Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E903B777D
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900127; cv=none; b=jJrByEdogBctxohf9dMShc+aVazVIO589Xlmw2BIgc2g5A3+vUkNkZzAvs4v9aG5igzqbHyaapvvNaPelIEY+vKE6Vayo9lX39/Hyt8W8noRm+1LFhijZwImW6D/S6jww1NW0+6P5NA7XPUwo7b/2z/ibrIEFhw5wioumEo9HA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900127; c=relaxed/simple;
	bh=P6QF6Yv8ogq7f+nx5ajqJmJOsHXiHwngTC4iLHwAwZk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gz0upIvaV3Yho6FKY39JMd1U0JfXVVhFEI7vXEsNZkcbiMqZf2aJ/LUN1L2EDuM6GaUJF8oiw+qPPxNdv68aVnDwdl0G+c5tkjAbBnRvQLynNU5RV5lSe71xvv5xkizKLTHudoXkURtyOhW81MGXXhO4nkQi03A9xO0Ih7HiZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK9hOynp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK9hOynp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-939c8c6b114so27097785a.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900125; x=1789504925; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NvMdq/CFBuovIVRZvszTk87BwOmyMMMVtJiexYaAPJs=;
        b=eK9hOynpjiQOVpwZAYdwrK5cZsGN/vVElPpTLhGDNmMMa1ebWwxaFP9D4mMdDgKT/l
         ohKc3rFmY7gd3LB4SFBYk+n0wSgaAKMNBcdkDR636WCpd0H9wTc09Wa//QleY9/uH9QK
         KQcZ+lNwAf9igxiAhT5Am7mm0PKwAgKhdiCxOUCcYDGQWmE+Fbuzx+JWdOQQUHINN648
         b8kI4T8cdhVBPlwhBZ47rx3b5Sk0ppwfjq1VUQa9r4t29xCmsK9ieBwFh9ERq3JUMFlR
         qw9oHtECHaWAVnTAudSXYuqrJC67Z0ZJq3VF4HoHPeoB6v1x/HDnoCCm1KK01NBOF3v/
         jpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900125; x=1789504925;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NvMdq/CFBuovIVRZvszTk87BwOmyMMMVtJiexYaAPJs=;
        b=OhIfrJw5kkp7MWFr9gtfZ8U6AZAZwHONmthBpocuBKf1RfxHg9KfkYfIvwhQEU1p7N
         hMlB7REkEpXKWLT0I/LwBAEJhStZA9FHGVygN0ujjIWtUZ6Yt5Dg7Gb6A3KZ1dcy8gV/
         4Oibs6ZEof6A5ZFpFhuFPFpVqHhe6vieJDbz0+maVdPO8CI/YtmI5vpbJrCrPqj8fqES
         ImyBQYBhaZNzcO8QcWcxcqfnkUaYL/BkbZpkSGWcOZK33mU2n9jobVubnbBvjOqTL6iM
         jnNzEZysHWz22Yblo4kJrwMdgl2H7yxiaCrhAVrCHvs0U1Xh3F7k6qSC1RrM98T0yfAm
         f8YQ==
X-Gm-Message-State: AFuF++lCPrC/R0JIqj2vN2jYDyDDFAxto88Z8yBaYHpgIUQhyqx1tSU2
	rXM1h324pELIHxucSK6nV9AWm3Po1WL6mMo3Obv3M/vvO7J4fRm5cKuvcPp2sA==
X-Gm-Gg: AYBFou3C+1jmBGNT4t9U0SZnCL2UdOzQgKXD50NmoGLWBpyA51KQfrYa61BLEvk6cGT
	WZQyVzAmOat/qwwMJpVN6wvW4wdcdbdSdqsuhmE8g/1XAgwhp1cmBWwXLcUDrSzBUPjrpvQH29Y
	1doHzaX+f3t58yeJDi9DICiBclckio0wENe2JyE5hKAqIIeKyOF2uE9UKq6Frtv5/ZYLglGxCFK
	ps245TPq8weakiCTU32wkL/W/4zfAB+sZkCqrtchKzdIy/0TZRZc+1lUdJnloLeNZKNmVmg33b1
	Ud7Pk0Z/wCi45PwcuT8KBcyBmEucsZbpcb5hk4WoHFGzod5/oV385NE11Xp2w5XRjzZu3yNYvCZ
	/vFlVD6DU0+xrydQHEdl7DwwFAVYNdr24+pl/+wlYonOfO8xfn3SK+qPC3CEWKqdIrQDo6E7fw0
	MoYlgC1uk1GGZqfKewyl9ZzM1WX2dbixBSMRi4J+D2Y/60ROMaEngKVhXMklkx5OCq
