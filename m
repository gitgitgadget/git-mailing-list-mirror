Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BF1DB34C
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423162; cv=none; b=WpD9Z12BRAt16eq5YHEd2ZYgPYnQAXLWuegXNnO3/CCjVS3ZDV4vIEkJ+j7HYjXYAmklAfW05T6nVVOqniIBAyP5HTkm8nZysDuUWww4ms0z6An6RVqyJqw4TEdr2zorfc8ZiKTIf78HJg6+gjDebBs7PR930/z6b1SjngkSfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423162; c=relaxed/simple;
	bh=JV081cMydRzDLl2oPw6dw6RGcqgX+xkyd1HDX5j/Ojk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgKL7C+QTrXEuUP/d5L9L/9v7pXnnN3STb4t65KcY4dXExoKx+QZobk88gH3xU71X1gjkVqUPc6JctjlWRYerzYEV7ifqNaCfQ14pzDO72JPeN3ipjLURCz0uQAzr1yRlJq+BS42QWyY8dHPf+g/uVK8pl3aid9qRt7TsuuzlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8SJ/3Ef; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8SJ/3Ef"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so7973174a12.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 00:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734423159; x=1735027959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++57zMQYfUva5xAiYaUDkscvYB+PanxT3mw1owzziG4=;
        b=Y8SJ/3Efj36qa+r19bp8RbtXHEV2d0FJRo8B+8ywJyvQT6RDp5sgnv9uEusbSQRLF8
         5cqwhqdb0GAZg056TJTcyV14s94RA5lmQ4hTAAqoUxeAkn6kwa9cmIF7NVcvDg9vz2Ku
         8HqRp57ozydmDlSGq/dLUZIQtQojZxDnjazwg0oQYqwYW2nigECKTsAlWkY2Zjb0Nez1
         kVDj2e0Z0pmttur+WnJA2e6jIGpwiyxKH0R9PE/FM7Urk7UxdJ25rkRNnb+LNcyp6Tcs
         HKmnxGjIOB7pNMt2NyEOMsTvoBao0wQQs7wIuy6sTtFtowSZYU9pWjmaT6CY/v2K92gm
         WvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423159; x=1735027959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++57zMQYfUva5xAiYaUDkscvYB+PanxT3mw1owzziG4=;
        b=e9HFBFTSmFDb/QtSWuWhciURw2Wb1VCwlDPcKrev0SvowZS+iyTnQtx1kiEejelzrR
         p6RzD+/3P+j7oU+R9emuJgwAZcf/K2wDqP4of6ZoHbn9LnsiaG6i+G2JLT9kmod/qcNH
         LOcmEFKxqY4WBVe3jMhyNdBoyMO84t8hGuvFGWxoHgZ65KfR6Y7b3yu4X+ZIVMD5PCCL
         /A2F8RQaX+7ua5JsiBMLSvSm2zItytd7a0AqUYQ7rgMvkqZF3k7d3ZOd2CmgGBMtlQci
         wYvt+To+HzdOiCdezcam4h0AbfpZqQA8fSp1pU+Ta3d8lJxd/tQLtVh2rfoeqp7aw+Lc
         9y2Q==
X-Gm-Message-State: AOJu0YxsdDdFC8K4kM2aXfRYMXHikMwMATCNuCHvKgixORJ3OekS9sOC
	oaWAzDIJ5jJctKVE2CCQ8Z4FcbZC2yIn3YKQka2uhQda7EB1KFV9F2NR9BwSll51BoUKlRjjdjO
	VMYOajnwGlHfDrNfi8nOBRaXGcCT7P4sDHg==
X-Gm-Gg: ASbGncvKxhrhsutOEGByH3CTT7auwWF9D0LIE+oHBrQKzgvn9nOahuytL2imy0qgwhW
	gduHoF3TBQwlgNQO6t6hg6xtdIXCi/Byu+zXl
X-Google-Smtp-Source: AGHT+IGmVk7kBTYnjvKlPX1KLYZQP5ozMnd0KppPc7EszUcPReVf7RAw0V5KmQTy4AEIBz7ihUYZvxGnMytuO4xkxu0=
X-Received: by 2002:a05:6402:3551:b0:5cf:f42f:de82 with SMTP id
 4fb4d7f45d1cf-5d63c2e51b6mr13095152a12.7.1734423158857; Tue, 17 Dec 2024
 00:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhVC3b+1TWLkKGYVb6VyBRyQjsDpbKRQQNT8SUXSmrWHfPnEQ@mail.gmail.com>
 <xmqqr0674hvq.fsf@gitster.g>
