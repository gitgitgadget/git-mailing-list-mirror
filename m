Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075835A39F
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619345; cv=none; b=YiA5jxytR1uiBi8kT9kCmgMxbyz+kOrn9X20labEN4HifmzdLnJE6E8f+CmU3k6uBYDAENJWeOIrLBaiP+ypNjsb+sBmOYtekKWkMq9wKW/9aP3VG3Njshg/qkJe7AkqLUzi3AK+/0r8tKteaaJYtBAu7LWKNaStxRJevQ7YJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619345; c=relaxed/simple;
	bh=nOI/bylgDt7ow3Dvcym8KOQ3qu18gKP7Q8o5LYOkzJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g4r+2L82523XGE728Vcg3CWn48mbDlU30XHt/gSpJ8mcEgvWTwgpk00AnUuLu4OvW8Rlhq5m1UtDkmzqJxC0M9sJKnwWNKENDxqSkYGlpVToQL1vsmIpiO53kz6z2TMfkoPMhcS13BgF1XxQBSRNAg1qZC57govXfl0QJi+L/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQgibllk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQgibllk"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917a4b69a79so7968286d6.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619342; x=1792224142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=NQgibllkGXGM69lsNEcZwpFHPurU8oG0SGe1ap6Of3yfusVeXCvWniB9ROHUoPIGyw
         mueAPrtOK2rfPoZ7zMJEdl0bwt54aMkqoqE/P4WzT249QbDssJteHhWwNCJL7cKJX4cR
         TTN8viJagkb5T8s5kzAy7WqVvVMnxaxp1JowV3Djyp1Z3dILioT/rKxsKWy8fLC5rEZx
         /fvCyiul4te70BPa+rR2/njABowjAol576QJoBb2LynjpL/glIXUkM7CrbDobAP8ZmB1
         71riINXFCO150+j9hzlihxelyjfI8HHx4ImfOGvduaR5jZ1ealXbYCVyQEgfb0krbSxQ
         RKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619342; x=1792224142;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=qpKon4JmIgWHqy++RbCcWc3liEDZc+roIxFBaGdmsqLYEdxzBYZmzME7+/8jwHyVHg
         QEZM9AKJIBrTZBEQ99H/4zTVnJXXqJRVx44VeQ6nsb5IyLL2/SSYbANRvo4eAib8kINp
         ReQoI0BICB+vZZn+ruWjaojSNI2p6OK9Mc2FTxcBU4i/IsMitcaI4n2j8suv7/1M521a
         eMsO+1Gz35fsJOrNrzSQMhJpHoEcXF5q19D7yWQlgh/rsnad8+HgQ+cWU8VIp41rWX22
         IJErAvJR4moZaBfYemfViNBYJDoKl/XcBjpEYZqypSY8KfnBWmEGNxkxg2Y1UmCuxKKQ
         5x1g==
X-Gm-Message-State: AFq9FYKoRPmDsIPj7wJa5x0ZA69thtmqUa8M/7d8zaSnH8DZqeFG+uWf
	GiOrk4IvcLFuTG0F/GK+bbLQrOf/3qFIY/8nim0vBfS8MToPsfBcYMwO1IrqxQ==
X-Gm-Gg: AYBFou2dxc08rv+Jfa94qk8cvd3oGZ0aUiueUc2uKblgbK8rvA/otzh99qpnMlRfGXp
	V/hvoeRIeE2YF3VNW6bCZYmXg0/ylGSx2+kk8BlhjZVNClFPKPGX0Dcentoz20kKNaxFYb+EqMx
	pQpvxTca6qxHtuxOvexxHzJBELvjYCeOG1HwNQQHs+aW9nKhDkvsMkmGBHz1sqWW4wa7/PaQ424
	Nk+Gbe75Pr07eADOttiAiWJ7rlYqTgTQr2fkAM9mcmxAxIQ0W21ffh2j4y23TJ4EmbK1sxPwz5d
	92b9Se+rePVkabVMeVW2nyIDoGs+W6jLwX8xUJUsz52XTt75NYZuwTptBEjT6mD+y6zymeLVJDo
	HWoP9geemWTl4/IjKIxilg8OPUEI8YLHzmaHDchrw//CK1MzfFCZbWjgnNRHfP7CrpqydN4lwXM
	padFwQaaPyLVppLMNA3TISM1gXpjHAMRQtY4h6GzwYacawdOrRFP6HSSDH7J4esnjgSRrFVrrlU
	Mk=
X-Received: by 2002:a05:620a:458f:b0:93c:8984:424 with SMTP id af79cd13be357-93ebd24ed1emr653328085a.51.1791619341755;
        Sat, 10 Oct 2026 01:02:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9896ac4sm367567285a.31.2026.10.10.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:02:21 -0700 (PDT)
Message-Id: <2b974bbe0a1ff1f70944a2db9d996c0c283bd3fa.1791619334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 08:02:13 +0000
Subject: [PATCH v8 4/5] remote: add "git remote add --limited-fetch"
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
"git fetch <name>" only fetches the branches already tracked, as
described in the previous commit. It is rejected together with
-t/--track or --mirror, since those already say explicitly what to
fetch.

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