X-Received: by 2002:a05:620a:831b:b0:92e:5fe2:fd35 with SMTP id af79cd13be357-939804070f6mr2755528085a.32.1788900124671;
        Tue, 08 Sep 2026 13:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afaf1sm125385186d6.41.2026.09.08.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:04 -0700 (PDT)
Message-Id: <8ad1faaa9a4ab71560b4e9321886706164518e9e.1788900120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:55 +0000
Subject: [PATCH v15 4/8] history: add skeleton for squash subcommand
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
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add the entry point and option parsing for "git history squash". Pass
the remaining arguments through setup_revisions() so the command accepts
revision ranges and rev-list options, while restoring the ordering and
simplification settings required by the fold if an option changes them.

Require at least one BOTTOM revision. The squashed commit needs a commit
outside the selected range to serve as its base, so a single positive
revision is not a sufficient range.

Keep this step limited to defining the revision input contract so graph
validation and the rewrite can be added independently.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  1 +
 builtin/history.c              | 94 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh          |  1 +
 3 files changed, 96 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 28b477cd37..b660baf94d 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
 
 DESCRIPTION
 -----------
diff --git a/builtin/history.c b/builtin/history.c
index a60e8dbcd0..4f5a7a46ce 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -34,6 +34,8 @@
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+#define GIT_HISTORY_SQUASH_USAGE \
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -1004,6 +1006,96 @@ out:
 	return ret;
 }
 
+static int setup_squash_revisions(struct repository *repo,
+				  int argc, const char **argv,
+				  struct rev_info *revs)
+{
+	repo_init_revisions(repo, revs, NULL);
+	revs->reverse = 1;
+	revs->topo_order = 1;
+	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs->simplify_history = 0;
+	revs->ancestry_path = 1;
+	revs->limited = 1;
+	revs->ancestry_path_implicit_bottoms = 1;
+
+	argc = setup_revisions(argc, argv, revs, NULL);
+	if (argc > 1)
+		return error(_("unrecognized argument: %s"), argv[1]);
+
+	if (revs->reverse != 1 || revs->topo_order != 1 ||
+	    revs->sort_order != REV_SORT_IN_GRAPH_ORDER ||
+	    revs->simplify_history != 0 || revs->boundary == 1 ||
+	    revs->ancestry_path != 1 || revs->limited != 1 ||
+	    revs->ancestry_path_implicit_bottoms != 1) {
+		warning(_("ignoring rev-list options that would change how the "
+			  "range is walked"));
+		revs->reverse = 1;
+		revs->topo_order = 1;
+		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
+		revs->simplify_history = 0;
+		revs->boundary = 0;
+		revs->ancestry_path = 1;
+		revs->limited = 1;
+		revs->ancestry_path_implicit_bottoms = 1;
+	}
+
+	/*
+	 * A squash needs a base to reparent onto, so the range has to exclude
+	 * something, as in "<base>..<tip>". A revision range with no such
+	 * bottom commit cannot be squashed.
+	 */
+	for (size_t i = 0; i < revs->cmdline.nr; i++)
+		if (revs->cmdline.rev[i].flags & BOTTOM)
+			return 0;
+
+	return error(_("not a '<base>..<tip>' revision range"));
+}
+
+static int cmd_history_squash(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_SQUASH_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
+	int edit = 1;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BOOL('e', "edit", &edit,
+			 N_("edit the commit message")),
+		OPT_END(),
+	};
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+	if (argc < 2) {
+		ret = error(_("command expects a revision range"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	if (ret < 0)
+		goto out;
+
+	ret = error(_("squashing commits is not implemented yet"));
+
+out:
+	release_revisions(&revs);
+	return ret;
+}
+
 static int update_worktree(struct repository *repo,
 			   const struct commit *old_head,
 			   const struct commit *new_head,
@@ -1192,6 +1284,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1200,6 +1293,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 38cf221718..978c42c629 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3227,6 +3227,7 @@ test_expect_success 'git history subcommands' '
 	fixup Z
 	reword Z
 	split Z
+	squash Z
 	EOF
 	test_completion "git history --" ""
 '
-- 
gitgitgadget

