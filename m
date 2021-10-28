Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE717C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A32E60F21
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1WRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJ1WRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:17:32 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364EC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:15:03 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id bc10so3707562vkb.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiGn5RIcfASprQ3nFLwlLV9xh+5c2ymHi6UhgauYGy0=;
        b=ahQJgRZb9WENZr1vd/H0EMud0ht/fw5VLsFBWP/D1HoDJrhOfuHsAnWY42bAPLIaPD
         Di++FbdO32lAwoS7we5Oqv9dlNujUqNUc0vVURvg0be9Td79XVY0pxZcDalADKMVPofW
         599OGoEFhU/HBkz9nNzH103HtniVOCFEqJh3jtyWLQwzkyp5GDzO+QonnHHaU9oQpxrL
         wTUHKJqgPn1l2ZHT7NORAl6u0tpgpdajiUJuL7HlZzcYC3piOePPSfEhcVVelFyidnWC
         9VfIrTok0w5AZX4cgnvc+zHDUZ/ET4LhniC/0xgvFsh+u9+uTMFSBtpHrdQT0pewAwI6
         cCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiGn5RIcfASprQ3nFLwlLV9xh+5c2ymHi6UhgauYGy0=;
        b=0v2xccLuuqeGHDqaFbZ80oPthjT3KbMw4EtcKEcxqe60rvKRxIpIgLQukDMdX16QiY
         GA+ExXmDI20sMT37EWAwWQEDb0cl0B+Ub8iJ6oKgDxE0chSN8MpQJ+gHKjQKm9HsWArR
         qJ5liNe6W5rnAcq8fvmVD+HZUtUQKokvqlsZ7KcMl3b6pDXHTJCpClLfjVDOTZO5j1xp
         VwI9lEbsQvzcCtz8r5uHrYSk+968sOKd3TDSzSd+b5envI8QrtSvJb4yEnUIgCWInk3t
         1Gjb/W1x4cm5/w6TY/+ctXyyXMxIDojGl9VTOaonqIlJdVJXGor8UkDuPSJX+3Qfy6v5
         9z9g==
X-Gm-Message-State: AOAM532kxccyl96M67Lpp25ehv9YhsyW0PsvCurCuHIHtPcLle2nmWG5
        WGO3jweaFRTkCXBJ7NgFElOmi33jYhRTO/grKlWQ7I4F
X-Google-Smtp-Source: ABdhPJwSXZbW48zyQ14akYiAtnccjPfVTBzTKYKx9exET1yexiGDF7f8TjmbWh+6RP2ZkjUWPSlBMMvIj+WA4E+5qjc=
X-Received: by 2002:a05:6122:c9f:: with SMTP id ba31mr7922311vkb.25.1635459302974;
 Thu, 28 Oct 2021 15:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
 <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <3ffd3a001f742713eb0fde8508f876ff95103d82.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <3ffd3a001f742713eb0fde8508f876ff95103d82.1635454237.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Oct 2021 15:14:51 -0700
Message-ID: <CAPUEsphWBuQybeBe8bjaUFZ=k+5maYCxiY4wche4XLVFPph+fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] odb: teach read_blob_entry to use size_t
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 1:50 PM Matt Cooper via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/entry.c b/entry.c
> index 711ee0693c7..4cb3942dbdc 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -82,11 +82,13 @@ static int create_file(const char *path, unsigned int mode)
>         return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
>  }
>
> -void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
> +void *read_blob_entry(const struct cache_entry *ce, size_t *size)
>  {
>         enum object_type type;
> -       void *blob_data = read_object_file(&ce->oid, &type, size);
> +       unsigned long ul;
> +       void *blob_data = read_object_file(&ce->oid, &type, &ul);
>
> +       *size = ul;

Considering this unsigned long variable is obviously holding an
incorrect value, might be worth adding a "TODO" comment here,
mentioning it should be changed to a real size_t (probably after
release, since it is obvious that change is too intrusive to need this
as a kludge for now).

Carlo
