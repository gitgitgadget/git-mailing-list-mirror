Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B3346782
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332220; cv=none; b=HuvzRo1xeqafRAy9bRoGK9CW+YKiF8lSWKQNWhBsW8P7XOWkLG2Litfc1BjD5LON9L8umzXpD/ClEhz+F5goolLlPPv4y8BZwwAsnHw2lsdoJktvHjFw8GgjLiTPtap3ec5mvsVQkRCYC8ZFdxyG5YnlPNw5WI0rjNaCQAjbXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332220; c=relaxed/simple;
	bh=+63aRGSBqz6HSHQnvcWjwwdpN4bQol9v+qtK6YXJxOQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NKDCFqHenRdlm0LchWuwMAj+JupepqfBrKzjFlK6AP3r8dHD3aDolKWKeqbLZUWw74yo0Ew7SJllfd0RSYUlGpF6o/GL4xN+lZVPziL0Um+rZozHFSYhMpEYmNJsJwYNaugBjTMF7y8bvUrhFoDDxgpjXW3jRnMwo8OJIve2sdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk7ZliGJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk7ZliGJ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d1b746f522so324781385a.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332217; x=1775937017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o17+zJH8tRbAy3ykVGAlCqOKUyYVdHJLKN4nvYlOTAc=;
        b=Lk7ZliGJRXTuJeeayBSbnpq5ptAhT+v7x4BkQt5tdopAxgtItlnQ726O3gx7MvXrTe
         cuUi3eDxrM53K9vGfsQQMN3Ki7M5r5X+qdVLst4UH12ZI3J7nSpTvED+Zhrwy/UDfDzT
         NS/Dj13MlOlqYDHh9NSNxh1Rx/cVxOQoQpuR0+YIb6EOTNCC39Ws/kNYo0GzxzyCm74m
         fKERma7s4dCfLMMNa8qdzUtS9mSaCdKvfv96GwUlgl4+LCdwr/7Xrt+cPJV0z0cyZ3Ix
         FII/PGa5cZ+sEDn4Fte4ulrUuoTQS/v/RQ2KR7qd/1NatUzNfx/nsCkYLa5Cv5UwpDO9
         OiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332218; x=1775937018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o17+zJH8tRbAy3ykVGAlCqOKUyYVdHJLKN4nvYlOTAc=;
        b=PGbfXQbQoUNWEX3ivEStduI17iDVzMgW/CcsbOAdYyooH8RXVgAtN8VhDRTtgL6Ye/
         tVLSTz9L1QLn+TB08ILNdLk8/5c8lXzTgmPeqIWrlbeiGUrLOmlB3uPq9nfWyjcJ8ytA
         fLfDDEG31bIkY5/nPGr/yzB8I0/Lj/gmubmdnt2M09xm7VD+XdVi8Gm0C0kJMERaIhnB
         JkJgtK7mwy95Q3ktXjK6bOYMmZvG0rGOtbkjA874OafcOG+kXmdSeRUtx9/MUkhObNWF
         3XSzoZVTN4lzm7gBLCLvvimaXcg/tbpGYErYW7ZY1Q8L8TCkcSw+eMnJ/45+dZjE8qnE
         x7sg==
X-Gm-Message-State: AOJu0YyPoqmhW0E4rqAENmzkHxD4vSKfvA4VNzezY3X/3sPvUp6gTzdg
	YO+MWcvK2dvU5xUgjdT9Ct6Rk4/5/BrfXYILs/pZ1jllmwFzFXItTX55mSlXkR1u
X-Gm-Gg: AeBDievAZqSRPt4rL79dyf+myqECwYrcHO7qOnbGwTPO6uHA43IMDoy8YBmRQxIpZWx
	zyV9etW08FuA1N2scOAYDrICKFWQbZ4KiJfP1G5NenAnN2JmbMEqiv1aR7ZvUpw2jlNMG/COef7
	7lfyItFD+Qwq3IimT7MJMAGDfAyPcIpEvNdRcs3mJAEo7VSw4+4nGk2t5oX1SKVD4wMcLYq1vBQ
	Lo/WkLjeCaZdU+SR3TUduy/7gLVIgsQrBRvVzfj3046PYtxqaJAaSJIqwv4NpEYjn2A8DesftJp
	f7RXWvzGvXaGGSX8pNLR+1SVG65N2oIlz3tVbq9OZatidHSibI12SZW08ehSxpl0xaQ6Hz+OPqR
	BgW14gYhdpR6+EYKrrsB8Ie2E8bnG6dD+4rwE7p+rRKQVp0Go+xU3ZaFfPS5sPdarK7j0gxiijF
	xPliToKJ3UpFq2rTSTeh7BfxnwlzA=
X-Received: by 2002:a05:620a:2844:b0:8cf:dc6a:18bf with SMTP id af79cd13be357-8d41e53aedbmr1019843085a.50.1775332217646;
        Sat, 04 Apr 2026 12:50:17 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5c5fe8esm715956485a.16.2026.04.04.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:17 -0700 (PDT)
Message-Id: <890dfd024dcecf9b006c7ffd3ef9c42b17743640.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:56 +0000
Subject: [PATCH v2 16/17] t9700: stop relying on implicit bare repo discovery
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

Currently, the "alternate bare repo" test case relies on Git
discovering non-bare and bare repositories alike. However, the automatic
discovery of bare repository represents a weakness that leaves Git
users vulnerable. To that end, the `safe.bareRepository` config was
introduced, but out of backwards-compatibility concerns, the default is
not yet secure.

To prepare for that default to switch to the secure one, where bare
repositories are never discovered automatically but instead must be
specified explicitly, let's do exactly that in this test case: specify
it explicitly, via setting the environment variable `GIT_DIR`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index f83e6169e2..99b712b626 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -153,9 +153,12 @@ unlink $tmpfile3;
 chdir($abs_repo_dir);
 
 # open alternate bare repo
-my $r4 = Git->repository(Directory => "$abs_repo_dir/bare.git");
-is($r4->command_oneline(qw(log --format=%s)), "bare commit",
-	"log of bare repo works");
+{
+	local $ENV{GIT_DIR} = "$abs_repo_dir/bare.git";
+	my $r4 = Git->repository(Directory => "$abs_repo_dir/bare.git");
+	is($r4->command_oneline(qw(log --format=%s)), "bare commit",
+		"log of bare repo works");
+}
 
 # unquoting paths
 is(Git::unquote_path('abc'), 'abc', 'unquote unquoted path');
-- 
gitgitgadget

