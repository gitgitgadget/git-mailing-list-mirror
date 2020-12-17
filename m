Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA0DC2BB9A
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 14:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B4223975
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 14:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLQOEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQOEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 09:04:33 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E26C061794
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 06:03:52 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id p72so916774oop.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z5A6wfgt76VJzjNo75lw5SriEfAKDQRHz3NNUpd0+XE=;
        b=Fcv91vf94lS1htmi7pIE7Y5sUPDjpcQ1bo8bVs4KFdo3RbKZipEaxjrPVI6d7DOEb6
         EUlwH/Tcr8OdEksmwliyMozcOQlRR9ThS91jFZqLLWlHOMhJ7uNwE3ApWoieP1dYvpZl
         MOoXjRS/X82FFjtPzeubMK/kq9HGQzALVWRiS3o+noO8IiOzDYsIm/aZvxC9iP7dBzcu
         fuL/MwRk6v+lDgN7QwanQEbEq1C/d4/UNgQohF0PSbH4QSHcucyjrXtI7mj1sPxrRr3k
         X7+t7ETkdtAJJi9YfkaKC+ALj0DFdxmkdXW4MADkYLLbvyRs1KeFeTHpHvhiZPUyJTBI
         Yz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5A6wfgt76VJzjNo75lw5SriEfAKDQRHz3NNUpd0+XE=;
        b=k954STm/FfnAgyGZWLYuMXXL0Pbub8UE6oUQGTm8Azwn7UqW6M+3LAwJkmF7J3CLQD
         pzQktT5hYsPj8sEPrP+bmKfnXEUowSe8ndN4jgcEmPW4Q0rGnAWDa/sspYDUS4OFvVoV
         qkwDsebU9hIIPutbRzxq5PutV8owaLyi669v01L+qHykvl9ctWKNmq+mv2vVSr/Qz9jB
         cVvMzp6G2pbOkhSXtIIjD3DAfixKlJsJUg8yTAFPF8Uq/du1NI7kupdz/5Glww1Opha6
         0pe1xi9IHf6CCTM1PFsZbL5pQiAWut8asxBd9qFXcFc4Gq4fB47fZnNh8TUCDTsPaJDg
         J36Q==
X-Gm-Message-State: AOAM532WJiuYgQ/wXroqQwF21I6+uq9NFJLrZsYs9RqUCXySqpGjGooS
        N+EYIg8dZM+atF9lSoUDi+I=
X-Google-Smtp-Source: ABdhPJxHP9lfZ/N6mQHfth5+K7LvdotAw22uq2keOVckzBVKuRFiUgcQwbEihYzxTseUvz0YA9SWTA==
X-Received: by 2002:a4a:e89e:: with SMTP id g30mr21893062ooe.17.1608213832054;
        Thu, 17 Dec 2020 06:03:52 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c8f4:b07a:ec58:bae5? ([2600:1700:e72:80a0:c8f4:b07a:ec58:bae5])
        by smtp.gmail.com with UTF8SMTPSA id n31sm1204501otn.33.2020.12.17.06.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:03:50 -0800 (PST)
Subject: Re: [PATCH v5 1/4] commit: move reverse_commit_list() from
 merge-recursive
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
 <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
 <9052faeabe62d9ba1b9bceae0c0f7b1809bd1b60.1608157683.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ed765c96-2c19-d5b3-3712-bd6f92eb9b75@gmail.com>
Date:   Thu, 17 Dec 2020 09:03:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <9052faeabe62d9ba1b9bceae0c0f7b1809bd1b60.1608157683.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/16/2020 5:27 PM, Elijah Newren via GitGitGadget wrote:
> +struct commit_list *reverse_commit_list(struct commit_list *list)
> +{
> +	struct commit_list *next = NULL, *current, *backup;
> +	for (current = list; current; current = backup) {
> +		backup = current->next;
> +		current->next = next;
> +		next = current;
> +	}
> +	return next;
> +}
> +

I followed the discussion about the variable names in
the earlier thread, and I certainly did not meant to
stir a controversy. I think this approach of deduplicating
but keeping an exact copy is the best solution.

Thanks,
-Stolee
