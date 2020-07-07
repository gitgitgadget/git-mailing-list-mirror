Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9FBC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4264A206E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoG40OXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGNYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgGGNYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 09:24:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF494C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 06:24:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 95so23656205otw.10
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KrXMbf9RNTfRD+tpnu6GXAx8WK9LRHL3qKuV3iVQSSU=;
        b=RoG40OXWPIpWrqf1rZ+mQbGTrPI9xcYcuxJzAk5NgysSEtOMjJxn8czgoSspGrkfhb
         hifxZVrYc7B2jv8ZnI0La9FntxhGh1PsRD8UMI6ienO94VncY18diu/aQhJwV7c55lS/
         2LxLaniuK2Tk4oeZ+AbIS11gUn3nIO6Kc0QtOM7cGHEks9eDaEX7xywvoja+pGU2Fi5p
         qXxEFH0XnKByk5jXsKVPlckZUAEAzJGhGTm82HJZA6EB/aOxNeQusPdDHzCZiW4Ut5tB
         2Ay2Tchj1ltpEVRNpL4THbpqsnZPYHmxx8NE7Qt0YMCLrcIEB2UwpWhvvTVeAU/CVLWs
         7LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KrXMbf9RNTfRD+tpnu6GXAx8WK9LRHL3qKuV3iVQSSU=;
        b=lAhDsXZduquIlqu8gNUSn5ATDMBQJ3h6AFZ+oPWQU5+9YZwV2NsuyUo2FNcvVzJIjv
         1kpsRA62mVbYTnW8rXa7Lx6Xv7SmLxv1Q4tpMI6gP9EDd2AS9+ZhbcmtoYG1aQJsW8Cn
         +Xo9esKJouSbPrkzKLkEq/Hbib55Hc0MWKIV7MIW3Ff03VmYg/jeUReGfPqsILgxg7kY
         190QiP9rVpc9SW0KtWX2y8/Lv1E1vB3zgkitKt5PwuUiwSZAEXkUXrrFak0PgXufbxgK
         /dSO9bmI49D+/J8HMgqwG8Zd8cd7Fa/ptyz/aQpCMHpUKHEl1cReyzQiV8iHxcBD5gqj
         a2yQ==
X-Gm-Message-State: AOAM532sthgH51kIxmbKyvz+MfFIV8LUcz1N3JRV10OMXsyVf7ZPPRKb
        T3goHZ7AihOq/JPD5KM+cLc=
X-Google-Smtp-Source: ABdhPJy9o/rR1Akzpl2DvPEeg84nqUYhBTAktAS04DsbZHNDkqlugv/daVYZp3vl7zZSxC9hx5Zedw==
X-Received: by 2002:a9d:6b95:: with SMTP id b21mr24319003otq.365.1594128254905;
        Tue, 07 Jul 2020 06:24:14 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p18sm5747947oto.11.2020.07.07.06.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 06:24:13 -0700 (PDT)
Subject: Re: [PATCH] experimental: default to fetch.writeCommitGraph=false
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200707062039.GC784740@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b7435e3-95fc-8085-9e26-6d451809faa8@gmail.com>
Date:   Tue, 7 Jul 2020 09:24:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200707062039.GC784740@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/7/2020 2:20 AM, Jonathan Nieder wrote:
> The fetch.writeCommitGraph feature makes fetches write out a commit
> graph file for the newly downloaded pack on fetch.  This improves the
> performance of various commands that would perform a revision walk and
> eventually ought to be the default for everyone.  To prepare for that
> future, it's enabled by default for users that set
> feature.experimental=true to experience such future defaults.
> 
> Alas, for --unshallow fetches from a shallow clone it runs into a
> snag: by the time Git has fetched the new objects and is writing a
> commit graph, it has performed a revision walk and r->parsed_objects
> contains information about the shallow boundary from *before* the
> fetch.  The commit graph writing code is careful to avoid writing a
> commit graph file in shallow repositories, but the new state is not
> shallow, and the result is that from that point on, commands like "git
> log" make use of a newly written commit graph file representing a
> fictional history with the old shallow boundary.
> 
> We could fix this by making the commit graph writing code more careful
> to avoid writing a commit graph that could have used any grafts or
> shallow state, but it is possible that there are other pieces of
> mutated state that fetch's commit graph writing code may be relying
> on.  So disable it in the feature.experimental configuration.
> 
> Google developers have been running in this configuration (by setting
> fetch.writeCommitGraph=false in the system config) to work around this
> bug since it was discovered in April.  Once the fix lands, we'll
> enable fetch.writeCommitGraph=true again to give it some early testing
> before rolling out to a wider audience.
> 
> In other words:
> 
> - this patch only affects behavior with feature.experimental=true
> 
> - it makes feature.experimental match the configuration Google has
>   been using for the last few months, meaning it would leave users in
>   a better tested state than without it
> 
> - this should improve testing for other features guarded by
>   feature.experimental, by making feature.experimental safer to use
> 
> Reported-by: Jay Conrod <jayconrod@google.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> I realize this is late to send.  That said, as described above, I
> think it's a good way to buy time by minimizing user exposure to
> fetch.writeCommitGraph=true until a fix for it is well cooked.

While it would certainly be better to fix the commit_graph_compatible()
method, I understand that that is a more complicated problem.

> In other words, I'd like to see this patch in Git 2.28-rc0.

This patch is 100% correct.

Normally, I would say "this is experimental, and a user can always
disable fetch.writeCommitGraph manually if they are running into this."
This is especially true because unshallowing a repo is (probably)
a rare operation. At least, I expect that very few users actually do
it, and those who do are expert users.

But, it is best to reduce user pain, even in rare cases like this.

Further, I hope to submit new maintenance tasks soon which can
replace fetch.writeCommitGraph.

Thanks,
-Stolee
