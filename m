Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959601F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 15:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdKMP2q (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 10:28:46 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:46347 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbdKMP2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 10:28:45 -0500
Received: by mail-qt0-f173.google.com with SMTP id 1so19958154qtn.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 07:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwAehD7NXw7HnLyYaSeN09u95MNjDHbuXVbkf0JLA5Q=;
        b=gTBXV2vrW51xCk+JKHu+wNUhwBg4JcZnlUpugR59AG5fQ8wM0zAjLYluAwH2ZqyfOr
         viJ1XqjQDJP5UpFZsEgPdZLXUkXdkoNW4udJY5xBQYyurkAWQ7i0tibwB+pmHHPKtfqz
         4E4SqaPTGB5aRYE06+Cpuyjb//wcBKhtfJcA5DHOBNgCADFpS0ubrUDvuZUtltRWdSC8
         TIPccLz7IHDtDg1DswrxqiNqe7hfHwkuIX9vJUGut305L+edc8JdJ1cAgSUAf5kDOwPk
         X6mMdUlZ1ekfDTwn4k8vJVE/ePbTlWj5KzDZXpgPp0Zt9SNglqnypW6b8mKxmjMFxSst
         NpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwAehD7NXw7HnLyYaSeN09u95MNjDHbuXVbkf0JLA5Q=;
        b=ZTyy+c0ZPVkqWWZ7SeLXjdN0y1CM+x9OPg9Hq9gsLXtQCzobGgWhK0lvmdY/1Ly95r
         RdQP/FYF0fvdc4MOjHS2oo5+IwYd1J01wIRC2m3HmzwalZIT+qNGLo94ymsE9SIyw+VM
         2YBsraVUxXct2JVOpUzWzHCMvlNziaTgpRPqqUfyc0wAACEW4guyXZgEgl7o7uKCmXgU
         NsFTEV+DdFLzITykDSUH8OUBhma5bIo9hFNNa6BJt3Epu49q9mhm+JOnDAaL1BXYflri
         0rMMvO76DNennm1kEML56mDbTpP/QGlOABX1dwj1t9tBVVbf8BeQz5x/z/EdoQQn/UuA
         ePIQ==
X-Gm-Message-State: AJaThX6LI/P+aPBpsQShzS1VCswSrFSA82xGOv6aHpGmIy/npeVsVW99
        12Qqn6RWKanOHhgb4eSIRfztnKA4
X-Google-Smtp-Source: AGs4zMb8V1YDTBijZBkESzfhrd0zrtS31fMPF3Nmpgqb/3ZHF0bPMIxxJjNOqUnmscLhgRvZYhBGfA==
X-Received: by 10.237.41.37 with SMTP id s34mr5384364qtd.154.1510586924470;
        Mon, 13 Nov 2017 07:28:44 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id c10sm10785932qtj.29.2017.11.13.07.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 07:28:43 -0800 (PST)
Subject: Re: [PATCH 2/2] fsmonitor: Store fsmonitor bitmap before splitting
 index
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171109195810.30446-1-alexmv@dropbox.com>
 <4ff73be656d5bbf9e2cada6bdec61843da9d1516.1510257457.git.alexmv@dropbox.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9b6679ea-b7e4-b45a-32bb-448cd2e891df@gmail.com>
Date:   Mon, 13 Nov 2017 10:28:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4ff73be656d5bbf9e2cada6bdec61843da9d1516.1510257457.git.alexmv@dropbox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/9/2017 2:58 PM, Alex Vandiver wrote:
> ba1b9caca6 resolved the problem of the fsmonitor data being applied to
> the non-base index when reading; however, a similar problem exists
> when writing the index.  Specifically, writing of the fsmonitor
> extension happens only after the work to split the index has been
> applied -- as such, the information in the index is only for the
> non-"base" index, and thus the extension information contains only
> partial data.
> 
> When saving, compute the ewah bitmap before the index is split, and
> store it in the fsmonitor_dirty field, mirroring the behavior that
> occurred during reading.  fsmonitor_dirty is kept from being leaked by
> being freed when the extension data is written -- which always happens
> precisely once, no matter the split index configuration.
> 
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---

The patch looks like a reasonable fix to make fsmonitor work correctly 
with split index.  I also did manual testing to verify it was working as 
expected.

Thanks for adding this additional test case to ensure we don't have any 
regressions with the interactions between fsmonitor and split-index. 
While the test does correctly fail before the patch and pass after the 
patch, I had a question about the test-dump-fsmonitor lines.

Why do you redirect stdout to stderr and then and perform an "echo" 
afterwards?  I don't understand what benefit that provides.  I removed 
this logic and the test still passes so am confused as to what its 
purpose is.


>   
> +# test that splitting the index dosn't interfere
> +test_expect_success 'splitting the index results in the same state' '
> +	write_integration_script &&
> +	dirty_repo &&
> +	git update-index --fsmonitor  &&
> +	git ls-files -f >expect &&
> +	test-dump-fsmonitor >&2 && echo &&
> +	git update-index --fsmonitor --split-index &&
> +	test-dump-fsmonitor >&2 && echo &&
> +	git ls-files -f >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
