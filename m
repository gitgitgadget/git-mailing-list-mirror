Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD260C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 17:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbhLWRJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbhLWRJW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 12:09:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B9C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:09:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so23835958edd.8
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhQMSrTVXN8GEpkIluMx0uR9LaopTtVZ1hTPWUzqC/0=;
        b=OTu1pk/amlsvZbNdUHOPoug0cPZGTpQx8TcUpvf+8ZV6cBytD0uwV7SG8XwC+iVNfs
         wOeR/MAYiPM7I9TufT066+y1k/0gQV7kpTA2c67NVc43+b+tGsuSP6MsfAbZGz5mT1UY
         RF2bKDNGkmSOIUHD45mS9nb1mMGrzTNDStdpkz0J7N7piQ5Pfajr8VxvtLVPb9YN8s0G
         2eQiDiz6Z3urhRXQHtP7/u8GcgTAvLM5YoV/EjQTF87jULZFaEXp+Ep0h4F0yLCdphKu
         pPMW0eP1oiAlyJHBo53fE4318bW0iECiAWR/Vjsl1JJ/jPKjfDlQw0kD+IpA6/2+40Ip
         4OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhQMSrTVXN8GEpkIluMx0uR9LaopTtVZ1hTPWUzqC/0=;
        b=5Oxw9e4pL78FoP6BwJF6VowqWSCLREhOh/a4BI9mVA/i54xUmhIg4QJY/hbh3T4FON
         wuSIywrA+0IupHncHyRhtlJdgvbPjnTGVvuCmBUBGE3acvx0kbuH0Y81B+Z2vw4f7lUc
         zJ5Lgruvj8sSMqFYExWyia1fc8svgWlZ6wbpdEIeqdPQeCCo9LR8xz7cpXV35X0e6dv5
         Eb4mFwTJVWAbiejrVb04l64QomLInOXvJ0sO97uLY6kfe2dJY00U1aMkUw5loGGnUXLy
         rFFL/ppD+8YuVSRfeQxKb1QdbWEiBu6zEmHiUZHECMjResPvuuVpA3ZJefHzreQKFLZZ
         MP0Q==
X-Gm-Message-State: AOAM533dac3zLyAi25eqDqq4kSrCu5pi9vDryeU7q2lZeuOzWWJrgjja
        nkV6+qT7vSjihlbO3dwNzf2Ty+V6ITV0v+R0qXo=
X-Google-Smtp-Source: ABdhPJy99x3OmptB+/ffV6LHq5Ebc32XiugeImxfaGS0i466fNmqz53nhaT1V1kRZIZUI/b+0+sDz5CLpx9WT+jCDg4=
X-Received: by 2002:a50:da48:: with SMTP id a8mr2752919edk.146.1640279360144;
 Thu, 23 Dec 2021 09:09:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
 <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com> <09b13280c2619e9dcbf33422c5dcfba84f0e52be.1639454952.git.gitgitgadget@gmail.com>
 <CANYiYbE+1o-8KxY2UGaCMdZJEPtnbTWgBrcFf7E-_ra76=kWmQ@mail.gmail.com>
In-Reply-To: <CANYiYbE+1o-8KxY2UGaCMdZJEPtnbTWgBrcFf7E-_ra76=kWmQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Dec 2021 09:09:08 -0800
Message-ID: <CABPp-BED-3TzbMwm-XFqB_rVp_yOef+koeXmEbb6gTHd0LjXQQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 4:48 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> On Tue, Dec 14, 2021 at 3:24 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
...
> >  static char const * const builtin_sparse_checkout_reapply_usage[] = {
> > -       N_("git sparse-checkout reapply"),
> > +       N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
>
> Found a trailing space in [1], which came from this commit.
>
> [1]: https://github.com/git-l10n/git-po/blob/pot/next/2021-12-22.diff#L19

Sorry about that.  This series has already hit next, so I submitted a
new patch to correct this
(https://lore.kernel.org/git/pull.1106.git.1640279223893.gitgitgadget@gmail.com/).
