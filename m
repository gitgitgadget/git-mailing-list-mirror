Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CE4207A
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211892; cv=none; b=dr+V77u9jHnWqhM9YVDLioegsC31JPP9meUW81zN8kDmrd5xtFDrjG2RBk5Jz9EZh4eG05EK/aAsGsaTLoQI7YjNCTUQz9H2K0c+r0xn+Ue5I8qBWvzsiOw+PAeYUSX4VeyEhcDTeiSZ5gB7iHdG7FqEdWcBurUl4+FdNQdCz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211892; c=relaxed/simple;
	bh=VWPitrUOtsyMpToZhF1k6malj56TPZP1hFgfb86buhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTy20FAfkeBCbR0lE4zaaLaoWgPMvjH6PX2H1ksA81cxscItDLfpEbGZ0wHEtIqjfwYqhrkCWHg4NEYfVFfAesc1gnacwY8d6PZMO6KY/x7DfDjK7V+69/no53ObCiw6sEuLAk2QBaWCqk9yW3mrL4q11R84Vk6GWDNC4JYW5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHWJnniv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHWJnniv"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3612749f8f.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774211889; x=1774816689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuBbquW2sqETqyWgHnq0/gdjm3dZ4n88eo88QtSBvGY=;
        b=UHWJnnivPmvjCDBYeMjLgOY4FMwig01IqjPqW9DFWwDF2ZmCBWPsZJbSnR4MoolWBK
         2JOsBKDXyfaJ6GJ3U1O7aDYGSGDxH6TT79ysZ8vTbapDJOv/2KGQsLNYLSxUWYr+PWvN
         Ww8eud1e4LsCk0sX7OQ66O+0kIHozz/qJehrlbTHKGj7X4Cfs/Zn18SyuuWLEFW+9OxR
         f+TFiN/vmTtcxUEMdHWIQa9YKf9PsOvZJQrwMzLdP4y13ZfMEf1VIxLoD4h2joqHBPM/
         PwRY1GbXVdzgw+hBv9POAK6CRUlrO4qaiFoXTPgXZWWKrGeLmimp7ZpFgoa866VRbiQR
         k6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774211889; x=1774816689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuBbquW2sqETqyWgHnq0/gdjm3dZ4n88eo88QtSBvGY=;
        b=h/OwlKf1AjhRI9He6woz8zU4T2h4sLjcOeRCQ7qlCHuSdcp1treUNqiEtp75mz+UpM
         ZsJfrwc6a8mfMUPNQIM9/1WLaiNpsMAs91XfKhZx+Qg+I1D0a+ClvMjqBt1a36/4iqvX
         +Q5CnwKOTopTFSpfEA55HaGVBHX063lq6hEgM/J5Myi2Duk7wW54kYHStj20QohVDwGH
         HDH79waaytskMBqOWE7cXvCCFxCBoVZd+fdTdPBUmKNEzOUFXOwpKwQzLhU9Rhsh/94f
         FY+DnEWls1cjoU2hayA1YYrqSpjYuuC+uTM3dpvUFvsIkoxrTNZXEeysIsFroe+gET+3
         8J0w==
X-Gm-Message-State: AOJu0Yzo3Js4pBI+xHWv7S6zA4/Z0j+RDiTRE3pzkoJsQ67a29H270Y1
	DMQtVnQMRw1HwubI5vTMB6H6CKV9TPshjt+Cozj4VDZ+/oxbAwKgxU1JeGK0udmXCgUQYA==
