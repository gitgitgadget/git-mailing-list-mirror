Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69972C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032D0208B3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqv9rZ8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901070AbgJVRtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901006AbgJVRtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 13:49:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B764C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 10:49:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o26so3544973ejc.8
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mkxMOvTqcmrPGhOu/GTisW+QFYj1aLtVWPxgMqOWMhQ=;
        b=Iqv9rZ8oNfkd2oFG7b8ws0e4djkxI0EGSBQ7sKh9ayrrV8hk50I5Zwhbaihop6ygjt
         Zd+pm69er67+MoCYjhqwfge9wjLBkHQurJoJg3aYCxDiGRqdfBTN+qZi1F80u/rHgwJi
         ZTyhGRbt7M0DsXqyBZ+4XuHcSPd2PxajOHo2yGHZHJOjX/HP1I+u+fMFYIcR5Ht52VKn
         arnTtAHJ57SaLCplWOQ6OOk2kYe/BUZC6cSPhmYnGIF6LunOxFvSBbFwVHkhHvUT9f6u
         20HejmZvYc6O8N+XasjROjRZxb8qPg7Eorl2zRZJYuZdcqR8xuF+xd35V4JtJQnj5HsA
         keUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mkxMOvTqcmrPGhOu/GTisW+QFYj1aLtVWPxgMqOWMhQ=;
        b=AVGsKuj311zZTlyyEPpz8V5VzQuUzuOIzqINMoqtA5+YQDtmsrtYmhenuRnt2vsOCU
         lqsj26v7Wr1wrGNUBnaEs4JYjJyYpDi2mNS7Gv2iW7Kv/VLPtBDDEMYmn/sByN8gAW5R
         i/pmqpeBkkhl8qpF56ORmTDEkbgSRKBmfVo+cVe4PUJNr3fQ/WMmVaTTFaDDf0JlV4Pk
         /FIdlQrtyhRXyl4KseaWtWfDgoQ8UkFyQrb4s8LIGRM1XTITeXUizrtsq+F/iZf/Ey3y
         UCc53F8YP0NBw1ET5RXZCRYQ+PoHakaDftXgUKCc6nAhm9yhkiUai0Aw0xPpid68uZqj
         jsPQ==
X-Gm-Message-State: AOAM531arDis2OnJvglgDz0a2bl+AVFn715ps8j8Yt1iIDP3UuGujw2r
        SqnLpbK6L+QARvxvsWVXX0NIE5eaYWmg6WaVCaSW/KYa4DE=
X-Google-Smtp-Source: ABdhPJznj5NqPENhgaAZHRD0IHHGrAj/4qQlaZyMwSQxmiOltqOfqySp0p9wAiYqSJCq5EulxudGReMm4+7Sp39OuUM=
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr3290012ejb.187.1603388946641;
 Thu, 22 Oct 2020 10:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ8Xv03UgMgvye_FSOtxHZqtW8rNEzx9n0oG+ASBi61YNSBFww@mail.gmail.com>
In-Reply-To: <CAJ8Xv03UgMgvye_FSOtxHZqtW8rNEzx9n0oG+ASBi61YNSBFww@mail.gmail.com>
From:   =?UTF-8?Q?Mat=C4=9Bj_Korvas?= <matej.korvas@gmail.com>
Date:   Thu, 22 Oct 2020 19:48:55 +0200
Message-ID: <CAJ8Xv03-tu_RvWrtBFoConLdqdiqJkwo0sC+-DGDMqF5MoKrMw@mail.gmail.com>
Subject: Re: Git difftool prints diff to console instead of launching difftool
 in v2.28
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git-2.29 became available in Pacman, so I retested my use case and
confirm the issue is still there in git-2.29.0:

(3.8-one-nlu-dev) git:master 22.10. 17:16:48
matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
:; git which
49303343575ac358a42e8819e3f26ce57a13e0fc

