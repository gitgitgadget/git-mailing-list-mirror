Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB7BC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9059D20692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgJDVSn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgAHNhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:37:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37659 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHNhC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 08:37:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so2774104qtk.4
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 05:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9iGxcOnvXtLwwajs3o+9ZsH3WjJSOQ4UFWjEiPrrWg=;
        b=HgJDVSn2NQRsQFwtLFzbOeD5dC8k9DemqKZtTa3p7La8G/AssrrnBs4kjyvPzddjJc
         +fF39dXlekNTRL8/ly9fqNTOYQ8myMYv4mOzhwM5NuXDOwUT2A0enyy2KlzaEGmmQc7b
         fnKi2GhDlvtBzwxiIkDQs5CbJAwoKhSLuhQ4GS/q8yG7g20FxHkOBqquk0gjbWMBzolQ
         nVLImx0liZZHHQunA354V4pM361t9KPCktkTQkxrItHvjvj9E8AeXqbAvaCD97AKjHh/
         TPIdnypF2UhmrNWfYG7C9vh8QTIt7sZO6IvUdry8YfG+gFGrwS8QG01c6avmJz3HXAZj
         oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9iGxcOnvXtLwwajs3o+9ZsH3WjJSOQ4UFWjEiPrrWg=;
        b=NuuMsNNtRQIqn1EzNGaGW9WXuRz5wUNK4M9C95Fz5Vncgnr0ioTCBWs3jWLw57aS86
         E16cBsPZ3yQgiMXuVUtdWsi6qLMai+uJ6aYCOIVCfw2JA5H89lZKgM5pjLKOI3ssMOTo
         zn46idNYI9QXhhNT3god6UvjFxKUTle1bfKyQ/ylgX/IOtRoxt2uiuiTbiMedQrR15yI
         2+ZH+KWExEOLapSE2dEiu7sXgDIdMrxiA/v47JbCj9kpSuTbU34qb8hYrm+NjU5UJwGG
         J56PAnsGC5MydtX2OvG33hLB0sGtVy5YoGZTGWUs3S0cvW4tnVXFsO+Wj/te5nQ4ibQ2
         GffQ==
X-Gm-Message-State: APjAAAXVb3i25oiixsch7YQVa0fygassepQ40p7q7AbY9qDmT4FuaM8u
        IeRyM9nICAxAdWqHE1pdI8c=
X-Google-Smtp-Source: APXvYqwo5PMUBPKSbiqpAOA1XwnVR9iyN5RLgbfdspWvzkJe/ISuWk4W2oWw38mYpkvFWPkF7h3gEA==
X-Received: by 2002:aed:3c12:: with SMTP id t18mr3705226qte.140.1578490621020;
        Wed, 08 Jan 2020 05:37:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3d10:d3f7:2db7:a1e2? ([2001:4898:a800:1010:ee45:d3f7:2db7:a1e2])
        by smtp.gmail.com with ESMTPSA id o33sm1598765qta.27.2020.01.08.05.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 05:37:00 -0800 (PST)
Subject: Re: [PATCH 0/1] Preserve topological ordering after merges
To:     Sergey Rudyshin <540555@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2001071308290.46@tvgsbejvaqbjf.bet>
 <fa570dcf-b19b-f658-456e-b4174d767ba1@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <222602fc-68a9-0671-e6b9-1aa727d830ea@gmail.com>
Date:   Wed, 8 Jan 2020 08:37:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <fa570dcf-b19b-f658-456e-b4174d767ba1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2020 7:50 AM, Sergey Rudyshin wrote:
> let me explain in more detail why I thought it would make sense to stop using "--topo-order".
> in case if a user specifies a single commit, like this
> git rev-list E
> with a new algorithm the options "--date-order", "--author-date-order", "--topo-order" do not change the ordering. Because there is only one way to sort any git graph with a single tip.

This is false, unless your history is always linear (no merge commits).

> in case if a user specifies multiple tips, like this
> git rev-list --topo-order C B ^A
> current version of git displays commits ordered by commit timestamp
> which does not seem like a topological ordering.

Are you talking about which of C and B are shown first? They are shown in an order based on your input. If C and B are independent (neither can reach the other), then they will swap order if you write "git rev-list --topo-order B C ^A".

> so I decided to change the documentation so that "--topo-order" and "--date-order" be the same. And since "--topo-order" does not add anything new decided to deprecate it.

Based on this sentence, it is clear that you do not understand the difference between --topo-order and --date-order. Please take time to examine the output difference for the Git repo with the following commands:

	git log --oneline --graph --topo-order
	git log --oneline --graph --date-order

> Regarding the failed test
> I'll try to find the reason but what puzzles me is why those tests (t4202, t4215 and t6012) succeeded on all other platforms (linux32, osx-clang, windows, ...) and only failed on linux-gcc.
> In my machine those tests do not fail either (gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609)

Try running the tests with GIT_TEST_COMMIT_GRAPH=1.

-Stolee
 

