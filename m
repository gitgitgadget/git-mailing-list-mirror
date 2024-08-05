Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F813BC0C
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870494; cv=none; b=sZGuaiexWxVKAnivzUtKsQs7Io/AsKB1Sm8WOgETaKod3sfevdpQrT0R6aaE0t+TgJu8yUNvv2VFwpNwfHv6XZWad6e3R3bKRToc3kT7coo8A/OAynCeYrngPunGkxTtXNyA1dYlR9BE5s1IyaUC6Ng6RZxLusxj2UxtBBvx4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870494; c=relaxed/simple;
	bh=Tn2+Dsqlch44F6drqRIeCI2cEe+bIeGMSKdwGyI4fSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YzfdiuaSo+N4ZwE/hUxN1Q7va5Ja02Ne+rLydijWeFzY++MJ/qgBXfzsj4nmi7tqyXSGx0xQToS2BvWZ4gIfB+gocoo3OFBs49ExmHd1W0wi2zkVotrrdw0am2Y2oETaSAQh9zb2MfCt8RGKZxrjqzVZ/qPbCMepeNdf15jD4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBKdUUR0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBKdUUR0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so14984186e87.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722870490; x=1723475290; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf9O009Du8JENt22cWdc17Rc1/Lu0LuVBhLBmPQE/Sk=;
        b=NBKdUUR0Ikp7895d0SMmGI+wbWwvtuCa3XWYH65fnXwdJOPR+pkUcyUuciQg9w/vHC
         pRZ2jNtoiqZg1rjCSpXDRPyIoCogGst8OnTb4hEV5MFhB13e/wP9S3Fj6ZclijunxV1r
         vj6K7JNsmn4O9JriwzfrFnM8hmuz+JuxKAkoY+b3p1bDMjM6VybT9neN1nhevpXlt3BL
         N/Q5yjasE6+iviT0fiNpdGaMpfiXPAGq4ucO1oXmKqqPZXqPr3QaTtoZ2wb2ney21o8X
         NOldEL6ekAGFgBted29cPWadzDJueIPAp++q0HJeJi5mYvpVlpUDWL33VcSkipiA9fSr
         mc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870490; x=1723475290;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf9O009Du8JENt22cWdc17Rc1/Lu0LuVBhLBmPQE/Sk=;
        b=pJGbtPgMYQ1VV3k3Qz2Vw9rB/yu6ilvp1DWzexXsk+sYYZgS2wrlW7c31i3lX3OJYH
         InMTWujIx+3MuhiBfLZhw27T72TeWw3fN+8ycqHfXQyF0Af6EVB3DZVLjQg/nXeoahXn
         yQk29FlwrG5+tKx5eCTBFqw1MrWhdv3BY+1P9SKsf3KnfRt9EYSBXRXiAOD75uwoh94m
         4RiVqWP6UHfXlge+gBvPwFPDo5NvIKNH4hW+FeFKnVu0Ff/Dg2EW3YtglwWbnNGA5HhN
         yqmU0V4Fq2QbGYRLsFxfWgKBNQAOEAOpYL+PZw6mXaGRNTDMBVbbA9q5AWxDS/TX8mL+
         /dxA==
X-Gm-Message-State: AOJu0YyOOVlTzVhf551vw8upJykNmxd7Vhe+LyfAMKmsyPk0qvRz7ehb
	ccY53HgKvUSoTbXUXIVuBwTc2X9/qPdgthWEtvW9LcOFJSWNtb2uAeyq1xlzMOAOncuodzzdiFP
	1O7SVXXSYtd5nrS8qL7g3JbRE8jBF5tJJ
X-Google-Smtp-Source: AGHT+IEW262YB9780tjGzidx8ykbfLS5g6BqWwuCFLrcLZcS4VAiGJSaX3eFkedZ/oB8tTLDoRNcUSeJXcxfljYxvLM=
X-Received: by 2002:a05:6512:b01:b0:52f:31:c2a3 with SMTP id
 2adb3069b0e04-530bb36b73cmr9209524e87.12.1722870489786; Mon, 05 Aug 2024
 08:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Thompson <fortran@gmail.com>
Date: Mon, 5 Aug 2024 11:07:41 -0400
Message-ID: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
Subject: Bug: Git sees branch as valid commit ref and works; should fail
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ git clone https://github.com/GEOS-ESM/GFDL_atmos_cubed_sphere.git fvdycor=
e
$ cd fvdycore
$ git checkout bugfix/mathomp4/trivial-ci-commit-gcc14

What did you expect to happen? (Expected behavior)

I expected a failure as there is no branch named
'bugfix/mathomp4/trivial-ci-commit-gcc14' in the repository.

What happened instead? (Actual behavior)

$ git checkout bugfix/mathomp4/trivial-ci-commit-gcc14
Note: switching to 'bugfix/mathomp4/trivial-ci-commit-gcc14'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to fals=
e

HEAD is now at cc14d30 removed an unused module use in fv_sg

What's different between what you expected and what actually happened?

Well, git somehow saw 'bugfix/mathomp4/trivial-ci-commit-gcc14' as a
valid commit reference and checked it out. I was expecting it
to...not.

Anything else you want to add:

You can see similar behavior with git-switch, though slightly different:

$ git switch bugfix/mathomp4/trivial-ci-commit-gcc14
fatal: a branch is expected, got commit
'bugfix/mathomp4/trivial-ci-commit-gcc14'
hint: If you want to detach HEAD at the commit, try again with the
--detach option.
$ git switch --detach bugfix/mathomp4/trivial-ci-commit-gcc14
HEAD is now at cc14d30 removed an unused module use in fv_sg

So even git-switch sees 'bugfix/mathomp4/trivial-ci-commit-gcc14' as a
commit reference.

Also, I have duplicated this behavior on a SLES 15 Linux machine with
git verison 2.45.0 and on another RHEL8 box with 2.45.2

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Fri Jul  5 17:53:24
PDT 2024; root:xnu-10063.141.1~2/RELEASE_ARM64_T6020 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show

--=20
Matt Thompson
   =E2=80=9CThe fact is, this is about us identifying what we do best and
   finding more ways of doing less of it better=E2=80=9D -- Director of Bet=
ter
Anna Rampton
