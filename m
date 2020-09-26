Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83EAC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBAA20882
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5p7ywDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIZOxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZOxV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 10:53:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E00C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 07:53:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g72so6024574qke.8
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wxjt1ffe/hk3uwberQWladHT6VohtGtvxTJ66KU9dfk=;
        b=c5p7ywDzIM4HUYZD6nxf8v+8iVxUl7pFT+QfFNHeXpUKCtCRsXFXcic9d78J7lA/mj
         RlZszqlzy+fcjCY3Pkb9JvMDqtqB2zopEzSCRgKyGmjJ9iAC8Rh+Bue+SlkVE2KCybrF
         Gtoz7BT7BtNW0XSCK2XwMsWypC/kjDS8AZ1BNzoVWYegO2MO2VngDy8hztd7ddfN4I2Q
         yrvIcAcmr67gtLkYC1h1nHYX7c3JCihZgoEPi4Yy/IHldxV1TJqL2ml82cp8IZa4SSUT
         3scSg5dB2/Yn36fejxdqloZr93K7Yfzy6vzTCfsPYiYYWNICjBIepQPntpPKKbtnE4It
         iBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxjt1ffe/hk3uwberQWladHT6VohtGtvxTJ66KU9dfk=;
        b=qkHypHj6MlvH3FDS8RAivtz0oE2bAmJrFK+ubUrGRGFH3PxoSULsTleZ6D9CQ01ubJ
         9mipFCUIJSJ/hEIF0OwYka8FjU/cnSQx1uWCIxRYfj2IN9SS1PTRNd4pE6iHXsUbVrzB
         3iB2ghW2i5lX3MB+gzc5VT5QoX/ADodOBjV/AzkcVycuUuzdGII7oGy69t7zwGL9pNKN
         WhOyaj9K+XeDNbuTTlxgoIGr72uK3n/eWXtYkGGNSK+XTJd5u4S2wrhg7PakmjfwWa7L
         3iYoJUTQK1VpIny4aRbrEm7tnKkpLN5bpSu0L1HMYSpC28EsFiU0jJtjqO3arwp12/iN
         p3Jg==
X-Gm-Message-State: AOAM533kmN53nZdnYenyXBLeELzTON1n48YoCIB/oDyqmx+YE8NUzdw4
        1QLV4j5ONq/KpThK8YQ5ThCrz+vIA8x4f3k6UQA=
X-Google-Smtp-Source: ABdhPJw3I/lPNJa5kpcLfIeM2IVabxyfEzb0YSV/Qj5UXSdxsAAFQkjccQ5tniy8Iqw+xV2oE72qU5PNDlC0SA0y6Is=
X-Received: by 2002:a37:5684:: with SMTP id k126mr4574236qkb.43.1601132000023;
 Sat, 26 Sep 2020 07:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <d9922bbe-4e34-45fe-66a5-d7b5bf42117a@web.de>
In-Reply-To: <d9922bbe-4e34-45fe-66a5-d7b5bf42117a@web.de>
From:   Aaron Lipman <alipman88@gmail.com>
Date:   Sat, 26 Sep 2020 10:53:09 -0400
Message-ID: <CAEJZ43hYgdCWGOaMHc=V_YBz0S3LCnSP6tZ1=ZTEwiNBwbHFqw@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: plug memory leak in reach_filter()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for catching that!
