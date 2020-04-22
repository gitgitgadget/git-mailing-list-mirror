Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC1C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1B52076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS0ZzVhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVX3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDVX3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 19:29:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96035C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:29:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so1927600pfc.12
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaijF7AJUZDQPKuQQcibRZHXe3XzpLkaZT93l4iYA2Q=;
        b=IS0ZzVheEbXdsuY4L91vTuMNgcQLbWrwfKQ0/XoJbfdsVUsuYcnHBEYCFpIU2TBh8Z
         Nzyx5eXWzVKXRtwklcrYkLAZOz+BjuNMW9oKOis1P+3QBo3TuApONdfzU6Ho+tx9rbM/
         BQVz97SZpHWgnbKe32QmRNn7JYufYfOtarmAAHfDJKoCc7oDvRkcFiYdRLiHprjC8aME
         zeCrAiVHtrddItgKMfQMmmizdcLuTEQFMH2f1NRf3iPEAmuMVwfDInQ5+1LHgDBg6Ceo
         dXg6OUj6lf9yQu0WhG4WyHLpZmUTw92eVRZfCdhjlIUsy5GW6PpgpbRDuxRwWnPj/l+p
         hOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaijF7AJUZDQPKuQQcibRZHXe3XzpLkaZT93l4iYA2Q=;
        b=TuNNze73vnYjcO9cXlA2EdHgJJ9XEFWQ6Zi8nDRf3f9bDj4W/k9rDwuIqNAunhQDCk
         M2y6s969CFmh1vR4Jzugh8An2hE/Oxe79FKliUXAShkAVCcm2fS5VrUrnUhgPHetewe6
         a4WQ5suvOPj8g5Hef+KaIBNjwrRSj1WfB+x9YrzsGn1PgiFmDGpeBbQmc5KXyXCT17tr
         W/qNnFm4J4lkelCl5V7YEio5wgDNVM8V3HImhaVrbRaiWR946f0TZLSvQHK8vANnPvlE
         toTc/1PqAM+T+lxlZaXMGPGMkbgWxhsLo4MpJeK2RIhVrWKjXagxLm5Rht132QiN+m1C
         YMFw==
X-Gm-Message-State: AGi0PuZulK6o/DFyELhCbw58K8tP2mIcHnpvtkaEoyCJpO1EvZRDZZwI
        HuJuDKq3FDQ7leh5MtcNLfw=
X-Google-Smtp-Source: APiQypK9lnJ1EYN/fTysF65K3znpCHhUCG570qizgODZOJ5HE74vHq16PlyO/tXzfIPRs7W6md5BTg==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr909243pfl.311.1587598155101;
        Wed, 22 Apr 2020 16:29:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f2sm317987pju.32.2020.04.22.16.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:29:14 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:29:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] credential: fix grammar
Message-ID: <20200422232912.GD140314@google.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <2bf781081d9e43f38f2141de023fe918eedcbf5d.1587588665.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf781081d9e43f38f2141de023fe918eedcbf5d.1587588665.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  credential.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
