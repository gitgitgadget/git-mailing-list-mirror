Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1F4C81
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653813; cv=none; b=HAgxHSSZBNDwinNRdhmgdPagfZ47TaQFjSuAJQ93f5hl2rS14ZiVWUuKBVnqxhhBj/iv5rxwLNd/C9u9b4RqJvuTCXEjixk51Z0wJTDoIWcGAQO/b7jzaP7Iln/s3N/mv7J10U55W0yg4gi9lmKigDfhIFfwtnAedikS5o25QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653813; c=relaxed/simple;
	bh=mFxSyI0pQVLDgHy7e/k8coNtUzjln0ZX/dtloCiYMKI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=STJSgU2mWQYzZJget3ecggFHvsirGeGax4ZI/Ai0bmRuUKtv62EdvW2JkpCyvDtIn8YKzSgS3FDfDWw7AN5zRukrCAQpqyLk8Xof3zsUqizoGfk3E3mnC5oLmWVzr++WnG4WEFd6u+pF4CU3eLrJyMyEvsOD7ZwqF7cSNhdygvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+u7LlIO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+u7LlIO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43260a5a096so219322f8f.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 14:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767653809; x=1768258609; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/uwYddRivyp9rdrQ3SkNa6yT2XbtVGNEfUeZ6FJa4E=;
        b=e+u7LlIO5Kg/BQ9xgMuqT0jsA6mxCnXqZjx/PhmFHlSmsJ4P87nNgGW44WrqhCJaM9
         028Oy9NQK1TFDlPXCNH8kiWaKBe8eUmdT/ncPf3nidizR0u7itwRJy6VCxtN8dM5FncL
         NZ5Y3Tq482f1yYBNI+DGnF/2toSruINFa6sebRHmzWyzAJoaqt8DpR/peqHN41OJFGK3
         8BfBdV3MmvT/HAMb2q+4lyZDLXXcH36pKvnNT9bQP0tqT92eSDJ5Lz7ibCAYqPrgwwy/
         V4N3N74uo6Ox3j611sQKP4ak6TGhEbIQbNKvdgCSrM+5MCIOpf27BF6H4xtUZsDo7h+U
         G9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767653809; x=1768258609;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/uwYddRivyp9rdrQ3SkNa6yT2XbtVGNEfUeZ6FJa4E=;
        b=E2rXsjlrPMzRPxv8z5oIoLf9ZHgXilOXNFAAgBbm0fPO4o4dU0XWKUhKT680/Uc4+5
         sFtABoUqnEivlFxuGW293lGcIt89s7rNNiwJAQy+1szHrDlDSmu0WmgL79qYBPBmBOfy
         amwA5SHA1NDFP7cLqRtTsgM/dCQ40iD6utLM1z6P8PrbYJenNWG1Yqj0JJJK77dZXuiQ
         D4I6Qh6qkBIGL0+JKfbxB4blT+hH5UP1bRx0Cqniva3c8yGtus3wYbIwVmutZtKVBta2
         MA3mXmjrtsbVOeCK0OMmBLG5jBhZlx26RrJiQuqh6AXQYciXQ0hbLz0sZARtLgFvPySk
         vkag==
X-Gm-Message-State: AOJu0Ywwpj+9z/OPyE9nMRidqJ6aVp9KNmtmX1wZmPct0ijqxzl0Z3a8
	TkNVmfPcKJXJk0GtZGrI0krZRlkEFoMJlFabqRK8W7jAQNY8J0krzi4zEU/D/LzezLwQkmwKJ8T
	8p0Jx0h0lHhquenY/JOBG4FAIj4yMQ0XHYv6q
X-Gm-Gg: AY/fxX5HsdPh4fa2VLiozTLf+zEMhLKnIuu503wYKcjSUnROdYmNgwwBLDMNd7C6aAI
	g0GFdohVLAJp43JlPwQI8xVW2Hoc5XFgUrhzM+zVpDGUyh0mz9JH5ZXG6M1hEloB7/CR7zp7lED
	MTlnbYGtCwuY3vfpsWl9Bkb64+ey0Mn5ACTKawWFymeW8ha5Ifkeq18oLU4c4Tpk9PoKxrVPbla
	zdQMTWyKGhJ31gSn5uKKVSfWcAfTU5Gmb8+XnDeJTBpTGe2WzwwSCX2jyq1qZSTMR/70VPWlFXf
	cZGU
