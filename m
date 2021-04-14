Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCFAC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC8B6120E
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhDNKcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhDNKcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 06:32:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95763C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 03:32:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n2so30602377ejy.7
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ybisKbv+7p7ysNloPEqI9m8mz/Lybs/0N2M0sJArMdI=;
        b=vhS/ruHNjND9xVzRegRAEOqC7qPn5cHGsowpU56PUQxBLMh5/tHXky7xrifGb9Z492
         ekN+bZrFjAv4Y7otL2WYUcGC8x40fiuWMjUfm3nZyeaP2SsySyfDkQORImic+B7IWC2Z
         UZsVMqp4DPLCOclB16ogPpssPLjvIK7e6t6cdrd9gAiweAUOwJEEofQDb4V8+0MbiWM8
         uqJN7+m2gZ5LDeTFVImvLMRXX7E/uMGGeGXhS0OrqgvojzR4awuBmXYkQn4NFKwq0/nJ
         +BJ4bLN59Q8hjvXWddFJ/5z3DWRvMwOF5FPz/uhcI8y+CsIuBhnota9cFhBAoqFZ9lLo
         JD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ybisKbv+7p7ysNloPEqI9m8mz/Lybs/0N2M0sJArMdI=;
        b=iAertkI6J+JeUy0WPweQy7G8qXEB8uiuIkqAEQYMTKOOZeDOo+J3yhzEk5Won41qNl
         OOH9aDwc42R4cdJ+G5yV1wCmg8zexiBAskIxJhtw6B0m2JVBz/SPIExh7B+n5CSsIEU+
         gikkxcN+FONx9WIKUxMAZaUeCfz8+E1Xt41PjiPJLkCQG+gsccteqC8tliPSi5UuTKFV
         VbL8qaLPvfSCsPY3mTOiZyzD7KMNNb6sHFR8ZqF+r2xLdr73zhLGuaj6UtHL49KPhZrZ
         wXlFdpnOyA4c/BlsvRcxptYbfhZc/NKCg7Eg/RUODp7tOoYfkNu2BEvNqBJSx9oh9ujg
         ixIw==
X-Gm-Message-State: AOAM533hylMC9w3/NrUFy1wVdeopmucWJQTi1/G3QicTUSgfPG5XGqV6
        yBughed1X3x+c7p6bD8FEmw=
X-Google-Smtp-Source: ABdhPJy4UFkDJKCpUTiN+lBUfo+oWZvRFZov4jzeGkZhROAD8NkGfBVmd0Rv36j5YiE/qlDpwn53eg==
X-Received: by 2002:a17:906:5619:: with SMTP id f25mr9528622ejq.393.1618396338125;
        Wed, 14 Apr 2021 03:32:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gs20sm883151ejc.83.2021.04.14.03.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:32:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Future structure of submodules and .git/, .git/modules/* organization
References: <20210408233936.533342-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210408233936.533342-1-emilyshaffer@google.com>
Date:   Wed, 14 Apr 2021 12:32:17 +0200
Message-ID: <87v98p17im.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Emily Shaffer wrote:

> I'm hoping to work on some other submodule-centric stuff over the coming
> months, and it might end up being very useful to be able to tell "am I a
> submodule?" and "how do I talk to my superproject?" more generally - so
> I'm really open to figuring out a better way than this, if folks have
> ideas.
>
> Patch 1 is a small refactor that we can take or leave - I found
> "SCOPE_SUBMODULE" to be pretty ambiguous, especially since it seems to
> refer to configs from .gitmodules. Even though I decided that
> "superproject" was a better name than "submodule" I still wasn't super
> happy with the ambiguity. But we can drop it if folks don't want to
> rename.

This is less on your patch, and more on the larger work you're
suggesting, but the two are kind of related. Skip to the paragraph
starting with "But why" below for the relevance :)

I very much wish that we could eventually make the use of submodules
totally transparent, i.e. (taking the example of git.git):

 * You clone, and we just get objects from
   https://github.com/cr-marcstevens/sha1collisiondetection.git too

 * The fact that we have:

   160000 commit 855827c583bc30645ba427885caa40c5b81764d2  sha1collisiondetection

   Would become totally invisible to most users unless they run some
   gutsy ls-tree/files comand.

   We used to have a full git dir at sha1collisiondetection/.git and all
   the UX issues that entailed (e.g. switching to an old commit without
   the submodule).

   Now it's a stub and the actual repo is at
   .git/modules/sha1collisiondetection/, so we're kind of partially
   there.

 * I would think that the next (but big) logical step would be to use
   some combination of delta islands, upcoming sparse indexes etc. to
   actually share the object stores of the parent and submodule.

   Things like "git fsck" which now just punt on COMMIT would need to
   become smarter, but e.g. we could repack (or not, with islands)
   between parent and submodule.

I would think that this end goal makes more sense than the current
status quo of teaching every command that needs to e.g. grep the tree to
have a "--recurse-submodules". The distinction would be invisible to the
likes of "git-grep".

It would mean more complexity in e.g. "git commit", but we can imagine
if you wanted a cross-submodule commit it could do those commits
recursively, update parent COMMIT entries etc. (and even, optionally,
push out the submodule changes). That particular thing being so ad-hoc
is a *very* frequent pain point in submodule use.

But why am I talking about this here when all you're suggesting is
another config level?

Well, I think (but have not carefully thought about) that this
CONFIG_SCOPE_GITMODULES is probably a narrow net improvement now. If you
set most options in your .git/config to you that's the same logical
project, why shouldn't you get your diff setting or whatever because you
cd'd to a submodule "in the same project" (from the view of the user).

But I think that for a wider "improve submodules" effort it's worth
someone (and right now, that sounds like it's you) thinking about where
we're going with the feature. Maybe with some technical doc identifying
the most common pain points, what we propose (or could envision) doing
about them.

So e.g. in this case, having per-submodule config could be a step
forward, but it could also be one more step of walking in a circle.

I.e. don't think any user asked for or wanted to stitch together
multiple .git directories into one linked pseudo-checkout, that's
ultimately something we're exposing as an implementation detail. If we
no longer expose that implementation detail, would we be stuck
supporting what's ultimately a workaround feature?

None of that means we shouldn't have that one step forward that solves
real problems today.

But I think we should think about the end goal(s) sooner than
later. E.g. in your case, do you *really* want another config level, or
is it just the easiest way to get what you actually want, which is for a
"git config" in the submodule dir to perhaps consider its .git/config
and .git/modules/sha1collisiondetection/config as the same file for the
purposes of config parsing? Sans things like the remote URLs etc.
