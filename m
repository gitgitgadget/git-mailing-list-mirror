Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274E1A2C22
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570594; cv=none; b=h/Y0Kl4r801C4gcL0ZKLQ7mP/NWkxV7eAvtFgxkma2q/DdGiS7j5v4Qjh/jC00fwe3MtC4MObkHpe/1QbYgWm3jx/iAfIrqTGRoGAYbzTGpf3UxBPWE/QDMqILQQ7n1Wt4Nz6aB5YjPuThqx/lPKgZqkdwV84e7g4wd0FnOtM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570594; c=relaxed/simple;
	bh=ux1ltjB7fEpye+TnmiTq1fmdc6AU3AFDmWw30Fex0gE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=H4JN8WaGpfDaEvhrcsCWYdGqSN57jx15IIT9O3gkmX7DmPOiQ+uCFiTuMYLLzjKStnxGERJP0spdJH23VpaxfRPaki5j7ZCLAp3LwREHSeB5k+VJMsEae2uX5p/xb+mMu2/E5hvjI0T/a3Slm/ezauZG3qSSuDXYartvzfscx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbWvdYhR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbWvdYhR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd6ed7688cso50502295ad.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723570592; x=1724175392; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ux1ltjB7fEpye+TnmiTq1fmdc6AU3AFDmWw30Fex0gE=;
        b=EbWvdYhRr7jiMRtD9moZaIlsFQ6JRdDNJiGWCcOOLwzoOGXJ9Bvbo4SDBxMV6fFBhD
         ZNCdl2qNqnPAtjY08oeNYVktYcwzuv5/sl6jDuzsa0Z+QBIsvhF16z5Nvn9Z6Ave1S+d
         c+M2nqBWwUVG/Tiig+v5kNWVjoNuE6zlmBk301Soz/CrCdPuQXtlnYbTOWY3EYrNqz/g
         mh9JVY/kbABsXvGl9Yk4ZFCHFmevnY6grhHDzeSYzU1fNp8NEuB8R4ua5sVO29vdFkU+
         pZSIg9EVSZ3gZmUSOAJBqG8y+O+1fGRxB6p8+ZJpWQCZg7+zGcOZ6LeXHmaCzWinfW4o
         bxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570592; x=1724175392;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ux1ltjB7fEpye+TnmiTq1fmdc6AU3AFDmWw30Fex0gE=;
        b=rw60NuROfQPYxcc6UbJpal5WH9DqWPzIPck9TwMO6MncGphG+GgrHQp8HooDm+Q5T9
         i4bqkPEk27jzrPl0MT0D1DGbCVRvuWC/BACXU/oqIU/uixUKXJT0vLh3MECob7QmjeBA
         h7uxOHdlbx/K7I2bJh11/QTFHu56QwGUeJFpzb+8WLtf3bJSKHnLpej2k+x/2+cM0MEZ
         j51OLm0zhbLij+yAVfI8z0tY1VJuMdBNqjM0hqzANhL/eIdrLlPBZKSJfnNAkOlahkww
         2cydPXlABuP60ayH34mR3EZlvYoBUEraIRYrqT0B9CtYVk8gCdhTsR8W+j87pUpqoxY/
         rE2g==
X-Gm-Message-State: AOJu0YwmFIbOdlJOT828Mo38cvF6YAGB0qTirLtlYgRFml7bPj7rGgG7
	AkbmMsU4QZWJ1uORTy2KxHKIFRMmeaYZ8laE5DDoTMPIshfDSRUcVDLShNUmzdBdktQ37MeQZwZ
	qDDQ5j2XgfyM6xrRPLO8RCHUodi2c3f96
X-Google-Smtp-Source: AGHT+IGwBxtFwlpXGqV8ylPIdh284oL4VaH0l0psVSJZnkGb1eiKYfMvRrGkM96sDyVzpJqp+Hp8ERHoqFi1kxxksjw=
X-Received: by 2002:a17:903:2447:b0:1fd:9b96:32d4 with SMTP id
 d9443c01a7336-201d64a5a2dmr3123855ad.51.1723570592181; Tue, 13 Aug 2024
 10:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Tue, 13 Aug 2024 19:36:15 +0200
Message-ID: <CAPM0=yCJ0snEznK0C+zkmGofWHE3OPWoMXSVGH6=TdM7=rZ84g@mail.gmail.com>
Subject: "git-stash --keep-index" crashes when there are no tracked files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I've found a bug.
It's something that's unlikely to happen in a normal workflow but it
breaks a script I'm trying to write.

Here is the complete report from "git bugreport":

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git init
git commit --allow-empty --message='initial commit'
touch foo
git stash push --include-untracked --keep-index

What did you expect to happen? (Expected behavior)
A stash entry storing the untracked file "foo" should be created. The
working directory and index should become empty.

What happened instead? (Actual behavior)
The command did what was expected but after that it crashed with the
following error message:
error: pathspec ':/' did not match any file(s) known to git

What's different between what you expected and what actually happened?
There should be no error message and the exit code should be 0.

Anything else you want to add:
This happens only if there are no files in the current HEAD. Adding
any file to the initial commit prevents the error from occurring (even
if it is unchanged when the stash is created).
I suspect that the command has trouble with the corner case of
restoring the state of the index when there are no tracked files.
I also tested it using executables of "git-stash" compiled from
current branches "maint" and "next". The behavior is the same.

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
uname: Linux 6.8.0-39-generic #39~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Wed Jul 10 15:35:09 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
