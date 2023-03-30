Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B66FC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 15:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjC3PQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjC3PQI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 11:16:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC0CA1C
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:14:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n14so2509824plc.8
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680189282;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv/8tdg2DdTv5VEAB1obNGh6swMwTU0CIbb3iiacQsE=;
        b=lvxvjtHWEtvZgzpq7N6w/JYEmcAU7ZdIM1QKMMNEFNx1ZH9jS05isxtH6VszNUrGPG
         2Y+1by6pyNdPKW5VFwr16mAAq6SAtwgVD61YhtWMkGMqZmBTmesrLyR/G549UsVz0Dt1
         U86TtVwoESIXR/1YMag1x9TnaOlcAFN83+RCzVOsqM6zTmKvHE6xPcJKK4ltX6LL2is1
         TZq0gOZTP5qXlRH/y6IU2/arufwGnInrZipSMWykKzr2QxGTM4dXxayOpCh3fGqlirjY
         JdLAr7tZ7AN+a6IdFOd8/r1bjzgVqD+uyqX33rX3n85FlZFZ0hsisI7z9NvJ6xYnf8WF
         kMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189282;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qv/8tdg2DdTv5VEAB1obNGh6swMwTU0CIbb3iiacQsE=;
        b=3nAxEOqZJhzX4YR2UGnBSdlxqmEnMkuWZ37/roInUGbq9jNSaeMqDfs+CNgYbcvlHG
         pgUjdsrg9hBpoiGMMNWp8BNTS7bWFFzcMbzWoUnIFGCFx3OV1AdpFNwD4YAq6RnMOnhU
         1/tc24DMpRsRmpfM93suVjbQjrye1mii8WWCyUxMgAc5qx2iNDJNW9mI8vPkLTGWMczh
         Nm38IiYnzI/XO8EyOAY/J248yaP3ii/VnHo2WxyaMe4mUPXV8e/+jQjYj3IYVBRHVCtV
         bMBFEkasBNMbVwdQRAwZ6Byxz2nM2E0iis7rxJ7AKiCM5YyxuSP9MlatQ12JetanIB0F
         n/vg==
X-Gm-Message-State: AAQBX9eqO+W6uT2Gbqq7/bd1OZw68XgLrEGh6Q3e8MhV6tkRi6ts9vUt
        Y3ANBmE8mtLPnSkKtEoG5ws=
X-Google-Smtp-Source: AKy350bzMoPVWWL8iuOf09EBNlEAi6VaiTIdLwkq52GwiOg/48L2JVitn1cUejaJkpNPSzoxR9ZyIw==
X-Received: by 2002:a17:90a:348:b0:237:b702:4990 with SMTP id 8-20020a17090a034800b00237b7024990mr25336731pjf.26.1680189281685;
        Thu, 30 Mar 2023 08:14:41 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090a1fcc00b0023b15e61f07sm3354932pjz.12.2023.03.30.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:13:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
Subject: Re: [PATCH v3] describe: enable sparse index for describe
References: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
        <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
        <xmqq1ql64796.fsf@gitster.g>
Date:   Thu, 30 Mar 2023 08:13:02 -0700
In-Reply-To: <xmqq1ql64796.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        30 Mar 2023 07:57:09 -0700")
Message-ID: <xmqqtty22ry9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Raghul Nanth A <nanth.raghul@gmail.com>
>>
>> Add usage and performance tests for describe
>
> I think this sentence can easily go.
>
>> Describe uses the index when it is run with --dirty flag, which uses the
>> run_diff_index commmand. The command is sparse-index aware and hence we
>> can just set the requires-full-index to false
>
> End the sentence with full-stop.  More importantly, it would be
> nicer to have something to substantiate the "this is sparse aware"
> claim here, something like "since commit X" or "as shown in the test
> tXXXX.YY".

With a bit of digging into the history, I think the topic that was
merged at 8d2c3732 (Merge branch 'ld/sparse-diff-blame', 2021-12-21)
made various modes of "git diff" to be sparse-index aware.  t1092
has tests for "git diff --cached", which uses the same machinery.

    Subject: [PATCH] describe: make it sparse-index aware

    "git describe" needs to compare the index and the working tree
    when (and only when) it is run with the "--dirty" flag.  This is
    done by calling the run_diff_index() function, which has been
    already made aware of the sparse-index in the series that led to
    8d2c3732 (Merge branch 'ld/sparse-diff-blame', 2021-12-21).
    t1092 has tests for "git diff --cached", which uses this exact
    machinery.

    Mark "git describe" that the command does not require the index
    to be expanded fully beforehand.

or something like that.

> Updated tests do look good, and the code change is of course minimal
> and to the point, which is also good.

Thanks.
