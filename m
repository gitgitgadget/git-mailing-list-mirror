Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3758ABB
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185379; cv=none; b=MlE0Aqo2HXEraOOJasStg1wOPdpdkazxzHInJhqAlY3Sk9W5GtdSFXkKaZuLWBK07ldFaXCIf1ZL+9EPjPVd+lGmKHvMJ68gMCU6+dvb2NSrxeeA43Art2HwGExiKbgSQp42Lg7KOJCpWoPqNySyK9x18VuB6IRfZmP3eqfFIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185379; c=relaxed/simple;
	bh=2rqmk/8cF7AkouZvwaXgVsDWEMOQLh4iCQLsF7PJWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQlNSr284CIRov6jtUfAPhCzqLzMDdMADEJgORkL21GoVg0BJ9qZBOZ8ZKiYPF1pM8QJAFlSvYh9KApeMvhEtP2L0Ld5YAwE+nKP1/LZm5E91XnT++uFt/TjvEdHzqz24V2M/9JAs2T0mUq7PYttqsu4Anm38Xjw97kxEfhyVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeosZY3P; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeosZY3P"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d944e8f367so40050075ad.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185377; x=1707790177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJC771/ZAtYuzQtPLvo0UyQDABOPPwXtlear8RbdXuM=;
        b=FeosZY3PX5Yja2YOs4IWD639/FBwsvz0zcGeMAwMs+sycH/EDh5ZePylPucfEFvG3D
         jYxJNMf0DF/Uv0kZ3KoylZQT4BykQ/e/9UnSepLS6AJA8Mgp1k1IXG3U6RDRv8Z5IvOC
         HUgAy+a7BeqzpMlau8s/ZpCukfnuI9H0s86ZCJ+2RbgZfUIYR48KMvJ8GXmgJNPnX8Hm
         UywYJOe+NFZxHaxKtB+Q5jKn5KWAVzZYVRzgr6vEhcdI2gwpEX2ObVxurB13PJjl3Tyz
         q4a+h1mKO0ecz+GqjDr9Za9ebdKu2HY5Wi90mEpjd5y/wMPJ3gtqGoBVf/Kdzf/xRiU3
         Q2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185377; x=1707790177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJC771/ZAtYuzQtPLvo0UyQDABOPPwXtlear8RbdXuM=;
        b=Zx6egnbdHKeC4VfENWo5+n+71QscaodrkD5Fs7NEun+rI+VbD8Yjlbbpb33MJQ5Xb9
         5LMCXINm3rWNXykON1SfTOBfZJMyO7Ry+YqXbqq4CskNBsUmIcGvd7+UjCw9WCUSgbBX
         0JIYmlx54pvXjuJm5AtI0SCkAMh80gXqxA9tbj8AygX4EfaYYpBUIHGhb9rWExAUnXdo
         UWYhiNyog3YqqXtxkY/zVcWtDVGX7zRpok7CPu+9OH/nWcN3cEqUbn+6L1tA0JWz7nPX
         npFkgLau/32z/8XoWjI3ymanAaTh+qkCFTfUm+gedxASd2bVbvJzJm8SnpkJlRu8skiu
         7UbA==
X-Gm-Message-State: AOJu0YywsLmJEbYe3m+v41P8viNqCuLAlgubWbVmj250+ifScwuW9aoP
	CIIDeTvt9MmTvSv7AeFg7MbtNV8Ghk015OcE6BzIp1hUX7ZkgItpkQ+hM/QvR2c=
X-Google-Smtp-Source: AGHT+IFEr3+FWsdct4SAfC90UmI1mcnLbGK81RCuI+PHbIs8pjJmsgFSNm3piPloqq6ioDVfqoGyBg==
X-Received: by 2002:a17:902:e5cf:b0:1d9:d17c:5818 with SMTP id u15-20020a170902e5cf00b001d9d17c5818mr349363plf.4.1707185377026;
        Mon, 05 Feb 2024 18:09:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjLjMeegUN9p1Py7M4ccCmksRDL13OHcv6oMsa9F1Tu+YZoUsJnSuUj1ISa2m//6h4tO8gMc03afqSZGwSY/t43RjbXHWJSaUbsC2S0pMFSNIm
Received: from brittons-large-Vivobook ([2600:380:4635:872e:d8c9:9f5d:4e33:1b6a])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001d9620e9ac9sm570173pls.170.2024.02.05.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:33 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 7E78D520297; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 4/7] completion: bisect: complete missing --first-parent and --no-checkout options
Date: Mon,  5 Feb 2024 17:09:27 -0900
Message-ID: <20240206020930.312164-5-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --first-parent and --no-checkout options to the start subcommand of
git-bisect(1) are not completed.

Enable completion of the --first-parent and --no-checkout options to the
start subcommand.  Add test.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6a3d9c7760..57c6e09968 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1478,7 +1478,7 @@ _git_bisect ()
 	start)
 		case "$cur" in
 		--*)
-			__gitcomp "--term-new --term-bad --term-old --term-good"
+			__gitcomp "--first-parent --no-checkout --term-new --term-bad --term-old --term-good"
 			return
 			;;
 		*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 409a5a49d5..f4d3aa67e3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1271,6 +1271,17 @@ test_expect_success 'git bisect - when not bisecting, complete only replay and s
 	EOF
 '
 
+test_expect_success 'git bisect - complete options to start subcommand' '
+	test_completion "git bisect start --" <<-\EOF
+	--term-new Z
+	--term-bad Z
+	--term-old Z
+	--term-good Z
+	--no-checkout Z
+	--first-parent Z
+	EOF
+'
+
 test_expect_success 'setup for git-bisect tests requiring a repo' '
 	git init git-bisect &&
 	(
-- 
2.43.0

