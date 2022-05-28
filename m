Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE9C433FE
	for <git@archiver.kernel.org>; Sat, 28 May 2022 01:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351512AbiE1B2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiE1B2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 21:28:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D01269BB
        for <git@vger.kernel.org>; Fri, 27 May 2022 18:28:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f21so11492155ejh.11
        for <git@vger.kernel.org>; Fri, 27 May 2022 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=baMf0qsdI5x4Wr92IxgKSOW+clgyw6b4wCY4snVvBnQ=;
        b=XhibdrS/fh709hYWY4RZIXnlNFKX4/OCQXLn9Jf0gBkE/8p6HDoMMNIBdHptely/p5
         5xx1xl1moKCPvkZE6C+3A0VdF9w8XqZfjJFpIkcTWJ53FtqCHWjxVDK9sGlEoHXUmFuF
         P7skQspHjWWuOO73IvOLvi+C59V87gs8uDIvZRgUktwQP/ouOPz3boyM6ECLhOh2GB6t
         P/fW8qEwrBuRFx0cRSP7cdCutlmsDaaqjG3pwiLXjuC/t2+AwL8YyW3k4jlja+JohhK7
         VOGtMpDLnoauXnT6EiRddFm20L6O0ivtXxqGlKodtsHBGbvnpUWLVJjqV260XaKu0ma3
         Bzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=baMf0qsdI5x4Wr92IxgKSOW+clgyw6b4wCY4snVvBnQ=;
        b=HsdgvVBwJyj6JGLb9Eu2d5rKpZ9OsuZHeyc/K2H79VZHL3ezF0adnCG9lajf35jCVz
         95RUPJpJ2AT1U0wtaDt3cq+q5b2UTtweEz/8sKU4q0iEOfyPiLuMTKW0uA2q7s1IPq76
         tp+4Xz4tL0e2kcAQ5w3/aS7smFrWx6whd7LgktVSXbvRhk0ExKoKxkLub2L9ffF2kvJ7
         MNMNMFXxL8HOx/gJLFZrf1pzQy6jfLPSGTivlzTs3flBMxB3uOfMPWVkDIHSbZsLG354
         b5E9ebqx26Dj6nnduPteTT08xq8bwXJ49mwmKYIdArVMssPjcm5Xf0vp10SsP1wOISAt
         4dtg==
X-Gm-Message-State: AOAM531PvPl+ihQWGJbM/rP1ZwNx2cUDvE9My9rWHZD/0JfPHs6+U1+R
        MApZk2ZWY8AgodcVA9+N7BmHYGzP36gFsGQHT4o=
X-Google-Smtp-Source: ABdhPJy9V67MBUTvpmr/COehbs4ujAAdZ6HwUMqOWVW8dm/g9yI5blpQV97lJg/t/bkqGN9lrLFezD6WBq6CScxKmjk=
X-Received: by 2002:a17:907:97c9:b0:6fe:bcb1:661d with SMTP id
 js9-20020a17090797c900b006febcb1661dmr29988311ejc.269.1653701281028; Fri, 27
 May 2022 18:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com> <YozlZ9DPrRLPBTBP@kevinlocke.name>
 <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com> <220527.865ylr4d4g.gmgdl@evledraar.gmail.com>
In-Reply-To: <220527.865ylr4d4g.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 May 2022 18:27:48 -0700
Message-ID: <CABPp-BEd9bRuh9ruaDN32RUUT8ZtdQGPefVmiB+HM-gFCdnZ7A@mail.gmail.com>
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 27, 2022 at 1:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, May 24 2022, Elijah Newren wrote:
>
> > [...] So, I think the signature of free() is just
> > wrong: it should have taken a const void* all along.  Unfortunately,
> > the wrong type signature sadly makes people feel like they have to
> > choose between (a) dropping the added safety of const that the
> > compiler can enforce for you during the lifetime of the variable, or
> > (b) leaking memory you no longer need.
>
> Hrm, don't you mean that it would be better as:
>
>         void free(void *const ptr);
>
> Not:
>
>         void free(const void *ptr);

Nope, I definitely meant the latter; the stuff pointed to is const,
not the pointer itself.

In fact, I don't see any point at all in the former; with the free()
that exists today:

    void free(void *ptr)

I can pass it a "void * const myptr" already without problems, because
free's ptr parameter will be a copy of myptr, and thus modifying ptr
cannot affect myptr.  So such a call signature change could not
possibly provide any benefit to the outside caller.  But that call
signature change could hinder the actual implementation of free() for
some folks (particularly if a given implementation of free() keeps
extra data near the allocated block with information about the size of
the block and the next allocated block in the list).

In contrast, I cannot pass a "const void *myptr" or "const char
*myptr" to free(), but only because of the current type signature;
free() doesn't actually modify any of the contents the pointer points
to.  (And if you want to claim that free effectively does modify what
myptr points to because someone else could allocate that same memory,
remember that use-after-free is undefined regardless of whether the
data pointed to is const or not, and thus you cannot access that data
after free with or without the const.)  So, free()'s real type that it
acts on is a const void *.  Sadly, the declared type signature is
rather void *, which unnecessarily forces users to cast their types
when calling.
