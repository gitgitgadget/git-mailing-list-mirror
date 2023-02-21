Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632EAC6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjBUPlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjBUPka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 10:40:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873212BF16
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 07:40:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cq23so18589664edb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHW73msRuC7XAqgK102s4kWV/rClXI0U/Lk6SRU5E6c=;
        b=R3C3TbzSCLKpOmZMDaTEkLEWbppLRh8CjkKeV9NB2tjkqOsCNJhda5Xa5qwVmh0Rr6
         hcvBh2+qoB8U4ZqqTew9oVzAiH8lLHChYwCmKnOp8q3vgGLXQD+CHlSKuiSZIhPPJwT4
         p/JSfCecJbJs5QckE+BeqtvsaaZGcPP52owSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHW73msRuC7XAqgK102s4kWV/rClXI0U/Lk6SRU5E6c=;
        b=t2CdVlEjkvSSa++C9ArJ/iZo9OALZGys6UnK0T+dNGmH09JoZB5/c+lBwWu5l0vAhn
         d4nvBWhy1IqztnhSOlE+RNIxODoj9lWlmrgn+vOuzKEkeNiO45NkmyC4ZxkjR7oE9ent
         FRm0eiRaayN0F+3s9ep5ExaqHtrdDDibb8/7JKFwExz+yDHmOrFE3sfG+4mR1tYR8KgR
         Ep8WHGsUj8h9KUaHV2POmuh25YWJp3xBfpGDagYNBncbdZTDs4EAs1ctwGj7yMca/0Tm
         hVQXvRxOot8F7WWqHCAJUlKBGBZx546cTTBIjGuenN+dxd5rWmMnP2Fe3l/2qdW7uMXz
         LWdA==
X-Gm-Message-State: AO0yUKX2HrvtFRBip0s7a68RFtVPZiorDOl2dse39/fM4HYqDgZtCdvf
        vQ+GA6IweiT9e/3/mZyOp7o4l7tyVipMgwWre6af5Xt5/Ahth/7tWMo=
X-Google-Smtp-Source: AK7set9z3lXnue9KKpauwwpygmSVmfxnB6YhHyLlV3rTUeIm3lwHe+D3/bprhoay87FBHhRojDFgHBAcXFDdTNeUhUc=
X-Received: by 2002:a17:906:f256:b0:877:7480:c75d with SMTP id
 gy22-20020a170906f25600b008777480c75dmr6234123ejb.0.1676994016989; Tue, 21
 Feb 2023 07:40:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com>
 <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com> <CAMMLpeSZs8DqrN6_F9-eg7fcbjV-O5+3V+hUsOhyd0x10xsCaQ@mail.gmail.com>
In-Reply-To: <CAMMLpeSZs8DqrN6_F9-eg7fcbjV-O5+3V+hUsOhyd0x10xsCaQ@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 21 Feb 2023 16:40:04 +0100
Message-ID: <CAPMMpohfF5Cwgxt_G+Gp4rNPGTJZcQfmgEoJcFi_Kzbv2XGuog@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 7:33 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> Tao, the primary motivation behind the `git pull` warning was to help
> prevent users from merging main into a topic branch when that's not
> what they really want to do. The fact that novices sometimes do that
> has been a point of pain for many people, including Linus Torvalds:
> See "Don't merge upstream code at random points" at [1] and "github
> creates absolutely useless garbage merges" at [2].
>
> If you're seeing users merge main into topic branches without a good
> reason, that does sound like more of an education problem than a
> bad-defaults problem.

I would disagree on two points:

1. The need for merging in the upstream varies project by project,
user by user, etc. If you are working on a part of a system where you
can reasonably assume the ground will not shift under your feet,
awesome, lucky you! Many users are not so fortunate, and need to
regularly ensure that their changes still make sense in the
ever-changing upstream context.

Regularly (whatever that means to you) merging in the upstream is the
simplest way of achieving that. If you're working on your own or as
part of a team that's happy to handle coordinated rebasing, then
rebasing is a potentially-more-satisfying way of achieving the same
end - either way, assuming that their changes will make sense in the
upstream context is simply not a luxury many users can afford over any
period of time.

Now, you note that Linus advocates for merging specific points,
because he doesn't respect you merging "random crap" from a branch
called "linus" - that's fine, but many projects strive to keep a
specific trunk branch "evergreen" in order to minimize late conflicts
are maximize coordination - there's a pretty cool site about it:
https://trunkbaseddevelopment.com/ - this is not really different to
Linus' advice except that the goal is to make there *never* be "random
crap" on the upstream.

2. The fact that the commit history of non-expert git users (those who
should not be using rebase, especially in teams) are so often...
spidery... is why the "Squash" option of pull requests / merge
requests is so popular in centralized workflows (GitHub, GitLab,
BitBucket, etc).

If your project follows a "merge down, squash up" strategy with a
well-CI-guarded evergreen trunk on a central server, there's simply no
reason to *require* your users to become rebasing experts - you can
let them use simple merge-based workflows, keep your trunk clean by
squashing away their complex commit graphs, let them merge down
whenever they need or want to, etc.


> We might still want to change the default to
> better support the more unusual cases, but

Do we have any analysis/understanding of how common workflows like
that of the git or linux projects are, vs github-style fork-based
projects, vs straight-up single central server projects?

I'm not sure what you mean by "unusual", but I don't think "avoid
rebase unless you really know what you're doing, merge down at will,
we will squash your contribution in the pull/merge request at the end
anyway" is an unusual flow at all nowadays.

> if you're going for a quick
> win, it would be faster to teach users the wisdom of not mixing rebase
> and merge in the first place.
>

"teach [...] wisdom" is a good one! No, seriously - of course I'm
going to do the best I can to prevent my users from falling into the
traps surrounding them - but my point here is that *we simply
shouldn't have pointless traps*. Offering a command that can cause
significant "harm" (time loss, frustration, etc), silently... just
doesn't seem like a good idea.


> [1] https://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.html
> [2] https://lore.kernel.org/lkml/CAHk-=wjbtip559HcMG9VQLGPmkurh5Kc50y5BceL8Q8=aL0H3Q@mail.gmail.com/
