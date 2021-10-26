Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A6C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A2661078
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhJZTKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJZTHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 15:07:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73D9C07978D
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:04:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m184so678414iof.1
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pzUTZjeQ5u6KSHKde37YefjfpFnbAgKijZdfydNtvUw=;
        b=V3KXWD55VkbGIXwurs0n1hPASR6BNsSZExHRXOmjioauqZZOa7ymKkykycV67xBpCr
         JkUCerZKqC/T4YK5+szUPZgzR1+nu+FavKkN4KmA0GdlRjE8MPqWz2BN6+dcefBvo1+M
         FWcewOijAmRfkMqO+I5KahzKxmu9Lbkcj1sBNgjiRA+5tbSFv+DDIyDkzMf1MzGSiLmU
         qfGk5BExKIbj8hjtAMQp78kD2CUU+agp3vqIJ+8pp0vrOwXS8jl9GcUqB+LQj9z7ST18
         x5z/pUQO6Z6XdcjiLGxFnsLQfW9rE4/8NiN7q8yv7MkvKtNkb59nwlwlnoy2E+6ESJjy
         sF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pzUTZjeQ5u6KSHKde37YefjfpFnbAgKijZdfydNtvUw=;
        b=AydhZ/lstercpZvRLH9PxnTjI17mREXeJ4jwSYjzKFw4mi+aL5XIsv3nYGZ4QcLwVs
         80mm6mcYcy7NfyGICp6JhEUitOLoK5PSvbcX00ZSeNLFEMpwU5Aajfow7A8B/M+EOhtQ
         eBI/wRzRdxenK7wyOFia5cW3Zi5mGIzf0ZQWPBcN6/VZIWrWzPnsULd8lOuSQEVVuGPv
         v6CpkmO9HNlXTO/YSu34lWZzHO/E0a2N3EvqIERxQmt13LIQ4RxBZSPhbVPjMpP7FnDi
         V6X8UCYaeFs1psByH5ji2AXEKRcVE9JX9HquSIP1KKffgVWOA0v1muidFcHQ99H9ma3c
         F9+w==
X-Gm-Message-State: AOAM532SHYq1KXtxjmvWQgSyOeKBJeP5xhtE8GGH+bYPpNPKrBEwKJDX
        7FIZ3rpwFDzXFiR5mI8r7zvifYQVyMY=
X-Google-Smtp-Source: ABdhPJyuj9dAq4VU/Yj1ZQcXNT9Y/mLRuNyCiTEteOv+makg9PDFK9Ch5jxiaY8QsLwYNP/m/68JrA==
X-Received: by 2002:a6b:7604:: with SMTP id g4mr16792396iom.162.1635275089090;
        Tue, 26 Oct 2021 12:04:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:86f:cede:45bc:10f6? ([2600:1700:e72:80a0:86f:cede:45bc:10f6])
        by smtp.gmail.com with ESMTPSA id v4sm480798ilq.57.2021.10.26.12.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 12:04:48 -0700 (PDT)
Message-ID: <00a67af9-da41-6df4-afc0-5ae7c7714bfd@gmail.com>
Date:   Tue, 26 Oct 2021 15:04:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, vdye@github.com,
        derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
 <ca1c6a86-23ab-57ae-b1ca-64a9851d72db@web.de>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ca1c6a86-23ab-57ae-b1ca-64a9851d72db@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2021 12:22 PM, René Scharfe wrote:
> Am 25.10.21 um 23:07 schrieb Matheus Tavares:

I reordered some things to first audit that 'slash' is used safely,
assuming that we can store "p - 1" if p is a non-zero pointer.

>> +	/*
>> +	 * If UNDECIDED, use the match from the parent dir (recursively),
>> +	 * or fall back to NOT_MATCHED at the topmost level.
>> +	 */
>> +	for (end = path + strlen(path); end > path && match == UNDECIDED; end = slash) {
>> +
>> +		for (slash = end - 1; slash >= path && *slash != '/'; slash--)

Since "slash >= path" is compared before dereferencing '*slash', this is safe.

>> +			; /* do nothing */
> 

>> +
>> +		match = path_matches_pattern_list(path, end - path,
>> +				slash >= path ? slash + 1 : path, &dtype,

This is also a safe use of 'slash'.

> slash can end up one less than path.  If path points to the first char
> of a string object this would be undefined if I read 6.5.6 of C99
> correctly.  (A pointer to the array element just after the last one is
> specified as fine as long as it's not dereferenced, but a pointer to
> the element before the first one is not mentioned and thus undefined.)

I also see the specification saying this is undefined, but I do not
understand how any reasonable compiler/runtime could do anything
other than store "path - 1" as if it was an unsigned integer. There
are a lot of references about "the array" that the pointer points to,
but these pointer arithmetic things are not actually accessing the
memory allocator.

> Do you really need the ">=" instead of ">"?

I think the only case that would be of any interest is if the path
started with a slash, which would not be a valid worktree path. I
believe we could use ">" for an abundance of caution with the
undefined nature of subtracting from a pointer, but it is non-
obvious that that is a real problem.

Thanks,
-Stolee
