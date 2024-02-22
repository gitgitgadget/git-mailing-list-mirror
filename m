Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230B146905
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608123; cv=none; b=jmIDXUAgh4ZG46O6zlRYBNEIsEI93OjoUguEwUuqntiBOSfaHLl7dfkMlVn3t8ZjFrY3b5axC4nRcSL6vEqNX5y5B6JQfTdwTcnyfuq99gp2jMR3wYC1LaCxuQv3dHXJvCYmKWkbx73aAKVhFxcCRYaNe3CDj6DH4/Qqaogg448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608123; c=relaxed/simple;
	bh=PUvI8mflEWOq2BwZiRa/nQDGYx9iFMV5Pd34ga33pGg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dyOqGSJW7Chmsqo15DAnUUEsKuHK4Fp+mjcsAhVVJoA0DNDbVwmEIobNju7XOQlCYkomrcaYEqacFTPZHd3pha5zsES1ugouObV/y5Hc/IrUiTmmJIZGWf+mtpMUufwWiIqc3H2bUVYOAbFk/ZCp19tmNPORzW0SO0tD57RJlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpyxXjkn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpyxXjkn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41276a43dc3so12213875e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608119; x=1709212919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls2gfG7/KzRPf3br5sgCg2MiCtFeXyjXvkeYAyegKIQ=;
        b=RpyxXjkn3etrz6uixp1luorDXxJYmXVaOAMnuwmd3+kgKygoJPQd5nTZ9Q2ahZuyCR
         wIRhT3eulBZNLA0THp4wZHpTV5r4v4HubnkovKEj/AkO1daaDE96N9lTMKLyIFZS9MlS
         l7BRy9jjlb/u/w2V9Aiqgrj+UDOhm9pV5f2K5zD/ErD8R3mCpZ5ll9ztyvcT5LeUjOyN
         kOA5CXlJGb9I2IxFJEJMj+ZHTHFVhf7S/HI96KD60NYk0iTwfEALAHdjiJ9kyzbl83K2
         K5dmBMa0Hgr5Zs0t3/cHgQJHVpIIr389Zics+yzTCg0HAozCBw5yhUI0zvmi/KQLjnvU
         4EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608119; x=1709212919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls2gfG7/KzRPf3br5sgCg2MiCtFeXyjXvkeYAyegKIQ=;
        b=Y703NIUHC8fvO9LMoGIl793gHZt1+1kdlCdOdlJ88UVpZguyaM4vVSVFGdJZN4Yukp
         PveLnGmxCp+g1W/DDW2A+8Kkn3Y+UOVx140fEIWvAEM6166NCdkRKhckEhrCe6UXzcU+
         6tZjgTYeUG81KuMD8fBkYkE3NglXgAz2JHm2N9Im/q7AGCln4R6/6xB8B9VneyEfwMwD
         4bDQrqWtMm3pQsjDEWMMWaqhUxXZAUnMRz4ZjxNo6T5gVzPlhzLuCnL14s+MUorEnYKR
         tC9cp6LEV57qfF0V+YmYt8MibUhO5rPDMftj9+5JBX+x45X9W2AQPEq74WUa5bXu7EBW
         jCVA==
X-Gm-Message-State: AOJu0YzNUoW9XcGWKHhWqbJ+Qqhs5WSyhchEj7UyGtzVtsnJxG6EJjVA
	a+nRKx/wUgwTVGTx57jCfgOyAEXuXgmIjnZwlg5VQ0a83m6SUI6XA4M78JTT
X-Google-Smtp-Source: AGHT+IGvonwbV5y48Uty4lVdTlXQFQUr3+H+Zt8Cm8vZcKGYwoxFsJmqcsEErp41lZ0YAOZozMELDw==
X-Received: by 2002:a05:600c:1387:b0:40f:e284:d785 with SMTP id u7-20020a05600c138700b0040fe284d785mr17633763wmf.23.1708608119279;
        Thu, 22 Feb 2024 05:21:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b0040fe4b733f4sm6041221wmc.26.2024.02.22.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:58 -0800 (PST)
Message-ID: <05756fbf71a2ff4932fb2c140659d07a87db25ee.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:45 +0000
Subject: [PATCH v2 06/11] merge_bases_many(): pass on errors from
 `paint_down_to_common()`
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `paint_down_to_common()` function was just taught to indicate
parsing errors, and now the `merge_bases_many()` function is aware of
that, too.

One tricky aspect is that `merge_bases_many()` parses commits of its
own, but wants to gracefully handle the scenario where NULL is passed as
a merge head, returning the empty list of merge bases. The way this was
handled involved calling `repo_parse_commit(NULL)` and relying on it to
return an error. This has to be done differently now so that we can
handle missing commits correctly by producing a fatal error.

Next step: adjust the caller of `merge_bases_many()`:
`get_merge_bases_many_0()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9148a7dcbc0..2c74583c8e0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -131,41 +131,49 @@ static int paint_down_to_common(struct repository *r,
 	return 0;
 }
 
-static struct commit_list *merge_bases_many(struct repository *r,
-					    struct commit *one, int n,
-					    struct commit **twos)
+static int merge_bases_many(struct repository *r,
+			    struct commit *one, int n,
+			    struct commit **twos,
+			    struct commit_list **result)
 {
 	struct commit_list *list = NULL;
-	struct commit_list *result = NULL;
 	int i;
 
 	for (i = 0; i < n; i++) {
-		if (one == twos[i])
+		if (one == twos[i]) {
 			/*
 			 * We do not mark this even with RESULT so we do not
 			 * have to clean it up.
 			 */
-			return commit_list_insert(one, &result);
+			*result = commit_list_insert(one, result);
+			return 0;
+		}
 	}
 
+	if (!one)
+		return 0;
 	if (repo_parse_commit(r, one))
-		return NULL;
+		return error(_("could not parse commit %s"),
+			     oid_to_hex(&one->object.oid));
 	for (i = 0; i < n; i++) {
+		if (!twos[i])
+			return 0;
 		if (repo_parse_commit(r, twos[i]))
-			return NULL;
+			return error(_("could not parse commit %s"),
+				     oid_to_hex(&twos[i]->object.oid));
 	}
 
 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
 		free_commit_list(list);
-		return NULL;
+		return -1;
 	}
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
 		if (!(commit->object.flags & STALE))
-			commit_list_insert_by_date(commit, &result);
+			commit_list_insert_by_date(commit, result);
 	}
-	return result;
+	return 0;
 }
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
@@ -410,10 +418,11 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 {
 	struct commit_list *list;
 	struct commit **rslt;
-	struct commit_list *result;
+	struct commit_list *result = NULL;
 	int cnt, i;
 
-	result = merge_bases_many(r, one, n, twos);
+	if (merge_bases_many(r, one, n, twos, &result) < 0)
+		return NULL;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
gitgitgadget

