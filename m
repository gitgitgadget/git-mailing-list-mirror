Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D67374F1
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707873; cv=none; b=S+D0YolwVzOjclGbyNQx2IZnkYnvj68lysi72Bqh1RJnq2Ulo+ifYWaEkFtP8n6ibUzNTz5ly2Y5NfmzpXqrIZ04xXzARa0RE2PHYgLzZJ9+rGiK0jHOtwa/JNifyAbrFKQBw5iwfrMqh2cKpBSRENtwRZGHqLlQNCAOQhrBThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707873; c=relaxed/simple;
	bh=yNCSwp9ilTB7k7dn+LXBoJNN362bwLWCTtTb6uButYk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JysPJmsAJ11rp9G0zYFOfCEUSHNWK4Y6UQbh0PDZtOELvIbPEQPkwAKZL6E+GWdiV32oorqBaK35qqNyYT2076GwYN33rGZpbvErm9UT65qa+iyj4J+K2YN52hzBLw+inCxU6vEwUTPd1r9/a4gVS0yBXPwAmIb8WCTq/61cBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST0G3zoV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST0G3zoV"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so193579366b.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707870; x=1729312670; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9P5pIMd/g5eplTsOG7n3zuU5oOZnpPUceC9tGFrrvo=;
        b=ST0G3zoVaQ8XtI3zXqjRZMnJv57neGOUaBvxVcXFAWdc1NysMuAyqhyEep+wOzAVWl
         WHo3iLan6VhIJwaJK7C330F4JDsnyo+x/w8kfNnWRzXVv5BSh2PFPIktYkgksOBBJb3Q
         82XSMnITIcRyUa7JWqp1SybcfEk6yMtxadFQtCnOU/OZwT1SQdbXtNz4gNQaebco631e
         jpRSR+XBUdpF1k6g6BoOP3iLSY9yCzpegzt7e+ERhmHqC9WwTbRDnc1OxwkRiRg7kWi9
         asXXqSwjQ6TblGQqFnjfKgZ8MOD3zYzbc9xVXZwKUSSyfSfFUnsDTDakEyHD/O8Vawrz
         tH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707870; x=1729312670;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9P5pIMd/g5eplTsOG7n3zuU5oOZnpPUceC9tGFrrvo=;
        b=RJoMmdGz4SkJ6/5AwzKSJ7wOL+woCjk0hJHWY9j1TL38HfuxX/qbkmedx8VLlfMcZw
         gUgfkJ05jp7AsXxcbNcgoZ2hBtz5+QceQNqoQTH4KqGIuIc2dK2uW4kAL8v7gbp9rDDA
         qU1297iuyhSY6O1BvZqA77MpQ2P1ZSu0JMbKSMxIGaLJ9vow5q6C8RjGT1iicO1x1Hyz
         YeYQbp+DZ6HQEujemV4Ddt6JuTPu9CMK14N1CaXGCXaIZx6kClBgGRIQo32Jwf12z8K7
         FfGFGNmLkvp6e64eABwVKXlgGo3tjy0mrpzumBWcno8JxfiMMTn+G/8sQBi69/IDnCiz
         +LhA==
X-Gm-Message-State: AOJu0YxzShme0GX20MNq+SDZ74wSjhgrm/fPROKUc8BqpaWj7A604WPJ
	ZKeLO+PvbcVbCf8C9F94Yt2mTESv7xkUfZgU/9nOa9lGAZygn0WunzuBVg==
X-Google-Smtp-Source: AGHT+IGxcaWMD4yo4/lH8pWmBNPo3aa+V5jaYyfuvbxdYfM2glt2TSHm9vcJKLrOLazB7NYOdNiQyQ==
X-Received: by 2002:a17:907:d2e8:b0:a99:5cf0:4b83 with SMTP id a640c23a62f3a-a99b9583ed2mr403220766b.30.1728707869457;
        Fri, 11 Oct 2024 21:37:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c02b9sm280976766b.138.2024.10.11.21.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:37:49 -0700 (PDT)
Message-Id: <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
	<pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
From: "Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 04:37:46 +0000
Subject: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>

From: Abhijeetsingh Meena <abhijeet040403@gmail.com>

git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
This is useful for marking uninteresting commits like formatting
changes, refactors and whatever else should not be “blamed”.  Some
projects even version control this file so that all contributors can
use it; the conventional name is `.git-blame-ignore-revs`.

But each user still has to opt-in to the standard ignore list,
either with this option or with the config `blame.ignoreRevsFile`.
Let’s teach git-blame(1) to respect this conventional file in order
to streamline the process.

Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
---
 builtin/blame.c                      |  8 ++++++++
 t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 t/t8015-blame-default-ignore-revs.sh

diff --git a/builtin/blame.c b/builtin/blame.c
index e407a22da3b..1eddabaf60f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1105,6 +1105,14 @@ parse_done:
 		add_pending_object(&revs, &head_commit->object, "HEAD");
 	}
 
+	/*
+	* By default, add .git-blame-ignore-revs to the list of files
+	* containing revisions to ignore if it exists.
+	*/
+	if (access(".git-blame-ignore-revs", F_OK) == 0) {
+		string_list_append(&ignore_revs_file_list, ".git-blame-ignore-revs");
+	}
+
 	init_scoreboard(&sb);
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-default-ignore-revs.sh
new file mode 100755
index 00000000000..d4ab686f14d
--- /dev/null
+++ b/t/t8015-blame-default-ignore-revs.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='default revisions to ignore when blaming'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'blame: default-ignore-revs-file' '
+    test_commit first-commit hello.txt hello &&
+
+    echo world >>hello.txt &&
+    test_commit second-commit hello.txt &&
+
+    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
+    mv hello.txt.tmp hello.txt &&
+    test_commit third-commit hello.txt &&
+
+    git rev-parse HEAD >ignored-file &&
+    git blame --ignore-revs-file=ignored-file hello.txt >expect &&
+    git rev-parse HEAD >.git-blame-ignore-revs &&
+    git blame hello.txt >actual &&
+
+    test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

