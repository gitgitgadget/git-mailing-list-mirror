Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F6C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 05:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiBCFTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 00:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiBCFTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 00:19:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE88DC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 21:19:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ee12so2469276edb.8
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 21:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ez7U9ZbYAMnfmyE19OiiVTz9Sq7w02OzW2YcVD2RSAs=;
        b=ZZ0MomC1U06Vs1/LcO9Btgn7TPilI5dT6p2fSFRmbmvUaJ3jBigcrN+KSLvOagFgnR
         S6yOhjkKcjPUf5q+48iz5XZpQNy4VHWmC5xXHPvlfvFBUmMh08Wa06NDe/h8GIjIr+nG
         fwbbb5stvtgDYIydJhfZoGk+Ipb6Yx5wygdf5yrkQuu3qv/ig/qL7teSpSZhsGwS/1Xo
         OTnwtEBSEXet/VlVx3d7PHavSAMNuLUWsmHd3QV2sCeMBDmMxAIa1iZ8q/Oarj0VRFKq
         tfGSHIEoI8uHFiexzZznZHE10g/UP4NQgJw5TEELf6al6bjfgCWjRQH41+lz9ROYcv8a
         ztGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ez7U9ZbYAMnfmyE19OiiVTz9Sq7w02OzW2YcVD2RSAs=;
        b=rRGAA681tTcAcPM7LuBM28kZIOrzwuOBPvq4KnsqUiC1Q27wu8AQidiXezI5IjxBKn
         ro5dqoRDCM70s5aPRvnUDOwWrFctVw7QARGngo7I2EZueOKpt6DPeyHZkxaaky7soC0t
         HOnTgBE+R1yXlMqNKxUeScjX1EAQuDTRuD3ArIPp2gUPW90Q9UTv3/nkF+vdy6YMm+cn
         +M5mhVNAC40zzjww1dLgvhJaImZIKESza/zfrHkbYVY4S9PWiHwS/Ymg3Ri6IwN3zfOO
         jO1VlYa4Cdaqmq/D2EJ2a2Z8Jo/3GoJCzMcrs2YO50fEq/tgxe1kJzhHRG0njdqg7EKK
         JwoA==
X-Gm-Message-State: AOAM530Svo4Oy5ReTEnFp6tipugh+r1aDKdK7IYEGnAzCrIeea4QOJSq
        KoCYGTUIJBnbJoTOoxwJDjr5p+UGOlkIfdroFcA=
X-Google-Smtp-Source: ABdhPJxxr7bqYYtRVJxu9uzDg/FvSKyk9SrYZwAOwVzUFUD/0LiZEVUhm0GKzqZ8hP4xAgreuX1Y6Nb1rxc8iq59AWA=
X-Received: by 2002:aa7:cc09:: with SMTP id q9mr33424889edt.101.1643865553200;
 Wed, 02 Feb 2022 21:19:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <2188a8ca1e77f2f5f8249f8b810775205ad529a6.1643787281.git.gitgitgadget@gmail.com>
 <220203.86mtj87o67.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86mtj87o67.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Feb 2022 21:19:01 -0800
Message-ID: <CABPp-BFUqRfptuPgGJ021V-O3SxXFfnHzcPP-qF+g_tsZ53RMQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] merge-tree: provide easy access to `ls-files -u`
 style info
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 5:07 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Much like `git merge` updates the index with information of the form
> >     (mode, oid, stage, name)
> > provide this output for conflicted files for merge-tree as well.
> > Provide an --exclude-modes-oids-stages/-l option for users to exclude
>
> This.
>
> > +--exclude-oids-and-modes::
>
> No longer matches this.

Thanks; good catch.
