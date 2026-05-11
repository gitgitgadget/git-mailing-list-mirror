Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C334406295
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514428; cv=none; b=d9JqUc3hSihRPi8i3ckWHyOGt/bX6HBrUjaSD6U+NgiaRFChR/xPYU19GcXe7dMmf5XFXs0O3YaEwH0rjYtydKiBWH1IMSZRxLtTsAS1Lx8D0bHiW2ZSd+2q4kVKkckXo2X6VhDNz2QaIOog2fdx8Wzsro4ivOUcPVHyyUe6P6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514428; c=relaxed/simple;
	bh=vYsdoCElqa4KPZasmhs41k86Mmaxmh1YZDCfmhR6HMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaGcxurvIuQxrZDA/5gXvYlqWEKz8gk+n39fkJYlE3pxLuXcRqbtn8B7MwibuuHPSJyLqtsJTGauhAXDGb0PTA3yH5V54vIpRUVQXFO3o1yp8xVYsXWfIFmn964eGGO6hvUddZJEKngoaUjM+g0bIEvHhOjVDSqZ941mPkHnoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Oth1CQ5s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LInxY9Al; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Oth1CQ5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LInxY9Al"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 51901EC00CA;
	Mon, 11 May 2026 11:47:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 11:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778514426;
	 x=1778600826; bh=pzoJrobxkTeSPN2U6+GBA2zX2zR5CYrIJsdxRL4j7nY=; b=
	Oth1CQ5sUa02bTBBsfMrz7AnAXQ4ZiHYNjHZZ93iSCx3haPBVf8VeL4NWhymPORQ
	caLiu7v1LzHaFvD4DW9fgAZ4BbiM/U8S84DhIXYJZFycKir6kHzsdAsXslow3riQ
	YcIsbx3TsnZYBqdNgt89SLVvUuacjSuBWir2Nh7R5l6ebxWkJ/NGHWcqxgmC+dbT
	4RTrMoJQ8qF88AZdyrbgAp7sjfgEPjF8oqiMa/uG+i49S+jkO/u92hJsZLGPn+nh
	S8NvRxQl4c681qb7kD6vLgaQCvpetQVWEYfKsYInySd5Tov6F7a6zG71YaJoW/mQ
	20n4woGrV+tej0UDyWWz2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778514426; x=
	1778600826; bh=pzoJrobxkTeSPN2U6+GBA2zX2zR5CYrIJsdxRL4j7nY=; b=L
	InxY9Alh41gIxK9JCF0BTuTiWCbkUofZdLmlD9R9MbBfVBPqX3ZdtEgG/qNGbpWD
	kx0Gj8WroZ1cWfnRMbzDCoCDoeFp4gQVyH9Ihg3IhyB74rD7/KxIEldk7tLrFDdf
	xSMY+9f0CytmKR6mGCNTXADU+v6QJ6cfmA7s2D2bZYxtUgXLYJw3Y+jJn1HrZigC
	KblmL0sCc97541YZE52cmLequgxrPzb8hkPEw9hzLycmePMp0yasfMuiVg2aSrvR
	sCyZ13See0PRCbuUBqgbsdvZBY1xXTKkQGw2Tp5PhiSxeziOsUKx+nC2wfsz0ezO
	lnL/hbPoy6RDIxXtY95qA==
X-ME-Sender: <xms:-vkBai9yaYVospgE66n_khxqKrrP7s-3oiLt_cAu04pOKGpnI95osu4>
    <xme:-vkBatr2_x75BS6PP_5V6TjiqCg405G54cD7D7pI1wABZBVM37NF9c8Ox2G40zLPx
    iOhv7oXxQ5vG0cuvqHmE9H8eIP7kd-kG_2PWBGRKO1jUVf-yJSO9w>
