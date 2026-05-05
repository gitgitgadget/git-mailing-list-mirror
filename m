Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD873C456D
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009049; cv=none; b=l/vdyMyC3JcXl2/7tD8f7LPxd0A5XnCqdMHUvhVowPr0HEGoFjCl62Zt742CSy2sqv8RDW3WNMMc/ZxGfftPtI1P1CmXUm/+fRFodl57gG8cQWkjAdo6vkkNlsRS3ve/URfA1o3m4k7hQAxbek/dYW4zYXbDcHJ5fhP9JtbiFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009049; c=relaxed/simple;
	bh=1gcUePTcjxKfedR/adt+cIzlkWB0vnvfbO6MYGKgTsw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RNkrUKDacfmDF+9aMhTNCDJctYLE9mJ6Hx9+GLZxn1APJp9XY/mKMJMqlKHj9qccyUHKG5dCCceuoZzA0FJvB9z03bU8qNvclYoom5QYIJ1kiWaGuDfue+svtS/DVkNttMHZAGi87qevqw50kaNswMREHmNbuyi5PH0mhtiqZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdmWxRBh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdmWxRBh"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-479dc6d26e3so3174367b6e.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009047; x=1778613847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHmZh4duX4oine/vSRhojzu/fu/W0t4JMuffp91h5Lg=;
        b=LdmWxRBhDAIzQxydHJK2vQRp1sPeSFq//9k79C+mXNKlflsBUi/W+99iEMbiZ2nazG
         l1lzt+ZnW5mgD3c55DAElwl75x66XFyL29AE8xruYFq4qWqtoUuZnhZwKe7ShYV4eeds
         xVjeNAkjblGRxt4k9ulfm/tO4O1xKOvXUQqBwZ6E1qI/gEdeJUk697IHKGfLFoMJShqb
         3jkjt9Iv+8EAkQxpXJY+wrw9GZApHenSjW08YmfurDQWxWie5t/M9McLpuxtMV8aoJyE
         atUweHDg6IdwjZwe26Ol+6CsumLtzVLOuUyR+VjsOyTQaqNVFGwJvqfBM/Tzy0tzNlyp
         nXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009047; x=1778613847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHmZh4duX4oine/vSRhojzu/fu/W0t4JMuffp91h5Lg=;
        b=TfuMFp3H5K937+/he0qhBsOnh5KaH+/OPix52mJFb4v6yRkmXZK59eQE7ceYtkRkp4
         PJSQ4UnJMfebIiBByPxsOAN8hwIpklJpuX9AKvwnL2cTvzjALPySRCVYn75zMWercKq0
         XCaEAvPPew/TfZSxrc8m3ufcz+fd9hZpyY4Pjkivla8Ujt4rnw0BGRDm+eamrvjMOxFx
         Frf4LF2HgV5vjlNgV/ab9Nu+U1IBwhWBYsVFu/9CXK6EeUFDrvH7+pzEvbXQPqtPgIdK
         ioAv+9FpSQrPtayRyFqT/ZuTeo9BISdcKOHmmkPQHJmZwqcTc+TQY4n1n1PQwte2ufRB
         vh1A==
X-Gm-Message-State: AOJu0YyD2Oj1uCJDUhhTUSs2kETCk7fjlEY4Fuue2ztE34fg+09YquL2
	tsvkZE8qRRfblaZhwpvS02/G6DjmhmfUWo0fRdppLZIi62RQl//KEIXw8UZD+w==
X-Gm-Gg: AeBDiesVJVypDe88U7oYFXmizTRHlNg6KH1wb4TLszaqQPVB7pdw5i0zN9gzIODihoY
	BBd1eulgqiw+WOT3dI2Zt3QRHB9kOUvxWyOA658M7V7XPDTgcJDBU4fj1P8YHjoSO9IVmCoAvdF
	oaoPyGySc3HrslLh5W77svu2OHqV1KMewNUYl6MdbRDhMWzwZdAxoCeCClFOnOJzR+ONrgPBS8h
	qZh5pokq2oWl+LkT5qGYgFpKSTJCZ6jzoPCNg+fV1NERKrzGL3i0qptarEj2CjNWafHM4TkuLEg
	1ABa3dLRu917GviSEWm+7Chohed3CWTiG3ojJJIiXE23RRpLLwJO1AUosx0kkrl+bS8AxyXCxzp
	Pqs42wyBWKbx80HMHwKSfJItceHEKmvDokTFDt1QLxivJvysaSOFnXUn8GJmYrjMhonTgSOcVmZ
	E7QhPYf6+iYwsVCjPEZ0vrT8jP0OpWG9bcfmP8