X-Google-Smtp-Source: AGHT+IHaCuMj2ViTbJ/Y0A+ZpUsbpG6oe+XEBWdgh9CAxi3xxXx1BQjTpFGwokLtJMCH1iB64nl/h4OEZeDsHRnklSw=
X-Received: by 2002:a05:6000:200c:b0:430:f879:a0fc with SMTP id
 ffacd0b85a97d-432bca311ecmr1609849f8f.21.1767653809156; Mon, 05 Jan 2026
 14:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Harrison McCullough <mccullough.harrison@gmail.com>
Date: Mon, 5 Jan 2026 15:56:37 -0700
X-Gm-Features: AQt7F2p4I426qoYhzO6-zYpBi-kPMbxkvJQnyVvXEIiYcEA0a4PBRyzeiE8kIP4
Message-ID: <CAHLeu+ww7bBACO97ddkHeL2nkwmwqNL9G2Bjq18NZr5_d-MHyQ@mail.gmail.com>
Subject: Unexpected behavior in git diff --relative=<path>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

- Create a "foo.txt" file
- Commit the "foo.txt"
- Modify the "foo.txt" file
- Create a "foo/bar.txt" file
- Commit the "foo/bar.txt"
- Modify the "foo/bar.txt" file
- Run `git diff --name-only --relative=foo`


What did you expect to happen? (Expected behavior)

I would expect to only see modified files inside the "foo/" directory. For
example, I would expect this to be the output:

```
$ git diff --name-only --relative=foo
bar.txt
```


What happened instead? (Actual behavior)

Both the "foo/bar.txt" _and_ the "foo.txt" files were listed--but the "foo.txt"
file had the "foo" prefix stripped, appearing as just ".txt".

```
$ git diff --name-only --relative=foo
.txt
bar.txt
```


What's different between what you expected and what actually happened?

Using the `--relative=<path>` flag to `git diff` appears to simply remove the
prefix from each file, regardless of whether that is a full path prefix or just
part of the file name.


Anything else you want to add:

This is the relevant part of the man page for `git-diff`:

> When run from a subdirectory of the project, it can be told to exclude changes
> outside the directory and show pathnames relative to it with this option. When
> you are not in a subdirectory (e.g. in a bare repository), you can name which
> subdirectory to make the output relative to by giving a <path> as an argument.
> --no-relative can be used to countermand both diff.relative config option and
> previous --relative.

When I read this for the first time, I imagined that the behavior would be as
follows:

- `git diff`: include all changes, display file names beginning from repository
  root
- `git diff .`: include all changes in the current directory and "below",
  display file names beginning from repository root
- `git diff --relative=. .`: include all changes in the current
directory and "below",
  display file names beginning from the current directory
   - E.g. if the repository root is `/home/bob/repo/` and the current directory
     is `/home/bob/repo/foo/bar/`, then a modified file
     `/home/bob/repo/foo/bar/baz/qux.txt` would be displayed as `baz/qux.txt`
- `git diff --relative=.. ..`: include all changes in the parent
directory and "below",
  display file names beginning from the parent directory
   - E.g. if the repository root is `/home/bob/repo/` and the current directory
     is `/home/bob/repo/foo/bar/`, then a modified file
     `/home/bob/repo/foo/bar/baz/qux.txt` would be displayed as
`bar/baz/qux.txt`

I understand that my initial assumption may not be the intended
behavior. However, I don't think that stripping a prefix of a file name just
because the file name matched the argument to `--relative` makes much sense. If
that _is_ the desired behavior, I think that `--strip-prefix` or something
similar would be a better name. The name "relative", to me, makes it sound like
it is logically connected to the directory structure.

In addition, the description of the `--relative` flag claims that "it can be
told to exclude changes outside the directory ...". This implies that the
argument should be a directory. In practice, the argument _can_ be a directory,
but that isn't verified.

If this flag is working exactly as intended, then perhaps a clarifying comment
can be added to the documentation to explicitly state that the argument is
matched against the full file path, starting at the repository root, and is
removed from the beginning of the path (and the file is included in the output)
if it matches--regardless of whether the match matches a full directory path or
just the first portion of a file name.

I will note that if you want to make sure that the argument to the `--relative`
flag only matches against entire directories, not file name prefixes, you can
simply append a trailing slash to the end. In the case of the example I provided
above, I can run the following and get reasonable behavior:

```
$ git diff --name-only --relative=foo/
bar.txt
```




[System Info]
git version:
git version 2.46.2
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:30:55
PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6031 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]

-Harrison McCullough
