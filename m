Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292FA1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeBVApM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:45:12 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34325 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBVApL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:45:11 -0500
Received: by mail-pl0-f65.google.com with SMTP id u13so1947386plq.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XasXWnPx/D/iPNP/wHyaEYOgQuc6zw/hpNHad5ZQTo=;
        b=Plf7u0lfBh9B7aT3uP3UmkodScbNCgcPIHfi/pCeti0PXACpsTkrCs/S5zCChQ0RT8
         OyFdit5ipulcZMBkrl0aLLcJh9A/mBsegZMGeGpDFg9b/y9udD3XXSUS3/HGHywhNDDh
         Qrbd+EElKnHXp2Nya5QyOQQgsW2EMn4MyNk9evtv9ADJgil7DO3rMVyNlfNKLGt2cDpX
         kyH4F0PXr0uXDPHDdEY74yo//8HP7jawoO2VGbRQtDZw+zEal961Kj1gCOjyfqDgtcDA
         VQKdFVnzFH40hufEO5Dh2yHOXszJzuckAdxNHvOsb46/M5n8yC77Otwecila6Tu/2x1o
         sayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XasXWnPx/D/iPNP/wHyaEYOgQuc6zw/hpNHad5ZQTo=;
        b=Iml8Sjn3DruYX0nj0jOuuMGlELPKc8jvj0OXJd0ESk3EvL/sf3KetDNvSkdEUAs2vy
         Tw19hYGXRiShdugOTYIkkMTEi9MeXuecHNUvqiJ2CB1X9jmilWn7g/vKP5ABjxYNF7rv
         KKqz1mCnzbA86ANc3hZ/RUDMX8fFOj4l81D/byHe5ehkEkC3iIZFERKUE8+ZP1o8bfKr
         9RIdYM9uqlSzNcB72zvOowy88hRJsnuA+4gqXLZqvbyL++orDGjPZiP8dZ/tQHo0o76i
         75ZcshsZcHrXGt7GJSGt6D6o2q4xGzq3+CwzFbAEwYSGpvNq4qxwo963cRiKuhdzs0Jl
         xrJg==
X-Gm-Message-State: APf1xPArRO/PuRTJ0a/HSOIyVrsjVc1e1lNwUUbbvzc4Dpnv+DjFkR4R
        ppjT+on82Z+CwlTdBsX6PD+Inw==
X-Google-Smtp-Source: AH8x227kl6lZ03bWB0UtQQ4aRWo4LLZQEFVtMP8+OqlgooYssct3gNTA+KC79doKbratRauB8UUVvQ==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr4780722plp.249.1519260310807;
        Wed, 21 Feb 2018 16:45:10 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id k6sm5032720pfg.29.2018.02.21.16.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:45:09 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:45:08 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 24/27] sha1_file: allow open_sha1_file to handle
 arbitrary repositories
Message-Id: <20180221164508.ebb49caaf24499caf386dae7@google.com>
In-Reply-To: <20180221015430.96054-25-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-25-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Feb 2018 17:54:27 -0800
Stefan Beller <sbeller@google.com> wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
