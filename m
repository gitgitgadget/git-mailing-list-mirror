Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC37DC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D5B207FB
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8ozY+B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgEUKKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgEUKKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:10:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387BC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:10:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t25so5052842qtc.0
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RReF2VYIHxvHlvSwDo/muy+lvyMC/RMFG7/4CQHxzIY=;
        b=l8ozY+B1breEHlFVoMmqOo2sG8Thc8t6is+EZ8WJi0MsEUlXmD+9fmDoB0MbPJxyh7
         8HkeAkTejYy1NKY/UYlmVLnVgQumQvRaQmaRvHwGKCQQ2gu4tnB/N1hJWUwQ0mpBCHAL
         s27Ng1VmPKrF/qMEzuknzgv8tnIwG27SOctIibd7bj/UEfkywdw1Ph6sc7wWZGbP+1Ye
         y9aFjNz4oHXev54JpCU6SmzZcgQlloAnpKch84Q0vHC7yQzZ+T2ubABpoooyR9rwK1RW
         OSBCzz1OoxSGGvYKNbha3rXuq5TiPP5KD8y5t+G+TBX2Rd/SoAV31offxEZOUaKhFJP0
         6bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RReF2VYIHxvHlvSwDo/muy+lvyMC/RMFG7/4CQHxzIY=;
        b=Vu+fCgfauVg3fSMwvVRUTbIc6iTkUMlHUWLzcqYp5LBjDhRx7AblAuC32cN+ydAcA3
         5qgChWZQGxoeyQH192Yjif6JbB7MTh8q1OcSUUB+7CfN4Vp21vE00K6jtgcsHim8ucKh
         sgKKhd6mOsUNN6n/6Zp6yYvowYg+piRegrFehg9oSntKDQnahOBIrBAb+Fq61nL3tDP6
         NEjh47/U6r//beTbsdFroVv7f4RsoBPx6lZ/SkKGJcg066gQ97f8MkU0ymWotCk8DFax
         idZAfE30ysk+uCTGxCECy8wH37I2PA4y6IEWbDOj71dGCh1vP44a1NzyswwZHsaV301s
         Xc5g==
X-Gm-Message-State: AOAM530Mb2hf0R1ZL26bWzTMFbWzNlzsubm7EiY1ZEn5ccxSUh7KoGJH
        myHgtidn18s95iR+Qtf00Ig=
X-Google-Smtp-Source: ABdhPJzg9KlP8Ju2BQpCpu+auSxpiolls9PcjkBwYJpADi0DvmGtjNQHsb52G2UQikJ+Jsx+uzAC/w==
X-Received: by 2002:ac8:37a7:: with SMTP id d36mr10200154qtc.375.1590055824133;
        Thu, 21 May 2020 03:10:24 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id i59sm4417256qtb.58.2020.05.21.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:10:23 -0700 (PDT)
Date:   Thu, 21 May 2020 06:10:21 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] fsck: fix a typo in a comment
Message-ID: <20200521101021.GA578798@generichostname>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
 <0e34ddca-1e29-17ed-278c-4f94ed6436b3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e34ddca-1e29-17ed-278c-4f94ed6436b3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Thu, May 21, 2020 at 11:52:04AM +0200, René Scharfe wrote:
> Reported-by: Junio C Hamano <gitster@pobox.com>

Missing sign-off? I'm not sure it matters since I don't think there's
anything here copyrightable but just pointing it out.

-Denton
