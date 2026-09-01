Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87963A544A
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301489; cv=none; b=MLru4WSS3Ue9MuMlWpQSMfxWF9iwZK9Lyu4pjuhuFtjV1BL8kseq66yokcIf68Du+Dse75qhA/Z+nvdE1TUWJZtBAy5ohiLVvkRLSkHivzTjl80no8CM6vQd6B7MObgwk0XiBW2awiufBGJKgM96FRmID9v6LPCwq4dTVfyvyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301489; c=relaxed/simple;
	bh=d/NoZFHfvU+QWgAjj7frq/C6TNQjiELdX9TcmgE44KQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NJNjylv57T6IKWTqYjH0970y9HvCVch+5yrgiOtiafWRPFkTxRmFhosbdMy5sTc5oapZqxl8zQRkFYlHpq+N/+dYEWvCRQifzD8vVPPCdlbr+1YRAHNyaTZ1sGuIFPC3/d3YKQl6x1rC1SdqvIVNgZJkYO800xO4Z6zqgMpHhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc7Gbc6P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc7Gbc6P"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8568e3ed034so334728b3a.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788301487; x=1788906287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wvr3Y61nGCy9afmMLcOmsP1yu5g2DpqHFM1pNqG9leo=;
        b=Rc7Gbc6PhCtCQ1jIxSAZd3SPv5jHlAq+topA9BBMc6diY9cdVLYmGxRPl/gICDFL14
         JWXnUHGDks7SEleqE5NkZ4Ca5z1vLKRF45HN/sbRBWOkmGcn3FMqlsu+IvX/F88BMww9
         bz2I+i8ezCTwrHxZ0tXAIby7sX0bxqHyR5Qe65PGFVPRhps6YN/mgEotNJ6hkTqpfToK
         5agmwmkrxlDWyGzYbESA3Mi6AxbyjIievRO/C3Rq3OjThYKgu7MndUHUrnAELIR8xqua
         /jrUuXSfk9KZXryD0Yk0imDIRLg7r9mTj9LQuwTEEpfVit0usMUsfKdweK6V9wiuc22s
         dG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301487; x=1788906287;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvr3Y61nGCy9afmMLcOmsP1yu5g2DpqHFM1pNqG9leo=;
        b=J15O9XGix4VbsHPOF91UayNarFxDR8EGqi/9miOo0WwexqZAX4sjsysS/Z08Sx7dja
         Olm++V5+K18kLxpNk/EBQJRJPw2O094k+ujRKT/O/KddB6kRUAjnokLyY2+oQpikDUp5
         lSTjBmtFjBJlGDgucuN4J1SYh/aM7Dz62nhGyUKHOutvnYxIelnVIkG34nm2KAgSpzdz
         IQ7yomgRAWBrL5Bz4+f+DicVLQdZdc6oq4MW/kRLPMBa8Xqm4yaPmM/az4ZcyQk/pmVA
         J0SiC+QgJhZO7SIKERFaK4hFXl4YMTMmts3mMDAz9WdB7V+9imnG8G70B8Rf5WVCX1Fa
         qdKA==
X-Gm-Message-State: AFuF++krSMicLx6b/BagIkGDHij560AQn72N9TWA3tyoydsSBZiyrDgi
	ql9P3omp2dRU4TAJKPZ6/L1dIHfwuJPLTg5OkkYK29M+1Z8sdqsaQKbPoYuChdBh
X-Gm-Gg: AR+sD13PIyy8Q2/xKc6v0fZXPODK3PEMsrXhhy0w+e6w2qSCRa+kmGnf0vTDW9Qwlyg
	+WN3nVFGYSSmVGGBsXWgEhH/aIC0K6LRIY+kF9ifloblZBTxb3CuKxOOMH66pep8cXy+LEpwwfv
	/RmglXufeKqLvHSxJnzLrLly2PZCWBLtjnDhxtbkIN2+d07u0H0dS0hk5cSXPZvgliQ09r7rIYt
	XKPf3YVVyw5ZBqC5ARqCND6Ir7zADv87zrkcfuvK3hcgeJI8siwY9Gay4hBYT+EYinavX09XW0O
	5JlMp4zm10l5EsLwM7Vd+Z9rXXQtAQRWEXR23iRt3NInB6dTnxrYlR44tuCrYi9iPQH4JJwrPSb
	f/0Hf4YOHWug2eGH4HyiI1WP2ZCp/9Q4UbCY+LEH4YYd3Ra304uqBr5ZmnAzz6MTdcFKJ/L8ymd
	cuuwI0v1yiUJartXN4P8caPBA8ac8pTply7ZEbWaqXMqMqEBWlS9sW/iQssHVl
X-Received: by 2002:a05:6a20:e290:b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3d9ad268522mr466558637.3.1788301487265;
        Tue, 01 Sep 2026 15:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7987csm1105818eec.16.2026.09.01.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:24:46 -0700 (PDT)
Message-Id: <c4511a98875a402a59e3109fcfe3839c2564753c.1788301481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 22:24:39 +0000
Subject: [PATCH v4 3/5] commit: reword the empty-commit rebase amend error
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When a rebase applies a commit that becomes empty, it stops and asks the
user to decide whether to keep it or drop it.  HEAD still points at the
previously-applied commit at that point, so amending is refused, with:

    You are in the middle of a rebase -- cannot amend.

That message would suggest that amending is not allowed during an 'edit'
or 'break' stop, which is misleading, plus it lacks the specificity that
might help the user know why their particular case is a problem: the
commit they intended to amend became empty and was dropped, so amending
would affect the wrong commit.  Reword the error accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c              | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 01b79185e7..9b6eaa3c72 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1332,7 +1332,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
 		else if (is_from_rebase_now_empty(whence))
-			die(_("You are in the middle of a rebase -- cannot amend."));
+			die(_("The now-empty commit has been dropped -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3588e16543..81f4844950 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1880,7 +1880,7 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	) &&
 	echo x>file1 &&
 	test_must_fail git commit -a --amend 2>err &&
-	test_grep "middle of a rebase -- cannot amend." err
+	test_grep "now-empty commit has been dropped -- cannot amend." err
 '
 
 test_expect_success 'todo has correct onto hash' '
-- 
gitgitgadget

