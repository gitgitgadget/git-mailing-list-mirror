Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B223D3491
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137983; cv=none; b=YUg3C4lO6PKQ/NOfMOJ8ZDLUVenglUQ7gWsdB1uhlkxwOGE0ftf0n6ZD9G60uIMMiMaQCOT7K1Vb4L3D70FUCrdnkK9siGFYgbhvSfzutF1sJ5g4fBWzRylDGUUPV7K0D6lSSgATD04kBs+LdIaBIfiLItnwySmTrnaWEHXPkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137983; c=relaxed/simple;
	bh=SEsyqBzN7RLcLZ9CCa6KWN4qysHHeKjskTPvox3ju4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abiVCU1xad9GZlY+Ityr7gCxsnwbl5SVTU5FoNDMe+cPdgAU053mcb7/4YG4hFcXKDj9zMhAzuWI2EwYqcHRkCE5kc8604ydiAk0DP1S4GPKP73aY/Y2h2udo1koHPBqoWivoDaQTTmXPTwtKkBH1kuDCVBpn87dUDohlpnVPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8UVgOZ6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8UVgOZ6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81df6a302b1so5514561b3a.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770137981; x=1770742781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2diaVpLMZgNOP0efVwv+G+/N51z4gROZv8k6L4s+WLM=;
        b=h8UVgOZ6735QOCWl6YBX+33vGQE6/O9/LgwWHXE8Pu9Ai2RprsKHDyfr5LXQS8Rdcg
         dWyQGLzgom6vvQOfi1J/rMxP/YURcWpjvfK9ST8lFhIzPj+6BCkut+nrKefWdIOSqYR2
         gpSD0Sy1xjMUYrtcBrmOiTEq21JHk7eCdIyw7G4wsupLb8ykX/hFvDaFRS7oN18vuDKs
         ERgle/CinYSrM1sdX+FccXDxZ9sYdwYTk57163PMxrYuufM0IUQ8mKdRNQbkf1fF8XoO
         M0aB+LH8wr4JKO6dbqimuOmtcVWZXcYY0IyFPGCoZ0ZJLHCmb+ksoyo4mCEs8GKxpE4e
         hYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137981; x=1770742781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2diaVpLMZgNOP0efVwv+G+/N51z4gROZv8k6L4s+WLM=;
        b=H8ZG2funEVgBqN/ITAJGYUXzN/G/Ln48hvRJIEpyNZfx/kzO9LAYqtjJgmrOmQwsfs
         FSoZ4PWODGPcrk1hoW3VvXf/HtJCR5u9BrIR/0vZcSBe7cQstudUzGdVAXxlusqSxn6c
         h2m3JOnCKlGVt6Jj/BfWkAhGMurvkz8D7tBaQNzzkcUC3VJ9nxbkGXpVO4vEGxNHrP9e
         uZrVIG+0FW0BW5zaLLhVyjonKJmBxnVUq8XLywsVJ41385VLHXuEJp3HxH/gzRhr4K3N
         W71lxTHyWn/+roGW+P8Ly19L9KMIWKp+NH9WPPfyqThAfWBc3vDasgWN55IteN03Oan2
         sK8w==
X-Gm-Message-State: AOJu0YxvyMV2tF09Pze6XRCShgVTKdRBUyFwbGS4wF23Xn0VA6MqSa/Y
	dnuLxBWWpYh6cSTQ9Eytre1yqrdHzZOjCaRIu832s4husXdBy5isOKROE0qb7K9K
X-Gm-Gg: AZuq6aLbTH1cX/Qj+LYlX0ZvitvoyPA96e+X91DgwZAPcmFl0h42eqZK85tCl9BSbEv
	R9FY0gOvD5m8m+taw1ZaiOyy1EQQjdHtU9jA0GyRQDS0AO8gPI1h4Xr9kjP8+DmnqSYV1xn9TM1
	1ujORla3s7P3GsBRhP8NjPTbaeqfTPRzChjqzJ8wbBx3lEoGkk34pxS9kHXd8CRtBvkpS6Ee8/4
	X2K58ngvXGh865BrXFQjC21h6StnrLW0ag1iT1Q9ujFEWQtcLNWgmLMpM5+ngijDolvFvbl6SOP
	RneF/f4byQKOOYRtF0cqbQDIG+GXSzuxQA5JIYd2W+st7CNjCv3bWWOZ71lxUjCu8ca6z89LMWv
	aw94T3OkH6dLLfwlwr6T2EHifhV7K4FTpnXirfFOMrw43rcSaNTJfPbZswnWYeJ8sWykEHdrOU4
	ZS+Ib2TrHuReEPFoNDWi1sclRk/AzmqVCF
X-Received: by 2002:a05:6a00:1587:b0:81f:3b74:5812 with SMTP id d2e1a72fcca58-8241c21f645mr67921b3a.31.1770137980943;
        Tue, 03 Feb 2026 08:59:40 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54fcasm21643806b3a.66.2026.02.03.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:59:39 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: pushkarkumarsingh1970@gmail.com
Subject: [PATCH v4] subtree: validate --prefix against commit in split
Date: Tue,  3 Feb 2026 16:48:16 +0000
Message-ID: <20260203164815.68258-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
References: <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
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
git cat-file instead of the working tree.

Add a test to ensure this behavior does not regress.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---

Changes since v3:
- Fix regression in existing subtree tests by checking prefix existence
  with git cat-file instead of git ls-tree -d
- Preserve original error message to keep test 17 passing

 contrib/subtree/git-subtree.sh     |  9 +++++++++
 contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..d7f9121f2f 100755
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
+	if ! git cat-file -e "$rev:$dir" 2>/dev/null
+	then
+		die "fatal: '$dir' does not exist; use 'git subtree add'"
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

