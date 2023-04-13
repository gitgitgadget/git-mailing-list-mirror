Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA7AC77B71
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 02:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDMCgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 22:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDMCgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 22:36:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CD768B
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 19:36:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z9so6729762ejx.11
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 19:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681353369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqqhHDoTQziNTthKEitttDEbXmHu2irBj34jrP3lBWI=;
        b=Lp2c/kHh2z9Z2RDeHbRoN4Bcgd60Cqbs/cfCVzaF04ynmcYathQu4VCOb5E7qOqQzj
         9sxRH1hrIE9Y3zUfqDVmA10TGg6gLt5i3NWsGaZ/kaNXdzgVOAgD0duvlS3gjjcaMOT6
         hBdaYyWfmbbtisl5flm5LNGaXNt2R3ETmbbenKHLQu0oI/oJbStkhY+IfuK9NefCsoz3
         eae2T81z9MkZkvd6Zn5EfUttskkRfzhdSQKgjAvlgGNXhZVl+czy3XSWmVYNORDbvRkv
         blCuynj2uepT+U9OrUCYnwi6wB56uQnIWhjf1l3/6DngUR0gHNhvs7z+NECPeJGT+8Rn
         lmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681353369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqqhHDoTQziNTthKEitttDEbXmHu2irBj34jrP3lBWI=;
        b=ZcCCJ7gOiT3d2/R/AMsXwthpigprMlVDraQHRTnDy6n/Mk3GZ+F9gsZ3NMM9aiZs5R
         XMMGwYiLJf7LPOzfSExOqdswl+0TB6/HO2ZrZHHTaQo3ZkfIEth7Cf6L643M0S4nLz6v
         BrNQGHqq8AGqdh+kaOw6zgTbAzbEGqFBwUExa2iD5klU+9VkCF1kHfTlIa0Rn/qnkpEa
         V/g6zAqbmy9Hi35tJhB/K+NiB4tU0PkUlvr03sqChImZMgqHfZFKlw2Iw8scenLxgC2e
         liOJ7fgbB9xxKlHr4ovS/BULBcvKtxoEPd0V3G+Lbin6HO7HCDJFrY+EtmJwwljK9e3V
         8wNg==
X-Gm-Message-State: AAQBX9daG8NGe0p6isJbn8I5JYfThF3PtPwv31VHYZRHt+9iZM9ePzt0
        zy7kD1ZIAIhummdX9ORnj/RfHOX0IT0kMIrUzH/xSsEbIZE=
X-Google-Smtp-Source: AKy350aGGBsUHuxpbp5QDnuCWIECepd23/I5cHsvaNK9KVvFjOz65uiVKIzg5CK4wM8G8woAD4zS8MbBsYIrfGZxJes=
X-Received: by 2002:a17:906:37cd:b0:93d:1b82:3c13 with SMTP id
 o13-20020a17090637cd00b0093d1b823c13mr475170ejc.7.1681353369389; Wed, 12 Apr
 2023 19:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230413015640.h6npzp47tnob7bq2@glandium.org>
In-Reply-To: <20230413015640.h6npzp47tnob7bq2@glandium.org>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 12 Apr 2023 19:35:58 -0700
Message-ID: <CAPx1Gve5b3yoUFK1VObOjjkFUCG4emaYUnJ-Q7bRyfURK74DCQ@mail.gmail.com>
Subject: Re: similarity index vs. whitespaces
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 7:01=E2=80=AFPM Mike Hommey <mh@glandium.org> wrote=
:
[example of Python script diff snipped]
> From a human perspective 33% similarity feels way too low here. I know
> it's essentially counting lines in the diff, but that feels limited.

Technically, the similarity index isn't based on lines.  Instead
it's based on byte-by-byte matching, broken into segments (these
do use LF or CRLF to break up segments as appropriate but very
*long* lines get broken up without such line terminators).  This
shares some code with the delta compression algorithm used to
pack objects.  One of the goals here is to consider a lot of
*moved* lines to be "very similar", despite such moves generally
producing large-ish diffs.

CRs are, if I recall correctly, discarded during similarty index
computation.  It would be somewhat easy to discard leading white
space -- and even easier to discard *all* white space, but I'd
suggest that would be wrong -- due to the special case already
in place for line terminators here.

It's not clear to me that discarding leading white space would
be correct in *all* cases, but it does seem very appropriate for
Python code.  Whether the earlier discussion about diff algorithms
being adjusted based on .gitattributes entries might apply here,
I'll leave for others to argue about. :-)  (That is, I'm just
tossing it out as an idea for the mix.)

Chris
