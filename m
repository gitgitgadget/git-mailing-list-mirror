Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6D3815C5
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244094; cv=pass; b=KQWSRDUk4HGMnc2GvZ5hiyPbQ440hgYK+PfdY4uaFSppGazVxtc1YvASxl9wIVaPb7UyJJT/0hp0cRWKE59wLY9GjaQhUwo9mUlWghqocirBe11drEKMlZgAeySl/nlZMU+p0vJC9/Xa5ddPZWHYKtzCw64MLa5UvyCR52rfkgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244094; c=relaxed/simple;
	bh=mGgUrLFPsMjOFqBTyLwfdVyBgB0/mAn39XvmETubOh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob2kNM2gBVty2pZlVUQpNCACnRvPIsxDTnkGQW1uJOXr+Ls4/Qop5qDGWcw7xsfhk7ZePWj/MPMoPbpvCpU2stpAVU65PXKht+OtNUSOraA2dx19kY6oIvwG8pMzx0apUndpktrSff5ZMyonoeXNMLsVMCfz5w0Flu/DiyMxAjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Zz3peyvM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Zz3peyvM"
ARC-Seal: i=1; a=rsa-sha256; t=1768244078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LVpmZ6QlIuhm1SaxgEh5LS9GpyA/mLLF40rGB1bbN5lBfud6c5Zjsf79AB03EZ8znSCg1VQciOCGLTmFeq0RQu7nlAxad0KYVVI+jhwZxqbY2/9jrRjHaTAxPYNCdkG2OPoco7oXxcYMvinAWbheaas7foJrSp0qlD+F7gPNc9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244078; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zq/HPVUzNWNiF2+ic98fM4i/JIYZmNCpAC8bpzO9EMU=; 
	b=ft4Bcv4+E+sxffMXPcFctw/PB9qZfzTmrWI/c+Tswqx8MU1e51JDH9LE1SMpXzIU+iKqrcDMGiuISPUH1FYf7VoWZkYzlN7Ak78gvyNkSYDXN0yl+iO7FEa6emLccmpYc8Me/SMKIYYa9X7METd2VdXuWqh4oxm8zxwR0rTvUeY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244078;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zq/HPVUzNWNiF2+ic98fM4i/JIYZmNCpAC8bpzO9EMU=;
	b=Zz3peyvMKM5isNxFpy4iFrfeBp0x9Q7e4M7GTcAsLHOJ5mWIbvNbUnVX3lgGe86x
	ABnVoRYg5S5XU0wJczLIHtp6pEBStB10/1ppOJJ2plxwc0pd6Hq2lI3La/W06ybYJFj
	Qdqji81GqKBz1AwbQLASbFeSDvtVnh21wn7xukpQ=
Received: by mx.zohomail.com with SMTPS id 1768244076683783.3270919553313;
	Mon, 12 Jan 2026 10:54:36 -0800 (PST)
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
Subject: [PATCH v9 10/11] submodule: hash the submodule name for the gitdir path
Date: Mon, 12 Jan 2026 20:46:31 +0200
Message-ID: <20260112184632.1334495-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If none of the previous plain-text / encoding / derivation steps work
and case 2.4 is reached, then try a hash of the submodule name to see
if that can be a valid gitdir before giving up and throwing an error.

This is a "last resort" type of measure to avoid conflicts since it
loses the human readability of the gitdir path. This logic will be
reached in rare cases, as can be seen in the test we added.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c                | 19 +++++++
 t/t7425-submodule-gitdir-path-extension.sh | 59 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3d5a81201e..b621d14275 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -465,6 +465,10 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 static void create_default_gitdir_config(const char *submodule_name)
 {
 	struct strbuf gitdir_path = STRBUF_INIT;
+	struct git_hash_ctx ctx;
+	char hex_name_hash[GIT_MAX_HEXSZ + 1], header[128];
+	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
+	int header_len;
 
 	/* Case 1: try the plain module name */
 	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
@@ -506,6 +510,21 @@ static void create_default_gitdir_config(const char *submodule_name)
 			return;
 	}
 
