Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBF3BFE59
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766524; cv=none; b=IIYnRVS/JlEWxL9yHK5KIfAKSmQ5DxaZ5i9+R50MS2n+E/MQKU3KPRAD3h9eLsnATilR9ZNDwPulflJ3QWbt+X2T4+tHGnWVHypBdcIjghTHtumoIaoa0E+3/ZgGt8+WMYWctfRVO0XdQo3Cj3DFkOqIT7shp4WcdTrmns7B3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766524; c=relaxed/simple;
	bh=1Gjq1YRazGX6z3c+bWa1pFgYfkJh5YoYANP8mDbLI2g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dlS8NBL2CfCG0E3F7PohCkjbdbkUdvWlGEWpmE2WAe1dkf23gh754MWndWXXn4qp2LZXF4FxYj/6HsuCE3nea8RDI7pIWCz+nocJJSYb6tOH5u0QqBE72kfCjJdxqwJHjBNWD4mG14JJVGz0HW+XIXtkp+DJNAhYeerNIkLMBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmHHdVI3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmHHdVI3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd759f502dso603543485a.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773766521; x=1774371321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0fwiZqtPcb9ySCuDmlbQKoRygUh2WPEsCKgCbgfuXjk=;
        b=CmHHdVI3mk3p67EKkovYzKXtisRYEoPOlsjKHMEl8cv9tmSvw7wdGSnnR1pSR7RRMc
         s3mpebALTbyK8o41KpPCr9qevsi1+3F4ZXebZRltaQNMg67G/mLTBNXTKDl0Jg9Wq2wS
         7lbf86LcIKnTbV2UvvsDhEWfDvAU8eilLdLMGYf6i1jR/tqMFFy3E+nekwREbrl+kkUq
         JkPOxh9AWHt4MHfOhQfCaLyxs13QHXbnX3tl3HWYPrDyltIsbAcbjIyIqBcglERkGNMu
         gmGxswB/lKmfmsi8izNdwETkDD0rXNp1+KQchnjzfuO9KRsay+3S9HiCTsycSL8IrL9m
         j/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773766521; x=1774371321;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fwiZqtPcb9ySCuDmlbQKoRygUh2WPEsCKgCbgfuXjk=;
        b=oWtRLmHkx9l6NOFBt6a49CVOUaSU7+y3txi8+xlClCGxwXDiXTGwRq5fdKv8uIEMow
         NBhr5Oy1JdVPZr5Lofk1H11UXrsGM4A2+0BdhbRNx88aMnvKl+mV3ZcFk3vVZB3VhCTp
         b++SxWSnldaL8QKyxZQjDVKEiPn4y6LGwFnkQH8ivJTQ8d24MCoy8atSpPw6Dn6X0N/O
         NhT6wAfP5V4Ibc1HaeMRqBgQejDcJ4nSJUHFehuXCqTfsXowAKhboDtOKOeDQMTY7hWW
         VIKcrMYNseJ0Sf590nnH0fRkqtQamWP7AUM7Ds06sanaLjkxuEAchSTKYo69i1315nS4
         dT2w==
X-Gm-Message-State: AOJu0YyyQN3xNkKmG0ydtYAzuy9VdQ0P+Wj2/3d0OfWJfqksT1ut+tx6
	2ja0abLOViAVyFKkTda0ttG8WRnK7k7wolD/ruk0jEL4s+r+3WlBUjACNxrd5KLR
X-Gm-Gg: ATEYQzxitAZEpiHtXfEIZZYxg9J2wZEBiE3FKgstyDqt6cQEUp2L7YS9wbCfNbj5VOg
	C+a/ugy2P1aofLPmLp5LSMar6Sy0ngykMaN1dSFLYyCk9+cSNQTHtPaC8kEiXMKE6cSz1gonWG0
	gUWSm+Eh3JqpuVkCeg3q4lDjttu97BXJm/soXmCoPEeZBwjDqwBs7EjgNdHyMASrq2meSIHgbTJ
	ik0mceb2rHc5ZO4qMTYpJwiSdkt9VNwDdt7k/0tNBKbPoaZWjO1GRcN+hSkcuoBWBvLZhOaH8pE
	/lfyDDq0AQ1JvV71LEyRmHDeRxLnbuo7ZKV9JZrbtoMQM/iznAGnfkbHIlz5HX6lE9IkaGRkdSS
	YImKTlOTJ4651qnTXOh75CqG77iENqAR691ZkzFUniTbysVu10BhGYgo1Pb+0j8+S7VPLd8APBj
	pBWc8TO3mmIC0ztvKbMNLQxhgOzfBJ71DL9U+I
X-Received: by 2002:a05:620a:2a10:b0:8cd:afe5:eb91 with SMTP id af79cd13be357-8cfad308cbemr31191485a.42.1773766521247;
        Tue, 17 Mar 2026 09:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.55.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6ba0963dsm899766d6.49.2026.03.17.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:55:20 -0700 (PDT)
Message-Id: <pull.2242.git.git.1773766519857.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 16:55:19 +0000
Subject: [PATCH] repo: add paths.git_dir repo info key
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

Introduce a new repo info key `paths.git_dir` to expose the
repository's gitdir path, equivalent to `git rev-parse --git-dir`.

This improves consistency and allows tools to retrieve the gitdir
path without invoking external commands.

The implementation adds support in repo.c and integrates it into
the repo info reporting mechanism. Documentation is updated to
describe the new key, and tests are added to verify that the value
matches the output of `git rev-parse --git-dir`.

Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
---
    repo: add paths.git_dir to 'git repo info'
    
    Teach git repo info a new key, paths.git_dir, which reports the
    repository’s gitdir path (equivalent to git rev-parse --git-dir).
    
    Documentation and tests are included.
    
    Tests:
    
     * make test T=t1900-repo-info.sh

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2242%2Fjayesh0104%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2242/jayesh0104/master-v1
Pull-Request: https://github.com/git/git/pull/2242

 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              |  7 +++++++
 t/t1900-repo-info.sh        | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 42262c1983..d17d911ec6 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -95,6 +95,11 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`paths.git_dir`::
+	The path to the Git directory for the repository (equivalent to
+	`git rev-parse --git-dir`).
+
+
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..3067107cad 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -66,11 +66,18 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_paths_git_dir(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo_get_git_dir(repo));
+	return 0;
+}
+
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "paths.git_dir", get_paths_git_dir },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..63be0849c4 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,4 +149,14 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+test_expect_success 'paths.git_dir matches rev-parse --git-dir' '
+	git init repo &&
+	(
+		cd repo &&
+		git repo info paths.git_dir >actual &&
+		echo "paths.git_dir=$(git rev-parse --git-dir)" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
-- 
gitgitgadget
