Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4B1AD9D5
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426921; cv=none; b=luzFvjwM3KnD4TUy64w7uK9FNOtcsr+ZnfCVdsV8yxjcdeBnUYBh3WZBLHUYZoiwiUH2lSn9n6lJ1qC0IBEu3LVMVARffpz91qjY39cB3T95+/VXdSPv5Vye+axvlJPDtDZRpnOoOxJcv7ptxGkszqsUgKVT5tthORmiPrJQnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426921; c=relaxed/simple;
	bh=hwJMzOFPvfMxuMJdRK7oGRZOJkuL0b1BTInqFEqVZu8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pXIExXnzkb0Yj7NrVzHoCCx01EwRzPkxWYu0mK/EUXYcFoT6W6/p1LO9X7NbQYOdWxMYFtEp4b33LhPvuyg/qQXLrU+H4O0Nv2RggtUMwbpbqHC1GR11GomMtD/jFdKRXMJDd0lOdYiewvNj9rn0ZN9Ls1Xci2IKxD7tnqVO3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu5IUbBv; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu5IUbBv"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so84165001fa.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722426918; x=1723031718; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hwJMzOFPvfMxuMJdRK7oGRZOJkuL0b1BTInqFEqVZu8=;
        b=Fu5IUbBvIXHOoBW8hEbmT3x5yUnfIY0K2+eVOM0cSzSxO+asbZ/waO6YRAVRcf/ENy
         OwIMiprBTaEM4eIepAsocX10mDl/HiKi6uMuASqcZZksn/M/j0fNm8IxFtthkxcvj0gP
         bR915Tnr1QRy4HxP0BhEoL2mYxDzCr1MoFIsIkyPgvq4L+ar9GNRN0NHHWkVep9Eedo0
         KfOuw6ReLJxw2DnHyfMLqV+0PlYmtmmCI64dKD9a5CSpWbAfNx9qwHfUunypDnJmLG7g
         lerPlAghPbrAX4mJ36Lj/l0WQOZPnG2Np9GHdjY/cihn1WKSW0Ybmlyscq8/sTidYjF7
         iePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722426918; x=1723031718;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwJMzOFPvfMxuMJdRK7oGRZOJkuL0b1BTInqFEqVZu8=;
        b=voutMSLiqqUaUHUbtbnJzXxPPdCBLnVKQufVRJr0Vo2iBqZFDxKmqXKG7ESnoSarHQ
         pMNt3rcSTGnMC3U0KcdQ53vP1upIfmf34udONe9C2Q/mLpnUdgufs4v9l4cCg0qEYNlF
         MaAjm+o8xOcOPbfHlSfMcLZZJuQweNSWQelq8Oei0uJLrvB6l+/2/k3d/XUu646GAiKa
         wpEbzSxg154d4CAfOofbgWYeLhOuKekMO/b9Qp3gdDjbtlwnQmVV49+rOG/A2JkhmM7U
         iU6dRdf+fvYFxN5SaUkm5z8G5tM4Ok8KVYzftJ2Rf2jo9YHEWfQ2OlYGx6RMRHCR4iPy
         yGiQ==
X-Gm-Message-State: AOJu0YyCAdAL6VPudh2ZTzTT8YtkLXwNlbSSnKK8xhZ107WKs3SVDXBv
	OEZJZVgOFNOjXhvlycu7uedtUQrA8yFAnHY+3hUwEaQRqUB9DP52sgnFBT6/bw6jPaqNKsWDAai
	PIvuUc8xll6fwlYXP95uHsqclGBBJJwE2
X-Google-Smtp-Source: AGHT+IElmMEIhf4ITfg00Xhr9v2h2pfa03IvuWR35ExiRe1dRitpDtiNJJliYB/GEHlJMG4ly6qgGdmOt2593nLzDlE=
X-Received: by 2002:a2e:90cd:0:b0:2ef:24f3:fb9c with SMTP id
 38308e7fff4ca-2f12ee57c3amr118067181fa.38.1722426917413; Wed, 31 Jul 2024
 04:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 31 Jul 2024 23:55:06 +1200
Message-ID: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>
Subject: git config set --file, key-value pair without '= value', gives
 Segmentation fault
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

input:
cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
cat >'./config.txt' <<'EOF'
[section]
key
#key =
key = value1
key = value2
key = value3
key = value4
EOF
git config set --file './config.txt' --value='[2]' --fixed-value
'section.key' 'value6'

output: Segmentation fault
$?: 139

What did you expect to happen? (Expected behavior)

'./config.txt' has 'key = value6' appended to its end

What happened instead? (Actual behavior)

output: Segmentation fault
$?: 139

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
