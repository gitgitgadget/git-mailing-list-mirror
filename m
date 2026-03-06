Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B8386C1B
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802879; cv=none; b=DSF89M4a/vWRR44Y3+ODChfLMxQdG7swTdjEGi3V6mIhFfINoSGNqtOksk2siF0oie30Q6lTwBb3IJ6bAqoz5jYjeIO1AfD2jShCaYYRAYsS+glSt6jCBnpqgPFH0bZFwU0BYQclfBtn+TjzdnbS3h6AtaybqLptE/Rz9yiH5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802879; c=relaxed/simple;
	bh=bJXlbMgoPJF793ZlSZRJmvi1OR/P/EjV4WeprcObcvY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m+yANxOzOIevRi0wDY9Bb1zHbjImHUf1fduxJplWkvBmgMg+OA3Elud9IPeOZ0rQhxTFYE4WvhtrYTh/SdPXV8AT3d2x4HXfkjaN4JwFud2RFpJGAVhysgvgpqVVvVSrnCp4n2tmdT9BQ6QhU0erVM/NZALxUHXaBIwsPbjQKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn1UTKRu; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn1UTKRu"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba895adfeaso8035606eec.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772802877; x=1773407677; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25E520+5q9uUJnBEiFA37I2c5EMJ903vOkJPxzEUJSI=;
        b=Wn1UTKRu0AXXbFs6S2xXM+3HMEkmeke1rNcMZuq8qgyptcIqt8lXg6K7AnZhXX8Muz
         38+d6RwPJ83AlPFFZvcpoFK+2jZUfBlAoC/lAdSa23NQQU2s+fzTCFpjvGkE1eYLicfw
         gtC6XyTwUni89cUj/R8zUsZUjrA9HyHXbpToBOAamuXqo4Qp5rDGJ/FYhFF3MQCv/utt
         KdaNtDUk9pnbw7NG5aWzoq6fBJVv0ieJybTIZ+66ZGT/Ok5i1yY9yxI/Sr6CXkWuFslN
         tt6mhFYlvZOrTLOVDtH4tBoRliTsYIfqORMwyEbFD5cktN8YGeOzzijo9xoXHI2f0XwK
         9Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802877; x=1773407677;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25E520+5q9uUJnBEiFA37I2c5EMJ903vOkJPxzEUJSI=;
        b=TqQ/7jPOV+izntykhLixk2M3syW7HM/Tec8f7+XajwTL8WjDEUFf5KF75Ra6joLn41
         xOvWzjcJ9R5ZP8pxDksTmQ4Y40oFK+XyvTnCFcjQIDR3nRnQOxhKpzqo5/NDvOMA2ZUz
         hAnyyIjFveFxtzA9Ax3EKrHUaGksJe1KDDGTAYhwndEQk6pj/h+ZtRabuf+R63ApGBU8
         nWdTkiITZm/E7ooBUDDW2q3rUxhgIXrYxnBO3KC8RWsJ4Ve4PpX1nrioCGzezrNOAuZM
         j748UoAYDX+1BNjZAcYl+jIH/XVCXrjG2YOF7njzSFRoArZD39112pj4fB7BNZLIJNYo
         JNIA==
X-Gm-Message-State: AOJu0YwotNzc1du6YxIteBily1H04KJOmQIHFU0aP1yQA5EsYcIYbYoh
	x6TpzKFnaGGNSApOXO5eIAmy305MnSYBd4m/d6dZxG0y3g5w5noMFoWkPCdp4w==
