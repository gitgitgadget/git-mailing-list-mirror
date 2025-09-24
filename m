Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0118BC3B
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727836; cv=none; b=f4hEX/0/fY8R4rVOjzCagynJtTTPjEDcSUoX1/Q1UiZ0Qfbo7BsHUIhNwle656+aCX7FK84cSKIVBbe6FGUsJLkgcFw5BqJfng/lAR5QXG8dMUHUgkDuk8NppB7rMTyVKQtzjoyD6zU2JhKiY0deQO4zi1Upg7RsScCS1LOxC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727836; c=relaxed/simple;
	bh=AC9B6O2u6T5CYczObJKUJN97TCA3iVkIHg+OKvkmqiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YpxzyjBTPTjhAgFUd5HNaxwr7Y9IAm+ukaMKqdmL8DoBHVVF0U9Z4XaL1EiHTD3vynugX5ngbSIISTI61ZIft6syUiGwjfS88vOKtN2/805UxvKrvZ2gKaG7OdIJaqH8TcbGi811KYJNw9HLxaWIt2gDleHfu3I2EbF8rybpWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhpd7tG5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhpd7tG5"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e931c71a1baso7736123276.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727834; x=1759332634; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A5YNuzdK9aMtiZwfnYbud2bR0MFZx6OFvVfx2GS6FqM=;
        b=Yhpd7tG54VKjoOpAce48wOTUGZMiY3mJHasRECVO6GcGsTJudymI8P2WlgnSJb+QKX
         pgOX74vwa5P+ENN+zUIM+UmCCxUmwJEjvVq+gAt568fFLm/LarWbbTLkMlYVdXbHj76O
         rZFDXGdFMYVY2539ypQgIhMi4Uv9ftZXlZFA5YZ7arMc70/r4lSHnt0qxuaB1JTIlJQ/
         dkHpG81PKRo7UGS6PE3vVLq73AkdVrFV0k104UdtDi5wvFs88CIaV15p1DkLEd5//AJJ
         oj162VpM6zL8u2EH/igx/Vv8q3iM3D0bUFZm+LUdfsLICO01Wu+xPiio2a3Q2k4lsp2B
         rrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727834; x=1759332634;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5YNuzdK9aMtiZwfnYbud2bR0MFZx6OFvVfx2GS6FqM=;
        b=rKa7XRBErYB+PvolWvLt3CRSR940WoWI8rfiQKTpp8IQo5M1uglS90ZYusxmx7EhzN
         MoNv9kDPSAHQsDNsCoGY2Jip4STrozJKFLWJ+cfyuN1nk0o9Z3m100PU5XEAnHWDYOlR
         MdHo/7578Tt9Uo7Rk4byjlUxhVf/YfjYpGFSEWOLFpe6jadIinj4SnQmTyWkrgo7zLX6
         pKrTywO/f/zTJYetQYKISPkyonBXAQQ5/nTIUXjrtJO7ICi/3mtTsO4rxe/6rNWCtnAA
         qKfZ0VZezJ5LfMomx+TaLgtGKrHQllj5qxsclUxTCPpHYtwr+Kt+zhHVIhq605KJuWTj
         Vy0g==
X-Gm-Message-State: AOJu0Yw2s8pVjNssYKG1gJmisZED+3Rq8lx2rseqgldGKhQ4kmKlY4fP
	woZLC8W0fajx+fb1cTOPKbQ9zaMZI1PyixdXhknsrmuFo337ETBNZ6sMViOEZczfLpTZ3b6v22V
	eBXkj14Ke1FtoSzk+k7A/3KGltM93UNzuNTab
X-Gm-Gg: ASbGncvn0eyWzNRxgVi61fEXBBbf24WUL2PcXIuHjKCsnpqodkL/b/nN/hI2WQgscd7
	jQ7mUaJwAbk7wlx0x4D7WLWrr1DJmqOzthtZAugKdU596n4BnQ7/eDbZc3MdESxYEByiAi3CtVk
	LwXdEkP0VHf+S7O0eyk0eOxSuZWyexJyUqEKQ7O2XT5jZfaQk1ye8iBnoyphT0xAW3Vg3WtrP+/
	vCgIz65
X-Google-Smtp-Source: AGHT+IH18RCEPG9CALtyi3TmSDb3eLM2Aj20YlYVyTFJCAtP7PsEEcjI8fgU6dvhOKOwSEds5/X6bv452rEI4qgmDQk=
X-Received: by 2002:a05:6902:100d:b0:ea3:be0a:ccdb with SMTP id
 3f1490d57ef6-eb37fcc8b51mr417975276.49.1758727833481; Wed, 24 Sep 2025
 08:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hosam Aly <hosamaly6@gmail.com>
Date: Wed, 24 Sep 2025 18:29:57 +0300
X-Gm-Features: AS18NWAUBEsQaikfwuJvA7z5Sze5XSwq50p91N5E2HUIfyS4fwefQFWC_vmaWGw
Message-ID: <CAJA-u1rnzef53+eW_mbwd_40q+-vt747Q_dP3PG_HKt1yXcmXQ@mail.gmail.com>
Subject: Bug report: Untracked file lost from git stash
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I have a file in one directory. I made many changes _and_ moved it to
a different directory, but that caused git to lose track of the
renaming due to a low similarity index. As such, I decided to do it in
two steps and used `git stash -u` to shelve my changes. Following
that, I moved the file and then tried to unstash it, assuming that the
worst that could happen would be a conflict that I would easily solve.
```
git init .
mkdir d1 d2
echo code1 > d1/f
git add d1/f
git commit -m 'Add file in d1'
mv d1/f d2/
echo code2 > d2/f
git stash -u
git stash show --stat

git mv d1/f d2/
git commit -m 'Move file to d2'
echo code3 > d2/f
git stash pop
```

What did you expect to happen? (Expected behavior)
* `git stash show` should show a file that was deleted and another
that is untracked and has different contents.
* `git stash pop` should apply the changes, potentially with the
conflict markers.

What happened instead? (Actual behavior)
* The stash shows the deleted file but not the untracked one!
  ```
   d1/f | 1 -
   1 file changed, 1 deletion(-)
  ```
* `git stash pop` says it's unable to restore the untracked file.

What's different between what you expected and what actually happened?
* The stash entry doesn't show the untracked file. It should show it
(or refuse to create the stash).
* Trying `git checkout 'stash@{0}' -- d2/f` says it doesn't know about the file.

Anything else you want to add:
I seem to have lost the changes I made (symbolized by code2 above).
I wasn't able to restore them using any of the git commands that I know.
I'm no expert but I'm the best in my company at using Git, and yet I wasn't
able to restore code2 using any git commands.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.51.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Aug 11 21:15:09
PDT 2025; root:xnu-11417.140.69.701.11~1/RELEASE_ARM64_T6041 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
