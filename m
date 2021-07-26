Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A0C43214
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 16:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C6460F6B
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 16:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbhGZP76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbhGZP5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 11:57:53 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99FC061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 09:38:17 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so2398240oop.0
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=TvCIn6o0uV3vM8CWPA8U9DBLa6ShumF4LKCgyiuMF1k=;
        b=pNFSsAP1ecvBp0P3l6bQ+ZFgBu9L2L/cM9IXPQGvgMgUCCufgMCLkdiLx8rFr3LLwE
         vf3dky4a9Xm4ha12N/QZGLr7FJQwX8cpspvqxDtu4PIri16O8h4qD7OPbdz/xQGywpsh
         5OHRJCCLgOd0LgidT5X5XNOHDoTTcNcLje3/vPRIrfTDChIqHvphSUs+LtirCN1e1Ow+
         BDiD9IX2a/Dt+DlH+0se/KZnvXgCKHEx2xgQQXy7dXzzrBBg8XnM+O4aJbM1bzjMF3aV
         EdYCoH874dcqPKpRDnuy1j4lf9c1Yll6z91St9MvwoF2vgfm8WMGSeVPPKLFxbpiE8K1
         qQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=TvCIn6o0uV3vM8CWPA8U9DBLa6ShumF4LKCgyiuMF1k=;
        b=WjLQKJL42pv1gtLZ+zHDZZKWHPVWXovrpWLs5/XRUU2vruXod3YFHKPHdBsFRrgmZ/
         g0/+uvjbilbCVi6tf045DclCFo8QlDgwWFB3QQQM+a0eyAsh1QF6sbEjHI50/U+wAUWx
         p2auqkSLFqMAsBADu06bcSxQniwsQtvmXXMBZ5AHQwtAMCj2vS/Mh8U7xL7eOgbLXYrU
         vZnF0qSFbctEHR/D5WDCDSgTq+PnHZbauR3kv2aPClHTobqr+2EsYUEHo88AYRAVtbNt
         LgKoh7LwFOVHsTgVjNWTSHT1rIHAVUKQMW7WyJJ9xhpUHp72BD5y7fbbNfyhVbKAVOQe
         ZUew==
X-Gm-Message-State: AOAM532xatTACeOLrIZur+uyKddA4H0ye6PzAvM35XKib/K57R61LyrK
        wKKzhTiYcL5R+kcAx8CDznE=
X-Google-Smtp-Source: ABdhPJz3LTJlUbY7UjNcI0Q7uRQzeyJcDmLZJRqRbPwLvtX24YW11WLnRKHogivbEK4mLdQ+zhejfA==
X-Received: by 2002:a4a:2fce:: with SMTP id p197mr10925150oop.37.1627317496822;
        Mon, 26 Jul 2021 09:38:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 89sm70576ott.19.2021.07.26.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 09:38:16 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:38:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Message-ID: <60fee4f6f2198_d0c208dd@natae.notmuch>
Subject: git push --continue: yet another solution to the git pull problem
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to understand that there's a problem with `git pull`, we need
to understand that most users don't use git like us:

  1. Many people follow trunk-based development [1]
  2. 63% of people use a centralized workflow [2]

In these situations the developer will see the following message while
pushing:

  To origin
   ! [rejected]        master -> master (non-fast-forward)
  error: failed to push some refs to 'origin'
  hint: Updates were rejected because the tip of your current branch is behind
  hint: its remote counterpart. Integrate the remote changes (e.g.
  hint: 'git pull ...') before pushing again.
  hint: See the 'Note about fast-forwards' in 'git push --help' for details.

But this particular integration should have the order of the parents
reversed, as it has been discussed many times ([4] [5] [6]).

In order to fix this, we could have a push.autoSync configuration
that attempts to automatically do this synchronization, and once the user
has verified that the conflicts have been resolved correctly, and the
merge is correct:

  git push --continue

This solves the issue of the order of the parents because it's only in
this particular case that everyone agrees the order of the parents
should be reversed.

