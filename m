Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AF1C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15226613B5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhJDSfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJDSfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:35:08 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CCDC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 11:33:19 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id t36so13090955uad.4
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BSe4BeYEK0otn6i+xaAYeRRe6O1LoFbSFAapBVFsTsU=;
        b=YG3xPAz5zGSe4GXqfD9btOWp+QrLpg9okYn+GHbFo6l6yZgZf1cuYcZ7ryemDsa/Z5
         EmMJUWD6AScBuTeXentdRbW2B9I9iWxgDM6eLnJ8Sel4QF+9fnFEC2uLyGRN59P4hwLq
         0LQvVPsacWj0A6l4xsyL87z6uoagG5T2gNO9CBelLO41AjtmpbXl/MK949S+YY98PMz2
         KUuAwJExEhghksm3FIVS6Q1ePJ53x4TRO2J/L2U4Qca8VKUMFJvFDt3OOft9kzwyFsBG
         YmTh9Xff6lbaa9D1RB/AKyb5DLVUST/eBzEyUS3Jsh4zw+OueCAqZy7FsL9ePaFeuKKf
         ozlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BSe4BeYEK0otn6i+xaAYeRRe6O1LoFbSFAapBVFsTsU=;
        b=LdSorAS483S6bFVwmagNWQM1d/ZjkLL6HtvnSPNG4sr7/41OK9zaPhEaEzIH/yrvyS
         AOEa7olZs+bU62BgdrYvE3gSlQGsTNA1c58AYy2cboa4Ij72JJ2jGP9z06lWPY7CGrfa
         3fIwzAuGKMVdwaTx+zhVrUqn/gUFAq/oi9wxKtUJO62Mgzvcke/M1S6tZRN78anEiuZI
         9sdpYpeIl+hkVCjiG9vKGjzYwDNx5PrRM/MQC9/PsBaZEmsyNOEFKX66obwXJ3ZMcbCP
         SmVQdYvhmXUf0kgL2MLo2TxBhUxXPpzyV7HOYbrvqG/VOsvR2Ajvd8/kpzI3SHE7CVjZ
         o3Iw==
X-Gm-Message-State: AOAM533AM5ovT1B1MdKnL/UybGLufPniBlPJ03LwhKvUj6EQjKxA1upJ
        RHW0GxktSx2Inv9Xs/p2WBdZ8OvRo+J2FKSOFF/F0PrcBpI=
X-Google-Smtp-Source: ABdhPJw1VHKXNlxI+6jTtEZW0F014R5i6N7CfCuaVquYYIBuPGCKEI4s1U/oIkATLVHvLwwsNa3+rtBotXUer4NcEME=
X-Received: by 2002:ab0:63d9:: with SMTP id i25mr5333488uap.138.1633372398684;
 Mon, 04 Oct 2021 11:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211002153654.52443-1-carenas@gmail.com> <20211004072600.74241-1-carenas@gmail.com>
 <20211004072600.74241-2-carenas@gmail.com> <xmqq1r50ycgf.fsf@gitster.g>
 <CAPUEsph_Aqaveur4qZ+Z+85gw1z2CvPOkzbkqW9zt56RoHhUJw@mail.gmail.com> <xmqqlf38wthy.fsf@gitster.g>
In-Reply-To: <xmqqlf38wthy.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 4 Oct 2021 11:33:07 -0700
Message-ID: <CAPUEspiQrGDyYrBUmeMh0C1uPDjUE5d--5zT4vZZUdNr+xtAxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] terminal: teach git how to save/restore its terminal settings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Arenas <carenas@gmail.com> writes:
> > On Mon, Oct 4, 2021 at 9:36 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> >> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> >> > diff --git a/compat/terminal.c b/compat/terminal.c
> >> > index 43b73ddc75..1fadbfd6b6 100644
> >> > --- a/compat/terminal.c
> >> > +++ b/compat/terminal.c
> >> > @@ -8,7 +8,7 @@
> >> >
> >> >  #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
> >> >
> >> > -static void restore_term(void);
> >> > +void restore_term(void);
> >>
> >> Curious why you need this because (1) we do not have the same for
> >> save_term() here, and (2) we include compat/terminal.h where these
> >> two are declared next to each other.
> >
> > It is in preparation for the next patch where we will call these newly
> > public functions from editor.c
> > I'll be reusing restore_term(), while save_term() is new, hence why
> > only one had this change.
>
> I think I understand all that correctly.
>
> I was curious why the patch left a forward declaration, instead of
> just removing it, which it can do because now we have the necessary
> declaration in the header file it includes.

of course, just sloppy coding on my part; will remove in a reroll

thanks,

Carlo
