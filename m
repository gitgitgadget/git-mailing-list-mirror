Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9914A4E0
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369069; cv=none; b=pHG94qLvQiEG8TvXxeULM/4J8i9QQNLos+rl2ErN0gx9oKhv7Ayyiit0HbwQ3dam5CQ0ZcJnqOAqM1YrEZBoeYwOShTgcqbdetaxQ1LYBjiTDwz80tESld6JT1Av9LWhdOqN2NuEBXjXT/13kT7mJe/475Ie4Dj/riCbr2XEi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369069; c=relaxed/simple;
	bh=kUa4sqPp+pArN+3ei0yODdFQ3IuIyX64C62f8Ax1cvU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JAXMLC+z/OnC4Kn5i5iUrbihmisGb6ClbQTMB9iCuxqt3SJbLcNR0vYj+SIEkRMAfwhFPkEPM/+JzVv6Lnq2elTgaK0CWb4VnF85ixVuvFoD3Sw+QMrhM1s/f/mZY+xE68PTEB0TGBfEhU2ZIjC8uvfXDFlMRhVgCdQumLJsGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqS/kUvg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqS/kUvg"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so532239a12.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727369067; x=1727973867; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUa4sqPp+pArN+3ei0yODdFQ3IuIyX64C62f8Ax1cvU=;
        b=PqS/kUvgp299qFk/14Ja2DOkf+fLZGNNL0fU5cTw8zcD+qwnb9RCySVGsqhNYG7Bfh
         6keUrHC2AJ0U+X8OV3x5+aXk6m3umqN3w8G90sI8Wf2CS1GrAQ3g2SkgSo1NtfxkMW+J
         SeNrKMcFJcly1F9zxAUPm/JwBgrnXn5BMQehIwF3zZfLx9Odr9GIXkE7BNata2gyIfUy
         TLVdhNKJBhxhal0EqJP2uTH+4kfN2ebqXemY2+g67Dcdlvi+NNJjNCO8DXRXMFh3vz6K
         IaXNFEi4P71Y1+MAjz7RHdmUpRqiPAFIkcgnfeV7QwGF69kbPwwai/9XX1eSKW5Nfg4l
         SsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727369067; x=1727973867;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUa4sqPp+pArN+3ei0yODdFQ3IuIyX64C62f8Ax1cvU=;
        b=Hd80PJraxdqU2gZ1/tMEp57Yb3dcmJ1E5TGLZq1qS1nh9nIoBvbqQ5OLGff69j3pyr
         s7GdAVURL6WcMDYJec8/9F/HD1mlKLvklhE2GfqB0oUE4DC0F0Ksk0OueTrS4rd8s8Os
         RDRtP+iYjmSHXEvVurgfHNBoo04hMUz0xrKWU30oeyl4YYaUqEp3v9LM1flCldunLYwT
         IVAt+jaYeyl5aafsh0liqyMOQKL3k9ntKYxTGEHueHjMgovxbLb8PIya5H7GtPTCmB0+
         C1BWQBHY+JR+x9nK1Xb/f9VAY2p5NIAS6Un76l7DmLLPFMgdr3ofzKssw2g24iQ5wdbL
         rB/Q==
X-Gm-Message-State: AOJu0YyISSy2x0NbOFjO018IVwHrL5dpnY6KC3lW9FPPXRh0koiLfdKY
	b41sI4huM7L/St6q8Hnn2EudPgNPdNmszOva+03MfsOm5V+GAc2BAtehb2hLy0gG+vVUsRhm2wt
	tufmVQZXINl0tKAjVXsZCfqKDSHX0mtga
X-Google-Smtp-Source: AGHT+IF5xVRFo8MvlPc6AP4sdwiycfCVzSPunEBlYSZl8uzS+uhPjyDhSCsO5fYlLIuNFa/udT0DTr5AXs21VBNqKao=
X-Received: by 2002:a17:90a:ee90:b0:2e0:876c:8cba with SMTP id
 98e67ed59e1d1-2e0b8b1dd54mr409962a91.20.1727369066739; Thu, 26 Sep 2024
 09:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Thu, 26 Sep 2024 18:44:10 +0200
Message-ID: <CAPM0=yD3SevBKhCOqOzjpEqX=4Z7BLJU2hKRFb2KtOgFEco8cw@mail.gmail.com>
Subject: "git stash push" doesn't respect pathspec regarding files added to index
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
# Create repository with two files
git init
echo 'old contents in foo' >foo
echo 'old contents in bar' >bar
git add foo bar
git commit -m 'init'
# Modify both files and add them to index
echo 'new contents in foo' >foo
echo 'new contents in bar' >bar
git add foo bar
# Push stash with only "foo" in the pathspec
git stash push foo
# Reset and pop the stash
git reset --hard
git stash pop

What did you expect to happen? (Expected behavior)
Only the file "foo" should be restored from the stash.

What happened instead? (Actual behavior)
The stash entry stores and consequently restores changes in both files.

What's different between what you expected and what actually happened?
The changes in the file "bar" should not be included in the created stash entry.

Anything else you want to add:
This happens only if the files are added to the index.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-45-generic #45~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Wed Sep 11 15:25:05 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Regards
Piotr Siupa
