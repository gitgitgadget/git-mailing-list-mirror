Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F0C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43916207C4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVw7Y0SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgERSh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgERSh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:37:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D4C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:37:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o26so6215108vsr.10
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N7pzYmofpKzu37Iyx1HAd7U5Mb2b7yELMShR6vWA0xY=;
        b=AVw7Y0SWBzAocSzm7Q8INGTkmaFx3ZJbErYzGvI+c2+sWKutK+d7m75M+HD0GTUb6g
         vqyl1j8FUuF7yINRCNfd4pque8FKb4Ayh5yMac7PgVocGU7Ok0fkaN/jinF0C2bmfMFr
         vkBJLSnQGt7J7zkHJKPgy/Yb0T8el4z7/7PjMrfQxWmeaxfMpXGns5RUEFcIOwhE7tyq
         heHFizoejvdcfQ8fF1hJ6OxCEHjmRyM1GfHaGn99XKl87o0BAvFpceIw/xQX3IhklR65
         cvH4yXYgvBPngvAWNE1iDsJNQQasLBcU3Ol8QhPyXonaoxdFZA3g70fd6DjBC2r0sGnz
         huSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N7pzYmofpKzu37Iyx1HAd7U5Mb2b7yELMShR6vWA0xY=;
        b=KKe5VtQlqQFrL8bvak9nyrog0buNQSJr19PDimiGLqiRA6H+CMWFi423ZAOE7cj6/r
         zjbq0FRx4ja/HNNKzrza9R49KYXSCUvbRl2td+ND3IM8yiyXGWFOqgvWnDNqCPzT+3X9
         kmjgNA0Mitao2g4tBYjqaEvbBTnUokpkp41grv4Z6rtOTZ2hvzn/U8KHsekkI2HCJUtT
         OTmosTjktiPR0WFvyXrM3K54p0q8YskJp2EhCi5GGDGo1BGFDvr64GtWtVdx9vpi8lga
         Tdpt1enT8hx/B0f8dogF6UFTgKI8XZOPv3FmuVIGFYbxQqIAQao4UwFtHKJFTOXl6DNx
         yPRg==
X-Gm-Message-State: AOAM531oG61ndgwK529ki78esTkMx8QsgpVjbj2jIdGWRWCR4JG+OIG5
        sQtdxrgrypHjCfJKm6nSjii65ITvSIjzfz3Gv2gDSYH5
X-Google-Smtp-Source: ABdhPJze1pCMjdyFxaUdKlpNHAZSY8YnD1++dDQFN+9lNKwDA3ZqXSI9/YFxw5/wkwsfDhShml1jt/2PN6Qgw7QzDYs=
X-Received: by 2002:a67:ecc2:: with SMTP id i2mr11611215vsp.85.1589827046581;
 Mon, 18 May 2020 11:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589739920.git.martin.agren@gmail.com> <acfca5465e822eaa6f0ddf85a01f7855d3dfb7d1.1589739920.git.martin.agren@gmail.com>
 <34870e5f-8e61-4af8-1050-43bfbe30d8f9@gmail.com>
In-Reply-To: <34870e5f-8e61-4af8-1050-43bfbe30d8f9@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 18 May 2020 20:37:14 +0200
Message-ID: <CAN0heSo_Y2Esp8X_amPXKaGaOVbP5rnJAyXiuUuW5BFSmwzhwA@mail.gmail.com>
Subject: Re: [PATCH 7/7] rev-list-options.txt
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

(I realize now that the subject/oneliner of this patch is completely
broken. Hmpf.)

On Mon, 18 May 2020 at 16:57, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/17/2020 2:52 PM, Martin =C3=85gren wrote:
> > If we really want a `--show-pulls::` list somewhere, we could perhaps
> > let it begin around "The `--show-pulls` option helps with both of these
> > issues ..." further down. But for now, let's just focus on getting rid
> > of those literal pluses.
>
> I think the way you adjusted the preamble is good. It matches this prior
> work before --ancestry-path:
>
>         Finally, there is a fifth simplification mode available:
>
>         --ancestry-path::
>                 (description)
>         +
>         (example)
>         +
>         ...
>
> And you're right, we do drop the "--show-pulls::" itemization. Will that
> make it hard to link to that exact option? Probably.
>
> What about the fixup below, to create this list item?

I considered creating the list item, but like you, I figured it required
more surgery to the text than I felt like pursuing. Thanks for making a
concrete suggestion.

> -The `--show-pulls` option helps with both of these issues by adding more
> -merge commits to the history results. If a merge is not TREESAME to its
> -first parent but is TREESAME to a later parent, then that merge is
> +--show-pulls::
> +       In addition to the commits shown in the default history, show
> +       each merge commit that is not TREESAME to its first parent but
> +       is TREESAME to a later parent.
> ++
> +When a merge commit is included by `--show-pulls`, the merge is
>  treated as if it "pulled" the change from another branch. When using
>  `--show-pulls` on this example (and no other options) the resulting
>  graph is:

I currently have the commit message below for my patch plus your fixup.

Thanks,
Martin

    rev-list-options.txt: start a list for `show-pulls`

    The explanation of the `--show-pulls` option added in commit 8d049e182e
    ("revision: --show-pulls adds helpful merges", 2020-04-10) consists of
    several paragraphs and we use "+" throughout to tie them together in on=
e
    long chain of list continuations. Only thing is, we're not in any kind
    of list, so these pluses end up being rendered literally.

    The preceding few paragraphs describe `--ancestry-path` and there we
    *do* have a list, since we've started one with `--ancestry-path::`. In
    fact, we have several such lists for all the various history-simplifyin=
g
    options we're discussing earlier in this file.

    Thus, we're missing a list both from a consistency point of view and
    from a practical rendering standpoint.

    Let's start a list for `--show-pulls` where we start actually discussin=
g
    the option, and keep the paragraphs preceding it out of that list. That
    is, drop all those pluses before the new list we're adding here.

    Helped-by: Derrick Stolee <stolee@gmail.com>
    Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