(3.8-one-nlu-dev) git:master 22.10. 17:16:55
matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
:; git difftool --tool=3Dvimdiff HEAD^! | head
diff --cc one_nlu_tools/util/number_formatter.py
index f70adbe,f70adbe..d2122ab
--- a/one_nlu_tools/util/number_formatter.py
+++ b/one_nlu_tools/util/number_formatter.py
@@@ -1289,96 -1289,96 +1289,6 @@@ def format_polish_numbers(text, convert
          text =3D re.sub(r" (kropka|przecinek|,|\.) ", ",", text)
      return text

--_REPLACEMENTS_SV =3D [  # {{{
--    ('noll', '0'),

(3.8-one-nlu-dev) git:master 22.10. 17:17:00
matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
:; git --version
git version 2.29.0


Best,
                Mat=C4=9Bj

p=C3=A1 16. 10. 2020 v 23:09 odes=C3=ADlatel Mat=C4=9Bj Korvas <matej.korva=
s@gmail.com> napsal:
>
> Hi,
>
>
>
> this is my first bug report for git, I hope it's going to reach the right=
 folks.
>
>
>
> I just upgraded my Arch Linux (running in a VM) today, which came with a =
new version of git, 2.28, and I have noticed the difftool command stopped w=
orking properly.
>
>
>
> In one concrete repository, for some commits only, I get this:
>
>
> (3.8-one-nlu-dev) git:master 16.10. 23:01:02
>
> matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
>
> :; git difftool --tool=3Dvimdiff HEAD^! | head
>
> diff --cc one_nlu_tools/util/number_formatter.py
>
> index b16931c,d2122ab..38ab1bb
>
> --- a/one_nlu_tools/util/number_formatter.py
>
> +++ b/one_nlu_tools/util/number_formatter.py
>
> @@@ -1014,9 -1014,9 +1014,112 @@@ def format_italian_numbers(text, conver
>
>
>
>
>
>   _REPLACEMENTS_PT =3D [  # {{{
>
> ++    ('noventa e nove', '99'),
>
> ++    ('noventa e oito', '98'),
>
>
>
> (3.8-one-nlu-dev) git:master 16.10. 23:01:07
>
> matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
>
> :; git --version
>
> git version 2.28.0
>
>
>
> Where I would instead expect the usual prompts asking whether to run vimd=
iff, which works properly with git v2.27:
>
>
>
> (3.8-one-nlu-dev) git:master 16.10. 23:01:42
>
> matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
>
> :; git difftool --tool=3Dvimdiff HEAD^! | head
>
>
>
> Viewing (1/2): 'one_nlu_tools/util/number_formatter.py'
>
> ^C
>
>
>
> (3.8-one-nlu-dev) git:master 16.10. 23:02:37
>
> matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
>
> :; git --version
>
> git version 2.27.0
>
>
>
> I have some untracked files in the checkout currently, no intent-to-add e=
ntries as far as I can tell (I saw a single note in the changelog between v=
2.27..v2.28 that had to do with the difftool command and that talked about =
these intent-to-add entries):
>
>
>
> (3.8-one-nlu-dev) git:master 16.10. 23:02:42
>
> matej@ac-mak-arch { ~/proj/one-sem/one-nlu-tools }
>
> :; git status
>
> On branch master
>
> Your branch is up to date with 'origin/master'.
>
>
>
> Untracked files:
>
>   (use "git add <file>..." to include in what will be committed)
>
>         .tox-0/
>
>         Session.vim
>
>         mytest.py
>
>         nose2.cfg
>
>         tests/debugging_tests.py
>
>         tests/resources/numbered_tags/
>
>         unittest.cfg
>
>         work/
>
>
>
> nothing added to commit but untracked files present (use "git add" to tra=
ck)
>
>
>
>
>
> Please let me know what other information might be needed to investigate =
this issue.  Unfortunately, I couldn't subscribe to the git mailing list, i=
t seems that our company servers include headers in the emails that Majordo=
mo doesn't like. (And the bug report itself was rejected as spam, so I am t=
rying to send it from Gmail now.)
>
>
>
> Best,
>
>                 Mat=C4=9Bj
>
>