+	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
+	header_len = snprintf(header, sizeof(header), "blob %zu", strlen(submodule_name));
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, header, header_len);
+	the_hash_algo->update_fn(&ctx, "\0", 1);
+	the_hash_algo->update_fn(&ctx, submodule_name, strlen(submodule_name));
+	the_hash_algo->final_fn(raw_name_hash, &ctx);
+	hash_to_hex_algop_r(hex_name_hash, raw_name_hash, the_hash_algo);
+	strbuf_reset(&gitdir_path);
+	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", hex_name_hash);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
+		strbuf_release(&gitdir_path);
+		return;
+	}
+
 	/* Case 3: nothing worked, error out */
 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
 	      "Please ensure it is set, for example by running something like: "
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 3cca93c897..a76e64a9f7 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -438,4 +438,63 @@ test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are corre
 	verify_submodule_gitdir_path cloned-folding "fooBar" "modules/fooBar0"
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'verify hashing conflict resolution as a last resort' '
+	git clone -c extensions.submodulePathConfig=true main cloned-hash &&
+	(
+		cd cloned-hash &&
+
+		# conflict: add all submodule conflicting variants until we reach the
+		# final hashing conflict resolution for submodule "foo"
+		git submodule add ../new-sub "foo" &&
+		git submodule add ../new-sub "foo0" &&
+		git submodule add ../new-sub "foo1" &&
+		git submodule add ../new-sub "foo2" &&
+		git submodule add ../new-sub "foo3" &&
+		git submodule add ../new-sub "foo4" &&
+		git submodule add ../new-sub "foo5" &&
+		git submodule add ../new-sub "foo6" &&
+		git submodule add ../new-sub "foo7" &&
+		git submodule add ../new-sub "foo8" &&
+		git submodule add ../new-sub "foo9" &&
+		git submodule add ../new-sub "%46oo" &&
+		git submodule add ../new-sub "%46oo0" &&
+		git submodule add ../new-sub "%46oo1" &&
+		git submodule add ../new-sub "%46oo2" &&
+		git submodule add ../new-sub "%46oo3" &&
+		git submodule add ../new-sub "%46oo4" &&
+		git submodule add ../new-sub "%46oo5" &&
+		git submodule add ../new-sub "%46oo6" &&
+		git submodule add ../new-sub "%46oo7" &&
+		git submodule add ../new-sub "%46oo8" &&
+		git submodule add ../new-sub "%46oo9" &&
+		test_commit add-foo-variants &&
+		git submodule add ../new-sub "Foo" &&
+		test_commit add-uppercase-foo
+	) &&
+	verify_submodule_gitdir_path cloned-hash "foo" "modules/foo" &&
+	verify_submodule_gitdir_path cloned-hash "foo0" "modules/foo0" &&
+	verify_submodule_gitdir_path cloned-hash "foo1" "modules/foo1" &&
+	verify_submodule_gitdir_path cloned-hash "foo2" "modules/foo2" &&
+	verify_submodule_gitdir_path cloned-hash "foo3" "modules/foo3" &&
+	verify_submodule_gitdir_path cloned-hash "foo4" "modules/foo4" &&
+	verify_submodule_gitdir_path cloned-hash "foo5" "modules/foo5" &&
+	verify_submodule_gitdir_path cloned-hash "foo6" "modules/foo6" &&
+	verify_submodule_gitdir_path cloned-hash "foo7" "modules/foo7" &&
+	verify_submodule_gitdir_path cloned-hash "foo8" "modules/foo8" &&
+	verify_submodule_gitdir_path cloned-hash "foo9" "modules/foo9" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo" "modules/%46oo" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo0" "modules/%46oo0" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo1" "modules/%46oo1" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo2" "modules/%46oo2" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo3" "modules/%46oo3" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo4" "modules/%46oo4" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo5" "modules/%46oo5" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo6" "modules/%46oo6" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo7" "modules/%46oo7" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo8" "modules/%46oo8" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo9" "modules/%46oo9" &&
+	hash=$(printf "Foo" | git hash-object --stdin) &&
+	verify_submodule_gitdir_path cloned-hash "Foo" "modules/${hash}"
+'
+
 test_done
-- 
2.52.0

