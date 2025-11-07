Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1032B991
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528012; cv=pass; b=PIU0DeDhqYE/+nBTft6yU0HSkkuZJMbQ3tpDWQJtVKmmCH67nkt3TOCe9r74iQwbL930lJlWtbd4c8qwPcKFTCa9VCF2zO1D3jeHRaeBLirU1+h+nMz3k9GjMcXYkYgHYxoZAENgvr+Qk8gq/dTG9HW4zbtaYFpCTLtbBGFkAvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528012; c=relaxed/simple;
	bh=TAufOcCoPQRLZT4abWa7F1H7K/VCXFu1kIW39fLCsIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXzwIwyCGDb1qWQaytgx1H4Tszi83BSIaW0CUukkl5sd/rSYNeaVdAGLAEaobCkNwi/U+A7yHHPk5oX/UFReElh571vbve15ybayavlVKmkmn9Cv9GFFdf8QIfaAKysX+ooQcBg7IKpAVix75I4CfPfmlBcRGEbgfOGxwvGiuwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=c7GXIeBk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="c7GXIeBk"
ARC-Seal: i=1; a=rsa-sha256; t=1762527981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dRHCRsMOfzT+ojIrHCpdfvYe88HhbCfFH41yWm+s+T5xuPxNwEAzFbOwMgF1V0w7oHltrZQbD+S7OJvStJaxmXTBbcX/M+BXENaseQs8GAVoFSqOUaDWTzXsbQ45gqJqGXlFFrNkGFyhQ8Aj+2AQP3WvwdpEtxtHNoXdTMFH5IM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762527981; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bdYcBaXWF6RY5d33R2D3Rr+o2HeG8Vf+6CIUitXG730=; 
	b=gcu8/LWOI7zqnxN4NHyus4XYIuQnp6++zX4XscIvZAS7tDdVWroBrsT7XnQHZtCAUSrr47WxipU8UPxqnVdGY+AcJ0nW/x0e1/DF2UUI5vofftdOORuqHLmWRvzBLbBMXJiSeKmdSBEshr1K+3MTLiSnvo+a2pKiZoRyHBcnuSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762527981;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bdYcBaXWF6RY5d33R2D3Rr+o2HeG8Vf+6CIUitXG730=;
	b=c7GXIeBkP68w9zDWC70jg5jJqe6OpWd5spgS3LES4sRhS7lVWV4tfgbP+FmVB0yJ
	NasFtI8nJak2dxYc/v1HgeGT/GU+bVwYzPht025Ukb+lrbN7uzdqzUOV2weKzcw6jAJ
	6AaAn9MVnZgJuGxLgVFA76l8Mz6kzuxFzeyNO6Lw=
Received: by mx.zohomail.com with SMTPS id 176252797958417.447754283963945;
	Fri, 7 Nov 2025 07:06:19 -0800 (PST)
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
Subject: [PATCH v4 1/4] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Fri,  7 Nov 2025 17:05:44 +0200
Message-ID: <20251107150547.3272180-2-adrian.ratiu@collabora.com>
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

While testing submodule gitdir path encoding, I noticed submodule--helper
is still using a hardcoded modules gitdir path leading to test failures.

Call the submodule_name_to_gitdir() helper instead, which was invented
exactly for this purpose and is already used by all the other locations
which work on gitdirs.

Also narrow the scope of the submod_gitdir_path variable which is not
used anymore in the updated "else" branch.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fcd73abe53..2873b2780e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3187,13 +3187,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 
 static int add_submodule(const struct add_data *add_data)
 {
-	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
+		char *submod_gitdir_path;
 		struct strbuf sm_path = STRBUF_INIT;
 		strbuf_addstr(&sm_path, add_data->sm_path);
 		submod_gitdir_path = xstrfmt("%s/.git", add_data->sm_path);
@@ -3207,10 +3207,11 @@ static int add_submodule(const struct add_data *add_data)
 		free(submod_gitdir_path);
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf submod_gitdir = STRBUF_INIT;
 
-		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
+		submodule_name_to_gitdir(&submod_gitdir, the_repository, add_data->sm_name);
 
-		if (is_directory(submod_gitdir_path)) {
+		if (is_directory(submod_gitdir.buf)) {
 			if (!add_data->force) {
 				struct strbuf msg = STRBUF_INIT;
 				char *die_msg;
@@ -3219,8 +3220,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3238,7 +3239,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.51.0

