Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16615C4708D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 12:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjAFMbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjAFMbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 07:31:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBF3889
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 04:31:00 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f3so1077203pgc.2
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 04:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agYWVUulkCVNop2zSqJFPWyr5EG0yLBeRe05mOO7wMo=;
        b=dxZQqurl+sR8F+9RSSKXjShzG3/3R1C6XK3qD1UlM2N8jRepmL9UH0h+HSj5H8cplG
         7oXt+bUN/j2aOAbo3P2wx5G9m4Eqm0106nEqjkg+Qy/cC6/Oo0E3CaoNYaSGDknfhBUs
         a9dbGL99sNGlsrXeZOZjD5pHg9At3bqHuK02+4x6uqOSg8Q148Yoh8x245KH409kkB5t
         1PJwjAol0cna8/hxpsj/nvV1rWNPZB/Mhw/IKv/lp/qCS1jicf8QJ/NZ3icHr2CXOe/+
         pUwkDaVQEn/4IJ2zsOW9YmV1B4K2z30qg7iy4ItnCQH+pNmBZXhuQXIOtx1adELc/6mx
         bYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=agYWVUulkCVNop2zSqJFPWyr5EG0yLBeRe05mOO7wMo=;
        b=3FLMqKiYa+CpLfF1wldMPHSKy3eF19qf8Am/x+DAQ2O8nV3IDVq8yxfyYDh3GCnOj5
         idyvoOSZkeU4W4QBtsL68Ebpf15ygCQIl4A63wN6pCgZHEN8668Q6VTmnIalHG2qLcaY
         W8PjhtMowvoyCP0xMR17yCTaROqzb5uRXhcm2IckkpLdnXrtm1RXyGXM3IQsjN9EDmzm
         ABhkz3OwZ1DHteH3Mjw4bM652muKQP89rpoOmfdsInjYWx9BVayOijo+Cvp966oidsY7
         SvrmYWRcvqPyqMxmhqi/PU7EmCSJPBALzRK58I8CwEcX20GL46ZJ7Vwe0Inrhi3FQps3
         735g==
X-Gm-Message-State: AFqh2kqd7F5jXaNqyX9FLP7m5xuwY+nY+js5Gm/ykSUQcABWQcdtrDQW
        u+IHmJTrGz/V5ON1wYDGeLW4CU673NJ+aQ==
X-Google-Smtp-Source: AMrXdXssJsAxrhxftNGYASyGXLXPMK1IN+WSdejpqvr8sd/Em72y5+5lLnBS7TwhYGkJ5s0+MGGSBQ==
X-Received: by 2002:a05:6a00:1885:b0:580:9a80:6e37 with SMTP id x5-20020a056a00188500b005809a806e37mr67180420pfh.25.1673008260109;
        Fri, 06 Jan 2023 04:31:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a17-20020aa79711000000b005813f365afcsm998871pfg.189.2023.01.06.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 04:30:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] scalar: show progress if stderr refer to a terminal
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
        <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
        <1f8493b0-3f96-c616-1e4e-98b6ed33e8c4@github.com>
Date:   Fri, 06 Jan 2023 21:30:59 +0900
In-Reply-To: <1f8493b0-3f96-c616-1e4e-98b6ed33e8c4@github.com> (Derrick
        Stolee's message of "Thu, 5 Jan 2023 14:19:11 -0500")
Message-ID: <xmqqsfgnsv3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> +test_expect_success 'progress without tty' '
>> +	enlistment=progress2 &&
>> +
>> +	test_config -C to-clone uploadpack.allowfilter true &&
>> +	test_config -C to-clone uploadpack.allowanysha1inwant true &&
>> +
>> +	scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
>> +	! grep "Enumerating objects" stderr &&
>> +	! grep "Updating files" stderr &&
>
> Here, it would be good to still have the GIT_PROGRESS_DELAY=0
> environment variable on the 'scalar clone' command to be sure
> we are not getting these lines because progress is turned off
> and not because it's running too quickly.

Good point.
