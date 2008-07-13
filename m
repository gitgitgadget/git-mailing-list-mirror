From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Mon, 14 Jul 2008 02:58:42 +0300
Message-ID: <20080714025842.6630c47e@linux360.ro>
References: <20080710170735.4c5b237a@linux360.ro>
	<7vskudr11m.fsf@gitster.siamese.dyndns.org>
	<32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
	<7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
	<32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
	<7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
	<32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
	<7vlk05o14i.fsf@gitster.siamese.dyndns.org>
	<32541b130807131642k1382cf84gdf5e8bb8d2ff4ffe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, ryan@michonline.com,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 02:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIBV6-0003Bc-ET
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 02:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbYGNAAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 20:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbYGNAAJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 20:00:09 -0400
Received: from [194.117.236.238] ([194.117.236.238]:44487 "EHLO
	heracles.linux360.ro" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbYGNAAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 20:00:08 -0400
Received: from localhost (82-76-182-196.rdsnet.ro [82.76.182.196] (may be forged))
	(authenticated bits=0)
	by heracles.linux360.ro (8.13.1/8.13.1) with ESMTP id m6DNxeG0018723
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 02:59:42 +0300
In-Reply-To: <32541b130807131642k1382cf84gdf5e8bb8d2ff4ffe@mail.gmail.com>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-Spam-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_00,HELO_LOCALHOST,
	RDNS_NONE autolearn=no version=3.2.4
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on heracles.linux360.ro
X-Virus-Scanned: ClamAV 0.93/6834/Sat Apr 19 00:09:50 2008 on heracles.linux360.ro
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88360>

On Sun, 13 Jul 2008 19:42:35 -0400
"Avery Pennarun" <apenwarr@gmail.com> wrote:

> On 7/13/08, Junio C Hamano <gitster@pobox.com> wrote:
> >  If this additional option claims to produce a mbox, I think:
> >
> >   (1) quoting only /^From / (not /^>*From/) to be consistent with
> > the standard practice is the right thing to do; and
> >
> >   (2) reading side might need to also pay attention to /^>From /,
> > in case somebody feeds an output from this option back to
> > send-email.
> >
> >  However, strictly speaking,(2) may break the standard workflow of
> >  generating patches with format-patch and feeding the result to
> > send-email, as format-patch does not do /^From / munging (and it
> > shouldn't).
> 
> Note that it's generally very bad practice to do (2) unless you always
> quote /^>*From/.  Quoting only /^From/ and *then* trying to dequote it
> correctly actually increases the number of places where you can
> corrupt a message.  As a sign that very few programs do (2), I think
> it's pretty clear that a lot more people see "From" rewritten as
> ">From" in their mail app of choice than the reverse.

Junio is right when he says we should match against "From " instead of
"From" (i.e. we should not touch lines beginning with "Fromage" for
example). Should I resubmit or can it be corrected during the merge?
 
> There is also some debate about what "standard practice" means.  See:
> http://homepages.tesco.net/J.deBoynePollard/FGA/mail-mbox-formats.html
> .

When I started working on this, I visited Wikipedia which provided a
link to qmail's site, which looks quite authoritative on this matter:
http://www.qmail.org/man/man5/mbox.html

I just followed that spec.

> If git is going to start actually producing mbox files (as opposed to
> just individual messages as it does now), it should probably
> explicitly take a stance on the issue... or perhaps make it
> configurable.
> 
> Have fun,
> 
> Avery
