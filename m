Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E6C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiARQBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiARQBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:01:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F68EC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:01:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so81652435edj.7
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=27iKCvjflip+rZbsr0fYyVsdOlnpOkmbhPcaYp2xyNE=;
        b=qaiCNhvcqPaibd1h6tL1cnl/fV/+eZK+0f/gv20K5zaMbAnMw2Fpflb7ioou9oNzLw
         AhwdjmjhMbSLTcMJYf8Ivzu42IoIe/CRDhRCqydDuY0AL1b7WjjoJ7wRVi2gR98InMtG
         BX4X0hBo58yKcI74gLv5b+hjM4IYVLnPZg96NYmnEbhMkD4mblZ+2hWD6iOIkZ9J2iUS
         Fd5kWwSfQ16fYOB5iXCfmsxSEbRG5N1+d3bTqSrjiDnb3sjRfDsYJZbhzDtOppW1TvrB
         M+BvY7RDJWH4D1pfVv+aF5mQEeXadKFLaaUiv6Kze67wBw7ASdBWwGmyeF2zaRTMZAc5
         XBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=27iKCvjflip+rZbsr0fYyVsdOlnpOkmbhPcaYp2xyNE=;
        b=iQW62aZH3jheza2y24aJbXnw9UnYk5VKgExo4iu6tKoGMbVI2h8Oz+JVDgBoWefg2Y
         pEjSaNIxUlDictBeMS0bbaKBS4n+WT+nlLW3tGNUo8VFh0k4Fexv2JitpKXIE18WqA3G
         vuwT79zBs8Pd7MC65izpJfHakGffbcFb9CwZ5u1JyUbj7ixh0EzjxPNda9Ob/ImrlmrN
         aC4WwoPXzks8zvZkaBHFJWsDConXHMOhKxGgT6lp2oxFJ6/5zSJT8kVIpcFSBfj1+n7w
         N9yLwnk+SagVgwahYBpsPzm+UoU2qOwQlcVzCdNgURi1o9ENjP/THEaDl79adHAvuGFf
         LKug==
X-Gm-Message-State: AOAM5311PWi7F8IAqCOQqV8jmy+vVap/sRXp6PHdDYppZKNXIAXav3do
        iB2uzOAWxH6E+qwJDHAE4Oo=
X-Google-Smtp-Source: ABdhPJxCIwpphKehLenRrFJgXGWTJ5XUKscwWjWZ3qipAvoJAG+Vm/rclRrp4liJEdmIMKNyrhlwzQ==
X-Received: by 2002:a17:906:6a26:: with SMTP id qw38mr22561264ejc.518.1642521689565;
        Tue, 18 Jan 2022 08:01:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hq35sm5548204ejc.100.2022.01.18.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:01:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9qvI-001eQY-MQ;
        Tue, 18 Jan 2022 17:01:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: ab/config-based-hooks-2 (was: What's cooking in git.git (Jan 2022,
 #04; Fri, 14))
Date:   Tue, 18 Jan 2022 16:59:04 +0100
References: <xmqqy23h4nss.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqy23h4nss.fsf@gitster.g>
Message-ID: <220118.86a6ftowx3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> * ab/config-based-hooks-2 (2022-01-07) 17 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - hooks: convert worktree 'post-checkout' hook to hook library
>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>  - merge: convert post-merge to use hook.h
>  - am: convert applypatch-msg to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - hook API: add a run_hooks_l() wrapper
>  - am: convert {pre,post}-applypatch to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook API: add a run_hooks() wrapper
>  - hook: add 'run' subcommand
>
>  More "config-based hooks".
>
>  Will merge to 'next', with minor nits?
>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>

I'd really like that, if you're OK with it.

I.e. I could re-roll it, but those comments are relatively minor, and in
any case will be addressed eventually by subsequent to-be-submitted
parts of the hook.[ch] API conversion.

So unless Emily or Glen have strong objections I think it makes sense to
mark it for 'next'. Thanks!
