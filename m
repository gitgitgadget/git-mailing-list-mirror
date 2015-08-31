From: David Turner <dturner@twopensource.com>
Subject: Re: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 14:30:35 -0400
Organization: Twitter
Message-ID: <1441045835.25570.7.camel@twopensource.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	 <CAP8UFD3-Y4T=dQmBVfRR1DEuuRZLSrUvQid8m1YttOnJc5Fj8w@mail.gmail.com>
	 <xmqqzj17y16t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:30:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTqt-0001nl-R9
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbbHaSak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:30:40 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34520 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbbHaSaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:30:39 -0400
Received: by qgtt94 with SMTP id t94so20192867qgt.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=3gIFF4JbgoPH56Vtyh40wGcZM279k0PdOLT9Mn3Pb6Y=;
        b=KNmYP2XudqARonb7DCMzpCWGpkyPD4RBrgHv2qmny/Z0CvtHTi0QR3J6W/bOJz8w7U
         2btcdfb4SRUkfOeCpPYDsuClvmSYvB2Gt5zRmE0ypYvpi6PCqF6+xo5kCePndJ3w8EOc
         paJHT66VtL6DhP84QZd5yWoZHCzPNNPOSmPfWBhdHAZFsrOIhQWUZ9+UO6BPe2jBBRTv
         AVUYH53uPR5G4AvtxaZUuXOV9rAAJllUbWeEOHQTWuswRAZDVOeiY0wRba6dLtATY2xQ
         fpKp/Gbd4KBCrw/jqYQJJgiNc5NgPoh7Vk33wsVrgEtiKHUT7veag2crjfORLFul+kft
         BUWQ==
X-Gm-Message-State: ALoCoQkuiK5mK45Iq/KnYmrtkRva87OmQrn+ZxLCyuLTpFNdLvnN5ZCSYkCsnKB4hWzX/aVgBdZm
X-Received: by 10.140.132.71 with SMTP id 68mr42073761qhe.64.1441045838599;
        Mon, 31 Aug 2015 11:30:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p18sm4258544qge.40.2015.08.31.11.30.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 11:30:38 -0700 (PDT)
In-Reply-To: <xmqqzj17y16t.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276904>

On Mon, 2015-08-31 at 07:36 -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> >> * dt/refs-bisection (2015-08-28) 5 commits
> >>  - bisect: make bisection refs per-worktree
> >>  - refs: make refs/worktree/* per-worktree
> >>  - SQUASH???
> >>  - path: optimize common dir checking
> >>  - refs: clean up common_list
> >>
> >>  Move the refs used during a "git bisect" session to per-worktree
> >>  hierarchy refs/worktree/* so that independent bisect sessions can
> >>  be done in different worktrees.
> >>
> >>  Will merge to 'next' after squashing the update in.
> >
> > Sorry if I am missing something or repeating what myself or someone
> > else like Michael already said, but in the current doc there is:
> >
> >        Eventually there will be no more revisions left to bisect, and
> > you will have been left with the first bad kernel revision in
> >        "refs/bisect/bad".
> >
> > If we now just use "refs/worktree/bisect/bad" instead of
> > "refs/bisect/bad", it might break scripts that rely using
> > "refs/bisect/bad".
> 
> Christian, thanks for raising this one.
> 
> I do recall the thread and I might be the somebody like Michael you
> remember, e.g. $gmane/275105---which did mention that "git bisect"
> would not need changing if we kept refs/bisect/.
> 
> What was the reason why we chose to move to refs/worktree/ again?  I
> do not think there was an issue that we cannot keep refs/* in
> general shared while having one (or more) subhierarchy of it per
> worktree (otherwise we would not be using refs/worktree/*, but using
> something outside refs/, like $GIT_DIR/worktree-refs/).  Was there an
> objection to refs/bisect being private from aesthetics point of view
> (i.e. forcing everything per-worktree in refs/worktree/ would prevent
> proliferation of refs/this and refs/that that need to be private
> case by case), ignoring the practical issue of compatibility issues
> around existing tools?

That is correct.  IIRC, on one of these patch sets, I proposed accepting
both new and old refs, but you said that would be unnecessary (it might
have been the notes/merge one instead of this one).

> I think one example of script, "gitk --bisect", does want to show
> the DAG limited by bisect refs, but it does so using plumbing
> without having to say refs/bisect/bad itself.  Perhaps the thinking
> (or lack of enough of it) went that no other uses by scripts need to
> peek directly into refs/bisect/ hierarchy?

I did a quick search on github, and did not see any scripts that said
"refs/bisect".
