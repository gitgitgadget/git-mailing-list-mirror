Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B0C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BED561019
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhDKTv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhDKTv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 15:51:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CAC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 12:51:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s15so12527587edd.4
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WMAThRzyWlDa7FBEptSu7QsNraaWFUmtUBe28RT4GWI=;
        b=YjSDivYbbl3LxECU/mZ10rcvBeFNOprrcNQUuMQGz9JEPqSTMTbFBb2wMf269fEGhr
         LeOJZCCNTZXyBi6cnn106HLkrr+kQDUGxLBVWAekkYz6x61iN9TXx9k2QNQ7ma4rE4jh
         coujz6bu9QpTsa277rGkqaerVc3N29zfFUfKMJSMycgcIgqxR60MrOUcOiG0itxVhPBF
         kYQ9B/cZ2o+qKiHesJmy5W5ElRG2AGQW5uf7P54YsslMcpjaIpI1uSU4q7FwLZ8tbcPu
         9TfqiPjBzHwI007xAE6mHg/8zwELk8pok9md4Ov3rz1CFiSY7UYfwrimt8urLHZHR6tm
         eG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WMAThRzyWlDa7FBEptSu7QsNraaWFUmtUBe28RT4GWI=;
        b=jXIqSnt0AJrcKCkGmij6NBbNsAgCS5Icw0NPU9zitgQRi67QPJHtNROZLwFNW1ig45
         1CSqTXp/2WKyM2U90scva18v3JzZ/uCpKretPL8TImr8HPQACpFn+RUQiV05Jhv6ovTw
         YVUCxd9WIcvPEQS0dw3XsYpWCEvuJjZClIkHBXjEKS3yLP0plopZeu5WHHop2l9Db19G
         DisDbizfl1tj32vBnnTFRG32+hEjHAiPDw90AC8Zj4P4CwH7SmBmgrj8NtOfTIhBB7Ly
         ClyI0CTdd3Oqu4A/Tl6B7/WB/Do2ZzKDAKvfSNhswdUQw6LrOJC+c1rUI4Md6DGY+MSj
         G3Lg==
X-Gm-Message-State: AOAM530maWD3vET2Qq4oD9zJm/5UMt42Mmkcxkny8q90Ek865wYeR0Ck
        xJjAQuFfDfZRUFTUJtjJxyw=
X-Google-Smtp-Source: ABdhPJyosLf33tfXl/I3Z0bkWL/giVubM7ta7ym47z3I8FiSOojQJD1FyxdPcw8nVDNgbDUBKDwllw==
X-Received: by 2002:a50:d0d8:: with SMTP id g24mr13522430edf.290.1618170697958;
        Sun, 11 Apr 2021 12:51:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d6sm5313044edr.21.2021.04.11.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 12:51:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Drew DeVault <sir@cmpwn.com>
Subject: Re: [PATCH 1/2] send-email: remove non-working support for
 "sendemail.smtpssl"
References: <20210411125431.28971-1-sir@cmpwn.com>
 <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
 <patch-1.2-ee041188e55-20210411T144128Z-avarab@gmail.com>
 <xmqqk0p8hc5v.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0p8hc5v.fsf@gitster.g>
Date:   Sun, 11 Apr 2021 21:51:32 +0200
Message-ID: <8735vwfvln.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> So let's just remove it instead of fixing the bug, clearly nobody's
>> cared enough to complain.
>
> Hmph, is that a safe assumption?  They may have just assumed that
> you did not break it and kept using plaintext without knowing?  If
> we do not give a warning when sending over an unencrypted channel in
> red flashing letters, that is more likely explanation than nobody
> caring that we saw no breakage reports, no?

Maybe, I think in either case this patch series makes senes. We were
already 11 years into a stated deprecation period of that variable, now
it's 13.

If we're going to e.g. emit some notice about it I think the parsing
simplification this series gives us makes sense, we can always add a
trivial patch on top to make it die if it sees the old variable.

I don't think that's needed, do you?