Even Junio has agreed.

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> But that does not necessarily mean swapping the parent order would
> >> produce the history of a right shape, either, even for those with
> >> the "first-parent chain is the trunk" worldview.
> >
> > Why not? Everyone who saw a problem agreed it would.
> > 
> > Reversing the order of the parents creates a merge commit like so:
> > 
> >   Y---X-+
> >          \
> >   B---A---M  trunk
> > 
> > Most git experts work with topic branches, and when you do that, you get
> > the same thing:
> > 
> >     topic
> >       |
> >       v
> >   Y---X-+
> >          \
> >   B---A---M  master
> > 
> > If you merge topic to master, the first parent of the merge commit is A.
> > 
> > If you do `git pull --reverse-parents` on a trunk-based workflow as
> > above, you would get exactly the same shape of the history.
> > 
> > How is it not the right shape?
> 
> I gave detailed write-up in two discussion threads linked already in
> this thread from 2013 and 2014; as I said, I do not think we want to
> debate that as part of the discussion of this documentation fix.

I already spent several man-days re-reading the discussions
multiple times, and I spent several man-hours re-reading them yet again
to answer this mail. And what I see is that you agree in some situations
the order of the parents is wrong.

In this thread in 2013 you said that the obvious fix is to use a topic
branch workflow, but as I explained above, not everyone does, and we
can't force them to do that. They need a way to reverse the order of the
parents, and you yourself were not oppossed:

  I personally am not strongly opposed to a "flip the heads" option, if
  implemented cleanly.

https://lore.kernel.org/git/7vd2shheic.fsf@alter.siamese.dyndns.org/

There's many other instances in which you agree we make the merge in the
wrong direction:

  That is one case in which it is very clear that we are making a merge
  in the wrong direction.

https://lore.kernel.org/git/xmqqoazgaw0y.fsf@gitster.dls.corp.google.com/

  I meant "Introduce 'update' that lets integrate your history into that
  from the remote, which is to integrate in a direction opposite from
  how 'pull' does".  

https://lore.kernel.org/git/xmqqa9b2egcy.fsf@gitster.dls.corp.google.com/

 - Most people are not integrators, and letting "git pull" run on
   their work based on a stale upstream to sync with an updated
   upstream would create a merge in a wrong direction and letting
   user continue on it.  We need to have a way to prevent this.

https://lore.kernel.org/git/7vbnvhil5x.fsf@alter.siamese.dyndns.org/

  The issue we are discussing with "git pull" is that if a non
  integrator does a "git pull" from the upstream, in order to push the
  result of integrating the local work with it back to the upstream,
  by default "git pull" creates a merge in a direction that is wrong
  when seen in the "first-parent chain is the trunk" point of view.

https://lore.kernel.org/git/xmqqbnvgasib.fsf@gitster.dls.corp.google.com/

  To me, the problem sounds like:

      Tutorials of Git often says "use 'git pull' to catch up your
      branch with your upstream work and then 'git push' back" (and
      worse yet, 'git push' that does not fast-forward suggests doing
      so), but 'git pull' that creates a merge in a wrong direction is
      not the right thing for many people.

https://lore.kernel.org/git/xmqqoazgaw0y.fsf@gitster.dls.corp.google.com/


Of course not all merges should be done on the opposite direction, only
the final merge that is meant to integrate the current branch into
upstream. That's what `git pull --continue` would do.

That would solve the issue for all the people that work on trunk-based
development, or centralized workflows.

If a hypothetical user wants to do back-merges from "origin/master" to his
"master" he can manually do `git pull` for those, and the order will be
in the traditional order, so the history would *never* be in the wrong
shape.

Of course, we don't need to wait for `git pull --continue` to be
implemented, we can start telling users that after `git push` they
should run `git update` instead of `git pull`, and the former will
reverse the order of the parents correctly.

So users can do `git pull` for back-merges, and `git update` to
synchronize and before pushing the changes back to master.

So I repeat my question: how would this not create the right shape?

Cheers.

[1] https://trunkbaseddevelopment.com/
[2] https://survs.com/report/nz2odu1spl
[3] https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li/
[4] https://lore.kernel.org/git/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com/
[5] https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/

-- 
Felipe Contreras
