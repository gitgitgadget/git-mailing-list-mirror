Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81481E4F13
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034635; cv=none; b=uQEFOdPoaai0Lyvayjep9U6gmtYzYD15tWQcjVf8gmHkfYwHaxKMwgFusRowbiWNwgsRiMw8L5a0Z7+IBwNtM7IPnB1J1ReMKRIjfnCmzIh76PtkjWTuudjGXxmM8AbOHbvY7ENyzOUGpDoTjxTRoSWWe+mHRZjSFinMeo+taJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034635; c=relaxed/simple;
	bh=J9ju/WYAcmZTrZGXDNQiSighlsoCJw57xcG9bFFdyXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6JbHpz/JhqvmfTIXTwsZhNo9eTJbWZ6R463LwfBECzuMvHHqcCQwsEWM8v7ziTcHXbM7XX3U1mOl0ofprb6+9PL9GpbUiBhzxbEzSJMrSlcDUt/AUeVp6/VPJyYiK9V5iZxuaMPDEtpNZ0R/9TdAMJLvebL6fLDMwHEi83/ZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z5AEdgkH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSFEhdsY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z5AEdgkH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSFEhdsY"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B9CDE138FC27;
	Wed,  7 Aug 2024 08:43:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 08:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034631; x=1723121031; bh=sLcDYWcLxB
	WewFijaQACv6JRKMtVXOiM2lYqyBr5Qsk=; b=Z5AEdgkHUowklnXVdTotZGqk+W
	XnLvCRDqlnb7yknL43sps3fIg8oJiSubNcQlo4dojPlvJrzKRkjzgk13u7hcgdfj
	haho+kv1CUc4OtqrRDHfnfUSESzlXJa6dtg0nYdxv91EgxrZvN1RqtYtfbQWiyNS
	3gS7pFOndha9S6tC8o5ozSiAds7qoO4LoXG8bPMLb0sfd/4F/5NySvcrsAdn24hF
	6rS9TmXw1XjISb8p+mvdhFdg7r1AjfUiMRSq56H5PaR7k0wTxX764scE5CLQMBY2
	vDxjiK14UzZW2wzWcgearavLfAl77AH6K3mCuqKzGWVVY+P62Ik5tsKYcW+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034631; x=1723121031; bh=sLcDYWcLxBWewFijaQACv6JRKMtV
	XOiM2lYqyBr5Qsk=; b=qSFEhdsYA+rHekr1WZOh3wlh9uiZmnR0p0gnCSBfAKpI
	RW+QYYB7oqSIKVrZI6FnMqDOJn/xNS6ZiZTtSzrmyBmAHno9FkqplGuEy9nf6MD2
	fiVfG+M+CFm6T7Pk8DBFbxbo+zUpFa3lKFCmSHkSUxaeTorIWjWTH3yRhI1h1qXY
	RuteZg2A/jInmDXbsStF4pI6P9gi+PwWYBeeijq+ZQedjXoxr8ZvBGs+gjz8qIIX
	Lv9yJ+IJn7b1RryWShNvVkQB70HPUxmbphVgMggpnZ5dQreJSSeZ8zJSJOWMaOSE
	af1ic1dNKmaLn1VJVEhIULAZ2Z8YJlDYtvq5O6MZvg==
X-ME-Sender: <xms:B2yzZjkKR0fo7ey72NjESTyYh_gI66_g4OiU2xEX9A94blSOWH8DRQ>
    <xme:B2yzZm2s8E5VSf64fQ3FiIirv1HU87P9KVyLNnr7HFvjBhkxyn_rHvUGlw7O9s9cn
    _qKt5vNkQeQkvjIlQ>
X-ME-Received: <xmr:B2yzZpqwP0lVYd6trcJWYI-F-dYEl_wOW9vT9NGeze-Gn2fq49HQYg8-rDa9SJWWXDGWHuaDxPbkmFHcwKe3HA4YG8YjKaQ-diJSpHSlMVTswtqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:B2yzZrn5owc9XpahscCKSZfV2KxeBihm-V3wG3BWnJ-oy3xXMt5jHg>
    <xmx:B2yzZh1O_XMyS211lnwT_M6D5cfoF1epxx2ch7SN56codQb0y-lskQ>
    <xmx:B2yzZqvsqqDB8VpVk719rLPTuSfNv-uns4N4yOl5BjAxvjc6nM3ugw>
    <xmx:B2yzZlX4qeODdRY11LvxXoP7nhZOKTcDr-AAJqzp_liMvpp19MIyOg>
    <xmx:B2yzZqwcZi7m9r-qiRz5asSyj7ljeThq2Oh76jTnlxUfQqAfnUrEL_Iv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:43:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4dbe104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:43:46 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:43:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 1/6] builtin/submodule: allow cloning with different ref
 storage format
