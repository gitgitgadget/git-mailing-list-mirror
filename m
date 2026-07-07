Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876D3C8713
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408911; cv=none; b=YQiB5gPGMj/zjLyLMGdxRiYLQqkEihB0/Z5sCxt7jqOlbny1KUEExZ0/Rjf6JK+yAEmrmgmFqYGNGWBdYm2mCAjLyVrocmkrHE9B2+NHNf7ScEJ7K29yLHHdUbZGLCrTbkImj0WBA43gXqj2Z1WK7quUERYUSKVFfm9J2VclzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408911; c=relaxed/simple;
	bh=lLn1j9NxUbSRP8+X4Jrl0o8I3HxqVVz+YpFYOWKXUCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiYBkkOrcK7vKQO4rXOE6UFMQUImxfgQoScb2jCKr9TMiJVb6+rAhyG83LgSLwJzUUkJwWmCFr6QDx8hFlKct8wnHfe35XrTToLNDeywjVJoCOU2gVx1zDecJizOJdv8ze0bkAeGxLXPDgKE6OjG1h+n33gTjON9t8qQ9zaNC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Glly2VPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ijp6qeZ+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Glly2VPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ijp6qeZ+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B1737A01B7;
	Tue,  7 Jul 2026 03:21:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 03:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408898;
	 x=1783495298; bh=81KHUb37BUoT5kYvNfL1bzDTBGTlUIm6wi/N40gk04c=; b=
	Glly2VPoE8A1TertqgG/Krij79EZ19Asa0ASuZnFei+Ic3h8z645kBR5jj++sygL
	Dx3gaNcFfUP/MIoKtwho4E6nSUm1fTD7GXEE1W49L5GLknQscOpLiQtfrLbA88OM
	tm+zIeb7GPEmPlkBN5nwiAVBa/ZldCYun8/TG5H5X4BCdA/1jK6MOXGVocWZo+85
	AK9kyPMg5jkRvcTZCYbvVZmRKmjGQbHRMPcOfQH29sQ8Hqt6hURwO09Kq8+9jB7b
	h+1a6nJpjm9+RFLKiI46nqz/YIdluWD72PleSdV4Z2tCNP6j4aE4mGBgMZzRnv54
	rA4o5RMIhKa+Gna4JQD+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408898; x=
	1783495298; bh=81KHUb37BUoT5kYvNfL1bzDTBGTlUIm6wi/N40gk04c=; b=I
	jp6qeZ+Uck4v6VfEVxxprc6qgpb/ZnhwHz+AjwRb7NTS4xrRufS8F/mVYOsYlG8o
	a82qQ5xhhekRwUMQmUZGLwzdkiLMS9jjZvxajUdP8phN842hEz+QCnj8Dz+eD5lD
	iy/tR28LOTxe9KmSFghF4q48phs61ehzgS2bV/B0OAakBUCEcaypKmFHRYqAdDds
	zEhyNegwtGJhduMHPv+oX18AGP4Gc66EvcrQmJm1BzGCPXSg2d6jFzvAHRutk1yg
	+sLKGNpkSH0x9zdS6h9bWb2V3A8rltPo7b3+XPtWCdYzSHTco0P/IQjKDWAS2fES
	f6MI+1gh8tPAWXT95Ag+w==
X-ME-Sender: <xms:AqlMalZPPx4prOHDOvQyqlvbPvqSEA4lF36TUeqkv0erNV3TR1z6pA>
    <xme:AqlMaj0DVitwuBf82JaG4bfJ8HF3dEsfJWpWeFCvIW6J2tSn9PlujOxmMaVVsdBhm
    F-TJGFrCS0P1Ak2qNbsVkVSFCnnQWm1_mF-_MhhXPhzhpjfsdlBcA>
X-ME-Received: <xmr:AqlMalU3QtE5T7zgip69WdMoJ2HFB8dZWtlFbBHyzc4VENsxj6LpmdTUk6DkGAptaxkqgjdY_QYpasdO46C8XV2A9-c9JJHa_SM2i6xC9w>
X-ME-Proxy-Cause: dmFkZTGN43lq7lHtzoztmsp2ha3377ph9aD/+BVx8B3RlzKxJTITPwJpgbD06HEEJ5Ah07
    0LxTetEuoADDN+Mls8RD45ALjsaPLIReBcQJPOvQPTry8ULvEMzVHzXlYRPjSpMIeerVH5
    p8Rmz3b79H9S7nsP+1mbJhQJ0dy0Xv8QbVJni1FpZizZ7kpWPdWX++YgEoJpRO2Tl8a45W
    5SlNg+T0N5LSUaaqyinki7fdkmBnThGqUuHMxdk/nHtieM4TbfGnj2CEBrJs4aOV2HRq59
    IgODDry8R917oTbxnFbKbkjSTMUTDvzcg5AUPmrfe2SFRp3e4X2egtqQl3BbleTxAhjAm4
    dDS9SdPcX2zA3pWASM0xDkpIY56AJFJd0JJltO0ibMHP+juvCaEH2l88O1iBsQjzzS6+hm
    /VKpC5VemvSd3h0vrYqIHoXczVTDaBfnfW94/NL7SPXWx3PoIPaVeleKF95227BCSRcKAZ
    ohtKGVk+JWa+dfjndbUwIQtdNhhdJMMu4mrBFsOYc8/YZLgEL7nJpuoTSX1qTFSw/qfNZO
    fwB9UcYqEffVHYL6l0vftfJ7fIQGGF9coiCfxQI9eO8AQXEP0GD9pKFqgCkezoB2bEDMjV
    0swa1PWwRqx3CtkY8zcoOKTMjLac6iSn5INLeLLVqfxPVcRYtMsiAObSxCTQ
