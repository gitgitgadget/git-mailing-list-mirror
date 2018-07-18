Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FAA51F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeGRRuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:50:37 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:40065 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGRRuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:50:37 -0400
Received: by mail-qt0-f170.google.com with SMTP id h4-v6so4691300qtj.7
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v0OkIxyYUulzBqZnFj3SDGZnNaWYBAs1TcrkDNwMo7k=;
        b=E7t+GFXDFfkRcAV6NVqQK/vNSY9fszrMahWvTrE+7J1lVV349uiRk1mPYsbNAbGmcD
         own5S2g30c6+pAp5Fa4aXBsM9Ttl60oXxuwzkwoXoc0kunoo/etZKtGWQQtzr8bNl/oj
         KkvK+aGarBgXsv78EOTwlR7hFkEBmG4WvmAK/PKNf3sXcE7GODXwWPXX4jc4vXpCPWmt
         xPBCuOrvTn/kn5P+aZGXs28spHVxYyJ8AnW5uNhW3yLwAW1FPYB4UAVeh2LjV5NDRCr9
         rGUOq4IA8KE7cxn8GP6/iBo44m+u3+FS3D3hd1OP/1GJdK2wXpQtPAevqPYW/SQEPhtW
         zLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v0OkIxyYUulzBqZnFj3SDGZnNaWYBAs1TcrkDNwMo7k=;
        b=e+Y67PlutS9Wl+2ATHZVn+MzGO3j5xF9GPPuuaWkBYgoRUZmeZ3MDe1CGD4ugoEhhu
         OsK10NCFjSSJtOzFm2lRi3ro3x4DnRDCUtrDERSJ/3JCrZmLiFW1Z8jPzYL8/crgP9H5
         3Op3b6/CufRYSvVTKXB7wqhp/rNJeam04CIW+3DyNwK2KUJ7KTq6zb6xnorIncTim1Gz
         bZsRpuaJF9dnA2GT+DKXlFVmEHGlYLGyM00P9NvJwEsxZlLMzQJ7GBRJvDJS9j787Tey
         oY+qoYgi8EIV+UxD8UG1a6fRXhLOsnHpK92h9Qi0Juditi/chPODcsp3wsU304AQEO76
         hnVA==
X-Gm-Message-State: AOUpUlGbevoLC6Q2Zkciezcsm2UjBPoMH4ph2dzF4zxvR41D3nt/33lL
        LukYeeXsqIBAEptizm6ygvMgCMrcAMM=
X-Google-Smtp-Source: AAOMgpc87gIuLkxqEV6b78wdsUyRsioCGqUbZrHQ27+qgLj0GJDY0v/WlnHdlZ491R7l4PtbZPHcVg==
X-Received: by 2002:a0c:e505:: with SMTP id l5-v6mr7350448qvm.128.1531933905550;
        Wed, 18 Jul 2018 10:11:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d070:73be:3735:cf07? ([2001:4898:8010:0:b9a6:73be:3735:cf07])
        by smtp.gmail.com with ESMTPSA id y142-v6sm3553665qka.5.2018.07.18.10.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:11:44 -0700 (PDT)
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>
References: <pull.10.git.gitgitgadget@gmail.com>
 <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
 <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
 <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com>
 <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet>
 <CACsJy8AbT3=wzKecGqvj8ibHmquU=NfP872f1cAM-VFOLSLSGQ@mail.gmail.com>
 <xmqqfu0glbqm.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <afc090ea-840d-6c27-d6d0-2202914f1ccf@gmail.com>
Date:   Wed, 18 Jul 2018 13:11:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu0glbqm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2018 1:01 PM, Junio C Hamano wrote:
> No, fixing a tool that throws such a harder-to-read patch series in
> reader's mailbox is *not* something I'd spend my primary focus on,
> especially when many contributors are perfectly capable of sending
> reasonably formatted series without using such a tool under
> development.
>
> That won't stop those who want to improve the tool.  But I'd wish
> those who want to make Git better spend their time on making Git,
> over making GitGitGadget, better.

I appreciate the feedback in how this series caused reviewer pain. 
Hopefully this date issue is now resolved. Any further feedback is welcome.

I'm choosing to use and contribute to GitGitGadget not because I'm 
incapable of sending series myself, but because I _have_ had difficulty. 
Using the email submissions creates a friction that I'm willing to 
overcome, but we are probably missing out on contributors who are not 
willing to push through that friction. Perhaps having another way for 
new contributors to feel welcome is an indirect way to make Git better.

Thanks,

-Stolee

