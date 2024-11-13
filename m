Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C018EB1
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459137; cv=none; b=kyUp9CZS4mL5GDOhtL5x55yqlKQSsvn0bliFUnB8/LJzt5paRgBph2fs1+JMwZ8lV5S0k3n5KYLgBX+Wal0HAokqnoaAjVxdpTS6kBYOM6gSvsxEsi6q/Ayr42yFimIQ6C2yo72juJiHWHigSBfxO/QpVn9XWSUYc/PG7/PEV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459137; c=relaxed/simple;
	bh=ijrTHIViB3dWfhYnEmnI/vwiQSXewrBSDxjW35MGlAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VXIknGr4RBVe6Z7AkDyAjAkW2IghKjOJZT5PGMjHrUKrWoRc59UKY1pvBouoGBDnY4/zMgqD11KwZxndlXWKdoHn+s26e7ZqP9jSSqWEcJoskRjdJtOOy4QQo9M0Aq3KJacD91l6YfuVyHDC8eDY7k9wBTX4MI5aHU9PPSNyd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjWmNRQF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjWmNRQF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eac969aso1028805e9.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459134; x=1732063934; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEwqcrVrJph7lJ7laTaMdKMBUJScDztfebfQ58iEJ6c=;
        b=YjWmNRQF+rWGxYtZuJuIkW13886NucwgMuumLf6q52AU2r01iAHsvyxsZTXaJfRdJR
         N3u64jKRyWrkP9JlNA/t3Q8v+Af856GZNh6FRvcDoGo/DF6TkZ+rARwk4ksIkhYV5tuF
         53xgoG4xOom5ANUrhGT3MTKUhXZYMA1g7fUm2eSdFGv0nvlkWY6Fma3MmhzKB+tlWwvE
         y+h48FdMnfq7lDmYfLLVmwiUGahSyAMTvGmfs9kFBIPiHlCtV7XHAwR7f6ug7Pqnius6
         x8kb+pMSO53mjGCDsOBdXBxGfm8bvOw27OU133BjjlYz9t6xvJ2WObLJcjouOg1dy2B8
         YtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459134; x=1732063934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEwqcrVrJph7lJ7laTaMdKMBUJScDztfebfQ58iEJ6c=;
        b=Kg8WfgDDwrzhS4F82e8DPASYokdVphSGLY7KkbljTRyNrSe0kK+n7wn/N/TTcx9pSH
         QWxXFAlw62sz6JlzC2gcqLfihGHGRQFK9QSR/65P2XQlTPwXHPLKUKEOZ/2vuPHNSgsn
         h8z8uh5h8mccxW71vgyaS43e95k4RAEn3I10I1Vkbkjl1r5ZBmi/JUXHhySS1McYEXGV
         t+tp1A6Ske8xfc6OY5iYfWcCO4RnP2W2dHLpduLyUDasUGmAeRw2aERMv3/K68UrOuli
         AgNO+QQ3GTmM/Z12nNI4ojZcfSNPsqjDptjNyP93hI3SomO69Go1XPx1Bu+G4pvTWZvi
         bBGw==
X-Gm-Message-State: AOJu0Yzs3NYR5zJCtOcI7eomD1mZg1+NsWB49GC7k7aFHY8FKWmTzNdF
	rxlFceyw3BxU5XfZgtMW6/eJZiUhVZwzWE51hYWmBvUUy5O9et1O8r3esw==
X-Google-Smtp-Source: AGHT+IEItzHt7HZcsdUQW17NnmtxaOm/N1GVNCY9OTgx6vXQoFGXh38wkOxI+xh7T3rITa9PgpxmBw==
X-Received: by 2002:a05:600c:3115:b0:432:7c30:abf3 with SMTP id 5b1f17b1804b1-432b685c2d7mr164296725e9.7.1731459133654;
        Tue, 12 Nov 2024 16:52:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d550c14esm4729555e9.28.2024.11.12.16.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:52:13 -0800 (PST)
Message-Id: <74b83caa1e5c1a63248dd4dcbaf2cf450f9cf32d.1731459128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 00:52:07 +0000
Subject: [PATCH 4/5] git-mergetool--lib.sh: add error message for unknown tool
 variant
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In setup_tool, we check if the given tool is a known variant of a tool,
and quietly return with an error if not. This leads to the following
invocation quietly failing:

	git mergetool --tool=vimdiff4

Add an error message before returning in this case.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-mergetool--lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f4786afc63f..9a00fabba27 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -263,6 +263,7 @@ setup_tool () {
 
 	if ! list_tool_variants | grep -q "^$tool$"
 	then
+		echo "error: unknown ${tool%[0-9]} variant '$tool'" >&2
 		return 1
 	fi
 
-- 
gitgitgadget

