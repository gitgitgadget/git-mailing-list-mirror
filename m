Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43E301007
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232867; cv=none; b=YDj80VGTo7yWMzFkNgnAiXDGLDreVxtoqEgyajFkX5eT6OegXBLKZfmJIJJl75BXh5DS6KyyTsmZ317FcwfjJPDiD0s+leiP1pxrOzkKhsToFHpt4FeMTCWmlu/uS14LLVwzXhB6TbnlK76e9Ok0oIamYIUU36Bc8eUfqCAejLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232867; c=relaxed/simple;
	bh=e8Urgt5lFVUcsikXQuW/xZES43Xz6Qr64AcovVbCoTY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gTxvxyiG3BUOXO05d8X18HgowM+feGh5Y6RvAEW0BuUQRWuCCB9kx/KObBgOcVtY1+IfuNbcZz7AbyJStqJo9Im/QOt8LQxoDnBXP07nPXfVMVPZXjq/0deMwF1xtfPqMbI+Ln7jvGsm1g9kp0kngkkhzdzlvaMtZb6xR2WL4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkb3jXBl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkb3jXBl"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9387df58cso4031383b3a.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763232865; x=1763837665; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GBz6zt5Mb2o65VQcQ4EMhpBJnfQNXHTCt53Gsc5AfLU=;
        b=bkb3jXBlgcVOgzym28h+DIviai127LKaXKhNTZe+EY8bHj/JC0gtQpQMyRoGuksMfX
         ThQ9Tno17YKtCEY4tsZAaBSZd9Bm+TfFyT8V8PNbGZDUtIWIsnG8lrePhX1mgzHFAG8x
         ICqsDaQBa3hfYrwcMIrYuq1hFDXNZqz2I5LGf+DFHPAAGNh80SWkiOXKAV4GPcTN2+XR
         PYmjlfKIyVsN/iyTHlFrWZNswGxXBA8hfepte1d2s6obMI3kmxTpdcfQTs0Xd+hZvOgc
         rbNphP0bSc+udkdTICIjUomUhfP68UNhuL5lhR84wb6BjIRXQfBE/sgQfYsbJ6vllaaH
         n/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763232865; x=1763837665;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBz6zt5Mb2o65VQcQ4EMhpBJnfQNXHTCt53Gsc5AfLU=;
        b=HJYAifVU0czXl+M6Bz+Bmpd1JyEqFhW5XSNQFlKtsILJYKFDQR04+f94HYB4pc+Emy
         pQpDG6fc/PvVEScrZSd/jT/OQuTpvcdemC7F/Y4axFDlYKNSTTTYchO3jN1cFcgx1lb1
         dPldNkfgdbsyp2elxP7Bb9QhViFfm6gN7E7sluHuNt37xL1Z3E9Bwtctpd0Ki9yZw3dI
         oow8F0HQLnvGIsNf7bZKm/CHkR7omD5YjVxQ69jpeCM6jmTGte5g/FyI8bFjed9ThXpZ
         0xqYP+y3bqdSm2ArgnVaztKXrmtefzjgUoKKZsXZqvNLsnVy13BaFgKIusFpiUSfUQbA
         1aug==
X-Gm-Message-State: AOJu0YzK/ceiAXnOeoGmN4ppnSiTVz4BstQBNGLZ5vCELg0CvkQ+gkLc
	u+1+ij7nDZv/jrz1hb2cp+FPNXWSL/Iw2VLPueEVohFeM6dh5ovQr36J9xKhEA==
X-Gm-Gg: ASbGncu9w2oidUkWsRozep8X3QCnFn6zVUBWDLJifu+I26/jEM95z1KmOIMHiFbCNTI
	qBlTZvnVviY+HgravJvTBGPkISZmyWcc1BmC4JTVYLNhe07YPbkUxm+ysEQml4j5vjys3iCIZYH
	g0rzEfdiztwi2palX2iqWwmXsaJiaJ8wCsth4RFxTwwSXc0rBIP+C8VPExXIa5fl4EwPIIfZS7y
	aW2lF4NpKa0oDI3TH9fdha8ZSP3RsxyMPS7qy/8lqJWdIyBP+YjTuNi5jmqOpnK5Xmp95a4MxQ+
	Rkz191DQqg/AHRTWJRMn3h9UG9IebYl+9lelD9/3wQjqp1OOWCR9Gv+kHrzBMN4bAAPOlqOgU9j
	LmbGBpoIukGoe+OuDQ1iPmG6GM5NQXa7oDPqDsgGWK4tKg7Mc/fnEM4mMdEgcPKMibXNEJz5wC/
	jMDw==
X-Google-Smtp-Source: AGHT+IHj1izKmRB60xaN1HeTEU+5C+180k6A/Ogb95OgbSd/Cn7L9BF7hZ2u5FLsGnsl2tF51MtajQ==
X-Received: by 2002:a05:701b:2914:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-11bc1abbf96mr305798c88.38.1763232864670;
        Sat, 15 Nov 2025 10:54:24 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885d8sm24188661c88.2.2025.11.15.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 10:54:24 -0800 (PST)
Message-Id: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
From: "Kiril Ivanov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 18:54:20 +0000
Subject: [PATCH 0/3] git-prompt: add quiet upstream indicator option
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
Cc: Kiril Ivanov <ivanovkirilg@gmail.com>

This patch series allows a cleaner git-prompt when the upstream indicator is
not actionable.

In particular, the '=' to the upstream can be redundant noise if the user is
always on a remote-tracking branch and only needs to be aware of any
divergence.

Since SHOWUPSTREAM already supports various options, I propose a new 'quiet'
option to limit it to actionable output (omit '=')

 * Default: branch =
 * Verbose: branch|u=
 * Verbose name: branch|u= remote/branch
 * Quiet: branch
 * Verbose quiet: branch|u
 * Verbose quiet name: branch|u remote/branch

Ahead/behind output is unaffected (default <> or verbose +N-M).

Kiril Ivanov (3):
  t9903: shorten setup using test_commit
  t9903: add upstream indicator tests
  git-prompt: add quiet upstream indicator option

 contrib/completion/git-prompt.sh | 14 ++++--
 t/t9903-bash-prompt.sh           | 86 ++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 20 deletions(-)


base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2101%2Fivanovkirilg%2Fquiet-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2101/ivanovkirilg/quiet-option-v1
Pull-Request: https://github.com/git/git/pull/2101
-- 
gitgitgadget
