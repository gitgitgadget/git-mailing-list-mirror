Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8772D73A6
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780862858; cv=none; b=okyZ6UTFvIlEpv+b4bNqtqNhAAMadZfMqmB6bvSgL6JNDLlvPppUkP3qWeEzcA9nXX8ysF01E0EQWIw/2HA25lU3Uv7vsq0FCY2tKc9yjtu1sXG5REH4TnKssPjmrmKn8DuRNvpoXrhOIxsjtokGYv5N8zdW1acqwFXoohUF648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780862858; c=relaxed/simple;
	bh=6L8BJ7cQCghrfEMjof2+gok3/+kBxr0sjoOrj0VMRA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3rWDY1Z+bM1IbH1dw6XOt++Iru/JSToJBpdbisdPINhhah1vsmN2czkrytjv+LyUP8ccke5Hfixda0ttgEV3cd4EQfTa2Kj/zVw1Of2tDrPvtGiqazo2vS6jJ/3MuHrZqiw/rLuLhB3HKtGH1KGJDflBHqCCIxsPO/s+gijB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xl5sZNRY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl5sZNRY"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef4223be7so1828338f8f.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780862855; x=1781467655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh3nGZ2pX6AbiW0AxwERTIGW6ySzIxK1mFBaKoaQobo=;
        b=Xl5sZNRYVF3YGVZopO1sPjCReSGefTG0v4umlRkrfYrgFVqnCBsH41wpW9Tf6Bi8aH
         tef1YqGwg+saXtDZ1yT0Q1ksieEDK8zxZwiUgAIXblFiSJsHlk/P0mbKRPGyFlvkjl/0
         XdcRErDhmP3OK7MOOxe+3mgtUgAbkPJipRtAzhw9WvPfOtUu1aPGgJT6eHFkaBk94Zn7
         Ewk0Vc20ZjHrXX8xWGrnMafX8QhfC7dmAbIEbEziYRXFDgrV9doE66JjPkv7ZXB017ob
         UQCtq1Fhf3nZ02k6ZteZ3RxN1Ir5CaGJNpKEqKWKwzOhlnmw3eOXhqBYtfrlyjBKibHm
         GQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780862855; x=1781467655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vh3nGZ2pX6AbiW0AxwERTIGW6ySzIxK1mFBaKoaQobo=;
        b=nC/gap4rsRRT1sHkpLAe2L347aDKafulpqEGhmlbFgDH10LAZUALjWtzTbA7l/tc8W
         N6Bms+eww1vEPbLaQ/y8Yj8bWM1TPO3azcDqb8O9RwFf9qPKcgQSGyU0HjCQU89NgUNJ
         4n7FO+L8whhyTyx/uw2HnBChEIs2L6YatbF8HI6oOJROjl/CfozBnxyf9UqzvTJSngbv
         jrKtNczKOZRZCUdSOkNhq+ENyKoV0eaGSThS/StIhmwxECZ9y09eQlNWq8pjRabiME9K
         KhAClh8VQPl/Hs7ElTGn1c608ZkdAeJqUUwm1PJJhqLw1pYLiu+CBb69yG+HsCyNPUgo
         KCBw==
X-Gm-Message-State: AOJu0YyMsbYVp+sahSm6AbsO2/QFcKRTMhhU7lUym+w+WEWkL8Jp6aY5
	KZpoEeoXJ8JYPZLb21tUmcB61O0Th7A0MBHhicjaDM9Y3dNc6gPv72c8
X-Gm-Gg: Acq92OEqvKFLAOOC4pcQVpvY7QskgOrDISWAI/65jzHCE7/8T7fh7ZBcInGw3x35blM
	WJu6WARNPCpUrtfOxla/RgkWgWurZ4R8OCtSECQulH4ClboPR8Nw3dAhrre2g47zFvpBPxqqHcG
	8m3Ksx8qlzAdg28yt2pfkLUOoR7mq8ThVhkSYPZwtDds5Xi/5uvF9mWx851GxNXox2rKSRepEzX
	4ZHDAosTslrnqAGRnQT87AwJ/teMrbPmvQWifSxxCqfn5KASXXFldOFksUb+2w2RntrFVU+iIr5
	H4kgY8OJ8KZgu8WzveTSxnV1fuewOQk7GWvzE3E+jUAZBVCFxFRF5cd5q9pNBkjWvdNPc/Ea1w8
	9vQH44VKxxxtl/23m4yVoMTCek3y4F3ZIYPDO5JKTnJAhpbp314REQZUU7eKm1xx9SVsrL/X/gh
	Eoy8Z3RfWFlKNXI5C6nLXdmwxT8w2EZJWCWKCSWohCkDjh9R0N673exGZEAnyQs2IXli/TSin+m
	+Gr3sQWNUUwqpxbkN3+4wvk40iL/n1my+Sd1+QQl6jYwOOxmR5TJ5tK9wrc7O6dkDDxebpX2foz
	JXqSMV2ExhusIYjFCf7QtiTEQt73TwRmkv0GMXX2ha5ZwRzLfQesl71VlvNxYJWCf7NQltWuUAt
	59zV1TYXU4UFoXLaaG5SSzzwZTG4R0D7YiPfMdxP6MkYOEjA5hnABirBERMxLjllNySv4wc2x5o
	it2zU3shclbeNXFqZOddRe61sR
X-Received: by 2002:a05:6000:a88:b0:454:a41f:d082 with SMTP id ffacd0b85a97d-460304eb3d9mr14476898f8f.3.1780862855538;
        Sun, 07 Jun 2026 13:07:35 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (static-21-4-87-188.ipcom.comunitel.net. [188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm35511890f8f.10.2026.06.07.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:07:35 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sun, 07 Jun 2026 22:07:21 +0200
Subject: [PATCH RFC 2/2] builtin/history: print feedback after successful
 reword
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
In-Reply-To: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Unlike `git commit --amend` and `git rebase -i`, `git history reword`
doesn't print anything, this makes it feel empty for a porcelain command
and hard to tell if the command did anything without using other
commands like `git log <commit>` to check if the reword was done.

Print a message on successful rewords so the user has feedback about it.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/history.c         |  4 ++++
 t/t3451-history-reword.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/history.c b/builtin/history.c
index 51a22a9a1c..0f1ba3b531 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -739,6 +739,10 @@ static int cmd_history_reword(int argc,
 		goto out;
 	}
 
+	fprintf(stderr, _("Successfully reworded commit %s to %s\n"),
+		repo_find_unique_abbrev(repo, &original->object.oid, DEFAULT_ABBREV),
+		repo_find_unique_abbrev(repo, &rewritten->object.oid, DEFAULT_ABBREV));
+
 	ret = 0;
 
 out:
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 54ea8a7207..4b22d761e3 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -416,4 +416,18 @@ test_expect_success 'aborts if the commit message is the same' '
 	)
 '
 
+test_expect_success 'prints feedback on successful reword' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		reword_with_message HEAD 2>err <<-EOF &&
+		first reworded
+		EOF
+		test_grep "Successfully reworded" err
+	)
+'
+
 test_done

-- 
2.54.0

