Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB17FC433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E9D206BE
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj5ln8VA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHWP60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHWP6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 11:58:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC263C061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 08:58:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so6016561wme.4
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V6B6nMzqXoYNkJpL83NBuTqjuRfanC03JjEyAHELl0c=;
        b=Kj5ln8VADmhsnnozse9q/12CuYusFPwLgxaTnq4vXBKp+59V48ygir8Frk07qRpVxn
         4sUw4eXtJDPZUF8BbQaS1WES5Uza/6LIXA3L/U/av3nE8aDaD/xpOJgZijNxrZLjdQMR
         foVVvFvHix/h3GhKPDkABxFtvhoz+1XWWQSIdtc6jE4YCBoP9dYLEgQ96e9MpMVl6xCi
         U9Fc+QoOdccsOaD28jNu5ufV85sHs3BBBf0CAW9v3VTuucW5GiBU01OcLj1oEAR/5IfM
         53YfS0xCMIH2SrL9r8J/FUbRZ80G0/06bMdg1+G0U+OpW0ryNrgjSaWCJRj0fJgPGt2x
         U4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V6B6nMzqXoYNkJpL83NBuTqjuRfanC03JjEyAHELl0c=;
        b=rkQpGdi8ZzQYwnUbB9yVmDpG79hGCET75EwgzoiIshxugeHZsVVpM+wCF77fLwK/V3
         GvvOms9RHm1/kIDWLt4OHYtEx61dSJ7qjBkxyq2iwKGAgm8vYEAys4s3XOdI3fWm5Cco
         RKt6lt1O1Vj3GChI9pFXAEWTJRsbe+VfsvfEnuJUl8zpw6ogCQiUOBezBI0BNvaz4JzG
         8ehUv6So0J6gM3r0Qe/BnkY7AzN/c7dz9x4PQ9Qcr7tQ468rYNj+1PcXwoSvQvR0WnB8
         Vbp/FTjJoaUm9QJ+UOyqSUwQS8u+7hupOzCkYfkVZL9Gc4La87/3FwYAo8lzf8AGR2eS
         Pw8g==
X-Gm-Message-State: AOAM532Q7h0elpmmEiHVAEraTB/m6g09msDwgoBQf0/88vk9F/2SW0e+
        XIh8llJ/QUjyuZcMcO29NIKnvh1UdEY=
X-Google-Smtp-Source: ABdhPJxGiYIXIzCezF2D337MW3Dr43iH4QTszFW3WqHztGkwBcyNop8ZNWllyg4AgvkTpjL8opUwTw==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr1875854wme.131.1598198298790;
        Sun, 23 Aug 2020 08:58:18 -0700 (PDT)
Received: from [192.168.1.240] (16.45.90.146.dyn.plus.net. [146.90.45.16])
        by smtp.gmail.com with ESMTPSA id h6sm18230721wrv.40.2020.08.23.08.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 08:58:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] t4140: test apply with i-t-a paths
To:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200806060119.74587-1-ray@ameretat.dev>
 <20200808074959.35943-1-ray@ameretat.dev>
 <20200808074959.35943-4-ray@ameretat.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c5ee08e9-572e-b77d-ee69-f07cf79651c6@gmail.com>
Date:   Sun, 23 Aug 2020 16:58:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200808074959.35943-4-ray@ameretat.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond

On 08/08/2020 08:49, Raymond E. Pasco wrote:
> apply --cached (as used by add -p) should accept creation and deletion
> patches to intent-to-add paths in the index. apply --index, however,
> should always fail because an intent-to-add path never matches the
> worktree (by definition).
> 
> Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>   t/t4140-apply-ita.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>   create mode 100755 t/t4140-apply-ita.sh
> 
> diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
> new file mode 100755
> index 0000000000..c614eaf04c
> --- /dev/null
> +++ b/t/t4140-apply-ita.sh
> @@ -0,0 +1,56 @@
> +#!/bin/sh
> +
> +test_description='git apply of i-t-a file'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	test_write_lines 1 2 3 4 5 >blueprint &&
> +
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +	git diff >creation-patch &&
> +	grep "new file mode 100644" creation-patch &&
> +
> +	rm -f test-file &&
> +	git diff >deletion-patch &&
> +	grep "deleted file mode 100644" deletion-patch

test-file is still i-t-a in the index ...

> +'
> +
> +test_expect_success 'apply creation patch to ita path (--cached)' '
> +	git rm -f test-file &&
> +	cat blueprint >test-file &&
> +	git add -N test-file &&

so 'add -N' does nothing ...

> +
> +	git apply --cached creation-patch &&
> +	git cat-file blob :test-file >actual &&
> +	test_cmp blueprint actual
> +'
> +
> +test_expect_success 'apply creation patch to ita path (--index)' '
> +	git rm -f test-file &&
> +	cat blueprint >test-file &&
> +	git add -N test-file &&

If the last test was successful then test-file is already in the index 
and 'add -N' has no effect, 'apply --index' will fail wether or not it 
rejects i-t-a entries.

I think you should fix this by adding

   test_when_finished git read-tree --empty

(or possibly 'git reset' if that works correctly when HEAD is invalid) 
to each test in this file

Best Wishes

Phillip

> +	rm -f test-file &&
> +	test_must_fail git apply --index creation-patch
> +'
> +
> +test_expect_success 'apply deletion patch to ita path (--cached)' '
> +	git rm -f test-file &&
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +
> +	git apply --cached deletion-patch &&
> +	test_must_fail git ls-files --stage --error-unmatch test-file
> +'
> +
> +test_expect_success 'apply deletion patch to ita path (--index)' '
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +
> +	test_must_fail git apply --index deletion-patch &&
> +	git ls-files --stage --error-unmatch test-file
> +'
> +
> +test_done
> 
