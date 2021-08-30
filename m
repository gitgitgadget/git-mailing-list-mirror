Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28FC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACC2610FB
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhH3MMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhH3MMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 08:12:19 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA82C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:11:25 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id i1so10326804vsk.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4bek7l0hGpG/uIXhFUgOANUJgGMSTbOFakeaFhE6jEw=;
        b=fU1Xjz9BeMGKPglYDH1kYKszsU3kyaPSxIxIRPPlasxq5h+5dLmzBQQeQIdEx88pa1
         aqFR9R3vfpBjuo7b3BVVNizLasEukngxJn7stOOA0AEEjAsUOQJ3hHrkErkfxAa47DvG
         W86H/2gndnDxEyn3jWRZfrk4qHoLwlq2ayHGFoZUDdVJlKktdgWkuKdGdYlK+Nhocn38
         lADsvlFEeayymO1eQiW/RsHE6nt4REXgkC3KqNAo4uRlCUya1TB8HQ0lxtjEenP54AIE
         nLwXLptVmkO4GyEJNJQJqH7ABaGscAw86XkYxCJBe8TBHutngdbWojPub6tj9YHxlXAo
         BjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4bek7l0hGpG/uIXhFUgOANUJgGMSTbOFakeaFhE6jEw=;
        b=RXUXWFcUmUJKLxFYwH8G6akT0BcA334647OXqR4P705gdhzW1On4BTbgvGL1cAyYUz
         KZTKIWuRd9n4a7yIhGy0Mu1gleThSHwZ7KpvQD5YhgApwxjRIXaljIcG03AGyK5COsgY
         5Wy1o3vX0yuirazaEwIGQfZPl5ua6qpA3neT3YawGarSrbXpZZVvw8Ro9AmnD30Ee4yx
         PixLhyzHGOAiBEib6BHZ+a/pm3aA3Jl8/upccIRlmjf71xEdZ30w/Ww9691uZJLI6k0y
         Ma9QK7RJgSByqfUreAt+FynJynI5cYRJKWhJbp8QEDsHszz2wcrdEQRNpFOOJ7Es6fBI
         cQFA==
X-Gm-Message-State: AOAM530RlNTjqRFdG/y3D6KaCwQ+zMnTCTkNofKmvt1lkOsH80blN33q
        A0VDu/aamr3ghRzGewf3WltaVPOqraHV0ob5c+japQ==
X-Google-Smtp-Source: ABdhPJxKnXv9WAG5J5iX6w3YdLBBBwYSNbkuwsCQ+QYoYaD9C5CnI7AVH6y/+hgZk71Umm+tUw5LHObTBk33SpqeGGw=
X-Received: by 2002:a05:6102:3594:: with SMTP id h20mr12919823vsu.42.1630325483796;
 Mon, 30 Aug 2021 05:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwno7bgeo.fsf@gitster.g> <patch-1.1-f7d9c8af0c-20210827T055608Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-f7d9c8af0c-20210827T055608Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 14:11:12 +0200
Message-ID: <CAFQ2z_MRrxBgpP8wy32pAuzQb0BAEH-jSUZA01Atxs4DzRQvKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] reftable: fixup for broken __FUNCTION__ use
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 8:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The use of the __FUNCTION__ macro is non-standard, in this case all
> we're doing with it is generating a prettier unique filename based on
> the name of the function that makes it, presumably to make ad-hoc
> debugging easier.
..
> It's smaller because it punts on the whole notion of adding the
> function name to the filename, as argued above I think __LINE__ should
> be sufficient here (and is probably already overkill). The only reason
> to add __FUNCTION__ or __LINE__ to the filename is presumably for
> one-off ad-hoc debugging.

It's there so it's easy to track down which tests forget to cleanup
after they run, and __LINE__ works for this as well.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
