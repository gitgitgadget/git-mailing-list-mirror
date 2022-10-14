Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F3C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiJNUkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiJNUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:39:55 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD7AA
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:39:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q196so4819116iod.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjVaqKtTPS9hVh5ZKCM9UTGZ+BtCNqzFGvAFJ/+PLnM=;
        b=tH0fE8r9gUAqPTlYK74c/melWyy7wjwmUfAaTrxN1xWvyW5Lx8DiRY5ktTUm5xefMv
         tuoHkRL8r/F58B2XZEWciGGZ862oCycmzHbgZDW4ltoul+dD1ubGRCDqKwPhZkNHR45k
         1dm8A5DU7tYeCjgb+Myg63O9190WA4P1iKMUa6X+zUeV2W2o+5qT0NVRJG/dAAtMw0Ny
         DGpEvtOPB2a35tvmeQ0b2HBplHNkbYvUUoXhsbBuT92m8uiOnJ5RLgIwSokMjNSRXvau
         /T8l5vw8cA9MelPa3PQefkdIsdJbj8LcO8CW5bCzu4o1JxXyBi3JxWwHXGGACy3qowbd
         mc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjVaqKtTPS9hVh5ZKCM9UTGZ+BtCNqzFGvAFJ/+PLnM=;
        b=J43JVYmniu0bHQ1vK0hpg7H5qvo042PNAsbbKBxgpnkbCd0Q1MsJF6oj6kSwn/4I06
         NqmFyxrJIcm0xKI+zG44Rf5vDcylt6GNM4LW7+OBp9H6fQbqBBn68lXzcalUk/wNJd1y
         1wKJtBIcFjxmN35mM8/kiCuJZPqKwgDKyccvCpsZBIbDtWJu2GdvBdzErlK5qqZbJ6kb
         uZZsZcOnDCZfNeZqpjmKby6Ot6vidnptTOfXJ2tsUbupKJ6am+BJyDNPsiCHL28VnTMC
         DeKTNlpQNhDcHdvOuIvYTz/QEPhfXkJRfBCd909Y8y6D2xJailOSqaf3bJCyPf/cpJi9
         ENQw==
X-Gm-Message-State: ACrzQf1UpgBEugXIre+Kv/4qdj/u2uI5ebiTpkURGT4Agc4nMrwXwixz
        ys8Plq5t0U+hgth7/gdbT3EA4Ir2lL7+UWic
X-Google-Smtp-Source: AMsMyM6Fmtkh5iWr0A3huhb7AboE6I6ibDIGCaOB+KXQt97ETHy0103tWR4nXkxliRNcIpZpDOm3Jw==
X-Received: by 2002:a05:6602:2c89:b0:67b:7e8c:11c1 with SMTP id i9-20020a0566022c8900b0067b7e8c11c1mr3235201iow.101.1665779976717;
        Fri, 14 Oct 2022 13:39:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c17-20020a92bd11000000b002eb1137a774sm1170476ile.59.2022.10.14.13.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:39:36 -0700 (PDT)
Date:   Fri, 14 Oct 2022 16:39:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 05/11] Makefile: split off SPATCH_BATCH_SIZE comment
 from "cocci" heading
Message-ID: <Y0nJB6MEjTsGLWOJ@nand.local>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
 <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
 <patch-v3-05.11-ab25b586f38-20221014T152553Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-05.11-ab25b586f38-20221014T152553Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 05:31:21PM +0200, Ævar Arnfjörð Bjarmason wrote:
> @@ -1298,10 +1298,11 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
>  SANITIZE_LEAK =
>  SANITIZE_ADDRESS =
>
> -# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
> +# For the 'coccicheck' target
> +SPATCH_FLAGS = --all-includes
> +# Setting SPATCH_BATCH_SIZE higher will

I suppose it goes away once the coccicheck rule becomes incremental a
few patches later, but I did find this rewrapping odd.

Thanks,
Taylor
