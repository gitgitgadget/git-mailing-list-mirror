Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8930D1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfAHSEY (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:04:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35979 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbfAHSEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:04:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2068579pgm.3
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfnLOinTjf90R6WYi/4YbmHaptB8piYN+Tjdv89lc2M=;
        b=vjtAHk1DFJ9TD1ZIXQcpTPHZth/ygGp9WxZQhy/chgixPubU6WpZrmKhOL1cytz+/v
         Idd7dpb1MSHfdJ6WM2f6p188wGLEEHznSmrqlLEXBVYerRr/E+l/1sCXD9YvsFu8+uOx
         YUEzwUcztI0y+D2e/aQZazkVC6WNQx4Fm8Kt0qVCEo/lm7qZO+cu7SH5ZSwVU5CnkD+d
         zaj8hzxq8/BjJhS7E7j4c4ptvFSmD6vnMEGtou0J1RESkJKuADFAKXUJNv37OsEClXHg
         XC3seX7d7TkJkJbp6/igXmQRMa1HJI3505MJ91iQZZunznwzmdzEbkxCFi5AJMDLyd01
         ufWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfnLOinTjf90R6WYi/4YbmHaptB8piYN+Tjdv89lc2M=;
        b=Qjwrni/hcz0ExlxPY5ocqfRJm05lLsHMzPzCyNt1jdBodAE8K4ATwDziX2poZJheiY
         /nokglB4o9GT456SclF5wvWXkyddvBYrPiz883OYrKnp+uDJ1D8dAy6l763sz1CA2OyC
         tFNGmLQrkx5PSS7VB0xJ/J1TX/2gdfiY5Mv6md+IWcJ8/cx7qJP3x8JpwiWVoWf3Ivtt
         doA5jBYW8gKgFuexmyVio6ZXOOob8xeYot1wJYwwqSeQYkmil7Ugbe6SB6UoafaCvAD+
         8nuHRHtmYVvUeXGfN7Oup5o5T2RYOr+6SkNOdo5qwNIjpfrsLJHmeWcWlQHhZpU1BfC3
         1seQ==
X-Gm-Message-State: AJcUukc2q6+zW9nRRRi2EbjlNZZMzFyGObCglHwn/AY3R2ZYsK1jSE+5
        M86aaBZWvMcDeqiYeBiBOmW6IA==
X-Google-Smtp-Source: ALg8bN7qG7vBQBtkffi6vBz2VnWNmCfaBtY2S5efdPJkQ3ZtexZMhqncy1uoURC+vVmxG9alAuQJ7g==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr2335709pga.355.1546970662806;
        Tue, 08 Jan 2019 10:04:22 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id c7sm138384723pfh.18.2019.01.08.10.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:04:22 -0800 (PST)
Date:   Tue, 8 Jan 2019 13:04:18 -0500
From:   Barret Rhoden <brho@google.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
Message-ID: <20190108130418.052c52d5@gnomeregan.cam.corp.google.com>
In-Reply-To: <20190108114106.5cf57e67@gnomeregan.cam.corp.google.com>
References: <20190107213013.231514-1-brho@google.com>
        <8736q3qon0.fsf@evledraar.gmail.com>
        <20190108114106.5cf57e67@gnomeregan.cam.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-08 at 11:41 Barret Rhoden <brho@google.com> wrote:
> Would you be OK with
> also changing fsck to take a committish instead of a full SHA-1?

Actually, in retrospect, I can keep the unabbreviated SHA-1 for the
file inputs and use get_oid_committish() for the one-off --skip-rev=
cases.

Thanks,

Barret

