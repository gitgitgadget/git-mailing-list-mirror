From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH v2 3/3] Add option to transpose parents of merge commit
Date: Wed, 28 Nov 2012 05:43:54 +0100
Message-ID: <20121128044354.GB17470@camk.edu.pl>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
 <1354057217-65886-4-git-send-email-draenog@pld-linux.org>
 <7vzk22ii7b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:44:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZVb-0002MA-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2K1EoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:44:11 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:55915 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab2K1EoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:44:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id B1A245F0047;
	Wed, 28 Nov 2012 05:42:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3RpTJnLAxP1Y; Wed, 28 Nov 2012 05:42:23 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id D1FBA5F0046;
	Wed, 28 Nov 2012 05:42:23 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 7252043CFD; Wed, 28 Nov 2012 05:43:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzk22ii7b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210702>

On Tue, Nov 27, 2012 at 06:18:00PM -0800, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > +--transpose-parents::
> > +	Transpose the parents in the final commit. The change is made
> > +	just before the commit so the meaning of 'our' and 'their'
> > +	concepts remains the same (i.e. 'our' means current branch before
> > +	the merge).
> > +

> How does this interact with Octopus merges?

It moves the original first parent to the last position. And nothing
more. I have forgotten to mention it in the documentation.

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index ee0e884..ab2b844 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1477,6 +1477,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >  	} else if (whence == FROM_MERGE) {
> >  		struct strbuf m = STRBUF_INIT;
> >  		FILE *fp;
> > +		int reversed_order=0;

> Style. s/=/ = /;

> > +	OPT_BOOLEAN(0, "transpose-parents", &reversed_order, N_("reverse order of parents")

> It smells more like "--reverse-parents" (if you deal only with
> two-head merges), no?

I have changes to --transpose-parents because of the octopus merges.
Although it is not a mathematical transposition in this case, but a cycle
permutation. 

-- 
  Kacper
