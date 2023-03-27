Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A3DC77B61
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjC0Qdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjC0Qds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:33:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059C26AE
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:33:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id cm5so251731pfb.0
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679934805;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqHQOTFTFOnFOE/rjBG0Cw1S/EcR3pvQiJEy8jP6dd0=;
        b=XNskoSxzF3GQgDo2qrE72IVyDTl/lsMAnS2krR7qsoto+bh3ndI0MmyfGHsO2W0s1A
         QIM6u1YsAHHrqmX0zwcGnRrMO4f6ygxRzHY68ry83/zfzpCQK1kSXFA1f86KUN25z0fB
         KZNtPKmOIrNUOPzS2wkHjxI4Utsk2thOEf1ZqtHwzPp6bc7J33AI/ELGP2DqemLXhjTo
         R47EpuUgRbbkke+IL8jP3MI2c2ZnE7dxpcA31f+pA7W6EGqMeiLb0W+eUSeLlX5UvAa2
         JyOay4p8NwMVKs+OAV3yS9Exa+VIWg0rRogeA8Vfj5BuyRumNA1WIMV13apLh8Xj2jUI
         blWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934805;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqHQOTFTFOnFOE/rjBG0Cw1S/EcR3pvQiJEy8jP6dd0=;
        b=4MJ9CL3OJD2+502XN+2kVSSmBGkx4DiNdB/5hJaJo8dPDxppsLULnZ5CHX2uc6aqh3
         3LfSVHk7Z7/UJ7fq5OaaL/P6XgLzsg31N+9wxpoTmLfzPrQJvb9jxRxE9pDEJmEY1V4N
         B3EtNVL1zHV/m1V5xCnwj8yU9ezuRrWabMgdoyriHsLGgfloKv2542J56DC4jiv4mDEM
         b9VQl+63qjM7erarkN5kdQbnGiz6KNe6WlYtetOBTYq7i2v6Bw+GUbHxS5mQ+mHwv4rI
         HnS2EnNsGhErgvH5ad4aEKhNYrkFriEteoMnvabNs0EltNqcwB2eRgnVx5FdxEh7gwNJ
         RmQw==
X-Gm-Message-State: AAQBX9dB9YQtw9LRjQOAoWBi1BltNO+Zr6pLZbG9MlOLDGbfpinbyFdu
        onaQpMz2chD2hNF2FikjpWI=
X-Google-Smtp-Source: AKy350YHOR/s11qbRj5GQfaxELO0puUKLUF94Bu87P7j2qfJ3SHY9JNdfAgot46ZzSvXB/6jqyVCtg==
X-Received: by 2002:a62:1dcc:0:b0:625:2636:9cd2 with SMTP id d195-20020a621dcc000000b0062526369cd2mr10848488pfd.18.1679934805408;
        Mon, 27 Mar 2023 09:33:25 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j24-20020a62e918000000b0062d942f0ad3sm571368pfh.51.2023.03.27.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:33:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Subject: Re: [PATCH v9 0/3] rebase: document, clean up, and introduce a
 config option for --rebase-merges
References: <20230320055955.461138-1-alexhenrie24@gmail.com>
        <20230326030636.2635642-1-alexhenrie24@gmail.com>
        <19ab92b4-6b83-d788-78f2-43a3ec3ec412@dunelm.org.uk>
Date:   Mon, 27 Mar 2023 09:33:24 -0700
In-Reply-To: <19ab92b4-6b83-d788-78f2-43a3ec3ec412@dunelm.org.uk> (Phillip
        Wood's message of "Sun, 26 Mar 2023 16:12:03 +0100")
Message-ID: <xmqq8rficfxn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Alex
>
> On 26/03/2023 04:06, Alex Henrie wrote:
>> This patch series introduces a rebase.rebaseMerges config option to
>> accommodate users who would like --rebase-merges to be on by default and
>> to facilitate turning on --rebase-merges by default without
>> configuration in a future version of Git. It also cleans up and
>> documents the behavior of the --rebase-merges command line option to
>> avoid confusion about how the config option and the command line option
>> interact.
>> Changes from v8:
>> - Add braces around one-line else clause
>> - Remove unnecessary change to error message priority
>
> The range-diff looks good to me. This iteration addresses all of my
> outstanding concerns.

Thanks, both.  Let's mark the topic as ready for 'next', then.
