Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F457C4332F
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiDPCIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDPCGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10215A15
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:01:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q19so9293143pgm.6
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGxGoiKHZ671DX2D2W8pTbswD9FxumG9GDovG70OAtY=;
        b=QyX18gsHf8ZjutIn10+lJ9pB672ddGrAWo2fAmL+RGFz3rqbA/rvKSugHUOnU1ZhEv
         0pZcd882ojLp9agQ8iQJBsVSchgXndGAkTxGn6k+Iz1k5u/+WQiBJPGZ4NISFFrlC4Yf
         6I3loDcjKXU2laqHVpLoK373IT1VckYVvMB4lAaENCIqC0sHCINCMMgMiYtPtJFOJGWr
         tHPjbe0KNOdipqCzyuLQ/30XeIWdiju/ciUZGFXEVrRbM1U1p9RXt9HBdmv/vfSYSitj
         3fkwRjOF7XN/9C+1RHVFGca4tPl52hrbXiUw3TsFNrHrLOejIVzmZmTDTWnEw+pGMPK+
         tANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGxGoiKHZ671DX2D2W8pTbswD9FxumG9GDovG70OAtY=;
        b=E+Oy+0XYRVsqpcRYhX0VhI8lDyE0TQrJEkfNfKAwvm3TbGpupivOEvM5OmTHOPS/Dz
         J3i3whnv7ODE7bBIzIRmrh4Y5/7eEIxSl6Bb4w25C+uEuj7Z9E7CJsxQw+3bEQBP4aH8
         1aWPByf34hpI4/hLrIElSCHQ7GoOcFcY6ZKiQhYauDKRT4qZnXb0CRFdBsoAfEVQgWbY
         tLkn071cUQInw46ppFOrdL6Qh/ItAh6v4U/wee/GGZTOKFT6OsxWxAWdh+8z9aMMTr7Z
         TM2BSvJz2zz3U68tjdsPJmOgUYoW6MfaN3rki4ezLxXYULMGhcox034dgNTnkSCRwS95
         okNw==
X-Gm-Message-State: AOAM531HRcgnt8xHMmNlfO4uJfo6RS9M21FeQjG8VubyfA6v3HRg6zms
        UkFGNw9j6DjbvEOZukWYQ0PB73R9hXSDnKCiUVAkV9xvZlQ=
X-Google-Smtp-Source: ABdhPJw5pl0Qdk7URrpHIJGvXOOB6dMdABaBIP67PGDCb3ivZ1KWEYWV/vF4r8gacNUgvpqF/E5/kbjphQY7nN6tj5U=
X-Received: by 2002:a67:7242:0:b0:329:1f29:4b4c with SMTP id
 n63-20020a677242000000b003291f294b4cmr398753vsc.1.1650070328658; Fri, 15 Apr
 2022 17:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220415123922.30926-1-carenas@gmail.com> <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-3-carenas@gmail.com> <xmqqh76taplg.fsf@gitster.g>
 <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com> <xmqqwnfp98ix.fsf@gitster.g>
In-Reply-To: <xmqqwnfp98ix.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 15 Apr 2022 17:51:57 -0700
Message-ID: <CAPUEsphXnLfnoM6qznVhaxVdOPk-38+Jaj7OEOY7bEvMiDgz3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 5:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > this would be IMHO a better fix than the one currently queued in
> > ab/http-gcc-12-workaround and indeed squashes the warning with the gcc
> > 12 version that is likely to be released with Fedora 36,
>
> That is an excellent news, as ...

Sadly I botched the test, and was doubly confused because =C3=86var might
have botched it too the same way as he originally reported it
worked[1] for him, only to say the opposite in the commit message for
the reroll.

the warning is not squashed even if we do the more aggressive BUG if
not NULL first and now I am even doubting there was a real bug to
begin with.

Neither this one or the previous one had bugs reported to gcc AFAIK,
until I raised[2] the previous one with Fedora, so there is no
confirmation either from their side that they are indeed bugs yet.

Carlo

[1] https://lore.kernel.org/git/220127.86mtjhdeme.gmgdl@evledraar.gmail.com=
/
[2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
