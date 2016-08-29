Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A700C1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbcH2Jrv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:47:51 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37841 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756473AbcH2Jrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:47:49 -0400
Received: by mail-wm0-f50.google.com with SMTP id i5so82659305wmg.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XROcEGHr9folbldT/yAA9ErQtcGuc5XRVCNagjhTBs=;
        b=CHCcCr4htLuvikeywMxaXKR0OnwCGWatkaUZ5hzM8lkbP04exveLrWG3SgwSHlWQpT
         wtFzyYb4DNASlslZGiBkk7FOXESRvU3qiPRF8mmLYGAp2pmtQ7/Y2f2tF26ccZBlYQG8
         87VfM3DTD1dHe4oNz7cSFto1j2VemIe/SaSTXqdLQtNyRzuoaLBsBpVv3IcfRjUrOfRa
         0Q/qUzsVjTlwT61oP4LFr2ljWUSjEyERKW//tjVUtrHB0S1sfCx4Qytbom3SJaLy1kLQ
         qECq48tk3XzHB3I9CtoKvttrM6Y40nDlP2yzf5AxyivkERjQwseZKNRHHRutP0oCvdfa
         22Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XROcEGHr9folbldT/yAA9ErQtcGuc5XRVCNagjhTBs=;
        b=ZmilRgmxXa2jM8p/8+88NycK9mgNQtnBhvWWCopaEjXvondb7n4BtHcxYmKAFnCwZ2
         Wqg3sd5efReNWYXHQ0f5/aMKiy86zpsEb8yUWo/JkO0vXbWwJGiI7SPratFXX9M/NCWr
         vOYdAaMRYXVpt4F034va/OgcrxRk28J573IR3IrLfR+de7sMDhkITRi1le5DN7IwrXc+
         /nG8dDmzAljtabdLMNbSDyrp1X2k33nrycjFdC60hpoMJ7BeX+9uFT+wmoq9zmQCoqFX
         gJ2u1T4MgCEBRRylETQwf9kEIZ9+wXsl4hARH6no5cCqsOjzDEwVnFYEwq2O7Sm2xaNX
         +1xg==
X-Gm-Message-State: AE9vXwP6Wrmo7RTzsdfoIKFFW7i5kYLogdyzchH29cn0BjplDwrYoyJz4l0zvqLkYAseow==
X-Received: by 10.28.145.137 with SMTP id t131mr10225807wmd.110.1472464061649;
        Mon, 29 Aug 2016 02:47:41 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id lv9sm33504828wjb.22.2016.08.29.02.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:47:41 -0700 (PDT)
Message-ID: <1472464060.4265.27.camel@kaarsemaker.net>
Subject: Re: [PATCH 15/22] sequencer: introduce a helper to read files
 written by scripts
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 11:47:40 +0200
In-Reply-To: <c0c7caa40a452ed9328c21302e4399562d40ec12.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
         <c0c7caa40a452ed9328c21302e4399562d40ec12.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 10:06 +0200, Johannes Schindelin wrote:
> +       if (strbuf_read_file(buf, path, 0) < 0) {
> +               warning_errno("could not read '%s'", path);
> +               return 0;
> +       }
> +
> +       if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
> +               if (--buf->len > orig_len && buf->buf[buf->len - 1]
> == '\r')
> +                       --buf->len;
> +               buf->buf[buf->len] = '\0';
> +       }

Why not use open + strbuf_getline instead of hand-rolling a newline
eradicator?

D.
