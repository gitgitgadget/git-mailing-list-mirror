Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B50C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5904960F02
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhJYPgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhJYPgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 11:36:20 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88124C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 08:33:58 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h20so6446035ila.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2TUs3+VqtGG6NtEsGyTV2ReqzISBtFAlTo9WB0m6wDQ=;
        b=EAp7VbSf5ObVgrwfKPb1h1jT9VqiRGGi9AhgVrd08ptTMIwJ5Uh1M4nnD+y3I4HgNP
         isTsnWuGz3eb8SWSvRukVliso0Z7CXKcr4yhq5dBV4OoidUlktDpbZdpIjoFcFQ5/j/3
         B09bqv9v2AiYNoSwM6CFtjLEG7TO2KR8/zDS6ij0s0m06MFi2CWjoTyOs1xlN0kQllnV
         RxNgxhY2lkRgay/n4kLRZ9QVIsa6UbatHrvoIl81I98VjQpB2Z9JR5toVXlW8gj67Bjl
         EqBXvECOM4sTN0Qd8wknXOJQAF5eRCECk5LLpxlqKsx/029ZaZ8lqqOIFvZlPtg/LfK6
         k31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2TUs3+VqtGG6NtEsGyTV2ReqzISBtFAlTo9WB0m6wDQ=;
        b=F4BzQxeWo3rbKKz7FcXU3BJbjW924Wdp+8Ww5Qyypy7JzsaBYfDlQtJqztz0OazOVr
         ROW4mu2Fk8F8R3/wKFZOWbX/Yh5h0dSJuSJVKpr7/ILrd3mEvVFNEYMkRs35BXKIshTo
         AluiRwKkYEiNbjPAAsglWO+9/utqXfNN4pQ4W50Qx2SdHYAoVpYets6x2ibCyvlULSqa
         aS81Wzq9kMzICcoYIsFXSh3AgBfkGLL8e4uiF3R+eCFQ1ttxrp4HxCEGwjt8UBnZNzf+
         aCntWCX9Ro0/XpENJl9TOCYWGK5q2pMcovJ41LlXtNV28hZ+zZl0RgDmB0FrYQZ1ol8K
         k5Pw==
X-Gm-Message-State: AOAM53256a7qPPrf9eljz4JXoft6u0OeL6uq4vgmTxToFERnFjbL/dJD
        ab7PA+McrRfh/MgcBudWK9w=
X-Google-Smtp-Source: ABdhPJzZaY0Nwrjpj3+Pcjey+iz3iQA4SZOKIi5zVruGrXj3iqfeRDvYy5y+EK1NJ6cEng2TQZYBZg==
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr10348872ilr.283.1635176037840;
        Mon, 25 Oct 2021 08:33:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b594:8626:d264:bb0? ([2600:1700:e72:80a0:b594:8626:d264:bb0])
        by smtp.gmail.com with ESMTPSA id b3sm8957373ilc.36.2021.10.25.08.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:33:57 -0700 (PDT)
Message-ID: <f816eec1-cac9-7ed5-18ce-37665c11d571@gmail.com>
Date:   Mon, 25 Oct 2021 11:33:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] command-list.txt: remove 'sparse-index' from main help
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20211024170730.3428123-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211024170730.3428123-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2021 1:07 PM, SZEDER Gábor wrote:
> Ever since 'git sparse-checkout' was introduced [1] it is included in
> 'git --help' in the section "work on the current change" along with
> the commands 'add', 'mv', 'restore', and 'rm'.  It clearly doesn't
> belong to that group, moreover it can't be considered such a common
> command to belong to 'git --help' in the first place, so remove it
> from there.
> 
> [1] 94c0956b60 (sparse-checkout: create builtin with 'list'
>                 subcommand, 2019-11-21)
> -git-sparse-checkout                     mainporcelain           worktree
> +git-sparse-checkout                     mainporcelain

Thanks! I didn't realize what a pain it would be to include the
'worktree' grouping here.

-Stolee
