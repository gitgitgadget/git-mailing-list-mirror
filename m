Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A41C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8720848
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeyCJwNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgAGKyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:54:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37080 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgAGKyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 05:54:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so49993415edb.4
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 02:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wff356uIsLHxVjoizv9/VUBtVYo8+ROxdOlAraLHjBY=;
        b=aeyCJwNwZxRMAUAJj6OxzqW5HMcoIY8Asxu/B/Lzpq0WExaXsVj2jMg37zBVDLV+ta
         XHQIEr5zASEortbtYTMOm61zETbuiH+WTO5Lt3cXcp9ob/x8GRml52JQZbaeJvx0izf4
         ffOc2P+zdzqwJ0FwZNM9l7JwGMfQmym8Gn9+2gAZwCB8rT6V+HaUL6CgkmO0OGSSug9l
         ANLlrvyl+0OWz3wnJoWdnx9HmeGnMVGqB0m85gKoS/HHTLmT9eAc9Hctmloa+fdPjoaC
         3aWmUeOAxqvCwRAJ3PNCHZVFm1XR52wteljAM4Uf0e2A/xjmkrGvtri1VqiyBNhojtjP
         uprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wff356uIsLHxVjoizv9/VUBtVYo8+ROxdOlAraLHjBY=;
        b=WJYynYKOiVxFkGrWT+oyZMuEHS6yll5DpivvB6LS6ydiVMWsVN7KX3hTtZ82Uy/pdL
         Nj7F7TMcZaKTeC1aJi6HidR9OLHO9nKSmzXtGQKLBQlr980qmw0bayVuuOonunT/BJor
         yR/3BPLK24CMOFCbz0kVTXXTRaWyT/JFP6nLcHYwD+hTy/EwLHd/lrhqET9+CVGX51/l
         LgFxKVGPsKQUlFX46CGrcb1/KI+FYUmGoi9fRaPsKmVQHMJ3hQgrOQv79A+eBy6N7b6W
         7b+ycO29P86ON+aiAPwxWhiAHiDE2OmyEkJEo/aHJExmNsnt2bOAS1xgZ/lVW6w4wXi4
         meJg==
X-Gm-Message-State: APjAAAVFtch5uLQsaBzOMngS7hEoGnxQLm/Oa0MVFHVR/kvjL3VNKyeK
        MX/CYcKJ+M3DnpXFJ+y/hz6/iZmHmIn98xGi+7Q=
X-Google-Smtp-Source: APXvYqzkij452nVZgQqs/Mbn9UfhAu8Zn0aEo3tctFGiTyHqq+DOzFFcLGD7wDt1guLYB5/rzf+1H4PXkIFWwWXAmnQ=
X-Received: by 2002:a17:906:bc51:: with SMTP id s17mr113241250ejv.137.1578394456211;
 Tue, 07 Jan 2020 02:54:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
 <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com> <xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 7 Jan 2020 23:54:04 +1300
Message-ID: <CACg5j27ce5BfR9RKekMEXokvCnXiXzmCVsyEKce+HORe8kL_GQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 3, 2020 at 11:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> A side note.
>
> Right now, the advise() API is a bit awkweard to use correctly.
> When introducing a new advice message, you would
>
>  * come up with advice.frotz configuration variable
>
>  * define and declare advice_frotz global variable that defaults to
>    true
>
>  * sprinkle calls like this:
>
>         if (advice_frotz)
>                 advise(_("helpful message about frotz"));
>
> I am wondering about two things:
>
>  (1) if we can update the API so that the above can be reduced to
>      just adding calls like:
>
>         advise_ng("frotz", _("helpful message about frotz"));
>
>  (2) if such a simplified advise_ng API is a good idea to begin
>      with.
>

That's a valid suggestion, I can investigate that in a new patch, I'd rather
keep this one as simple as calling the existing advise function.

Thanks,

Heba
