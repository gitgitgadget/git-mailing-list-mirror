Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC933E348
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102696; cv=none; b=XwGbkJmFtZiWZ24mncwFkd3uTn6bBzahVANDhlsS3w9ZD/DyI1wRc5I9yrIU4KQPCcG/W+oER78DQgMH39YKxTUrVy14l3TVeaRaBFCOmHVw8sZD6xATbJqev13xAY4nHiy66C0aGrHrLiU21GNP5LQx2EoEkuWv8X/m7DUK4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102696; c=relaxed/simple;
	bh=JB2qh43jJmR2/5EX0tzAwNASpHp9OSxQ4sNUChn5fsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pU4aOQTfbg3uBWOW+1p2+8quHTgM1uzGaVEZHkuYaKV0J7ZeHm39PtEc1U9lCKlDq+L9DCoQ1O2RHBe9qCc2puKjglTdjj1a+3u/u2Ds0KbfUa6pXDvNsSrxs/j1DW2DVLCSyOGqwS9MNoU+ILcxmPTgJN1uFOQ/Zp1xLakq+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3mrSvgM; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3mrSvgM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so2342629eec.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102692; x=1791707492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=b3mrSvgMjleG1m7MsU3EDdDfYTQUQSLhzQmQCeqnhItj/AXpu27TpyOv+xzD8R0Q77
         liWkMfxuBoheyxEcUzyKHGJbpQbinwc60ybP2CvoWyVFso9xEpVhv8jylZfMECWk2M/J
         NAk3TK+7qHMMdqgWGjEDtWZHhczuy/y8nfH/8frDGvn3TqJY+KgRdPyNqVkg/KxA9vFi
         JylcRoYJS7re3aG9JG7zsGlarS/oVYcSvc6El39B3AoQ/N2pXF9kjdMTVI3W/US+lYRz
         qwzE70Xpu7WfncxML0Nr4GL2m7KO6Hos4cA/c5zRhceJ8MxXVWx5mj5yJwGTv54ENp+L
         9WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102692; x=1791707492;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=itO5TSqxrsYVXCk4FhFtfUNKXfwnQi+JTsDWoPEP3ieloaHA2251sNP67HM1K0UQBo
         G3VCfCmQsIbBAoQ3MfvRZpWdbyLYw4Bb/ZmJvcl0aHSOIYCHuQzaxupQ6Hbn6RwI4X9s
         sWyUBi+Ogkf4dbGc/6PYpJffLd7uzSZxpPnyx2SpLq2jfq+Aw6ahGZ5UqObf8DYhb4yR
         NOAFW1U3vCvoRNW2s3zk2087NHIPMAsRZorMM5S63pSVijjBAtsqO3BGx9wvMQJdUss/
         LFYwfXLmFBjKer5CRCYH1sbjmOboQgMNuVStuKB0V+PsjCDf6konM/zH2o4W9HnodL0f
         bDZA==
X-Gm-Message-State: AFq9FYKebTJqRaUoLAmO70uerNjW8GFHBdyW7ERSmT0031Dw42vF+xc6
	EQDFKavInD7sC8uO2hGIDkwqOn+mo5iAM8aB4dZM5l0vT22U63213cyageolRw==
X-Gm-Gg: AYBFou0fIoQM/PYqkGB7hoE8sR7OHopBGZ6s3VVCvc2aTbSslEy4NJkmh8RYu4avyoB
	fTKXe7hGM+S+JaFLwFFPH3CHtgRXoeDfQB4GDUcKaf/YIEUsX6ECDh7s+D0BCRZT7AOi04wG8pD
	IDc7mQdL3gDubhVwY8cYsC+6jAkDjYFk1Hk/kaey1WvVA3sXwwpbQgnQX1xyUG/dsdYdIxrC2k9
	mN8RU9rYl9ObCM+nTi0gXGaeT7+XNC9IirZhnzU82rnXC+T+Rmvq0CuCVx+t833fSnruWjuW2Xl
	yDwLXH+aewKXPlYxdh9sQH5AflA9WpKa9uxAjQESI2/gqrPnsaV4JUkr0lioHeIVVCJYg135D/R
	HJ+wevQnJcK/Vhv39SQIl+L79sHPGcekBJ472WPJxcBVWIX9IL1FgegYlKfldMBZCfMUDMPTzdp
	gNQV+uy7K8JuTyuvpVeKJqNwIrtymFOjLXOBbtg4BHbC5I6Cs+VgZZ/B/azyav99IER88C8X3Rg
	g==
X-Received: by 2002:a05:7300:1681:b0:33b:dfe3:250d with SMTP id 5a478bee46e88-351116a1832mr5937146eec.23.1791102691934;
        Sun, 04 Oct 2026 01:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127021706sm3089942eec.3.2026.10.04.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:31:31 -0700 (PDT)
Message-Id: <84d192445c2636b618e86e632ee8439574aa0058.1791102684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 08:31:24 +0000
Subject: [PATCH v6 4/4] remote: default to --limited-fetch in a shallow
 repository
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Adding a second remote to a shallow, single-branch clone used to
still fetch every branch that remote has, since "git remote add"
always set up a wildcard remote.<name>.fetch refspec regardless of
how shallow the repository already was. That defeats the purpose of
having cloned shallow and single-branch in the first place, and can
make a plain "git fetch" on that remote hang or take a very long
time on a repository with many branches.

Turn --limited-fetch on by default when the repository is already
shallow and neither -t/--track nor --mirror was given, so that
adding a remote there does not by itself commit to following every
branch it has. --no-limited-fetch keeps the previous behavior for
whoever wants it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 ++++-
 builtin/remote.c              |  5 ++-
 t/t5505-remote.sh             | 60 +++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 4255f8b3e6..80f8a4a183 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -52,6 +52,11 @@ Add a remote named _<name>_ for the repository at
 _<URL>_.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches `<name>/<branch>`.
 +
+If the repository is already a shallow repository (see linkgit:git-clone[1]
+`--depth`) and neither `-t`, `--mirror` nor `--no-limited-fetch` is given,
+`--limited-fetch` is turned on by default, so that `git fetch <name>` does
+not need to negotiate history for every branch the remote has.
++
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
@@ -74,7 +79,8 @@ With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
 that tracks all branches, `remote.<name>.refmap` is set up so that a
 refspec-less `git fetch <name>` only fetches branches our local branches
 are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
-details.
+details. `--no-limited-fetch` explicitly disables this, overriding the
+shallow-repository default described above.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
diff --git a/builtin/remote.c b/builtin/remote.c
index f036dd5d6f..0cf1126976 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
+#include "shallow.h"
 #include "odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
@@ -238,7 +239,9 @@ static int add(int argc, const char **argv, const char *prefix,
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
-			limited_fetch == 1;
+			(limited_fetch == 1 ||
+			 (limited_fetch == -1 &&
+			  is_repository_shallow(the_repository)));
 
 		strbuf_reset(&buf);
 		if (use_limited_fetch) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0168d5abfe..f3b5905e9e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,66 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add -t main upstream ../two &&
+		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'a remote added in a shallow repository defaults to --limited-fetch' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.refmap &&
+		test_must_fail git config get remote.upstream.fetch &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-limited-fetch overrides the shallow-repository default' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add --no-limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch &&
+		test_must_fail git config get remote.upstream.refmap
+	)
+'
+
 test_expect_success '--limited-fetch works in a full repository too' '
 	test_when_finished "rm -rf full-add" &&
 	git clone --no-local one full-add &&
-- 
gitgitgadget
