Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA61FC7E1
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124060; cv=none; b=l7deWjoqFm+PePo8Aemqi1g8Ys7Rp+50Fp6njAfLoYGHFYigLcC+B9OC0X1MTo49/RmjDhBKr0ColUd8rhSeDfl/B3AF1TF0DHs9UgTrspB2xmB4TnzpEa48JAKf/aHnvTAzKvX3X9Elz3+uxR8LfsmN28E40XpLjaIVFav9J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124060; c=relaxed/simple;
	bh=P6ZP1NEA9uhf5ec3WlBfZtBMvgctM3K/24+LEYAxL/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0UNdfvAnRwG5pFw0dwCnldc0odXk1odFsrsxlQSPgMdZ0Hx0gljfkiQQ38LhPSlhE3VHcoRs6UDHh0mZS9c2qxYutD8nMKj8dCjspvQ45sNatQLoFY7TQcVHEHhN4uTk9tJ4Wf6c9rlNbwlxy16SvOVFtm/SbR9XhZE5gNhtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzLIHzYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4YOrpwn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzLIHzYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4YOrpwn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C07361140190
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 21 Feb 2025 02:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124057;
	 x=1740210457; bh=U3L63CqXGH6RkdLw92vnZMO6WuEVR1wfdpF20SFQzXk=; b=
	NzLIHzYmFh0W8kwt1R7Jn+DjlXUm1SWZfbzBKfLz+FQ2DPFxnL6YszECT39E+CdA
	G1HqusEIFKS5HhIsOCDyarQOffUtPV/XGkiHDJN+FC8N1jAlC49MSp3EfpJj5SJY
	vfND89r22M1DqW1F7hIQ6Suwm3z2cxGh1gJwjtG0CURBTIv5ugdiSeFpKycr9pMj
	8fw6ay4unZO0u9c4Kr5FG9QuZV2F2/vlWQymI2qsuqGhFtQFn49i1RDR4fdIdrfn
	vsNWAZXbayyZ0wcXsXo9tRRpPzVlL6RmfyEWX6siXyg/InUxxZ5npSfx2zX+BSNE
	RZLWDVtJmf1/xFv4AF+Lzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124057; x=
	1740210457; bh=U3L63CqXGH6RkdLw92vnZMO6WuEVR1wfdpF20SFQzXk=; b=l
	4YOrpwny/sLnTHTz5kBSAUo2l4s7KAwqddxJVGT5fFYAWgLKKq+77dp1sSD9/1iw
	3e5oBvI0msfVaf+L3F1XaVlY4aZzGrgPJg8TqYV0X/kPFkTMLn6Clhrvk/ln77tV
	EpmSlxUucdZclqmWcKbyCqCV2bWC8GTY+hTQiGKkug1olmRpMK4bIss3Mdi4rHoZ
	R4w54SBTCLNP9JSqMtUna41D5XMAPqgUDRSuL9maiE/fEhfQ+dW5iengxFDTV62P
	pd4DNiWBCkazmyXArxL4546M40VvcIxn7BRPr+urt64ZfJoLpkUxLdU6B4ThlqLl
	sxt/8GWmltfGJrzGWJbSA==
X-ME-Sender: <xms:mS-4Z3AwD_VdjAJctZs0LrjCdYeH3_XnfxGrTjSwja5XNAeRHIQMkw>
    <xme:mS-4Z9hbMgwKgpfpmoLFHNIG27zbR-2lsISkIXsnvmQ-Y_XxPBDfLhVjTtsHeCrZX
    C6c-GAKnFUVWoWvqw>
X-ME-Received: <xmr:mS-4ZymDdWJIMgkxOc6ZeWysauWyYPpfNqAVhyhFfcpLhLvbXF-QmKQaM302lF03pKnZ1womgJPoGqff7IwMqJRnAddo6rT-01TKibnPHUxm7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mS-4Z5wajzxjtz-tBhQyIEkW-UCAN7hZBKbEMEI7a78ePPghKe-U5A>
    <xmx:mS-4Z8RA6mZh-tLGn62Zs47oaP95cEKs_V4zaMAEv3Q1kvSTm3Mk9g>
    <xmx:mS-4Z8ZHhHVqj65s8l0Uq32lp7fnvhS93q0bq9xVSvaxxZzefvCDLw>
    <xmx:mS-4Z9QE9DKn83TTO71E2J7NvJHkUHttkjBBZHmvSx270FatGLBZgQ>
    <xmx:mS-4Z3Jd3IeEMR2h3P-nt4l0pwvpoR6NHQ4qR4NayDJxYRh8-HfCS8dp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2022272a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:27 +0100
Subject: [PATCH 2/9] builtin/cat-file: wire up an option to filter objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In batch mode, git-cat-file(1) enumerates all objects and prints them
by iterating through both loose and packed objects. This works without
considering their reachability at all, and consequently most options to
filter objects as they exist in e.g. git-rev-list(1) are not applicable.
In some situations it may still be useful though to filter objects based
on properties that are inherent to them. This includes the object size
as well as its type.

Such a filter already exists in git-rev-list(1) with the `--filter=`
command line option. While this option supports a couple of filters that
are not applicable to our usecase, some of them are quite a neat fit.

Wire up the filter as an option for git-cat-file(1). This allows us to
reuse the same syntax as in git-rev-list(1) so that we don't have to
reinvent the wheel. For now, we die when any of the filter options has
been passed by the user, but they will be wired up in subsequent
commits.

Note that we don't use the same `--filter=` name fo the option as we use
in git-rev-list(1). We already have `--filters`, and having both
`--filter=` and `--filters` would be quite confusing. Instead, the new
option is called `--objects-filter`.

