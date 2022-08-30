Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3BDC0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiH3NRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiH3NRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:17:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1569D21D5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:17:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso9915669wmh.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=2qVkkmOgykRdYz9SqNY6NW9hJKDFh4vKcreY1S7xMbw=;
        b=CaP9mD0YmbRfgltoB7Cjd2fXdWU/bM2bdVWc31T9implqA9j3QsYXTE8f4sW6h+hc7
         f8BOY7xPLS3+WK8HWS3ydhVEP6/oJ8liRM8yEXfN2F0ptrKxv1BduiobeOk5fngt+DK0
         agvOHrSyQDSfpfxUgF+a9dVSM12BgtyzeIZorpfZHvq4T8HuP3jZUFeS1JKbdhq/DYlS
         gNE9raZgTgzgJwHhnuKyZY7kHeuGltfm5MJQPr7MdTzM8S89VqsGTlmRzjW3V06S8BB8
         TsYl+QEgGyYf30PPskBKigKlHYMUq8GLJ6xV+Vud8aY5dg7mk+TxznqYSatvfH3V9HRF
         Pnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=2qVkkmOgykRdYz9SqNY6NW9hJKDFh4vKcreY1S7xMbw=;
        b=4bGZWWo8cxmPEHtFntHDPSfpyyQqpD7Uuyb2ZGreTEtwJ/vonfDJamyZzaTiEEKKZO
         c+RrWAdBNWuthQ/wvsRbmvuOprbYcYHkencVsyztjUx/+58RAk2Txva2dgvzDuu4GFpA
         dM2gqYqOWjOsrAoA/LCGOqcP116TQHgxMEK2Q3Zm2PvALCboay2QTuVY4nUoEMM7FFSJ
         YOcc3/yDMkP9zTvMSPd+qHCCSj6IjIyYwef3DTABjd5vK1hjCpg72rn5tuQqG3q0XTHU
         +lylGG+wXB13PlnXOCq7zbACzOf0j0DIDQUyw7Fz7RmNpAGrIXbU3joB3d7hTyHOsefV
         fEbQ==
X-Gm-Message-State: ACgBeo2IqHEDETtN6DFG/s2EaHxgvUlZhY4pW1Ifp8j9WK86o7EQlPs/
        FbxVWdyMsBJdBse9tbxvmsw=
X-Google-Smtp-Source: AA6agR6hQBRRVEaGgBRuopA5cAK0/pdpB6G5FJGPWVInxwVFPLQFpHntcpOV7c+mEX8qCZPCXdUhYQ==
X-Received: by 2002:a05:600c:224c:b0:3a6:7234:551 with SMTP id a12-20020a05600c224c00b003a672340551mr9611509wmm.27.1661865471393;
        Tue, 30 Aug 2022 06:17:51 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c15d400b003a331c6bffdsm11382296wmf.47.2022.08.30.06.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:17:50 -0700 (PDT)
Message-ID: <9261de42-3287-6ccb-6cf5-21c0a8ee1f17@gmail.com>
Date:   Tue, 30 Aug 2022 14:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/5] t3701: redefine what is "bogus" output of a diff
 filter
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
 <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 29/08/2022 16:11, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When parsing the colored version of a diff, the interactive `add`
> command really relies on the colored version having the same number of
> lines as the non-colored version. That is an invariant.
> 
> However, in the 'detect bogus diffFilter output' test case in t3701, we
> essentially required a hunk header that contains parseable `@@ ... @@`
> hunk headers, and called all colored diffs without such hunks bogus.
> 
> The reason for this is that we would like to show the users the adjusted
> hunk headers _including_ the extra part after the `@@ ... @@`
> information, which usually contains things like the function name or
> soms such.
> 
> Now, there is a _very_ popular diff colorizer called `diff-so-fancy`
> that does not produce such colored diffs as the built-in `add` command
> expects. Nevertheless, the Perl variant of the `add` command handles
> those nicely, essentially by ignoring the hunk header and saying "there
> is nothing else we can show except the original hunk header, even if we
> had to adjust the line range and the original hunk header might get that
> wrong".
> 
> In preparation for teaching the built-in interactive `add` to be a bit
> more lenient, let's change the 'detect bogus diffFilter output' test
> case so that it verifies that a mismatched number of lines causes the
> command to error out, but not an unparseable hunk header.

The existing test deletes the first line of the diff[1] - so it is 
removing the "diff --git ..." header not the hunk header. This patch 
changes the filter to delete everything except the diff header which 
seems like a less realistic test.

Best Wishes

Phillip

[1] To verify this I changed the filter to  "sed 1d | tee 
filtered-diff". filtered diff-contains
index 0889435..d95f3ad 100644

--- a/test

+++ b/test

@@ -1,6 +1 @@

-10

-20

-30

-40

-50

-60

+content



> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/t3701-add-interactive.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 3b7df9bed5a..88d8133f38f 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -761,7 +761,7 @@ test_expect_success 'detect bogus diffFilter output' '
>   	git reset --hard &&
>   
>   	echo content >test &&
> -	test_config interactive.diffFilter "sed 1d" &&
> +	test_config interactive.diffFilter "sed q" &&
>   	printf y >y &&
>   	force_color test_must_fail git add -p <y
>   '
