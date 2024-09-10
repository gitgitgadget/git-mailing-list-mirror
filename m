Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D5175D5E
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935352; cv=none; b=FTr78Jx9Q51VIqzpRu33w174fou9J63ElvjpK3HdpfR/QLaBchwCh/xJI9kkt4aSQZLD1Im28MfA1PgwHydr4BqqX3a2kzNbsCOjJe4DeYVLsTzeVA1eDl6EGVreYfHtRoVmpeX3YDeVSeapfp2Te0hon0I3cXjjvapbO9u8UaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935352; c=relaxed/simple;
	bh=QkNCjheZJf97d3eT/AcgVlvKzl8U8AevTnI/fn6r8Ww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S7cYtEKPQwolOFUQpk5YXgP22aPxzemBq4NVtHubQYx28W/zuMPa/cOIW65ob1WcfjebN9AVqncJ1de/667ywdW0qXq1ahlN7keo0kL+yAvgKKdjyDa7aCBw92xV5YJTBAL7U/6OTHWLPsAtNd3++kDSqMFpap3uou2W6pqFtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmKdTxaH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmKdTxaH"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so6100060a12.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935348; x=1726540148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+b6DMYyerKciEpsy0G6dMm8vyY33u469IiHYEKCKfQ=;
        b=HmKdTxaHFdRHWmmL6XyTceQSMpDAaL5H0jgJOJl1tfM9Hl6euDsZIZNSqdQRtx4Xt6
         mqXwyxCSA2YHEEcymyjblPZ3djInCfT/C/4BN+LmvNaNa1JVvNBnHXFRL5c0ZwAa8YsG
         xOTiBSdrtBbBrjUkbJEnbD12yeABawK+Z7OEYZg/a1UqMsdgE7XdivKYmhvWmbx0t9wP
         49vzX5XzAdvLq0JuTQTNkJ+HkY6kbmS9m7W2dt8wBGPvsKYcpm6RvzVbMttViQxQxw2J
         7+vfz1cU+cpDeVxDZ6iZJNafRWrIzJcylQQRwbTD9RlXWRjNl2TgOUCwNutETiGy1u15
         Posw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935348; x=1726540148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+b6DMYyerKciEpsy0G6dMm8vyY33u469IiHYEKCKfQ=;
        b=EX1tj9F+Elf2asLnQF1cUx1E6FCjswzpPtodz9QPLDkwJIHAguI4slZlddvyV/lT6z
         wb0aXM/5pwveYxm3InxtdSFChT+89HhP4veK9JGm8+RuNqpNbCdFqjyr1kC+e5HeEB87
         J+Pe+xoP/wKNMvNkUNjKtHZvBmhSyZuGmXB+rkgzPKNcWR1nQr6FT/m1VPmgDeBvsaIF
         Do6YEGlkVpB/v6te4OhN/U0SAzdknvKSkY8KjywJfEHIfSp3F9MiyFIdyFcn5ed2wfZx
         r9rtaZuV91OuUgnknyxUzkQpxnkJ0wSKoMjF5l2tX4H4g6bS/8OdWmP+vN1o5T/IoEzN
         hfyw==
X-Gm-Message-State: AOJu0YxtW/zObGVqe61dfrabnxa881Xld0O9eoOIsC718rFaXbLry7ME
	4as0+T6/PegRpKj4boYAKYBI+5XplFNWs2qPfFW4A7K/0r1EwSPYZjiiKw==
X-Google-Smtp-Source: AGHT+IEE4yRz88wzOsDWv1UA5+RKY/5Z4lL/THwv8/rCA5pdJHFidMoPPiwN6Cz4zaajZviPKGHIJw==
X-Received: by 2002:a05:6402:34c4:b0:5be:cdaf:1c09 with SMTP id 4fb4d7f45d1cf-5c3dc7baef3mr9661238a12.28.1725935348055;
        Mon, 09 Sep 2024 19:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd46824sm3653939a12.23.2024.09.09.19.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:07 -0700 (PDT)
Message-Id: <90986876381e4ccc10c5e191a3928407181e6a04.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:35 +0000
Subject: [PATCH 10/30] survey: add command line opts to select references
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

By default we will scan all references in "refs/heads/", "refs/tags/"
and "refs/remotes/".

Add command line opts let the use ask for all refs or a subset of them
and to include a detached HEAD.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-survey.txt | 34 +++++++++++++
 builtin/survey.c             | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/Documentation/git-survey.txt b/Documentation/git-survey.txt
index cdd1ec4358b..c648ef704e3 100644
--- a/Documentation/git-survey.txt
+++ b/Documentation/git-survey.txt
@@ -19,12 +19,46 @@ As repositories grow to "monorepo" size, certain data shapes can cause
 performance problems.  `git-survey` attempts to measure and report on
 known problem areas.
 
+Ref Selection and Reachable Objects
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In this first analysis phase, `git survey` will iterate over the set of
+requested branches, tags, and other refs and treewalk over all of the
+reachable commits, trees, and blobs and generate various statistics.
+
 OPTIONS
 -------
 
 --progress::
 	Show progress.  This is automatically enabled when interactive.
 
