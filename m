Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287CC433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50997207D0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHCX1f0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgE3QYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3QYf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 12:24:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2FFC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 09:24:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l27so5155867ejc.1
        for <git@vger.kernel.org>; Sat, 30 May 2020 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WVkryqOYbeqGzCFWrFr+wTW3Nj0WByNqKWWrVdjGxmI=;
        b=gHCX1f0prZQVYeOcV/D/xgPsd+znHBCWSSxdJoS+bxdygWi03bnAFEGo+O+y0+O+Tr
         HeMfxDypv4Bv1Iwbl3TOZ9RKatLvewYtwlTGgzbGSEx0iQItoNqodYKIW7EviJu479+n
         Tn9jg9sWIDv54ynBHDkC3qve8augdipDqWBtQEHFxm58FoG2Nr4R0Jl02lpAK1y5HXXi
         Nb2G4h/QOXEs830kiNb7Zsz62Vw/dTujyWSEARjkKeH0Tx6TBq953/wOq6cmwYu0mS2y
         NzZw+s0XoiyN5aktIavrE1Cbb2p01WdDpHDnirZqZ9QR3XGEcMmU5YGkWCvaNHPXg2wY
         Y2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVkryqOYbeqGzCFWrFr+wTW3Nj0WByNqKWWrVdjGxmI=;
        b=Uw+8UbulTOdfPi1GiIuwRFXjYITFsBwPL7mPsds3SpldB9w/59De7Z2Xn0dCMFNjIE
         ZIf1pOhL64PmbxiSpRFsGEXiA9dhomGMUTZ1nonlF4NVZ4hAxytlfKluuRSvDRgMq0UQ
         eZzAjbWwutzP810g2UJbxIuU4XqLOXMtukxFH2L8KLwcuPmEFQslz9HNXa9gEdA+Mhi4
         ilvwbmsQK3mB9iGC8DQMAdUqBXEMBfpNZ56pCuB5+Lx7JmjMZ5CyCLAMvSIaly9KZPJp
         P0NOQZOchjY4Jsb2Lmb++JWe+Z4AVIQZX+dGYjnllhb5NwgDQkZ0wwGa3naTFcSy3Kxn
         1Pzg==
X-Gm-Message-State: AOAM533gPvxuVI7f7SMbe3LSfdElvz+35D0BjuzS2nEoko/0LGhPBhdg
        vHUiULvtVnRGsDanNy3qF0c=
X-Google-Smtp-Source: ABdhPJyFg36qDjJPurxgQOcRHZ1bf7D2G2Q8CIV/EAm0U8Yu7nQmWdOzk+GDlGcXy6DlEi9z7h9j5g==
X-Received: by 2002:a17:906:c55:: with SMTP id t21mr5911907ejf.100.1590855874415;
        Sat, 30 May 2020 09:24:34 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:d1bf:eddd:8052:1a96])
        by smtp.gmail.com with ESMTPSA id jx14sm10037458ejb.79.2020.05.30.09.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 09:24:33 -0700 (PDT)
Date:   Sat, 30 May 2020 18:24:32 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] sparse: allow '{ 0 }' to be used without warnings
Message-ID: <20200530162432.a7fitzjc53hsn2ej@ltop.local>
References: <20200522002502.9010-1-luc.vanoostenryck@gmail.com>
 <xmqqa71xqpd2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa71xqpd2.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I've now changed Sparse's default to not warn when using '{ 0 }'.
This flag is thus now unneeded for Git and can be dropped
(but it won't hurt to keep it).

-- Luc
