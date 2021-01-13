Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D579C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2F923134
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbhAMAxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 19:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbhAMAxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 19:53:07 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFADC061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 16:52:27 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d14so187695qkc.13
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 16:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6vhqJCz+OqXEUl8PnkraMatyfcDLMvORcjUl1jkHF4k=;
        b=V8pNCz8eKfKvuTzjPjehmG2mah/DKFaVCf8g5tpz8KSnaaTHPZ1Qiyd4TQFgsWCja/
         rurlSPxyDSxo20yEpGYYRmC2yYBKCki2A9dS0Q42KxjYq5Q5sGoTupCw2nwr9dHI6EaM
         WEG4BHk6vblhuMxFGIb/sofgRmmFtFH/XpNddYrIRL/AVSKH5qW75NscXh06ISsZIp7X
         gBu3f51Bg9Gk4Uq2NTghDPhBN58AVc/1qdRGCp2fAqlZzEP4apf/8bIiqa5nE3vsbIOb
         UlKh/8I4qD5/TYsyU7t1DqzzQQAjYEN/JFinjsDLOAHwP1JwtCF07FhW6/CFRudzNOq4
         Bc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6vhqJCz+OqXEUl8PnkraMatyfcDLMvORcjUl1jkHF4k=;
        b=eGr4JoEsHdG+82Ct0oAINrvufXLQ9rJsQvkE+fcLAIAPqWJrvgot22CSoRHT4VsTZd
         zr+3qLhk3pSkIEL1e1jmH0126/1KsgOp0zvaG7Tm6iDIUx6EE2nYt9tWYOBdW8L6Izdd
         bttS0Yyj0RloyydLJGYkXqMcbpvfEqb5ndpi2lnyDACt9VitB9Jw2PLZQkFmix55vPPG
         TvFtrakpk/5rAzN4PI1gODCcf6RCFbsyWiZ4HtfXv3/4uxmgGoI5C9br8PYkTXAkwtVo
         pbOvySUQmlOy88GYSwzqMJ7Z9HqLxigYUdKn60UANF3duBcrs0Z6XWF4mCs4/4CFZ3ve
         jTeg==
X-Gm-Message-State: AOAM531q8f+pKcEqqxYyNlM+lfUE2dZCxqLDxFIc5MjuTjbV8n4jm9Tg
        8jrzMn1TD4K/mKgq2KXsM/LgHw==
X-Google-Smtp-Source: ABdhPJws9gCC1VOny+jvK6ZiNg2Rh9ZtBcOj1cHpbUS2aJOdb4sx9I0DJiCohaqako7W4CI6xk+t4Q==
X-Received: by 2002:a37:9b95:: with SMTP id d143mr2353491qke.215.1610499146310;
        Tue, 12 Jan 2021 16:52:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id l11sm183216qtn.83.2021.01.12.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 16:52:25 -0800 (PST)
Date:   Tue, 12 Jan 2021 19:52:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/5ER+ml/MhDjROA@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <xmqqk0shznvf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0shznvf.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:23:00PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This is the first of two series to introduce an on-disk alternative to the
> > reverse index which is currently generated once per-process and stored in
> > memory.
>
> Queued; seems to be killed on Windows but otherwise looking good.

Thanks.

>   https://github.com/git/git/runs/1691849288?check_suite_focus=true#step:6:164

I will look into those failures. It looks like these are all due to
running 'git index-pack' when the '*.idx' file already exists (resulting
in Windows being unable to write over the file).

Did you want to queue these two topics separately? It looks like you
picked them up in 'seen' as one big topic in a8f367dae2 (Merge branch
'tb/pack-revindex-api' into jch, 2021-01-12), but I thought you may want
to pick parts one and two up separately to allow them to progress
independently of one another.

In either case, I am planning on sending a new version of the first
series tomorrow to address Peff's feedback.

> Thanks.

Thanks,
Taylor
