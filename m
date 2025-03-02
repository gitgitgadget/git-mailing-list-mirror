Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A398158DD8
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740901530; cv=none; b=E+r4spwXhKDC4JpuHtP1VxBGgWVbXHNb9/xnWDmMwxT0OdQQrbDdMaZM7nNV14wYe6tNndIZU0D1b3ZmgLY6QyiAiILxLwwVfs+QBltlE4/hC0+39i3hYW8SsGIlgISShetuJJ29s7RZ5ZwUoMUjrHdLboMdncYSmqX3JzQGoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740901530; c=relaxed/simple;
	bh=y7MeA+bWdXDK+cLCoFTbAOSzUtlDE9215XGvMGxu3AQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XNI0occvdFXjJTUldYJ8UzZg45asL7k52nZnC9n0nfc6KWuQ+AunkaD+8gmHHtkcl/iF/CuBFSXJnD/hnmwftfsH08snxFEpXBFckAcbYcaoSQGVBmsNy9yfOtL8eseHMXJcZ9XcjLukj4eWyqXWQctJWwnqyJ/v9Ffq0tpo6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1vVYnM3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1vVYnM3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso21258595e9.3
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740901527; x=1741506327; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aerWOLqmebk+3q9cNJNUJI76aXd9pFip/zVUgHn9WIo=;
        b=I1vVYnM3eOtomnZHOvqlsXOmArdXALPua7hoFL1y9KmjjTAk7q4vR+cdSR+8LjelMP
         KjXbmzYY0tyhTjxUC+tBk4QOqsZcVjLFMFS8yqrF23V+QAl2TRjGeRY0qDrR1PDo1DFO
         faEU9T7dcMInI1KbyWfoB6OyeruBq0FFLIvk2J+3aQMP5rIpLvAZcTv4r316u5YFCy8t
         0uaODYQXK+PnCCoz9Ksg+D8VTHykCyKOH5iua6Q8Pp9m3FB7py4fmTqq5GcTkGCDnaoP
         86IWKyDtQ7O6tbtMQRfCE96FekeRGY9MfyTnG/Rti1wXnlzpIO5dF/juCTdhx27ZG3hk
         T21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740901527; x=1741506327;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aerWOLqmebk+3q9cNJNUJI76aXd9pFip/zVUgHn9WIo=;
        b=GHpDzrqQUWxP9ZhjvUFBAvi7S8lNhf+gm4CRoHkPzaV1BIs6oOOTcC57MyuTMVl2dO
         aUA3vDZMpIRc4sywB4mW3xJQGVflA4rbW8HnFz2L5qwquqc6Fe3d8usae+LbmKpqdXKI
         qQcn9tK4m68zwvZiMa9Ux/5ASN78YZI/vE4e/uDbXdsc3Y1ZF/g09U4mQzK8GkZN2rbr
         SWF/uYM9DLk8yHM0/w8EKaVtjzTcvPxEgGSNrkVOYlp0lu4gGm6eUem5XZntkFVbe7Ou
         HTpaLeytRzsu3WpaBhJ0A2DMywPWYeAaj7kCA89c9o0KbQaf+HxAi0Bjd/p2HOJ3ynaY
         Y0sA==
X-Gm-Message-State: AOJu0YxlEqNHIrWOjLqoEIVMMFZ1QpCnqeJTgMNACSA1Dpb+ix30nOmt
	tvp2ArPwhwnEpq3/amYoTcAn+uyOtVGWJQ9yYPQqDt470oLNZ2j9mpBVYg==
X-Gm-Gg: ASbGncs57iALeAoJUpc8TjivxwFdAKiBQMk84/Mi0uoRKmTopFuzfHXPpnJ974XNibF
	NuqmbL5BB+6yd5S3ZMep6QZgAREOCwvXF+6SilVtJLA/wJXAZL7ckcDeWERhR2vH1UHSz3XlhHs
	I8r7lM5dWEfkrz0cfWtjpOWtrN313046t2JRUCwuaEsHtNY1vwyO9kOCy1LAtfek5G6cuKhnG1X
	tBnRMYJ0E2xj6PTGZLJHNIHjR9dOZuHCgCjFShIiiWqb7I4OAjTh0HK8hns7B0f14pIsfpJy/zz
	pieqGeCKgTKuukMh9f7crjCnPXvNOyabg0EgftNa2V9/EA==
X-Google-Smtp-Source: AGHT+IHHvDo1gitQRSN7+aLTr26FG9POOHQx0BcO8aE3U1brkRezeKXYDnrGe45DnUVjkjtUxlrHKw==
X-Received: by 2002:a05:600c:3505:b0:439:8cbf:3e26 with SMTP id 5b1f17b1804b1-43ba66d5659mr71408445e9.4.1740901526647;
        Sat, 01 Mar 2025 23:45:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c4051bsm130627035e9.0.2025.03.01.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 23:45:26 -0800 (PST)
Message-Id: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
From: "David Mandelberg via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Mar 2025 07:45:22 +0000
Subject: [PATCH 0/3] completion: fix bugs with slashes in remote names
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    David Mandelberg <david@mandelberg.org>

Previously, some calls to for-each-ref passed fixed numbers of path
components to strip from refs, assuming that remote names had no slashes in
them. This made completions like:

git push github/dseomn :com

Result in:

git push github/dseomn :dseomn/completion-remote-slash

With this patch, it instead results in:

git push github/dseomn :completion-remote-slash

In addition, the change to __git_dwim_remote_heads() restricts it to only
list remote branches, not HEAD. I think that actually improves the
completion where it's used though, since HEAD doesn't seem to be valid
anyway:

$ git switch HEAD fatal: a branch is expected, got 'HEAD'

David Mandelberg (3):
  completion: add helper to escape strings for fnmatch
  completion: add helper to count path components
  completion: fix bugs with slashes in remote names

 contrib/completion/git-completion.bash |  40 ++++-
 t/t9902-completion.sh                  | 213 ++++++++++++++++++++++---
 2 files changed, 225 insertions(+), 28 deletions(-)


base-commit: cb0ae672aeabefca9704477ea8018ac94f523970
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1901%2Fdseomn%2Fcompletion-remote-slash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1901/dseomn/completion-remote-slash-v1
Pull-Request: https://github.com/git/git/pull/1901
-- 
gitgitgadget
