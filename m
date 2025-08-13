Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59DA48
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043572; cv=none; b=CAFwyeKDby/DpuLI2ASWwrjCNcBK2/lV62V7Xj4RW9OifWwX6P08qarKHS8Rz1amtPBXTKTuBXD7+ERsV+4yQcCZw5Z8P4cm5NPuG7LQbHObkwYn+0bXzhel5XwRJXR6k4b76QzUVyccrUnSo2BHAcZC8rLkADVohIYQYlYaU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043572; c=relaxed/simple;
	bh=Wk5P7AK8JHpo8FVqmobaoLtp8YesvUsQ8hufCHYNab4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l795kmJQ4oW9hDCA0HArz/MSsUUhMjdKLKQdhHbp4der31BHvk+YqpmmXrrDYSR9CEtOZdRFilgtml3DiIXFRxkSTye1u7h+4KFOCfRiyt6xfkYtl0xGFi/WC56OnIVE3XjPkRdGoyip5ch91lcFnKhQgu1mPh3swX3Pn3wRCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwLskThn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwLskThn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F588C4CEF0
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755043572;
	bh=Wk5P7AK8JHpo8FVqmobaoLtp8YesvUsQ8hufCHYNab4=;
	h=From:Date:Subject:To:From;
	b=OwLskThnUZ1h5sBPgSWmE1pZhO/PXIkzIzbvQ5wn9nbJ+cxXTXwIhCv6EBZWug4uM
	 zURa30rrVdmqdeJL8OQoGDYzxlfdZuRwNfGgoBsAyAj2jvnUE0slN13S42llikxphx
	 EA05ffFcVqpt2fvxvD5H2EVXdXQHG/VCJB2aekiIinJGR9luQVfYfeghdW6eJXLz8l
	 kCRRX3uCiW7can+muNLH/QaE1l2GV8lAK8iQmGThgCZTsmhVFJXSWNkGggyG9Q+Oox
	 +B+ExzxVryfZw6tMfwtNg165cH3IZruuw30tMZSLFgq16oNPaCzEpQ/AzfsexSW5A6
	 QeNNMr6DRIKuQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso9533788a12.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:06:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwcxeFnkSo7g+bTlDKnbAjurAgxJXsl3RndmrHQbZYuzZ9UGXka
	VaHgQ98hudjF0STptJfTHwDD4cXMClbS/GiYnWmC5kzaIXkXDakuf/74OScyvYTYlBRckaIYMNL
	UO6RhENnDekciqd7rc60Ni55odHBjl5A=
X-Google-Smtp-Source: AGHT+IGhdo0n2peaUAY5kwPR0Croy20J+O2y3ZtJTHPp7+MpUsQV6BpQlGWaHs4ECIjyPStnVqGVTYCKLdRvyJR+Qs0=
X-Received: by 2002:a17:907:2d26:b0:af9:a2cb:f1a1 with SMTP id
 a640c23a62f3a-afca4dff3d1mr112520566b.38.1755043570728; Tue, 12 Aug 2025
 17:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 12 Aug 2025 19:05:33 -0500
X-Gmail-Original-Message-ID: <CAOZdJXWaC2U_YrwuDcA0x3iUeF_uJ658a93cTfdLftEXYRB52Q@mail.gmail.com>
X-Gm-Features: Ac12FXyPfJRpoyiJrYX--MOM7wcCpnYB7hwBElt_--SXoU2rdLEzO8bDyttup9w
Message-ID: <CAOZdJXWaC2U_YrwuDcA0x3iUeF_uJ658a93cTfdLftEXYRB52Q@mail.gmail.com>
Subject: [BUG] suppress-cc does not support multiple keywords
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I hope this isn't just some user error on my part, but whenever I use
the --suppress-cc option, and I specify more than one keyword (e.g.
--suppress-cc=author,self ), git complains that it doesn't recognize
the keyword.  It seems that it treats all of the comma-separated
keywords as one big keyword with commas in it.

Here's the git-bugreport:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git send-email --suppress-cc=author,self ...

What did you expect to happen? (Expected behavior)

The command to succeed, excluding "author" and "self" from the automatic CC.

What happened instead? (Actual behavior)

Unknown --suppress-cc field: 'author,self'

What's different between what you expected and what actually happened?

The --suppress-cc command should accept multiple keywords.

Anything else you want to add:

I was able to work around the problem by specifying --suppress-cc
multiple times,
once for each keyword.

[System Info]
git version 2.50.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.5.0
zlib: 1.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Linux 6.14.0-27-generic #27~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 2>
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
