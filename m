Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CEBC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E22C613E3
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFKQOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKQOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 12:14:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748FC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 09:11:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id d19so2269146oic.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=c0qL8D/61wcmVUkVSM4JgRkHYWul1LknamSoZcOQgIY=;
        b=EXmz8j7suMsaViqsUkGf3+GoPEwUq8cVihk9b5vCNbUWWWTslNttk5yq/OmPY2RS46
         Y2IveowqwBsLgpuKKPq9z78ND1lY+7l9QEvmzxdIztd/aB+2Dd/sFCfPKCtqcKqwjq7m
         PaGD5+EdFuMSDZ9+vfu66tZsQfr636eQ3zSWy8frwnOiCtn3+W4NTVUrV2CjksDH8db+
         b6gbbQQ4SW/IS0EessSiQGdyZUTDINU5jLElonpXcOGaM0NZLs0G9c7wcOv8PkYNoSNA
         7Dc/joMEjd2o0UqaR2i5wJKs4Q/xSxIABRe07Hg7/Av0dkHodimFp4e5OWXLPx6UdA/3
         ShiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=c0qL8D/61wcmVUkVSM4JgRkHYWul1LknamSoZcOQgIY=;
        b=c3G2WriswUKrjeC03znqlVjMDsL7JyHVPa2M9hdBGDMQPYqzQ5gD0WG2oqgPCvUKqF
         elba/MB1myl0Yp6sSVj0+ssq45l7YsozO05paxtahU33x2C1P/BMeJf5io89NCmbAtPg
         ezVtMuq5njo3ce26/kJFj9Ykl7vQlq6PCrzoW7IVJ7q+Faee1GGgXmowfRzH2VxsiC//
         89KGZsnL/n7x18GuEHXwUdGjVSmK/wrGxEmLgz7wPdSmPEegcOOtj+tt2vvX5WBUnsy2
         9a1wrL0+IAYGh8QWB2daZkJOl0xVcTBtWUV4MZ7b5zphsCvV+IQRyUk86Cy85+wE7mdw
         HDeg==
X-Gm-Message-State: AOAM533lpaXZA/Q6VVS2xsM5DU5HtJi3ntUO28VXNPLQ2nk9/T8vGpZU
        7nr1bDA/jr1wgZEK/2Xg/Dk=
X-Google-Smtp-Source: ABdhPJz+dZ/AWVHFHdVwjbpwj243ucCGkkHUf71dPAoux/YJn2PNwIPUzoH+J3706VpxQsNRcJh1eQ==
X-Received: by 2002:a05:6808:319:: with SMTP id i25mr1598483oie.95.1623427908366;
        Fri, 11 Jun 2021 09:11:48 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm1342687otm.57.2021.06.11.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:11:47 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:11:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c38b3daccc9_85c8208bb@natae.notmuch>
In-Reply-To: <YMKM0lVYjblbkK/I@camp.crustytoothpaste.net>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL8X7PepIggpKlSl@coredump.intra.peff.net>
 <YMKM0lVYjblbkK/I@camp.crustytoothpaste.net>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> Similarly, singular "they" is extremely common in informal written
> English (e.g., texts and tweets) and nearly ubiquitous in spoken
> English, where people use it routinely without thinking[0].

Singular "they" with semantic plural antecedents, yes, singular "they"
with semantic singular antecedents, no.

That's like saying we should all eat mushrooms because they have many
beneficial properties, which is true...

but not *all* mushrooms.

-- 
Felipe Contreras
