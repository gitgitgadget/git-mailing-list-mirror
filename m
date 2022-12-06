Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D3C3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLFVwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 16:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLFVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 16:52:13 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911E48402
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 13:52:11 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4NRYzW5tYjz5tlB;
        Tue,  6 Dec 2022 22:52:07 +0100 (CET)
Message-ID: <a11c51bc-f419-f128-05c9-d9706aabc665@kdbg.org>
Date:   Tue, 6 Dec 2022 22:52:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
 <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.12.22 um 16:07 schrieb Johannes Schindelin via GitGitGadget:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..f8c6205e08f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1546,7 +1546,7 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	test_set_prereq WINDOWS
> -	GIT_TEST_CMP=mingw_test_cmp
> +	GIT_TEST_CMP="GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --"

After René's work, it should be possible to drop this setting on Windows
altogether.

I started doing that, and when I proof-read the patch, I noticed the
SED_STRIPS_CR and GREP_STRIPS_CR prerequisites that are visible in the
context lines of this hunk. I wanted to explore whether they can be
removed as well, but I ran out of time.

-- Hannes

