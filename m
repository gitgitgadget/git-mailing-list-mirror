Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD51BDCF
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930994; cv=none; b=OETdFg41VM9P3U7+1aXA2sScK/PKOn5SwP7uxiC9RYEx7pnMdQ0pqxXH7m9yvkIeGi1mHl8J9DhqIUN2VEnFZ/fI0/OwehpNqXrlc0AxGKPuDcy0dKjlDYZg9/h6ujFCcGFPa+smR2ZEtf1wLZV/JXrdtkM7k90bZEwWGwjrjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930994; c=relaxed/simple;
	bh=/LJy9HmBbqprCh+f1CIi/Vhi9IM5NIRiH5zrCLD+G7Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LbWlO9eucaWeDlEFRF1s34o8ZuOqgZIEvmWcimi0skoAbm5t1CRypVDZ4/3M+F8ZVrCTuWitGLqUu1GxfceEoMXqlK2pcufM3r3jgXATQ4ncmAgOrVo7jxBMjgLoi2Aa/lZhRlgMfYbc9+tZ04g8+bXttOgd07Cn+wt76fvT/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB+Z0vTm; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB+Z0vTm"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so1923744241.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 23:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708930991; x=1709535791; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6F0uDijYnPqaglB1dDOc2H0EPkRK5ChV40X2q6hCJhw=;
        b=XB+Z0vTmQ82Fb7tuvBmxQUQPpLnQpzvc7BDovYbgXTSvEXbzAZXTAKPSK/ZiRkaAIy
         yhKZlzj290wSWi20E7/FRsjZGLY5UhAOW8C1TjQADvkMeK23U5EywwBNyYTPvZ00oFQL
         JZp5Iek/ayRbPUi8ABPKU2oG09QMsL/tBx1TJ2mYNz9GYOLD6LQJTm2/UL+LVSkQ9VlH
         uIUbL7MYQB8r1T1Lt4sU7C+JutJ3fBKUw7YxcAdBcHWy8+PQnS37n/5UoO/sI9z4wLPO
         ScpG6Mn0MiNri0vjs9MDmEWkQk2iWt4Z6kSBz7mgSiXHjHmPKUCL4YkpVl6jmJjZDTZJ
         rDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708930991; x=1709535791;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6F0uDijYnPqaglB1dDOc2H0EPkRK5ChV40X2q6hCJhw=;
        b=gC7bbwPfKEdKdbOj5/iYM9z2pfvWMTcRpzEQT8hAO+Mdkv7+r8tfxz+N2ufNcglMjL
         g5lclle/aBlxoKZ9jfuE8Cww2kezFvQQ2FZB+Kfd+dBF4hgiq72djMKhgolJMOqHjxh1
         Cpulnth7mwh0zNRMhG1nXb6Sm+JliuNd35P9G/iBaPBLNl7J7OJeYu9oh18k6lY0J+F/
         /99u66QDi9kiT8aLC2vl8g/+oVTP7e2eTmpCiACRYKJRCeZ+Qny6IIV4y8VjAFAqryhD
         8xo6d0Nt7dhn+d1Y1oZiGbZijk2wryQvVCTF9e5u/7Ny4/FVnvaOSijupeOPri5yXNC9
         jlhA==
X-Gm-Message-State: AOJu0YwuIddnpa8nnPLx8ahjCIwTur4GxMfn+jBYOfjNuimMATuktJSh
	5raNMdEezayFYgLlZnLChUStfx68EHyjyL3N7A1u7JXlcKzuprll8m61Hh+Ru7zpWEwcRhG5LXy
	dkbF5MwfXc58yp6AMu1XUX54aL19KnjNuPqU=
X-Google-Smtp-Source: AGHT+IGPR5RcorHzJU4797BPQTnCyk+3BD4olIH3Al2+Rmpqbd2e+Bh8nR8u5FxO5j9fQqzOwwfWvkK2gWhE6INUe+o=
X-Received: by 2002:a1f:cac1:0:b0:4cb:277d:9d22 with SMTP id
 a184-20020a1fcac1000000b004cb277d9d22mr2558607vkg.16.1708930991453; Sun, 25
 Feb 2024 23:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Pawe=C5=82_Dominiak?= <dominiak.pawel@gmail.com>
Date: Mon, 26 Feb 2024 08:03:04 +0100
Message-ID: <CACeVQwQ4MELjB8nZyeu9QDTtgwhhw0oOsL8BHdm_rxTj1vMy+A@mail.gmail.com>
Subject: Bug: diff --no-index with cachetextconv crashes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey!

That's my first bug report for git and my first email to a mailing
list in general, I hope for understanding :)

[Steps to reproduce your issue]

Global .gitattributes:

*.txt diff=test

Global .gitconfig:

[diff "test"]
    textconv = cat
    cachetextconv = true

Called command:

git --no-pager diff --no-index foo.txt bar.txt

[Expected behavior]

diff --git a/foo.txt b/bar.txt
index f6a4b70..2b24d27 100644
--- a/foo.txt
+++ b/bar.txt
@@ -1 +1 @@
-Foo bar baz
+Foo bar qux

[Actual behavior]

BUG: refs.c:2095: attempting to get main_ref_store outside of repository

The command works as expected if cachetextconv is disabled:

git --no-pager -c diff.test.cachetextconv=false diff --no-index foo.txt bar.txt

[System Info]
git version 2.44.0.windows.1
cpu: x86_64
built from commit: ad0bbfffa543db6979717be96df630d3e5741331
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe

[Enabled Hooks]
not run from a git repository - no hooks to show

Pawel
