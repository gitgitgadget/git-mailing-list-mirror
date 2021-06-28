Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF15C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E0961C74
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhF1Nyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhF1Nyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 09:54:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3583DC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 06:52:06 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a6so22355213ioe.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0q1CndmCeLFiM+eglOkiOeN6sSgpw2AKBu3HGjV9roY=;
        b=aO/yAhYg7UASaYvH12sqQ6J1QKVYxYRYYi/Rz1hmh5QtzEN4EQ7xb00X3sLdbKRWnX
         8d52ss09ZfjT3F08OVvraFfd/2PsES+xibvpdDgGUDTpq1/BSFvepnqsQSrbVxIR9m/K
         VjXzo2ly4o9K6FwnfZlL6GdKw2tA3Jr7LjUn5BErFshn+wgA4++kNBY1pr9xQ/V0cKzv
         sdvC43NOyfOfyshQ9g+CignokHFgp/AVlgr8A4NfLDzWz7G0RaNbysQsN/ZtPFtwtlPX
         fSCVk9nAIwMuxb/4C0viGKqjaYWSZHFDx5foLjZMgyAF1lh9NC+A5Lr2HDgY9fzOWq/N
         dM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0q1CndmCeLFiM+eglOkiOeN6sSgpw2AKBu3HGjV9roY=;
        b=cbZq2UKTQtRdAskL0rzfHuxMaRLSZLUmTzfpN/WCqjeXO0EIJDMzQcdIjA4LgGb5++
         LJayQauk/ryeHTl6/Q/ZE7BwBmGF0rMSNchMi/up7WWeW2pw67U1TzKcwNFdOMnQn0mJ
         1bm8RpZDlfSHyZUcey4Pbrfsl3x58OamBtVCUJX9YAIpJndSr7TPkS9RubHAiVu35exC
         cqxTQN3a2fzgCMIOkpkLkGdcs0ODsITycvJemXLtoHEP+BY5yAQpA4Jrg6pwtKf7/VBm
         Vr+n5QdfiT77QPNQeP4Tqz0TgP3E5zueY9Jj/FZ4uwEg0euTXjkxP/ZHi2Gq4V2Aj40n
         hhzA==
X-Gm-Message-State: AOAM532OciPMnOzS3zGJCTHi0U/m2ixMmPJn5Q0T7CCwJFX0j83gNOY+
        F5nzesBqHBzMESrYjiu01sTxrkmaBY3YhjyEPro=
X-Google-Smtp-Source: ABdhPJxOeN29EDPez8qtTOgBdgwBr1WUFGiiOVyBlLW4M4Wf9bifug83FOZ5njIc11DHxwuBtKRDJhbf5FRFruphVJs=
X-Received: by 2002:a02:ba0a:: with SMTP id z10mr23228639jan.10.1624888325593;
 Mon, 28 Jun 2021 06:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
 <pull.980.v6.git.1624797350.gitgitgadget@gmail.com> <9a1f07329401434b5960ef8ae002f11b1133506a.1624797351.git.gitgitgadget@gmail.com>
 <CA+CkUQ-gHT=g3KwcBXkp8eBX7wfY_HkT1=hhRiYLap-Av2w5MA@mail.gmail.com>
In-Reply-To: <CA+CkUQ-gHT=g3KwcBXkp8eBX7wfY_HkT1=hhRiYLap-Av2w5MA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 28 Jun 2021 21:51:54 +0800
Message-ID: <CAOLTT8RLX2Zn7C3hd5JhiAYK9TptXbraf=jobL7Cj+p=uLitvA@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     Hariom verma <hariom18599@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> >
> > Most of the atoms in `for-each-ref --format` are now supported,
> > such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> > `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> > `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> > `%(flag)`, `%(HEAD)`, because our objects don't have a refname.
>
> It's not clear why some atoms are rejected?
>
> Are we going to support them in later commits? (or sometime in the future=
)
> OR
> We are never going to support them. Because they make no sense to
> cat-file? (or whatever the reason)
>

Because in "git for-each-ref"'s "family", ref_array_item is generated
by filter_refs(),
which uses ref_filter_handler() to fill ref_array_item with ref's
data. In "git cat-file",
we care about the object, not the ref. Therefore, ref_array_item is
only filled with
{oid, rest} in batch_object_write() in cat-file.c. We cannot represent
some specific
ref-related data in "git cat-file", so we cannot have some atoms in ref_fil=
ter.
Yes, we probably won't support them in the future.

From an object-oriented point of view, the atom supported by
"cat-file" should be a
parent class, "for-each-ref"',"branch","tag"... they have more
specific object details (ref),
their supported atom should be a derived class, they can support more atoms=
.

> Whatever is the reason, I think it's a good idea to include it in the
> commit message.
>

Yeah.  The sentence "because our objects don't have a refname." may not
correctly express the reason for rejecting these atoms.  I will add
more descriptions.

> --
> Hariom

Thanks.
--
ZheNing Hu
