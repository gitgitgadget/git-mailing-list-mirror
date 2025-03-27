Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69A2E628
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068652; cv=none; b=okexMgA/4uex07zmTa9iTkqtyNHwnarur6tj9QN1Zh4HmmKu6A439idT6eX+KoMJKnE7SmAIrr3UAmHvifvolzOwF0yZQH93c+HG5vTuSNEFAHqhpxpdtPjlS4B02Z6E3mXdXHkF4FiErJDSEE3iZ7owGYKi0paDKRGVvnlufHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068652; c=relaxed/simple;
	bh=I6LwjESBgv/gGH5xN8vbql7Jzv0oHUVfECrHfFjwJ+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxJi5M63DTHLxPCI2M+mzREib3by2CshECexBDrGdad96a2KiFjuN2Sj3tfkvSRbNSxOTlxw6u7sFPhOVn5+32N+OT18FXZCEQPBbLJLcP2+d1AEA1iYtZX7VbMSrChpcrfyaexY0QDoMEfsaTepeDIw8wMLBCQWdrnL3vq01o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iMbh5lJb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdBhRxNh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iMbh5lJb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdBhRxNh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C51C51382D85;
	Thu, 27 Mar 2025 05:44:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 05:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068648;
	 x=1743155048; bh=x3MgW3hGucJp4NocNta1JGJLz4CNO47BcOpT4OeP4GM=; b=
	iMbh5lJbaPUCFRRMA9/FbzngeULA+0E/lIy6PyCKMdjVd58GkjxbdW5MLRh/t1F7
	mkcV0QWOY6StLdb5c2hoeMt/V9kUyIudJdk//s+CVRAJy2cSa+zcGdCChwt1s+yO
	RZwQagZuQuQuWetHhH6Jd6zNX1CmugK7eUSHrBwjuJwS7DJkeGlVtK9XtTIjmfKN
	laV+w5u73qGcrdA47lxwdnC/QYJbYIZ+pPpv2KNHPsUR/dt++AYjJChKkboghqRG
	vQfI5yI3Ilidjni0Odeml0LqXHMCMSPUxhlvnGv+4P2XWC0Ew+cmTV8+rxVX25W+
	NZO3synO3r++oDmiBB9goQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068648; x=
	1743155048; bh=x3MgW3hGucJp4NocNta1JGJLz4CNO47BcOpT4OeP4GM=; b=L
	dBhRxNhwJAOtuVcE7qLrQiAD02GG34hxnrjxQz4rK7hF/EMTx9UWWXRV3GmeG6QH
	sjw5uwskNIOvSoRoT3x8kzzooJN9Ne3/CGBIW/oBkmsodGGkyh1w2eCP+oNAL/rT
	EYs4Fkezxv30D5R+c4B4jg83/OSopo84HMD5/fjOF7Qqo3qCzUoGJSJTRyLoi2Qd
	RARNbl6ojysAG4383463ekV0I/cA08qbYcvlFSx3yMXX9Mchn9csw7b6m+JR3Ea7
	IfeGX9PUsEQoDvAbWqo5d2aWcxaWFkj5VXtrm7SBT3HDI/w6wt/bkAXiSkyFqeVi
	bBYLBX3qTaRd42Z52dGOg==
X-ME-Sender: <xms:6B3lZwIaSZkRPldZLoGyingFlW5RCfTW_mhW3wvUoJVnVeFOrzxseQ>
    <xme:6B3lZwL7S-9ALI1DiXGZAiCe70iWRSzVFmoiwGzM72a0Yd7TzdB54daImPCLYq-QD
    ygERQtNBebjdfkmCQ>
X-ME-Received: <xmr:6B3lZwsEFkBpOZVL2bshBQzjegZGjHkwlFW7qWLTKNT4_xEZRNTbt-eq0SXioT6EtY4nXDc2QnKAFZV42phc7EHhCbDHdqDj8nU059GV5hWCXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6B3lZ9YGCZp7WOVpMRy1W9FDbbiC20_gfq4BclKQ4pA-iKzc8snj8A>
    <xmx:6B3lZ3bxh88Cw1oklmHKE72uAq-SkxwPIToIJNLGYFt64pZJ4HXU5Q>
    <xmx:6B3lZ5BvgO0UVNOa_ZUiKo-wlaOeR_TZ6eTBmst70HXxcHG16cvOiw>
    <xmx:6B3lZ9ZxSK_aLfn5pXgRNuvGBFeQSQHxhxQ4Ua97wG4hq6rFaPNDFQ>
    <xmx:6B3lZyygrxnh78NceZRBtqKYY8ro7i9RSEQNOoLeB3yu-aHJa_6o5q6V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f691de43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:43:57 +0100
Subject: [PATCH v2 02/10] builtin/cat-file: wire up an option to filter
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
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
 Documentation/git-cat-file.adoc |  6 ++++++
 builtin/cat-file.c              | 37 +++++++++++++++++++++++++++++++++----
 t/t1006-cat-file.sh             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index d5890ae3686..f7f57b7f538 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -81,6 +81,12 @@ OPTIONS
 	end-of-line conversion, etc). In this case, `<object>` has to be of
 	the form `<tree-ish>:<path>`, or `:<path>`.
 
+--filter=<filter-spec>::
+--no-filter::
+	Omit objects from the list of printed objects. This can only be used in
+	combination with one of the batched modes. The '<filter-spec>' may be
+	one of the following:
+
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
 	name and a path separately, e.g. when it is difficult to figure out
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8e40016dd24..940900d92ad 100644
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
+		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
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
index 398865d6ebe..1246d3119f8 100755
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
 test_done

-- 
2.49.0.472.ge94155a9ec.dirty

