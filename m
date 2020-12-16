Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30062C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1875233CF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgLPNbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgLPNbF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 08:31:05 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF6C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 05:30:25 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 11so22871718oty.9
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PPZJjJvaZQfIKnff5xJHuNHluNeWw8g1zVdv/epzfwQ=;
        b=qA0jD4a2cLyLDuCMI6eegIHW7fQ1Kg1D+mtAMqqV2hAlsOUjyzWs2a1Hifr1OVVkCI
         jyLjuLg7lHaujxfEXnIDPbRAnxfDIxkMK01KVDo6OSrpaUvXke5Mmx1GVPyp9iBVYDdO
         qdBp9u5H0GF+n70R/zQX1nc58IHGdPomLwTXgcD0lUIkKvEEdnMMDyELVq7vHdQnjvqc
         UyERW54mXViHAe6Jbx2oDSBaG7WeUPyVproQKjMydYRKzvZjTOIoOJSHwMJ9FcaF46Yz
         1ygXRIgSpDdCr3zL4yljIbzMG+SPGiuLpyxxNfbb3LqFkH7luXUWci3V6Y8TZx0uCSYp
         Ad0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPZJjJvaZQfIKnff5xJHuNHluNeWw8g1zVdv/epzfwQ=;
        b=t8qdwqzlRAlC8M81+EItPPf5Tyyi9W0sOcLqe9leJXJjdPHddRkZ5nTt6a5A8ZcGn+
         d3djTaEOTWM6C5KXRDP8N4Wp0qGc1PwUTcPbYg7BtXl2Zo2BInKoI0He42FVI8VG+q1G
         TS0VkDPZPX9WeQlLKhjT8gnpuuQlglnxciikinEgV745SwBCsGSJtJe2EPlJtc96pNeK
         aHLEFJjlI4t+xnPvstJMurEvBk3zMHlDEZ4KwMGmNLyKWvAVlSpDcJU2mPWp4MYZQ6MI
         kdcZa9vH1QkE2n2LHniXo0qcU9LZjLxNbMtqlGRaSoHgtQHJ8WaIx41J4n96W26+dOjF
         LnWQ==
X-Gm-Message-State: AOAM533jGS85zYYL0yYauZZxTPD8wiwv6/3sJKM7LOoUiaY57Yrk5n9m
        rX+GzPS5r7LIJvnv9IFVn8wy2RvsXQOAcA==
X-Google-Smtp-Source: ABdhPJzH2RCHAxdF5TnrwDnEtc0c1PPfi+i7Wzr33oWj4hNjwi5Yfa/kmTtli9v3CQKdgTeOiP206g==
X-Received: by 2002:a05:6830:118b:: with SMTP id u11mr26154582otq.130.1608125424910;
        Wed, 16 Dec 2020 05:30:24 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id i1sm439576ool.43.2020.12.16.05.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 05:30:24 -0800 (PST)
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com>
Date:   Wed, 16 Dec 2020 08:30:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2020 12:53 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In a subsequent commit, we will implement the traditional recursiveness
> that gave merge-recursive its name, namely merging non-unique
> merge-bases to come up with a single virtual merge base.  Copy a few
> helper functions from merge-recursive.c that we will use in the
> implementation.

I'm sure these are copies, but...

> +static struct commit_list *reverse_commit_list(struct commit_list *list)
> +{
> +	struct commit_list *next = NULL, *current, *backup;
> +	for (current = list; current; current = backup) {
> +		backup = current->next;
> +		current->next = next;
> +		next = current;
> +	}

The naming of 'next' seems backwards to me, since it is really
the "previous" node. Using something like 'previous' makes it
clear that you are reversing when you say

	current->next = previous;

Thanks,
-Stolee
