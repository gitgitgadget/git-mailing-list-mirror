Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A0AC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 01:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9733360ED4
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 01:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJNBXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 21:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhJNBXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 21:23:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44FEC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 18:21:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r18so14243556wrg.6
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 18:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fnudMLv/7uKRvu8ivtzyuBCUmptPyzs9hIMLAly5+Y8=;
        b=MS0lXfll8tIx/CKy+sriEQKpnWfH8X6njlmWmxR4TZGMPq+IAf1Pry8XRx8rERuLAF
         1lpAnH1jfDDp7ajuYE6zeDvOk3HzQAHTvfpqv0kCtxvL+6OB/qtsrVK+0WeskJmiQVGj
         LYY93BmyuMjD3jFWtBATuGIHZZbmXCOg6FqdG+aUIXB+pZCcFWorqryzOJldgvscYdUR
         sQsRMkPAefVvUX5AYkN57+or01ncLI2m71PFX1crKhSmtBsQLE/2n8TapLBCaeW2b49V
         bsJS7YM+o9rthxKDVPy7+vP3fYi/qgukff9ItEknv3iIUqAdVnTJ/QkviRU0wB8K5TUM
         hwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fnudMLv/7uKRvu8ivtzyuBCUmptPyzs9hIMLAly5+Y8=;
        b=4NgxxpaEaSWkxR4jA0J0DFRQ9r+L+EtBid8Q2BsCBD6uuRO8p5prPC3HZMZ90vkdQN
         YPV727jia6oDcLEnPZuokrMYcOqRLw2ju0dtZ3p2psSdYYlCGcx2uqh+3tmEmLbAczsc
         McDOT5UajrDE/Nn795HoxAW5WJWgxXVzBtmi2jI0c04fka0AQNV08PtLJQJSeWnAXeR+
         TPO00yx60dUOMGTNHn9ugcjt0rUkyoyCVU3ij+91yc9QSUiXl6xD87r6RMKDMEwzHzSB
         012HjiOgdsPGctbsGeLb2GPrFLRRot/l6RKymrFYdcKg1+M4b84gtnjVvKI0fl7dltKc
         VHJA==
X-Gm-Message-State: AOAM532ePsSBQwAnae8/CyP5cF+pMHPYhxY7H7t2Dvj9MwVT1qMnlFoZ
        iJbKJcChF8rR0zYhkI76j42XHCdTzCdpeg==
X-Google-Smtp-Source: ABdhPJxXWy+KPjAK/havk5VjeyDG6ODI9Ua3+GTxrb5rC1NGA3JHknu1Mz/hW2FEU3/vN44ZSs6jcg==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr3032697wrc.30.1634174488207;
        Wed, 13 Oct 2021 18:21:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d3sm979327wrb.36.2021.10.13.18.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 18:21:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion: "verify/repair" option for 'git gc'
Date:   Thu, 14 Oct 2021 03:19:10 +0200
References: <e288dbe1-b7c7-5a2e-5271-404a14de836a@syntevo.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <e288dbe1-b7c7-5a2e-5271-404a14de836a@syntevo.com>
Message-ID: <87h7dkh04o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Alexandr Miloslavskiy wrote:

> Suggestion
> ----------
> 1) It would be nice if 'git gc' had an option to also verify
>    (like 'git fsck') the repo and report corruption. I think that it's
>    a good idea to have it in 'gc' for performance reasons, because
>    'git gc' already reads things.
>
> 2) It would be nice if git could automatically download blobs from
>    remote if local blob is corrupted. Maybe it was already implemented,
>    see story 3 below.
>
> Motivation
> ----------
>
> -- Story 1 --
> Just a few days ago I encountered another secretly broken repo which
> caused some small bugs in the git UI I'm using. The repo worked mostly
> fine, that's why I had no idea that it's corrupted.
>
> My git UI invokes 'git gc' sometimes and if that detected the
> corruption, I wouldn't have to spend time hunting the bug in UI.
>
> Specifically, it reports these errors on `git fsck`
>   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit,
>   not a blob
>   error in tree 1d571d7354f99b726bbcc0cb232b3f47846c71a1: broken links
>   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit,
>   not a blob
>   error in tree 2808b286c2a933e88735d97416e29b9514fc6af2: broken links
>   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit,
>   not a blob
>   error in tree 604f6f6c4fbf8da7a593708e863e68f8c5a27d07: broken links
>   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit,
>   not a blob
>   error in tree 6a2c4a5ef0b0ee7aa85d88c3147b7558a6a7c29f: broken links
>
> The repo is not confidential and I could share it if needed.
> I "solved" the problem by cloning a new copy.

I'd be interested in a copy of it, I've been slowly trying to improve
these sorts of corruption cases.

> -- Story 2 --
> A few years ago, I had another repo that wasn't used for a couple years
> and had corrupted blobs. The repo looked fine until I tried to clone
> from it. Unfortunately it was the only copy and I had to write some
> code to "guess" the blob's contents to repair the repo.
>
> If 'git gc' detected corruption, I would have known about the problem
> earlier,
> when I still had other copies around.

I wonder if this and other issues you encountered wouldn't need a full
"fsck", but merely gc triggering a complete repack. Which is not to say
that some regular background "fsck" wouldn't be a good idea...

> -- Story 3 --
> Also a few years ago, I had a repo with a single corrupted blob. I don't
> remember why, but simply re-cloning it was a headache. I managed to fix repo
> by issuing a command to re-download a blob from remote. Git could totally do
> that itself, I think.

Yes, we still definitely have cases where dealing with this sort of
thing can be very painful.
