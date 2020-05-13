Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6BC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD20D2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH+cncxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbgEMUI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387445AbgEMUI1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:08:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C89C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:08:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so622879qke.13
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsdJwVfyQFGQ+UlTf87byM5AKBj0qpXhTmL6uD8x+NU=;
        b=sH+cncxIaekiY14sjLDZULYcB28ODKPxFKdbackZ3MuCSKZwJWUohGfcfgCSMGTs+l
         lSkkUtBJ2FzsfxucPSVLX++ptBC3bv1JdBPF1pFPOB+xpLK5aqq08e9GNEu+tEyxvc9j
         mlNWU5Z1cYTkCzx8kXqdgAXd5qsvbG9hDGeZzeYL6uJvPyGjDZg7Iz8C78a9xW5Vzqyq
         ybfGCXuZTnXd+SAd4t8OcEvCPerq67U5lagXqPhTlOTSDUvFVA6Sb8eN3j32gJkUfCWO
         +IUhhrD/8f10m7ONFTQ+uKALmxY+7YM12U4Z3vVCMQ7cQc+lhtoNVZtzbVVpZd449oM6
         tn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsdJwVfyQFGQ+UlTf87byM5AKBj0qpXhTmL6uD8x+NU=;
        b=CBbrIHv+A6HUoeO4YwKAtoMcO7AbaKMNf9lOiQ5EUvWsaYmgrFjnd3muxBpLroDeW2
         aI9d4fmXpTgSEjIoKhpCA/DBNY+oap+JxbbQotPHf/bTMSneed6pA4nXaHVr9Luz7Qtw
         rKQpfEaVqNNMyPEtNILdnhL4sYYT4O+Mnvz16Fgs4FRHVaBOXXlKBLypHAL+XFWRJoYZ
         XgfPXH2pq4uOGCYkxoYKRhMMGdc2Umy6SkyWHFBTHRAWfwQ8wDO2X2Kr3iQi8H9Ncqkp
         XIUnm4ok81bxuqhjcbdplWfpwPCHkyc0rg7j2ppSg6rGUDTgd75mmKn0Kv0CCl7Nh7iy
         afbQ==
X-Gm-Message-State: AOAM530OdcQFt/CM+NqGgIDN5qgP2k550EJrLdUsV7lRT6nrKS9gneWH
        kmrL2pWcX9+MwQ1Y4KRDAYM2J/ybWnYdftuhE4s=
X-Google-Smtp-Source: ABdhPJzCu3ZON9qrrAZxKnR18uXJG2oGAWCpA14L7/LswTlsDiFPWlPheBKhF0E95HFwhC6A42/PD/UMYpu9kDmDrg8=
X-Received: by 2002:a37:49cb:: with SMTP id w194mr1390790qka.77.1589400504823;
 Wed, 13 May 2020 13:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <9c674372fb58aa42e339c0a96c432283c4b0a894.1589302255.git.gitgitgadget@gmail.com>
 <xmqqftc4c123.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqftc4c123.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 01:38:15 +0530
Message-ID: <CAKiG+9U04p9KbjrAc-g=yS-O_h8Jd8zvPoUjKG1L=-OybSUgrQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] cmake: relocated script file contrib/buildsystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > The CMake script has been relocated to contrib/buildsystems.
> > The changes made to the script involves pointing to correct location
> > of the source files.
>
> This does match what the list agreed to do.  Why isn't this done as
> part of [01/11]?  If there is no technical reason not to, I'd
> strongly prefer to see it done from the very beginning.  The same
> comment applies to the next step.

Okay

>
> Thanks.
>
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  .../buildsystems/CMakeLists.txt               | 76 +++++++++++--------
> >  1 file changed, 45 insertions(+), 31 deletions(-)
> >  rename CMakeLists.txt => contrib/buildsystems/CMakeLists.txt (92%)
