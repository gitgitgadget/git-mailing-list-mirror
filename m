Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277FDC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29DF22C9D
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 11:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbhAXLyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 06:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbhAXLxT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 06:53:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38AC061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 03:52:39 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d2so8286204edz.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=if4Lnnui8pyf3Ti3uOIjZXsTl4gZN1ZY4PEza9okVYk=;
        b=NqEiqKe7/KzeI1ETJdpIsn+9+TeLzpC9fJP572wjAHTFisSMpVoQu75AUNLorqROHf
         3VJe3+/aZ8ayQHJ6gVrDXaXbEeNPiInukWAR2rGwp+Sw9593TFYBZnjYcZZuwwUHmepu
         VPUtZNG8zRK7pcprjxMsh7+guifXGD0i6CZO2aec2OTgf5C4mDrb5bA5gWpbShs3UjmW
         QzCvryPpGQNaB6JnPG9MX+gkDN/1VEEvb8qRcyHQNPykLOROS3niGrUfe8XxTpXYOp5b
         QpHtHdbSTKnJIccVPrHbu31zrc97mfgp+jGih/HM+TgN1rW6kDOV3ANllVUh23DR0Npe
         fFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=if4Lnnui8pyf3Ti3uOIjZXsTl4gZN1ZY4PEza9okVYk=;
        b=JWzffqxm1W+JjK7pIJ6QCV2nR4bfhpF4/oEqj9h/xkLmSoFzuoRVAi6TfVbschCFzd
         ZwgZG/5UsPP6BFfdsUH5rC4FzS4v86jYeIJ5Xdq5k00CFMlIgn9z8ScEBGKdmRI9ra5+
         nxQ6PTO9s14UfxwW8A54mbpKKSPa3lk1tzXBog2Jbpr5Oiy1MyPHYYIJ5a0idUjEo/TO
         4JRxOToKHWstGAC4QLFaywF6PgJWzKrufE1OZ2eSZoYdN9Iw+GPsuKWP4KSULd46lX9D
         +zjCb7AqUIiYfrm3KUKfnf+0r8hWdRdQy9+4qcdCyb4PP8/kipAU6xnq/fXEgbySXDB3
         QDOQ==
X-Gm-Message-State: AOAM530F0ryxT3haHdaeCyhQ5m6GEkoaizjZZ7hZ5Hmn0dxriwUO6RTY
        qEM4+vJRUmuCztkswMdN3DAKGKMR8YVL6Q==
X-Google-Smtp-Source: ABdhPJx9Q0rCjAPDESF1raetZrT97kZL96PN0Hl7yCS5PvuwBK7W2N4sNaUiF6ba1YpyRNFMAY4Iuw==
X-Received: by 2002:a50:8b61:: with SMTP id l88mr537993edl.250.1611489157981;
        Sun, 24 Jan 2021 03:52:37 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m10sm8394111edi.54.2021.01.24.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 03:52:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] http-fetch: allow custom index-pack args
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1611455251.git.jonathantanmy@google.com>
 <3032117ee747e72f6208eab7f960737d25f8a82a.1611455251.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <3032117ee747e72f6208eab7f960737d25f8a82a.1611455251.git.jonathantanmy@google.com>
Date:   Sun, 24 Jan 2021 12:52:36 +0100
Message-ID: <87im7m7drv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 24 2021, Jonathan Tan wrote:

>  --packfile=<hash>::
> -	Instead of a commit id on the command line (which is not expected in
> +	For internal use only. Instead of a commit id on the command line (which is not expected in

Leaves the rest at ~79 and this long line at ~100. Perhaps a follow-up
change to re-word-wrap would be in order?
