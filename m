Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B2C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF91823BC7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgLJBx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgLJBxU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 20:53:20 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72484C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 17:52:40 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id w79so3446264qkb.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 17:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zRQqoPk4sgx8iUdLyFe5oesRZRfVGUxhj4XbWQtO9Bc=;
        b=V0t7j8QNIOH/JPRrvNnrpawreFcuU7b+yXjWMEkjjkne/QSbCqDyJ4ZoqHRDdHRN+J
         GwCnKnO3bLXYMzOp+kmnOSTkOGj1Y3NJpN7+q8pqjUyxz8UutVM7Q4XdOkwzj0spMw/U
         p01kvPceTdUqN1t+6fu0yTreRlj6jYloBwrQf0p0je2xPXX8ke1Dxn7y43tlsPFBtjCW
         4/IyBtANynqI+rS7f85o0DjJoQbNDpxRY66/lrA6gXd3pCHB0OLNiUU9CbMVeeySl5Zr
         jQ4eYe6KPxL4SxFfLak6yFF68oyCbhp+MxhIzBP2TnZboUxuzcJDamXtBazCU9zOCTn8
         lKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zRQqoPk4sgx8iUdLyFe5oesRZRfVGUxhj4XbWQtO9Bc=;
        b=d39xuL4BM8sjrrYKzu0/bwLnr+E2Oy7SCnEKZy4KEoCJ6jYo1Npmt3uh2usICNnPXQ
         yrbv7ivgHTg491Peu7l+FnbPRrXRc0OHvl7KyYWTulaS0rONNfocRCfdqLS6Osf+rPiC
         WaLI5eFEFp/ujf9Y32P3ZIjDgIAK0UKtxrlIatdeWo6wKZbUI2N1fhDFeC8gZoFuDMSy
         p1m+I0deKRxwortoZwg6BGc5rGM8wXfoTQVvHO/B3gUZmFMCXW88Q+wFFlQnEaMB7qxV
         iMd4EwiKbmNQBtwGmj3JpQKjBkZVKNuVCSyI4GBBU9uSkkxx7H6w/YlgvyaEZvBtDfk4
         vXtg==
X-Gm-Message-State: AOAM533xDFtMssgkOdjKZr/eKWYG3R1JdOxe9tiwO8Ccq7ilFdNCDjMh
        w88f8Q2yycpUCLXaMS8W7xU=
X-Google-Smtp-Source: ABdhPJwkit/BxdP2pKe11jyE+D7aVPulU0eDdjgF/ixMx5KEYoGDJUjQ/fMh7gd1aGxQ7slPVwkbZw==
X-Received: by 2002:a37:e40a:: with SMTP id y10mr6399701qkf.144.1607565159627;
        Wed, 09 Dec 2020 17:52:39 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:49a5:bddc:9642:d852? ([2600:1700:e72:80a0:49a5:bddc:9642:d852])
        by smtp.gmail.com with UTF8SMTPSA id g18sm2347820qtv.79.2020.12.09.17.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 17:52:38 -0800 (PST)
Subject: Re: [PATCH v4 5/8] maintenance: add start/stop subcommands
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
 <20201209185114.GN36751@google.com> <20201209191616.GO36751@google.com>
 <xmqqtusuzffv.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <995da636-94bc-378b-83d0-ecce9d802b81@gmail.com>
Date:   Wed, 9 Dec 2020 20:52:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqtusuzffv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 7:13 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>>  	# start registers the repo
>> -	git config --get --global maintenance.repo "$(pwd)" &&
>> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> 
> The rewrite makes it better than the original, but I wonder why the
> original did not do a more obvious

maintenance.repo is a multi-valued config setting, so it is possible
that there are multiple existing values. Hence the reason for needing
the value filter.

Thanks,
-Stolee
