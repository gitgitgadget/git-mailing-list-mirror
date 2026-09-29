Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7B4E73AC
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673613; cv=none; b=J9+qJ9AizTIz7AtDX3NxjdHNCOHe4w0hG+mySst89yH8xp3Shjj6bOefzkoXQN0ak/MOEzh7V9lpwe31yTAbBm7QGtxlLVGb4DGc7Ao8IA3ECeSdHFNWgm0sMpdmnj7Ch96Z9HnTxkfxXx+Dd6w4MdHCZTWPZ6Kf99O2IoSIJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673613; c=relaxed/simple;
	bh=rY392n9b6eAlwnudVUP9RL0mDx2Nr530DKj3NAEh9lQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f0i4F3H28IKFFGwGS7GsMWGv8V78Kwd/Z3T3zTRxlQMq9zQdy3dBM5yf9TNGn9uVpW7LZrSJUhjQeap6jiOHKNfm82TcVOG89/cRs6BRE2oCVMBuBZf2xi4NVoSVqVLQumuTae7SmxKSrpgdNfSZZfQ/mO4gcPSk1PjaHFRSUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoGUEIJM; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoGUEIJM"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-916304a1fadso3560036d6.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673601; x=1791278401; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EBCqv2hSk+dzqGPOEy5CnMtAkJ0QGs0DxLEXX6HAczo=;
        b=QoGUEIJM9yIDPr8rwaE6isJwFb3dJzR5oMHtKVsV6e6dIUeen4ujw+MrcaF7t59yCL
         BQnzRHgLcQoB7NTlrlp91UQ93IsIubgtZuazvfRRTBxij8eeN8HpICCkBRd058HsqxgO
         Uc5bLKqS7mIcBR7T0eC+IQNoO9zOMcrtkaUFK1gdLvep3vQ6GQdrNPlB4Qp76Ewp85rr
         60Daw2PDr5P5WTiEtMBKQi5HOpDxrx3PWszSDY7I1i9ywy1bGThJ/z3M/fvtRYeND6/v
         JmF/PnJioRfzbvafn5xtR0ucPqrVp85wZIidGVESDlm/vodWY7geeceSnchBSSPBpJVs
         9WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673601; x=1791278401;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBCqv2hSk+dzqGPOEy5CnMtAkJ0QGs0DxLEXX6HAczo=;
        b=v/4luVBITmQ6kvnPCrrcGY1a2AI0HKVhObWjlug5IF3mVyZpN/FCWcI/+0X3ewDJki
         GCCzEhSKnrsw/vF+lAwaEJf1Agw2DuD1x789QGmBeBx0V9LAGGXSSC5y+gSqPqg9ge55
         zIceactf/Imww5CrEFdMwnn2DK/CjNMkVwx9/INIaNy02+b9mYXOLgf3rWADk+YU/Nt4
         wQpD/bjKwyLOATFPgRaiVcscPwlsADRVARBCfBW5benrQI53T1rrnJjYEFs0Rt8pTCJR
         oZ34apLVIOgV4QHZCe+Dv5pUQWfKhYjzlhI4jP0V8X/qJXs3FQmF/pQ0Yu1BkjSAe3YW
         FlIQ==
X-Gm-Message-State: AFq9FYLJ2DdWGWV0oSWQG0N9oGGQWbinGWvs3gQUDbhM3SNNQDxz18Nq
	ecaNzv2MkTzyS8mHokrHZPG0iTuHJsLKkAL9Se7LU3CTU895/1mjhDzl6lR6xg==
X-Gm-Gg: AYBFou3hIjtU/hZ6VN8LLZzKVXjEiqrF3of9VYA7Oz02A/MvoWArK1biw6RR4Tbi6V4
	xtzyGklvfH9qqM+ut9prglfR880wEf8w4Ps73Uo0UsRtcNvGPK02t9uFeZvwB2I2drjJWlMWjcg
	IGy7fJFbe6g8fvPx11dK3mJF2eQzRvqaGvXTbU6YJuoAMKTsebZfF0N6B09hJWUdhqeVjSABQdJ
	KTV8Ogd0KIq9D4Evhm9ENXQGYaocjtNtbhMrOLGyUF6De5UqpQIlHcMbMbaiEe1+QBuFRgWjK/U
	LhQyiXNKVE51nsKx45ACVfAmmysHQ5s/Gym+IB/xmS/qXCu2shFzZSnxs6KhSptkAUJ1nNGcRaJ
	ahs9ppsgrr34PdW4dBCiF86CIIUgHSNTary8KG5yontaXGguE9ipcwssB/egwhyIB4eLMOVLpQD
	47HICQ1KlgkolHdQY1cxOH78yheAa1T3hrmkn4E6iMmZjp1uHtChdzqpWrEShRJopVN6EuqThDw
	FAdeMYXdot2Iw==
X-Received: by 2002:a05:6214:5bc5:b0:914:3120:b7c3 with SMTP id 6a1803df08f44-917863d2575mr32397316d6.7.1790673601110;
        Tue, 29 Sep 2026 02:20:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d013e8bsm6384496d6.0.2026.09.29.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:20:00 -0700 (PDT)
Message-Id: <d48a7004e409952cd1be104840a83168e5e72659.1790673598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 09:19:55 +0000
Subject: [PATCH v4 1/4] fetch: add remote.<name>.refmap
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

Add a per-remote config variable, remote.<name>.refmap, that provides
the default value for --refmap the same way remote.<name>.fetch
already provides the default refspecs to fetch. Like --refmap itself,
it only maps refs that are actually being fetched, so it has nothing
to do when there is nothing explicit to fetch, on the command line or
via remote.<name>.fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |  5 +++++
 Documentation/fetch-options.adoc |  3 +++
 builtin/fetch.c                  |  8 +++++---
 remote.c                         | 12 +++++++++++-
 remote.h                         |  6 ++++++
 t/t5510-fetch.sh                 | 17 +++++++++++++++++
 6 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..103eada406 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.refmap::
+	The default value of the `--refmap` option for linkgit:git-fetch[1].
+	Used to map remote refs being fetched to remote-tracking refs to
+	store. See the `--refmap` entry in linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 035f780e58..538914bc6e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -244,6 +244,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.refmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..7651b41139 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -509,6 +509,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -552,14 +554,14 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
-	} else if (refmap.nr) {
+	} else if (effective_refmap && effective_refmap->nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
diff --git a/remote.c b/remote.c
index fe62068463..017cd9d13e 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push, the_hash_algo);
 	refspec_init_fetch(&ret->fetch, the_hash_algo);
+	refspec_init_fetch(&ret->refmap, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
@@ -176,6 +177,7 @@ static void remote_clear(struct remote *remote)
 
 	refspec_clear(&remote->push);
 	refspec_clear(&remote->fetch);
+	refspec_clear(&remote->refmap);
 
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -539,6 +541,12 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->fetch, v);
 		free(v);
+	} else if (!strcmp(subkey, "refmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -988,7 +996,9 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return refspec_find_match(&remote->fetch, refspec);
+	if (remote->fetch.nr)
+		return refspec_find_match(&remote->fetch, refspec);
+	return refspec_find_match(&remote->refmap, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index cca02033b9..ac485a584d 100644
--- a/remote.h
+++ b/remote.h
@@ -90,6 +90,12 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * How to map refs fetched without an explicit destination into our
+	 * own namespace, the same as the --refmap command line option.
+	 */
+	struct refspec refmap;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a8d38d9176..bd853d0a84 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,23 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.refmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.refmap \
+		"refs/heads/*:refs/remotes/other/*" &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/other/main
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

