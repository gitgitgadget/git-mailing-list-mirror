Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D411A5BB3
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744553254; cv=none; b=qXxVd0wiW+EQ1seJ1ZGS0BF9zR0HblJxvCbctDREzSDQCX+lF+msm7GhbtmjPdgVNi338bYcbMWiIqIr9Ac9lpjK6lofAQ/FxSXk5kSsJo27fTju7oUibBiRRlqI3cBbvwgaForCwhyXzwrxCRmcy1TSswdZ+L/BnYeSv0VRwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744553254; c=relaxed/simple;
	bh=1NyN6WA+Z61ScREL3DQCz3X1kprD5TIdocQJbPTkoWI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B30j6NrtvN+P3vaP1s0RR7x+lCGn+LDpD1GeclckcS67jUa9JR2y6HfeQX9pzFg2TQU89Q+eYQUt9TrEP/9YAf+JGhYSnwoSBA1th52m43MHP/zhJSm0RRlJ5nh5B3nryqM7D4oApw0SLvYeFWAljYN5l1gWcZ29MfJ2Gv4QGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMfQZLvM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMfQZLvM"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85e15dc8035so113947739f.0
        for <git@vger.kernel.org>; Sun, 13 Apr 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744553252; x=1745158052; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1NyN6WA+Z61ScREL3DQCz3X1kprD5TIdocQJbPTkoWI=;
        b=EMfQZLvMthVwOQCPZMl7CZxY+I5SkS5b/nNJT4q1BSr1Mh16VlxVobd64x2Z5UR3X5
         DqlgLe3umnGuJPs/kfDpatjmXMBt6hyb87OIEV+bionXfF1h9T/c8gUFR/NWSu63DDQf
         dJI4fHX7vUgxNbxB+P5ABv6lubINmlSEe0mAfoSUSc20N5HVQEpkN3uuJtt95bsLzCNa
         U6QB8IAk82F2G7KYGDifRxacJYVgqBh7xp/fODbuvqHNsjVCYaJkerfMmkLrLwuZ7iBd
         zxUJsxsGC4jqnxKOmtGJza5hAofayGv3ixEi5yeSMvtQ4R/bADSroIfE0F0xyU3+cEb2
         z67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744553252; x=1745158052;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NyN6WA+Z61ScREL3DQCz3X1kprD5TIdocQJbPTkoWI=;
        b=eFRZe3iLa/EuVT0dDMoeEgH8zHr/RfSYTmvoTW7CRt4vzs/ZpMWGOgPuXo1ehQhnZq
         7lHZp29zhaZc6m0iS3tgwMPFO/OVWzoySsYwXw2PDPX0b4zu3ZTqSHIwmuAScsn1OP/8
         u/AVbVTA7wG3cWyDKxym4pgoqhF/+3Vinv74FdIt5WQA1jsIjD3DbnWuSqapdE5ESiur
         FunQpwtPEHaeUTp+PUjJqHdHVwvOEEKMSGryIsDF86umQLAvM3WgtmJWkVnKCf5hlq0S
         hGXgy/Uql3B8d1yNSTkN5imic3c8atbSwyuFKre+N8yTb+63ru8OJjnpuHmnz/ZUw34f
         xoHg==
X-Gm-Message-State: AOJu0YwHZesxwVzAiIPehF6yX2D6XC0VmU5tFcci4EUQqxHqYgcLN4Dz
	85UJ3B827c0GdlRSRJW4XmfRnM/Ks23SgHy7lpmEYrQtJJFLLKXe+1yvq1uQ9f6O+cr+VC1Wt4d
	c8rHy01Yb60ZkFu7RfTmuvIDSnLfcAyPu
X-Gm-Gg: ASbGnctcwj9tHYXgYvsnS52HYIQuJKmUvduA2c9BReD0ZsvdijGDYlv8LmeSXPylC14
	htmBAd+K2wGT3Mkcj3Q5hDl6BBsit0S7aKeDka8kLdEIkhIZO/fqSG7tPp/AUhH9a/gT9GPa6Lt
	PbaeVHjjmMR5qS98f0qWHSqeo=
X-Google-Smtp-Source: AGHT+IEWmDz2FYdBvXdMuCdBwUyLEEyf7TJl5stGbJMz+dLYOAy7pJOgo4R42UUgpALHOJ0vZIBUWxkLQkr6qDb63Tc=
X-Received: by 2002:a05:6602:728f:b0:85b:4941:3fe2 with SMTP id
 ca18e2360f4ac-8617cbba939mr1019697839f.7.1744553251545; Sun, 13 Apr 2025
 07:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kirill <ks1322@gmail.com>
Date: Sun, 13 Apr 2025 17:07:20 +0300
X-Gm-Features: ATxdqUFlH3WVdXKFckfkAzhSNkA-yBPRGYqWElxQlkluOpf8OzA4m2N5NmMD8bk
Message-ID: <CAKFQ_Q93M=x_xNuCm_evjUSfi_cNGQ0LuZSHVua1vTZHc0e-7w@mail.gmail.com>
Subject: Bug: git difftool --tool=meld -d HEAD^ lose copied file
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir git-copy-lost
cd git-copy-lost
git init
touch file
git add file
git commit -am "message"
git rm file
git commit -am "message"
git difftool --tool=meld -d HEAD^

In meld right click on `file` in left pane and press "Copy To Right" in menu
Quit meld

ls -l

What did you expect to happen? (Expected behavior)

`file` is present in working directory

What happened instead? (Actual behavior)

`file` is absent in working directory

What's different between what you expected and what actually happened?

`file` is missing while it was copied in meld with "Copy To Right" button

Anything else you want to add:

This bug was also reported for meld but I don't think meld can do
anything with it
because copied file is being lost in temporary directory like
/tmp/git-difftool.7bOf2n/right/ created by git
Meld bug: https://gitlab.gnome.org/GNOME/meld/-/issues/555

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.9.1
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib-ng: 2.2.3
uname: Linux 6.13.9-200.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Mar 29
01:29:31 UTC 2025 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
