Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFC4C5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47B8206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGYnQ4ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKYJ1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKYJ1X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 04:27:23 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3811C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 01:27:23 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id d17so1034888edq.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+I46GB/RyP/sCvgK0XYRkVBx8Wpfdu4LyXNE5vu3aVg=;
        b=RGYnQ4ewqbrng8418CNHBKPTRA42qxBzWkLG23IIwoP3hA3xgF3plOt/7g0p+cAbSv
         w5/bD2jWnFPFizUFHFHAPIyb0Kig3dmg9KU/2rkTuZx9GQ386UTgfWSyBdjqxR/EyPpm
         ZlpPUBS1mz59m2UhYkcZbJlue7PsPuXPb/JwbhE0KxZOVZCh91B6YA7+KpqXI2VoRmK3
         /svBFSa8k1SGer6rZdmR6d7H2RinH0UH3ReBp7HaQYEfsbrqw0BUzE9sjRJFw5c7+w6U
         jaxi61XCoOqQgnKYw7llFooe1ISfMtEtAYhnZB5QigCCP09WX0i0Bc4vwdV5Qb5999aC
         KNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+I46GB/RyP/sCvgK0XYRkVBx8Wpfdu4LyXNE5vu3aVg=;
        b=q9FheAq69GKRW0Rlxc+rsxXaAlJnKCeOE93Rav2qY7nOD8BD60kmjMv9m1O5T7Iwl8
         kIpw5myM86Zy+JUdBTNvHkwfse7c/dvM2LDJxhfdQryOWeItXo1WKCaT5R8z52njicfA
         9TFAyaAZTdEXXha8K8+oEfyhVqhbMirEJ7Lu3YDgcWixOMGnlIgVAZVt+x2ZF+/NDQ01
         daeFh+S0VkDh+Zd2Jlh4ytA/PPsvrTu5Zf6g7ijxSF6/Zyh/lKeSpe6zTpYBID8VemwU
         2D2+5b0RTXUyu1qJQL7F3YthcvJkLbY3cZDIGtqyyZPEt4xXsfF00DGqZ5nqZDsst5lh
         Nfgw==
X-Gm-Message-State: AOAM533QntGSZrSsVIzwpB6N8tIr5iGAKRedafL6husoDVhajWZ3F+a6
        ebj8TdS33VCO1UAOiQFjrQu1Vp7Pe8g=
X-Google-Smtp-Source: ABdhPJyfVjDGM65yNCvjJhrd2EEXgp0TFADdHDY1JqiTtqkahPL4+fFiuWsDs8HIyG9VDDowzi6FYg==
X-Received: by 2002:a05:6402:658:: with SMTP id u24mr2609170edx.27.1606296442387;
        Wed, 25 Nov 2020 01:27:22 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id dh12sm840581edb.58.2020.11.25.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 01:27:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] grep: simplify "grep defaults" handling
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <cover.1606251357.git.martin.agren@gmail.com>
Date:   Wed, 25 Nov 2020 10:27:21 +0100
Message-ID: <87wny9okg6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 24 2020, Martin =C3=85gren wrote:

> This is v2 of my series [1] to simplify the setup and use of the `struct
> grep_opt grep_defaults`. The only difference compared to v1 is in the
> third patch which now drops more code in favor of copying the whole
> struct in one go.

It's good to see this change, I remembered having to juggle these values
a while back in:

    git log -p --author=3D=C3=86var --grep=3Dmemset -- grep.c

Thanks.
