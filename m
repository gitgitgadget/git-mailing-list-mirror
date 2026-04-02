Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C53E95A4
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140429; cv=none; b=HK60/dYlPWT2z9JOnnt/hP05HmfuDbUd1+02po8cU0TAGd55dOQflLAbsNGhijddLUR+oru5fn3bsfdSJ2BErHc7cUxQXm5rz8delAy+ts9w+6OYZEJqJ3bL7JDqJUzSUe7k8GM2PuXmgBAOOy81NqDB8mr+ysvrHQ/Cy0qSb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140429; c=relaxed/simple;
	bh=W1avFsUnPl1HUEJzqPmKoMwR1scWadgIStJE1XgbKxQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bDRDxmiOKTmSf+HKB26pH3Br7c/s3J31yRgu28pQKC9BOs8aN1JCjEKvPrXiw7py75xEwjdg87uro7Z2Th8HpjSjJVtqhM/ur55wJKVEv6SHn4BDw+Mom4U6XLc75F89YL/yDeqp4eganKVJEAzjcaCRivJ0cpWMErIDFzTKGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5HCbQn5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5HCbQn5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd8576a512so229579685a.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140427; x=1775745227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So2vIHOG8Zm+vmmprAGxBjFa98UpZPTRWBgQqP4gM38=;
        b=C5HCbQn5vdgxtodgm05eM54fW6fQ8AxM+1cVtVXjfYr6JssaxaZGyouDusbjffpM4w
         KE8PpPUSutYQqesGGh6/65mHJCS7U40vKOMjmpZ5sv/AUTSW6qDtGynrmRUxuPd8PL+E
         peOyftrMtu+ReZ4cjo/yz0PQwIx7IV41d2DTFMxlkAgWPaUF/4/l7/vwqYo6FU2wrI7M
         y4cmTtlZgPzZiIUPMdXuGsL/urOxKi6xnlOHOTNSNp7vzQXMYQ1pqnCMI/Ag6NJIZnAM
         jc/V+2hSEQwNGnuG9w5+KTehlH0GNxFhiB54OvFLiPY1cSK/PPCZxjlfz8gqEq68/yLI
         rHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140427; x=1775745227;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=So2vIHOG8Zm+vmmprAGxBjFa98UpZPTRWBgQqP4gM38=;
        b=KgSWAjkyfpmDrEeTQYrWqL13qVtVV3WSa7or744ERQGWlAeKNcZ0Lvj2tMeE77pLJT
         CrpBbVdtHKsIqOOSeJF2H+45zn6kVFximzCjdSWa115GaUYGqrm11HDBuRlxEb6THlM3
         5a5uZQdwH6VF9vT+YhzWtRN1OIpXdS8egcIWddH1LuZUOIVTYzq4tvWYXUS24s+VCmh1
         h+jpQbKR4jY6ufhJZex8UB3tbJ5vi9XoW1qyiqasFsr2gHhGHfcnJQFvi0SbtGN/FRb5
         9SI1TbSI01BJLGDAYHJ07H4NJy2K9VIUYaNivQKVaYJ9+YI/x18UpXEYsfUijtaYaFOr
         Z7bQ==
X-Gm-Message-State: AOJu0Yw8cct5T8XIdZQQcui6A0itYLbnZCWcSrqIxZeKCQLVRW4ySsT8
	Ql8MQdj4jfDKadNaobC7cZsipYROf2D+LqJShf/gwwd/XxjrypPj7rpwzv6adA==
X-Gm-Gg: ATEYQzzTnghVjNPrdzv1nc3B3atXG9hvnBnwOszWRPvzMO2vRBJnL3vC3ITjDWQkvcy
	YlsRyMV5PuOqVPfIN3wNvJoXZ6ZqNPohrXnpd1EZ5a76u+b8rT7dxpeB9wfyZ/ZlcdxXBIOrvoz
	CGKzgHt9+FooRjck45U6ZfRlrAfB10AUYA4FO+CqchHbG9UVZ4V7A50a/f1Dl38HS9WYAcA33ff
	mzuhsLnaIAbjPkwYlIDEzX6hjU5k59Eg2aa5MtwQZXKl6zy/7BMs+O5xgc2TXphiw2LmNzaVHWI
	byHa8eWr7bYJLuQ967fBBIsFhy6apaL1RNUBC17zCWbxF3TI0DbDBp1xT52WszeipuUSQrBg5Va
	prmZy+gEzgqgnmDMyQXCi2RvM+TREzfW6ZgpXNf5g1IgCf0PZyVxoHaZ5kzWqdovI/iIAr+nYaO
	IzWR0sXn6XG/ViGHOALA2utwVF67U=
X-Received: by 2002:a05:620a:1789:b0:8cf:d5ca:add0 with SMTP id af79cd13be357-8d303223e07mr282344585a.30.1775140426878;
        Thu, 02 Apr 2026 07:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5d5d5a7sm268382185a.18.2026.04.02.07.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:46 -0700 (PDT)
Message-Id: <861a8e0940f172b2e401611efda7d42ae31373ea.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:21 +0000
Subject: [PATCH 15/17] t9210: pass `safe.bareRepository=all` to `scalar
 register`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This test expects `scalar register` to discover a bare repo and
reject it. Since `scalar` does not support `--git-dir` (that option
would not make sense in the context of that command), pass `-c
safe.bareRepository=all` to opt into implicit discovery of bare
repositories, so the test keeps working once the default changes to
`explicit`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9210-scalar.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 009437a5f3..54513c220b 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -88,7 +88,7 @@ test_expect_success 'scalar enlistments need a worktree' '
 	test_when_finished rm -rf bare test &&
 
 	git init --bare bare/src &&
-	! scalar register bare/src 2>err &&
+	! scalar -c safe.bareRepository=all register bare/src 2>err &&
 	grep "Scalar enlistments require a worktree" err &&
 
 	git init test/src &&
-- 
gitgitgadget

