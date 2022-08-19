Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5495C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350535AbiHSSWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349812AbiHSSWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:22:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD9BC109
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:22:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s11so6592014edd.13
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=Mk4js/MYhbQMEPZT95JdTRAPK/R5LTGYuYF37HDD+Hs=;
        b=l0zRJy9FJbRXfpREP6/oPAC8jiJkAv6Q0iJs/bCKMLc5LGrBpVbmyOQQC1Scy0ahxT
         ZCx4c78+UBLvLOIG4MYJ6DnLOe6ww6OUCrvMCQuOe1dCFZV4d+s8JvebRjDxmiiudTKE
         DfaYDkmVKviQTmbqeFXLIFn+FvK64GFs6X9VWOgZIUZwuDqZrZxSpPO4ohMw81Heo5XA
         di+b87exiRpSmUDRikQ+dpNMLjklL+pzdHrzCBAt8djHE4hhV15IadLz5nxePgBcDq7S
         QKYMqsIEQQw51KQC8x9pftb4ky0xiCGQrJmBdqQdaQFvpYU0tZcdWGrcxS70ELyO2O+4
         wwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Mk4js/MYhbQMEPZT95JdTRAPK/R5LTGYuYF37HDD+Hs=;
        b=UW2qYohGsDeLdXjgup2BmIFGGRDM2BI5Dd0bvQ7aSm9YZ0aDO/NaM04JCa5dXX/RqN
         CxTe+pnoQ05KBZSdjBJnfDdBTNH3jypCfCRSMahJIvm/U2Z5Eg91/Vy4D8dzIkkrO5jR
         QNQJE9S2pjfH8WziM8o+gLMKrdu2OAkT3vsplkK9h+G3pt9N9JqJOmbZu1QlEsibZTcj
         HEjyzBR/yzxROPXDpv9PMJOmMN09WNnwx4FnzE9dHuzMR7OMo8yhs8MFBWJeqnHUlvnY
         MfRv970qDOC/p+M4zJ9AwxPUWjjAmNPJrhMcTIrmeQ+MID3U3SoQUgWAEsdwcqa2wi3O
         mEGQ==
X-Gm-Message-State: ACgBeo3mVlBjsUspznzoyD07Xc6oTrfCj8138o2WMfHLIfVckuhur5MU
        UOJ2hE4Nj4oCtymtW4bCTic=
X-Google-Smtp-Source: AA6agR44qc/8CR8W9TY5ntrEb6J6x/DiUGDarKrIfSiyFFQTyZK74Q+ux/oPT5VUxERp9m3AFJLZlg==
X-Received: by 2002:aa7:d856:0:b0:445:e147:e014 with SMTP id f22-20020aa7d856000000b00445e147e014mr7080072eds.425.1660933326338;
        Fri, 19 Aug 2022 11:22:06 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id kz9-20020a17090777c900b0072b3464c043sm2609574ejc.116.2022.08.19.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:22:05 -0700 (PDT)
Date:   Fri, 19 Aug 2022 20:22:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/20] builtin/commit-graph.c: let parse-options parse
 subcommands
Message-ID: <20220819182204.GA3373722@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-12-szeder.dev@gmail.com>
 <220819.8635ds6run.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.8635ds6run.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 07:53:08PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > +	argc = parse_options(argc, argv, prefix, options,
> > +			     builtin_commit_graph_usage, 0);
> > +	FREE_AND_NULL(options);
> 
> Why FREE_AND_NULL() over free()?

Heh, it's interesting that you should ask that ;)

I followed the existing pattern for now, just like you did in
84e4484f12 (commit-graph: use parse_options_concat(), 2021-08-23),
where you made graph_verify() and graph_write() use FREE_AND_NULL() to
release their concatenated options arrays.

But yeah, a plain free() should work just fine in these cases.
