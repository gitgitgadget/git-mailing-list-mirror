Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7F28FFFB
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179065; cv=none; b=c8XckNqZ6fRecjX7VoLUylIc7wRoNXVayr7j0e4zjFZh4rs+GYGQzKYzqlPw3FcLRxAlYo+ikaTKLwhSHIYxDFgkieFlVacZdi9+fh6VNweOqWDPsfvQCeA3OS6tXiIiPdkGpTQUMm2T+VOfo5ODvRnw44y+PtErSEl+V/0FKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179065; c=relaxed/simple;
	bh=EMz9Wrn0nTP+2Bl5llrdgEp6yf8xCZolGjHqNd4Llpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsd0H889SGtYa8z9WTYlMbipdCzxylmG4yV1CUCnh6WDPq2m5QoMB55lEuXRIS6jKNKn6HSs2kih/IUlAB3D0iqRv34X/uiwoEGilqak4DjE/Ns6LpvlgYzqFTDNI3acfn/+ucm225inmssJM9LeH7ZoPAly6IZy1mLwIvxskxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+NxkdBi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+NxkdBi"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a76f90872cso12102425ad.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769179063; x=1769783863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1TcrskYCMx6WQ2ctN6S6ZBqmJsuCr4f3sQ9qE1kvqQ=;
        b=c+NxkdBilrsZ+tlqcAnXauBPVzS46tFoncTDHol5bhHmOUpICeG7C1iOWOCseLNZvK
         OvNuc8l7K2fI+CD1TKIat8djQ/YqLlsjB45wRTdJnIeAvprLpQy3faUPYeMisQTCBnvY
         a3h7RcjmL2ztGgajl/UvNu7ratuK3ZhFbXuEPf8zR4sh5j9LAX3j0pZm5R4p6ZupMgEt
         LiIAKIWoUFp4ETnATN4ZP/AeVl2hYAWu9rzoYSDB+BDI+3ZHrpCiIAZvNj+UUiPKzcz2
         4J5rW/7aCQLnISl2YDLxRIOp80GQZ9L7aPGecaS9EPDSuBls+TrBBl3U/rTQPZkJi/Hz
         wNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179063; x=1769783863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1TcrskYCMx6WQ2ctN6S6ZBqmJsuCr4f3sQ9qE1kvqQ=;
        b=pisZJkKe7gsj1jyGDvrc0gXE9FVBrFtttGdlNFWJ7YvVQP5hJnQbZyV/wuAIECKwtG
         cGKxkVu+X/hXjN0HU+1lG1JrmvivTb0Jt1GS3XEbkN3KZOGZaKu6QVArUNqwFnfU3pqB
         TbJWLyWvnqQZos5bjXo2Ltop78K3cJSf2vrI7tWTgdkbMCT6uVvYJIsxssu9Q4DcMzFq
         Isxe4KSnbBlTO9lMqvW5tj+R2CcGdMjAI5I7wnZOaFDckiMUcxHkNM+7w8sWsEaHrsvp
         Vk0I+6qDWOQdjEcLvL70rpfUgG+K5le4VBVGeM58u0TXCnFBv2TSre35O32dI1g/9deE
         FeUA==
X-Gm-Message-State: AOJu0YzMGnYESgHvSQBuRNHKOscIgve+fsiELPVKnDWXtSMbZpKf//xX
	nzkxGzdzsZCJ8qzqUoYNYuLFKNdlTJak37cl3Wv1HzRFsXN+zF6x8mA17Y4RLg==
X-Gm-Gg: AZuq6aLiUnyIyq8tBQhcepI7iZYBKLmGTrSU/okyN4QSKgFw6AyuoC78M2D41t088GR
	K2mS5TUX0xpntwXCElPvqstNlTbsCI2+KhriE7+C28QS3h2YZS99kAnnJqrD+cP9E4YRxApn6te
	+GuuWF+MKJAKjaIRQxuyT7WtlYKgVzyED0pYvw5GljCShonb+Ea9qls4ZOYLb1BchyTMeXZXakF
	puuAcvzggbCLDhUxVeBsruqngDcjJjYUumFhxxD0faXMG4TcRYWvf2GygPL2A1vWOQ2eQWvbwiO
	oz5A3a57p59Yg01kvGa7SF+tfj+3zttSh2PG4tYOXqfwQihYWzu1BDu29Q9wdSAwCRDtj30x9K3
	XfNV+d8++mj8TXANfozLuegRJJ2FAubUGTTr4QptyhZ+Y97JrXaNf4sM+4hOBRhegQlylqE2wtM
	wfs1sMTcIbxvS3hK+aQbqrCaQQfv4d6PeI
X-Received: by 2002:a17:902:e5d2:b0:295:6e0:7b0d with SMTP id d9443c01a7336-2a7fe75af1amr32055065ad.56.1769179063222;
        Fri, 23 Jan 2026 06:37:43 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871d4f9sm2402691b3a.32.2026.01.23.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:37:42 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v4 1/1] subtree: validate --prefix against commit in split
Date: Fri, 23 Jan 2026 14:35:53 +0000
Message-ID: <20260123143552.15572-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123142658.15516-2-pushkarkumarsingh1970@gmail.com>
References: <20260123142658.15516-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git subtree split currently validates --prefix against the working tree.
This breaks when splitting an older commit or when the working tree does
not contain the subtree, even though the commit does.

For example:

  git subtree split --prefix=pkg <commit>

fails if pkg was removed later, even though it exists in <commit>.

Fix this by validating the prefix against the specified commit using
git ls-tree instead of the working tree.

Add a test to ensure this behavior does not regress.

Address review feedback by fixing indentation and adding regression test.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 contrib/subtree/git-subtree.sh     |  9 +++++++++
 contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..324ed38148 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -257,6 +257,9 @@ main () {
 		test -e "$arg_prefix" &&
 			die "fatal: prefix '$arg_prefix' already exists."
 		;;
+	split)
+		# checked later against the commit, not the working tree
+		;;
 	*)
 		test -e "$arg_prefix" ||
 			die "fatal: '$arg_prefix' does not exist; use 'git subtree add'"
@@ -966,6 +969,12 @@ cmd_split () {
 	else
 		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
 	fi
+
+	# Now validate prefix against the commit, not the working tree
+	if ! git ls-tree -d "$rev" -- "$dir" >/dev/null
+	then
+		die "fatal: '$dir' does not exist in commit $rev"
+	fi
 	repository=""
 	if test "$#" = 2
 	then
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 316dc5269e..e4f632f3af 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -368,6 +368,28 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 	)
 '
 
+test_expect_success 'split works when prefix exists in commit but not in working tree' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+
+		# create subtree
+		mkdir pkg &&
+		echo ok >pkg/file &&
+		git add pkg &&
+		git commit -m "add pkg" &&
+		good=$(git rev-parse HEAD) &&
+
+		# remove it from working tree in later commit
+		git rm -r pkg &&
+		git commit -m "remove pkg" &&
+
+		# must still be able to split using the old commit
+		git subtree split --prefix=pkg "$good" >out &&
+		test -s out
+	)
+'
+
 test_expect_success 'split rejects flags for add' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
-- 
2.43.0

