Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86711327214
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528013; cv=pass; b=H6YfMt/1270QNubwJFORztM6+C8m4WkRGls8f+9rU97flf4NmMp2473Y5ZVzflB4qpN0aMJGnGftZPwfuBLzi0Cx9yx5y03q01feFQ0HugXd2QmkycJAt5V+7z+GC0C5sKjMiHsj2ikn4jvuebZRwG98afGwee0jv+3nvya4SWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528013; c=relaxed/simple;
	bh=isQFpDh8PeVrYxJdmk6DL9IjMdYu64KGPdHj6ojrwtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJwiHN41QebEkXZIIWnD2lMfzQDcrAMeTGzy7/Gkb9YGJVBy1SFWQQJBlYBSAy0tHolLvLGUJFWS5DJIzqgSSKRNqCp0BsPhdOyCurH3LQpqVCIQ8YvMNEUGhfto+ndOP6LJPYYLUYKA0cBEwm6tZvMgSmQF/1djrzC9lv9FwBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=TYXWhYpz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="TYXWhYpz"
ARC-Seal: i=1; a=rsa-sha256; t=1762527993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FyoBO9iW6RMWZ597rcnyhUGJ3zput17PUxV8L+ckucDugYsrQOZk7IXElMiyYHU6EDnLv4d22v/wKU+3JQ2RpIiX8uYk6yFf/y/J/H9HQKyGYlnGG7eMM4v1No93Hga1/xOu8Omt3C4zFtgum4t6dPt6RwapEpa8hUQCVXhQ3IA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762527993; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0jUmVtNEfVsuiDZQz2swenJCklF9Qot/fpEQNKhMoXQ=; 
	b=OfGVAzi1czC4dzwkLUEJzCs9fBs0lnLdZCiU0yqVUxJdv51tzwC+GrXAZNnmLkh9f+XzR+KuTB0fZoTYrExCQ8wdc3qqkGOXpuPCE+3V4RjTjrdwa1s/wfahWzfhYXJ+yJ3I70fxLAI/EYHXhliCBmUdt8aQnX7TRw/+946k/Wc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762527993;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0jUmVtNEfVsuiDZQz2swenJCklF9Qot/fpEQNKhMoXQ=;
	b=TYXWhYpz7y1uIRHppThXiZhB9YFpDC17Mau/Hik+PbLgnrnmP+wWNNL4ko7OSxcR
	RFgilnuMUHm0QZQGgat8HByhca7amZ7zcTBHx+qys6bUY99nKezFLKWSOS4kWmcXYhj
	f1+Nu9vWgoUJ3sjTj/Nrxlxhv0Z3bg+U0ZDUTGMY=
Received: by mx.zohomail.com with SMTPS id 1762527990621571.8269921605121;
	Fri, 7 Nov 2025 07:06:30 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem colisions
Date: Fri,  7 Nov 2025 17:05:47 +0200
Message-ID: <20251107150547.3272180-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107150547.3272180-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new check in validate_submodule_git_dir() to detect and
prevent case-folding filesystem colisions. When this new check
is triggered, a stricter casefolding aware URI encoding is used
to percent-encode uppercase characters, e.g. Foo becomes %46oo.

By using this check/retry mechanism the uppercase encoding is
only applied when necessary, so case-sensitive filesystems are
not affected.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                   | 47 +++++++++++++++++++++++++++++++++--
 t/t7425-submodule-encoding.sh | 15 +++++++++++
 url.c                         | 12 +++++++++
 url.h                         |  1 +
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index ceaff0c1aa..ecbffac2c6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2280,7 +2280,7 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
 	char *p = git_dir + len - suffix_len;
 	bool suffixes_match = !strcmp(p, submodule_name);
