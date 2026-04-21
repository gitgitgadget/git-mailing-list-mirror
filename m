Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9C2DC76A
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775325; cv=none; b=des6rTzUIlDNKMM/fQ1RJYTy414D1xxGoozCYLy28Xh8J8+Vu2klnN6GunsMWyNjSnLmIWBRCUUUrQfOyyplefzoEk52O5FwsXZqjOgUMVOqEVjBaGo0o/iS/VuLC9+clFIzJn4TqDxgSAegllRzMHkl7PqpNmM4uoMioGT7PHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775325; c=relaxed/simple;
	bh=VU0fe/OjTzFpZdAbxzw9r4994LVu7rhwnCUEbImr844=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GXlCbgcdk/pxJNYDA7U/3jA2xemQac/tz4+i5IlT783s5i+Y7deQ9Kc72OIdIvcIoDU4xsTfTv8WyT2LgxWzm5e2+9WsNsF6nIfNa1jhWhWl6yyXPuTbgbMbegXYcZP/1pXdRP6sPfZYFMfGOqdcbcswmX4JnSzL5nvCyLjalZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlwhG7vc; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlwhG7vc"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d868d014a5so3981952eec.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775322; x=1777380122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jknLOp/3DfZNZxwjmB+MK1bd5XnCL4FY3WU/a7ma/7k=;
        b=YlwhG7vc7GCC2TlyY0Fw6YEhgkSilb9Iwleirrzcxk2RY9XC8m/7T7fPpw7Ws2DKhT
         3zU0DNt6x/b1z56qfH148a5PhUFf2s1Jf6/R1N5oQPhDfnn9h/uX2rOZZ9TfctTAeD5D
         eNzR+jQJTMUkjnjzs+foiDdtldmPLZVqErS14i9iqDTk68q4QMUFOCCF7JlgGdkWRtub
         tb0F1fTLw5lrngY+A0LPGFpjpFx454Vlpohc7YH62NnWrxzUUzCSE518mhD+83aWlYc8
         DYFT9FerAUevI0fUapfwPzt7XdgZwvmYUqnJjDykm2j5X6xrGVZBILwR1BwVP3wc1VVV
         0yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775322; x=1777380122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jknLOp/3DfZNZxwjmB+MK1bd5XnCL4FY3WU/a7ma/7k=;
        b=P/QW4bOwYbPrJJPV1uoh71uqEHCKfP9N8SZyV23Nkwfy/HLl4/DO7Dk5r20aC1dTFg
         VeF/lvzkecThVCSUf4DPjxMD+fK2wS9fQtmC4vj51sWjZhrlzgy3mY1uDKG1TVdqZhdQ
         IBLbmZxUv+YTERpK7reSaQY6Ivbjv88mqHhO1efUY3KH0Xx+lwktSqB+pLmFJqrNVTAF
         WgHMpYm8yy9jGxaIMH8FCRyFIvqk8KZ+dw7QIkDDDy0Jo5YYt8O67ZjnlOun6lyjI1jE
         rReyESLzkK9DxRMQXeoCZYLL+AyVIweWSnfHMtswsoXCI2Tsl1mWWiskf7hezr+5i0yd
         LiJQ==
X-Gm-Message-State: AOJu0Ywp3DZ9J75Y4AjkyFJyMQH1R/+VkBKFSHcJZ1MXyroAmOsZh8nN
	bp30muIA7wMY8PJEVIA2VgQfCZ/7IUeZPaiQbMoeLkUlqBbW+RVNIJNFJlPNpQ==
X-Gm-Gg: AeBDiesUtr5UaB60t3Ds5VbY0GPf3hGGrZ10lqGOyxqWJFKy9risVrPEF+2gGVMQLEU
	C08rTd7x2R+ts6TS6J98MBKjWS4tRFnibVHjOzo37e/usIoBK6TNF5HUwH9ZfONlILBHz9kxBEg
	4ZeQ5EJUse4umEdtorItHPuSjUdTtyA3Eig6FpSWD7oq5EiD9O59ACCPNqNYG2un2JC6a3LMMpc
	8aR7xLsdbhNjbGisL6tctgIJ7Am6+CFsEHKLFoYRN+UKxeMnt9dDkKnml0mpvIC1FbGUrJgppvH
	0v1vLqT1VvztOORd6YMt4Sbg1+YYfjTzPnOy2sihT7TyX/3jhtdLEIMMkvxxDiI1Ovbm9ESbmjQ
	kwyaa4oq0B1cKkDb1fjwJZZEIK+HWukAAYEVjB7GvEmhPQ3Qryxrg0Y+LfHIkdfmNaLRC9Z8nvr
	dnbGyMFyxwg2lokRS2SPOWqx3urLU6wry8/9U=
X-Received: by 2002:a05:7301:4586:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2e47873a866mr10100376eec.13.1776775322257;
        Tue, 21 Apr 2026 05:42:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.55.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm15837750eec.30.2026.04.21.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:42:00 -0700 (PDT)
Message-Id: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 12:41:55 +0000
Subject: [PATCH 0/4] ci: GitHub Actions updates (brought to you by Dependabot)
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Dependabot (which my voice-typing software frequently mis-translates to "the
panda bot" 😉) is enabled in Git for Windows' fork of the git/git repository
to lighten the maintenance burden a little bit. Frequently, the updates are
not actually for Git for Windows' patches on top of git/git, but apply
directly to git/git.

Here is the latest batch of those updates, with heavily augmented commit
messages.

Johannes Schindelin (4):
  ci: bump microsoft/setup-msbuild from v2 to v3
  ci: bump actions/{upload,download}-artifact to v7 and v8
  ci: bump actions/github-script from v8 to v9
  ci: bump actions/checkout from v5 to v6

 .github/workflows/check-style.yml      |  2 +-
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/main.yml             | 50 +++++++++++++-------------
 4 files changed, 28 insertions(+), 28 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2097%2Fdscho%2Fdependabot-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2097/dscho/dependabot-updates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2097
-- 
gitgitgadget
