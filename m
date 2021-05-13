Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF68C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC59613B5
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhEMPZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 11:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhEMPZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 11:25:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB7BC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:24:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k10so9190658ejj.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iVVMa+mpxmF45zzHR9vYKnkkYTLUoaFtXue02T2+fyI=;
        b=Oj88Rdogg/gVVr9BYWTOK40dmSUVB6Gvggd69C6BC4UUkgHb5KNv02XOkkrrAvtBaV
         dpf9SWENz/NmMdGZ7xEa1PVPXlsRj4uB8/Lfn+ukUXQ33D184hjL4N9G+ydhngtS9/vZ
         OdTaKgasiFo05+qBl+7CE3CXph/EbruCYdVj4yu2WW8VdSqDVJ7WTdD0mM7Xz63dR76A
         GHlfyuCug/81UVXPtF0d/5M2AXIdQB1paS1V+btcHesfrDBlt+dNs3Tm1j/BykMQlcJ/
         KxyVU9V3HJTbMjlu+ZWIFFpCVeNUlKWrz1khSMnbEcg0KNBTSzbITmYQRdBz5F3CCoV1
         1XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iVVMa+mpxmF45zzHR9vYKnkkYTLUoaFtXue02T2+fyI=;
        b=sTefRWIy3pgRIGahlkLoKh/pBwWaW4hVC9HvanmEbHsJPXFmt0B6AHJBKCxssFT4kb
         GokWHaFHZHsBdOgvj/WLRLyACfA6TOrVf8T3J30Bn6mcYI+MNaamskMGRsiH7bM6tpFg
         IrlKnbLAzWQLSv7YYOntUxY9Uu8NX08UIeWaY4D9z80WzQ/YvPJYrmbVjoyXLF9/oKj7
         uWfa8e4352nLQYdHdkjUQMqmoTKu4KcVW9v63y5B6ncgYdAQea7VCHHJxlqY4Oh0Y9US
         l4JebhwCL4QG9yrGXv9Z05lk57u2R9JL1YqUGP2VO05UBj786cQBZXxZ6/UdEGjiw8AA
         Wrfg==
X-Gm-Message-State: AOAM530UU70RmwnWnNvPzaZckVt073mmVdeYmEEK5+Umxs2YaIQ95GWD
        A2ApUTz8ZebqYTlIDcp1khsmzzvxP44=
X-Google-Smtp-Source: ABdhPJypyhk3v6PqbJwgwTNBrc/39gZRpbpw8LsaXhu9vfhP9Jajo7xD25gfoz3XBUV/8qUDiYwFww==
X-Received: by 2002:a17:906:cf82:: with SMTP id um2mr44070903ejb.322.1620919471645;
        Thu, 13 May 2021 08:24:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q18sm2537688edd.3.2021.05.13.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:24:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] doc: remove redundant rm
Date:   Thu, 13 May 2021 17:22:37 +0200
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
 <20210512222803.508446-6-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210512222803.508446-6-felipe.contreras@gmail.com>
Message-ID: <878s4islld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 12 2021, Felipe Contreras wrote:

> It's not clear what it was supposed to achieve.

It seems this used to make sense around 7b8a74f39cb (Documentation:
Replace @@GIT_VERSION@@ in documentation, 2007-03-25), but at some point
(I didn't look further) we refactored that and kept the "rm".
