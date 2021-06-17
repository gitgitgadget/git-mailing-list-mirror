Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD1BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B242613D6
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhFQUQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFQUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 16:16:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287E7C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:14:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c13so7830201oib.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=82HZBSGjKV8BzrqOiyo+YxR7JsyUXmQ89wEaNIBhQCw=;
        b=FpLJbWtbZB6hWEcn8ypmHHmjuq5W2J7w2MVeTTFSJhEkJiGUKspuHdUMtywpdfZl8E
         ToooPpM7V+v4lA+djBxhjiGuaBCKb+78lU6h7fb10jGbhnlnKdPAfFLQwoEeY/R0zak+
         aWYWxASiaDe0XVS5oKpRDLdC4ixuhy2eTr9nW/TW90ngQIb+3e+HdsAkbNGTjQ7oTefm
         Vve/qhFgr6RJUueLTWPpD+9+sLu4RBuNNNX2Vabw2P+i7g3EgGTwOSB3/BLjEx7wioL4
         5iwovRO60TPLx/4n34uLkR/WpcOaig6bMDVhG7Xt+uS6QhiTuJgPQtjSxAYqijZmLlw4
         zfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=82HZBSGjKV8BzrqOiyo+YxR7JsyUXmQ89wEaNIBhQCw=;
        b=U231QrwCAGDIQdiETSkXQiUqhZHv6F6ilfu5hFjJkDp5fAQ4lMIk75zJOd2/CGH1od
         DGwkOdZtuFyOIOLhERp5okLRYWDRCK6n/QwpO9N29Hmi3YvxA5ratmGFmfJnWJCkW+RI
         Yyc1QZulf0dILYwR3u8D5n8ywLMU6vbykfZ17rKtfB1yXG8mtEZ5HtcAnk5EuQf+J83F
         jPKgHP4m/65EWp9dkZPC6DbfTDh/KXUJ+OgHl0rypYQhK7ifDkJkPGOcIszi2PlHQr0w
         AQmYKZ4+kElLLQI4RtfDcpMfbatS8cP+A+f4qqX4wT4cf6JK3tIIFIdjObFKyGF/v0Wz
         Dtxw==
X-Gm-Message-State: AOAM533wcxGZjDspYBs+jC5n9iL/zOEbFWr8fuNE8Ytyn5ER+On/TpQh
        UKPQWPedp98yETY1aE+uY5Q=
X-Google-Smtp-Source: ABdhPJzXyjpuTEbMBuMdhtaq3kI0/qBIDI/Fux78IWUPHLqf2VgSf5Ym1ZqS4lVQIoTu+kugraFMCA==
X-Received: by 2002:a05:6808:34a:: with SMTP id j10mr11597843oie.149.1623960851359;
        Thu, 17 Jun 2021 13:14:11 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm1307081oie.33.2021.06.17.13.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 13:14:10 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:14:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbad11b13f5_9bf20896@natae.notmuch>
In-Reply-To: <patch-2.3-6e164edb0b-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <patch-2.3-6e164edb0b-20210617T095827Z-avarab@gmail.com>
Subject: RE: [PATCH 2/3] Makefile: stop hardcoding {command,config}-list.h
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Change various places that hardcode the names of these two files to
> refer to either $(GENERATED_H), or to a new generated-hdrs
> target.

Avoiding hard-coded things is generally a good idea, and I can smell
there's an advantage nearby, but it's not stated.

Can you spell out what you are trying to achieve?

> Hardcoding command-list.h there seems to have been a case of
> copy/paste programming in dce7d29551 (msvc: support building Git using
> MS Visual C++, 2019-06-25).

Actually that's not the commit, it's this one:

976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
Studio solution, 2019-07-29)

The changes themselves look good to me.

-- =

Felipe Contreras=