+Ref Selection
+~~~~~~~~~~~~~
+
+The following options control the set of refs that `git survey` will examine.
+By default, `git survey` will look at tags, local branches, and remote refs.
+If any of the following options are given, the default set is cleared and
+only refs for the given options are added.
+
+--all-refs::
+	Use all refs.  This includes local branches, tags, remote refs,
+	notes, and stashes.  This option overrides all of the following.
+
+--branches::
+	Add local branches (`refs/heads/`) to the set.
+
+--tags::
+	Add tags (`refs/tags/`) to the set.
+
+--remotes::
+	Add remote branches (`refs/remote/`) to the set.
+
+--detached::
+	Add HEAD to the set.
+
+--other::
+	Add notes (`refs/notes/`) and stashes (`refs/stash/`) to the set.
+
 OUTPUT
 ------
 
diff --git a/builtin/survey.c b/builtin/survey.c
index 4cfd0f0293c..e0e844201de 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -7,19 +7,117 @@ static const char * const survey_usage[] = {
 	NULL,
 };
 
+struct survey_refs_wanted {
+	int want_all_refs; /* special override */
+
+	int want_branches;
+	int want_tags;
+	int want_remotes;
+	int want_detached;
+	int want_other; /* see FILTER_REFS_OTHERS -- refs/notes/, refs/stash/ */
+};
+
+/*
+ * The set of refs that we will search if the user doesn't select
+ * any on the command line.
+ */
+static struct survey_refs_wanted refs_if_unspecified = {
+	.want_all_refs = 0,
+
+	.want_branches = 1,
+	.want_tags = 1,
+	.want_remotes = 1,
+	.want_detached = 0,
+	.want_other = 0,
+};
+
 struct survey_opts {
 	int verbose;
 	int show_progress;
+	struct survey_refs_wanted refs;
 };
 
 static struct survey_opts survey_opts = {
 	.verbose = 0,
 	.show_progress = -1, /* defaults to isatty(2) */
+
+	.refs.want_all_refs = -1,
+
+	.refs.want_branches = -1, /* default these to undefined */
+	.refs.want_tags = -1,
+	.refs.want_remotes = -1,
+	.refs.want_detached = -1,
+	.refs.want_other = -1,
 };
 
+/*
+ * After parsing the command line arguments, figure out which refs we
+ * should scan.
+ *
+ * If ANY were given in positive sense, then we ONLY include them and
+ * do not use the builtin values.
+ */
+static void fixup_refs_wanted(void)
+{
+	struct survey_refs_wanted *rw = &survey_opts.refs;
+
+	/*
+	 * `--all-refs` overrides and enables everything.
+	 */
+	if (rw->want_all_refs == 1) {
+		rw->want_branches = 1;
+		rw->want_tags = 1;
+		rw->want_remotes = 1;
+		rw->want_detached = 1;
+		rw->want_other = 1;
+		return;
+	}
+
+	/*
+	 * If none of the `--<ref-type>` were given, we assume all
+	 * of the builtin unspecified values.
+	 */
+	if (rw->want_branches == -1 &&
+	    rw->want_tags == -1 &&
+	    rw->want_remotes == -1 &&
+	    rw->want_detached == -1 &&
+	    rw->want_other == -1) {
+		*rw = refs_if_unspecified;
+		return;
+	}
+
+	/*
+	 * Since we only allow positive boolean values on the command
+	 * line, we will only have true values where they specified
+	 * a `--<ref-type>`.
+	 *
+	 * So anything that still has an unspecified value should be
+	 * set to false.
+	 */
+	if (rw->want_branches == -1)
+		rw->want_branches = 0;
+	if (rw->want_tags == -1)
+		rw->want_tags = 0;
+	if (rw->want_remotes == -1)
+		rw->want_remotes = 0;
+	if (rw->want_detached == -1)
+		rw->want_detached = 0;
+	if (rw->want_other == -1)
+		rw->want_other = 0;
+}
+
 static struct option survey_options[] = {
 	OPT__VERBOSE(&survey_opts.verbose, N_("verbose output")),
 	OPT_BOOL(0, "progress", &survey_opts.show_progress, N_("show progress")),
+
+	OPT_BOOL_F(0, "all-refs", &survey_opts.refs.want_all_refs, N_("include all refs"),          PARSE_OPT_NONEG),
+
+	OPT_BOOL_F(0, "branches", &survey_opts.refs.want_branches, N_("include branches"),          PARSE_OPT_NONEG),
+	OPT_BOOL_F(0, "tags",     &survey_opts.refs.want_tags,     N_("include tags"),              PARSE_OPT_NONEG),
+	OPT_BOOL_F(0, "remotes",  &survey_opts.refs.want_remotes,  N_("include all remotes refs"),  PARSE_OPT_NONEG),
+	OPT_BOOL_F(0, "detached", &survey_opts.refs.want_detached, N_("include detached HEAD"),     PARSE_OPT_NONEG),
+	OPT_BOOL_F(0, "other",    &survey_opts.refs.want_other,    N_("include notes and stashes"), PARSE_OPT_NONEG),
+
 	OPT_END(),
 };
 
@@ -55,6 +153,7 @@ int cmd_survey(int argc, const char **argv, const char *prefix)
 
 	if (survey_opts.show_progress < 0)
 		survey_opts.show_progress = isatty(2);
+	fixup_refs_wanted();
 
 	return 0;
 }
-- 
gitgitgadget