X-ME-Proxy: <xmx:AqlMatVwDjiodriTeNxjr1k5d6LQOn7V1BD8EJSF1hsOUo9XDAgtJA>
    <xmx:AqlMakfkQvxHB48zhL2G4mdLpDjlqELuwmZkxRWDFEPj-lVHzqSk8w>
    <xmx:AqlMamV9mI8M4_uXTCoKHPjrteabgadgtelG-zgZqSW7MLrmkrUvLQ>
    <xmx:AqlMatcrhcFhgCgn2oVLGcCR7Y58UlX85ssIK_DchvmOcLo40bKMSA>
    <xmx:AqlMar07lODEe480NMSOUSNbC9oLYcnNR4E0_bPd4bSQ3O6xDoQ5zl7f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fec06953 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:22 +0200
Subject: [PATCH v2 03/13] setup: unify setup of shallow file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-3-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

It is possible to configure an arbitrary "shallow" file via two
mechanisms, and the respective logic to handle these is split across two
locations:

  - Via the "GIT_SHALLOW_FILE" environment variable, which is handled in
    `setup_git_env_internal()`.

  - Via the global "--shallow-file=" command line option, which is
    handled in `handle_options()`.

We can rather easily unify this logic by not configuring the shallow
file in `handle_options()`, but instead overwriting the environment
variable. The environment variable itself is then handled inside of
`apply_repository_format()`, which is responsible for configuring a
discovered Git directory.

This new logic is similar in nature to how we handle the other global
options already, all of which end up setting an environment variable.
So for one this gives us more consistency. But more importantly, this
change means that `the_repository` will not contain any relevant state
anymore before we hit `apply_repository_format()` once we're at the end
of this patch series. Consequently, it will become possible for us to
completely discard `the_repository` and populate it anew.

Note that on first sight, this change looks like it might change the
precedence order. Before this change, we used to configure the shallow
file in the arguments handler first, and then it looks like we override
it via the environment variable. What's important to note though is the
last parameter to `set_alternate_shallow_file()`, which tells us whether
we want to overwrite a preexisting value, and when applying the value
from the environment we tell it not to overwrite preexisting values. So
in effect, the command line has precedence over the environment. After
this change, we now overwrite preexisting environment variables when we
see the argument, and consequently we keep the precedence order in tact.

With this change though we don't need the final parameter anymore that
tells `set_alternate_shallow_file()` whether or not to overwrite. We
only have a single callsite for this function now, and that function is
itself only ever called exactly once. Remove that parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c     |  2 +-
 setup.c   | 10 +++++-----
 shallow.c |  4 +---
 shallow.h |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/git.c b/git.c
index 387eabe38c..e5f1811b6b 100644
--- a/git.c
+++ b/git.c
@@ -306,7 +306,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
+			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
diff --git a/setup.c b/setup.c
index 1d8c193375..85fad0d77d 100644
--- a/setup.c
+++ b/setup.c
@@ -1046,7 +1046,6 @@ static void setup_git_env_internal(struct repository *repo,
 				   const char *git_dir)
 {
 	char *git_replace_ref_base;
-	const char *shallow_file;
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
 	struct strvec to_free = STRVEC_INIT;
@@ -1067,10 +1066,6 @@ static void setup_git_env_internal(struct repository *repo,
 							  : "refs/replace/");
 	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
 
-	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
-	if (shallow_file)
-		set_alternate_shallow_file(repo, shallow_file, 0);
-
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
 		fetch_if_missing = 0;
 }
@@ -1774,8 +1769,13 @@ int apply_repository_format(struct repository *repo,
 	}
 
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
+		const char *shallow_file;
+
 		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
+		if (shallow_file)
+			set_alternate_shallow_file(repo, shallow_file);
 	}
 
 	repo->bare_cfg = format->is_bare;
diff --git a/shallow.c b/shallow.c
index 07cae44ae5..c063b3deaf 100644
--- a/shallow.c
+++ b/shallow.c
@@ -21,12 +21,10 @@
 #include "statinfo.h"
 #include "trace.h"
 
-void set_alternate_shallow_file(struct repository *r, const char *path, int override)
+void set_alternate_shallow_file(struct repository *r, const char *path)
 {
 	if (r->parsed_objects->is_shallow != -1)
 		BUG("is_repository_shallow must not be called before set_alternate_shallow_file");
-	if (r->parsed_objects->alternate_shallow_file && !override)
-		return;
 	free(r->parsed_objects->alternate_shallow_file);
 	r->parsed_objects->alternate_shallow_file = xstrdup_or_null(path);
 }
diff --git a/shallow.h b/shallow.h
index e20ca4c21b..6a64db42c9 100644
--- a/shallow.h
+++ b/shallow.h
@@ -10,7 +10,7 @@
 struct oid_array;
 struct strvec;
 
-void set_alternate_shallow_file(struct repository *r, const char *path, int override);
+void set_alternate_shallow_file(struct repository *r, const char *path);
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);

-- 
2.55.0.141.g00534a21ce.dirty

