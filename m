Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DE1E04AB
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551360; cv=none; b=N0hqnzV1/VGvmnX0mGOFkcMNxPwsEr3gdBUEZ7qhDJNhLq9UhJlx/EVMB6QUi94rQ+tQUwdyzsNeqE7s4QXkwgjjGA/HkqZgMvFl4ZByEOYcnzYGbeCabLP5UeIYdJ+kJ/lHhObRWRbZHuiLqb1sf+BQ/dx1OPJA6fxLGFolf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551360; c=relaxed/simple;
	bh=FV7JZaC7bCqaLE335yc5E+KvNWrFi+FIq7N3DSJLHfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X9dxIpIYE5fb8ZzluIYLBwXsl3Ov49z0/BsN6pKhCxWrxqfEUKXRc91A9pXNfzGZPfXQKKmjhwD/HvCE6Pgi/3Xg4b8o0d/+Sogf5w6Ga3rzMTwR6ZFkebgd2jS33OGPA9orjy+LLfjOQVkSoXoZ7BAz+SFDumvgWd/OdReQFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBXiFToZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBXiFToZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43153c6f70aso48045e9.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729551357; x=1730156157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FV7JZaC7bCqaLE335yc5E+KvNWrFi+FIq7N3DSJLHfA=;
        b=bBXiFToZUgrINdtt+znVLoANVWKfliJrXjNiGL7gXorYBBG/UwG5OXgSU+zQkKKa04
         7VfgzvajJ3nnR7+LUkNz/hR2u2DD9RRX6E6JLJ+86h6Kg3mQJRCHg/oJxldveN+Qu1Ih
         4cWU+eOUPJSobg8QEX/FP3iBAjqjENUz354/HRl3p9n3ArJLwi1Yqp5ssbxpxUmIKLqz
         fFg4P3myMCh68l+eFBoS4CBr8FVgOC8I/LOr+Km4XaKxKK1fnszn84H5HGA7L/3gP5JK
         KqKKUOMtL0qJAjK+lUzPyQPKXEhvDj1Rn7z1xoOUi/96xKgR7lXjXCNwjSnVALe7RFm0
         IYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551357; x=1730156157;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FV7JZaC7bCqaLE335yc5E+KvNWrFi+FIq7N3DSJLHfA=;
        b=t74+0ehy1E5LYL6ZNiYZ9XS9IboKk/QFfF4qk9L0W0x4mmwcaRWZIZ5IcilZZOoKgG
         bygyyEzj2MWBfQO/UjOi2v8ma3+JLcHl9Yihf+lfG/a3Vi9KsxhFY2CZwca94fIb099s
         qd+lkZZOPgBrlEy81LmD7iMJOBW9jF+9pc5TmGLCDKLk9HFMra7NgKHyAwM4Bb/bsOsp
         9g+qzrSN0TFvtjPXl7mr+SY8UM4M6cxRzYlFejcSMN0aZN87ORidgpx6bUrw379V5TaL
         jy8UEFbWQ+egKOqkUM02dDh54L50/N/U+6g3hucVu3Zh2tuam3JEYlC3JvOCCNB9xg6G
         o2yw==
X-Gm-Message-State: AOJu0YyTEhlFzb+92vrbXyG6e1HWTjlm0bCthhqDY49OwqteXL4RYSVi
	tGhZU6txD4s+bfRODQSJl0sbPcQbAGC+Khl41Ny1udKvqviThsAWa2XlXcemmPpzv9LQd49LvBu
	0e55zbO0adAKEzNaDR4ZCX63T5GK6GKJqlCJOPnaEapcltB0y7g==
X-Google-Smtp-Source: AGHT+IFnKOnj1MisxVYyd40Ru01XyZRr+GHKxeSqlTL4KJycn0G073FRYrYqCEkd+p8o4uynIUZH3+zpD1nk4fQQR+8=
X-Received: by 2002:a05:600c:1d9f:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-4317c755463mr1807635e9.2.1729551357232; Mon, 21 Oct 2024
 15:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Calvin Wan <calvinwan@google.com>
Date: Mon, 21 Oct 2024 15:55:45 -0700
Message-ID: <CAFySSZBCKUiY5DO3fz340a0dTb0zUDNKxaTYU0LAqsBD2RMwSg@mail.gmail.com>
Subject: Question about `git gc` locking files
To: Git Mailing List <git@vger.kernel.org>
Cc: Emily Shaffer <emilyshaffer@google.com>, Josh Steadmon <steadmon@google.com>, 
	Enrico Mrass <emrass@google.com>
Content-Type: text/plain; charset="UTF-8"

Recently, after upgrading to 2.47.0, we had internal reports of users
erroring out with:

fatal: cannot lock ref 'HEAD': Unable to create
'<filepath>/.git/HEAD.lock': File exists.

We believe this is due to "(98077d06) run-command: fix detaching when
running auto maintenance", since we have neither `gc.autoDetach` nor
`maintenance.autoDetach` set. When this bug was fixed, the maintenance
runs that triggered during usage of the external tool, repo[1], would
lock the HEAD file in the Android manifest repository thereby erroring
out `repo`. Additionally, long running maintenance tasks would also
cause users to frequently run into this issue when using git commands
that are written to HEAD.

We can fix this easily temporarily by pushing out config changes to
run in the foreground, however, I was under the impression that `git
gc`, whether invoked normally or through `git maintenance`, would be
able to run in parallel with other git commands and therefore not
lock. There is no mention of this in the documentation for `git gc`,
but I do see it in the `git maintenance` documentation. So should `git
gc` be locking the HEAD file in the first place? And if so, is there a
way for `git gc` to have less of a dependence on HEAD.lock?

Thanks,
Calvin

[1] https://gerrit.googlesource.com/git-repo
