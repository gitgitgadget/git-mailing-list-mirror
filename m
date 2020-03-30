Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B388FC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E1220716
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m19TfaDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgC3Mw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:52:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42736 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgC3Mw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 08:52:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id 139so8806819qkd.9
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UoNmfZOY1FFhIe/dH/tY01rPaIxD4J/8XG3MgrxmCCw=;
        b=m19TfaDCCE7YZ8QZFWVucFi+KXuirLUP3vkKUismSUOXSB/5Sb1fQoJMjPleZj1Nla
         mSEz30N5QL8cjz/Wj0IJpGEGEqnHgS7tV8rw4QK1v7ZAf+SGLiEnQLi0DWaYVW1ye8y5
         mv633qzyY53z/HfqdNbF87q7AlGIyVPEHC4PMi4cvS6nR3wlCdd385tN1wkOKZGVIl2x
         J0lJHsiKvBjK5i75zz3e6ReAT8wEw3ZMLDM2HJUiYlPrUwozotXzIJZ896+Ow1kOhhFg
         YtiU104L3wcTfc1PCQc9yobEr1pV/AmPV7pQAZNemtSyNT4f5/WJ5q8oHwP+uUuDXdAL
         BH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UoNmfZOY1FFhIe/dH/tY01rPaIxD4J/8XG3MgrxmCCw=;
        b=hn8JnLaWgAZY+68fs0AC7JIl+gMUXc+F86uDWvjkjF00pXY/OkMAVTYaVVLOiAdUUQ
         8bu3YZMMU+Y6YABdp0ge60Nkj0/l9WChd30ue3etqQxNKAny4tOcWj42sqp/ln6qbMKR
         hK1ULHYXHaZLnuasxHDaAChfeGMGXKK/wreijfpSBM+InWSKJoNUO7t+inIzLxsq/j3w
         nIwrGVEN8BL9sUxoEQhqBOdHXHy0UfKAy9jX/wJCfJBfnlfC7Gg3fj6G104qXmjlzcCf
         7UVHMfgtmZIaterUUu3Zg0gV+6IQ3KNZCBY+DSlJ5sAE33FyRyYBX+rNbIfKWvDoeiMu
         TgWg==
X-Gm-Message-State: ANhLgQ07+EdU2sDq5+WHyf8S8jVOQ62pigLECaEYPvrvcr4KSBZNRI6+
        PLsCubQ/DjMh+MMsQK+n6ac=
X-Google-Smtp-Source: ADFU+vvvAiQ1uGCLX1WnK9DtKSyCJAlmOPjRiydSJgBnggL0UVIv7aNVZos3d3i8JNRKeMiMdjibfg==
X-Received: by 2002:ae9:ddc6:: with SMTP id r189mr11426808qkf.14.1585572776305;
        Mon, 30 Mar 2020 05:52:56 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a18sm7991366qkc.117.2020.03.30.05.52.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2020 05:52:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] doc: log takes multiple revision ranges
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
Date:   Mon, 30 Mar 2020 08:52:52 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51E0F312-E132-4E8E-AFE6-570CB02B4590@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com> <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,=20
> Le 28 mars 2020 =C3=A0 21:34, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> `git log` accepts multiple revision ranges, but makes no mention of =
that
>> in its documentation. Currently readers have to go to the `git
>> rev-list` documentation to discover this useful feature.
>=20
> I have a mixed feeling about this change.  Surely you can write
>=20
> 	git log   v1.0..v2.0   v4.0..v5.0 -- Makefile
>=20
> and you can explain that the command appears to take two "ranges",
> but I do not think we want to encourage it to those who do not
> understand what the above actually *means*. =20
>=20
> Specifially, it does *NOT* list commits between v1.0 and v2.0, or
> between v4.0 and v5.0, that touch the path Makefile.  In other
> words, you didn't really give two ranges with the syntax.  What the
> A..B notation means could be called a range, only when it appears
> alone.
>=20
> And we have *no* intention of changing the semantics.

Of course, I understand.

>=20
> "A..B" is a mere short-hand for ^A B, and it may appear to be a
> range, but "A..B C..D" does not make "two ranges".  It still merely
> is a short-hand for ^A B ^C D, and if C reaches A and B (in the
> above example, v4.0 is very likely to reach both v1.0 and v2.0), it
> means the same thing as "C..D", i.e. "git log v4.0..v5.0 -- Makefile".

Yes, you are right.

>=20
> So I have a mildly strong opinion against the change to the synopsys
> and the short-help; it is a bad change that does not help users.  If
> there are not sufficient explanation on the equivalence between A..B
> and ^A B on "git log" documentation but there is one elsewhere, adding
> a reference to help users learn is very much appreciated, though,

So the 'git log' documentation states:=20

    origin..HEAD specifies all the commits reachable from the current =
commit=20
    (i.e. HEAD), but not from origin. For a complete list of ways to =
spell <revision range>,=20
    see the Specifying Ranges section of gitrevisions[7].

What I wanted to achieve with this patch is to make readers aware that=20=

they can write e.g.

    git log branch1 branch2 branch3 branch4 --not master

to see commits on each of branch1-4, that are not on master,=20
since this is not immediately obvious (at least to me)
in the 'git log' man page. Even following the link to gitrevisions[7],=20=

it is not explicitly mentioned in the "Specifying Ranges" section=20
that a range denotes the set of all commits reachable by all given refs,=20=

minus the ones reachable by all given refs prefixed by '^' or '--not'.
However, this is really clear in the 'git rev-list' documentation,=20
which uses  '<commit>...' in the synopsis
and clearly talks about the "set of commits" point of view:

    You can think of this as a set operation. Commits given on the =
command line form=20
    a set of commits that are reachable from any of them, and then =
commits reachable=20
    from any of the ones given with ^ in front are subtracted from that =
set. The remaining=20
    commits are what comes out in the command=E2=80=99s output. Various =
other options and=20
    paths parameters can be used to further limit the result.

Do you think it would be appropriate that this explanation could somehow =
also appear=20
in the 'git log' (and maybe also 'gitrevisions') documentation ?

Thanks for the quick feedback,
Philippe.=
