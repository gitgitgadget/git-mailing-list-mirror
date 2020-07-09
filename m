Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA1C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 01:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7039A20674
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 01:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg6BoC9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGIBAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGIBAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 21:00:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCC8C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 18:00:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so190656pgc.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 18:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pjNhq6B94YgsU+ff4FJsI157LI8c/J7aBzV5JXnHf4=;
        b=fg6BoC9+HvD5IvC7RYxSuWHQ/qxbPhChBFjD7D9apV+RQWUkI8RiqckHJD4eCJojCt
         Cz8+uXZ2FAK2U2n4XjE1S4yNe7AtA8GiMlQ56+LsEVii9f/n67U39EpVleeKIXvy70fd
         Q/PsTFjIBfRzqz6zf6HUACx7CtnpCLEqOnM/ysikXBGVPcbl2soxF4MKYdA9IxKH2NU8
         LCT0w2ckBH3EOZw7V0q0PyiEAHR/S0VM3Fe4/hbXDbucUU8G2bvaQRGpGV2mYvplhTL9
         cS1qwJaGDO2XrRnGs3Y9ctrIFhHqKOxy5PmJ1iULtaRFijHZZLgn+0Z1uKU6FpJ377+k
         KTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pjNhq6B94YgsU+ff4FJsI157LI8c/J7aBzV5JXnHf4=;
        b=ArdWoKDG6o8gCxPPEZJ/CpRJHG9Xf6NhCUccseKHcj7eHyANie5/s1NZhq7P7MOjco
         Q6ESwmDTo5n2lPlLDN0C7A8Ylw+bIRblf9byIg9O3DZ9biG+D92nf4XUp5xRXrXe5LMh
         KHDWtnY0Uq5PQvVjh9Wst44d4qvquFICNd8Ijcumqzt33V3qYR7uRTB45xjlz5B6Qbw0
         U4GLX7xc18Gz21wcgyt/JtXsf7hgIpiwmVLIKl7Yf2oZeIQO0EiAQ8JzjEZeoYbAnJ97
         dEymX/3lu3QnvepJC1CrJIgx4o5XmTHbqNwg/P8VQfygX63UL8GdHYdgVwmfT/hTeWtj
         yLPw==
X-Gm-Message-State: AOAM533EkB40deo7ERT3xphNUEBXc3HBhdlPRkFv7Mr+CxRMf6F32o84
        zXJwESu29nOrUpSNmdzdagU=
X-Google-Smtp-Source: ABdhPJxJqezEcye0cifNFZH6bno9gn1oVuDXRuHCdPRKgXD829IGHEKvRN/4/9fVnEuRedZhNGIGRw==
X-Received: by 2002:a65:594b:: with SMTP id g11mr54407300pgu.168.1594256444644;
        Wed, 08 Jul 2020 18:00:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id q24sm856236pfg.95.2020.07.08.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 18:00:44 -0700 (PDT)
Date:   Wed, 8 Jul 2020 18:00:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jayconrod@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v2] commit.c: don't persist substituted parents when
 unshallowing
Message-ID: <20200709010042.GA8720@google.com>
References: <20200707144338.GA26342@syl.lan>
 <1f769bbbb4f1b4ad67d29ee7b3e5282446e4cc0f.1594242582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f769bbbb4f1b4ad67d29ee7b3e5282446e4cc0f.1594242582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> Reported-by: Jay Conrod <jayconrod@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
