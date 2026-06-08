Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD432D0E3
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936681; cv=none; b=b9Hi9osz42SYUh0LN22jGsM/lb5j6P6SbrCmLE7vPGYzf+mLzcn1mrTetOnVcwxiVfYo9g40ci03sjHzYPRnOaSAYC66Smm3fTAYVemMGcCwqCbMA+aK13TAogQqspWXYM77JUbfQgAmIRUYfB13RpR4LnmscCd6an6e09aciaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936681; c=relaxed/simple;
	bh=6ciWjsnOGBMOBm+j2y74cOCPPpoD3x05OIw6aQFYl2A=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ZU8X2STGRsA+yiTTfz3Wa3hd741dz9eauGt1mCsVVlzXelVe8iZ42B5JaNHNNoCsdebwaazhLC48NbaYadalm+OishJ+0WPQWv8NialjZj+EU++wsIpaQ/NIBjzTG31a35Ja5hjYnwZpM2auPAPfM9DnA4MENtXi9hrgU0jv/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmmRV4RW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmmRV4RW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e0fc8ead7eso50419207b3.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780936678; x=1781541478; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VzUgF9wytohvxSxKzH8uqJFGY2q0C+xxumMjfrNTes=;
        b=XmmRV4RWm+MM+Db7I5weXSD2E9OAgSG4SAbWg1Fpiw8bUbd+LFQLfw5iT3dAMO5u7a
         VjevoL8cHygXAwP0qgjoeiNBgogE4jfLJBiu5f1tTUmOoBhbguZ0nZuZVUvq2KULGvPu
         d2Gs/CLK+Ta6cmYivdEQqsPUijzdlgXqgCHXSYw6xtndF+hdolWHE9ZK/3iGy5FvXm39
         IcaqWodBvSEOWCDtM2OBH4GV4zw/K6R5Qmb3pW48M4vtN+DGCI4lT8uNWHGNIsD+wCvt
         6RxH5yAHPvE9GaVAIus8dVe0DMDxmVvvuStzUJD/Nurqok4TE9wyIg1Umzrd+vY/P/kQ
         Oamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936678; x=1781541478;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/VzUgF9wytohvxSxKzH8uqJFGY2q0C+xxumMjfrNTes=;
        b=Lk3BLY82DSF5j++G4u+TxTkGew19BbnF0e1mRWv0+UKRgchw+F1LIPguKkU3m8wy/H
         4Jt5I9cE9Wxehi8yY8q7KdnwssWGvPOeJhrjhTmBGOpCOe/Rx3a3rUrHQEOtekjNqzEg
         dJ83OeBcbJpn7FDIRf+tW7V/Mx1T7+ZBZJYBKsbj/WTIF+UJBxb3Hoa9h7dM4cksQQIx
         0c1GjAHK7ufFGGiI+OyoHZ8HvoLUfhbntxQNVyClRyhb5gkwLUnbGvCa9qZAXsnc+CUf
         +kYCqBxKmjDWbhp8jDKdhQtAq3jK+iS1pRRMsDrJIfTMG69ScVn9kPzfdRpwViec87lc
         1CAQ==
X-Gm-Message-State: AOJu0YxsSVVhSc9LGWMlUhTw4e5zp1FRRcjNZRxORCb2aX8tH/DQypWY
	jeHlUnfYGWKfhvnftmUesT5P6qBZETr0noCd8vyO7FxKuwjUeAjBtCgq
X-Gm-Gg: Acq92OEt8WkpOC78xOl2ekTvzCiKdbXc3XgDpL/ruKY0sEL9cISt4c26+P8eciFV2cE
	gZ6zHcvFAG140y1+U7ZihqAebgc/qpB2NR/R7wxXuu37LwA9MGWqTpWcjlPW9xOhLUWKcc9BiZ5
	Xpz1x4zCODph1ZzFVGc45FE18PRmR2gBf1e4pzPI0cR0ipx6qgkmdCoK65yqDOe8TEZSGMj/zEy
	LostMFb2b0UUzke1BOLU5pxy6qXJqD/BxQu33Kkheq1KquDK+lc+bxIJKddo9MvIe7YSUsv5RDx
	aVmL9wuEGTVYMQMhvJHQWCCMHGLykEpttHgZZYgx+JmgqbrEWnylkb5Fa1xyz5TN/V57AkIro7r
	tjaq2pOXF5iC/7Dc4DFlrBSVhfghf3SAoPz+wNFqBtqLz/a5eP1pfp2fRfFikibdC18fBP3Lhyl
	S/b2QkNMcx3lG2hApz8xKatn0HfRKSD3mVnwqJG7td7C0SLhfbLsxf51gTMNJTHHgUxaZzlgeMT
	TXgCeIa42wnT7LJcYU6sZlMeA+UmecxD9lWUba9GUFlKX2/41lfUi+V
