Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690F26E64C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895884; cv=none; b=YubHN9nKiG5tnjkXbuz4CXNm7moAOd8Ydg1GuQvJWGC0PDJeTOYADMPEi7kr9NNgLq+e3sna2MkNJz4mH3LV9zainyT1ZRv7OKoOjQiepxcZ9qqwhNVtkF4rtT83i0iB9YZFRNezqbQB1wbr5ayJ00AEXDejfGCtjsK/hODSHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895884; c=relaxed/simple;
	bh=FN1sCKmonjZsG4xhDaIrvnEvdEHeZMGap1MYUuMmyHI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=UuLNPQ4HWW+0tKFBpUhxwxhO5v8BhEM81SO6DbuDAP62g1YNNuBsmSseBdYDWgovh2cUX8c6QGkgMMDBLOsGv2ktIifMVwBkrtY1lxop2Zgb1qsvI5namRCKlB3Ypgi+VQQrE6Zt0lM3axjhYyDfnUBJaQXgtOKM+YuZFzHMQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0gBAKXg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0gBAKXg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2c4382d1so2546055f8f.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895881; x=1740500681; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1eFk4EDWrKSafhgThuIKmAZX49/0HbRt7kwmTE2luI=;
        b=b0gBAKXgq+sMHVcpWhF2YLdAXH46aBuo1LtV2+ShxrE5XKH6P5xrQDzrZZh/42H7aw
         +3OZr647WoaHVR4Qrwh0xGeFUTQaqcAOZ1I+sGyPfGDf8/4VGUmHCQjug5boTbU1yqfY
         32/NpSMzug/OjaGbKZL3k31B8EJUS3y6BhYUPvG3jUW6/zkt6fAthFUh9HmAnGAY6kyc
         KA4PlZHS3e3Xt31C3KTojg5Fz0QL1b9m/kSitfvggI2h/MktuYhYQNQOMTMQ3ELMGPQ+
         fzi6EePPfFFZmqZKZ2U7Sx9Kjiw7d83YiqBGUUnqXcQLIuFuw73F4YCUCAE48Cd+v73l
         Ui4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895881; x=1740500681;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1eFk4EDWrKSafhgThuIKmAZX49/0HbRt7kwmTE2luI=;
        b=C62DWUXnRmFBJ4xlqFallwSOMrnPpnQBl+yb0zCVWTeaI6jqoSNZcAn6+RL8pn3lx8
         0hNZJ+2BtIsKvZShmhos4zo+mFCDjw4j+mHYtu+R65yL0pw803h2Ox9V4DudRqbwQo7+
         XAC3q9Kv+YyaObgWaNJm3FvPjDtoWaH/eWZT2RE2thl7jwQ4ecaAETpgJuYuveV4kqRX
         QytbEem7OptJiC4PTm9qD4H/GbS4mE+2g/NdjEekgVtPuYBKzRMJT8dT4LUdbjKfXYlf
         b7qI2XUyomuyx5trjlaNhxeuenTzcAl+qnug249m6XE+W7nEoXiYKtm9vTdPXc7xKWzd
         JtoQ==
X-Gm-Message-State: AOJu0Yzd7lmAjsIU0vlT8p89JEKl+/iQv0R5XqXw9cDRdM0FieQq2j4s
	LUDnqmCqye4/HH2A18ekIBpJTwfIFXUzGLKFP2V3OAzU1HDItmc12ei4TQ==
X-Gm-Gg: ASbGncuTQM31S1hhEpB0BetcP17in+REVIKk3K0gAklFdxpyw2MGbFlohHUz8RVpwy0
	0nPMBRNv8IqhP1XdZn/sjbUi4u7P02q1+jmja04GnkPF0+iRE4BKttApvDdCaijogZRBbToXMT6
	53GF072Yv4C7cvACjY+Z69vEr0/X+Xj3dydjpiiYJqVT2bhUTaRTjgUjVFn47ReCr94PwPRylV/
	ivhTakAPQxYZ6GVOKSSYlgDkHXXtMV6Rka5nSpr3N105T2e84hTGcrHqWMrVJMVnFOxFfJtO3e1
	RldDahh8OVrpo751
X-Google-Smtp-Source: AGHT+IFHtOBPGmV0EV1/QlBOsZk4GCAJLDaIwx80XG21cPRQsLvxMb3fEbQhg70ogUwWCvDAJYIoYA==
X-Received: by 2002:a05:6000:1f84:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-38f57bce501mr349321f8f.4.1739895880638;
        Tue, 18 Feb 2025 08:24:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398ba53406sm45305315e9.14.2025.02.18.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:24:40 -0800 (PST)
Message-Id: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 16:24:34 +0000
Subject: [PATCH v2 0/5] merge-tree --stdin: flush stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Elijah for his comments on V1. I've updated the commit message of
patch 2 as he suggested. The rest of the patches are unchanged.

V1 Cover Letter:

I tried to squash some fixup commits with "git merge-tree --stdin" and found
that my script deadlocked because the output of "git merge-tree" is not
flushed after each merge. The first patch fixes that and the rest are
cleanups I noticed while reading the code and documentation. This series is
based on maint.

Phillip Wood (5):
  merge-tree --stdin: flush stdout to avoid deadlock
  merge-tree: remove redundant code
  merge-tree: only use basic merge config
  merge-tree: improve docs for --stdin
  merge-tree: fix link formatting in html docs

 Documentation/git-merge-tree.txt | 11 ++++++++---
 builtin/merge-tree.c             | 11 +++++------
 2 files changed, 13 insertions(+), 9 deletions(-)


base-commit: f93ff170b93a1782659637824b25923245ac9dd1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1862%2Fphillipwood%2Fmerge-tree-flush-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1862/phillipwood/merge-tree-flush-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1862

Range-diff vs v1:

 1:  3b317978509 = 1:  3b317978509 merge-tree --stdin: flush stdout to avoid deadlock
 2:  16fec87766f ! 2:  63b09dbe1b7 merge-tree: remove redundant code
     @@ Commit message
      
          real_merge() only ever returns "0" or "1" as it dies if the merge status
          is less than zero. Therefore the check for "result < 0" is redundant and
     -    the result variable is not needed.
     +    the result variable is not needed. The return value of real_merge() is
     +    ignored because exit status of "git merge-tree --stdin" is "0" for both
     +    successful and conflicted merges (the status of each merge is written to
     +    stdout). The return type of real_merge() is not changed as it is used
     +    for the program's exit status when "--stdin" is not given.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 3:  bf1dc603a15 = 3:  f95a15a4203 merge-tree: only use basic merge config
 4:  4c416850634 = 4:  1645b0e747e merge-tree: improve docs for --stdin
 5:  89722894c87 = 5:  a0179820092 merge-tree: fix link formatting in html docs

-- 
gitgitgadget
