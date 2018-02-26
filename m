Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589AC1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 22:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeBZWda (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 17:33:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37572 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeBZWd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 17:33:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id 139so7075973wmn.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 14:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N2cNZqTqh6WfAKh5rKEoO3/qiL1af4F6cQeqESy8zjk=;
        b=VzGJ9C+yfxnbF538GaCkn5kU8wV8hfmXSnoSTF+rzSTivmfeO9LzfjD/7wtFCUePyc
         kr1UaWVj4afwotOVSIwXxIX8jMjcQH5cLGhlMYP0gCdGhjkhj+89a2QUxzgcqR5iloS4
         pylR2a9JrrsKgaF41eZQ7PVDh3gAXwio64f6X+CiRu0JU+DPJqrAO63dshQzkSy+IYsi
         nu0z2m9B4PMm8iHoZBg1Bc2ELpt4cfH0iND0e7CqhNUL3mTVc8PtplMRKDGzCi6z+v89
         c/nA+1XNle5lKpHpDEpGsknfMXGOH7r2L7tR5Rf+xAThuKuFI7QnRvJbN1PvS2OqYYE/
         7IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N2cNZqTqh6WfAKh5rKEoO3/qiL1af4F6cQeqESy8zjk=;
        b=kZZdZyywLMxDadkJZi0eiekbBPDBTRgkI2VNiEmW5L23opM1MlcOiiYFiJsVHgP1wK
         NlqdOsxyWQ9MhHksqATu3Crl7/UWfFcPqs7IS4TgPX1odoWRJA0HzPXC2/ag4c4Dsu5o
         b16ZsqvY633JS8YTzbegGHTC33vGyAqptcEQbAP8Hc1ZuK3z/9apbjA7OgPHTARH6WHl
         aVpmTChd0b2J9SAoyAZ3Se4mhxTBxqdHG3kdOtcW9s9mXFErK8Ww0Kh01IVvleCuWTUc
         sohm/qu80MV2cEI8/aZkzWY8qF6YMhCUSiNme22pSIwQGy1LDmQ/lQlGxzog6MzZ+Qn9
         69AQ==
X-Gm-Message-State: APf1xPAdj4kJXDq2hjXff9fjggoXy0jw6e2mhhFqAhkijQm95ucv4u07
        +geWC5kkZba8zEKAxMnUnhw=
X-Google-Smtp-Source: AG47ELsUjuCpWQtvvMYQ9RpHx+vYPgsCjDqT8oGe1tQM/ofejFU4VOG5W5iOfrTa5ugXf/ldU3WhtQ==
X-Received: by 10.28.178.81 with SMTP id b78mr10248884wmf.78.1519684407548;
        Mon, 26 Feb 2018 14:33:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n64sm9500249wmd.11.2018.02.26.14.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 14:33:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-14-bmwill@google.com>
        <20180222094831.GB12442@sigill.intra.peff.net>
        <20180223004514.GP185096@google.com>
        <20180224040149.GA16743@sigill.intra.peff.net>
Date:   Mon, 26 Feb 2018 14:33:26 -0800
In-Reply-To: <20180224040149.GA16743@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 23 Feb 2018 23:01:49 -0500")
Message-ID: <xmqqk1uzqt3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I actually wonder if we should just specify that the patterns must
> _always_ be fully-qualified, but may end with a single "/*" to iterate
> over wildcards. Or even simpler, that "refs/heads/foo" would find that
> ref itself, and anything under it.
>
> That drops any question about how wildcards work (e.g., does "refs/foo*"
> work to find "refs/foobar"?).

Sounds quite sensible to me.