X-Gm-Gg: ATEYQzwhE4U3plbnyDyeQ37IGwhQ8pu9udD/4MwESDEZITp0D5aqF5FSri3JIOXjm/P
	zSdGhembmieFFQsg+8hXbdnKWaNcQo5C/YdOE0Sjs6tnEFfsRBSYpu/puP41ISOEshjM8MB+E44
	ID+Kb+gp+/7Mk2GMqSN3wZhx/eVcK7x4/NHkfET6XIGfL04OYEnU/PFQKXjrN8CAnN/ubRXXDm9
	93ZyTSqkoleh+zcuuTVPW0ay1Pze0ROUivR8ekiFUpVM1/k4+EjQzbeNQ+/zjIXgywUJ3mGlPlA
	yOH1/0nyuRXNYPY8kZfrCLdE2T7c6FHnwlcjo/9+gsvtHOAkkdMjKETwUzeFdzlnW76RkVyWq3z
	J9NJPlZkhsX62wRl5HTWGVXUgDGO6BlsT67zhiEL7ASPcAydJPnptENrg9vnC4xEKocHUYDo1se
	Th2W2iBEFoqXBXXkZvTmKZJYTDM5eW1BPwnp9PhLUkU76o8Y7NPP+bd8B0YcWfhNIpfbCxqnRA6
	V+YnmxdKbsF7Sj4elNNJ85m2OkzQvaJmBC5Bijf9mjNb87OtmlixnB4izI=
X-Received: by 2002:a05:6000:2484:b0:43b:4c6b:754a with SMTP id ffacd0b85a97d-43b6427b552mr15636901f8f.53.1774211889425;
        Sun, 22 Mar 2026 13:38:09 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm23569157f8f.20.2026.03.22.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 13:38:09 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH WIP RFC v3 1/3] graph: add --graph-lane-limit option
Date: Sun, 22 Mar 2026 21:37:59 +0100
Message-ID: <20260322203801.637769-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322195406.108280-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches produce very wide outputs
with 'git log --graph --all' making it difficult to read.

Add MINIMUM_GRAPH_COLUMNS = 1

Add '--graph-lane-limit=<n>' to the revision options, this option
needs --graph explicitly and rejects values under MINIMUM_GRAPH_COLUMNS.

Add graph_max_lanes to rev_info and store what the user set

Add graph_needs_truncation() and teach it to know when a column is
over the limit following graph_max_lanes, if the limit is 0, treat it like
no limit.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c    |  6 ++++++
 graph.h    |  2 ++
 revision.c | 11 +++++++++++
 revision.h |  1 +
 4 files changed, 20 insertions(+)

diff --git a/graph.c b/graph.c
index 26f6fbf000..a95c0a9a73 100644
--- a/graph.c
+++ b/graph.c
@@ -317,6 +317,12 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
+static int graph_needs_truncation(struct git_graph *graph, int col)
+{
+	int max = graph->revs->graph_max_lanes;
+	return max > 0 && col >= max;
+}
+
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
diff --git a/graph.h b/graph.h
index 3fd1dcb2e9..9a4551dd29 100644
--- a/graph.h
+++ b/graph.h
@@ -262,4 +262,6 @@ void graph_show_commit_msg(struct git_graph *graph,
 			   FILE *file,
 			   struct strbuf const *sb);
 
+#define MINIMUM_GRAPH_COLUMNS 1
+
 #endif /* GRAPH_H */
diff --git a/revision.c b/revision.c
index 31808e3df0..aeddf2d166 100644
--- a/revision.c
+++ b/revision.c
@@ -2605,6 +2605,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+	} else if ((argcount = parse_long_opt("graph-lane-limit", argv, &optarg))) {
+		int max_lanes = parse_count(optarg);
+		if (max_lanes < MINIMUM_GRAPH_COLUMNS)
+			die(_("minimum lanes is %d, cannot be set to %d"),
+			    MINIMUM_GRAPH_COLUMNS, max_lanes);
+		revs->graph_max_lanes = max_lanes;
+		return argcount;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3172,6 +3179,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
+
+	if (revs->graph_max_lanes > 0 && !revs->graph)
+		die(_("option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 69242ecb18..597116f885 100644
--- a/revision.h
+++ b/revision.h
@@ -304,6 +304,7 @@ struct rev_info {
 
 	/* Display history graph */
 	struct git_graph *graph;
+	unsigned int graph_max_lanes;
 
 	/* special limits */
 	int skip_count;
-- 
2.43.0