-	int ret = 0;
+	int ret = 0, config_ignorecase = 0;
 
 	/*
 	 * We prevent the contents of sibling submodules' git directories to
@@ -2318,6 +2318,42 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 	if (p && strchr(p, '/') != NULL)
 		return error("submodule gitdir name '%s' contains unexpected '/'", p);
 
+	/* Prevent conflicts on case-folding filesystems */
+	repo_config_get_bool(the_repository, "core.ignorecase", &config_ignorecase);
+	if (ignore_case || config_ignorecase) {
+		char *lower_gitdir = xstrdup(git_dir);
+		char *module_name = find_last_submodule_name(lower_gitdir);
+
+		if (module_name) {
+			for (p = module_name; *p; p++)
+				*p = tolower(*p);
+
+			/*
+			 * If lower path is different and already exists, check for collision.
+			 * Intentionally double-check to eliminate false-positives.
+			 */
+			if (strcmp(lower_gitdir, git_dir) && is_git_directory(lower_gitdir)) {
+				char *canonical = real_pathdup(git_dir, 0);
+				if (canonical) {
+					struct strbuf norm_git_dir = STRBUF_INIT;
+					strbuf_addstr(&norm_git_dir, git_dir);
+					strbuf_normalize_path(&norm_git_dir);
+
+					if (strcmp(canonical, norm_git_dir.buf))
+						ret = error(_("submodule git dir '%s' "
+							      "collides with '%s'"),
+							    canonical, norm_git_dir.buf);
+
+					strbuf_release(&norm_git_dir);
+					FREE_AND_NULL(canonical);
+				}
+			}
+		}
+
+		FREE_AND_NULL(lower_gitdir);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -2653,13 +2689,20 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
 		return;
 
-	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
+	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
 	strbuf_reset(buf);
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
 	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
 		return;
 
+	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
+	strbuf_reset(buf);
+	repo_git_path_append(r, buf, "modules/");
+	strbuf_addstr_urlencode(buf, submodule_name, is_casefolding_rfc3986_unreserved);
+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+		return;
+
 	/* Case 3: error out */
 	die(_("Cannot construct a valid gitdir path for submodule '%s': "
 	      "please set a unique git config for 'submodule.%s.gitdir'."),
diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
index a42d358f5b..f92b3e6338 100755
--- a/t/t7425-submodule-encoding.sh
+++ b/t/t7425-submodule-encoding.sh
@@ -143,4 +143,19 @@ test_expect_success 'submodule git dir nesting detection must work with parallel
 	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks
 '
 
+test_expect_success 'verify case-folding conflict is correctly encoded' '
+	git clone -c extensions.submoduleEncoding=true -c core.ignoreCase=true main cloned-folding &&
+	(
+		cd cloned-folding &&
+
+		git submodule add ../new-sub "folding" &&
+		test_commit lowercase &&
+
+		git submodule add ../new-sub "FoldinG" &&
+		test_commit uppercase
+	) &&
+	verify_submodule_gitdir_path cloned-folding "folding" "modules/folding" &&
+	verify_submodule_gitdir_path cloned-folding "FoldinG" "modules/%46oldin%47"
+'
+
 test_done
diff --git a/url.c b/url.c
index 0fb1859b28..057e6e5c6e 100644
--- a/url.c
+++ b/url.c
@@ -14,6 +14,18 @@ int is_rfc3986_unreserved(char ch)
 		ch == '-' || ch == '_' || ch == '.' || ch == '~';
 }
 
+/*
+ * This is a variant of is_rfc3986_unreserved() that treats uppercase
+ * letters as "reserved". This forces them to be percent-encoded, allowing
+ * 'Foo' (%46oo) and 'foo' (foo) to be distinct on case-folding filesystems.
+ */
+int is_casefolding_rfc3986_unreserved(char c)
+{
+	return (c >= 'a' && c <= 'z') ||
+	       (c >= '0' && c <= '9') ||
+	       c == '-' || c == '.' || c == '_' || c == '~';
+}
+
 int is_urlschemechar(int first_flag, int ch)
 {
 	/*
diff --git a/url.h b/url.h
index 131a262066..92e3c63514 100644
--- a/url.h
+++ b/url.h
@@ -22,5 +22,6 @@ void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
 int is_rfc3986_unreserved(char ch);
+int is_casefolding_rfc3986_unreserved(char c);
 
 #endif /* URL_H */
-- 
2.51.0

