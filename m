Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F30C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E760FDC
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhHZDKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZDKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 23:10:47 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26DDC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:10:00 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r6so1750526ilt.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/aMxBx+NHtHeaWUHMyqXY+nok2Z1V8VYBjYv8o5enlY=;
        b=cj4z1vFPM7ZkJdNMU8psuUsyBCs1MG5vgmIXmR6i4bfmSxoigy+TUgqhQX0gLBVaVW
         tptXLUvB0yV4NOVCR2/im/WiVq/Ux/s+Siv/03PrnbQT26XGpM7FepPNWskXgw5hlPWm
         NkadiFWaz/51FJfKvum6Man9xAUDc9TLoQRn6IrYfaJr3sJOAeOXgX460ZrR4MzXunu/
         n66cK4eZl3hJo2E6GWroxXZumRfd8e+KpgTxV4wwQU4beLl4EcllL0nQ6r2/TiFLgLx4
         CAPECmfhXDSDNJJqHvAsCgrSnsy7Wtnk+tmI3yFAlCwvYJ4dE/Kw6i+2NGvucWws/vS1
         T2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/aMxBx+NHtHeaWUHMyqXY+nok2Z1V8VYBjYv8o5enlY=;
        b=jA17HnwQgF8OoGhu/NSwFgEsGp1KQlMlteLPSmVStG4Ah5fsZX7ue3/IQSByGL8MGl
         fTreCdu3mtQhVxCAJI24+c/Dv0iexFBZi31upkIodRo1ALuEvrGke9O+N6R5nOcWw+qn
         WWPuNdFxFCChQxmGiRIquowi4msPJIYo765vt0G1fOzoo7Gvc08nOb+ZZFkr72XkWu83
         8V3tGVTwVX0ZpOfhztONNaVcA6GgWdGFX6H9xad5AOfd7AovhWuok+IXV/MB+uDNFgLB
         mnNd2RM0ZkxJeCUCxzloSO9W95mcSiT6eoSZE8u5j80EfW2z667U3Y3Zx403zkf98+ey
         DN7Q==
X-Gm-Message-State: AOAM531jKFGBKlpPrlHgeiOH8a7EBZvCO3NLXvSVnCGvRZ9xUiTGWTMH
        Zw/RzUp5l4xVQVi8u/tpD89lPg==
X-Google-Smtp-Source: ABdhPJybsLbQ1bK+2r1x54heMSOLlvea9zVJJRaF65daGo5p79EShqyhSy5dOvmW13ji/O39dmpKPg==
X-Received: by 2002:a92:4a0b:: with SMTP id m11mr1124754ilf.118.1629947400391;
        Wed, 25 Aug 2021 20:10:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5sm1066659ils.3.2021.08.25.20.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 20:09:59 -0700 (PDT)
Date:   Wed, 25 Aug 2021 23:09:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/6] tr2: stop leaking "thread_name" memory
Message-ID: <YScGBj4RJP7iISGp@nand.local>
References: <87o8agp29o.fsf@evledraar.gmail.com>
 <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <patch-3.6-1fa1bbb6743-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.6-1fa1bbb6743-20210825T231400Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 01:19:21AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a memory leak introduced in ee4512ed481 (trace2: create new
> combined trace facility, 2019-02-22), we were doing a free() of other
> memory allocated in tr2tls_create_self(), but not the "thread_name"
> "strbuf strbuf".

Your patch is obviously correct, but is "strbuf strbuf" a typo for
"struct strbuf"? It doesn't really matter, and it certainly is not worth
re-submitting 6 patches for a single typo, but just curious.

Thanks,
Taylor
