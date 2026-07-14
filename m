Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0239B972
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030994; cv=none; b=ux2kY0knVlMbhkkPTdY9B+Eov6+ohOXW+G6JXorpQIcFSYXs0WWFTwcSvG4APuOGXjl3eEGGUPjALrbtjTSwzWpogaJ04wX1iLWDzq1IZHZ/9tpiN0QO0ePZEJ+WCN9tDU9/W08LngjK/YKaCR6OSXuaml2mKxWS/RNl9+BlqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030994; c=relaxed/simple;
	bh=t2R0qB053lYY9NPw5jFXxNKYt7hUyhDGmIxkmYOz0QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RazjR+fFeCKmtG5XbF1hp+PbPLfzUI5W50ntAdQVaUTgoM4j0Ios/vBGcAUdz80wxSgsCZ7Cisk/oFwRYAnHwm6vSU44Ld7w+uj5k3fBMOqJ6BYiJD/tz79ItKK+uXXA2c9BGuSGOqpHuXmXcy5s9APrqILDV6pZ/QSJ92f1BWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX/q2fjN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX/q2fjN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso4039638f8f.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030990; x=1784635790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g0R8cf6kw54e6vzNht8ICDtAjZ3R4787DPNT/LyxjTI=;
        b=eX/q2fjNlBFiZR4kZqMKAF/lW+BjssYXm2m+nPCV/RCnewdD7Y1Y2VF3mcVqh5gm5/
         eR8SoUuGv0qUA3fqxc2aMm5O1rE5rFU2Lb7b9JsbkwdH7vqp912rUUBt/qg4Gjw9nhA/
         81XYlK+V90KfKJ/DWzMjrkqtlyA/8E5Yp1ZgwgCjsqRNFIHGSv19llqYEZh0YyqIFOym
         pOCIDdVTGs4oZ0TA7qu1qgjd18U45JAPvd9/NT5525jZv6A7AG4k7f2DAJoSn0DXTX1J
         nVtBj1Sad7GIjErqM0xIaRZR3m/1i/YBf0HF4r7fjIsoiSTUd5O7mXZ1kU7pp0dm8b/B
         GdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030990; x=1784635790;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0R8cf6kw54e6vzNht8ICDtAjZ3R4787DPNT/LyxjTI=;
        b=cSUwppiRcyRn6hOsQ2XtQ8Uua1P7MAsKjYUGRMcjgzM9JVp96xHBMVeorfdQc+Dv/n
         ayf32QY55sc+L40azmuKPtpoTKDZUC56nzxlog9L3+zirCfAipzTNVZt65ovOe4HuY1f
         UGiH1Y9Ca7rpIGk6bB5c/IkEM1cCuneqCDGmVuzDlhqX2FqzB3gvuernO/H+4isT+Aps
         qyBABwuXDzwPAHGna4gbpy7/3MPC1vqFrZj5t3TuMgYAQoN/BV4ktHqaUqsZeGzuJ0jg
         HQcRLNbfsqCciEfYxZaAq6DT6ebnecuZzIKh5QfQ4+o06rZbCSs+VO/NfXdqFwNVO/wP
         EsRg==
X-Forwarded-Encrypted: i=1; AHgh+RoU1Mvo4OPGfcKde89mDbEjCIj6BYGjXmRT6hWLVHloIS/lOnGcqdLv8mSb5vGsNtvzzm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnj8VUH245xxEkEIhNfC/XuH4o/FDJ4AbtPOpqUjfp/Y8GqDTZ
	aDTw7TNkAiMK4sgI5ZM8SmRQXLVUb/DmJoPnd+VCwki8JWq54f7uwEWx
X-Gm-Gg: AfdE7cnbZSTkM38J/bCprEgBW7v9p8aR7g5MhZtBz3LuapCbit88LLyRPuvnv89kbm6
	iHWmH8yh+Bp3+FTM+ff4woXcyU29VoVXzwo/n6aidKE88XJdpTN653uSjqxGAM4RRdDCxzYXGFc
	u+c8RzLifRaOXC1Cimg+dlUMxf0MwxSD23Y/5OPsM41IMI6mrgwVGFpwmMYOLE6cykiEORJhxJH
	YQKrYHWAEYO8xKn4IbvxobFoMlOjald0X9Kgw5Rb8aU0gOPhpFCIoOWyPH8txV96qpgyyqm7XUg
	FNiF1245HJ77VfIngDA1TeQDHOIVP0u/Q2+9wwS3U80aBxjrpvJQnKBYOIV7xODarACPJ1DXttc
	dPcwVMKZXNM52Vas0YFBoeQilixrdtAg7MSlBYpEkAqjXn4aDnFgmHFypOt8v/c5M2obBaKpLNP
	B9LBxsDlrJ4II8gCbEBexKJBJX1Hiangq7UaH7iZ/hQ7dwqt/69JI9ejFbdCEP0Gso0aP7BQruL
	9Tt/AeKo/QKwwHsFskyXT0AEbs3bAWk7ZktKN3VvZauS80Bt2gWAbFSwxFRMUgdnsFkyFzRe+io
	t2e7EhAsKyAtjeVXhcuM0c2W4HelGLOY3/8oJvexfboqPNJtczAgdGncP9mEFwULkRiU3BtRH2B
	d/vGQAfltskObLDUQ3y1p
X-Received: by 2002:a05:6000:4b09:b0:477:f5c:9bf2 with SMTP id ffacd0b85a97d-47f2dd02397mr14669440f8f.51.1784030990244;
        Tue, 14 Jul 2026 05:09:50 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm7749939f8f.34.2026.07.14.05.09.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:09:49 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v12 7/7] graph: add --[no-]graph-indent and log.graphIndent
