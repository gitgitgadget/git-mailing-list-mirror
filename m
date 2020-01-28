Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0707C35240
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B1E2173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEn0O9xV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA1EBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:01:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34114 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA1EBo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 23:01:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id d10so12084793qke.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 20:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RyJelee/DT68jmWfx8iJXoSpzxQjZY2c9AxzUj2Ww/E=;
        b=kEn0O9xV7OJqEbdDJy9Xhkm9HnCcPcvW3mwX4Z1AGIY9ZCZkf0mR+RDoIOmhlnHmGd
         ngKdJTKVu5RZ0KjAcfYk8FSmJf7Smch/UOfpaRF03QrH7LMx1L4y6XZEzKHrf7qulN7E
         xncA/Y/KR/CsULwJs7jTf7Imr3CYP4cXdcpuCYLi9xAzAzSR+CMoIz5Yk1/q2uUXuCtr
         1SHBop2V0jkhhLj022rVaEtn4zP4QwoWcCFfy67eAIQa0lIO4Pd2fTFhaIAhfW5pmP3p
         OTs82Psp+pQ4mU5HlTiKRs3riAqlQSyChSv6t6w4REc07W+rFvgyZxWwWOdvNA+aMBIz
         o6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RyJelee/DT68jmWfx8iJXoSpzxQjZY2c9AxzUj2Ww/E=;
        b=QnWZBJTgnDNJ7BXP24hiTLgqro8lwabl15glKZe/tO1H+GgK0FEdnRKGl8ROLOzZG3
         UHaabAXa/G3U0BPiqNZ5Pz92dU4JKS4yVnJ8vlOKkwb3KmjCrNWP2HRxOvSK1E+UWEUN
         ZXDsV0NNih5UXbTtOwjIsYHpNqj6r8HYrbIQ1tuc0Bau7NH88OCjjn8/hJs9DBb7KRyN
         bdbctQm9pHrkDDxEvX6ZXHeXaV8tmlwugdZIvNrpdrVhnbuYwhuKp+wxexxbrXDxNvsD
         SenrIM87Rt8mu3rByeelBfI8zBInem/a6NFB3Rw9zFqlcJZMuVo+oQUzzCefzWokEBab
         7wHA==
X-Gm-Message-State: APjAAAVVsJrV50ZZ3aSv7MyMQ2xLqPcIKINjls3pL5/LPRk3FIpnpdd6
        n7AXClr3i2qie7wXxbnHV6k=
X-Google-Smtp-Source: APXvYqzWr/a0O+7mEdlwNhtTLV9dTcyKTiLbi7MBHZtSdxw+2JYEgxNhqwI5W/XzJ+L3oygmByHaNg==
X-Received: by 2002:a37:8e03:: with SMTP id q3mr19800908qkd.395.1580184102909;
        Mon, 27 Jan 2020 20:01:42 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g205sm11539637qke.16.2020.01.27.20.01.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jan 2020 20:01:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Submodules & worktree
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
Date:   Mon, 27 Jan 2020 23:01:37 -0500
Cc:     Git List <git@vger.kernel.org>, mateusz@loskot.net,
        Peter Kaestle <peter.kaestle@nokia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C0C3A4A-B185-4690-B76C-42E113A89687@gmail.com>
References: <CAKQS2drF+CQTiKtXD6Kx1ZbH9ZTekWmbfiiHTCJV_BrT5-gAFQ@mail.gmail.com> <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
To:     Ole Pinto <olepinto@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ole,

> Le 1 f=C3=A9vr. 2019 =C3=A0 09:00, Ole Pinto <olepinto@gmail.com> a =
=C3=A9crit :
>=20
> Adding a worktree from a working copy with submodules doesn't work.
>=20
> In the config file I have
>   [submodule]
>       recurse =3D true
>=20
> It that's not present, I don't find the problem.

I also stumbled upon this bug and fixed it in 4782cf2ab6 (worktree: =
teach "add" to ignore submodule.recurse config, 2019-10-27), which was =
merged in 05fc6471e3 (Merge branch =
'pb/no-recursive-reset-hard-in-worktree-add', 2019-12-01) and made it to =
Git 2.25.
`git worktree add` now works correctly in a project with submodules, and =
cd-ing to the new worktree directory and issuing `git submodule update` =
inits and clones the submodule(s) to =
.git/worktrees/<worktree-name>/modules/<submodule-name>, as it should.

I must warn you however that I discovered another bug that can happen =
with the submodule.recurse config when using worktrees with projects =
that have submodules. In short, issuing `git checkout` (or `git reset` =
or `git read-tree`) in one of the worktrees will leave the .git file in =
the submodule incorrectly pointing to the repository of the submodule in =
the main worktree, i.e. .git/modules/<submodule-name> instead of =
.git/worktrees/<worktree-name>/modules/<submodule-name>. I also fixed =
this bug [1], my patch series for this is currently in next.=20

[1] https://github.com/gitgitgadget/git/pull/523

> # Problem 2 (submodule status seems not to detect some cases)
>=20
> $ pwd
> /tmp/main_repo
>=20
> $ git submodule status
> ebc9325f7b19164c9bdfd05263481ded66d7bd7d submod (heads/master)
>=20
> $ rm submod/file.txt submod/.git
>=20
> $ git submodule status
> ebc9325f7b19164c9bdfd05263481ded66d7bd7d submod
>=20
> So, I have a plain, empty directory where the submodule should be. Not
> having any 'first char', I'd expect it to be checked out and up to
> date. Is this expected?
This is indeed not expected, and used to work correctly (the hash should =
be prefixed with a =E2=80=98-=E2=80=98) in Git 2.12. This bevaviour =
regressed when `git submodule status` was ported to C in a9f8a37584 =
(submodule: port submodule subcommand 'status' from shell to C, =
2017-10-06).
Another user reported this regression to the list recently and a patch =
series is in the works to fix it [2].

[2] =
https://lore.kernel.org/git/xmqqv9owbw5o.fsf@gitster-ct.c.googlers.com/

Cheers,
Philippe.

