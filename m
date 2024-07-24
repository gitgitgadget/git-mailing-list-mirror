Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBBDF5B
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789253; cv=none; b=rQLe0UDPJf11wK5SWw8qldlm+9yaTrTd8GAXyk9VfNwl+ZlXCe/em00snWvHa8AXql2Nysp5ZQ4+8Zr/JAZU/iJ0PdNaePfkyXkwFWj1Z8XFrMpu3kE3MlqIh7rvUDY8YizABCnKsZFoQHvVE7VYtLkNKIfUcaexK4JkI0iiYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789253; c=relaxed/simple;
	bh=7fjT9cpSSCJNL1e55V0p8Gi4lUS/v9T4buR3NVX45/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UqCeiZ1yWQQIrI1bWluOVUEoOy7n1NkgNrZfbEBLXhWJWHzplj7yN8WRUeDZzOYEIPN9tlSsT3ESOMwOpiWVoniQebydQNQYN5nmCAqET5vDRNpmupqF6Qwy14WOox8D2H3a2/71x+wqABHZJ9Be1R0N6ueg6l2PJrkHWdlgKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brown.edu; spf=pass smtp.mailfrom=brown.edu; dkim=pass (2048-bit key) header.d=brown.edu header.i=@brown.edu header.b=DhgWrg1T; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brown.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brown.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brown.edu header.i=@brown.edu header.b="DhgWrg1T"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e05ebd3d607so6239114276.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brown.edu; s=google; t=1721789250; x=1722394050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q96pEfYcmC6/5yLo+83+OR3ltsc0oVemlWz6ddR0oRA=;
        b=DhgWrg1T6P5Vft2FrhlnffHB7dHMuJYYcmw2bPbdvnBTsf3RsbNCNoAl54eJf3bF4G
         IzuQHmwAuJgA8tOxwfmrcWeomroUgedH6cN3Oag/MOPWjAXB/qS6xwCKmPaRtuZO2Hla
         IGuk+iBfiI5CNRqFsClkxR8xne454IN5LdfYcDqk8P+LxLozc1/DdHIWjCteNXVB2Tx/
         agrjnZH3/ui50gVD6LVgeVc/ihEddYRi4IyHV1D5/mTlDIKV4rsCfI2cLa+5vsN5Hfgg
         cP5HWXLUg45b/HCLS4odTPJ2k71auIfu2Gfe00JcGYnY2OlrodJywCyVEDvBYy+1E+dA
         IASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721789250; x=1722394050;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q96pEfYcmC6/5yLo+83+OR3ltsc0oVemlWz6ddR0oRA=;
        b=HlIr4v5cUMOykte0sNZ+ETyx8lj19IPwXXHH5LUnVbvcz3Ns/UvyXkuxoQoG5APaZQ
         LYtt8dP05Loj0Ce3v2qOhrngZqvwdxgzFbu9ZiuT/VKjG3p+GPZ6NuHfcmNBzlNWbEAH
         BksDBL6rKt7QZBvEFU1Il9zzBmkP+bY2kq9PLbF37irnH6hKfrd4QK+pjf1AR6PEIqCk
         ve1PKt+r6HjKJQSU/DKGNDTuw8x/sXdPBp6G8W37BmdAZGC4LAP+ir4WUDqCMqHsVZ4f
         uOMVbswKB7l1J04urXJd99DsXUzBpM5vCgzrfRhJVdPukCvHKwztbyakfyyIpJlgkIMh
         a4Ng==
X-Gm-Message-State: AOJu0Yxy7ANWpKbIMxuL4mw4XjpXKJ9sam4o6OG+RGJMZ0no3lGEdbOS
	+0qphNBYGhuoe5IAb1vkMoMr+X8WzFnJEyTZoE5Jbk8bGavPa0lFeOahTvXv4uN64XV+2lcXJNH
	8a0alq9B4Js/ABqt1HK88mBJVuCACCGdKFCE0o2w6hGU1nB4eCA==
X-Google-Smtp-Source: AGHT+IEFCW3ihi44JAo6Ov3tgBjIvpJJZG5PK5Ae8WIU4XR34gxld7lKrUrPjmcBC95HZqu1ALYT3uebmSfmxh4OhTU=
X-Received: by 2002:a05:6902:1614:b0:dff:4a3:2df4 with SMTP id
 3f1490d57ef6-e0b097baf24mr2254092276.31.1721789250443; Tue, 23 Jul 2024
 19:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Jin, Di" <di_jin@brown.edu>
Date: Tue, 23 Jul 2024 22:47:19 -0400
Message-ID: <CAKOkDnMGRfQoNygYLiAxPZB2q=VMYvw8kyu1dM=pM843-FH41Q@mail.gmail.com>
Subject: EXDEV when re-init with --separate-git-dir option
To: git@vger.kernel.org
Cc: Nikos Vasilakis <nikos_vasilakis@brown.edu>, michael@greenberg.science
Content-Type: text/plain; charset="UTF-8"

Dear maintainers,

We discovered that re-init with option --separate-git-dir will throw
an EXDEV when the target directory is not on the same file system as
the original directory.

An example is shown below:

$ mkdir -p fs1/gitdir fs2
$ ls
fs1  fs2
$ sudo mount -t tmpfs tmpfs fs2
$ cd fs1/gitdir
$ git init
Initialized empty Git repository in /home/user/fs1/gitdir/.git/
$ git init --separate-git-dir ../../fs2/surrealgitdir
fatal: unable to move /home/user/fs1/gitdir/.git to
/home/user/fs2/surrealgitdir: Invalid cross-device link

We tested this on version v2.45.2 and after reading the code a bit we
believe the issue still exist in the master branch on github
(https://github.com/git/git/blob/d19b6cd2dd72dc811f19df4b32c7ed223256c3ee/setup.c#L2280).

Best regards,
Di
