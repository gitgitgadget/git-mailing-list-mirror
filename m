Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554E1AC88A
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067927; cv=none; b=LYaRGB+quZlrtJmmkf5ru0ZFkVU5rAtjk8656GQOH0mpS22bYrM7Y3vLzDqCg6Sxl7yHq+s6VyfYIhNnehyvXx2DCU43K/VcznuT9c2REQ3v3g9bGiEiekKpdjoJ/a54aXhxY5l5BBqKwnzPChIrBZyq2lS7nmed3dlmQwwnHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067927; c=relaxed/simple;
	bh=5l7+6IXecgG9a39NXmei0JZpyMe9KreCYAEWnFLSE6c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=inkbJvwl1WiSaYN7G2HkuQuG3QaRob3FXQgpbbmtrTNnMKJUj9gE2GwVSetI3KrXEtbtvWMJrvdoN7UhhtUIEgG0pmfN8Ai7kj19Tv/cV2gSlspgtTzd4F9B4FfWEQT2SK3n3cYkSwfEl8nrh2fsoxo6l5PDPD3jpLG6AHXwZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfLFbpe3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfLFbpe3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so22919111fa.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067923; x=1726672723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwLU6yfkT1MAzSPpvvvUTy0XWobCnJbo32cIIv0rM6g=;
        b=IfLFbpe3wCSCUfu5XeY0yv8Kqm/lseDZd8XNiw9nurVYQljk3qX/AX9+z6a8I1p/bc
         /XrjwSKsMFPBejG+5L55UqTJJhmsmFk4mrpLbu9MyUEoiEiJ8Lts6beoLydmbx6zUN6/
         bk9jsqMcM3F8e65UxU/q3YHSzRTnd8zEOTw0WabPyqfEAs758P8xO5oCwRIiN/wc5hzw
         /TbXckxByKz54JT3ESoWIeEggAKddnCNbUAJc+UIlOVJcCK9qc7zBFMKTPbqNbaS7TKb
         IP/YBwr/6JJH1DSB5CcKOrG6KVYL44OKo8rl8iK+cZOgWQInbzAFbYNb7F08kMeRt+Ms
         5woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067923; x=1726672723;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwLU6yfkT1MAzSPpvvvUTy0XWobCnJbo32cIIv0rM6g=;
        b=w0YaEkjruIBp7NLOgkWM/GDxh53OueAGjkL740ct3/fcUhyIKrTg8k4xT9b3pU3rbR
         tgK/ubKQ1x5PeiFFtyYlBNdHK+F4eYG3m8rO4gkI0JyHioDRIWOTGQV7kBsVV28i5PUs
         /GDPHrb8ZKLG2BxA48pCG43D+s4tweSLNNsusSu0BVXagV0W3gewsIg7mfbykIHhYpHg
         ejUOKIJNXrp/i5xYFoSpISYSWoGU1yaf4FlzamjjmhjvzBlEYLM3HMvVHSWyNPc1ku+s
         0q4M7OhQC1MGWi72DnVLXGGCuCk+6k7UYPXNufy+KXWFXE3P+0TLDGvOLuhGF/2URTu6
         3mpg==
X-Gm-Message-State: AOJu0Yz99m3EmFNT73fz2psSmOzs1ATIGtif3i1nJUmUA7RPq1/YHN0E
	nj4kbk/ea3VyBWsxYfdK5ie39HTZU8ifH+fKQG805tnu563AYsjh6bmQww==
X-Google-Smtp-Source: AGHT+IEeJdY0XV4sVcOM5aTv4oMhyotS0SR7ycOG93z1qnaEYzn0o7kt6bfYTbXh6sEgk41b3aPfEA==
X-Received: by 2002:a05:6512:2244:b0:530:ab68:25c5 with SMTP id 2adb3069b0e04-536587a689fmr18862005e87.2.1726067922080;
        Wed, 11 Sep 2024 08:18:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258317d6sm623379166b.29.2024.09.11.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:18:41 -0700 (PDT)
Message-Id: <dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 15:18:37 +0000
Subject: [PATCH 4/4] remote: check branch names
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
Cc: Han Jiang <jhcarl0814@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Make sure the names passed to "git remote add -t <branch>" and "git
remote set-branches <branch>" are syntactically valid so that we do not
create invalid refspecs. This check needs to be performed before
creating the remote or modifying the existing configuration so a new
function is added rather than modifying add_branch()

Tests are added for both commands that to ensure (i) we report all the
invalid branch names passed on the command line, (ii) the branch names
are validated before modifying the configuration and (iii) wildcards
are accepted.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/remote.c  | 19 +++++++++++++++++++
 t/t5505-remote.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 318701496ed..fd84bfbfe7a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -132,6 +132,19 @@ static void add_branch(const char *key, const char *branchname,
 	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static int check_branch_names(const char **branches)
+{
+	int ret = 0;
+
+	for (const char **b = branches; *b; b++) {
+		if (check_refname_format(*b, REFNAME_ALLOW_ONELEVEL |
+						REFNAME_REFSPEC_PATTERN))
+			ret = error(_("invalid branch name '%s'"), *b);
+	}
+
+	return ret;
+}
+
 static const char mirror_advice[] =
 N_("--mirror is dangerous and deprecated; please\n"
    "\t use --mirror=fetch or --mirror=push instead");
@@ -203,6 +216,9 @@ static int add(int argc, const char **argv, const char *prefix)
 	if (!valid_remote_name(name))
 		die(_("'%s' is not a valid remote name"), name);
 
+	if (check_branch_names(track.v))
+		exit(128);
+
 	strbuf_addf(&buf, "remote.%s.url", name);
 	git_config_set(buf.buf, url);
 
@@ -1601,6 +1617,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
 		exit(2);
 	}
 
+	if (check_branch_names(branches))
+		exit(128);
+
 	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
 		error(_("could not remove existing fetch refspec"));
 		strbuf_release(&key);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index cfbd6139e00..709cbe65924 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1195,6 +1195,34 @@ test_expect_success 'remote set-branches with --mirror' '
 	test_cmp expect.replace actual.replace
 '
 
+test_expect_success 'remote set-branches rejects invalid branch name' '
+	git remote add test https://git.example.com/repo &&
+	test_when_finished "git config --unset-all remote.test.fetch; \
+			    git config --unset remote.test.url" &&
+	test_must_fail git remote set-branches test "topic/*" in..valid \
+				feature "b a d" 2>err &&
+	cat >expect <<-EOF &&
+	error: invalid branch name ${SQ}in..valid${SQ}
+	error: invalid branch name ${SQ}b a d${SQ}
+	EOF
+	test_cmp expect err &&
+	git config --get-all remote.test.fetch >actual &&
+	echo "+refs/heads/*:refs/remotes/test/*" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remote add -t rejects invalid branch name' '
+	test_must_fail git remote add test -t .bad -t "topic/*" -t in:valid \
+				 https://git.example.com/repo 2>err &&
+	cat >expect <<-EOF &&
+	error: invalid branch name ${SQ}.bad${SQ}
+	error: invalid branch name ${SQ}in:valid${SQ}
+	EOF
+	test_cmp expect err &&
+	test_expect_code 1 git config --get-regexp ^remote\\.test\\. >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'new remote' '
 	git remote add someremote foo &&
 	echo foo >expect &&
-- 
gitgitgadget
