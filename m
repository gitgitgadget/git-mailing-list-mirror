Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5BCC38159
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 00:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjASAvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASAvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 19:51:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479B613C8
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:51:21 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f8-20020a170902ce8800b00190c6518e21so441676plg.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AiByRpWaTZb8g0y1wIc2OypSMvC5VyDwYFX7i/dFgY=;
        b=Ea7SGaOEb0IQGaY3DbAt3X14vu03gFdKRVAbGIHU3gN8uHmM6NKvMIDYWD6l2zexVB
         RC9Kk5hWL5mQqY6i0xA/yzRUZQIDqEdXao3y1H0j+5xLO0v9exf+zbZGGOinRu+J5i/0
         FwTlFJ7/jnS9iWcyA+aEUE0zFzliyWI7MDUb3i3YIkmSY2MP/+p0CLO+TumX9jHbdKNs
         vz8Qdw1meESmO1ZB0DF2vahYruPW3ncV/Pvmw08UO0Cn9jnxqj6iYrVUVxJzk34Jn0cG
         esxZK2m4d3ieN32HFOI+bzPA/gwsocmVhwxWyXUSyUylfBIvSpxCsDCjhULj3DwNJrTr
         rU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2AiByRpWaTZb8g0y1wIc2OypSMvC5VyDwYFX7i/dFgY=;
        b=EsJjOPA1rSJRGTuo78AgvKUyTRbWpfo6jiop0OFGMsi0VUWMi2kRO99g1F7iSqGf8t
         J2nihxnfR0y5rRXlUntMCwzGLcy4dPpA5J0fRFZ/+r6lFk7wc+yYebuy/HQWHCVznCD4
         fAzKIdQ3E/zBtTaEZTAl9g6He8SN9FrVUEA9fartCd2yortiEEYK+CxFp7O2ZFJE6xyP
         6ob26P3iFj9xAXjb3nDXwRKyFsXadWgHYQin2Fs/oXqXOqTLjTZf1xhNJZOP9HKKRZzO
         oqwl9CNk8jbD9ugeLLYY5unzg4u8qfveWNI8mmCfsQwskao3faOAgOAz54j5LC6d/Mt9
         CBtA==
X-Gm-Message-State: AFqh2kpWusJcGp6y+D9PT1IFb4uAuljclPG5Y5bwiRdKDD61h3uLVH0H
        ScssJZ9mzy31Ek3gsiHsm7IOlBmKwhaq8w==
X-Google-Smtp-Source: AMrXdXuN71cnB7hHtDdcbtKf4f+8hM/RTBG0g+Ttzv9cibNutjC9+s2mO0D/dJ3yXJvE8X9gEOIyv5FyEMKBMg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:d44e:0:b0:58d:8e78:842f with SMTP id
 u14-20020a62d44e000000b0058d8e78842fmr888578pfl.85.1674089481153; Wed, 18 Jan
 2023 16:51:21 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:51:19 -0800
In-Reply-To: <patch-v3-7.9-f35aacef4ca-20221125T093159Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <patch-v3-7.9-f35aacef4ca-20221125T093159Z-avarab@gmail.com>
Message-ID: <kl6la62fny7s.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 7/9] config API users: test for *_get_value_multi() segfaults
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> +test_expect_failure 'unregister with no value for maintenance.repo' '
> +	cp .git/config .git/config.orig &&
> +	test_when_finished mv .git/config.orig .git/config &&
> +
> +	cat >>.git/config <<-\EOF &&
> +	[maintenance]
> +		repo
> +	EOF
> +	cat >expect <<-\EOF &&
> +	error: missing value for '\''maintenance.repo'\''
> +	EOF
> +	git maintenance unregister &&
> +	git maintenance unregister --force
> +'
> +

Mechanical error: This 'expect' was probably meant for the next patch.
