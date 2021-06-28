Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED41C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742CB61CC9
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhF1UZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhF1UZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 16:25:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2939CC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 13:23:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b15so5589867iow.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=egFGFMR3wgOqN57cFwt0TtExoV2oZuPzSgG4WLJADrw=;
        b=J2BTrQrb953NKaU96dRiIcoLQQ6nxzq2QFPfCaC7emVrCLODEDSEJuIjfXP+JAXoZg
         twz3LWyGbg2IE73IkTrRregWuc1UERTxpwmnsvNUY7Qlci7pb2sWW8Emlmkn7Zqc2SEn
         nWwaliuIn51POFvJIoAZNN1ybI9P2HrqW908Zet7OACGW//2JgSjv2bpjj3DZ0DZiP+G
         3fgQty2hNu3TqHWomSwhiN+i4w6QLhaxYpdUN2Hik9M/0wjNTN0WpuV/UDVlH/wY1p9T
         CMLe8rbEtZAtNHFtDpJ02I118lyS+JfTGuAHuvKLXEr/ESVmbqt7SlGznILv+HVYOUWP
         psRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egFGFMR3wgOqN57cFwt0TtExoV2oZuPzSgG4WLJADrw=;
        b=ON2ikAW8A/LOhgGSm4c9grwKI+2kscK0Ud6tsNUAI3h8EzZJivyRzlEL03+13xCGxa
         hlyWtRD29D1cYweeQj8p7od+fbLsV3WN2NMg90Udr1GOIoSKmGAF++Lw7E19UY+JNj+h
         mMV2DUVUBvZtK8U8WqD/t/wMQLnxFalniN1X9zYdF/GAyfRdKMNUPV7a6RkpB3j+2V5x
         RjAOGuChfPzbELP3ERtOzG7Jet7vWHDVhSdS7CmUAHM+CRn1PxaNkefWGL9jyGlSfyv5
         Sr/CUOOeqk9RV2qw4SHYlanHG/Ask6UPOTN5GwH4c/0hFL0oKL2NfXuxYcfLDJVtpvfc
         3LFw==
X-Gm-Message-State: AOAM532RBN45tMpC9W2NafyoU8Ib7GZ4RoON3iBRMn+h1Sn3LRo7nGQM
        8HKug2/GeXT+ia6SNOWq4jv8pg==
X-Google-Smtp-Source: ABdhPJwY5q7taai7MohctLZDIcEB2H5TRvinqIEbAVRtQpRHG6GfM408VBDesThqU3RyGpROPT3YNA==
X-Received: by 2002:a5d:9f4b:: with SMTP id u11mr962416iot.144.1624911806510;
        Mon, 28 Jun 2021 13:23:26 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:be26:393a:8e47:afb3])
        by smtp.gmail.com with ESMTPSA id u20sm4772792ilj.77.2021.06.28.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:23:26 -0700 (PDT)
Date:   Mon, 28 Jun 2021 16:23:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YNovuzAsaEb2uIaa@nand.local>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 07:33:15AM +0200, Patrick Steinhardt wrote:
> As expected, performance doesn't change in cases where we do not have a
> bitmap available given that the old code path still kicks in. In case we
> do have bitmaps, this is kind of a mixed bag: while git-receive-pack(1)
> is slower in a "normal" clone of linux.git, it is significantly faster
> for a clone with lots of references. The slowness can potentially be
> explained by the overhead of loading the bitmap. On the other hand, the
> new code is faster as expected in repos which have lots of references
> given that we do not have to mark all negative references anymore.

I haven't had a chance to look closely at your patches yet, but I like
the idea of using an object's presence in the reachability bitmap to
perform the connectivity checks.

I have wondered how much performance we could eek out by being able to
load the .bitmap file without having to read each individual bitmap
contained in it. (I believe Peff mentioned this elsewhere, but) I would
be be interested in something as simple as an optional .bitmap extension
which indicates the list of commits which have a bitmap, and their
offset within the bitmap.

I'll try this out myself and see if it's worth it. (As an aside, I'll be
offline next week, so it may take me a little while to post something to
the list).
