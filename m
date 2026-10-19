Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFE49BB58
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400188; cv=none; b=aw65/BJL/AMZym2AxRXs0Yqd4UC8drGiUXHFb3MNL0BJIkjSSo/qpAlS86pueXN4FB9JH8prHM1jUrWHJQw3kx67m561dD4uB4XE6pb3x1hwHQiDAPgJgOFtvITkFeyXC9FpdwTPX4gfEV5BZkFL2dRTEtk9tdL0G+Hb+Qy/Puo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400188; c=relaxed/simple;
	bh=T00MiSHEh0j40D8/5ZbC9/qH8wE4Z9Z6Lo1Q0RHDw/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNBe1Xs1buybV7EAqC9GuevO8u8SEydRMephtaOw+51Dj586dlqaCg22EP3aYY7346gDeJ3Q9MQ2ASxiCKX8SlIAGW1tOE4xHlM4nEpZ4X5jvUKZiElMip1nJ0cs1TKWI9ZQcs/3FqcOnpMiy0ymLcohBM1X1l+HZ/QTUUpMCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QmU80dc+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFCUBZwF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QmU80dc+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFCUBZwF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A8171D000C5
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 04:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400186;
	 x=1792486586; bh=jrTp4pS9taDea4XBFKZvyCvAv600ghFihrumA80LALU=; b=
	QmU80dc+2C47a4X2maVpKU3cyKWN7LLfskYLIJxINKFk33zRNcb+v/vJsXBIC8t0
	0YE2ykJbE3KN4ghxhPoxooLKWqBrGgQfilwET73zv7yG7+C5qRrRbQkYutQKQHFn
	kJELUoiMBSGMC8zL1y74EwjrX4BznekRfcP01rqNwwjVbDl9DaJ1z8RAwDn83yLK
	XWFFw80JaJpXdYZ/HOlKonLUpJMF+ac83lU8fNgQNhQjrj52s6r7kERgHABGZTP9
	bwEE+r8ajQt8jho8q/ngd/pPJMY+PvQeikrEszPmjhnToMPQFKoiIlTZ8zrmwZyX
	6yWmowOH48PIDO4o0zeTAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400186; x=
	1792486586; bh=jrTp4pS9taDea4XBFKZvyCvAv600ghFihrumA80LALU=; b=Y
	FCUBZwFsf9aMVoxrRXsift6+k9loA7kI2RS72IJITW3rnw9OJRbFXja3o8DtkHxV
	0hytMDrZcRMkQxwEbXFnQWjmpt1XRHvK7HwH2bzXSkZyBup0vt15bQK/eNCQ1x1l
	NrY0CxmvadRgOafnQyeuZyTdu3ZyBktCkVY/b/4QFX2fh0vam5pY1gRYfsq69aDA
	gO6DsaOKhZfDFC902OONoe2Gyvms3GyOVNuHvFPenTEfc9SQAFDaiIyGOl65TU27
	mhrPPxxwHQ4DcpcEYANZtyKso+E5zsMqOZZsGNmTLY+u6PUmUMtBuFwrCo0if7+j
	15rk25w4gj5pJFfn+EfFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400186; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hPz9BBgbym+mMtZGJZueDmYvutlFK9G4WzH1k3RGRennLYD
	zIyK8c/aw0GgquPp4glhcvbnKAGz3Y1CGLKF04y6YUmgGp6I69RdBhcCGIVD5/TX
	SlVQd3798sLeuUTucaL4UbTH1haigRVQnZoHEaUx2S4qIdM+Wbf3EEGXg1xX4hyD
	WguItLDG/BRKdpJ7aHxR0pO3msOSOoBaeFVPlrMQatBZq0SuaCeQjh0G2fa1E5dC
	dDJCctE2G7TWGuXJldak9JE7KlWvNLwmcVCKmnWUgqDe04TFaiJBv7311Tx7I3d7
	D5MsIzdP35iYKWRYjukN4MGia1L/c82WBVmOZFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:K4tfZcNyASjG+xVN2HwgXs0nsqRCwOHf/NLU7DImZ4s=:T00MiSHEh0j40D8/5ZbC9/qH8wE4Z9Z6Lo1Q0RHDw/I=;
X-ME-Sender: <xms:OtvVailIFfA7Axr7L2V95HGgDwMt7-x37mQ7bmef1xw5B_Z2_g1cxQ>
    <xme:OtvVagykUBKfKnCMCM4vFF8fx2IPE01_wCPzW-F6K4IG_PFjsEqEzcJoQIps_iAa5
    YKZ7I76CK7n5Q_BBizl8A0DeuThtGd98d2AgUhuCiTD4gp-6x-Bf78>
