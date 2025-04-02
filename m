Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8A239083
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592428; cv=none; b=qlgLxwpnvgWFDSLdIqp//7uPfhLIEeNSEK8a0mrevycRVlKgNFcFY3N9usmaZt/4FZGYdIcBYLIKBrtcNCDrjLhGKZ746JPAI2OLF4a2VkWqO7LjLEdZsQ5eefZMCo+Frn3qahYLaU0pf0K+PPvR8FPhm5zWqev9Jh8KhyNtb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592428; c=relaxed/simple;
	bh=NOhY+B8jpy7+AUq7kkVPZVuaTgkWnL9RCnN7MtKsZvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qT/oCvABkIhHvIr2+BHy6708iCZhvGbMDiZqzPSlv1URmaIfyoD7uIm9lLsnLw8dGbYYW0q5hbmC4CO5vp8Jvfol/+vHyfkt7Jjy91GHJtYOrC2qIN4FE+Yr8DwPZQ5WskzOkaE/+yCrS858qcDatC0U/t3U0teeVAaMEYBEigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LkidPdDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwI0MpHx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LkidPdDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwI0MpHx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3DF0254005F;
	Wed,  2 Apr 2025 07:13:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Apr 2025 07:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592425;
	 x=1743678825; bh=m0NETpY7dNWaJcB5dXsY3v8w5svuq/Rx1seyQxYEC+Y=; b=
	LkidPdDP1bXZcE/nRHllCKZJPZK2B+LmYs52nOB85e+ptKxAsXooZHmcN1FOzydj
	JYTTW/7wEd+riqAZr/RRCeFEDdF2t23M/DsQFws2y74yLPK4BsGkMNF0aic65Oo4
	AtigF6SZF4Be20oqBq0LycBp74UX5OzunEcNRWhCMM5zUsQfIoZDnsLwSn2LJSIi
	uhbG2uzAF0aLirWW+JnIPc1H/1SoHIUyeQjyDOTp0dY9nioo5yu5rGP/QgcrM/4g
	BlMFpOXY6qcD6mcoUCtbvxmmfyqvkgLqjJ3CSKd4pqRU2ue3VrDBoseB02M42amV
	ukjv5sT4BLm94/qekC4eow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592425; x=
	1743678825; bh=m0NETpY7dNWaJcB5dXsY3v8w5svuq/Rx1seyQxYEC+Y=; b=K
	wI0MpHxyqnjojf9pWoJa7rnZ0uQrd60TEHkm/faDUCdsVBbcr9XA4sNbhMdMRF4l
	JYjHXPBhlaef5OX0Mcy5L6OxKm8f9Tvf1sCO7uim9Nod3SEnsPOuMU5ub0q1EuXA
	JftOofZon8ghh5U+2mQE42yndlyipWi8QbceDIhPpXbnGd5SNBFaa8kW2drApeNO
	eCC+9R88EQ/XvxoXXWJdm6/CoULxHOlWeyanT+OmBjCbVNHQC/c1lqmGIs0+WOtk
	uDYZm9+OkyZAeUHUXZUI3tEkkTJxc/K1pw55K+XQPVpcs1h3SBInvYs11EUjACu0
	kGpJEfHSyvm84MsERRUhw==
X-ME-Sender: <xms:6RvtZ70u5cQ8uxqYk2LFh_7C1Du9ZnUO4gfYQmGBc0KRnGPO_Snwdw>
    <xme:6RvtZ6HQxAGuyHEgRBovFN5_YKHvtdnxjCUBRrpQVSUi7tCkMhSiBRzonteW5zK1y
    GUudoaGCGoAVsJvZQ>
X-ME-Received: <xmr:6RvtZ77SCX7DhgpFF515tbcRLQ3Nlh7hMlbFqRX5MZwdbIBc53ZFrcUvMA_RM9-1rl2fYX5O0HE9sZj4CZan53FLfnlfMdN_bR4zcU76vxegRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6RvtZw3bkM0IE_eg9t0RzEx3520dZL3IFE7q01s8_QoGunUWnx8EGA>
    <xmx:6RvtZ-G2uh1VeUjPi551Hg-0dpgBcbNvWTeIK2xYAWDiTYAohf4_xg>
    <xmx:6RvtZx-gIJ-IR7Jx-nwOx5hoykn6U9FBmkCWAqp-r2xmSR4L-oKkFw>
    <xmx:6RvtZ7mY8QEy-w0k48UzgbdO2fzKDuKCUZ9hVmYQimRs5rcvSnvPrA>
    <xmx:6RvtZ7Hc4zlxviIQaKYApPKBiT2KdufEeFcEmoVl8BgUyBf49hhj1jEn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4569fb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:38 +0200
