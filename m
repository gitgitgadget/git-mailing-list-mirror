Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A921F4B7
	for <e@80x24.org>; Mon, 19 Aug 2019 12:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfHSMAN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 08:00:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40056 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSMAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 08:00:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id e8so1514507qtp.7
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUwq0fwFNKSgrRRmcIfz7exJs5vmQDCMMjt2AYBhMP4=;
        b=tKNdYZSVQiPfELBE8mZGsujt7t0/zesIV0pM2g1TNP8+KcCf+JYn6TDWH5MNqfdcGy
         Tg/GrahzEwEDKyBzFEYlBKdEzMO4hS/vM4IL5chiFkRczHl3u9XCbqIa9vwoXw0PBb9o
         hq965POnrY3XNlRnsPHP8RsSnvyPA7ywu7owVcbqqJ93zIyOplEpSTestTpK5d+YmNkG
         /IPL2PsWzyIjWHVWG59cwOCxLNMIIom3JM0LNNq3gyFjA9DbAYcEBrFZ31GeiolK0I6T
         6dhs5V067ZIF7IH3VbLK2Zvg0neM4KjOJG+R2ksE0BUUlLtOpMG90ZP9XADECmbM0TfX
         quyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUwq0fwFNKSgrRRmcIfz7exJs5vmQDCMMjt2AYBhMP4=;
        b=UY7+uCNCkj7JEhxpBoR9gP9LEar5Gzs4XOBiItVlu6NHFsAN3nIfyG+kPR1+HfeojQ
         0nZVPvbFt0NkmL9KtoTywO1cJ/wtwqqIzqwRudR/KH1RTaZHBG+cqfxAF16lxJb74Yt0
         RqyM7i+E1JLcxbFokay5SDQuAplw+cTykd5WA5MHVwdm3Ohtodiz/oYzqChYOkTlv8g9
         ENSQDlyN3Tquc6sj5WPw6sGARVEcY23yoOFiaS65qfhJd1aELosTxMeKNo/4z1wVpLs6
         miCy9W8LuEavF7tjfbWDALZ7Vos8/Bfqn9pvgXnKlas2ir0ldzdbDj4+sBc6zxa/x16S
         h6pQ==
X-Gm-Message-State: APjAAAUmwXtmGKyLrAmD3KxxIthOj1gdDL2/k5A0fPFiENm6iqpfETxy
        EpMRRT7BbwnefovHM1RUu9U=
X-Google-Smtp-Source: APXvYqw82UxHxaIQGtBMxOZYUAjBXO8AUnXby/ICRAlZoJBQUaY7RVSKC4mTfE4d+U5yMB1nVkvIwA==
X-Received: by 2002:ac8:6d0c:: with SMTP id o12mr20027542qtt.74.1566216011856;
        Mon, 19 Aug 2019 05:00:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3cc4:beea:5454:ae58? ([2001:4898:a800:1012:edf7:beea:5454:ae58])
        by smtp.gmail.com with ESMTPSA id r4sm6978434qtt.90.2019.08.19.05.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:00:11 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
Date:   Mon, 19 Aug 2019 08:00:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190818182801.7580-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2019 2:27 PM, SZEDER Gábor wrote:
> Line-level log performs a preprocessing step in
> prepare_revision_walk(), during which it filters and rewrites history
> to keep only commits modifying the given line range.  This
> preprocessing causes significant delay before the first commit is
> shown, wastes CPU time when the user asks only for a few commits, and
> does parent rewriting with no way to turn it off.
> 
> This patch series addresses these issues by integrating line-level log
> filtering into the revision walking machinery and making it work
> together with generation number-based topo-ordering (though for now
> only in the case when the user doesn't explicitly asks for parent
> rewriting, which is probably the common case).
> 
> The first two patches are quite straightforward (and arguably somewhat
> unrelated), but the rest deals with history traversal and parent
> rewriting, which I don't usually do, hence the RFC.

Hi Szeder,

Thanks for sending this series! I'm particularly excited about it
because we recently got a bug report from a user in the Windows OS
repo about "git log -L" being very slow. I put it on the backlog [1]
but haven't had time to investigate it myself. After we are done
updating to v2.23.0 [2], I'll have time to test your changes on
the Windows repo. I anticipate your change to provide a massive
boost.

In the meantime, your first three patches look good to me. I'll
dig more into the last two at the same time as I run performance
tests.

Thanks,
-Stolee

[1] https://github.com/microsoft/git/issues/166
[2] https://github.com/microsoft/git/pull/165
