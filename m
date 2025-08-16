Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A0226541
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380256; cv=pass; b=I88IBoLRNIS2wJOsTWK3o2inrnd3OxEUQW6ikvYMrzw7bq2DB1XmIbLtw4iyKhh7XHeohMVHhGLtDwozym89YwdDRvHNDsDPFI9qJwnxmrXGJ/9Yl81UD30q/6vO7mmzlmAbom+pZI31FfnPGXrFPqZ9xwjAjorLhCgfVBKOIjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380256; c=relaxed/simple;
	bh=vz0KpiDEa0o2gxWRNHnYMfn2Cj/+3vKX1VmAtZIkOh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muhONmPU4Yvy122SpHw2NKXuNbrdMM5X/lGz6ttYm1fDHRCQG+nMstr3h6j3bD2Zx8/CH+Fd+GveWCmsYSjcWcHYNaN0k6ZqlU8Le8vsM9n0Ar2tBn8RjVTAkIvKpmBgzQsVX+lJ5RpHrwUga1pjTS2WX4rP9RodKYhy+uLhcks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Atv8cCAj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Atv8cCAj"
ARC-Seal: i=1; a=rsa-sha256; t=1755380236; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YF8daVLJPW9oStu1KKyl0VFShxFqVQYpbZjeFrDIMjm7Kecw9nJxXsEBl+s8dBj+RIkOHI4vxc0Z02PUxgrcniP82gGXIBjxURpSQORQ3Aevxdi5jpWndHhP1oAmEU4K+8jlHsvLg02+Len/ArN6fj28d/DFo3xsJW00VtePg0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380236; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u4bzb6oeATlVb1LABuagw2iFNZhW6lIxZRh+akuaKLo=; 
	b=IlkiDIxvBBkOUysMa4uChHoZ/ou37WEhKNUvwkpoOnqeUBE2aO26QHHTHZqYfZZIb4+7SJjbZz1YVmazurB7xyYfqd64MoUnELYcrI22tH+nzxEIg9MX4B7WCjUWT86FNsPoGkJeSo7kgC/3F7LNE3a0w/DTfHhScWtepnchNz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380236;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u4bzb6oeATlVb1LABuagw2iFNZhW6lIxZRh+akuaKLo=;
	b=Atv8cCAjZFumbWx56HViIX/kITdOHptCfMLxuGlJkbPY/9o9Z54GX0Gzp1SMDqCP
	nFyClYJ96oRRKe6NzqghST1fz/+/wj5GT80+aTW9WIwigJEcQVS3DBWrBdFG800P9Yo
	MBPQdjRd2ozwgf83BOzdzxI+RiTR1r2u8y7+XEdA=
Received: by mx.zohomail.com with SMTPS id 1755380234162803.2511337815716;
	Sat, 16 Aug 2025 14:37:14 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/9] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Sun, 17 Aug 2025 00:36:34 +0300
Message-ID: <20250816213642.3517822-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.50.1.679.gbf363a8fbb.dirty
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

While testing submodule gitdir path encoding, I noticed submodule--helper
is still using a hardcoded name-based path leading to test failures, so
convert it to the common helper function introduced by commit ce125d431a
("submodule: extract path to submodule gitdir func") and used in other
locations accross the source tree.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..7243429c6f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3213,10 +3213,11 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3225,8 +3226,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3244,7 +3245,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.50.1.679.gbf363a8fbb.dirty

