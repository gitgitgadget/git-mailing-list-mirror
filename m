Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A1C47096
	for <git@archiver.kernel.org>; Mon, 31 May 2021 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2007F6135D
	for <git@archiver.kernel.org>; Mon, 31 May 2021 16:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhEaQGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhEaQEC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 12:04:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13BEC05BD07
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:40:35 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b25so12161794iot.5
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2fT8euMzjvTpqlx2UJWnNc8xa2TVXYIseQwI4DQAO6c=;
        b=satE6nNOqDgZkVRkKSQza8F1BEiZJqZtH3V7Z9EQGBa9yGRo9OsiUgJgF4ub7jBC3C
         dgUj601j1hSh127oOLvyNs1fcE0HeJ+zI+vTpaD+pcxzdlsL40cO83KmTBM1qhjlJk4G
         bnVjQQqmDMUWw+fKS6zB+4XOdi2BFYj1s1tzLmuo3VnkeuZKmMWPUrgIsFbdq6mV9mo6
         e5SzcJFQ5psxGHONRmZglSECo66DCWYgjgbfZsM8WG0vARm98zb06RSrb3lcB4TG9hAP
         MoZ8lcbelrXP6/6K3Xj4rFXKj0X1uWtSm4tTzI4pMeCCoFBujSLFchI8xH4fzzUoy6th
         CqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2fT8euMzjvTpqlx2UJWnNc8xa2TVXYIseQwI4DQAO6c=;
        b=jKE7tgeA+O/uuPV9kTxPyaBvBxLZzhSuEj1Pc3ylQA3H7Hxn3WUzQO39+EwKKg1hqs
         f8UQJgJat62hjpvBYo7LCTudqsIt9GdqM2tsOIBfVPVcnB30mmCMkX5hih2K+0pb16B9
         /63+m60wHtN6ayqE2wRqbF7g+AV6VDiJsbKpGl7uc1AwgN9nw0AjRAIAQC/R2G/wRx82
         LtS0/4ztaK6TdPGFbtTNr9nHXPnyDO38a+imzwjI8BEglKRIBkPrjnSfsiUPmG6/zQTu
         IcAwy2fQAUHfm5ze7Rn/As4ZZZg9n+ijeXnHerME6aX946CjqaythwoLR06d8DQgIIhu
         phig==
X-Gm-Message-State: AOAM531rerTINXbjN9yFbok6EaZsecX9fhAuO5yj+uKwZ2t51s3fU18H
        KZFc6mnzUeWB4l2PHp0Omuf3VRwy1Lc/FecEZZA=
X-Google-Smtp-Source: ABdhPJyUUy+tE1k1hYDMa7UksH5ZPAMwBX7lwdQQk2bx/wY9oMLHBdpsLuhKNmAPNzwOKOyAqCOI6WdTvz4GJ6uMmyU=
X-Received: by 2002:a6b:5803:: with SMTP id m3mr8612144iob.68.1622472035311;
 Mon, 31 May 2021 07:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <pull.963.v2.git.1622379718.gitgitgadget@gmail.com> <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
 <xmqqtumjy2e4.fsf@gitster.g>
In-Reply-To: <xmqqtumjy2e4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 22:40:22 +0800
Message-ID: <CAOLTT8QFW4UrwZ+OboYqkoT-oKo1Sz3JJ-Fp8b2RWugMOy5Cug@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:04=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -530,6 +545,7 @@ static struct {
> >       { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
> >       { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
> >       { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
> > +     { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
> >       { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
> >       { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
> >       { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
>
> Doesn't this conflict with your own zh/ref-filter-atom-type topic?
> Shouldn't one build on top of the other?
>
> Or did we find something fundamentally broken about the other topic
> to make us retract it that I do not remember?
>
> Thanks.

I am waiting for zh/ref-filter-atom-type to be merged into master. But it
hasn't happened yet. But if I want to base the current topic on
zh/ref-filter-atom-type, GGG will send past patches (zh/ref-filter-atom-typ=
e)
repeatedly. If necessary, I will submit the current branch based on
zh/ref-filter-atom-type.

Thanks.
--
ZheNing Hu
