Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45698CD68E0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 00:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379270AbjJJA6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378608AbjJJA6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 20:58:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402C9E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 17:58:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5046bf37daeso6631644e87.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696899483; x=1697504283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mOYFJf8XEDF6YHu3MRwVxE6VS3vQPK5lul5JZdn9KQ=;
        b=NsXH3vtuhi/dABu7NpVoVgiBU0+9HHCPVb7amS0dZiC95MT6LYYHBRWc8Dr9xBcJuX
         bEIEPbn3LQK2Vum1RWT5prvTjdO3E+/KMR8MnykiSt0JYZtUc9oAnruTVBTUuuYA02wf
         HEmPLMjI7a+pcoz7i4XVKZazyODyw9xkJL8anKuJ9kMJmB+o2a+w24GNdtr05AnPDYLP
         0Xah5OncVUg1RcxzHXTVNlD9eni0tlJtiYwB6oko635gLnRJ96vHWGkcf2TIEX3d+qEr
         JoWOlF4SkZvjKRq1xcgyvLs713OiRJ/W98NurYgd/+EWqY6TpEDNvxaG9+raaTh1rPYO
         M8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696899483; x=1697504283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mOYFJf8XEDF6YHu3MRwVxE6VS3vQPK5lul5JZdn9KQ=;
        b=McUNqilMIcAvhCpSpmhz1CgeEmuzPp1AJZCNFIlPr8fTBPetu4oU7NuOtadJTe2ZaC
         sLCATLJ/Kr0sCrPfLJVE0/0FRlFXJ9ssZAP4sVjiQEA7iWDU6ZyZl1bSW8IVDYJWU3XE
         GJVx5I7YBLXrfug7gjYoo0qxjkaTVmXZSoaSUYdjjXM+9HTMUypa/f4ifgD0AaujpSkj
         f6XQsOaOsA/e2ZpMim/cvC2SLR2PoNGBZRFQej/io/aGfBGlASLLCJmE2r3Zwdtvd0kl
         HGxfLIvvcmKpeHnsFWGtOvDiPMaD46US18w6uDaj5irLx5VpcQxD1CaTHuBM2OjbJRlJ
         QZGw==
X-Gm-Message-State: AOJu0Yz63vZZ5NvW+HK0TkVYgkh3Vd76iVYJmV7dLFvWc1Y5FaQTJN9y
        eYg9jRrwhJwkkhyChBOj6a/kNVgRBTamXUZvXQ8UwBUA
X-Google-Smtp-Source: AGHT+IFB23R3mIq9yFpiAyUcXyAVTgRlVEbMardDmQ/LXzUYw9PtzbBluxODDOAnKOY+AEi8qJM/dfhX8pWY7qx8+dk=
X-Received: by 2002:a19:910c:0:b0:501:bdde:5a49 with SMTP id
 t12-20020a19910c000000b00501bdde5a49mr12466110lfd.15.1696899482946; Mon, 09
 Oct 2023 17:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
 <fffcf580b29153a3c4c7ead3abfb2b621d3a0d46.1696747529.git.gitgitgadget@gmail.com>
 <92beac82-f0fd-452b-858f-453cdf21b71f@ramsayjones.plus.com>
In-Reply-To: <92beac82-f0fd-452b-858f-453cdf21b71f@ramsayjones.plus.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Oct 2023 17:57:50 -0700
Message-ID: <CABPp-BGGj1tfAEtjuS-O6pMK-BfdKb=RZDenuoppLADbFXHcfQ@mail.gmail.com>
Subject: Re: [PATCH 03/25] documentation: fix typos
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 8, 2023 at 9:32=E2=80=AFAM Ramsay Jones <ramsay@ramsayjones.plu=
s.com> wrote:
>
> On 08/10/2023 07:45, Elijah Newren via GitGitGadget wrote:
> [snip]
> > diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat=
-pack.txt
> > index 870e00f2982..42afb953e8c 100644
> > --- a/Documentation/gitformat-pack.txt
> > +++ b/Documentation/gitformat-pack.txt
> > @@ -17,8 +17,8 @@ $GIT_DIR/objects/pack/multi-pack-index
> >  DESCRIPTION
> >  -----------
> >
> > -The Git pack format is now Git stores most of its primary repository
> > -data. Over the lietime af a repository loose objects (if any) and
> > +The Git pack format is how Git stores most of its primary repository
> > +data. Over the lietime of a repository loose objects (if any) and
>
> Hmm, this tyop jumped out at me while this patch
> floated past... (at least I assume it is a typo!):
>
>   s/lietime/lifetime/

Oh, that's interesting.  I wonder if the LLM did fix that, and I just
didn't notice it.  I suspect so.

Anyway, thanks for catching!  It looks like Junio manually squashed it
in, but I've also got it locally in case any other changes are pointed
out and I need to re-roll.
