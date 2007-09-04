From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] Add post-merge hook.
Date: Tue, 04 Sep 2007 10:25:10 -0600
Message-ID: <1188923110.6192.15.camel@beauty>
References: <11885136172952-git-send-email-jjengla@sandia.gov>
 <7v7inc7hao.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbCf-0001FK-07
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbXIDQYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbXIDQYc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:24:32 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:3045 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbXIDQYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:24:31 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 04 Sep 2007 10:24:15 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l84GO3me015847;
 Tue, 4 Sep 2007 10:24:04 -0600
In-Reply-To: <7v7inc7hao.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.4.85923
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0, __pbl.spamhaus.org_TIMEOUT ,
 __sbl.spamhaus.org_TIMEOUT '
X-TMWD-Spam-Summary: TS=20070904162418; SEV=2.2.2; DFV=B2007090412;
 IFV=2.0.4,4.0-9; AIF=B2007090412; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364444383642312E303036353A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007090412_5.02.0125_4.0-9
X-WSS-ID: 6AC359253HO1221351-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57609>

Sorry for late response --- *long* weekend.  :)

On Thu, 2007-08-30 at 16:07 -0700, Junio C Hamano wrote:
> > This adds a post-merge hook that will run after `git pull` operations
> > if enabled.  The hook is passed no arguments and cannot affect the
> > outcome of a merge.
> >
> > Signed-off-by: Josh England <jjengla@sandia.gov>
> 
> Thanks for your patch.
> 
> Two questions.
> 
>  * Do you want to run the post-merge hook even for a squash
>    merge?

Yes.  I'd like to run it at any time that the working tree might be
updated.

>  * After resolving a conflicted merge, you would conclude it
>    with "git commit"; don't you want to have the same hook apply
>    at the commit time, or is that what you expect the user to
>    deal with with post-commit hook?

I wouldn't want the post-merge hook running there because (in my case)
it needs to do something slightly different than the post-commit hook,
and would seem counter-intuitive to me. The pre-commit and post-commit
hooks are already there and handle that scenario nicely.

> And two requests and a half.
> 
>  - We would want a new test in the test suite for this, to make
>    sure that later changes by others would not break this new
>    feature you would depend upon.

Can do.  You want me to resubmit the original patch along with tests or
submit the tests as a new patch?

>  - You described _what_ the patch and the new feature do in the
>    log message and in the documentation.
> 
>    You need to also explain _why_ somebody might want to have
>    such a hook in his repository.
> 
>    . In the documentation, you would want to make the reader
>      realize "aha, this is something that would help me" with an
>      example.
> 
>    . In the log message, you would want to make sure other
>      people understand why this new feature was added, what the
>      design consideration were at the point of the feature was
>      added.

I may have to come up with a use-case that is more mainstream than mine.
I'm personally using it to update permissions/ownership in the working
tree based on a git-controlled file (created by pre-commit).  I'll post
the script when its fully fleshed out.  Should I just put "If you're
doing something crazy like me, this hook may be useful."  :)

>  - We are deep in feature-freeze for 1.5.3; I'd appreciate a
>    resend for any patch that is not a bugfix / documentation
>    update after 1.5.3 final.

Sure thing.  It looks like the 1.5.4 cycled just started.  I'll resend
with the additions you requested.

-JE
