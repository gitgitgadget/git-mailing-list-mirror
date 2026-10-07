Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F5414A0A
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410177; cv=none; b=um/bzK4PQngaizvwjJyPAlOUzd9d4eh69K7XGwlDO9Cw3ypW20ZMoutJmSuRT2ASNMUibWVeyPxlvjq6kuG+LS+4vHtM721V5Km3u6CQg4GpI4lPO3V10ly7GYLMIQYRiKB4m4TbbhzJbMy8fRV+kDIbtHyMqo3p8v4QpF1xDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410177; c=relaxed/simple;
	bh=nOI/bylgDt7ow3Dvcym8KOQ3qu18gKP7Q8o5LYOkzJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NV8YDrMNgGyCtxtF7J6dXgZOEv1/+rk3dA6LCJC9PwCRQ/FPsfvGqHbLx1c/ZlpTjVt9UIDGLNXYvD/E+ZYTp7nWv0qx1dUv+ihrnoGCx433gBKJwYCVsmy7p8fPdmcvHpU24ZXPLNyyc/WVOR+YCqT+h0O9iuR+tUM9e+3aDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjFY7hVP; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjFY7hVP"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-455ca262ccbso1668625fac.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410174; x=1792014974; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=YjFY7hVPtwx0MlByhto2ZI9ZEaECEpGGFoib/GsO64UB2nYJ9KSj1vZqoWCPZl+VOU
         3rrrZQdO+tHsVxhyQHtwuA3t4gPQAcosT4f73egx2B2gwYKmPRTtugvyoakJFIgBIrKa
         7XevpzTvY42QmbWzmehv28XWnzDbW2bdmFlX/zUsckQdGe62juoXPdkOIbGowYfQhuvD
         C6fkRMB1LqZP0rv2P39L6fYtZok12GdyxI4fdVT/+ZSKRFdLfSdUkDUmcms1SuAnfl3O
         WHR1zTaIxKEESVU3k8y/ZxYiKbyorVs1b8sCQEnkX/F9N2bBslO7SeLHP3llwuw624l/
         jJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410174; x=1792014974;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=kHERIu3IWqnE7eU3LAZqNjkcis2c3qU0XpmKp4NdCwcV3xKEOqiT7RuKiX1uRwpQc2
         xPVOwjseOZoPtzE4IPwD0C0LViJKp+64PxA/3yt2bw7xA1gbOR4SxyAGk6kaAD4XGLGF
         cgnNSXdRP3LvpS7Pv3YXuWVtV9aVdYKjnXXlkj/WKZIjW4PZTT165Wke4/IaIpacZxQ6
         GIO87TkDprmOxxTN6B/GvQ8fVK0H6Q242R1tvuZpTewpvEwbB3/RR2+jUWN3alE6VO/B
         sjpzcZ9xJS8R3S/O5FmeX+jdcv4goy46L79JR6psnVbkVzHqnOcverBQU/ezQF7Ntaay
         Qs4Q==
X-Gm-Message-State: AFuF++mzgJ+QBjqhU4udR+jrFPRdvGRLw2Awv0Cyt5pbBLkMrGj6Iu12
	b6Ymv9CZhqjjmrsC0zvfnsfOe8PkHCd/mJb/RzxUim3yGAR8j9UoasbAhEnHOcul
X-Gm-Gg: AYBFou0j6pW+Q0RskyJ210dWRDdlI3giVdmFte66A6T80oCrSKrdyq5sE9BPtmHeciB
	E8TdKz67QVN1OV1dfl0MCllwnjnSvgqt/mR8YADa/LNjWsdfinNCzgfs0juzxOSksR7EsLxtM+2
	vO3gv8tdL4ZhdTDmCJEx6CbRcphBV7rH8gBZ/KcSPHwlnr9w4Z9pGIzLa9kILSiMZ14fgziYHz7
	IEOFxIuUJ2GMUGSxL2gGNikKTu1XC4FcYyBXrcryLZUxyQaAcrCEuARMh9Ccf61Xjju/6CZHszo
	PVRtc3QaInTxz7FfT5nVEaDk26yCOpOAU98dUxIfqSzAL5MAlMIJELmNlyYrhkoN54SAz2+C+us
	wS1saDtom3T/CRyjQ9mr4NHxSsm4dGI4SbbJ2a91j4938mGRgB2uyuRsv2MOkpaLdujUGKQOIHs
	cDUEgV3Lz+/FJtz7xFhHYnjJ0p3kxRCeURG2aTlsp3BmC8VNmcshSlAgT8IqnGEltT13SZFuXVs
	jBQ
X-Received: by 2002:a05:6870:812a:b0:494:116a:b0f1 with SMTP id 586e51a60fabf-4a25942acd2mr3478509fac.21.1791410173881;
        Wed, 07 Oct 2026 14:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.134])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a274b7ca62sm1484149fac.9.2026.10.07.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:56:12 -0700 (PDT)
Message-Id: <a2208875b66546330ab1d0ae3632b3a01ecc5d5e.1791410164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 21:56:03 +0000
Subject: [PATCH v7 3/4] remote: add "git remote add --limited-fetch"
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

