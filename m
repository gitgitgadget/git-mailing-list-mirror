Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7518C327
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966453; cv=none; b=mDHNOZWHxQoEVq/mNUR5J+PNfOCnwm92Rwn5fQP/Q6weJ1EkQPhaYQvNyykf4dykIYkdHg20dzkioJRAzgJt5GQiZ2yoUDuGZYjeoAgqufs0woxJ6rEyLpR3v1oITUSyQ2BJ4Uhh8actfGzju2tfcQXCeyFhPgjc5MUi6Hp0JIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966453; c=relaxed/simple;
	bh=67wT8OntQYN3AgigwfYrY2vYmPUJf/VRT/9ffCZCeuI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=athGwgwwLk+t8r7koyoqr12gsDEKawM5UrtrHRmh3ixls3agNp9m77Dv6Ep1BcUaSQO+mU890MKhAglCH7k6gM1XR1USumnwjtSWdmxi3Mb+h5QBGOybzXN8PDtvKQAn7flUpr8t1YZyM85eSfxUrRqiJSA9/DlHaInmtE8ue7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5PAjRTY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5PAjRTY"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3436553a12.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725966451; x=1726571251; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67wT8OntQYN3AgigwfYrY2vYmPUJf/VRT/9ffCZCeuI=;
        b=K5PAjRTYZIjGHw1lRlyLYR0hwjrOcIsB7BGjl5sVhDpl4EBSAjrujmhg+HV1/JCqtE
         tlUqLDgfihztuWQsY9/SShJ/w1hVLR0mmbtJ5MGrSfXEwebdpaf6mqP45uVGLaEkdAX0
         LZOFWdFTOmxNYnrnIJHlXQKCVP44zVE1aHxiyH5qybY1hfr+yLy5lUejlyPY1IcHv9ac
         QhHr0m6+vWnSLftQEmy8mNJD+shNWiGzOF7dMkvW6qSCrefafKd9w0vcEgRFsqfLpRMT
         8+ACopDivajm2zDnxnuCCsKdpkvp/UPAsWe7hCrcukDSKrfXJryOOCh71bQUSqYb3wv3
         T4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966451; x=1726571251;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67wT8OntQYN3AgigwfYrY2vYmPUJf/VRT/9ffCZCeuI=;
        b=DtLBFiKO7l7PZbSdFRORTMVQTAxlWHNgojfa/ex5gu7qdxqjLmdWOa3qahYSBNZQBL
         aOkz+GaFkhek2aqTNwKGJy9wR3AUNCZtb2BAq56KgxF5e+r/2rL3al6ZQ0Z4SBw0eosx
         XxV925mrcYlCcTmvoPT6MAAyUt8UwwJB0fzFN1AVX9gj4byHisl3JJvAuGYAgTJ2QZK7
         owOdEevhuRRiavfzRJNVwVazB4LG7i+gmBjIbzXKIMroRyfxNopJNfdONI4paAAL159C
         jRANwn+a6BM1/bk/w+qCD37ayHYFTTimkDzK1lH2+NNC563T1xugf9Eklnxk2fhE7++i
         toGQ==
X-Gm-Message-State: AOJu0YyO7Vf+ifZGoAWF7SP8vsc+Ls0Ut22iYC6J//6jxHqjVxjsp4lz
	wYeoFEDTg7qE1avCEr2J+LECNdrpKwh6WcV/PRJWF11bdB+myeAbeHPwX+iXK8DtWTjnjVIdK9C
	Z7OUDpbE4dowkV8z+0XbwRQTrQDYdz0JR
X-Google-Smtp-Source: AGHT+IGqiihZtUKTBq8VfYiqkEe+26HSxSYbvns3sw2D09D01BIZd8Raj//qcE5s8+oCxBsobFs7XXxAlmpyttwuQdM=
X-Received: by 2002:a17:90b:3e8a:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2dad4de4d19mr14038074a91.1.1725966451366; Tue, 10 Sep 2024
 04:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Tue, 10 Sep 2024 23:07:19 +1200
Message-ID: <CANrWfmTz6x0qmTDaTOF_USR+fDcVdwfpUJDhjozb_VzBAnUJsA@mail.gmail.com>
Subject: `git diff --break-rewrites` does not work (otherwise it should break
 rewrite into delete and create, for `--find-renames` to work)
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git2'; mkdir "$_"; cd "$_";
mkdir --parents -- './repo';
git init './repo'
echo -e 'a\nb\nc\nd\ne\nf\ng\nh\ni\nj' >'./repo/file1'
echo -e '0\n1\n2\n3\n4\n5\n6\n7\n8\n9' >'./repo/file2'
git -C './repo' add './file1' './file2'
mv './repo/file2' './repo/file3'
mv './repo/file1' './repo/file2'
git -C './repo' add --intent-to-add './file3'
git -C './repo' diff --break-rewrites='50%/50%' --find-renames='50%'

What did you expect to happen? (Expected behavior)

`git diff` outputs: file1 rename to file2, file2 rename to file3

What happened instead? (Actual behavior)

`git diff` outputs: file1 remove all content, file2 complete rewrite,
file3 add all content

What's different between what you expected and what actually happened?

Anything else you want to add:

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
