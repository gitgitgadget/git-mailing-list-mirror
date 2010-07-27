From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] Fix git rebase --continue to work with touched files
Date: Tue, 27 Jul 2010 14:29:24 -0700 (PDT)
Message-ID: <783007.41425.qm@web30007.mail.mud.yahoo.com>
References: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net> <201007272153.36646.j6t@kdbg.org>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:29:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdriN-0005IE-6w
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab0G0V30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:29:26 -0400
Received: from web30007.mail.mud.yahoo.com ([209.191.69.24]:30073 "HELO
	web30007.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750795Ab0G0V30 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 17:29:26 -0400
Received: (qmail 42732 invoked by uid 60001); 27 Jul 2010 21:29:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1280266164; bh=lWQtdhcRJVaTmXzeuqLw4SS7o+TP6TUwiuTlCKagl2o=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=PJRB2FEUCXKUARfilL/ZuyGanyJCbwqeY+zorRe3OGGuk0ldaXtxnQDNB0pofHTJjfkDkdFzjP6dQ2I0ensozH6bcbezTlqG1+8YUDC2d4Us4sTN7xp0TheWp7swh32M0AKcchCnATNeVU5OTAaP3DhXaTTmUeAUEdYuYzltca8=
X-YMail-OSG: pB0zMZUVM1kCCNFGomTG8uMb_KaQZRnAMIAREH7jyfuGelA
 f3jvoezpBw5ilii1G9YJfUEuww4hSefiEoBUt2sYyEl8a1a96ftfdZ3.md4z
 uJayW.UwMA72B6ayWO8_D9pVK2UDxau3skJIWUFVRNQwzj1_G_yqzbJQgHEw
 OSz2z3Hn0ciNprkY5EmdUVHrxhxKElgJOuawTi7I0Z4g7evbrhKVk1zyizDv
 Q19fsabWh.AZo.JZ3fywY1wpWQTfwSkJL1ZidlIIc1Vs8WthoebEcliPW_Iq
 ScPl4SuC7PsmF_qxyI1n0SPzj_i0f0ICztDpD.CA-
Received: from [17.202.32.26] by web30007.mail.mud.yahoo.com via HTTP; Tue, 27 Jul 2010 14:29:24 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/420.4 YahooMailWebService/0.8.105.277674
In-Reply-To: <201007272153.36646.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152004>

On Tue, July 27, 2010 at 12:53:36 PM, Johannes Sixt wrote:
 
> On Dienstag, 27. Juli 2010, David D. Kilzer wrote:
> > +test_expect_success  'rebase --continue works with touched file' '
> > +     count=1
> > +    while test "$count" -le 4
> >  +    do
> > +        git branch  topic$count topic &&
> > +         test_must_fail git rebase --onto master master topic$count &&
> >  +        echo "Resolved" >F2 &&
> >  +        git add F2 &&
> >  +        touch F1 &&
> >  +        git rebase --continue || exit  1
> 
> exit from a test is a big no-no. But I think you can reproduce the  issue 
> reliably and get rid of the entire loop if you use test-chmtime  instead of 
> touch:
> 
>         test-chmtime  =-60 F1 &&
> 
> i.e. set the modification time back one  minute.


That works great!  Thanks!

Dave
