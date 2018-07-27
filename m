Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6D01F597
	for <e@80x24.org>; Fri, 27 Jul 2018 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbeG0Thf (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:37:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38637 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbeG0Thf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:37:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so6388953wmi.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8lQ0AmB9nV7BhL+iOLNdq2qeNz5NxUgt+cNVBnYTjFg=;
        b=YqmQoE/IuuuTKywgydFAhl/mhioFZwVW3xsAcgc4aDgCwsSvEqdr6ofbS5DaMbuS42
         ZGP7Tybyb4hmq6GT1R24A8BsIgmuNomUVQKyKNcA8BPWrKk78NGhRLw6FAL2hwU0PxAc
         VlNNKz7lhwKCwaoM/QzQhXxGfVY4aLdfKaRZovimrvSz6FaMXDLTsdX/iGOOP1lMTwPl
         TfyaRRb4+yIFZdMTucDRIrTv4m0qwqL0KUZv9ieZDpedSoGJN487RP2/XOr+52GsRJr7
         E6MTaydNVSTFvd3GJXbT05CC4ROQ2QxJFsuve+CjNepn29g5CoqulAEZrbCtWwCamjFg
         8oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8lQ0AmB9nV7BhL+iOLNdq2qeNz5NxUgt+cNVBnYTjFg=;
        b=sCKQ60NqmV6Z2a3ons8OGvd/48KL1Ocz+mxMP2+35OS/POd3WsItC2RRDV+a+wBteY
         64axLgSM+V9bl4XMhcMixQP7aLLzUuA9G9gHfQYAZpeK62axfj4Rxxl0cK0Hn6km4Dc7
         483R2DQCrX0QKSSYDGSF1y+ZtoRauMTKbRxNMfFhUOjr9ZKDycgIuqL/CeAaoEAfYXMT
         1GCMXfW5zxNQKocT/KaleoN63vQfSlX+D+OcWZOm2Vror5C8IJZOqoFsVNVTY7nR4qh1
         xR904KvkDio0wq4Pa5fMsy75V/nas0G6nv4EYBX5VvrMAq3ScZy8Hbgz+GJ4F1CsX5xT
         eklQ==
X-Gm-Message-State: AOUpUlHZmxcdQu1ScRKYmfrgUVxlhoQSYbe+TLUU1s5KN30A4ixvvvOr
        ScCKhZH73SveshnkGUI/3Mw=
X-Google-Smtp-Source: AAOMgpdONihCDUdafrqxPzl+WtgGUrbmgPqeND7aJyhreo+c/+VSJHzQxxy68tR4+emO+aBEawsv8g==
X-Received: by 2002:a1c:b80c:: with SMTP id i12-v6mr5033753wmf.30.1532715271856;
        Fri, 27 Jul 2018 11:14:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p3-v6sm5640748wrg.47.2018.07.27.11.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:14:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "peartben\@gmail.com" <peartben@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "newren\@gmail.com" <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] Preserve skip_worktree bit in merges when necessary
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
        <20180727125923.11744-1-benpeart@microsoft.com>
Date:   Fri, 27 Jul 2018 11:14:30 -0700
In-Reply-To: <20180727125923.11744-1-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 27 Jul 2018 12:59:41 +0000")
Message-ID: <xmqqzhycmtq1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> Sending this update as Elijah is on vacation.  This only updates the test
> case based on feedback from the list.
>
> Base Ref: master
> Web-Diff: https://github.com/benpeart/git/commit/0ab3816d61
> Checkout: git fetch https://github.com/benpeart/git merge-recursive-v2 && git checkout 0ab3816d61

Very much appreciated.  Thanks.

>
> ### Patches
>
> Ben Peart (1):
>   t3507: add a testcase showing failure with sparse checkout
>
> Elijah Newren (1):
>   merge-recursive: preserve skip_worktree bit when necessary
>
>  merge-recursive.c               | 16 ++++++++++++++++
>  t/t3507-cherry-pick-conflict.sh | 13 +++++++++++++
>  2 files changed, 29 insertions(+)
>
>
> base-commit: ffc6fa0e396238de3a30623912980263b4f283ab
