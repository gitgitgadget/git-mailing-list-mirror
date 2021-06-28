Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E45C11F67
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6B561C86
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhF1TBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbhF1TBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:01:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2CC061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 11:58:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h2so27501684edt.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hJdnV5KA19uxH33W16JQuMdhZAgHPobGGPZ+3mVpNQg=;
        b=q5r/td4RCACzTv0SrD8Q3n5/PCI/TZzCHIMDkOZe4LPZRMKqeGrb3xmwIiLRP0B4Z0
         YuMSLhRdQznBCFPPWDy5af1SOUaZ4T3/Tg9kflSb4VdjeAkjwjIXDQLhUjoOqDKafg/f
         KD5PaQcN0W/AeiaWkkgmLgfF32l+OYoYhYAGN3DbXcKF9mkpFc1GY4OeiXn8z2svt/Tr
         M1Ncry4ILowFdTB8Rwk+tMZXHVN/UOtweHfOaajjI2cIHlc+rBFaLt8e1bxlcMExnAsZ
         xgjaZyB0ZXaatY/OzX5Lmaei3htYbB7o6nn9zC60iMH8jz1a0v9lEN9/0FZo/6nurbKp
         sMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hJdnV5KA19uxH33W16JQuMdhZAgHPobGGPZ+3mVpNQg=;
        b=PW4aok1ZWBURJ+mVe5TkSc/5LJTe1vKIDDsiqClHloJJejr0vc+XAV8jwCwppyTldL
         m7kFxa2LYXGrBFYocnNfVOaGYVVZvPUKwn/meobfDQSX8fWHYh6RN1y0EvfeU2LLAOps
         q7X7/Iea1RMctRcOaGa3WlEYqcb8w61yWywQm6O1zG2oXbqEZ89MEC1mNbz+WeUF7Sbg
         iHdhmCizToX/99T1mS53984BfBV9lF/HIqBk2WROyf0cRighfCk6SIfKET0iHx1ci/hr
         LQAocFlreaX6HwU2HO8lfpUq50jHxXmNdBlVDHpkfer59uxdF1jJOie0qLSnLf3Q6HuM
         mcgw==
X-Gm-Message-State: AOAM530sM8PBzz/MMkV3Y4AayN8Zxp+x+xeMjQAurGEkiaQyI4wI7wLC
        2ybf2UIrAtOZNjNp/sLoEQw=
X-Google-Smtp-Source: ABdhPJwb29lIFx1455o2ZpT5Hzrqf+vGy8yoDw/rpEtj2JhAjzBWzZs7L0ylvUSnOg6mRA3sI+lROw==
X-Received: by 2002:a05:6402:68a:: with SMTP id f10mr34746419edy.99.1624906719465;
        Mon, 28 Jun 2021 11:58:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o14sm10297985edw.36.2021.06.28.11.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:58:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew Hughes <matthewhughes934@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: segfault on invalid 'git grep' invocation
Date:   Mon, 28 Jun 2021 20:53:56 +0200
References: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
Message-ID: <87bl7phl41.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Matthew Hughes wrote:

> Hi all,
>
> It's my first time writing to this mailing list, so apologies in advance
> for any mistakes/faux pas.

Thanks a lot for the report, and welcome.

> Summary
> =======
>
> Segfault seen when running:
>
>     $ ./git grep --and -e 'pattern' -- not_a_path
>
> Expected Behaviour
> ==================
>
> The above invocation doesn't appear particularly valid to me, I
> accidentally ran it while editing a command. Not sure if this needs
> addressing, but perhaps the expected behaviour would be an error message
> about it not being valid?
>
> Compare with, running without '--':
>
>     $ ./git grep --and -e 'pattern' not_a_path
>     fatal: ambiguous argument 'not_a_path': unknown revision or path not in the working tree.
>     Use '--' to separate paths from revisions, like this:
>     'git <command> [<revision>...] -- [<file>...]'
>
> Running with a valid path:
>
>     $ ./git grep --and -e 'pattern' -- common-main.c
>     fatal: Not a valid grep expression
>
>     $ ./git grep --and -e 'pattern' common-main.c
>     fatal: Not a valid grep expression

The exact segfault you've found is found at least back to Git version
2.0.0, so it's been with us for a while.

The problem is that you're trying to --and two things, but did not
provide two things. We apparently never checked for this, and then
segfault in the cleanup, thinking an --and must imply that we have two
sides.

I haven't looked deeply, but think that the reason it segfaults just
with not_a_path is that we then proceed to die() in something that
should probably be a BUG() instead as we can't grep in the
expected-but-not-there pattern at runtime.

Giving it a pathspec that doesn't exist means we never run the "real"
grep, but we do run the cleanup, hence the segfault.
