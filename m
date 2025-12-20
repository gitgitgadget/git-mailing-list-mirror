Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF43273D84
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225775; cv=pass; b=dsBC//vl5OlH1x7wGi1XBKC7wJijii5zKovTxpC6k+2SMms34Nl9Ah0i0TYkmdJHy1vqJ9uL2bCXwxsnP2JeLxkIrfP5DNmoRiOa3spMtlCx4+IV3jJcUKdf6roOgeq92uiSzzdNzM1AHEA/dOWWhaLnEbIGblshvwpfjQJ5wGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225775; c=relaxed/simple;
	bh=fnev7uCKVZtoqga0Z1ssjQ//SvS0zkR6SreYSXRF46U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiwLXf4+Qs401A6EVixw8tGijs/jCsrAs6g3HvdjVVSuQFCNFV2wQOi8dgKVbomctZuspew7Ha8fO8aVKPX56p0S79TJtSrfRonUTlGGq1E7ZzIw/vCQqRglPqFv3uZ+bGQ3QoO5A7tWz4iYCnuHhYYOsyc0C6zrWcx1qLpo2Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OTFEhjGp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OTFEhjGp"
ARC-Seal: i=1; a=rsa-sha256; t=1766225757; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vt5LPKt5aJLOAgtvLdcEoUbLDjAvsnH4QGdJ5uZ76npsx5mSyn34xkLEn/ncF7cUhugoBcQCTcQZiL9UJZyqstjlMiI+IZ1Nwa9pfjhLUdzXrKM1h3KlCDBS8csxVHe5LTX5jtBvtkG1bHM/So9l2uP4mIFasFRVdtox9rCTACs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225757; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L+uf1to0k3f0n9BBWfRxf44sm544fNws/V4SB2hBxWY=; 
	b=Gfxbo/75JXXhedYy+S+CSE0Vi8Y2hG6092yYFv5M0vCcDsg6R4OPzrJQtnIT9AyVXR5nuM3V3f/RZPhajT92h+6YrEjZvNKPCTiJBY7LgEkp0aM7QscnbXb1Z6E9vf59FuWGqFeIuHYNQjdkG3/RjPm9CspEpFMQx3OC+FQyFFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225757;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L+uf1to0k3f0n9BBWfRxf44sm544fNws/V4SB2hBxWY=;
	b=OTFEhjGp6I6z8uO603urTPojwP7cp7d/n0YVMAHM1ZhY6F/2QzAU9xhKbCVqJONH
	tQNyOCnCna0vdGi8C1cbKQtBC7MPhZga8CYdEXFrMBTdJhc+fiILJ9CvafmWKQ53ld/
	G8XAk4R8ncWRlAtmUpQl6rd6mKZbG3ZyAUuI7u0M=
Received: by mx.zohomail.com with SMTPS id 1766225755646621.9677188420716;
	Sat, 20 Dec 2025 02:15:55 -0800 (PST)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH v7 03/11] builtin/submodule--helper: add gitdir command
Date: Sat, 20 Dec 2025 12:15:20 +0200
Message-ID: <20251220101528.1227487-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This exposes the gitdir name computed by submodule_name_to_gitdir()
internally, to make it easier for users and tests to interact with it.

Next commit will add a gitdir configuration, so this helper can also be
used to easily query that config or validate any gitdir path the user
sets (submodule_name_to_git_dir now runs the validation logic, since
our previous commit).

Based-on-patch-by: Brandon Williams <bwilliams.eng@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1fc098614..3bc139ff9c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1204,6 +1204,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
+			 struct repository *repo)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, repo, argv[1]);
+
+	printf("%s\n", gitdir.buf);
+
+	strbuf_release(&gitdir);
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3583,6 +3599,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
-- 
2.51.2

