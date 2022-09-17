Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBCECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 23:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQX5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQX5L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 19:57:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74712A258
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 16:57:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p5so29907649ljc.13
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date;
        bh=F54aLMfBI3BtSLkg9iqiSa0TMdrvj/iuispL5+bgyYw=;
        b=hdkbe2ILxF+kqUXoKSLSOUPYNUUV0iJ6svRw8Ufp/u894syW5+c4EDmTjWWQkIcSjD
         ea8dtSVmeTGz3utzLTVKdH+7CwvWgci+ssihTnjVbMy6gC2pweWz5NXEpqkvFrlZZMZa
         Gq6NRau8mg/KGrzL5rW6JDkxDZBAHFvnSpjgxqs05qFmQmY6VQbd6aRxFT1NnMNq/Rji
         zEoEK1TBGpz49VjT9GYvcSanU/2sSJ9B7gqSm6x0oqNf051Q7SmhvsuP2mCQfdmqd2jH
         2kWYgOYan1WtQ3k/bZu+ON+C3UcQ0/njDXAJlCUvi57x9V8+nqBWRrXGjsWheTkMw5nJ
         tNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date;
        bh=F54aLMfBI3BtSLkg9iqiSa0TMdrvj/iuispL5+bgyYw=;
        b=n478XIOx/7rO4Wi+VO26ZobN/fBdS87i62P14TW8RGFEB7bivhCjRzZRLn/5FZR1WU
         dPyaRKQTP5OP8FNtDGMP/xGNQt6EwABl/0PIhp9viga/l8MtdJTCvEOzmg+pEtjsKmyo
         shsPgCBUXYWvWRkU40hcBYBouETcedYwoFYMKkyWt+3OYrN5V0uQRGTct3bq5O24/qHa
         9D4xIqA4XOP1QiGz9AJrKQD8fILmjxrpJPkj3blDwqvsMntwIiG9QIsvJwvUXR8pEoTx
         sVjNv01eMLma+7kz1Lsa/vSwBiqzCLcDDwsiGyshHL+uFCe4gdsmtYhm2rvAD07K5SQo
         CFNw==
X-Gm-Message-State: ACrzQf3vqH0mxQnojqnUk8ARniFninVW7t+NNXTC2I6sY7punqv2z2nc
        Zsj49JOTXVtjO+s3GBKQDQ==
X-Google-Smtp-Source: AMsMyM4gfP7InA2ytlbqwWzGv0PygECXXU4glpmykH47MI5UkpDcLooGd0l6xc5oTFYMKqhL9Jj0Zw==
X-Received: by 2002:a2e:8ed2:0:b0:26b:fd05:72ec with SMTP id e18-20020a2e8ed2000000b0026bfd0572ecmr3047791ljl.465.1663459028877;
        Sat, 17 Sep 2022 16:57:08 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1fa0:465e:11c6:e110:14de:f25c:6cc4])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b00498f3ebffb2sm4332794lfn.25.2022.09.17.16.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 16:57:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   =?utf-8?B?0JLQtdGA0L7QvdC40LrQsCDQmtGD0LvQtdGI0L7QstCw?= 
        <veronikamorso78@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 18 Sep 2022 02:56:34 +0300
Subject: Re: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing blobs")
Message-Id: <BD83C5E1-2908-4C28-AA6B-507F85FB7995@gmail.com>
Cc:     git@vger.kernel.org
To:     jonathantanmy@google.com
X-Mailer: iPhone Mail (19D52)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCtCe0YLQv9GA0LDQstC70LXQvdC+INGBIGlQaG9uZQ==
