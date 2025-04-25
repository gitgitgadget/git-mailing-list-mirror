Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CC25E446
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593523; cv=none; b=YoNAS3EwVEeNSvU+r3h/ctmMA5nY6dnyjCdP8ynLqLUV1Ly2Rc4L4R7ByUd4gpgs39lAsa3aeavXqZZDYc436pheLs02E07m+S3yNPUbt4NOC/QLkLu3CcOr1DEhfTNloZ5ZDzOhQTPJHY+K4lxMP/JMpmME8riKgMHFivYL9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593523; c=relaxed/simple;
	bh=eimRLCw9maLe63hJX41k3q4ALEw4kfNOWstac1TkNG4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HtwtBKQFmSqZvs5UP3FVH6LN8GFVpAL3zNSEKCkAgWFyf0k8N5eXBrgALUvX6iTd6ZdX0SxswWZNqenwI6/3gBCiAO15j6S52jLI+I3psujSw4PCRoHGRnKTNzEgzzw+hVFwuMOCt9nzJs4z7BlMUH4vpoD7WuMCp4zrXaWsIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOq7GIvw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOq7GIvw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf848528aso16647255e9.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745593519; x=1746198319; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2rIyzWRPqaI/QldH3XVG05dPLRCDWvN5MB6/72/wQLk=;
        b=dOq7GIvwASq3x8eglpkrcGeSvlAZgocymBvirwHXEMEkT4+p1ePkIYOyqV+W1URwiZ
         L7PxkTwKcMiM9jgMpmALWZ9BjHfffu9ubQ5BgGEYhT3JeWw/YYQZ6uh44vTrVBCHnxBo
         a6QKolOPxyPGdeV7AVC3vB5Can5gHVKIZGY01+dJnFMjuWErDvYIJSlhenDylad21McF
         pxurJ1X0dZD2abxuqIDnzOHQ4l8HJakuWPajfal6uUKjB1zqcw3hNji2wLv5gW4jGvtn
         XZITdEInsOettkZsCMNf1FCJwsAIWdQtfQLSKjX3F258+DL++Jn3C3iGe54lTVwvv3Te
         MQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745593519; x=1746198319;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rIyzWRPqaI/QldH3XVG05dPLRCDWvN5MB6/72/wQLk=;
        b=HZUERjprn5wVuPFELUW02VvfWnxo6YyggPydRLxPFroxY2Jbi6GtGwJs9TnV/1MypD
         VRkFLPsJwUPrRnBvPjCw/2ePZj9G6SOWx+T6I8vRGUr4S4g0zRSMF1Eh+h3/78vZqLvj
         yo0BSJ/Zj4t9Md69t1fcP81wk1vqsOgFZHRPe4DiBF5L32XcTUkT4MGNyHcfz5qaTLIP
         tVBIIHYX/dIfWik4rC7r5qIFmqgpFf5lXdVEHbxQ6I+eRze7SAFmLb8vk3E544Q5sv09
         tLaaTv1a9YSfMlv+UurDpU/O5ctuyypgZ9pmqTJ80oVTAY/uFqFEqFkIRjksZwBCb3MF
         GZUg==
X-Gm-Message-State: AOJu0Yzdv1DraWLmUO/iTsJnOT+ei0ElpJHFqaHDd6Hg6HyYEcYNC0rq
	nZ9jBiYsn0V01W1SQvSd9Di3Kr6nmcnj8GgatXorp+F3fEnMlpyT/IOdiQ==
X-Gm-Gg: ASbGncuHjjsCvSJhJIIYeEAfQlvBw7GR42gQpBtGpWafKvoJ4Yl7iD0p7hmydLdmi20
	2NcF33KACmYIMEwjivjLJQdFIrtgY4FeZCKHl1koA90rfUVRqsrN3hCj3pAz7T3Z9Yxn1w44Kk6
	w381YGd2cgdSUEYbDDl6Y1U/wRYydQ9Kk8juhd6ZteE4EA60ZpbPqjSuB1dNRUuQm13YUSQwm23
	uNCTvxc8KS7biDIRt1/psQEJvL29ur1uEaNBcu1mVvb5M6nzQ8IvzXWSFYZdC+ffXmIWrv9RJwo
	5wnB+QJy1hj9nzwwH9txdUl1mHq1T+Qma3X7SmImJ+3B40Op5mj4
X-Google-Smtp-Source: AGHT+IGke0vhUuzOyJDjhnmNE/jqM7joglCNAK+KuR/iF7Itev4asV72a72qF92/hXR7tfjt7P4F4g==
X-Received: by 2002:a05:600c:3d87:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-440aa428c9cmr6839975e9.19.1745593517002;
        Fri, 25 Apr 2025 08:05:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310a1csm27539675e9.20.2025.04.25.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:05:16 -0700 (PDT)
Message-Id: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 15:05:15 +0000
Subject: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since switching to `--vsenv`, the t7001-mv test consistently times out
after six hours in the CI builds on GitHub. This kind of waste is
inconsistent with my values.

The reason for this timeout is the test case 'nonsense mv triggers
assertion failure and partially updated index' in t7001-mv (which is
not even a regression test, but instead merely demonstrates a bug that
someone thought someone else should fix at some time). As the name
suggests, it triggers an assertion. The problem with this is that an
assertion on Windows, at least when run in Debug mode, will open a modal
dialog that patiently awaits some buttons to be clicked. Which never
happens in automated builds.

The solution is straight-forward: Just like the `win+VS` job already did
in forever, build in Release mode (where that modal assertion dialog is
never shown).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
    
    I was surprised to find this issue today, and that this had not been
    addressed yet.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1908%2Fdscho%2Fdont-let-win%2BMeson-hang-in-t7001-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1908/dscho/dont-let-win+Meson-hang-in-t7001-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1908

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 83ca8e4182b..275240be5dc 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,7 @@ jobs:
       run: pip install meson ninja
     - name: Setup
       shell: pwsh
-      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
+      run: meson setup build --vsenv -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
     - name: Compile
       shell: pwsh
       run: meson compile -C build

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget
