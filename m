Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CABC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F4B21927
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSfY7fFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgGNELw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNELw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:11:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC66C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:11:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t15so908252pjq.5
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hThMzR4dPMJIFoEy1vv0n1ICTTk76oZ8bFhe4hzIu2o=;
        b=WSfY7fFviXmRFWVZKw5uT7t9XwN4AE57V86ilhc7rmiMxrKwjgNUq5Yv6PI70pXjvA
         oBu1Y1Km1A82vSOnSJZiczn0CW70lg/LA11j/2gg8tXfBTg8kHIHkGJy2Hl1Y17Fuad8
         ibyrTjFtKqMVljaybgCE0PVNjpmziOmrvyQzBTi5m+PnjSsxUpchlIOxDIJo7tSkJ53v
         xObEY9QLIbf/Wp9iY+98n4vtEdQjVfzZXqZKIcC0ETF9zDrW9Vi0pbMcMXNtbeQQ5ncE
         xrU34dMPQa7zYoEsPsesxrqU7tyRoO57UbXFI7mGxZuNaObBPCoEX5ACxmSLEEe5aO9z
         fZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hThMzR4dPMJIFoEy1vv0n1ICTTk76oZ8bFhe4hzIu2o=;
        b=iRTdiQvRsnlaNxQb9IaudDOM+5bdFnV2SGQ2UvkrKhTN3UJI3hH7rVOjvtYJ0icMwN
         Zp07KG5yw6OGS1MuNFlAWxumcgz19DyJsbyWEzEBTXMOkp2FyCSo2vrYKfdePi5KG36x
         8edvnnKo4+Y//IMvRn43NvMaRPQE58hlWLz1fQkRuVq/fpKEGgYN2wYJftjARzwg0a0I
         3LbgsAVZle/ydP63Yl/2vpkI46BWBM3zbqrqWGqyTl2BNY9KhV3/GBB+xJNRx6s8qVOi
         UX3fNXe35yz6kWqmiHAwyddH8Ym6ohe1ADyAbmKNkI+80Jmim+duxkQ09MypK2+q5kfi
         +EfA==
X-Gm-Message-State: AOAM5303AMudJdNf1tmhYauGwrZy7jRcVjmwR9XbtOSoD4KstkLgylcE
        KdA9CilcQJdKasY9STfhpr8=
X-Google-Smtp-Source: ABdhPJyCTUwlBgx/mwMVsdfEN1yFFof1oDd3NZd+iuKaxqtsk2cKx3BkeYD0rIz1nbu1bm/7e1GKbg==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr2546816pjb.186.1594699911616;
        Mon, 13 Jul 2020 21:11:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 7sm14092231pgh.80.2020.07.13.21.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 21:11:50 -0700 (PDT)
Date:   Mon, 13 Jul 2020 21:11:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200714041148.GB2208896@google.com>
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 12.07.20 um 22:52 schrieb Junio C Hamano:

>> We could teach "git fetch" a new "--write-fetch-head" option and
>> teach "git pull" to pass it when calling "git fetch".  It is very
>> plausible that some folks rely on "git fetch" to leave FETCH_HEAD
>> without being told, so the option must default to on for a few
>> development cycles before we flip the default to off,
>
> Nah, really??? It's one of the benefits of git-fetch that it writes
> FETCH_HEAD and the primary reason in many cases where I use the command!
> So, either I don't care that FETCH_HEAD is written, or I do use it. IMO,
> not wanting to write FETCH_HEAD is the odd case and would need a
> configuration tweak, not the other way round.

Speaking for myself as a user, I also rely on (the first line of)
FETCH_HEAD being written so that I can run commands like "git log
FETCH_HEAD".  What I don't rely on is the massive amounts of data that
may get written after that first line.

Thanks,
Jonathan
