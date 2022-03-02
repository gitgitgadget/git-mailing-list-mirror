Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA703C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbiCBNh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiCBNh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:37:58 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB7C1173
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:37:15 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id r2so285559qvr.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0oUClP6fdmCWjvyIg6g0DJcbcKgBpeNtWv1JQyata5E=;
        b=NroMrFSjKgaxJRTddFBa6sMUtfCRTR97FhseTYap6rNZpNrKlPnXHFQaq6RufxjkId
         ini/jfJzGhyE9rVVEuRnr0l5V/oCJ0v+7HAfNX6mZf6shhfhGTkFhLaI6hNTnFhvQHJO
         2bvzR0d0Ldb+Wvwf8jeOo4SAhwHqC+p3PGsflqEpeu7tidRa0l0kkpm592o3fZ+mMpBS
         MS7ZFmyAIYi1i7U032v3ZoGVtUmjuID/LV9GU1o5l1VlHf+6RUQPGyMSWFjLO0vRHqJY
         6A3C5nA480KyPxKYdqT2DVzWtbzyo2U8yTWJl3NJLVpxvJZnaSuJQ293GRdlXF6c+2R3
         WPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0oUClP6fdmCWjvyIg6g0DJcbcKgBpeNtWv1JQyata5E=;
        b=g7aEvUaazvMgOBEDGu+9sbsYIk9ctIr95/hoUrVyqxP9/3NGkRffUSev7BEH/GuDPw
         i32p3quNhZpE46Lmx2n9yBntpp48WxZpAe0YjsIpxBYcdFMY7bhnBrE3DeJxQ6pe3Yu8
         M+4bHUp1/qR8q1qq4aIGE3epUcYvvL2IDAV/N1KA6f7bbedKQiG9wWhE6dFzcwC1Lg3Y
         NDeaTp8Jk/nfDvdKhOhixuN+9OY0O3UXA3q5NiLlR95RC1F47CpVuMl8J46B1xIvUR8Q
         S+ZcE/3aiBKy0tBHtAm+t0Le2CxU5Ps21X1jvvvkr7qx0+ZH7R/O7Q9oRtdwOwNsRmln
         3XlQ==
X-Gm-Message-State: AOAM530BSdtU+8WGk4Rd7ElUKxuEocSgYzCWfMLs3ahl721O/WF2wQhH
        42pPxowKwxaghewitBgTBWy0FIVSb4c8pfg=
X-Google-Smtp-Source: ABdhPJx71xkeop0dOCWS5s0kZGv9XguTZHz+VkyXik+KrUCwTtZqHt43WKte2/ss6+k79s4WV7m26w==
X-Received: by 2002:a05:6214:2621:b0:432:393b:7e52 with SMTP id gv1-20020a056214262100b00432393b7e52mr20770556qvb.79.1646228234303;
        Wed, 02 Mar 2022 05:37:14 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b17-20020ae9eb11000000b0064917bda713sm7970891qkg.85.2022.03.02.05.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 05:37:14 -0800 (PST)
Message-ID: <7f8b3ed3-1836-0e8d-e6f4-77928ad62e40@github.com>
Date:   Wed, 2 Mar 2022 08:37:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] repo_read_index: add config to expect files outside
 sparse patterns
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20220224052259.30498-1-newren@gmail.com>
 <20220226061222.797107-1-newren@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220226061222.797107-1-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/2022 1:12 AM, Elijah Newren wrote:
> Introduce a configuration setting sparse.expectFilesOutsideOfPatterns to
> allow limiting the tracked set of files to a small set once again.  A
> Git-aware virtual file system or other application that wants to
> maintain files outside of the sparse checkout can set this in a
> repository to instruct Git not to check for the presence of
> SKIP_WORKTREE files.  The setting defaults to false, so most users of
> sparse checkout will still get the benefit of an automatically updating
> index to recover from the variety of difficult issues detailed in
> af6a51875a for paths with SKIP_WORKTREE set despite the path being
> present.

Sorry that I lost track of this thread recently. I re-read this
version that made it to 'next' already and have no issues.

This approach will work well for our needs in the microsoft/git
fork. Likely, we'll enable the sparse_expect_files_outside_of_patterns
global when we initialize our core_virtualfilesystem global.
Then, we'll probably replace some of the uses of core_virtualfilesytem
with this new global in some of the conditions that we inserted to
work with previous restrictions in this area. Then, those changes will
be fit for submitting here. If anyone needs those changes sooner, then
do not hesitate to make similar changes. We will adapt in our fork to
whatever the Git community thinks is best.

Thanks,
-Stolee