Subject: [PATCH v3 03/11] builtin/cat-file: wire up an option to filter
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-3-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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

Further note that the filters that we are about to introduce don't
significantly speed up the runtime of git-cat-file(1). While we can skip
emitting a lot of objects in case they are uninteresting to us, the
majority of time is spent reading the packfile, which is bottlenecked by
I/O and not the processor. This will change though once we start to make
use of bitmaps, which will allow us to skip reading the whole packfile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc | 16 ++++++++++++++++
 builtin/cat-file.c              | 36 ++++++++++++++++++++++++++++++++----
 t/t1006-cat-file.sh             | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index d5890ae3686..da92eed1170 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -81,6 +81,15 @@ OPTIONS
 	end-of-line conversion, etc). In this case, `<object>` has to be of
 	the form `<tree-ish>:<path>`, or `:<path>`.
 
+--filter=<filter-spec>::
+--no-filter::
+	Omit objects from the list of printed objects. This can only be used in
+	combination with one of the batched modes. Excluded objects that have
+	been explicitly requested via any of the batch modes that read objects
+	via standard input (`--batch`, `--batch-check`) will be reported as
+	"filtered". Excluded objects in `--batch-all-objects` mode will not be
+	printed at all. No filters are supported yet.
+
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
 	name and a path separately, e.g. when it is difficult to figure out
@@ -340,6 +349,13 @@ the repository, then `cat-file` will ignore any custom format and print:
 <object> SP missing LF
 ------------
 
+If a name is specified on stdin that is filtered out via `--filter=`,
+then `cat-file` will ignore any custom format and print:
+
+------------
+<object> SP excluded LF
+------------
+
 If a name is specified that might refer to more than one object (an ambiguous short sha), then `cat-file` will ignore any custom format and print:
 
 ------------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1261a3ce352..0e2176c4491 100644
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
@@ -495,6 +497,13 @@ static void batch_object_write(const char *obj_name,
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
@@ -820,7 +829,8 @@ static int batch_objects(struct batch_options *opt)
 		struct object_cb_data cb;
 		struct object_info empty = OBJECT_INFO_INIT;
 
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
+		if (!memcmp(&data.info, &empty, sizeof(empty)) &&
+		    opt->objects_filter.choice == LOFC_DISABLED)
 			data.skip_object_info = 1;
 
 		if (repo_has_promisor_remote(the_repository))
@@ -944,10 +954,13 @@ int cmd_cat_file(int argc,
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
@@ -1008,6 +1021,7 @@ int cmd_cat_file(int argc,
 			    N_("run filters on object's content"), 'w'),
 		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
 			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&batch.objects_filter),
 		OPT_END()
 	};
 
@@ -1022,6 +1036,14 @@ int cmd_cat_file(int argc,
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
@@ -1076,7 +1098,8 @@ int cmd_cat_file(int argc,
 			usage_msg_opt(_("batch modes take no arguments"),
 				      builtin_catfile_usage, options);
 
-		return batch_objects(&batch);
+		ret = batch_objects(&batch);
+		goto out;
 	}
 
 	if (opt) {
@@ -1108,5 +1131,10 @@ int cmd_cat_file(int argc,
 
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
index 398865d6ebe..9ce4eda6e68 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1353,4 +1353,44 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
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
+	test_must_fail git -C repo cat-file --filter=unknown 2>err &&
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
+		test_must_fail git -C repo cat-file --filter=$option 2>err &&
+		test_cmp expect err
+	'
+done
+
+test_expect_success 'objects filter: disabled' '
+	git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --no-filter >actual &&
+	sort actual >actual.sorted &&
+	git -C repo rev-list --objects --no-object-names --all >expect &&
+	sort expect >expect.sorted &&
+	test_cmp expect.sorted actual.sorted
+'
+
 test_done

-- 
2.49.0.604.gff1f9ca942.dirty

