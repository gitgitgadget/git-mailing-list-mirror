Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903CCC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B36613CC
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBBCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFBBCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:02:13 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D5C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 18:00:31 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v22so1179325oic.2
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jTCRztBsEmp4qAEBR+bhUpOCPMeNuz8zVDjc56OxbPA=;
        b=uqg6WR/cmH1mwDYJZt3MbmB3d4R5mq2zBP2Y16OxeMV3/hOXCjZMoLyWGsM6M+WqBh
         uG4+Wo0z9Z7Deg/jn8KACX6X4Tl49VmaE811I7o5h5VGe6BCwwkHbXoO8/FP+jkXDInt
         s9GLa0wzTrwVcyNiiXR8GPP/QycGqHQqNdk+Z/sxO6BAriEK7wXmIpoUtTQvsm3uAGNv
         IT28ZrImjUAxo4Up/Z96cJav1IHgWFvDf0eFWO2UvjlhT1GQYZZcjacUAVAneFpoNIiJ
         Bc07TNqY8JUnSLjvJ9kdtAKzytge8QAmADN64yZUoxEMLRvKYFY44kc0p6vZfG9DgURx
         Qrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jTCRztBsEmp4qAEBR+bhUpOCPMeNuz8zVDjc56OxbPA=;
        b=At9PDobckBQXYLSZfQtHGSjgTWQG6rVI9ygpezA5+tqBAKstS8CDxZPylnT3xfxsM0
         CczN/pKP29dgu1whQF6LQDMImJwUgSY2kG4R2G2YWBvmpIxIKxWBBm05P809ZJd4UdEe
         Hms/qaH85DE7LhTu8dq6f2sorVA2OqT9YBRulANlZiis6EUV3jZG8XKM9fyZNXYztZe1
         NrWi7XlrhQQADagLn9dutHLo4RapxubwSrKvI3D8pRK78VuVc8Ba8ZKhvDM7b0Yjkk9S
         MKTL8YMmp7ghwKJosSfzFKuabrrh18321ewf68SkFCzJBntmu01t76d2BQJDNUZMIg0J
         3WbQ==
X-Gm-Message-State: AOAM533tsWdl/rXucoMTjqLfLfVqw/NCZk27cB9hURZA6SDAGctk5eTK
        w8KWOe7OYS20S0PPUMAwpUc=
X-Google-Smtp-Source: ABdhPJz36WSw5hzfJ3smRPyq083DGnXehqwXICQ7dp42Wq2pLIgcRBctMKHMionr8Oq2o7qrA3xdDw==
X-Received: by 2002:aca:b506:: with SMTP id e6mr19914528oif.178.1622595629995;
        Tue, 01 Jun 2021 18:00:29 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m28sm4094851otr.81.2021.06.01.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 18:00:29 -0700 (PDT)
Date:   Tue, 01 Jun 2021 20:00:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60b6d82c6982c_4abd208e1@natae.notmuch>
In-Reply-To: <patch-21.31-3748f128763-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <patch-21.31-3748f128763-20210528T110515Z-avarab@gmail.com>
Subject: RE: [PATCH 21/31] hook: provide stdin by string_list or callback
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> =

> In cases where a hook requires only a small amount of information via
> stdin, it should be simple for users to provide a string_list alone. Bu=
t
> in more complicated cases where the stdin is too large to hold in
> memory,

> let's provide a callback the users can populate line after line
> with instead.

let's instead provide a callback the users can populate line after line.

-- =

Felipe Contreras=
