Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06872882B2
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613358; cv=pass; b=rKYouUf0c+9WejIprY3ls+Yd8SfASUA7E1uqNQe+SJ16AeHKzlNHzpbLZJlAgu/RRLLHb5BItRl3pxQiYsXbGYreHYZkitRobe5ddq4h1E+Kjcc1z/j0YdIORBEwAWRhOI23AQp5QhAlZMtRWB8oqF2L8pgp3NXU8R56y4B1q4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613358; c=relaxed/simple;
	bh=bmvdki1rQ9/OkPACJuHdtKQusffjMd/tuqu++6fpHus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QisLgPGElavWC03BKkt9+TFTOAIpTd3p2U7QiBYUAtkpKIcAxJ4HdTaADwuXmIwsRj38EvW6MpV3cpYwbXiRrH/Uv3/iuo8H+a9GK2PsI/hV6rQySWwUn0RAUSDmWHAXHz8x9P9RUthuTVa+AgSB2vTn076bbIk1sFxyJ9H8ivc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CdgOxPfx; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CdgOxPfx"
ARC-Seal: i=1; a=rsa-sha256; t=1765613333; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YSGYXPHQCQHp5tMK3RIVRihUCQft5TbaTVpgWIq0pHXzxnHgvhxtmpdJGFIph9dDOmkZ+AWkSr1UbagWjESNNy0lej1eH7T3DDF3BtMa9jwOWBd1aX146y3BB0ocWlIXYkf9kM5NodJ0SP1AZUqh5yyWQYk3GC+dcjyekpEuoEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613333; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IUzLuzLooAAk0qUVuzzKtFNE3pmGN8i1DCpELBxgZ/c=; 
	b=JhhnE8srN3US34nLa15j7DbI3XNqDSVf1vWl3PAQQq6YZlN8r58arM2u//KAJTN8sXEP1cVISs/HAKwdW2zR0LH1SVXJHSunGL7WvLOYTtsm9R/Ucc7xnwsBs7GAz3Y6OFjAxzTAOlXYde95NBhOASNro0lcSutt82q0B5SNUSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613333;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IUzLuzLooAAk0qUVuzzKtFNE3pmGN8i1DCpELBxgZ/c=;
	b=CdgOxPfxSJ7ds7KQaLxmMIHKG7ZcvuuhmTvHarT1/QwwqLZtAPli5w+7EbD0g00I
	fX5i/fCILJMhAOYnqp5oqJKIVv3Y1vuvJP/9U6yqdBVvQvG91UAfB/vUEf6Mk7ANA/l
	eyIM8DusYQEwqrsi91AC+l00VcHp1sk3T98d8HTU=
Received: by mx.zohomail.com with SMTPS id 1765613332216547.5535867940778;
	Sat, 13 Dec 2025 00:08:52 -0800 (PST)
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
Subject: [PATCH v6 01/10] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Sat, 13 Dec 2025 10:08:07 +0200
Message-ID: <20251213080817.347922-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
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
index 35f6cf735e..13b5e4ed68 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3183,13 +3183,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 
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
@@ -3203,10 +3203,11 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3215,8 +3216,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3234,7 +3235,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.51.2