In-Reply-To: <xmqqr0674hvq.fsf@gitster.g>
From: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date: Tue, 17 Dec 2024 10:12:27 +0200
Message-ID: <CAMhVC3byz89UP_DJq+c6UVUNoFW0oRRSwbR7v=uUBAdBMLwqMg@mail.gmail.com>
Subject: Re: remote.<name>.push without dst doesn't behave as documented
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So it was your doing :) (no offense meant)

https://github.com/git/git/commit/ca02465b41311fe7634acb9bb5b5c61975ef5f38

> If git push [<repository>] without any <refspec> argument is set to updat=
e some ref at the destination with <src> with remote.<repository>.push conf=
iguration variable, :<dst> part can be omitted=E2=80=94such a push will upd=
ate a ref that <src> normally updates without any <refspec> on the command =
line. Otherwise, missing :<dst> means to update the same ref as the <src>.

My understanding of this was (the only phrasing that made some sense to me)=
:

> If git push [<repository>] without any <refspec> argument __is invoked__ =
to update some ref at the destination with <src> __and remote.<repository>.=
push is set__, :<dst> part can be omitted __in remote.<repository>.push__ -=
- such a push will update a ref that <src> normally updates without any <re=
fspec> on the command line. Otherwise, missing :<dst> means to update the s=
ame ref as the <src>.

As such I chose `push.default =3D upstream` because that's the only mode
which allows non-matching refs. I expected it to allow me to
discriminate between having and not having :dst in
remote.<repository>.push. But without :dst in remote.<repository>.push
it updated the matching ref (the second test failed).

Now I understand that what was really meant:

> If remote.<repository>.push is set and the refspec on the command line do=
esn't have the :dst part, then the former (remote.<repository>.push) is use=
d as a refmap. Otherwise (if remote.<repository>.push is not set), then mis=
sing :dst makes it push to the matching branch.

I believe the phrasing in the documentation calls for being changed.

But also I can't confirm the "otherwise" part. Below the last test
fails. Either you have to (unless I'm missing something) say:

> If remote.<repository>.push is not set, then it falls back to the `push.d=
efault` behavior.

Or make it really push to the matching branch even if `push.default =3D
upstream` and the upstream is a non-matching branch.

Regards,
Yuri

--

The whole file is in a gist:
https://gist.github.com/x-yuri/943fd13704b38551da36c8363d7852e1#file-b-md

# the state of the cloned repository (1 commit, 1 local branch ba)
# a (HEAD -> ba, origin/ba)

@test "normally it acts according to push.default" {
    start_cloned_repo
    git commit --allow-empty -m b

    git push

    assert_equal_refs origin/ba ba
}

@test "but remote.<repository>.push changes the destination when the
refspec on the command line doesn't have :dst" {
    start_cloned_repo
    git config remote.origin.push 'refs/heads/ba:refs/heads/bb'
    git commit --allow-empty -m b

    git push origin ba

    assert_equal_refs origin/bb ba
}

@test "specifying :dst overrides remote.<repository>.push" {
    start_cloned_repo
    git config remote.origin.push 'refs/heads/*:refs/heads/*'
    git commit --allow-empty -m b

    git push origin ba:bb

    assert_equal_refs origin/bb ba
}

@test "if remote.<repository>.push is not set, it pushes to the
matching branch" {
    start_cloned_repo
    git config push.default upstream
    git push origin ba:bb
    git branch -u origin/bb
    git commit --allow-empty -m b

    git push origin ba

    assert_equal_refs origin/ba ba
}

start_cloned_repo() {
    (mkrepo)
    cd "$BATS_TEST_TMPDIR"
    git clone --bare a a.git
    git clone a.git b
    cd b
    git config user.email you@example.com
    git config user.name "Your Name"
}

mkrepo() {
    cd "$BATS_TEST_TMPDIR"
    mkdir a
    (cd a
    git init
    git branch -m ba
    git config user.email you@example.com
    git config user.name "Your Name"
    git commit --allow-empty -m a)
}
