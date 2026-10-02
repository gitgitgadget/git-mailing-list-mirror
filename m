Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077341A513
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925216; cv=none; b=O0dtyKzdRZXfNYdSewK7QitSgJ2uucw2eLIOTy7qeyVWygSU1ceO20eIvC4VC35jiGauJ1TSqrqXeVaBgQMFmg7NU0XZaWsZIWIrjUSUXyK1P+JVFIquTZP1yMgM9OFnVh4tL2UGl43yHP46KXYNTdxgJWMODG03VOnlJc2inqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925216; c=relaxed/simple;
	bh=ueyd4/mNBo2YjOZSNImN9F7DjYz5U0FIR5X3g8bc/vQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XkWQPtZFiHPkamUCVcyAtGr7tMGhC8SKiSnMr9ZOi0zo1h/T7OW00AkAMZUFij6ATYjwi1wYyX5Y3/+bLNDmnT9JLXAZ6uQIk7JSw9nbFJWMGwlIIi1kAQ5muzrEreLiIy0zrtPftsGDTzwN42etm7ypkhfP9rMSNZbrJsR5qQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEdk8yZT; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEdk8yZT"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3e517e6dso1860104eec.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925205; x=1791530005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UnNTok+xSCjoALwMPgCwAp98VQGEuUENBNZ1tMLOBzY=;
        b=mEdk8yZTRRJUL7oawX0y6neihAlovABCtM9f67tg42kFBWuYR1kVKpJbIzznVel2+D
         zMrn61jMpVB9jmbevgJZ1aiTAjzwSPN5nDAUyMmRsdaw6EU5EfV3ecWJgOIRrrUO/JD0
         3N3RztWNYw3SSbGgEb3vQl6fU0NezRSD+7oD8WPQVFVSoj2wvSOoE0LAT9Q6z/kCYfpO
         bVWlyKs72ZWFOVihdqVYSZkzQcgkmarIy7DDKa+HrJ1ZLqFTPlo87d1FkaksD/Kzyftp
         6aqX/YWxO0VaiTi//oEMuhp/CLYh77uAdxP6k7cHbRdSw5O2GgdUVRbWD/9EiHhILzFx
         aE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925205; x=1791530005;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnNTok+xSCjoALwMPgCwAp98VQGEuUENBNZ1tMLOBzY=;
        b=uM5KPnFZJP428V1vLSbM7st5WkdZ63sBm9An5DLcutPk/Wb7IU3Bevh9a+dqKpP6mc
         tmg0ft/gPc7IDpINQ6cWfa7u/PrAFAd4QVK+CEkSwMEp1QtEV71FGP1Ivs1bQ0FbT9FU
         tUgx1JEJfCGPQj/OrEyeHtvXeaP70Ydgr1IgU253R/oxOKhR5Y/24XWou5FBckHzz4Lw
         RH43B7m7j+04tErjUGEWVCEjRrgUN02WzbpMK4u0ncw2vaLso6Hutye8jF4lbq38akki
         qqMYqrXYTKIzlBD30BVJ19Z6YJ9/wl7fycFauqhLNtBDSH/65NVuJMqBV/9LabALw7Li
         v88Q==
X-Gm-Message-State: AFq9FYLANlC9a8XRG1y7cdw91gwt2zxwncqw2zHW2kz98Quz+yeQppb0
	0/MDisMzo3V33YWGKfu2Q0WV+h1hewUtXDLTPwROGh6TFOVWthT4gwN0ORABBQ==
X-Gm-Gg: AYBFou0kbcThrsq9yWhQMIUeLIWwV0MZc/FmX6f30+0Z9S5Mf2ZtuDxfGf+47Ett8Nr
	7A/0/WjaQfa5ShtBMZhxGkvJ4J36XzajaWUlrDOOyadMIXnws1Mj1MeuYQka8cF8WcEfnvxhmCU
	dmkl0o5AflLJ/gzX5TeZngBSknCWigsdJxNrsglpJD0YQ3G7xfr0sGghSotrSECoaadoXdKhJw9
	zd7o98PRyKibLdv7TCtjZficcgcn/ZA6b81WANHU9l/zcXyQwkY8UbF1we4aTY9qjfCGWR6mDlD
	e9Btnf+hIRVHFt8zXuEd9wgEdvGVk5sszMHZjMz6/vv9CDgiyufZ4x6NljMx13qZq9Dz0TJN1Br
	5yA/P3S5Owzggh2a1fbgzyVYcW+4dqQZECoIyZQDZ7NtQH0EPuxMUeybyMTZbZQSa7fQDhMog8s
	KdxAj1k+NxnD8MVF9IjL1NnQj5zNtSJbYUfKZZarMmwwDmK/B3fLIY3Lhr61699lGFXMkEl4Nw5
	/8=
