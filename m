Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F8DC433E6
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58616197B
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCTLkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCTLjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 07:39:43 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24212C0613DA
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 23:16:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so10673181otn.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MU3q3p3OxNXEp9aboM78IisM1b4g9m1FAMNE6P7hUKM=;
        b=fav0/RmnQgcFSo/GjhkNJ5ZN0JACnvbujLXWs77qZWbVUs9w0CmF2nQoUGHgOVZzvc
         JeWh/9AqIE5M/DkN4CWZ6SpJ48QHyRsYCDsLjJ13p0JWNhuZqimElj22k/Ld86BB8wo0
         kb0EGJnUN/jpdktpH61q499j+uygzu9A2tHB2GIpaICvULklkRD6qQ6voR+Ilnv+afYe
         lK9k6kP/Y09M6OLJkcfGYrG3OLm4/G+Cxee2XTefivE11PAY/o6W9oUVphsTWKBTS0Lq
         BccHneCsTk9tOaaB8Y9V5VVtRnkqIyzgMhFv10YJj8W80yzYgd61hMYftzVRCdpKJCKk
         awdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MU3q3p3OxNXEp9aboM78IisM1b4g9m1FAMNE6P7hUKM=;
        b=EggR1gpLYpnv8vLfNG5f2kxpwZsOBDjasd0lq3Bh8UOqmBU97WpBWuWhqGkVTyswGN
         OriyBtY3Q6af1e0xdNZx3rn4spMdlgt5Cq6HQ6SXafCHhbQS9Z2wqoMw9KRssvgeKYZ5
         4x7hjAioWuaG7XPZKPIYsqyJT6VevkWuZJbm8VFyeSanJNLwFxstHIn5lnOGPIZ8bpUV
         ejZXEGNBMYa3MrPvMITC+ioDn5V5DqcxcN78+8KSvhJFwbxf34Gibf8Y3MrtvjPb/Xj0
         bjlBig4hzo2Koyu8/9nUMUddBd47SSgqWlq6zWmGteUvARWApK/a84ycCWcBnqIgd3zW
         kcDQ==
X-Gm-Message-State: AOAM531WOLZOr1CBgna3w5OMCzi1I90C8Sm8zIAYtESXqGNjailtwTuM
        gamo7eWs8BEe1vj6cTDHCm6nxZlKc8DZW9hrrTk=
X-Google-Smtp-Source: ABdhPJwzq28uVmx5vu8eS49pbFXI7ZMIx0zR0/YRyiXrv8XGNVeBGHfXr38RAFlHDh+YpNPdHcqeD8PJ4VaKwzgX0rE=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr3860183oto.299.1616221017749;
 Fri, 19 Mar 2021 23:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <xmqq1rcctgj7.fsf@gitster.g> <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
 <xmqq7dm3p344.fsf@gitster.g> <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
 <YFWCvePMGvBY/I9v@coredump.intra.peff.net> <xmqq4kh6l6fd.fsf@gitster.g>
In-Reply-To: <xmqq4kh6l6fd.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Mar 2021 14:16:45 +0800
Message-ID: <CAOLTT8RE6LOx2AUH8PJMzFdqp4_GJkiY41K0xE1YiSQNixKCRA@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=881:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Jeff King <peff@peff.net> writes:
>
> > If I understand Junio's suggestion correctly, it is very similar to how
> > "commit --author" works. See how it calls find_author_by_nickname(),
> > which finds the first commit matching the name, and then pulls out the
> > full name from format_commit_message().
>
> Yup.
>
> But I have to warn readers that it would not be a sane approach to
> simply expose find_author_by_nickname() from builtin/commit.c as if
> it is a generally reusable helper function.  In a very limited
> context of "git commit", what the helper does is OK to run a single
> revision traversal without cleaning the parsed commit objects and
> object flag bits after finding a single commit.
>
> But generally, it would not be an approach that would scale (e.g. I
> do not know if we can expect to be able to call the helper function
> twice and get sensible results out of it).

Hi, Jeff and Junio,

`find_author_by_nickname` is indeed a good way to find
 the `author <email>` in the "last" commit that matches
the specified name, but after testing, `find_author_by_nickname` is
as Junio say, it is not reusable(use it twice, git will call die), but why?