X-ME-Received: <xmr:-vkBanBtxNWlYp7bwbVtrOO6qzPtuuxEqk25QKk_5QJ2pwTyJHaQOolRV3j9smW48XhETIvQ7h1CdEl7di2QYJRWo869KEqXw3qtAaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:-vkBavw8A4GIwND9Q-6-8wCgwkyh4dS-xJBGvCWmkJfGqgR_bl7ODQ>
    <xmx:-vkBak07v4LrnbrPg2uILraxcO9EPwPj9tGG1AGner255jpQ-H1F1Q>
    <xmx:-vkBavzbXnqhmWGarEqEVHwJkxeBwoyGoB7dj2ICXKDxl5MSWhZkoA>
    <xmx:-vkBarHmDPDJBPNWYXSqrSsqHtWVZT_CUy8MpPHNHUUEzHYtGmJKuw>
    <xmx:-vkBat3GHv0gHhXA-MVWMM2QRF8U7KYWV-xBodhxH9Y21vz9CYXf_VhI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:47:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 3/5] name-rev: factor code for sharing with a new command
Date: Mon, 11 May 2026 17:45:47 +0200
Message-ID: <V5_name-rev_factor.6cc@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V5_CV_format-rev.6c9@msgid.xyz>
References: <V4_CV_format-rev.6aa@msgid.xyz> <V5_CV_format-rev.6c9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We are about to introduce a new command git-format-rev(1) to this
file. Let’s factor some code so that we can share it with the new
command.

We want to be able to format commits found in freeform text, and
git-name-rev(1) already has a function for that but for symbolic
names. Let’s use a tagged union for the command-specific payload.

No functional changes.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Pull out `*(p + 1)` instead of doing it in every `case` (Phillip)
    • Go back to using `continue` instead of `goto` (Phillip)

 builtin/name-rev.c | 53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6357eaa76d0..475efb0b82b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -272,6 +272,24 @@ struct name_ref_data {
 	struct string_list exclude_filters;
 };
 
+enum command_type {
+	NAME_REV = 1,
+};
+
+struct command {
+	enum command_type type;
+	union {
+		int name_only;
+	} u;
+};
+
+static void init_name_rev_command(struct command *cmd,
+				  int name_only)
+{
+	cmd->type = NAME_REV;
+	cmd->u.name_only = name_only;
+}
+
 static struct tip_table {
 	struct tip_table_entry {
 		struct object_id oid;
@@ -507,7 +525,7 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
-static void name_rev_line(char *p, struct name_ref_data *data)
+static void name_rev_line(char *p, struct command *cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int counter = 0;
@@ -524,25 +542,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			const char *name = NULL;
 			char c = *(p + 1);
 			int p_len = p - p_start + 1;
+			struct object *o = NULL;
+			int oid_ret = 1;
 
 			counter = 0;
 
 			*(p + 1) = 0;
-			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
-				struct object *o =
-					lookup_object(the_repository, &oid);
+			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
+			*(p + 1) = c;
+
+			switch (cmd->type) {
+			case NAME_REV:
+				if (!oid_ret)
+					o = lookup_object(the_repository, &oid);
 				if (o)
 					name = get_rev_name(o, &buf);
+				if (!name)
+					continue;
+				if (cmd->u.name_only)
+					printf("%.*s%s", p_len - hexsz, p_start, name);
+				else
+					printf("%.*s (%s)", p_len, p_start, name);
+				break;
+			default:
+				BUG("uncovered case: %d", cmd->type);
 			}
-			*(p + 1) = c;
-
-			if (!name)
-				continue;
 
-			if (data->name_only)
-				printf("%.*s%s", p_len - hexsz, p_start, name);
-			else
-				printf("%.*s (%s)", p_len, p_start, name);
 			p_start = p + 1;
 		}
 	}
@@ -567,6 +592,7 @@ int cmd_name_rev(int argc,
 #endif
 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	struct command cmd;
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -596,6 +622,7 @@ int cmd_name_rev(int argc,
 	init_commit_rev_name(&rev_names);
 	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
+	init_name_rev_command(&cmd, data.name_only);
 
 #ifndef WITH_BREAKING_CHANGES
 	if (transform_stdin) {
@@ -663,7 +690,7 @@ int cmd_name_rev(int argc,
 
 		while (strbuf_getline(&sb, stdin) != EOF) {
 			strbuf_addch(&sb, '\n');
-			name_rev_line(sb.buf, &data);
+			name_rev_line(sb.buf, &cmd);
 		}
 		strbuf_release(&sb);
 	} else if (all) {
-- 
2.54.0.13.g9c7419e39f8

