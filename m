Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6EDC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266D16140A
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhJDT5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhJDT5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 15:57:32 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A9C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 12:55:43 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so23064021otq.7
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=i4ZPFKPnOVz4FqxPK6PL4wgswjR56nuJXZjVqZAtvhs=;
        b=BDA940E9nn3NwpFeqXp+9b3YbetYaOr4wg9VaPrgJ/HxC5QQJTGsLyO7VgYXUNYfVu
         wPGTNBGaFWk4ckegI2qaVaE0aiAOjcdV/JN6TsC1XzcskSbwX82DwL9UmSjsLLL0picO
         RtDztcgowggwpDgIfCzk+dWeg43TgZdvDl+9G/8M12IuCmoJurEiPZygVCaEnm8FMI0Z
         8zIWqZiWCDG4YVLZp4Pnvs0/OR80TG8M9Z6THBMgTNhTVLl8c64S8Bj9161pOC0Qd254
         y1xc5ESKRCOqpAAc+yjtx3YGYnMnzxcpfMxjTH9G385uXMR1voqczOPKhb9+nN9kYKz6
         gkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i4ZPFKPnOVz4FqxPK6PL4wgswjR56nuJXZjVqZAtvhs=;
        b=gyIu0YoYGlyeQIdM5orIjcYnr6lx22OPHyo8bxf2OswL8ECdj7n9EwOhevNLCGel7h
         CHWX0AR9HeKDHE9Ou70XPW325B3PPTrg+5I6fRU+Hvl5ZEFFcoafRibZ9TXBEhMdk4Wt
         DZ03LDlr32pdjwv7uNND9pA5SKNnUs7npc13RO+QACmAPwB0dreSSVgM4nVUJjcRFGld
         V5hOf37eAxGeUsbYx8QQkmhc+1sgF0OsaXPZgE2kOCWLc+yBeFtElavOlRSKysIrS8bi
         zXoeUoQFaJIYZ1aWabzEdPPS5J0mJ5quVEOqSKwTQEInEVMOTMy1E9wwLmt2oS1CZQKY
         mmmg==
X-Gm-Message-State: AOAM533pxdTV9o2cOpfzeZ5ytwxXQ6L4h99jih3GVcWOjMKA6iyScV/9
        iNPl7zy26UcSkwQWL85+tjs=
X-Google-Smtp-Source: ABdhPJxq0UX/4/CtZbY+YrLN0ffLbsbbQT2InWNIT08FUV/IhaPauwNTEm5F+5t8WSMGZp8FMz9qMA==
X-Received: by 2002:a05:6830:2805:: with SMTP id w5mr11298021otu.248.1633377342824;
        Mon, 04 Oct 2021 12:55:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2960:f424:587d:3bfa? ([2600:1700:e72:80a0:2960:f424:587d:3bfa])
        by smtp.gmail.com with ESMTPSA id r188sm2885310oie.7.2021.10.04.12.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 12:55:42 -0700 (PDT)
Message-ID: <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
Date:   Mon, 4 Oct 2021 15:55:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: p2000 failure due to empty reflog
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/2021 1:37 PM, René Scharfe wrote:
> p2000 fails for me and reports:
> 
>    perf 18 - git checkout -f - (full-v3):
>    running:
>    			(
>    				cd full-v3 &&
>    				echo >>f2/f4/a &&
>    				git checkout -f -
>    			)
> 
>    error: pathspec '-' did not match any file(s) known to git
> 
> checkout fails because the reflog is empty, so the "-" can't be
> resolved.  The pathspec error message is confusing, though.
> 
> The patch below adds a reflog entry and allows the script to
> succeed.
> 
> Before the "test_perf_on_all git commit -a -m A", there are two
> reflog entries in each of the five clones, after it there are
> none.  How is that even possible?

That is certainly confusing. Is there something about your global
(or local to your test repo) GC settings that cause an auto-GC to
prune the reflog aggressively?

> @@ -109,6 +110,14 @@ test_perf_on_all git status
>  test_perf_on_all git add -A
>  test_perf_on_all git add .
>  test_perf_on_all git commit -a -m A
> +
> +test_expect_success 'add reflog entry' '
> +	for repo in full-v3 full-v4 sparse-v3 sparse-v4
> +	do
> +		git -C $repo checkout $OLD_COMMIT
> +	done
> +'
> +
>  test_perf_on_all git checkout -f -

While I believe this will fix the situation, it might only be
a band-aid on the real problem of losing the reflog during the
test.

Thanks,
-Stolee
