Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C793AA50C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149343; cv=none; b=b2AEamrcLKh320oo2pPIqemT9zmwVRA8XZvAq2k+KiaikvO2ODsdgAjUnf0xYx2EmKt+wk5AIGnqsXnSXDuhBakSvr3DtFM6NBsAfMY4cmGRPMxy1wWo688tjvw+TfeJUmuev7m4IKljTyCxPnJckCUkAxPDBOrsJzn31KlCiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149343; c=relaxed/simple;
	bh=N4bl45+ugHBhJTK8b1LEjbjDMqTcTFmnyc9du+YCtG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p66tXP/19V6SXumyUQ2efdt1Z4Wqx3bpcsLVGUK4kKy7LKnO2H+jUZKlYZ3nOlUY0dNkBLIbr5gnKBJoZWNbtwG+UVaQkC/XNQ9ExCFTr4fOR1StFTRItZ+dP/0s9yii/LJwNvmNLO919VYSRlXuMQEaAu/18uvldb1HYgRt6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUk96dcg; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUk96dcg"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12713e56abdso7707794c88.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149341; x=1773754141; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=SUk96dcgJdGBK3zWzOsZkh9W9S7ayeMy9BpDeGCb1SK8MDIFbEVHOcjocz3OtU+TjS
         Ct7fABEyK8y89O2QafpucShBVR8LCHXz1yAOMVKqnc17L0XhSdXSb1y8QmR7RGzVuVUr
         56WrOgjP7uMy4B1ZY5+sfwSekc7WsW3ZH+EuDAcRyAEN58mNWSLiBgcYyFsARqIQuhq7
         yUIgesQ08WEh+HT+yRANDPPXNVMwy4St5WQwjHE9zDsWxevGRKFVLjmkqmAb5Gk4zS9b
         EoFNplyWorG1gsL5SUqnv8A1BM6R0A2JN2VskW8RbpvN9ksHv8e2Yr9/XUlGFd1yzISN
         WWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149341; x=1773754141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=YVpSipETqmTl8LTb0GNW4REkitcYIgbhtsBCXwQdg7kbqndw9Uej/hnGJydRaABeur
         8oWiPjSNw4cAsR5Vi9Udf+4RsQ97ftJtdmG+p0TEFlCWCXCuCEE7+qQfBRwaxasWQ31C
         dBqsJ03jUlhybi+O3UKPuXiI43IUIcbGU1OJEmklBn7hPv/E+65Y33nk7HYdywx1sFwY
         ovbPC5DWaQ2j5lK+91PvaQgq47oPaaBmsRUEFJwBFxMbLgCOnZ5CBqd2yiqeS2aBmlDJ
         JsvRyCK7k/07BlUBrELtK8XyooW4xEWGjsXnjPSazLkaD1tByQbcp6z7VQ9iCAKfFcAL
         uXgQ==
X-Gm-Message-State: AOJu0YyZ/r+B66q5cZKLLLEmpJlfieODFy42TXi2H3sKKJfU3F0XPpO7
	6FrVZc+4vtO+VjTSWDL294F7BAXi7JBvzSuqCW3QqdiL1/pF3CoHw7DXThugpA==
X-Gm-Gg: ATEYQzx3IZmCfagPxLEAIZVjaIV7ldb/jAAkL0eNPEc2Kml43lr114VTFZr/8pceNwa
	PfEg26Q464ixtBWYhOmYnCslVor275oAK8xdjxPedWA53ouZ5rpuMlHPyasXjlS7NXj1cNXDhbC
	q+LRtLqOhHdJJ8GISQCl9TagCdro627adz8piSU4eq4NHWdzlvNLjGTSCF+3ctgr7EFqmJ++EhK
	M0jtnd1ScWDna3LwS9mS5izrTaUJJW2XBrubwJF8V/jO6kMSxLM39Y+Nn46+hs6n4vGPlbC4Ioo
	JpTeysaiCw4hkKpYkWUdIAoN4IzsaoA3/s4G7zSnb1dteeaJSGBRTaW9pB0i0+9kjzKHbDotvbO
	UrBm5TREaNxfGu69Fx6XoOwitLovqoV4kgHPeo4EfdaP2RpLFOdQlRDvWLz2o1DEr8MHKe1cK8/
	cepQQfSUeFBrUAVedNnqDt/94QmQI=
X-Received: by 2002:a05:7022:1282:b0:128:b534:bd04 with SMTP id a92af1059eb24-128dde1f3edmr1508288c88.5.1773149340982;
        Tue, 10 Mar 2026 06:29:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d5aa8f5esm10145387c88.6.2026.03.10.06.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:29:00 -0700 (PDT)
Message-Id: <eb5639dbc3571fde15f2d93cf2d137b8df775d2f.1773149337.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
References: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
	<pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 13:28:56 +0000
Subject: [PATCH v3 1/2] advice: add stashBeforeCheckout advice for dirty
 branch switches
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
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
when they attempt to switch branches with local modifications that
would be overwritten by the operation.

This includes:
> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> Corresponding "stashBeforeCheckout" entry in advice_setting[]
> New advise_on_checkout_dirty_files() function that lists the
  affected files and suggests using git stash push/pop
> Documentation entry in Documentation/config/advice.txt

The advice follows existing patterns established by
advise_on_updating_sparse_paths() and can be silenced with:

  git config set advice.stashBeforeCheckout false

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 Documentation/config/advice.adoc |  5 +++++
 advice.c                         | 27 +++++++++++++++++++++++++++
 advice.h                         |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..8752e05636 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -126,6 +126,11 @@ all advice messages.
 		Shown when a sparse index is expanded to a full index, which is likely
 		due to an unexpected set of files existing outside of the
 		sparse-checkout.
+	stashBeforeCheckout::
+		Shown when the user attempts to switch branches but has
+		local modifications that would be overwritten by the
+		operation, to suggest using linkgit:git-stash[1] to
+		save changes before switching.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index 0018501b7b..e1264f525c 100644
--- a/advice.c
+++ b/advice.c
@@ -81,6 +81,7 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
+	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
@@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
 			    "* Use \"git add --sparse <paths>\" to update the index\n"
 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
 }
+
+void advise_on_checkout_dirty_files(struct string_list *file_list)
+{
+    struct string_list_item *item;
+
+    if (!file_list->nr)
+	return;
+
+    fprintf(stderr, _("The following files have local modifications that would\n"
+		      "be overwritten by switching branches:\n"));
+    for_each_string_list_item(item, file_list)
+	fprintf(stderr, "\t%s\n", item->string);
+
+    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
+		      _("You can save your local changes before switching by running:\n"
+			"\n"
+			"\tgit stash push\n"
+			"\n"
+			"Then restore them after switching with:\n"
+			"\n"
+			"\tgit stash pop\n"
+			"\n"
+			"Or to discard your local changes, use:\n"
+			"\n"
+			"\tgit checkout -- <file>"));
+}
diff --git a/advice.h b/advice.h
index 8def280688..c035b5d8e3 100644
--- a/advice.h
+++ b/advice.h
@@ -48,6 +48,7 @@ enum advice_type {
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
+	ADVICE_STASH_BEFORE_CHECKOUT,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
@@ -83,5 +84,6 @@ void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
+void advise_on_checkout_dirty_files(struct string_list *file_list);
 
 #endif /* ADVICE_H */
-- 
gitgitgadget

