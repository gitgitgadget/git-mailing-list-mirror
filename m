Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FA481675
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182541; cv=none; b=AblY9R+jKWQYJFyAd66iu6Py9/6o8PQUdqyOPWim+sk7Ka3JEY8g5CNRCHigNJBD+xh4Chmqagn3vgIPA1dhNC/uBqKzizN2VO93z8hQt/W1qpKwymL8shl1PHquYtvPvQgXxzhE4xxIHAhayNCWjSjNZpZ/aI91Xxsa/JLXhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182541; c=relaxed/simple;
	bh=vYsdoCElqa4KPZasmhs41k86Mmaxmh1YZDCfmhR6HMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1xdw9VrA2gjxZtm+qP0AFlubpu8G27t+fOt9zgoq2ltthtrXLqIi+JTZJTzOKCqCU38gFMZX+ZAP2UqDe5XkJAINcgJWSmbMsMbrDsqkBT+SaPZO3kzcmPWkVI5ZdsgoeRHss3Ksxz8pnE3dYGT8ZFp1PTulz+gJRGyVB/A/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fpAvJkws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eu/XOdk4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fpAvJkws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eu/XOdk4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D2F10EC00CE;
	Thu,  7 May 2026 15:35:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 07 May 2026 15:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778182536;
	 x=1778268936; bh=pzoJrobxkTeSPN2U6+GBA2zX2zR5CYrIJsdxRL4j7nY=; b=
	fpAvJkws04AFGkeSi5LbogrMnHmkTqNRDlSO3u5Un5aRvTjDorh9CESXKZ4QhdGa
	Q9tnByatmd5u3iPYNggh67eU6XwRORSDAffRVPSmk9d6Vqm6npU+bG7vZUEzHDXc
	0rSYb09Sy1k0G1OO27aAcYDlk4BXpaowuI9rKtAmNRBMhz4BFEIxjAl1+1ZbOm+w
	JAOyJAsEY32xBSkPlckc+XrzFNQr+DoOW+aSzjiOXddGzKdeCkRrP/RrK6mvIFtF
	KaI0uqdgMonazk7F6UTCEKrn8LnvWcojSWbYS5RefSuKN1Du4Dm5SIXfBaUV5D7q
	+QM2A8n8AnL6XPeBIdiPZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778182536; x=
	1778268936; bh=pzoJrobxkTeSPN2U6+GBA2zX2zR5CYrIJsdxRL4j7nY=; b=e
	u/XOdk4G2L5UmYIitknfCOkpADcdcxbt3yaVLZt4v86chNyZ2hjVx1ELfhqcldYD
	xnui1SXTVGQV/LkhYXY3W2zoYiGjVUr/oI+9gGYlcynv49VAwxOmRrEen+CN+fHg
	QAizwvLiGh7xtXQ5pF0OGG0Mx5emn3p7ow/YK5WTdej7258roPAga95IvpWhG5BV
	cMaivdhLqnHePaNEVGB29Xj8mZiVDVY2XmbIz8jeiZt6lGMc5FQnBRCrmGmpeRBn
	oAE2jX/u8LPS/eG5AeZ2R5mtgEuih2bRLvGPysxxPU9b7LTWnm+P2tF2gEwa/WB2
	8xqIw/Fw65sTFUhgIhzjQ==
X-ME-Sender: <xms:iOn8aSF3pueCTOr5QAo2Qyfbj7tSvrwF0yFkIXf4_kAnEdUQi79yqOU>
    <xme:iOn8acS4UKUYOF1fWf-QqWjex03QOr1iRL6_GvsFsay6rHJi_J7snvwURYQQF6eiQ
    o1Yks4JG8NMqIoiPNTRnMeJ4-ezNYQL2HxGSJ86qjYzdVzI-aeGXaw>
X-ME-Received: <xmr:iOn8aXsLSIw3tEpONO7GXBTrzsK_OLK3wg3LGQ35T77z0cFt19bovnBb2DARFcHWhrva2epz1NbqGG1PvQvurZIJGNlP1KGG3SoTIkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:iOn8acKm0quWmLye0AEQRy7-wNddxVByAzMi473iqMiSnle7LITG_w>
    <xmx:iOn8aUmnHqq5cHaBJNMNd97_F_xCWhPrESUkAVJNQ2qK9qzlkh_d_w>
    <xmx:iOn8adI_kmK1nbO59d5L-AJGZ2TYb9NX2VDNdOmiXozT4sziQDFZFQ>
    <xmx:iOn8aZ6nqbX2aMcbyasP5e-mSsV8EFV9aturVllhVy7oilwKMHXnTA>
    <xmx:iOn8aY1A078knH6ySbRJzwRm4ew1PknXCr7koKy2uvb6TyNyiHlDh6sh>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 15:35:35 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 3/5] name-rev: factor code for sharing with a new command
Date: Thu,  7 May 2026 21:34:22 +0200
Message-ID: <V4_name-rev_factor.6ad@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V4_CV_format-rev.6aa@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz> <V4_CV_format-rev.6aa@msgid.xyz>
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

