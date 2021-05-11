Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44854C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090C06161F
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhEKG35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEKG35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:29:57 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F6AC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 23:28:49 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so17139327iob.6
        for <git@vger.kernel.org>; Mon, 10 May 2021 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+frpMShiBN5OMziTKCzRI9wQj8JfPGMMTTemzZOnIrE=;
        b=tGEcddyGLndz9RJNFDuoNkqja0xQT0cuutw74is+xDuyWo1emYafCo1S6eMDZNTG6B
         tikDEK0K87M4pfxmZ/mgDV4csxLn6KXx28U/fqvf+Ll59ejf2C+my29oVVUM2r4XemS9
         PigJwx70EDzyCGjqEDkt+AUFUJPiKN/9Rq2bW/kL2Q7UAnZzUyRcGR/1F2FLtuf5FFzY
         5FAY577LGfz+bPJmeq0w7zT6q4Qphfs+ShmAr2aMZlWXoqQ7iGGnItcDg1xiWnFd/VVD
         ekToMsfe0vm0PHeaOs7Jv3JtI759fWDArO8Mq01BFN1qY9qeNLP0/fD0KY83d9fWk1At
         pzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+frpMShiBN5OMziTKCzRI9wQj8JfPGMMTTemzZOnIrE=;
        b=jYT+NwQLVftXpnE0bkluktJBudVfXgazNXSPq+6e5itqjHC/7FnEqFXkuulJ60IM/z
         gT4p+rs2hRzB7QvVmTCKKjNtK9CDH88X/PKhOQSgaG9K2vw1XqhzgzGZ4it8QmVgmm0N
         SQyeLSiR3UqyqiDYydeJpCHeM2X1kLxUHlPrd7NLwKPbgx33NNOQpLZnXL98JARex7oE
         vUUJ4TX/uoZ7EgD65HzbJv6MrYLcfwLSvjWl3PrACX666hpgKQJUGYZAs0q9Nfn9oTLE
         VxwOiEeSw5e8v03oWQP95A7xYsbSFL1VSXihMukxuu17ld+Cg1YT+kNZSmTPfE3hKW8x
         Nzeg==
X-Gm-Message-State: AOAM532u8ujZWRa1OmPCpdFyCa25hc0cKsZQVgsogHdA7MZZl3jy/Gsl
        TKBuGjYfTHm5tRUjdP5WrvdlDaDNNR5EXE0ZLP4=
X-Google-Smtp-Source: ABdhPJw9V9QA6QTfSDzB/G0XSnMb/UHB1ysXlite4xJlO6t/S3+LvOOVFuXHqheWDP8y0mkqxyqbeYEbCNVOELmmrbI=
X-Received: by 2002:a6b:d213:: with SMTP id q19mr20645241iob.203.1620714529228;
 Mon, 10 May 2021 23:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
 <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com> <xmqqcztyovf7.fsf@gitster.g>
In-Reply-To: <xmqqcztyovf7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 May 2021 14:28:32 +0800
Message-ID: <CAOLTT8QR4Ga41ADKhgB4=C7VgGbJEe5G5HSbcjRb51H2yQVRPA@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:29=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >     Change from last version:
> >     Prove that the bug may appear when using %(color) atom. And add
> >     corresponding test for it.
>
> >      ++test_expect_success '%(color:#aa22ac) must success' '
>
> s/success/succeed/
>
> But more importantly, I am not sure how this is supposed to
> demonstrate existing breakage around the %(push).  Did you mean to
> use %(push) instead of %(refname) or something?
>

Ah, I don=E2=80=99t think this scene of damage is related to using %(push)
or %(refname).

We are just in the process of using `populate_value()`, if the atom we
specify meets the following conditions, then the condition of
atom->u.remote_ref.push!=3D0 will be established.

1. The atom that triggers the bug , its "if" condition order must after
"if (atom->u.remote_ref.push)", such as %(refname) or %(worktreepath),
they can be executed correctly because their order is before "push".

2. The member size in used_atom.u corresponding to the atom must
larger than 17 bytes, because the offset of "u.remote_ref.push" in
"u.remote_ref" is 17, the satisfied atoms are only "%(color)" and
 "%(contents)", their corresponding members are u.color and u.contents.

3. We happen to be able to fill in the 17th position of these structures,
 which makes atom->u.remote_ref.push not equal to 0 established.

So this kind of bug is not related to %(push), an atom that satisfies
the above conditions will make `if (atom->u.remote_ref.push)` be true.
then execute the program logic related to `%(push)`.

Now, we only have `%(color)` can trigger it "sometime",
It is unpredictable to fill in the 17th byte of used_atom.u.color,
so we cannot track all the atoms related to this bug.

git for-each-ref --format=3D"%(color:#aa22ac)%(refname)"
git for-each-ref --format=3D"%(color:#aa22ad)%(refname)"

will trigger the bug.

git for-each-ref --format=3D"%(color:#aa22ae)%(refname)"
git for-each-ref --format=3D"%(color:#aa22af)%(refname)"

will not trigger the bug.

In other words, we cannot use a perfect test set to cover all broken.
So now `%(color:#aa22ac)` is enough for explain the problem of this bug.

Thanks.
--
ZheNing Hu
