Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB47C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 23:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DDF61029
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 23:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFOAAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 20:00:47 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:41865 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOAAq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 20:00:46 -0400
Received: by mail-pj1-f41.google.com with SMTP id mj8-20020a17090b3688b029016ee34fc1b3so857635pjb.0
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JP9rhdVfhEBeaaLBY03n8jKibLD4vWRVqIFi0L751Xs=;
        b=wPw0mnMmuVvqzDT02TSO/1dmd72Jw56/LDHykLnRuSd2pkhIGuLzmWNjxli7wBbTWr
         nmzOBqYnv+BP8H30lKrAvXwM6575t8O1Pq7UzMS+PepWUi0WWj0NNv59XT6RVKj/5Imb
         QdfGgS/jxdY3HdhAXSuBHzObxdAeT+ImUd9s/icvTOu6XQZ9Z+WO1sv9EKNgbHaGOhIN
         D3t9ySShH0PL3ifi5HPc8c9o/y3s7YbxP3ZvqE1uy0hlab33JSNuNIBlAJPD2KR5jDTA
         ACgP2TXQVY62oZMK/S4l3/qlRjK0Mru5UYMSK/O1+TU6mpq4LqG7kAIfRnqmAKldytzu
         Z0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JP9rhdVfhEBeaaLBY03n8jKibLD4vWRVqIFi0L751Xs=;
        b=rKfyM6wcYNHeY7gAYNdE0FaCbTPlFxhXv7YoG2AWVSdXjXpEOwd9izRgmyakKTlkmc
         uSp+akwN9hRdBV0gecKINFypUf9m1hBZXu+gzBmx7qdgNnEpqatGr+VMpsoXSxf1ydk6
         R2Qd1/Q1kRFePH++nWJ0tF/9ovvvgT86kWbVGRoQMv9FmLaAxTyubj41T5iuhFXHpGd5
         lwcMY6pyKXqaAnQ8pmOjnUWxTMrk4ITZeEinfWE3sGHSzKVK2Gh2FNIRmitkL6oRdLLm
         wCxJXYmx6Nl+XEs0a7KgrbQZwqNX3OfIcHljRIbqB6P1z3BKntKZMHWWsku9wZYAJO6K
         rVkg==
X-Gm-Message-State: AOAM533Ynb/s+6o18/j3R+NnMCT4Bs5Bedjit7tlgsYzsxRkSduda1kG
        oTei1YjPEeRRg3zd+1IYyOk7kuOJ1/3IsQ==
X-Google-Smtp-Source: ABdhPJyQDsWaezKWmGwd1cFd3SMaulwJemH1hMRQr5rIWJpKaGUUNGmx4KqrRGpGxWjB30ltsIbpdA==
X-Received: by 2002:a17:902:7c94:b029:fc:5e8b:e645 with SMTP id y20-20020a1709027c94b02900fc5e8be645mr1510070pll.18.1623715046788;
        Mon, 14 Jun 2021 16:57:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:87fc:fefd:1365:fa14])
        by smtp.gmail.com with ESMTPSA id s9sm13683349pfm.120.2021.06.14.16.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 16:57:25 -0700 (PDT)
Date:   Mon, 14 Jun 2021 16:57:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 04/30] gc: use hook library for pre-auto-gc hook
Message-ID: <YMfs4Zr4Q22W5dnB@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-04.30-da2763192ae-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-04.30-da2763192ae-20210614T101920Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 12:32:53PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Using the hook.h library instead of the run-command.h library to run
> pre-auto-gc means that those hooks can be set up in config files, as
> well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

I think all the commit messages in "convert x to hook library" commits I
wrote extol the virtues of config-based hooks. Since that's not part of
your reroll, I expect we should change the commit messages too.

 - Emily