X-ME-Received: <xmr:OtvVamQM615CtjV1bGOgrXv16ZWOo6uRtNQNOIc5ijgfr92YhJ1L6g>
X-ME-Proxy-Cause: dmFkZTGfTCDl6lUtR0YpWppdo23ln4jv3lH0xKWlUu7G6uFe8srcOriVaetMCFdYOyxqQh
    Hr8AcU1kgjJzkfBWAOsoOESOtAb6ToxqQo/glcL1RFxoi5HEY8NDh7o7yWVsMpg/4SJbyC
    Ee0RhLv5Z/LClTYB7Klx1zd81O5uXk7VQIM3x8R/zpf1qi5h0olmBbLQVoqqjdF2fHErUn
    GgQdFMkHZ2ZQUVX73yj3kmRnsZLrofdcFxVHcsVRe4zNV0HDojJqm8rLcDtzr7pnXN6rh5
    ETfI5C+vnxrskwXB7vMXv16EL/70ckpLtMvpMfgxUof+XnNLnkpbov+eAsWoepxKSY3zlE
    IhVWVXrtEby4h8XZT4WQriaymyu6eBKfOKgqZ7s3FNxvs3iTdMJeCgLrf+HzhPaFfoobOM
    FVCppp0Xh4A8l3vgTS0R4tTOHyTf2wCa9t0hLUPISsjdaLSkuq6y+/NehHhQ+mJFBR6LNE
    ZEJFFp3l6PZEu8afnbmZskNAmaENIuItJ1LrpnnwFRxdsM4cG8ObCqXKUKKzI7oqFv+C/T
    E2tzKM3G2ST68VY8hqPSc1KVYUnL+Ualf2RAxwXAQKoresB2NHVWm41x/D9J/QCNkvgxk5
    yytBqxC0GPgH6caW0o9p+x7lRx/IXMa2fe9Kia/xDB8gGhzJ0VFLw/xCmd3w
X-ME-Proxy: <xmx:OtvVaruf2yPzKn63Q-qh93OyB9bV2_qoDI-z2H-MtYD1nE8HhcwOYw>
    <xmx:OtvVagv6jaF2ZVNzenondc6KXO648QB0C5NE8rv4f-prdi5Ho-n_KQ>
    <xmx:OtvVapxF6CWJ0IaDZPvCnq90H6SScAEU1sKeNHdiYkvNpfmlXAXz4w>
    <xmx:OtvVaujUPlVutbc6LK1bjSdMAKEo-J3QWMz_je9NpEbthHLxRSyXpg>
    <xmx:OtvVau1Ts7SuTT5VRoM_HICFRgoT6vQTrwTiazVEiSl-vad7oR2nLToo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a5141fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:56:02 +0200
Subject: [PATCH 7/7] builtin/submodule: propagate
 "--object-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-7-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The ref storage format passed to git-clone(1) propagates to recursively
cloned submodules, and git-submodule(1)'s "add" and "update" subcommands
accept `--ref-storage-format=` so that newly cloned submodules can be
set up with a specific format.

Teach git-submodule(1) to also propagate the object storage format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.adoc           | 10 +++-
 builtin/clone.c                            | 10 +++-
 builtin/submodule--helper.c                | 28 +++++++++
 git-submodule.sh                           | 18 ++++++
 t/meson.build                              |  1 +
 t/t7427-submodule-object-storage-format.sh | 91 ++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index e9c81a7170..57a21bc8d9 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -34,7 +34,7 @@ COMMANDS
 With no arguments, shows the status of existing submodules.  Several
 subcommands are available to perform operations on the submodules.
 
