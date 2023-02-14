Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F1C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 05:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBNFcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 00:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBNFcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 00:32:03 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F0BBB7
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:32:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so2476541pjb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZ75ukhk1FO75YMDJ1TJrWfCVm4wvb++bb8xFTqFcy4=;
        b=WOFXdk+xRq82/BPzzOa8AE7nLKlbhsFgDGMUMYvvngG6Mq2ZUq1RBuMBQfiQxz18T4
         pP2SK7i7P+ELdXhQ6JlzM089yJDsrC7Zq0TEtHBPGp3W31nPgBFDqlE7VJiz3axESewS
         BG9jSagwiQWXuYasD6tkhnjvjyaXOhrwluH2EW1vTzppB7b4u9DUXfyeyIYc6RS9ZZYP
         jlLJAFowS0nPKMOdSFcvYjx3CbeYEUopJOsd6Ihs8+cpy+XI7zr1ifz160IOGUgJaGvp
         EGWQUdndf7YgQV20VP3mGVghUE35m465k3+HmjbmmlWOJJ1FQOybPtBA3+zQemCJEG2j
         ah9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZ75ukhk1FO75YMDJ1TJrWfCVm4wvb++bb8xFTqFcy4=;
        b=VNgFcr+tkaHRo8StkmYeuOLRhW5LbJO6FZQv33zn+kDhSgSkcML4TRFt+9jups45Ky
         fJaVrgUQUsrNQMLMZWGB0zXxrOaAwoJh3QgH7WHv7GKT5FbCd4xNsK4nr8TcoR+HO7+d
         /Of3T6ClO6jnhPvH6zekEqF8xtK5NpSxB55m7sV5lrBfZlpHocFUAxFEuocFKQHy94CW
         X/KG3znIeFeZd7FpfexT1nGCut5gfc+0317I8/d234gTzdS3ALTu1dEWWnG0WT2ka1Wf
         yGKmsgsF+YgR27oMy0xuuc05/xURA6Wvl68AgZZGgek952atypMxhWPcQi7kujYkzXsp
         SgZg==
X-Gm-Message-State: AO0yUKW/WAerml4HJJhJi78mtL6FqmJk3HFOO8aNJrJvv2v2xW8uPt2f
        Fya9tjxDNeJCafjvUxhLpKnrp8tl7Hw=
X-Google-Smtp-Source: AK7set9DBcYnKamsceRvfkxKd273PXMybOQwNcMGRy9ijbF4DuMPmd0niln07wpHI8NogkfYP0RJZw==
X-Received: by 2002:a05:6a20:3c93:b0:c2:b228:dd7 with SMTP id b19-20020a056a203c9300b000c2b2280dd7mr1155479pzj.49.1676352721669;
        Mon, 13 Feb 2023 21:32:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b0023234abed5csm8282909pjg.9.2023.02.13.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:32:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH] builtin/clean.c: fix error message usage typo
References: <20230214032534.507628-1-cheskaqiqi@gmail.com>
Date:   Mon, 13 Feb 2023 21:32:00 -0800
In-Reply-To: <20230214032534.507628-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Mon, 13 Feb 2023 22:25:34 -0500")
Message-ID: <xmqqbklw95in.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> As Documentation/CodingGuidelines says, we shouldn't capitalize the first
> word in error message. Change the capital letter to lowercase letter.

I think the "do not caplitalize" rule is about the sentence after
"fatal:", "error:", "warning:", and "info:" labels.

> -static const char *msg_remove = N_("Removing %s\n");
> -static const char *msg_would_remove = N_("Would remove %s\n");
> -static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
> -static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
> -static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
> -static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");

Do any of these messages come after any of these labels?  I didn't
think so.

>  static const char *msg_warn_remove_failed = N_("failed to remove %s");
>  static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");

These do appear after "warning:" and downcasing is very much
appropriate.

Thanks.
