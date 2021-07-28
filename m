Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1109C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F6860FC2
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhG1LAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhG1LAq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 07:00:46 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC4C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 04:00:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l126so2449727ioa.12
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CXukabnBx7bc2qQA/ESp2h76oSkn9JktPyOjsVYzoag=;
        b=JW4nxXnBGlRlQmWLuFAVFsr5ztJrD/Py0cz9EqmkuwYFe4117Q6VegyP0UHQdyPxSp
         PoveOn9+lfQWMm5dUDqnhbZqflNPRiKZV+ClLyRxmzX92TNTO4GN+NZYoMDnwzJQU1Nb
         dIGJXIEAYHmIslGdJmtiDSq3M7dyNFeNmOdbCfARybq/0PHqzxp3xCuYsmQt3sZCYgZ8
         Kzwsq5tyeY/M0+vpQklKJjRlWbmlH31rj+RlCwOZsw9GhBhzJHd/WvDA+cC+0JOPHuG1
         QNEKNsuXCXlejBp9LKekU9gWZMrBvGTxi6luPUrlATkWNZkn+W3WMKUurxGrPLcTcpUQ
         D0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CXukabnBx7bc2qQA/ESp2h76oSkn9JktPyOjsVYzoag=;
        b=rwuKbUBCc67GgVWpx94+ED+DW85C4clXYYInvgoR0ePrsjbSeTeRtxLDDon2/XzXez
         LvmYdpKmXOagKRh6YnXJxE4UD93KluTjXSHgCB1Eju/KR6CQ7pnZJFBd3Dq+/Lzqostl
         tNDeu8k9onDxCpt6Wx3GsxRK1nbPbIQQ+Nml8kOyxaK6uyJSoWkdktEvOKst+YjAwZBX
         itXodNdCnvVOe/O3QKoaTZ0sFRXuTORvRcvLxSgLlJCk0iLtCTRgme8DgUhBi0D66WKl
         b0Jn1Lk+rk0qfszXRuHbEblq5yfFwKFPKTWI5CdpkSi21ScOPmlgiCt/D9EYF4n33q35
         YF/g==
X-Gm-Message-State: AOAM531RR+zobXkePH9carsaDa3etHABB4jBtBRNaWvxVGguGpHcDHSv
        QeBGaZ4Wgh/ZrAkXae8/zI5oWox7SWcudkbTz9k=
X-Google-Smtp-Source: ABdhPJywCzyMDk45zeEa5WjOQfcyLUHek5/nwYTAGGL0kSRp1S0OM36cefBAOMGc2x6v0D5XsKxkpHuZR7kCaqnFhmg=
X-Received: by 2002:a05:6602:1203:: with SMTP id y3mr23680314iot.192.1627470043465;
 Wed, 28 Jul 2021 04:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com> <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
 <CAOLTT8T9Fu4-r5-2PhNmopW751TBN1LRrwBU70HuKZ48JD1X5Q@mail.gmail.com> <8893cce8-61a7-3469-0c2e-8f6fe9f1b295@gmail.com>
In-Reply-To: <8893cce8-61a7-3469-0c2e-8f6fe9f1b295@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 28 Jul 2021 19:01:16 +0800
Message-ID: <CAOLTT8T-NYEyxabCbSuLkXVKf15LMqf75a0gSR0aGCmeC8dSZw@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:46=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi ZheNing
>
> > Ah, because I want to find a way to suppress its advice messages about
> > "git commit",
> > and I don=E2=80=99t think anyone else is using this "feature".
>
> I'd welcome a patch to improve the advice. I suspect the current advice
> predates the introduction of the '--continue' flag for cherry-pick. I
> think that would be a better route forward as it would benefit all
> users. Setting GIT_CHERRY_PICK_HELP is undocumented and has always
> removed CHERRY_PICK_HEAD since CHERRY_PICK_HEAD was introduced in commit
> 7e5c0cbf (Introduce CHERRY_PICK_HEAD, 2011-02-19).
>

After I modify the interface of print_advice() in the way suggested by
Junio, I can provide a
help_msg parameter for print_advice(), and maybe we can use it to
provide better advice later.
Something like this:

+static void print_advice(struct replay_opts *opts, const char *help_msgs)
+{
+       if (help_msgs)
+               fprintf(stderr, "%s\n", help_msgs);
+       else if (opts->no_commit)
+               advise(_("after resolving the conflicts, mark the
corrected paths\n"
+                        "with 'git add <paths>' or 'git rm <paths>'"));
+       else
+               advise(_("after resolving the conflicts, mark the
corrected paths\n"
+                        "with 'git add <paths>' or 'git rm <paths>'\n"
+                        "and commit the result with 'git commit'"));
 }

> Best Wishes
>
> Phillip
>

Thanks.
--
ZheNing Hu
