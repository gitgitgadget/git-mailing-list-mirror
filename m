Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E340298987
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764052743; cv=none; b=GMBSK7TQZ6buaAZDB/yUZsEulFy8ydACAu+8Ge4YwoDW2vaIheEV323Pn+UH8SCo3sKHLuEnlHK2pCiMGJ8DrrdygB4i38Rgd5MnCAhXi3wCrWIBYp5Es4OXjBp4nf0cOuzBuRQn7tnbLlj+qrsBSnB6X0LCgNonj4zvY2ArfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764052743; c=relaxed/simple;
	bh=N3SRzrTMJrnpzNBbQ+h/6QaIZjtq8DUMDwVQ1vl2ZDY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=j2N15x1rhUKXJqVwXXaRFWD5taPq2PhHYJwBTb12twlo+VWhdLoSWACN58Ze4u+nBozNh3FuAGcTPaTugcjDy6UCF5Zfimn8U53PPJ+Fg+3oL7ar2ZcXW4dQBqgJGjrgk/CD7qChwAAN+NvxLk4/cP83hkZE0OoCMP03FEGKANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk3ca5cR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk3ca5cR"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-880570bdef8so61463236d6.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764052741; x=1764657541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v+iLUADsOXKqjIDBUviaEGHydgfw9TlynuPwhLZajsE=;
        b=nk3ca5cRZSCWS+4sDhsvP93+xcVqCnQuttBseplUIqo9NbOv9/nYC49Iy8nvEBXiYk
         //AXRUXslftShugD8t+aFlouOIP0IYxcj9CXtj0kPI/yFeqZAwJH1XGDLmnA2uCxjuCG
         p1agsWmeDUx+1t6kpKpLZcIWe1DhD6OS6mAaLOY3ET+taAgiLtS4Py6dSPOvyPnCFYqX
         VAJ2PCVvnankRwSAOFsX49OKN24YrKLt0hRUELeM4pXPmXEiOmoE9WX8dsgNJCaD6yRa
         Cf2+A9XMBP+WReRw2lyIakYxJY+TGWEZFiydA5xRmQJPP5BDFH/E3VgqXgVCbbtnFGXo
         knRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764052741; x=1764657541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+iLUADsOXKqjIDBUviaEGHydgfw9TlynuPwhLZajsE=;
        b=gFAEQhFCY0IUJ1B3EvogUkuHFiIuFQbwZfA/pewrDcptI/9nLRbbJ7e40N7NYeA3Lk
         BSRj8YjYUjYqoy6gQygVcuQV5P4z6pW4eBKIawV2sQh6wqEKhqpypS/6Jov0yd3zYpN5
         dSATEHJ9u8/CUS2cLlz8+TTagUMgkdQAkQi1LD1LRVd+K8ZzVzv6HZJLzNwQIRCP3MnF
         M2nK76T3WvQIZE1l+ORrNFOIdOwa3HO2X0gc0b6Zh49CImo981sGHZCDWrQ4u2yj43AZ
         2OxVabMIqWMVQ8PByu/AcNUUXmnpNHhnnoOuzh8H7nwUviEMx0Zm3SMEkkP7SC4w6aWA
         lJOQ==
X-Gm-Message-State: AOJu0Yzo8vaiyT86SYlH3O3DmEv8Mtrhd0qPWdvSQhc6tRz+KTyn3nRB
	a5hku09NsTMU0wwYvxp0VJK7ufVyAYlhBvLRsuHC0UhSQnO7l+RDyDfTispJw9qW
X-Gm-Gg: ASbGncu98n/CqfVU1hS7N28R1dJ05rAUYOK0LyHaDxb2RhqVxiYN16er6iG3Y73BkWr
	ckV7sKIm9IV05r8/ERZg6B8MpR2iDfp1SMTYVQlGohCf50flidnxXBNA+oqcK87S3E4kj1DCYpW
	slgHa9OBWXaFHuimGD20GLmo256ktdZf00BRwsyQcnkzxXmv478fMKU5F4xG3jdF+fGTmfsLjoc
	iY4sEGpqeHC60W2QDzBlb1KBMG1SOJwWHBKVMPI3KBGeR3Qah171ItgnMUX9ITTBdZtwlj34jLL
	lS/8+hMdBq0enF1Lr2YFjaigJPmNDvmMNpR5MQy1vDOqjIurO0wyUOiHDt/S08FiM4PJGywPBME
	1HI36JueWihVwVWWsIwGazRpD9BPNFG7YcAOlrjfnRJJt3RsGTtv1QTLrtKV6ygZEllG3PXJlnJ
	ShlLTkEatqb3k=
X-Google-Smtp-Source: AGHT+IHEzKpojCdgMQbwRmUk23WpqElBVht6gpkGCEUWErK6+xXaT2KU2k2Lu+rPPE5xfTTchWvcrA==
X-Received: by 2002:ad4:5be1:0:b0:882:489e:a7a3 with SMTP id 6a1803df08f44-8863afb10a1mr25758976d6.52.1764052740635;
        Mon, 24 Nov 2025 22:39:00 -0800 (PST)
Received: from [127.0.0.1] ([40.76.239.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e573909sm119463586d6.39.2025.11.24.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 22:38:59 -0800 (PST)
Message-Id: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
From: "Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Nov 2025 06:38:59 +0000
Subject: [PATCH] Add completion for short options
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
Cc: Wiktor Mis <mwiktor023@gmail.com>,
    Wiktor Mis <mwiktor023@gmail.com>

From: Wiktor Mis <mwiktor023@gmail.com>

Git provided completion for long options but not the short ones

Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
---
    Add completion for short options

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2100%2FWiktorro%2Fpatch-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2100/Wiktorro/patch-3-v1
Pull-Request: https://github.com/git/git/pull/2100

 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 73abea31b4..3f1d6c0955 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3916,6 +3916,16 @@ __git_main ()
 			--help
 			"
 			;;
+		-*)
+			__gitcomp "
+			-C
+			-P
+			-c
+			-h
+			-p
+			-v
+			"
+			;;
 		*)
 			if test -n "${GIT_TESTING_PORCELAIN_COMMAND_LIST-}"
 			then

base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
-- 
gitgitgadget
