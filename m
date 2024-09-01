Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31C3C0C
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725187760; cv=none; b=mOQy7xOtjAILeNpqcON7PJhXEpRRryMu/iH9ojh5s1raiTqE8cXexsxBFjaPNa+AFeCBlcSnpAmzWjFkqF81D2yvzLyCGJCPg9gFBhukm6NO8afDYKdlPe/1uJE6NnL8xO5y0fODBemdlJf8i6VUqtNyWoJvE82KeYJOrN9cr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725187760; c=relaxed/simple;
	bh=aFwwdSvqtiTWjMDt88eBly3w3+rftCGxoN8tXqvgH/Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hFzZw0iNTFwFyfnsGZ8CWGXqX7myX62tjTbbsuoLY5yaxKqTECi9HABTiZAC6HBp11DRoEMto8B/j6iwDKT1ylQjzBtNjhpT0rAaqArvM9OFQLtJtRW9r+eKLVFsrqMYoXDFYZibu60jLvMqyVGc0/x9L97i9U61wOX0CsmmyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3M1fN7J; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3M1fN7J"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53346132348so4143666e87.2
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725187757; x=1725792557; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aFwwdSvqtiTWjMDt88eBly3w3+rftCGxoN8tXqvgH/Q=;
        b=V3M1fN7Jju2ESFLQ2YSO224Mc6oWj2rnaoVfB+Qkj0PiO9MPON/Wha1j7prkEJorox
         UE84soQY7Gb/MIl98+kzDj7W2qe91i1y69y6YGHpq+00Hz/YaXYg4dt0ltvKBeLv5LvP
         Y9V/UoXRpNc6x3UJm8RC524YmTo95Y8qThYBCPjRAa/Zk5INg6iTv6KcBFM+U4vMVUtT
         SZhe8Uh9bFayLR/AntrS7uno7Bpb5LTfDpLMOHoHe27r9Eb7h3vu0SQscuX5M3ObXsA1
         OLPT0D698bNgjmqeB3MvubqnD+YTI4m5ZMSp5BV6gOudU3FSjfqgcxYezGqRha5TbV03
         0xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725187757; x=1725792557;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFwwdSvqtiTWjMDt88eBly3w3+rftCGxoN8tXqvgH/Q=;
        b=fwsRbyQ+ZYk/RN62TxJ1kx0vYXM6yGtp+aqvw5Geylg+BEY5+SCjqjzEjV8ikLFxZA
         5GXrSYPefNhJZddaJQJP8GsqzRiaS20zmr/An9D6ab6TBX1gIv/z9M0AJWMUtXiMYQME
         fY2okeAvdvGpTx1xuUq2SdK3FTBxR1kuXpvC2pwRmDh3bmBIwYkDIOAezh9k4n++eEcZ
         NrE863ogCdL79rY2J/yuXkpFhjkhm1Og4f9JP2t3p0SgtHvUX9GnjwoDmJSlSQHVtaFR
         w3j1op3bBoRutlfBz2woi3LuYiytCBq/Q57TWKzYIBCoOGd8kBchExSkw7NwSxSUh+IK
         y/Dw==
X-Gm-Message-State: AOJu0Yyq/kBA/KeLRWWRCeeeWVHfnN84bcPlQN99IvwGT/DYJUvjWNUv
	KsrqolaBFMcm6OZkyB1SgUYzH7E+PFQAbGcC8yJUE1FvLNoUmwQ7LOUbuziP9qVYdT+eqwhHHUL
	vlECxndR9uSzrL+PSVh87CT+MVA4Hl+8D
X-Google-Smtp-Source: AGHT+IHCXe09vrQvsGU4B3mxr9RG2P0ls8FhZycHOxFBaGpqlQEYNOn/68D5cpgE5DrC0J1rnWjuKe6Fvs1IObi1KaA=
X-Received: by 2002:a05:6512:a8d:b0:52c:cca8:a9fb with SMTP id
 2adb3069b0e04-53546b9089cmr4404171e87.42.1725187756973; Sun, 01 Sep 2024
 03:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 1 Sep 2024 22:49:05 +1200
Message-ID: <CANrWfmRvtz=WOPpv54-22aEFsCPi_vwpFo_Q08vq31NjggOVsw@mail.gmail.com>
Subject: `git merge --no-overwrite-ignore` overwrites ignored files when merge
 (i.e. not fast-forward)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

(`git merge --no-overwrite-ignore` overwrites ignored files when merge
with conflict.)
cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './repo';
git init './repo'
echo '1' >'./repo/file_conflict'; git -C './repo' add
'./file_conflict'; git -C './repo' commit -m "$((++number))"
git -C './repo' branch branch2
git -C './repo' checkout -b branch1; echo 'file' >'./repo/.gitignore';
git -C './repo' add './.gitignore'; echo '2' >'./repo/file_conflict';
git -C './repo' add './file_conflict'; git -C './repo' commit -m
"$((++number))"
git -C './repo' checkout branch2; echo '1' >'./repo/file'; git -C
'./repo' add './file'; echo '3' >'./repo/file_conflict'; git -C
'./repo' add './file_conflict'; git -C './repo' commit -m
"$((++number))"
git -C './repo' checkout branch1
echo '2' >'./repo/file';
git -C './repo' log --graph --all --patch
git -C './repo' status --verbose --verbose
cat './repo/file'
git -C './repo' merge -m "$((++number))" --no-overwrite-ignore branch2
git -C './repo' log --graph --all --patch
git -C './repo' status --verbose --verbose
cat './repo/file'

(`git merge --no-overwrite-ignore` overwrites ignored files when merge
without conflict.)
cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './repo';
git init './repo'
git -C './repo' commit -m "$((++number))" --allow-empty
git -C './repo' branch branch2
git -C './repo' checkout -b branch1; echo 'file' >'./repo/.gitignore';
git -C './repo' add './.gitignore'; git -C './repo' commit -m
"$((++number))"
git -C './repo' checkout branch2; echo '1' >'./repo/file'; git -C
'./repo' add './file'; git -C './repo' commit -m "$((++number))"
git -C './repo' checkout branch1
echo '2' >'./repo/file';
git -C './repo' log --graph --all --patch
git -C './repo' status --verbose --verbose
cat './repo/file'
git -C './repo' merge -m "$((++number))" --no-overwrite-ignore branch2
git -C './repo' log --graph --all --patch
git -C './repo' status --verbose --verbose
cat './repo/file'

What did you expect to happen? (Expected behavior)

`git merge --no-overwrite-ignore` refuses to overwrite ignored files
when merge with conflict.
`git merge --no-overwrite-ignore` refuses to overwrite ignored files
when merge without conflict.

What happened instead? (Actual behavior)

`git merge --no-overwrite-ignore` overwrites ignored files when merge
with conflict.
`git merge --no-overwrite-ignore` overwrites ignored files when merge
without conflict.

What's different between what you expected and what actually happened?

Anything else you want to add:

(`git merge --no-overwrite-ignore` refuses to overwrite ignored files
when fast-forward.)
cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './repo';
git init './repo'
branch_default_path="$(git -C './repo' symbolic-ref HEAD)"
branch_default_name="${branch_default_path#'refs/heads/'}"
echo 'file' >'./repo/.gitignore'; git -C './repo' add './.gitignore';
git -C './repo' commit -m "$((++number))"
git -C './repo' branch branch1
rm './repo/.gitignore'; git -C './repo' add './.gitignore'; echo '1'
>'./repo/file'; git -C './repo' add './file'; git -C './repo' commit
-m "$((++number))"
git -C './repo' checkout branch1
echo '2' >'./repo/file';
git -C './repo' log --graph --all --patch
git -C './repo' status --verbose --verbose
cat './repo/file'
git -C './repo' merge -m "$((++number))" --no-overwrite-ignore
"$branch_default_name"
git -C './repo' log --graph --all --patch
git -C './repo' status --verbose --verbose
cat './repo/file'

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0.windows.1
cpu: x86_64
built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