-`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
+`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage-format <format>] [--object-storage-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -75,6 +75,9 @@ URL in `.gitmodules`.
 If `--ref-storage-format <format>` or its deprecated alias `--ref-format
 <format>` is specified, the ref storage format of the newly cloned submodules
 will be set accordingly.
++
+If `--object-storage-format <format>` is specified, the object storage format
+of the newly cloned submodules will be set accordingly.
 
 `status [--cached] [--recursive] [--] [<path>...]`::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -140,7 +143,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--object-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
 +
 --
 Update the registered submodules to match what the superproject
@@ -193,6 +196,9 @@ If `--ref-storage-format <format>` or its deprecated alias `--ref-format
 <format>` is specified, the ref storage format of the newly cloned submodules
 will be set accordingly.
 
+If `--object-storage-format <format>` is specified, the object storage format
+of the newly cloned submodules will be set accordingly.
+
 If `--filter <filter-spec>` is specified, the given partial clone filter will be
 applied to the submodule. See linkgit:git-rev-list[1] for details on filter
 specifications.
diff --git a/builtin/clone.c b/builtin/clone.c
index 85c124dc37..63348c3f34 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -686,7 +686,8 @@ static int git_sparse_checkout_init(const char *repo)
 static int checkout(int submodule_progress,
 		    struct list_objects_filter_options *filter_options,
 		    int filter_submodules,
-		    enum ref_storage_format ref_storage_format)
+		    enum ref_storage_format ref_storage_format,
+		    const char *object_storage_format_uri)
 {
 	struct object_id oid;
 	char *head;
@@ -776,6 +777,10 @@ static int checkout(int submodule_progress,
 			strvec_pushf(&cmd.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
+		if (object_storage_format_uri)
+			strvec_pushf(&cmd.args, "--object-storage-format=%s",
+				     object_storage_format_uri);
+
 		if (filter_submodules && filter_options->choice)
 			strvec_pushf(&cmd.args, "--filter=%s",
 				     expand_list_objects_filter_spec(filter_options));
@@ -1703,7 +1708,8 @@ int cmd_clone(int argc,
 	err = checkout(submodule_progress,
 		       &filter_options,
 		       filter_submodules,
-		       ref_storage_format);
+		       ref_storage_format,
+		       object_storage_format_uri);
 
 	list_objects_filter_release(&filter_options);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 64412adf9f..8a9c9e17b6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1739,6 +1739,7 @@ struct module_clone_data {
 	int depth;
 	struct list_objects_filter_options *filter_options;
 	enum ref_storage_format ref_storage_format;
+	const char *object_storage_format;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
@@ -1948,6 +1949,9 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 			strvec_pushf(&cp.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(clone_data->ref_storage_format));
+		if (clone_data->object_storage_format)
+			strvec_pushf(&cp.args, "--object-storage-format=%s",
+				     clone_data->object_storage_format);
 		if (clone_data->dissociate)
 			strvec_push(&cp.args, "--dissociate");
 		if (sm_gitdir && *sm_gitdir)
@@ -2065,6 +2069,8 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &clone_data.object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &clone_data.depth,
@@ -2095,6 +2101,9 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		if (clone_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (clone_data.object_storage_format &&
+	    odb_source_type_by_uri(clone_data.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), clone_data.object_storage_format);
 	clone_data.dissociate = !!dissociate;
 	clone_data.quiet = !!quiet;
 	clone_data.progress = !!progress;
@@ -2202,6 +2211,7 @@ struct update_data {
 	struct list_objects_filter_options *filter_options;
 	struct module_list list;
 	enum ref_storage_format ref_storage_format;
+	const char *object_storage_format;
 	int depth;
 	int max_jobs;
 	int single_branch;
@@ -2365,6 +2375,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 		strvec_pushf(&child->args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
+	if (suc->update_data->object_storage_format)
+		strvec_pushf(&child->args, "--object-storage-format=%s",
+			     suc->update_data->object_storage_format);
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
 	strvec_pushl(&child->args, "--url", url, NULL);
@@ -2809,6 +2822,9 @@ static void update_data_to_args(const struct update_data *update_data,
 	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 		strvec_pushf(args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(update_data->ref_storage_format));
+	if (update_data->object_storage_format)
+		strvec_pushf(args, "--object-storage-format=%s",
+			     update_data->object_storage_format);
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=%s",
 				expand_list_objects_filter_spec(
@@ -3019,6 +3035,8 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &opt.object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &opt.depth,
@@ -3067,6 +3085,9 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		if (opt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (opt.object_storage_format &&
+	    odb_source_type_by_uri(opt.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), opt.object_storage_format);
 
 	opt.filter_options = &filter_options;
 	opt.prefix = prefix;
@@ -3372,6 +3393,7 @@ struct add_data {
 	const char *repo;
 	const char *realrepo;
 	enum ref_storage_format ref_storage_format;
+	const char *object_storage_format;
 	int depth;
 	unsigned int force: 1;
 	unsigned int quiet: 1;
@@ -3477,6 +3499,7 @@ static int add_submodule(const struct add_data *add_data)
 			string_list_append(&reference, p)->util = p;
 		}
 		clone_data.ref_storage_format = add_data->ref_storage_format;
+		clone_data.object_storage_format = add_data->object_storage_format;
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = add_data->depth;
@@ -3669,6 +3692,8 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &add_data.object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
 			   N_("sets the submodule's name to the given string "
@@ -3700,6 +3725,9 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		if (add_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (add_data.object_storage_format &&
+	    odb_source_type_by_uri(add_data.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), add_data.object_storage_format);
 
 	add_data.repo = argv[0];
 	if (argc == 1)
diff --git a/git-submodule.sh b/git-submodule.sh
index 8632194138..4de5ffba04 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -103,6 +103,14 @@ cmd_add()
 		--ref-format=*|--ref-storage-format=*)
 			ref_storage_format="$1"
 			;;
+		--object-storage-format)
+			case "$2" in '') usage ;; esac
+			object_storage_format="--object-storage-format=$2"
+			shift
+			;;
+		--object-storage-format=*)
+			object_storage_format="$1"
+			;;
 		--dissociate)
 			dissociate=$1
 			;;
@@ -148,6 +156,7 @@ cmd_add()
 		${branch:+"$branch"} \
 		${reference:+"$reference"} \
 		${ref_storage_format:+"$ref_storage_format"} \
+		${object_storage_format:+"$object_storage_format"} \
 		$dissociate \
 		${name:+"$name"} \
 		${depth:+"$depth"} \
@@ -310,6 +319,14 @@ cmd_update()
 		--ref-format=*|--ref-storage-format=*)
 			ref_storage_format="$1"
 			;;
+		--object-storage-format)
+			case "$2" in '') usage ;; esac
+			object_storage_format="--object-storage-format=$2"
+			shift
+			;;
+		--object-storage-format=*)
+			object_storage_format="$1"
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
@@ -386,6 +403,7 @@ cmd_update()
 		$merge \
 		$checkout \
 		${ref_storage_format:+"$ref_storage_format"} \
+		${object_storage_format:+"$object_storage_format"} \
 		${reference:+"$reference"} \
 		$dissociate \
 		${depth:+"$depth"} \
diff --git a/t/meson.build b/t/meson.build
index 11b3752f00..8542035b6f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -926,6 +926,7 @@ integration_tests = [
   't7424-submodule-mixed-ref-formats.sh',
   't7425-submodule-gitdir-path-extension.sh',
   't7426-submodule-get-default-remote.sh',
+  't7427-submodule-object-storage-format.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7427-submodule-object-storage-format.sh b/t/t7427-submodule-object-storage-format.sh
new file mode 100755
index 0000000000..a2c9a5e753
--- /dev/null
+++ b/t/t7427-submodule-object-storage-format.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='submodules handle the object storage format'
+
+. ./test-lib.sh
+
+test_object_storage_format () {
+	echo "$2" >expect &&
+	git -C "$1" rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup' '
+	git config set --global protocol.file.allow always
+'
+
+test_expect_success 'add existing repository with different object storage format' '
+	test_when_finished "rm -rf parent" &&
+
+	git init parent &&
+	(
+		cd parent &&
+		test_commit parent &&
+		git init --object-storage-format=files://objs submodule &&
+		test_commit -C submodule submodule &&
+		git submodule add ./submodule &&
+		test_object_storage_format submodule files://objs
+	)
+'
+
+test_expect_success 'add submodules with different object storage format' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	test_object_storage_format upstream files &&
+	git -C upstream submodule add --object-storage-format=files://objs "file://$(pwd)/submodule" &&
+	test_object_storage_format upstream/submodule files://objs &&
+	test_path_is_dir upstream/.git/modules/submodule/objs/pack
+'
+
+test_expect_success 'add submodules with garbage object storage format' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git -C upstream submodule add --object-storage-format=garbage "file://$(pwd)/submodule" 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'recursive clone propagates object storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -am "add submodule" &&
+
+	test_object_storage_format upstream files &&
+	test_object_storage_format upstream/submodule files &&
+
+	git clone --object-storage-format=files://objs --recurse-submodules \
+		upstream downstream &&
+	test_object_storage_format downstream files://objs &&
+	test_object_storage_format downstream/submodule files://objs &&
+	test_path_is_dir downstream/.git/objs/pack &&
+	test_path_is_dir downstream/.git/modules/submodule/objs/pack
+'
+
+test_expect_success 'clone submodules with different object storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -m "upstream submodule" &&
+
+	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
+	git -C downstream submodule update --init --object-storage-format=files://objs &&
+	test_object_storage_format downstream files &&
+	test_object_storage_format downstream/submodule files://objs
+'
+
+test_done

-- 
2.56.0.269.g68944adf51.dirty

