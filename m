Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31392C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiGSRnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiGSRnD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:43:03 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DC54651
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:43:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r70so11276224iod.10
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vX4k3JxC1ub/1uFBpXn0JdIAO4ZlcMC4jh0QutCEsy4=;
        b=ID/olUK3a2cFypM/Qp5IaJrD/GshhHrEi31XF9XVf1TY9P84I2BXX9rEG3i+pWTOmf
         8P/yDRJcYJ8HEb5UXOPpbwxOJF+oRCglTCHf+DH67bSpJmp0uFwJherv9rfKTTq83mV3
         EAYcwuq0Q0KeH+OTD4/fPgZRdZ0emrfdVUoFp7Rho0kC+71ghwviK/I+QIr9Bgu81JU+
         KuXqQYuq0R4yfnrUd2/dzZ502qPq33aDqDn2WslOHn9eEFzn8LhWNo0cKazhrF6rg1ID
         imFVdwY7vEgs+Istjb7No5ZwM/WXAISzl5iKb/iRV15OYnx3/vBHEnW8pqn8hVC5jjWE
         GlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vX4k3JxC1ub/1uFBpXn0JdIAO4ZlcMC4jh0QutCEsy4=;
        b=qtBwWgEV0ZO9ixXpOPLW0xivK3zZwnotdF1OQ+biUkClpmdHveRitHabWQKGatgI2B
         c97ZccbVkrmZHJN6cKnPikgkgoau22c+u+7+et+vnl6Lqgi4/5e3fkOpd8+u5RcdDYdJ
         MbcEtf1m1Q5HrVqv/jV0n3SLxMj2xZvpV4n4kYoD/aFXlSmaMwakVfGXBpIaXR6LkuFm
         qrd2NY4WIR2Tlw0OEI0RJEt/nicIoj2tTnuAJIWqakv6e9cdKnJTGNV2bW1ebY+pbfgW
         v7q5T4xjmR7ekAxFywPYFcFLx05vuymI2Q+gtPs9qwpczOwdUFU94DmlR9Bw33jJroE8
         g4rw==
X-Gm-Message-State: AJIora9tlBk+WaFw9XGYy/8dWUynpr8ydQm7ximefsNbTt2hKscSI6R1
        PGAuK1JrJHfFfCHgf6lRetn3
X-Google-Smtp-Source: AGRyM1tdT0/N6rbfLMFUl70OullKu0RpdU54M7waWZG57Qp7BhQyyQEoKFq1PVKTj/9k4RNQEtq4+g==
X-Received: by 2002:a05:6638:238d:b0:341:4c3d:a923 with SMTP id q13-20020a056638238d00b003414c3da923mr11728607jat.124.1658252582533;
        Tue, 19 Jul 2022 10:43:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id j15-20020a0566022ccf00b0067beb49f801sm5563750iow.2.2022.07.19.10.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:43:01 -0700 (PDT)
Message-ID: <228ad533-477c-f16e-220d-61e52d9aee26@github.com>
Date:   Tue, 19 Jul 2022 13:43:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] mv: add documentation for check_dir_in_index()
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
> Using check_dir_in_index without checking if the directory is on-disk
> could get a false positive for partially sparsified directory.

It can be helpful to point out that this is a relatively new
method, introduced in b91a2b6594 (mv: add check_dir_in_index()
and solve general dir check issue, 2022-06-30).

> + *
> + * Note: *always* check the directory is not on-disk before this function
> + * (i.e. using lstat());
> + * otherwise it may return a false positive for a partially sparsified
> + * directory.

I'm not sure what you mean by a "false positive" in this case.
The directory exists in the index, which is what the method is
defined as checking. This does not say anything about the
worktree.

Perhaps that's the real problem? Someone might interpret this
as meaning the directory does not exist in the worktree? That
would mean that this doc update needs to be changed significantly
to say "Note that this does not imply anything about the state
of the worktree" or something.

But I think I'd rather just see this patch be dropped, unless I
am missing something important.

Thanks,
-Stolee
