Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427BC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2023A59
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbhAPJSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 04:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbhAPJSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 04:18:10 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB50C061757
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 01:17:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v67so16829642lfa.0
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 01:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ObwSovtsyw/I08PzZ+Y9P1erh4GAHGIC+B5ASkr+5wY=;
        b=dk0vd3+dWZDSv6VLIuJcBHXPlwOyPssIowzWdEgTazNAdxQK736RWuGWA0/piVUwex
         x5fpM86YTGJZbaIlkCGXNMiU8UG7IkjsK7r6GA3kT8cvZlrN6X4+tNyH9VtXEIEmOGMf
         6QOIdnbDOqjxDX5xxKXFEgCOeWbr8FMZqcWTVygR3oHkcy1kS1iG6iV+jWsq/hx4ueJR
         ncQGPTqT77Ze7W1OVncCMoBcDTebiyyj0io20cpe23CMdr+HRo+GoTrMItGa91I52gke
         C9GuIOVvKPwrFD62ZaGMIy8s4OS7pDkA69XDukY91IVDaSLbQS8yRrYHPxcJKVDllirC
         WqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ObwSovtsyw/I08PzZ+Y9P1erh4GAHGIC+B5ASkr+5wY=;
        b=pWI2TY9zcQwUgi0APJuMw+nZO7lBNOTZmg63IcfiSLvq2g7z6A1GXagPGJKia8E7QV
         0lQXvmJy/xNd9+pfsyjXtckiiiLJBcTIbAy1onFrHxk0c7ysr/jKeCrysO5wK2Yiv7A1
         lBj7bZ2lfm0P1vqFHq2QvygfJh1yNcikeEYXptC5s4xXXr69UFjN2dbK1NmqtkkaSJjJ
         maz4rX7F582yVXzQl0wrcgISIIcueB1ZSg4HxTgAZbkoAeFNdKhDjWmcpDT0mRGcFsX1
         66V7SFuLuWM54tplt1qV33GxZoHy8k2VbYCIeCcYi30GL2aXtmRhtqS2CiREzua/QRUp
         YyeQ==
X-Gm-Message-State: AOAM530y3f0t7TUDAqjiwDmR5PgRnL4qQPi8hNXbcrXs6BcvabZEG+GP
        BpLS6PAXW5hBiBPJbqoJw7sBjZTBwzc=
X-Google-Smtp-Source: ABdhPJwGzP2SPOxHtUoijITGx71bp8TO/VywbSv+byRxsfZlnh2kBSAcKMhbb/aIXMTxKh/3oNKCtQ==
X-Received: by 2002:a19:ed0e:: with SMTP id y14mr7422442lfy.467.1610788647786;
        Sat, 16 Jan 2021 01:17:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e25sm1236539lfc.40.2021.01.16.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 01:17:26 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/32] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201221152000.13134-1-sorganov@gmail.com>
        <xmqqmtx9pdqa.fsf@gitster.c.googlers.com>
Date:   Sat, 16 Jan 2021 12:17:25 +0300
In-Reply-To: <xmqqmtx9pdqa.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 15 Jan 2021 23:01:17 -0800")
Message-ID: <871rels0ka.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> These patch series implement new set of options governing diff output
>> of merge commits, all under the umbrella of single
>> --diff-merges=<mode> option.
>
> This latest round hasn't seen much review reactions, so I gave it a
> read-thru with fresh eyes.  I didn't spot anything objectionable, so
> let's start merging it down to 'next'.

Thanks, Junio!

In fact I'm planning to propose a few further improvements on top of
this, and wanted to wait till these patches are settled.

-- Sergey Organov