X-Gm-Gg: ATEYQzz4onFKttdml8hvLwDol2ELDPMHWlB8vtPDgX6iRDznUiOCacWiTJoSR2icMm/
	Va+kHtvNt69wKQruo/2kpmXdFl6uwo0aXoOWdlKjqAtsbFVJ+NtQOaOj0qrkwESWf5DbGjVQI+4
	lICyxlfPr0fKphjjKRgY5WyvYLjFa2dS9NK/wlDi319X7uVgBWBK46lNtjkHH+Ena+0tD623Ra9
	54jmAfP25slH06dbUFkrqMJbB5RN81XDaUFe+Xn+AoLURTtgqs4aeBGeOpGZzivHMULH/X+EOwN
	5emyXnBND9JvajK3aiBOCoUmdS/q2SvMVdYzolhvcvrrauu7n41Jg9cSuitIGFrA89f2tmQtXdd
	8KiXeciuzRzsh/WVjtrq/1W0uf1yG6WwP4+HYFlNVjmzWhvLJ7ds4Ijg1rAvezr75YMccqYGatr
	09d9MUt3z/g54XKk2PEGpoBO8d5Q==
X-Received: by 2002:a05:693c:2b0a:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2be4e02748bmr761110eec.20.1772802876875;
        Fri, 06 Mar 2026 05:14:36 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82bc72sm1118067eec.13.2026.03.06.05.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:14:36 -0800 (PST)
Message-Id: <d51f71708ceb0263c8e10b6d7915f7a426c88f2e.1772802872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 13:14:31 +0000
Subject: [PATCH v3 2/3] branch: add 'branch.namePrefix' config param
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a new configuration parameter for the branch creation
feature: 'branch.namePrefix'. It corresponds to the '--name-prefix'
option of 'git branch' made as configuration parameter, and behaves
exactly like it.

Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 Documentation/config/branch.adoc |  5 +++++
 branch.c                         | 18 +++++++++++-------
 t/t3200-branch.sh                | 12 ++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..202c9048b4 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -35,6 +35,11 @@ This option defaults to `never`.
 	value of this variable will be used as the default.
 	See linkgit:git-for-each-ref[1] field names for valid values.
 
+`branch.namePrefix`::
+	When a new branch is created with `git branch`, use the provided value as
+	prefix for its name. Can be '@{current}' to use the current branch's name
+	as prefix.
+
 `branch.<name>.remote`::
 	When on branch _<name>_, it tells `git fetch` and `git push`
 	which remote to fetch from or push to.  The remote to push to
diff --git a/branch.c b/branch.c
index c24d7ce823..5fb7280d47 100644
--- a/branch.c
+++ b/branch.c
@@ -368,18 +368,22 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 void add_branch_prefix(const char *name_prefix,
 					   const char *current_branch, struct strbuf *buf)
 {
-	int value = 0;
+	char *config_prefix = NULL;
 
-	if (!name_prefix)
-		return;
+	if (!name_prefix) {
+		if (repo_config_get_string(the_repository, "branch.namePrefix",
+								   &config_prefix))
+			return;
 
-	if (name_prefix[0] != '@') {
-		strbuf_addstr(buf, name_prefix);
-		return;
+		name_prefix = config_prefix;
 	}
 
-	if (strcmp(name_prefix, "@{current}") == 0)
+	if (name_prefix[0] != '@')
+		strbuf_addstr(buf, name_prefix);
+	else if (strcmp(name_prefix, "@{current}") == 0)
 		strbuf_addstr(buf, current_branch);
+
+    free(config_prefix);
 }
 
 /*
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 550989a2bb..847a8355cf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1734,4 +1734,16 @@ test_expect_success 'create branch with --name-prefix' '
 	git branch -D blob-with-prefix-with-prefix
 '
 
+test_expect_success 'create branch with config prefix' '
+	test_config branch.namePrefix blob &&
+	git branch -- -with-prefix &&
+	test_must_fail git branch -- -with-prefix &&
+	test_config branch.namePrefix "@{current}" &&
+	git checkout main &&
+	git branch -- -with-prefix &&
+	test_ref_exists refs/heads/blob-with-prefix &&
+	test_ref_exists refs/heads/main-with-prefix &&
+	git branch -D blob-with-prefix main-with-prefix
+'
+
 test_done
-- 
gitgitgadget

