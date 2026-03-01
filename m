Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C4175A6A
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383865; cv=none; b=lyAeXwWyEQ46Gkrm66uR8cO1rSQ1sJyNKQ8XxVpuGGiODIXlMqAxFmIGJOo17NTqlNYO9Q8RU8T1MVMDmSEwRBNehkbnYpWT5sMzgumEIwdcg8wmu/I0EYi9xZ/7/T0OPxoQSq+AVXlfK+9wPtDSVZsiIHjj18MFR7cHQPDoMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383865; c=relaxed/simple;
	bh=K0buFRbizqnc1HjXZgwEy6jhZZUV46lkOosRh5hAJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa2aK9OJaHr8Bf4yldVMEUX234oOZFUKRQPGdGiLtHg8Dx1KS6fPEoGRKtIX/NZ8LgVTWm7tpmMo7fVqvbCo7sokPy9KqkCOsojTo+qyz+I8aRuB+y3bJCLKSPJ/yLOVNLwBSju8AZbPnTQwrUHqYxHcSkNWlXbtME6FpAb7DvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhb8NQGU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhb8NQGU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adbfab4501so16075355ad.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 08:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772383863; x=1772988663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlAlfHxMZQueaal6rLVQmwOH7QAePtGFOBac/o5FbPA=;
        b=lhb8NQGUZICqoeVnVOJ3wP569qeq4qdo4lt6gfmuMh5AESKl2th8oVIG0xsR5oPCj1
         4HNhZ7VnJpJjxUpsu6N+1jaFUKH53/vvBuTxM3eR4y2+loI3Z98U9woFiSod+rHZ0dqw
         INyfCftR/ci8TUYbWJ2yh6tti2xihhOy+rkn+2tUelzjL82bg1Z08Xvo3u2OKX14Dk8Q
         LRvPRKQdl1U3u2o4DHNEhSWRDAHUnVynIfYD+WdwfGjLhv8Yqt0ai4F15TO23JSzPUIz
         zWjrQ+AiYkzBVsZfSb/7ZjiSXM0X5lOXsccRz4iPV/N8jJA8SsWDz6rjJPyqIpyVZ3hx
         CYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772383863; x=1772988663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlAlfHxMZQueaal6rLVQmwOH7QAePtGFOBac/o5FbPA=;
        b=MCk4Jp6NKQ9fEkXr05MjOCatxpPht5sjkI7RfXJKB3Rval3wK4kxSlTaiKvtS9oxy2
         3nwZuoKesVejCJ0EAdcq9ZsBOBmhQQQrfvojfmd9PQF8wtqNzJSRw3o5D9jDcO947Q9R
         iqv9l6smmWOWW44NkPdTfTmOculWB3GJnO9oNgul36P2eg9f/6m7bS5kB68+zL0LQ1K4
         WYQ6m3uAGsh0payCsdbLDXmoZZ5W+6jis6Sqbl2nhivNdzePPYQVnQceJC2yFvbGNRJ0
         de1H6yEbe/p6nzBK2IHI2huuehvDUpWB0qIcQgdd8bXCG02lC4lxyXliClrrHW3xpK6K
         qhlA==
X-Gm-Message-State: AOJu0YzG3ALasKHCpoYvnXrphuucnFEHdAgUkc9VRyRq7Dg0iGltNhii
	ekyTH6mK8Q4cBqLTdRBAaH6fvwTQQi2/AqXtE/bwQX66V7tpvEeHuZ07
X-Gm-Gg: ATEYQzwqBdOsILX3LiyadWBQGfbpfokgGkwHmNEk99kPJ9/0iDxtdgWaiNnU4/CYIP/
	1mY5u0c+oDS8qfMK8Np3K/Um57mYvETv0fkE2H8OiNoWc+nVwHs6i2uk5YUkdtLMjGh6u+C82F2
	y2aDF1fQ5c0zNXQh0iILiTYwAY9mBhTeGKyEmQvlc3hpUlCQEEHY+SlgzR9GQkfin63OhY9sWbB
	f1b3LcqP++CJchqAVhtja3Pg2+mAJE8JjZq5fg66u9t4by5O7EpxbEo0h75nDeLeoz3BmnBXiRE
	BTXOoUDm9UAWnPFlj8ZlxKYdnqHCs8+IRfQEkel2ieThbEpWIGRA8VVGH+KyUHIV0wfcwaDboXO
	Hr2Rk8vlQ0inkePm5VH4VkUvqn6UR+jCUnLXq4G+2neLifGNRRtKqd85UZyAOctR6+vDBLLYz8A
	WaEkNYIGEiy65WZSkBiWwnCE1hU5tuDqAFdmqew1FcMWRAVaen0+jFgiepQCxVKEOK2/Tkq97qZ
	M3teNgB/ayBkbgOeGiw0HR5X5ZVdJ31