Date: Tue, 14 Jul 2026 14:09:38 +0200
Message-ID: <20260714-ps-pre-commit-indent-v12-7-d50938e006df@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some users may prefer to not have graph indentation.

Add "log.graphIndent" config variable to graph_read_config() to read the
default preference. By default is graph indentation is true.

Add --graph-indent and --no-graph-indent options to overwrite the
default preference.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/config/log.adoc       |  4 +++
 Documentation/rev-list-options.adoc |  8 ++++++
 graph.c                             | 10 +++++--
 revision.c                          |  9 +++++++
 revision.h                          |  2 ++
 t/t4218-log-graph-indentation.sh    | 53 +++++++++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index 757a7be196..f7dfce69b5 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -59,6 +59,10 @@ This is the same as the `--decorate` option of the `git log`.
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
 
+`log.graphIndent`::
+	If `true`, indent visual roots when rendering the graphs with `--graph`.
+	Set true by default. It can be overriden with `--[no-]graph-indent`.
+
 `log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index eaee6ee839..fd831f0ec6 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1269,6 +1269,14 @@ This implies the `--topo-order` option by default, but the
 	By default it is set to 0 (no limit), zero and negative values
 	are ignored and treated as no limit.
 
+`--no-graph-indent`::
+`--graph-indent`::
+	When used with `--graph`, indent visual roots (commits with no parents
+	or whose parents are not shown) to differentiate them from commits that
+	are vertically adjacent but unrelated. Enabled by default. Use
+	`--no-graph-indent` to disable or set `log.graphIndent` to set a
+	default preference.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/graph.c b/graph.c
index c14be934a0..28bef1b88f 100644
--- a/graph.c
+++ b/graph.c
@@ -419,6 +419,8 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 
 static void graph_read_config(struct rev_info *revs)
 {
+	int val;
+
 	if (!column_colors) {
 		char *string;
 		if (repo_config_get_string(revs->repo, "log.graphcolors", &string)) {
@@ -435,6 +437,9 @@ static void graph_read_config(struct rev_info *revs)
 						custom_colors.nr - 1);
 		}
 	}
+
+	if (!repo_config_get_bool(revs->repo, "log.graphIndent", &val))
+		revs->no_graph_indent = !val;
 }
 
 struct git_graph *graph_init(struct rev_info *opt)
@@ -999,7 +1004,8 @@ static void graph_peek_next_visible(struct git_graph *graph,
 static int graph_needs_pre_root_line(struct git_graph *graph)
 {
 	return graph->commit_in_columns && graph->is_visual_root &&
-	       graph->num_columns > 0 && !graph->visual_root_cascade;
+	       graph->num_columns > 0 && !graph->visual_root_cascade &&
+	       !graph->revs->no_graph_indent;
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -1344,7 +1350,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			if (graph->is_visual_root) {
+			if (graph->is_visual_root && !graph->revs->no_graph_indent) {
 				int depth = graph->visual_root_depth;
 				/*
 				 * Each visual column is 2 characters wide.
diff --git a/revision.c b/revision.c
index 258c3cf782..37f7ea45d1 100644
--- a/revision.c
+++ b/revision.c
@@ -2627,6 +2627,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->graph = NULL;
 	} else if (skip_prefix(arg, "--graph-lane-limit=", &optarg)) {
 		revs->graph_max_lanes = parse_count(optarg);
+	} else if (!strcmp(arg, "--graph-indent")) {
+		revs->no_graph_indent = 0;
+		revs->graph_indent_set = 1;
+	} else if (!strcmp(arg, "--no-graph-indent")) {
+		revs->no_graph_indent = 1;
+		revs->graph_indent_set = 1;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3201,6 +3207,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->graph_max_lanes > 0 && !revs->graph)
 		die(_("the option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
 
+	if (revs->graph_indent_set && !revs->graph)
+		die(_("the option '%s' requires '%s'"), "--[no-]graph-indent", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 569b3fa1cb..acf6d06b24 100644
--- a/revision.h
+++ b/revision.h
@@ -314,6 +314,8 @@ struct rev_info {
 	/* Display history graph */
 	struct git_graph *graph;
 	int graph_max_lanes;
+	unsigned int no_graph_indent:1;
+	unsigned int graph_indent_set:1;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
index d4c850c0d4..24dc9b497d 100755
--- a/t/t4218-log-graph-indentation.sh
+++ b/t/t4218-log-graph-indentation.sh
@@ -540,4 +540,57 @@ test_expect_success 'visual root cascading gets wrapped after 4 columns' '
 	EOF
 '
 
+test_expect_success '--no-graph-indent disables indentation' '
+	lib_test_check_graph --no-graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	* 66_A
+	* 65_A
+	* 64_A
+	* 63_A
+	* 62_A
+	* 61_A
+	* 60_A
+	* 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+test_expect_success 'log.graphIndent config disables indentation' '
+	test_config log.graphIndent false &&
+	lib_test_check_graph _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	* 66_A
+	* 65_A
+	* 64_A
+	* 63_A
+	* 62_A
+	* 61_A
+	* 60_A
+	* 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+test_expect_success '--graph-indent forces indentation when graph.indent is unset' '
+	test_config log.graphIndent false &&
+	lib_test_check_graph --graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	  * 66_A
+	    * 65_A
+	      * 64_A
+	* 63_A
+	  * 62_A
+	    * 61_A
+	      * 60_A
+	  * 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+# log.graphIndent unset and no --option (which activates graph indentation) is
+# the default state.
+
 test_done

-- 
2.54.0