Further note that the filters that we are about to introduce don't
significantly speed up the runtime of git-cat-file(1). While we can skip
emitting a lot of objects in case they are uninteresting to us, the
majority of time is spent reading the packfile, which is bottlenecked by
I/O and not the processor. This will change though once we start to make
use of bitmaps, which will allow us to skip reading the whole packfile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc |  6 ++++++
 builtin/cat-file.c              | 37 +++++++++++++++++++++++++++++++++----
 t/t1006-cat-file.sh             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index d5890ae3686..7c1c888079a 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -81,6 +81,12 @@ OPTIONS
 	end-of-line conversion, etc). In this case, `<object>` has to be of
 	the form `<tree-ish>:<path>`, or `:<path>`.
 
+--objects-filter=<filter-spec>::
+--no-objects-filter::
+	Omit objects from the list of printed objects. This can only be used in
+	combination with one of the batched modes. The '<filter-spec>' may be
+	one of the following:
+
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
 	name and a path separately, e.g. when it is difficult to figure out
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8e40016dd24..723644fbba8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,6 +15,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "ident.h"
+#include "list-objects-filter-options.h"
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
@@ -35,6 +36,7 @@ enum batch_mode {
 };
 
 struct batch_options {
+	struct list_objects_filter_options objects_filter;
 	int enabled;
 	int follow_symlinks;
 	enum batch_mode batch_mode;
@@ -487,6 +489,13 @@ static void batch_object_write(const char *obj_name,
 			return;
 		}
 
+		switch (opt->objects_filter.choice) {
+		case LOFC_DISABLED:
+			break;
+		default:
+			BUG("unsupported objects filter");
+		}
+
 		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
 			size_t s = data->size;
 			char *buf = NULL;
@@ -812,7 +821,8 @@ static int batch_objects(struct batch_options *opt)
 		struct object_cb_data cb;
 		struct object_info empty = OBJECT_INFO_INIT;
 
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
+		if (!memcmp(&data.info, &empty, sizeof(empty)) &&
+		    opt->objects_filter.choice == LOFC_DISABLED)
 			data.skip_object_info = 1;
 
 		if (repo_has_promisor_remote(the_repository))
@@ -936,10 +946,13 @@ int cmd_cat_file(int argc,
 	int opt_cw = 0;
 	int opt_epts = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
-	struct batch_options batch = {0};
+	struct batch_options batch = {
+		.objects_filter = LIST_OBJECTS_FILTER_INIT,
+	};
 	int unknown_type = 0;
 	int input_nul_terminated = 0;
 	int nul_terminated = 0;
+	int ret;
 
 	const char * const builtin_catfile_usage[] = {
 		N_("git cat-file <type> <object>"),
@@ -1000,6 +1013,8 @@ int cmd_cat_file(int argc,
 			    N_("run filters on object's content"), 'w'),
 		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
 			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
+		OPT_CALLBACK(0, "objects-filter", &batch.objects_filter, N_("args"),
+			     N_("object filtering"), opt_parse_list_objects_filter),
 		OPT_END()
 	};
 
@@ -1014,6 +1029,14 @@ int cmd_cat_file(int argc,
 	if (use_mailmap)
 		read_mailmap(&mailmap);
 
+	switch (batch.objects_filter.choice) {
+	case LOFC_DISABLED:
+		break;
+	default:
+		usagef(_("objects filter not supported: '%s'"),
+		       list_object_filter_config_name(batch.objects_filter.choice));
+	}
+
 	/* --batch-all-objects? */
 	if (opt == 'b')
 		batch.all_objects = 1;
@@ -1068,7 +1091,8 @@ int cmd_cat_file(int argc,
 			usage_msg_opt(_("batch modes take no arguments"), builtin_catfile_usage,
 				      options);
 
-		return batch_objects(&batch);
+		ret = batch_objects(&batch);
+		goto out;
 	}
 
 	if (opt) {
@@ -1097,5 +1121,10 @@ int cmd_cat_file(int argc,
 
 	if (unknown_type && opt != 't' && opt != 's')
 		die("git cat-file --allow-unknown-type: use with -s or -t");
-	return cat_one_file(opt, exp_type, obj_name, unknown_type);
+
+	ret = cat_one_file(opt, exp_type, obj_name, unknown_type);
+
+out:
+	list_objects_filter_release(&batch.objects_filter);
+	return ret;
 }
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 398865d6ebe..48840a13561 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1353,4 +1353,36 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
 	perl -e "$script" -- --batch-command $hello_oid "$expect" "info "
 '
 
+test_expect_success 'setup for objects filter' '
+	git init repo
+'
+
+test_expect_success 'objects filter with unknown option' '
+	cat >expect <<-EOF &&
+	fatal: invalid filter-spec ${SQ}unknown${SQ}
+	EOF
+	test_must_fail git -C repo cat-file --objects-filter=unknown 2>err &&
+	test_cmp expect err
+'
+
+for option in blob:none blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
+do
+	test_expect_success "objects filter with unsupported option $option" '
+		case "$option" in
+		tree:1)
+			echo "usage: objects filter not supported: ${SQ}tree${SQ}" >expect
+			;;
+		sparse:path=x)
+			echo "fatal: sparse:path filters support has been dropped" >expect
+			;;
+		*)
+			option_name=$(echo "$option" | cut -d= -f1) &&
+			printf "usage: objects filter not supported: ${SQ}%s${SQ}\n" "$option_name" >expect
+			;;
+		esac &&
+		test_must_fail git -C repo cat-file --objects-filter=$option 2>err &&
+		test_cmp expect err
+	'
+done
+
 test_done

-- 
2.48.1.683.gf705b3209c.dirty