X-Received: by 2002:a05:690c:4807:b0:7d0:6660:160e with SMTP id 00721157ae682-7ed0b87282dmr160159247b3.3.1780936678220;
        Mon, 08 Jun 2026 09:37:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4dd7:1401:a55e:b40d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2148b48fsm85290217b3.12.2026.06.08.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:37:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
Date: Mon, 8 Jun 2026 12:37:47 -0400
Message-Id: <9A2F74F1-66D0-4015-B387-35B107ED6F7A@gmail.com>
References: <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 Pablo Sabater <pabloosabaterr@gmail.com>
In-Reply-To: <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: iPhone Mail (23D8133)

I don=E2=80=99t have any strong opinions on the rest=E2=80=A6

> Le 7 juin 2026 =C3=A0 16:08, Pablo Sabater <pabloosabaterr@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFWhen using `git history reword` if the new message is the same as=
 the
> original it continues anyway creating a new commit with the same
> message and updates its descendants, modifying the history after this
> 'reworded' commit even though there was no actual change.
>=20
> `git commit --amend` and `git rebase -i` + reword share this behavior,
> however `git history reword` is different:
> 1. Works in-memory without touching the index or the worktree [1], so
>   there are no side effects like staged files that could justify
>   rewriting the history when the commit message is the same.
> 2. `git history` by default updates all the branches [2] that contain the
>   original commit making it more costly than `git rebase -i` that only
>   updates the current branch.
>=20
> Add a check if the original commit message is the same as the new one
> and abort if so.
>=20
> [1]: https://lore.kernel.org/git/20260113-b4-pks-history-builtin-v11-8-e74=
ebfa2652d@pks.im/
> [2]: https://git-scm.com/docs/git-history#_description
>=20
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> builtin/history.c         | 10 ++++++++++
> t/t3451-history-reword.sh | 20 ++++++++++++++++++++
> 2 files changed, 30 insertions(+)
>=20
> diff --git a/builtin/history.c b/builtin/history.c
> index 0fc06fb204..51a22a9a1c 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -135,6 +135,13 @@ static int commit_tree_ext(struct repository *repo,
>                      original_body, action, &commit_message);
>        if (ret < 0)
>            goto out;
> +
> +        if (!strcmp(original_body, commit_message.buf)) {
> +            fprintf(stderr, _("Message unchanged,"
> +                      " aborting reword.\n"));
> +            ret =3D 1;
> +            goto out;
> +        }
>    } else {
>        strbuf_addstr(&commit_message, original_body);
>    }
> @@ -718,6 +725,9 @@ static int cmd_history_reword(int argc,
>    if (ret < 0) {
>        ret =3D error(_("failed writing reworded commit"));
>        goto out;
> +    } else if (ret =3D=3D 1) {
> +        ret =3D 0;
> +        goto out;
>    }
>=20
>    strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index de7b357685..54ea8a7207 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -396,4 +396,24 @@ test_expect_success 'retains changes in the worktree a=
nd index' '
>    )
> '
>=20
> +test_expect_success 'aborts if the commit message is the same' '
> +    test_when_finished "rm -rf repo" &&
> +    git init repo &&
> +    (
> +        cd repo &&
> +        test_commit first &&
> +        test_commit second &&
> +
> +        git rev-parse HEAD >oid-before &&
> +        write_script fake-editor.sh <<-\EOF &&
> +        true
> +        EOF
> +        test_set_editor "$(pwd)"/fake-editor.sh &&
> +        git history reword HEAD 2>err &&
> +        git rev-parse HEAD >oid-after &&
> +        test_cmp oid-before oid-after &&
> +        test_grep "Message unchanged" err
> +    )

=E2=80=A6but I think this test case could do something like "GIT_EDITOR=3Dtr=
ue git history reword HEAD" and avoid the script?

> +'
> +
> test_done
>=20
> --
> 2.54.0

Best,
Ben=
