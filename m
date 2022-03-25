Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC3C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiCYTk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiCYTjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207D2364F2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:18:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t2so7182757pfj.10
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZPGzn8GYc7Mm2LhL0Trk5w+WAMLtd5ESXvjPPmgRhOo=;
        b=HHuYM/YpkHBL1gom+ndB7CQqc6GAboqnCwYLtB86U0oIHkUNaZvnGfUzyWHd9X7PNY
         6NBVxrho0rgupPX1SEpqww7c4eSeIUNrNYqqRgEyHUWX59G+5NnuC7okTJW6L/3ofYjW
         3lEBFxOnEL4L7QaigA0F5+ZOUFHdDpxf7AQWKuATp3QrP0cCjUCoHneubPCtT7k5hZgu
         C5xdAl5kPMkqeZmmE0NXRY7ew+qCTPok8FWhIbj4+8EhemK332lzoPrDBiK7ECEut+Ox
         N3ZAWvTyt8HgO1S+q37T0Ia7ggmTotrhr6X/m3IoPMbg/TknhoddXBHioKu5U+S+LRuP
         T+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZPGzn8GYc7Mm2LhL0Trk5w+WAMLtd5ESXvjPPmgRhOo=;
        b=ct87xP+vRAwmtJsBf//IpCjEqEujIzBjUU3yZ/iZoXMWZrr1q7ysgYqx92FJlHn2VU
         dZsDyKd4+fpDE6D12k7DziP4TobEVYy/nHr/mlyWEvF8WHBnyIjhxfYFQVX58eX/7JMQ
         UkuUWsccUg8F9evKimJNWQ9vXuvqIOJJQLl0QOWKesJrwkhI1b5nWc8J8si9ri0Zmjt4
         vcXuIEm+6m5qlZWGehcQmr/qydhLa/SzOUaufCnqsJGs6YOKPrWZJ0n8vvghdnYvvtAg
         wS669MILc+hZEHhPooSyJDukd2s7NITmExgNrOmGQVUoKyGxSU/YrY372PcNyTYE4t7O
         wUEA==
X-Gm-Message-State: AOAM532mfgHwrF6nFJEmWM5nJCdySu9UDBU4HgIP28pYcV9u3rrNoJq8
        cOGf/5T4bxsn7xG9DKLKdj2X/6n3yVxkyrxk
X-Google-Smtp-Source: ABdhPJym+0WnpB/FjJVVJ1Jr8X+nfitudaNxdHxVS9T2Qg9Nf6wTCabellKV3V+I1LK/jXmlySxtKA==
X-Received: by 2002:a05:6602:3787:b0:649:ec10:183b with SMTP id be7-20020a056602378700b00649ec10183bmr6400933iob.117.1648231876233;
        Fri, 25 Mar 2022 11:11:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j13-20020a056e02014d00b002c98acb8d32sm462904ilr.45.2022.03.25.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:11:15 -0700 (PDT)
Date:   Fri, 25 Mar 2022 14:11:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3] http API: fix dangling pointer issue noted by GCC 12.0
Message-ID: <Yj4FwuyEW0b5ImEC@nand.local>
References: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
 <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 25, 2022 at 03:34:49PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This isn't the only caller that assigns to "slot->finished", see see

s/see see/see ?

> the assignments in http-walker.c:process_alternates_response() and
> http.c:finish_active_slot().
>
> But those assignments are both to the pointer to our local variable
> here, so this fix is correct. The only way that code in http-walker.c
> could have done its assignments is to the pointer to this specific
> variable.

Got it; this is the key piece that I was missing in my earlier review.
Sorry about that, this looks completely safe to me now.

Thanks,
Taylor