X-Received: by 2002:a05:7301:c017:b0:34d:2c1a:9881 with SMTP id 5a478bee46e88-34f21977973mr2059865eec.36.1790925204676;
        Fri, 02 Oct 2026 00:13:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.209.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f8e9c7sm4671233eec.14.2026.10.02.00.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:13:23 -0700 (PDT)
Message-Id: <b45f3cf0ab1e2dccd87cc4615e0ba15e6cc996b6.1790925198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:13:17 +0000
Subject: [PATCH v5 3/4] remote: add "git remote add --limited-fetch"
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

A remote added the ordinary way tracks every branch it has, via a
wildcard remote.<name>.fetch refspec. That is wasteful for a remote
whose history is only worth following for the branches actually in
use locally, and it can make "git fetch" negotiate history for
branches nobody asked for.

Give "git remote add" a --limited-fetch option that sets up
remote.<name>.refmap instead of remote.<name>.fetch, so that
"git fetch <name>" only fetches the branches already tracked, plus
the remote's default branch, as described in the previous commit.
It is rejected together with -t/--track or --mirror, since those
already say explicitly what to fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 +++++++-
 builtin/remote.c              | 28 ++++++++++++++++++++++------
 t/t5505-remote.sh             | 16 ++++++++++++++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..4255f8b3e6 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git remote [-v | --verbose]
-git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
+git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] [--[no-]limited-fetch] <name> <URL>
 git remote rename [--[no-]progress] <old> <new>
 git remote remove <name>
 git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
@@ -70,6 +70,12 @@ the `refs/remotes/<name>/` namespace, a refspec to track only _<branch>_
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
+With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
+that tracks all branches, `remote.<name>.refmap` is set up so that a
+refspec-less `git fetch <name>` only fetches branches our local branches
+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
+details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..f036dd5d6f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -179,6 +179,7 @@ static int add(int argc, const char **argv, const char *prefix,
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
+	int limited_fetch = -1; /* unspecified */
 	struct string_list track = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
 	struct remote *remote;
@@ -198,6 +199,8 @@ static int add(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
 			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt),
+		OPT_BOOL(0, "limited-fetch", &limited_fetch,
+			N_("fetch only the branches we build on, instead of every branch")),
 		OPT_END()
 	};
 
@@ -211,6 +214,10 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if (limited_fetch == 1 && track.nr)
+		die(_("--limited-fetch does not make sense with -t/--track"));
+	if (limited_fetch == 1 && mirror)
+		die(_("--limited-fetch does not make sense with --mirror"));
 
 	name = argv[0];
 	url = argv[1];
@@ -230,13 +237,22 @@ static int add(int argc, const char **argv, const char *prefix,
 	repo_config_set(the_repository, buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
+		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
+			limited_fetch == 1;
+
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.fetch", name);
-		if (track.nr == 0)
-			string_list_append(&track, "*");
-		for (size_t i = 0; i < track.nr; i++) {
-			add_branch(buf.buf, track.items[i].string,
-				   name, mirror, &buf2);
+		if (use_limited_fetch) {
+			strbuf_addf(&buf, "remote.%s.refmap", name);
+			strbuf_reset(&buf2);
+			strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s/*", name);
+			repo_config_set(the_repository, buf.buf, buf2.buf);
+		} else {
+			strbuf_addf(&buf, "remote.%s.fetch", name);
+			if (track.nr == 0)
+				string_list_append(&track, "*");
+			for (size_t i = 0; i < track.nr; i++)
+				add_branch(buf.buf, track.items[i].string,
+					   name, mirror, &buf2);
 		}
 	}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..0168d5abfe 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,22 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success '--limited-fetch works in a full repository too' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add --limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.refmap &&
+		test_must_fail git config get remote.upstream.fetch
+	)
+'
+
+test_expect_success '--limited-fetch conflicts with -t' '
+	test_must_fail git remote add --limited-fetch -t main upstream ../two
+'
+
 test_expect_success 'check remote-tracking' '
 	(
 		cd test &&
-- 
gitgitgadget