X-Received: by 2002:a17:902:dac3:b0:2ae:450c:951e with SMTP id d9443c01a7336-2ae450c983bmr30085795ad.17.1772383863414;
        Sun, 01 Mar 2026 08:51:03 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c9f79sm123562715ad.33.2026.03.01.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:51:03 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jtobler@github.com,
	karthiknayak@gmail.com,
	lucasseikioshiro@gmail.com,
	patrick@pks.im,
	peff@peff.net
Subject: Re: [PATCH 0/2] repo info: add path.git-dir and path.common-dir
Date: Sun,  1 Mar 2026 22:20:51 +0530
Message-ID: <20260301165051.90762-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
References: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi,
>

Hey Pushkar,

> Following the earlier RFC discussion about exposing repository
> paths via `git repo info`, this series adds two new fields:
>
>   - path.git-dir
>   - path.common-dir
> > Hi,
>

Hey Pushkar,

> Following the earlier RFC discussion about exposing repository
> paths via `git repo info`, this series adds two new fields:
>
>   - path.git-dir
>   - path.common-dir
>


There are no updates to t/t1900-repo-info.sh.
Since path normalization can be quite tricky across
different OS environments, we absolutely need tests to
verify how path.git-dir and path.common-dir behave
under both --path-format=absolute and --path-format=relative.

For example
In both patches, if the path returns NULL, you return an error(...).
Have you tested how this behaves if a user runs git repo info --all

This is one I could think of...


> These mirror the information available through
> `git rev-parse --git-dir` and `git rev-parse --common-dir`,
> respectively.
>
> This series builds on the recent path-related changes to
> `git repo info` (including `path.toplevel` and the
> `--path-format` flag), which are currently under review.
>
> Both fields respect the `--path-format` semantics introduced
> there.
>

The new keys haven't been added to Documentation/git-repo.adoc.


> Pushkar Singh (2):
>   repo: add the field path.git-dir
>   repo: add the field path.common-dir
>
>  builtin/repo.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
>
> base-commit: 625c4fb2daac9879b299dd1cae2e793d2821dec0
> prerequisite-patch-id: a15d35d8ce98f550953b8d2b5766b945ae73013e
> prerequisite-patch-id: c3311a175dacc8d31ac8143f6deb36a1a46bd960
> prerequisite-patch-id: e2348c7f5cdad006aeb10ddda81a184859941c8c
> prerequisite-patch-id: 54003bdf23d570ce671626496a6622319a4ee2c8
> --
> 2.43.0

Thank you for the patch

Regards
- Jayatheerth



There are no updates to t/t1900-repo-info.sh.
Since path normalization can be quite tricky across
different OS environments, we absolutely need tests to
verify how path.git-dir and path.common-dir behave
under both --path-format=absolute and --path-format=relative.

For example
In both patches, if the path returns NULL, you return an error(...).
Have you tested how this behaves if a user runs git repo info --all

This is one I could think of...


> These mirror the information available through
> `git rev-parse --git-dir` and `git rev-parse --common-dir`,
> respectively.
>
> This series builds on the recent path-related changes to
> `git repo info` (including `path.toplevel` and the
> `--path-format` flag), which are currently under review.
>
> Both fields respect the `--path-format` semantics introduced
> there.
>

The new keys haven't been added to Documentation/git-repo.adoc.


> Pushkar Singh (2):
>   repo: add the field path.git-dir
>   repo: add the field path.common-dir
>
>  builtin/repo.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
>
> base-commit: 625c4fb2daac9879b299dd1cae2e793d2821dec0
> prerequisite-patch-id: a15d35d8ce98f550953b8d2b5766b945ae73013e
> prerequisite-patch-id: c3311a175dacc8d31ac8143f6deb36a1a46bd960
> prerequisite-patch-id: e2348c7f5cdad006aeb10ddda81a184859941c8c
> prerequisite-patch-id: 54003bdf23d570ce671626496a6622319a4ee2c8
> --
> 2.43.0

Thank you for the patch

Regards
- Jayatheerth
