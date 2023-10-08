Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B37E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 22:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjJHWkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWks (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 18:40:48 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E0B9
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 15:40:45 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a21ea6baccso48146427b3.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696804845; x=1697409645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW25U7pWk4Xuvf0VQqlobz7FPkqvfrM7+gGMfHddQpg=;
        b=Nrc0MFw3QId/MqENqh5msOLE3PXMndLhfyBMX29//8LkWusBLfBbjR0QTXjkOS1uFH
         Art1XpVjuahFwA/7nGSfN10K2Ci0hGOIEay6NSAv8pa66NcwJQrG0f7QXeAg9Lp6jD1J
         aSWcvfAC3NHczKjLSyiiPbB6VFg/Nl+92eJGRwA7jRWG7GAFIqV3L5/9aLC9z/ipvOtz
         nxte/M838p+lLp3WKBYsDg42xE1sez/zCUkGPn9/8FE2jPJKY6qXp9Q75/KPyWMm9EhP
         HRXdMTeEjoAaDiQoSYOVaU3BO0qNhqF1dG8JEZe9zEdDz18De4L7cqNuqXzePJ3xvU8I
         7qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696804845; x=1697409645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW25U7pWk4Xuvf0VQqlobz7FPkqvfrM7+gGMfHddQpg=;
        b=sesFsmSPsNbYUhIZZDz4+zpXcdfL5FQbpkr0W4cYaLN0fW7ww/PjWlE1npDLixfZQn
         3G6BNQ/e6hIF8eG0DjiBE0v4HvoHn/Llt8qLeoAld1cNgOW4KNizCdRWeLdTwa4E6FVO
         2CT5ypOyKnwtTqtX6a4/cRLIAJ0av/Q9ZL1Y0Qp7sBIArSikyR63yMK8fvvBYav0pHKs
         E0G1vYf+LbUyJcFPBVt1PyU+jK3KQ0M1Xu52IDylDAvQXyPMfTpnE+guAjSz7o+Xwfxr
         p7/wUX2a6Oc4JJ4WeM2u5OFFhKpOMOMNRCADS9dSVrX4+SL0EWU3cC/VwdXty/NyzfXQ
         Zj4g==
X-Gm-Message-State: AOJu0YzOTl/fj/WsxjIrlKtLBqGoWLjeVc18UewdPjgG2MmmsFAjdt26
        yDWoEqVTVcOMxMS3Ph3iHcZBdlKfOb2ULFPo0K+ZVcJjSwZCgfc=
X-Google-Smtp-Source: AGHT+IEv6NYotAF8JEaw/9JqyqhhGskFgk2/dMZEFVZYNa0mEt+Y/QL3JddeOpxLJPJgwgRxvuPkDiBdqiUZtfTeHmk=
X-Received: by 2002:a5b:110:0:b0:d81:85c9:cea9 with SMTP id
 16-20020a5b0110000000b00d8185c9cea9mr11867412ybx.65.1696804845093; Sun, 08
 Oct 2023 15:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACS=G2xBNMMTSCSsVFe3M3jFN0m0pZ-j_TAz3r6xmQrgdRujfQ@mail.gmail.com>
 <e22b6211-8534-417f-a647-e36cb00eee61@app.fastmail.com>
In-Reply-To: <e22b6211-8534-417f-a647-e36cb00eee61@app.fastmail.com>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Sun, 8 Oct 2023 23:37:02 +0100
Message-ID: <CACS=G2wnQEVqiUA8Jy=iaaAnRv7bMKmegR2rGR=Tbhf7UuLR4w@mail.gmail.com>
Subject: Re: [OUTREACHY] git send-email issues
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh wow
I read about gitgadget but didn't understand how it works, I'd
definitely check it out with these links you sent and I really hope it
works. Thank you very very much

On Sun, Oct 8, 2023 at 11:17=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> Hi Naomi
>
> On Sun, Oct 8, 2023, at 23:59, Naomi Ibe wrote:
> > I've used the --smtp-debug tag, checked the official docs and other
> > docs too, plus stackoverflow,google and even chatgpt, but nothing
> > seems to be working. I've even had to change my gmail password tonight
> > but it still doesn't work. Any tips at all would be greatly
> > appreciated at this point. Thank you
>
> Here [1] is a good resource for setting up Gmail for git-send-email. It's
> a bit of a chore to set up but that resource was enough for me to get it
> working. One of the things that you are going to need is an App password.
>
> But have you considered using GitGitGadget instead?[2] You can make a pul=
l
> request on that repository and then the program (gitgitgadget) can send
> the emails to this mailing list for you.
>
> [1] https://stackoverflow.com/a/68238913/1725151
>
> [2] https://github.com/gitgitgadget/gitgitgadget/
>
> --
> Kristoffer