X-Received: by 2002:a05:6808:2507:b0:467:2a6e:ada8 with SMTP id 5614622812f47-4804230908emr248827b6e.25.1778009046893;
        Tue, 05 May 2026 12:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.21])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935904sm9047739b6e.11.2026.05.05.12.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:24:06 -0700 (PDT)
Message-Id: <98cfdb87d26cec5f91ea4d8ce949512d60958e56.1778009038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
	<pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 19:23:56 +0000
Subject: [PATCH v4 4/6] fetch: add --prune-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After a successful fetch from a configured remote, run
'git branch --prune-merged <remote>' to delete local branches
whose push destination ref has just been pruned.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/fetch-options.adoc |  8 ++++++++
 builtin/fetch.c                  | 20 ++++++++++++++++++++
 t/t5510-fetch.sh                 | 31 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..afbd1f60b8 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -185,6 +185,14 @@ See the PRUNING section below for more details.
 +
 See the PRUNING section below for more details.
 
+`--prune-merged`::
+	After a successful fetch, run `git branch --prune-merged
+	<remote>` for the fetched remote, deleting local branches
+	that fork from this remote and whose tip is reachable from
+	their upstream remote-tracking branch. See linkgit:git-branch[1]
+	for the exact selection rules. The currently checked-out
+	branch is always preserved.
+
 endif::git-pull[]
 
 ifndef::git-pull[]
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a22c319467..5451bf3b5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -82,6 +82,8 @@ static int prune = -1; /* unspecified */
 static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
+static int prune_merged;
+
 static int append, dry_run, force, keep, update_head_ok;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream, refetch;
@@ -2189,6 +2191,8 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, prune ? "--prune" : "--no-prune");
 	if (prune_tags != -1)
 		strvec_push(argv, prune_tags ? "--prune-tags" : "--no-prune-tags");
+	if (prune_merged)
+		strvec_push(argv, "--prune-merged");
 	if (update_head_ok)
 		strvec_push(argv, "--update-head-ok");
 	if (force)
@@ -2382,6 +2386,15 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 	return;
 }
 
+static int prune_merged_for_remote(const struct remote *remote)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+	strvec_pushl(&cmd.args, "branch", "--prune-merged", remote->name, NULL);
+	return run_command(&cmd);
+}
+
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
 		     const struct fetch_config *config,
@@ -2457,6 +2470,11 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
+
+	if (!exit_code && prune_merged && remote_via_config &&
+	    prune_merged_for_remote(remote))
+		exit_code = 1;
+
 	return exit_code;
 }
 
@@ -2520,6 +2538,8 @@ int cmd_fetch(int argc,
 			 N_("prune remote-tracking branches no longer on remote")),
 		OPT_BOOL('P', "prune-tags", &prune_tags,
 			 N_("prune local tags no longer on remote and clobber changed tags")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			 N_("after pruning, also delete local branches forked from this remote whose tips are reachable from their upstream")),
 		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 			    N_("control recursive fetching of submodules"),
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6fe21e2b3a..b94fd2bda0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -386,6 +386,37 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	)
 '
 
+test_expect_success 'fetch --prune-merged: setup' '
+	git init -b main fetch-pm-parent &&
+	test_commit -C fetch-pm-parent base
+'
+
+test_expect_success 'fetch --prune-merged deletes merged local branches' '
+	test_when_finished "rm -rf fetch-pm-clone" &&
+	git -C fetch-pm-parent branch one base &&
+	git clone fetch-pm-parent fetch-pm-clone &&
+	git -C fetch-pm-clone branch one --track origin/one &&
+	git -C fetch-pm-parent branch -D one &&
+
+	git -C fetch-pm-clone fetch --prune --prune-merged origin &&
+
+	test_must_fail git -C fetch-pm-clone rev-parse --verify refs/heads/one
+'
+
+test_expect_success 'fetch --prune-merged skips unmerged local branches' '
+	test_when_finished "rm -rf fetch-pm-unmerged" &&
+	git -C fetch-pm-parent branch two base &&
+	git clone fetch-pm-parent fetch-pm-unmerged &&
+	git -C fetch-pm-unmerged checkout -b two --track origin/two &&
+	test_commit -C fetch-pm-unmerged unpushed &&
+	git -C fetch-pm-unmerged checkout - &&
+	git -C fetch-pm-parent branch -D two &&
+
+	git -C fetch-pm-unmerged fetch --prune --prune-merged origin 2>err &&
+	test_grep "not fully merged" err &&
+	git -C fetch-pm-unmerged rev-parse --verify refs/heads/two
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf atomic" &&
 
-- 
gitgitgadget

