Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DE91F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBVAUX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:20:23 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36212 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeBVAUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:20:22 -0500
Received: by mail-pf0-f182.google.com with SMTP id 68so1382155pfx.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vk7Dt96GqvXU+TltiTzMSF1iRukm0hG2yNtw3jMVPek=;
        b=jEL6xR5gvjL7cFEWgAn4ok8CUgq6dZYvApX+LGlJJr7YusdTfFm8bbqDMinWX6utMu
         eg6Snyh2Ip/69DqgRVRguTcliJ3cSQDU18WHmM7+Yks+rDYfLD2dpvfsW9bNYLUB9ehf
         hWun9tusei7XA5T+HUMqzcklWActz1lB5+W3nUKjWe/nPH6yLGQ0q5orh+CkAiFdEW+G
         NzeUr1FQVNgZXGHku5Y8mHMf40ZOgKLXNoWRk71dMPR3Q6zdgjMxhO70EfoxqxAXRIT6
         Y5p7X74k2A35xsxul0/PY+Rpi1T1WwHKNfG5bdhFyIot9DYZpm/VkVmmu1kdFxsT/KKt
         fH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vk7Dt96GqvXU+TltiTzMSF1iRukm0hG2yNtw3jMVPek=;
        b=NZ9F1+HnXmmdvHxL9ckY4BjM7m5fdyBfi1FS5iT7/7fTVeo9uiRIQwMR5ZWEUR5pZt
         34XgP6czgQWiDVaH2CpSmxJZU7fF26cnRCDpyIk6nO1qH+kv7vSBSvG4OvF3UOQvIli8
         85g6pRqtzAsUZ0+jbZSVQpfLcQhu9wwMI0dBY2o29lKKdNuvn0cGChGYe9fLonM0dqqD
         f9cHjXhcvEh/N6JkWgVdss1nUqMVqaGI9VPy++upqEL7wz/XFpuhQv/OeTKk/3s0HEhw
         qRi8TdTjGyLHy8sH8zzq3ytX3ftT5Plb2Q4h6xAudsJFRkMC8uxKREBuCN4XMCV6K6OT
         v+LA==
X-Gm-Message-State: APf1xPAAC8JOb1vkjv4/CYgLfMP2kyQToDUT6mpvXcCEiGbFi0uc+7LP
        yjqxrPTUy/X4hu/EWAdvDV6RVg==
X-Google-Smtp-Source: AH8x226MAT5rtcABRByZlq4lPNUFTUOgtC0Pohj+vU/WncmQoq0u4y9Zp/Jxd0yE5M+3kNnZij2hew==
X-Received: by 10.99.143.69 with SMTP id r5mr4072212pgn.160.1519258821622;
        Wed, 21 Feb 2018 16:20:21 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q13sm8773651pgr.15.2018.02.21.16.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:20:20 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:20:19 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/27] pack: move prepare_packed_git_run_once to object
 store
Message-Id: <20180221162019.bba08985870de3755a550b57@google.com>
In-Reply-To: <20180221015430.96054-8-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-8-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Feb 2018 17:54:10 -0800
Stefan Beller <sbeller@google.com> wrote:

> Each repository's object store can be initialized independently, so
> they must not share a run_once variable.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

> -#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL }
> +#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL, 0 }

Optional: Trailing zeros are not needed in struct initializers.
