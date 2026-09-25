Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F83DDAE1
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333414; cv=none; b=Hm0rcTw+VelcXHXgf8IeErCT/GrSyoGMp0TvMUIasPhOl+a5CJqpq9C865emmQGYdCTY1rJEsL1yaL72t1+t/ogOMKynjMRxDml29hvNCbStXuKKQwCb1BjErslQ0Yblb6pCUuMPbm0o+qE2PbhEkJlQGzW7YehivI8FlrEaxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333414; c=relaxed/simple;
	bh=chhJjgswR9iKC3AmcbYR3tpQUrwcP3or0IegCXR3FVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wzh3WDchg8jcJz1Uu8H0kcMqzCOroObVRjLg8qSTR//iGGBg+eKC8Jjpo23E3pwHm3MzDElgBZbPOzceMUevPMZQdMHUfXPFx0Jz85Ce3i2GYvSQl3vPkl+Z2bD/mkuvBX8Q2+MPWwd4K7LSvbA/Ebjn3OGmR1Z9lsaT76V5EaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac+eABM9; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac+eABM9"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3115c4451c8so615146eec.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790333412; x=1790938212; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aYopBmKuB2uR2gTEP1ZHKFiYowbaVPk2PJh4ABOm7ss=;
        b=ac+eABM9KJlzNKfm3PWzCZloz1aUBpD64xLDFxtSLW/yfOfMokA+W3wNl7z/g0zEIB
         ZRZIw0tslocoZLvBmrNizGNbo+plpuNrpwyjt8fxl8/iw7VCC9xp+RdaFSRrN+AWwPmX
         w39+lwIwxlYde8Qnc5xae1H4wU1ZPp2vOp1YuKrfyL0jrnBU3dAxO2eaU1fwXBUPWlSQ
         Wwq3iEFp4GEiLfywzkRK8u+2I73BkKr9k9MKPF1XBYJcUdSxCykK6zRz314/yxuxQHDc
         z+h5Foqb+b8bHszP97RMcIFNuyzb9XuuRKeZru3PjyJ0oAG4s12huP/TD7HDxWrwGrCV
         L57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790333412; x=1790938212;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYopBmKuB2uR2gTEP1ZHKFiYowbaVPk2PJh4ABOm7ss=;
        b=OyZJtlsRkp3sDvVq2RYPXAJUi6CfrrcfC/5W+qcqAjJVwABVJwQHJ/sHI8GjGJWMdW
         IrYzs6CfUEs3zjPVE58Ypg/3r6iUGJvE1EUsBpzWQclXGpUUt23IIFNO619DKxt2Fcdk
         dKCgBArieLc/SvWlErmLxraYSBI7IDiF9E4n97UxGpi1fI/hizTnH5Zm5+fiMVuiVHq+
         jIezGg8wZrne02vWj7t5WKIo1yk0up5ERzYHlB+dR3iYNIEWDAR/5TNWOmZLSxEbTGxS
         OhukghUjFRG+oTFHmzUiCj6x9QuMd0SIol5xTHf8O/YPMeHxpChn+8H9d4GttICuORIm
         Pg1Q==
X-Gm-Message-State: AFuF++kreV7vq/bcgBGj/Av7L3Mei8w4tvI/oEkuILxUZ4212prCzjUw
	uxpQknQK5KUjL/R/hPknRSnWc0SfHHtXcaXgePfgUbTYQRF3GEamaqQvkmazUadH
X-Gm-Gg: AYBFou1RCWFy7SxZVl9xzet6dFaQnDAAio/Z9gogPkfHKfFJ9aHQVVcvr2JZJcSkaE+
	hVkC9h7LyV8+cKDcse0rDapa9TYd9WX4DQcmHjoL3vh9B062n2Zd/pkZ1t9LUgPTk2CdTieKyG4
	zp1HX6fElKmRpzpXybhjs46qFvELFKxMLtLkIKzIF9WCE0Y+HwAGLRwvTakcDMOrEYSWrVzD5Ng
	ws8ywld8PdcplmS3z165/PN/I7hbREAbNxzd3DpRdEVSR7lhidyDcKRoh5eAbdZq0GZQGw5jQI2
	DZYmvqiuDQa29pFPufPg/OM+tTIxRG9lFJAQz0yuIj7vNqxcxISMePIbMM4hSCYjcW6Ho6ll9z5
	OxuObwFMnHBhwQ3Apq+i94jX+neI0ab/wb6GGb+JHEL9TnsrtVYfG7zDrxfaB/GXv6+M8v+ywbi
	JTrbOcdL5vMeL7F2XLmATu7N1isjNLYSguRAe+DDcAmFJULNuoRlIwwSNQwppsy3Jo+3P6Oho=
X-Received: by 2002:a05:693c:87c7:10b0:33e:61ab:8309 with SMTP id 5a478bee46e88-34006275ab2mr4208365eec.23.1790333411314;
        Fri, 25 Sep 2026 03:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.7.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757747sm6936546eec.13.2026.09.25.03.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:50:10 -0700 (PDT)
Message-Id: <31462e944563c94829a32e35577d7d2567ff8b36.1790333402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:50:02 +0000
Subject: [PATCH v3 4/4] remote: default to --limited-fetch in a shallow
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
 t/t5505-remote.sh             | 59 +++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 74fbce6e0e..82b21eafa7 100644
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
 are built on, plus the remote's default branch. See the `--refmap` entry
-in linkgit:git-fetch[1] for details.
+in linkgit:git-fetch[1] for details. `--no-limited-fetch` explicitly
+disables this, overriding the shallow-repository default described above.
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
index 0168d5abfe..9cb88d8806 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,65 @@ test_expect_success 'filters are listed by git remote -v only' '
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
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual &&
+		git branch --set-upstream-to=upstream &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge
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
