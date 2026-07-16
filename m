Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF930E0E4
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165031; cv=none; b=EV4PS5x+j47ZJPHsLYxoQv9eLEmehOTnnepK9EInn5QS418N3/U0pMrz1cWAcJzIVfx/u+Z3skVzgiYxZJ7tFhBUEns0qDyv0IAH78/Q3kDKEJMSOnh3D0XO3mav0XsqvjhseuAS7ss7GXcmuUnwPJBw3kdFYLphyHpdvKCyEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165031; c=relaxed/simple;
	bh=gBxtLgBnRe2rTIgqqA2+IWzU+wP4Hwbj6sOoyBQRxk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPC/0qXK3hKthqbnRnuh+Xsdy2UthIuslryEvmkyo8QpLT5+SZGWCylpq6ReWQLNJ12Az4CCS9B65by10YG9fwESmbAQ6bQGp9pPz+2YyfNdBq6l858ku5GsBdd2W3uWbJG+XIowIOfpQ0uUaWUcuTjp17WMUMzQBHs3Sr+0UZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enM5+q2E; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enM5+q2E"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381216921aaso6250989a91.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165026; x=1784769826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DrLJmQCDQj+bZw2nSj+aKcT6URRBo7QKSnOEGF4g0M=;
        b=enM5+q2E5+OutGQXtSsoV8lu04ZKZb60AXJiTXJhOyMZnCA5RAc5x3Mr5s7HzH1B7X
         eccjv9/qI1SDNC3x5p4ObqyQ8XdvYOm2kb/sia0KPE9SDUgaL23mV7tgAefFUQIkfug0
         ASYCFm+d1SJ4pnTsU/04s/Q8WFw7lRXa/PV4yeoF7HDtDJT2CaMpyZTaYr/1zdRU+tWz
         Wzhq8C24n4skGR8AAonynjMKUSQwasWlmDvWI5aJuVEDv4Giwdj06i31n21egyhcMBYD
         FOwj81xflSuI+Rv9hPShGvxE6KTpCFFxOBOnrQsOYRUA12A5UtuFwXoTArxyRb5hhdCu
         knLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165026; x=1784769826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DrLJmQCDQj+bZw2nSj+aKcT6URRBo7QKSnOEGF4g0M=;
        b=HBUc1OXji6u9wJic+gnCPQUmVuQlZygBfBTu4NTTnoErYQ6eBBvnBxoPOmthvTOq0X
         t7gtzblc9o2iRtRxjf5MzbeWb1u+3k/tAlP3GPfda9xeSXJnMmB52M/RQWaffmLX7sFn
         9WPYQ/bmnog+iYm/6+3PvhVvgC4PDg+lUcOBlSv2QCT5tp/vCJSEPpMov9zEB4l52miz
         1k5BScZvoH5N53MK409dq+Sp4+gril0Hn5AaUFILFJh0cQVFIIfgI+rt3Sdq59/xckt6
         mIPiANY0B1whvcVSq5h4NXP4Q84LezxptQ+1uYQ57gIYnaTM9YyjP3E3QSxeSaFcng1H
         IiyA==
X-Gm-Message-State: AOJu0YwxsBLVIO9+kkna6LzHmBVggIPNnieGyWHTJLDSC29EhDfTiDi6
	vxvclWja6ry2yu6kUVAG1CyQST1KDWSybxldcuMNAAVNKMPUFS1894EV/jeWoQ==
X-Gm-Gg: AfdE7cldALf1fBu5iUy49olZ643ETv9E8wsOlYytIkjyJPl25HlGLUIXKZmqpIPs7Wv
	xNvyzKjf921zrBzZKoh8aoI4LYUsFvtPe6YfY2bidbKgd2SZpqUjy2jMaa3P7kjlk+Ym/95/Fea
	kcZ23ZiFHCHFiZUopEjG3/tjQ4PvjXpVJHFx2mVxp2EYdpdKfdw9lyskRLkb2v9Xv2FL73uqGHN
	bHZQiMLzjtZbv4U+uG9KGdHO6ZT9G0Xq49/F/jphkQAgAsyMkR0WCUmEn32tfEPol2Y+O0qBLEq
	q3D411dsNTeptax84MctAHwLoOkhu7GFDD9/u6NyZ0hIMAPjDmzIQla4kOOjNqkCSBASGqxxHIY
	xsR1OqB4JklZJ18J0lXdVjFKkbk6rorTDN1GgdoBCWn0Dcij52xF2T8lVC2ZTVd30jGEw4Ef+zw
	Ne1pZhDUjy3y+zUqTfdcp0cY5ojmKpGIhWt3sIITitJflhs/X3LqZQy2S7pn90mIHzWL2lD+XMB
	Q6+qlxdpV5z
X-Received: by 2002:a17:90b:1d52:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38e1ae5f663mr8584585a91.4.1784165025745;
        Wed, 15 Jul 2026 18:23:45 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:23:44 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 2/7] repo: add path.superproject-working-tree with absolute and relative suffixes
Date: Thu, 16 Jul 2026 06:51:33 +0530
Message-ID: <20260716012138.6714-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-working-tree.absolute` and
`path.superproject-working-tree.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 33 +++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..03aa57942f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-working-tree.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-working-tree.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index 194757eb18..82359473e9 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
@@ -121,6 +122,36 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -163,6 +194,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
+	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index fbb9063ee5..220b3d4d3d 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,40 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-working-tree absolute and relative' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		cd sub &&
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.superproject-working-tree.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-working-tree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-working-tree.relative=../" >expect.rel &&
+		git repo info path.superproject-working-tree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-working-tree returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.superproject-working-tree.absolute=" >expect &&
+		git repo info path.superproject-working-tree.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.GIT

