From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Wed, 29 May 2013 13:46:13 -0500
Message-ID: <51a64cf542ee1_22511551e18464f5@nysa.mail>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
 <51a56e2db218d_807b33e18100177@nysa.mail>
 <7v4ndlvgnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhlam-000739-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759421Ab3E2S7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:59:21 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:37745 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab3E2S7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:59:19 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so885018obc.17
        for <git@vger.kernel.org>; Wed, 29 May 2013 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=lYFzumOyTcvBKuGgYNXptmbWQMz3/jnR+ZsIPJlFNuI=;
        b=UVlJqW0aEOR6S1Oka3aiXeSHpjt13g1LfNFtssyWsG+fYUSIOOR9QIqCEqwy11NwPa
         qgJQvAS+FYPpgUu96YKyWuUI3WcaBPEg8XomyHx+RMYTKWKXwq2S2xreif89QX9laVm3
         gcIxwtYUpatiwTrhVtbiGNOlUgc2E6B6coS3wkf7DLfp4jliuvp/B4UHPIu9ebV3JX9v
         iBidpAG+WioiZVhqT+7578cc7xAQsdYXRfBnaQdENr7Yv6K1cuDGo+W29/CtRf76CYTc
         W3phpaIBPs1Y/3IadUXv7/WBq/wPYzMo6JXpcb6Aqdk4xAZ6RaZfS8Bp0bdzX0h/JSSQ
         BLwQ==
X-Received: by 10.60.58.33 with SMTP id n1mr2529668oeq.3.1369853959275;
        Wed, 29 May 2013 11:59:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm11618205obz.11.2013.05.29.11.59.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 11:59:18 -0700 (PDT)
In-Reply-To: <7v4ndlvgnq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225868>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> * fc/makefile (2013-05-26) 5 commits
> >>  - build: do not install git-remote-testpy
> >>  - build: add NO_INSTALL variable
> >>  - build: cleanup using $<
> >>  - build: cleanup using $^
> >>  - build: trivial simplification
> >>  (this branch is used by fc/remote-helpers-use-specified-python.)
> >
> > No, these are independent.
> 
> By the way, I dropped the order-only one and I explained my
> reasoning for doing so, but I haven't heard back from you.
> 
> As I haven't used the order-only dependencies nor '|' myself so far
> (primarily because I have not seen a case where it was needed), it
> would have been nice if you responded with either "yes, this is not
> order-only and the patch should be dropped", or "no, order-only is
> correct because...".

I'm not sure, so I think it's OK to drop it. I've used order-only to
dependencies that should not be listed when doing $^ which doesn't affect us
anyway, so I thought it was more descriptive with the patch, but I can see why
it would break the build if that file is updated and the targets that depend on
it don't.

I don't have time to investigate further, so I think it's OK.

> In any case, I think the above remaining five were sensible changes,
> and am thinking about having it graduating early in the cycle.

If you do that, please add git-remote-testgit.sh to the NO_INSTALL list. I
didn't do that at the time because I was working on the master branch, but this
changed in 'next'.

> I somehow had an impression that the other series depended on this
> for SCRIPT_PYTHON_* stuff, but this is about the installation step
> and the other one is primarily about the build step, so in that
> sense it may be independent.

They are completely independent. The improvments to the main Makefile is what I
came up while trying to understand the code.

> >> * fc/remote-bzr (2013-05-28) 8 commits
> >>  - remote-bzr: add fallback check for a partial clone
> >>  - remote-bzr: reorganize the way 'wanted' works
> >>  - remote-bzr: trivial cleanups
> >>  - remote-bzr: change global repo
> >>  - remote-bzr: delay cloning/pulling
> >>  - remote-bzr: simplify get_remote_branch()
> >>  - remote-bzr: fix for files with spaces
> >>  - remote-bzr: recover from failed clones
> >> 
> >>  The ones near the tip conflicted with the hotfix for 1.8.3 so I
> >>  discarded them for now.
> >> 
> >>  Will merge to 'next'?
> >
> > Didn't I resend these with the conflict fixed?
> 
> As the date above (05-28) shows, it seems that I did not forget to
> drop the old one to replace with the new one, but I did forget to
> remove the stale comment from the previous issue.  Thanks for
> noticing.

Oh, I see. Cool.

-- 
Felipe Contreras
