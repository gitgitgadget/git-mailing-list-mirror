Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525928640F
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187022; cv=none; b=O/LM9Oq46dA+0P8CoyC0fXQPvXS5IgUv2taLR9fol3MO389+4x8DcppgYu4pZFZOohixiidj2sZsVe97ls3dlUjJTFIhZU8SUmpCPi/9VJgKNcpE+j2Dq39Yl2Alfpah6PjySI7OGrfgp89169/CO6XxteNUnqyPBPNWFWUKQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187022; c=relaxed/simple;
	bh=y5rEj9lYeQ+5lud0Ew/cQXlsiw4Zf7KvNSFSTx3C9Wc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pjjRn1S4kQKLBQ62/iVNcJmQdIxJi373xqmlAjLJ/e/VL9o+coXpwtXzqZf00Qh9ngwXavj2iGvt03GnwoeTrgYmngkju5oRZZYINeFbOs8LWvSl1Fjzl1+LkNc47pF+/pTyyy6UgaaVdHJ9D3BLmu0Q6VJmaZ7Gj/78x3JQrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzyy9uCo; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzyy9uCo"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1248d27f2b9so3237705c88.0
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 12:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771187020; x=1771791820; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVHMdap0H8f63gX8SnbgBB5k6tvOgcNvjwE74zT+qiA=;
        b=hzyy9uCocPgO5qpFIuOQ39/7pTfl5VomDZIMqC6KOreMfpilA3wgx08PwlSJQoMiWk
         CEhVcK53TX1FSlsCCXTQG4UjFEJxu4IgZShMpUUQEg8VNpJ6tIPTYiLgU517B2+2gkpB
         xPCNTMMX7bAJ4PBdEZtBw38bGBW51iKVnIpGXmhw8bJR9IEkU/yuMW+pY5sYSBovpp7r
         It+AbQhS/5IUcI9mZH4HV4pZb0s+M4yCfk/Mhggmktwle5PJYWDJWZLIs4wMx7nU2+Dk
         tKOl7pVwZvvgHAhR5hOqn/xWQuFoSNtsm7eA/AhDOCcfoy05lrhtOB9h1EGaitNQXaW7
         VPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771187020; x=1771791820;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVHMdap0H8f63gX8SnbgBB5k6tvOgcNvjwE74zT+qiA=;
        b=BA9HxPNA/VELFnqXWeIPYG01YYwbPI8AYnIC97PxEbrzetUh4mJ3u3lhZIaUpEoNh4
         3tjFUT/uzBy7lvOT6BOyhq7dPW+F3P3lMl/mXNFsmC2H0co4fcRqUTw1fT5ACKG/U8dF
         qzrCdb9CG3pl2+QW/pA7is0ycNQbVcbtY47bdGByvlnxO2mMA5Rjsn84JCZ0/EpwUyff
         YYc01VAKc4qCjd6yu2O2TZUcZ9fJh0jcvCj3r+7lrYDUmHfwNFnxw7Y2XNomY8mkJU/7
         Z4q/JxlfTpVKB7PCeVjDi631NAG75VukFudYpNE1Fe8hO2X3mFijAfyCHpLyl05EFocM
         fWUg==
X-Gm-Message-State: AOJu0YwnnFizgt5kYALZXGNxS/jQ67pMqiEgzgfYDdYmkmR82IfywOj1
	+9CV8Zq80mVxsbFhfNLRjxPczEUp3VwxdbVuWdOpy5LEMfsRYYdob4BOarWCWA==
X-Gm-Gg: AZuq6aJrcQ+I2uoGhwILs4Fff6NfPhpkEnuSsjKevGG6SONc99jO/6zQXEn59bYismY
	H6/fIfdYA2x1PQb6+FvGwvUpF1TqV7/UU0J6pyBusa8kaU5S8z9Q8jsHhYt09E2ZOXu93NWl+CV
	uUc55UprVmH//u3+o9JmJF2nrU1ImKQSZdOsFCD8WU4vT3JIZN54NpGEO1EXpq6iqX1ZPP+RVVp
	+93EKbUZTIFtW7Vsvchsttyfm/hEEiCMbGvsFVh5qBeUbIs7bGDkSsxmFRvgGo1fYmJ3/IDl4Z/
	HTZ0lb62vCcRVhRxji1wUvYEZy8u6QYjISSA7gTmvKlNZGnYR7BCWfGxwC8ByH9Y6cCCXPW4oOZ
	xu9XTCOFza+sZNO5JBDsVSMYuvo1j5mIZoXgjuVnbQqAs0qibCFm4sMghCFhAoLmfIagYt9Thc3
	Kf1IMsNzdEh8tA2qAE/EH4LKE4OI0=
X-Received: by 2002:a05:7300:7fa5:b0:2ba:7617:eeb1 with SMTP id 5a478bee46e88-2baba04c674mr2957673eec.12.1771187020074;
        Sun, 15 Feb 2026 12:23:40 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66bb08sm6790254eec.26.2026.02.15.12.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:23:39 -0800 (PST)
Message-Id: <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
From: "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Feb 2026 20:23:36 +0000
Subject: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
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
Cc: Orgad Shaneh <orgads@gmail.com>,
    Orgad Shaneh <orgad.shaneh@audiocodes.com>

From: Orgad Shaneh <orgad.shaneh@audiocodes.com>

This was documented but not implemented.

In the flag description:
prune local tags no longer on remote *and clobber changed tags*

In the documentation:
... to prune local tags that don't exist on the remote, *and
force-update those tags that differ*.

Signed-off-by: Orgad Shaneh <orgad.shaneh@audiocodes.com>
---
 builtin/fetch.c       |  2 +-
 t/t5516-fetch-push.sh | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a3bc7e9380..c212f50b86 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -981,7 +981,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		struct ref_update_display_info *info;
 
-		if (force || ref->force) {
+		if (force || ref->force || prune_tags) {
 			int r;
 
 			r = s_update_ref("updating tag", ref, transaction, 0);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 31df7faf56..4d29043baf 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1092,7 +1092,7 @@ test_force_fetch_tag () {
 	tag_type_description=$1
 	tag_args=$2
 
-	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
+	test_expect_success "fetch will not clobber an existing $tag_type_description without --force or --prune-tags" "
 		mk_test testrepo heads/main &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
@@ -1108,7 +1108,13 @@ test_force_fetch_tag () {
 			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*' &&
 			git tag $tag_args testTag HEAD^ &&
 			test_must_fail git -C ../child1 fetch origin tag testTag &&
-			git -C ../child1 fetch --force origin tag testTag
+			git -C ../child1 fetch --force origin tag testTag &&
+			git tag $tag_args testTag HEAD &&
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 fetch --prune-tags origin tag testTag &&
+			git tag $tag_args testTag HEAD^ &&
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 -c fetch.prunetags=true fetch origin tag testTag
 		)
 	"
 }
-- 
gitgitgadget
