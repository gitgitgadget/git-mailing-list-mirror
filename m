Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA0C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC26B2076D
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK5cHbpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbgJLPTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbgJLPTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 11:19:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D3FC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 08:19:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v12so2100273ply.12
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1LPNjDpwikIsDS/Np6M3niOG2yTwSNAY3oX8EW/ZHDA=;
        b=BK5cHbptzJGxHrDTEEv+o0LMxrS6fDK+CRVNyDADwFWJqLj2eRIm+LeFhxzdC5o2ST
         0qQb8TzwnH3IZLulZyTIdNv42visRBZ3CduML6YXRuOLDwk9URBzMJfs1iCajBVF4bdE
         DC/ph8SKUsB2XsV3AmdgRSoSflS6/IMd5Ja+zLvqY869ebaHuZrMmxJPaJ6Fbeei80f8
         OnroxleiLAW/PtHGgsTg9M6YcU401l9BsAptBGOh1m+7ABMaUxjgnPqJTmsjeVUjXAIP
         tb5IQTVi16ghqS7DtX6ZHRYSgGmxuTqOHXH3Ve64XddQB7rB0O+kxCEUqR1JjPOHxQSX
         JkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1LPNjDpwikIsDS/Np6M3niOG2yTwSNAY3oX8EW/ZHDA=;
        b=AI8K490+yxDNITnHEBVvdXPB4dYz/xK/3OP5Akz8j6TALR9Ie27c3PfE2/OhhdTk29
         +o+Fna2Levf9ThwnHLQRFLPpjeD7uDqoRb4GrOfDxM4Ps6u6jSJaitsjVrNJ5AUd0w+M
         CB3c4DG9YF6Etx1vRKvu8bm3DqQz23pf8ZXLzqVor+Ki235YBeQBJAyf9fa/zDTL7U6w
         YuJZIEliSVvDGhAI6o98vB01HpN+ICIFQ+0XQwaE9ASZdGOOGYhyVQpYRoi6fZz09Pmt
         goFUp+lf6v1YOmo7NQJFPsJhn/n9A3yRObswHHtW3FX/wuF75RLIddDqHyh/ezElzuON
         nagQ==
X-Gm-Message-State: AOAM532OoRpHqabF2KbhFPoZB8eZ+q2sBPSe3VSLLNQ87sJlVb5evSBi
        MXmdUCXFIX+NnFQh4G2hppU=
X-Google-Smtp-Source: ABdhPJygQDYm3Y4GP0rER6In5ERjPA2+4jv25PbSNK/1d7CJqs1U7tLRxxnIPh4tGcWgOb8Nn8caew==
X-Received: by 2002:a17:902:ee83:b029:d4:bdd6:cabe with SMTP id a3-20020a170902ee83b02900d4bdd6cabemr16496675pld.68.1602515962877;
        Mon, 12 Oct 2020 08:19:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id b10sm19125906pgm.64.2020.10.12.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:19:21 -0700 (PDT)
Date:   Mon, 12 Oct 2020 08:19:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201012151919.GA3740546@google.com>
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201008014855.1416580-1-jonathantanmy@google.com>
 <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> The `merge_bases_many()` function has only 33 lines of code, partially
> duplicating `get_reachable_subset()`. Yet, it had a bug in it for two
> years that was not found.
>
> How much worse will the situation be with your 431 lines of code.
>
> Even more so when you consider the fact that you intend to shove the same
> duplication down libgit2's throat. It's "triplicating" code.

Careful: you seem to be making a bunch of assumptions here (for
example, around Han-Wen having some intent around shoving things down
libgit2's throat), and you seem to be focusing on the person instead
of the contribution.

Would you mind restating your point in a way that is a little easier
to process, for example by focusing on the effect that this patch
would have on you as a Git developer?

Thanks,
Jonathan

> So I find the argument you made above quite unconvincing.