Message-ID: <a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J89WDXVEGIC4C5Ga"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--J89WDXVEGIC4C5Ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As submodules are proper self-contained repositories, it is perfectly
valid for them to have a different ref storage format than their parent
repository. There is no obvious way for users to ask for the ref storage
format when initializing submodules though. Whether the setup of such
mixed-ref-storage-format constellations is all that useful remains to be
seen. But there is no good reason to not expose such an option, and we
will require it in a subsequent patch.

Introduce a new `--ref-format=3D` option for git-submodule(1) that allows
the user to pick the ref storage format. This option will also be used
in a subsequent commit, where we start to propagate the same flag from
git-clone(1) to cloning submodules with the `--recursive` switch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.txt        |  5 +++-
 builtin/submodule--helper.c            | 30 +++++++++++++++++++
 git-submodule.sh                       |  9 ++++++
 t/t7424-submodule-mixed-ref-formats.sh | 41 ++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 t/t7424-submodule-mixed-ref-formats.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.=
txt
index ca0347a37b..73ef8b9696 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -136,7 +136,7 @@ If you really want to remove a submodule from the repos=
itory and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for remov=
al
 options.
=20
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|=
--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth =
<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filte=
r-spec>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|=
--force] [--checkout|--rebase|--merge] [--reference <repository>] [--ref-fo=
rmat <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-=
branch] [--filter <filter-spec>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -185,6 +185,9 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
=20
+If `--ref-format <format>`  is specified, the ref storage format of newly
+cloned submodules will be set accordingly.
+
 If `--filter <filter-spec>` is specified, the given partial clone filter w=
ill be
 applied to the submodule. See linkgit:git-rev-list[1] for details on filter
 specifications.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1218a1995..42a36bc2f7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1532,6 +1532,7 @@ struct module_clone_data {
 	const char *url;
 	const char *depth;
 	struct list_objects_filter_options *filter_options;
+	enum ref_storage_format ref_storage_format;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
@@ -1540,6 +1541,7 @@ struct module_clone_data {
 };
 #define MODULE_CLONE_DATA_INIT { \
 	.single_branch =3D -1, \
+	.ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN, \
 }
=20
 struct submodule_alternate_setup {
@@ -1738,6 +1740,9 @@ static int clone_submodule(const struct module_clone_=
data *clone_data,
 				strvec_pushl(&cp.args, "--reference",
 					     item->string, NULL);
 		}
+		if (clone_data->ref_storage_format !=3D REF_STORAGE_FORMAT_UNKNOWN)
+			strvec_pushf(&cp.args, "--ref-format=3D%s",
+				     ref_storage_format_to_name(clone_data->ref_storage_format));
 		if (clone_data->dissociate)
 			strvec_push(&cp.args, "--dissociate");
 		if (sm_gitdir && *sm_gitdir)
@@ -1832,6 +1837,7 @@ static int module_clone(int argc, const char **argv, =
const char *prefix)
 	struct string_list reference =3D STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =3D
 		LIST_OBJECTS_FILTER_INIT;
+	const char *ref_storage_format =3D NULL;
=20
 	struct option module_clone_options[] =3D {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -1849,6 +1855,8 @@ static int module_clone(int argc, const char **argv, =
const char *prefix)
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
+		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_STRING(0, "depth", &clone_data.depth,
@@ -1875,6 +1883,11 @@ static int module_clone(int argc, const char **argv,=
 const char *prefix)
 	argc =3D parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
=20
+	if (ref_storage_format) {
+		clone_data.ref_storage_format =3D ref_storage_format_by_name(ref_storage=
_format);
+		if (clone_data.ref_storage_format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), ref_storage_format);
+	}
 	clone_data.dissociate =3D !!dissociate;
 	clone_data.quiet =3D !!quiet;
 	clone_data.progress =3D !!progress;
@@ -1974,6 +1987,7 @@ struct update_data {
 	struct submodule_update_strategy update_strategy;
 	struct list_objects_filter_options *filter_options;
 	struct module_list list;
+	enum ref_storage_format ref_storage_format;
 	int depth;
 	int max_jobs;
 	int single_branch;
@@ -1997,6 +2011,7 @@ struct update_data {
 #define UPDATE_DATA_INIT { \
 	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
 	.list =3D MODULE_LIST_INIT, \
+	.ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN, \
 	.recommend_shallow =3D -1, \
 	.references =3D STRING_LIST_INIT_DUP, \
 	.single_branch =3D -1, \
@@ -2132,6 +2147,9 @@ static int prepare_to_clone_next_submodule(const stru=
ct cache_entry *ce,
 			     expand_list_objects_filter_spec(suc->update_data->filter_options));
 	if (suc->update_data->require_init)
 		strvec_push(&child->args, "--require-init");
+	if (suc->update_data->ref_storage_format !=3D REF_STORAGE_FORMAT_UNKNOWN)
+		strvec_pushf(&child->args, "--ref-format=3D%s",
+			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
 	strvec_pushl(&child->args, "--url", url, NULL);
@@ -2562,6 +2580,9 @@ static void update_data_to_args(const struct update_d=
ata *update_data,
 		for_each_string_list_item(item, &update_data->references)
 			strvec_pushl(args, "--reference", item->string, NULL);
 	}
+	if (update_data->ref_storage_format !=3D REF_STORAGE_FORMAT_UNKNOWN)
+		strvec_pushf(args, "--ref-format=3D%s",
+			     ref_storage_format_to_name(update_data->ref_storage_format));
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=3D%s",
 				expand_list_objects_filter_spec(
@@ -2737,6 +2758,7 @@ static int module_update(int argc, const char **argv,=
 const char *prefix)
 	struct update_data opt =3D UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options =3D
 		LIST_OBJECTS_FILTER_INIT;
+	const char *ref_storage_format =3D NULL;
 	int ret;
 	struct option module_update_options[] =3D {
 		OPT__SUPER_PREFIX(&opt.super_prefix),
@@ -2760,6 +2782,8 @@ static int module_update(int argc, const char **argv,=
 const char *prefix)
 			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
+		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference format to use")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &opt.depth,
@@ -2803,6 +2827,12 @@ static int module_update(int argc, const char **argv=
, const char *prefix)
 				   module_update_options);
 	}
=20
+	if (ref_storage_format) {
+		opt.ref_storage_format =3D ref_storage_format_by_name(ref_storage_format=
);
+		if (opt.ref_storage_format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), ref_storage_format);
+	}
+
 	opt.filter_options =3D &filter_options;
 	opt.prefix =3D prefix;
=20
diff --git a/git-submodule.sh b/git-submodule.sh
index 7f9582d923..dcbe943071 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -268,6 +268,14 @@ cmd_update()
 		-r|--rebase)
 			rebase=3D1
 			;;
+		--ref-format)
+			case "$2" in '') usage ;; esac
+			ref_format=3D"--ref-format=3D$2"
+			shift
+			;;
+		--ref-format=3D*)
+			ref_format=3D"$1"
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference=3D"--reference=3D$2"
@@ -349,6 +357,7 @@ cmd_update()
 		${rebase:+--rebase} \
 		${merge:+--merge} \
 		${checkout:+--checkout} \
+		${ref_format:+"$ref_format"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
 		${depth:+"$depth"} \
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
new file mode 100755
index 0000000000..de84007554
--- /dev/null
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description=3D'submodules handle mixed ref storage formats'
+
+. ./test-lib.sh
+
+test_ref_format () {
+	echo "$2" >expect &&
+	git -C "$1" rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+}
+
+for OTHER_FORMAT in files reftable
+do
+	if test "$OTHER_FORMAT" =3D "$GIT_DEFAULT_REF_FORMAT"
+	then
+		continue
+	fi
+
+test_expect_success 'setup' '
+	git config set --global protocol.file.allow always
+'
+
+test_expect_success 'clone submodules with different ref storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -m "upstream submodule" &&
+
+	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
+	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
+	git -C downstream submodule update --init --ref-format=3D$OTHER_FORMAT &&
+	test_ref_format downstream/submodule "$OTHER_FORMAT"
+'
+
+done
+
+test_done
--=20
2.46.0.dirty


--J89WDXVEGIC4C5Ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazbAMACgkQVbJhu7ck
PpRchg//eXvjhAUi2Ws63PW1yw4YHpFrPjs9OIBn8IZ8mjSYwoGXlt3gn8Z85EVb
Z0/n3PteF00Saknzg7tMiaopaSCciEQeayttIlCXKLwTgX9gM5FYdr07kjKQPqSI
O4ouSajBxh6RYZ9lUrkxbLF93A2w/92ljEL1rR7THmW/32DCzGXmD7ybSplSAL9Z
3T5/WZSGVHX00P/aMZxGoUSQ59Nk3I7Ypt9OlOowhkhLGtlTf4RfVEnUtKdqn1Zf
0T0wABH+pEpce5VZWPO8t3uWQVMo2aLqynu7RfH3ugaBqzLqpfqrwoLwL3ZwiUZa
vVvUugjtvnB4VGxQ6c743q65knBU8DdX/VkpJ3nyr5DAi9325JArENLuHNo28r1o
jg8/LKVWLVtkY5jQweNGPTMSpRbz0ym2LCPSDCvTDDSeEs9u/JHZxAyvNduoauj2
KXxv4O1lrBpjIaQvZugHKaxodylcuyh9Ui4VCCRNy1dBW9j21ZA5nIW5R4BDTPp6
ft6L1rPUTlt+qWVFEu+6jbfqDG1u0gc6C8/IiRjQE4q7whlvdkYAzSVu/UmYvBcZ
yXgTtt4zg13v4KJcQ+yQMXlGHkOK++tJjBKbNbRBMwrekJ/gh8ZxOpud9e+RMyJO
7X07GM1KGy+2N7HTlyVy6gckKXjvgLfspgN2gEkVvjfn02jOm/s=
=W0TD
-----END PGP SIGNATURE-----

--J89WDXVEGIC4C5Ga--
