Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC62C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD761622
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhENUBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhENUBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 16:01:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B84C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:00:39 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u11so586520oiv.1
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=oy5A2Ma1NljOhoQ3pv+czALiV7LPwaL8XUBGDX7uebc=;
        b=fXOmdgh2r70Jk7/dbre+Pe2R8bK6SHZ42fnz1lgP2BLEQSwUtx3tJiZeYxF7SCzmSY
         kQ039hyS9X5rrZqym7ZBxxbqq0psFcthJD1eQr3sdQ9ulZiuQ2OapP+DCUdvr85TE1SW
         WoXnufGvdduyRqznxqte82pKC8vpqwvieItrmn1kzUdU9NFh7FkFyyGax04ua7BvoGad
         sN02BCK0PMR6IR/V+FMLwwKlg1Ee+wE1HTWK11IxaeyeAgkcdRRqLPj7zb0SjZ/hnrAv
         6Tt3nrnboHcWYjmLsaP14EOw8V3oFzwhgtIaeTHoTxalI2vm7ljCbi8/7525LZG2PgfM
         ZaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=oy5A2Ma1NljOhoQ3pv+czALiV7LPwaL8XUBGDX7uebc=;
        b=jeTUb+A3YeCLVOKpt3K6Q/kx8/wb3njEc4Kn0Vn2seKi65avm7Tqtf6GBezNWi0N2i
         aXNRfhy48DHBsOtFjm6Ioz/7OuAqMZPABErMM081NKkoL36fSoGDnYnDzcxkuHEmNH1/
         ZULWZ61IwfXy8NcSjlbFA38nyQtCy1SaLz+1AjYy639lO1/tt3eA9eIMO8OijYYPH80g
         sMZ/dgdEppDaiMecATKUtVCFF9f97bDZYDw3epp69mArODfugEU4qQ16L2tG8IukJfBt
         fElAwUV2emom2mV58Y2i5T5BtwTFrcQ8x1ZBBtOlr7/NHh5U98vx34I+gUTciMnQWFWi
         lTvg==
X-Gm-Message-State: AOAM533Wm98huS8VF4IOZ7RKFFzrmvAvQdnz7PmVDtbbmmDym3QjfxAK
        kywh3xwUiPB5U6GaV211i6I=
X-Google-Smtp-Source: ABdhPJy4wZc2cs/xUNzsz6ZbYLo5Myif5xGRXK1LysO+Yio0dg9MdG43jrmF4sU7Ulh2/oP/s3K+iw==
X-Received: by 2002:aca:c317:: with SMTP id t23mr7833837oif.159.1621022438841;
        Fri, 14 May 2021 13:00:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f9sm1518581otq.27.2021.05.14.13.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 13:00:38 -0700 (PDT)
Date:   Fri, 14 May 2021 15:00:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <609ed6e4e5a26_43127208b2@natae.notmuch>
In-Reply-To: <YJ4KLfd16qwnRqUx@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <xmqqbl9e7yqz.fsf@gitster.g>
 <YJ4KLfd16qwnRqUx@coredump.intra.peff.net>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> > It is curious that {plus} for Asciidoctor is deffined only for
> > manpages and HTML/XML side lacks the definition.  Intended?
> 
> I don't think it's needed on the HTML/XML side, as AsciiDoctor ships
> with reasonable conversions there to HTML entities. It's only for the
> direct-to-manpage path that needs them. This is probably a bug in
> AsciiDoctor, but I haven't investigated fully.

I have, as I have explained in my patch series, which does isolate this
workaround in a single patch [1].

[1] https://lore.kernel.org/git/20210514121435.504423-8-felipe.contreras@gmail.com/T/#u

-- 
Felipe Contreras
