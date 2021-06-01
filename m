Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E89C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60AD61396
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFAKJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhFAKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 06:09:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392DC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 03:07:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id a13so9535186oid.9
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=7PjQnNdPvq5sbBEqlg/LfchrRHi/PsDBY2gLe2Z5h/w=;
        b=MrA2tjLMqeAZ6Ehi4EdK91DELxGeMl48/3eBlf+WarXWjyIVQZvjaxrScJrSX7Y0pi
         9NSRdFgaM+C3RDabLWGlVU27bDR9m7/YA4ErWjmewTtxRdDYiA/CZadjliCuCVjSznwm
         ltmpnV85wp09inlil84HXw+Owgms50MdWQobv+ZpoaKwqfFuMFlFrKIANCk70kCvaK1S
         wpnO+1KTblyxmdT6KPSCH3xIfkvsTdDePOg9Cl14jG7AVHbPBVxj4ROLxZACKL7Ms+L3
         G8bDNGE2dpGAs3U+hlV06vqxDkhfyvH+nakoPXkaiI0Lfnl186a4ePW7qTbcBtQo9Dju
         4L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=7PjQnNdPvq5sbBEqlg/LfchrRHi/PsDBY2gLe2Z5h/w=;
        b=OgkK25feGO3o7qauEYsmK/zhWSjk53OS0YQk1Qh8h8Tq0OqJH1fOMszHo79Uu72Ho3
         GNU8tgeGrUGCQB30gNN3WD5sGkaiJfRqhBe3BZkfXz9PLYzVrzdzacbksER7Eq34+gGm
         mOuLjCjr/tsrOly0Z5XgzHCyhsMX2SsccxKHTt3y2lcr97MDWZWSrGOLVvJzpj1B97NG
         zNgYE5zEvsyM8l8TR2VXq/+KgusbFbE6h8VBdVyYZGDHSQb54onP3MFCbSSWt2FvXIWc
         4uIO+unuZkZFIp20meQKq0H6tDMqqLNgy29/2XVMEHYQ/Monr1XfgH08F1H/Dh35xJrq
         NTrA==
X-Gm-Message-State: AOAM530ZD/HPHOWJy5Y4sPBf9oqq0pNoMbnqLHRxl2YEycl8EGeyUi/n
        nSfKneDp9hZR8lZOaWea/HU=
X-Google-Smtp-Source: ABdhPJzU73p8r+lRr3g/yq6pJGIjokLR7zzQI9eG0vSbUcAq6phm08M7ra52sBAeLxtotZE3AQ70LQ==
X-Received: by 2002:aca:4244:: with SMTP id p65mr2550930oia.8.1622542065924;
        Tue, 01 Jun 2021 03:07:45 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r25sm2398248oos.44.2021.06.01.03.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 03:07:45 -0700 (PDT)
Date:   Tue, 01 Jun 2021 05:07:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andy <rsstools02@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60b606f029f11_e40ca20849@natae.notmuch>
In-Reply-To: <ea3a64bb-7c1e-465a-9639-aedeeb635d0a@gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <ea3a64bb-7c1e-465a-9639-aedeeb635d0a@gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy wrote:
> My understanding is that even if it's not an advanced question about the 
> details of development, but just a general question, it's still possible 
> to discuss it on this mailing list.

Yes it is.

> At the moment my configuration file is quite short, but you mentioned 
> that the configuration files of the masters are often very long, which 
> reminds me that there is a lot of room for optimization.

Indeed. But efen if it's short, do you need more than 2 configurations?
(other than user.{name,email})? If so, maybe you could participate too,
and let us know which you couldn't live without.

> Getting out of your comfort zone is not even an easy task, and 
> understanding the problem clearly does require preventing expert bias, 
> which is not easy.

Exactly. And getting rid of our precious ~/.gitconfig (even if it's just
for a while) is a straightforward way to force us out.

Cheers.

-- 
Felipe Contreras
