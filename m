Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B24C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 00:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiGOARS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 20:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiGOARS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 20:17:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CCE73913
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 17:17:17 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t37-20020a635365000000b0041965b8ec8eso1978326pgl.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9LswFKdqdrpn4fDGQuSvH3elF6VPj2Uvbb3luYii+nc=;
        b=AnXke6NSwuJXvDthlI0zrnG8PsXGI0f2FNteLEoNZqvJ3TjIpSdLatZ+GJGSzzE9x9
         CmJg92RNu38c5ssY8DafejnJUPfPKa/TlcLFMM+WFJrcGJVUoV6cfB9OCuI1E4Uv5y8/
         9mol6z1YTJtYu/uenJgAcF256E+pYBZvwQ3FM+52y/CzRGYlz2c/M7wJrBMwOvFIiu2i
         WT9AwzYMmAgbPkQaLaNAYeMkTy/6SCklvS/BSN3pX0gbzTiVHcgYdrkduoIg+zui3Ol+
         GUtGEObXwF7YhHwm8erILBoRKuZ7D8jauZpwJjz+EVLPYI1FUpr1d+46GDqmrbB1aTnC
         5HmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9LswFKdqdrpn4fDGQuSvH3elF6VPj2Uvbb3luYii+nc=;
        b=0RZ2d1aZcxREJ4OwVCBpcnFCf8YCbyTt4svhxWbJWm3oL+9SYBFgIgN+YZ4EWDOCvp
         quRfuCsMAU9kgfQDThlvgUimEXDz378Y6TqHZgtT/Pr4x7djYmTZq9qaK34fYH4P+jpn
         YO8hyuLXlWaduHcugVXzJlijfSbwI8kVWgNVCj+cK11NnI9Y9C3tdlldLfNVikd6egun
         eoytJBfgunY5HLMkP5eyu7lavuyMGpCrfhp26DHTFcG8ELKlrgUKU+oIencXySAlj0Bl
         HJ3YVTcVg4YKO7HsbMnufcAYWgbbGYka30AiknT/2c73gyAZFWWdhMjmxHS0jd6PMysD
         fM5A==
X-Gm-Message-State: AJIora+9QNLTb5ruuiBgFZPX//EJoOB0PEHBTEp/4y8QDCuCdT2891+8
        9g3vv/pbD/CNP5kJl/BQ/FKaEJdTnM3WLw==
X-Google-Smtp-Source: AGRyM1twZzMqFMK04IjMBMDiEXWQ3tChAS5f1U07Jpswef6csNMAZpUIS8VIDSJnJ1ZqAR9z2zEE1Aa+m9rD3Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ce0e:b0:16c:7977:9d74 with SMTP
 id k14-20020a170902ce0e00b0016c79779d74mr10263065plg.92.1657844236548; Thu,
 14 Jul 2022 17:17:16 -0700 (PDT)
Date:   Thu, 14 Jul 2022 17:17:14 -0700
In-Reply-To: <220714.86v8s00y1z.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lr12ntek5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
 <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqy1wwaey8.fsf@gitster.g> <kl6lbkts63fb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220714.86v8s00y1z.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 02/11] submodule--helper: replace memset() with { 0 }-initialization
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 13 2022, Glen Choo wrote:
> Anyway, I was curious about this so I tried the following locally:
> =09
> 	@@
> 	type T;
> 	identifier I;
> 	@@
> 	- T I;
> 	+ T I =3D { 0 };
> 	... when strict
> 	    when !=3D \( I \| &I \)
> 	(
> 	- memset(&I, 0, sizeof(I));
> 	|
> 	- memset(&I, 0, sizeof(T));
> 	)
> =09
>
> Which aside from whitespace issues (that I've asked the cocci ML about)
> yields a sane result...
>> ....... If I have time I'll send that proposal to CodingGuidelines, or
>> someone else can send it (I don't mind either way).

Adding an extra cocci check sounds like a great addition alongside the
CodingGuidelines change (automatically checking the rule is way better
than doing it manually of course). The fact that { 0 } is wrapped around
two lines is annoying, e.g.

  -	struct update_callback_data data;
  +	struct update_callback_data data =3D {
  +		0
  +	};
    struct rev_info rev;

  -	memset(&data, 0, sizeof(data));
    data.flags =3D flags;

but since it goes away with "make style", I'm tempted to say that this
check is worth having. Is it too confusing to have coccinelle recommend
something that we expect users to fix afterwards?
