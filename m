Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9C144306
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102552; cv=none; b=j4YuFGub1AcquN5Rkd00py5kIo3KL9q/POCTV3dPujkbwbjDQCYw27AisU3bBf0Etxzt+Alee+AqDbOtXOGt+JGooK9eRWgtu6MNiCTdZImAigWfmtNYxtuPrHh+giapYJ3oLl0S8uSspPB481CHDAMtJW+nzdWwun7aXQps3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102552; c=relaxed/simple;
	bh=NK2xje7aGwQ8SXUPlRMQkjqvafEyLVMD8oOejojieZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm49PebkASymYGqdHTIXB7hTof5mCTSCpBNMDhep6rfbqrkxR6PCTgx/MzpTnP9VzpTGd5gChIxhe92xWkgBSxu+gYdKhMA1aOkqoHXK+5S34VLovCiuT+GiPfEv9aYZvEYV3Y4/z8uAx0m0nkHwEbMv7MudTBOme/X8QCeZhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qQAYxp2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7YPH+IU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qQAYxp2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7YPH+IU"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 84881138FE23;
	Thu,  8 Aug 2024 03:35:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 03:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102550; x=1723188950; bh=KxlkCDQu/F
	dkwNJEw7LaXbmWERXmzorW8xyIiI26aWM=; b=qQAYxp2uJjSv3vy08llqpvUMQn
	2ABwcgw2T/uSUXDaypDUpJy1OzBI3j0bAZ/Ga6f4xEEXpKZWFa0bEmL1rvfqOZmh
	s++dVdyHofAERjqZ+qCbR0GBqbu4pfXt30HaRFmnkf0Uwseu3zdrYYumKm1AFdFD
	tEJcd1qFvX5HV7Wcteiu9pfDlo4xA57QIlBbjhZswq10DSEIXiHPzROYLzw48SNK
	aMFLPGNm7moX5PUekw/Gbhc6KlTYlkW016hvaTRJ7STnDfPdhi5ANohcAcUJNoJz
	4Qa6rqZg4p99FNP8Uv2lZBi5npqH+AJzQO+k6lNSyDwtcFxG/7tZq+5uo/+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102550; x=1723188950; bh=KxlkCDQu/FdkwNJEw7LaXbmWERXm
	zorW8xyIiI26aWM=; b=W7YPH+IUOzR9XCGdZRJjkBQrqbqvG6ZbErXAD4p4JCXv
	yds5NN4shFKqoHm91p9owsaPJmfnr423zY/HCtva0TdDlVygJnXeNsecd/mFpZ08
	KSRvbSAaCYi83XynBh4oPtWOk7o+T4FZX7SSvRLhhxBIF84g7TTanPqCN5kKyDJ0
	0yi9gBWPpUQqTLF1VxnfFdya7EPhWxqDrx8vrgneORqCaAgw5FxmSVL4xABlwtWs
	g1+yzEi+jv0tvo6qR2XvSzkWPiW92yxRoJwZvlaPBmxMAiAhruBC13z2GhZlcDm6
	mRlmmrZyGFL2jH8sFyQj2wE4jr7GxvV71/qbAhH4ZA==
X-ME-Sender: <xms:VnW0ZvGE-I6XTECDt4V12r9L0UazKHUmxwvyzgD23ZJzBA-nMDtILw>
    <xme:VnW0ZsU8Y_sPM3aI_9YbFpEadhZ9kxLrDYeT985AIq1iUBFUA9tbsGFnKwcf-xOzp
    VI-b1Yjfb1N9JYzSw>
X-ME-Received: <xmr:VnW0ZhI21gQYHBzE18lRDecf6UJTRNrN-WItrFBj3joqJUiyAFsNXmBb1B8Dg1L4FofazoWjMc8Mng1f1fTkKCiNJ2AoR_AOQl3CdwYB60aj97Jr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhholhgrnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomh
X-ME-Proxy: <xmx:VnW0ZtGdRD3FbVIxpujJr5MbmgsVR2o8et-x9fDvsn7-NFRR1UVhyw>
    <xmx:VnW0ZlW88LIB4wQWDov4EE96OOsAvg9SM39mkHm5PBgbL3d_rQu3gw>
    <xmx:VnW0ZoMq904Sj6G8m3c4sii3kSYp9FZVTCnP7PNpLWpwXNFWVoVA8w>
    <xmx:VnW0Zk1d0OzP6RlIlXdIQYW_bjbxPq7pveFQxhUTX4xRb6lTYtc6og>
    <xmx:VnW0Zrxo4ZTA8utn05JhEP9y46rkHHko4BISCXxM-JPX4nUvcQ0yKfFT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4ed108d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:42 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] builtin/submodule: allow "add" to use different ref
 storage format
Message-ID: <4ce17e44a16335adf9423a227047d3810608aae4.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7uA5rIA1UAcwYeHM"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--7uA5rIA1UAcwYeHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with "clone", users may want to add a submodule to a repository
with a non-default ref storage format. Wire up a new `--ref-format=3D`
option that works the same as for `git submodule clone`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.txt        |  5 ++++-
 builtin/submodule--helper.c            | 16 +++++++++++++++-
 git-submodule.sh                       |  9 +++++++++
 t/t7424-submodule-mixed-ref-formats.sh | 11 +++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.=
txt
index 73ef8b9696..87d8e0f0c5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -34,7 +34,7 @@ COMMANDS
 With no arguments, shows the status of existing submodules.  Several
 subcommands are available to perform operations on the submodules.
=20
-add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] =
[--depth <depth>] [--] <repository> [<path>]::
+add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] =
[--ref-format <format>] [--depth <depth>] [--] <repository> [<path>]::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -71,6 +71,9 @@ submodule repositories will be kept together in the same =
relative
 location, and only the superproject's URL needs to be provided.
 git-submodule will correctly locate the submodule using the relative
 URL in `.gitmodules`.
++
+If `--ref-format <format>`  is specified, the ref storage format of newly
+cloned submodules will be set accordingly.
=20
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 42a36bc2f7..48f4577b53 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3128,13 +3128,17 @@ struct add_data {
 	const char *sm_name;
 	const char *repo;
 	const char *realrepo;
+	enum ref_storage_format ref_storage_format;
 	int depth;
 	unsigned int force: 1;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
 };
-#define ADD_DATA_INIT { .depth =3D -1 }
+#define ADD_DATA_INIT { \
+	.depth =3D -1, \
+	.ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN, \
+}
=20
 static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_p=
ath)
 {
@@ -3228,6 +3232,7 @@ static int add_submodule(const struct add_data *add_d=
ata)
=20
 			string_list_append(&reference, p)->util =3D p;
 		}
+		clone_data.ref_storage_format =3D add_data->ref_storage_format;
 		clone_data.dissociate =3D add_data->dissociate;
 		if (add_data->depth >=3D 0)
 			clone_data.depth =3D xstrfmt("%d", add_data->depth);
@@ -3392,6 +3397,7 @@ static int module_add(int argc, const char **argv, co=
nst char *prefix)
 {
 	int force =3D 0, quiet =3D 0, progress =3D 0, dissociate =3D 0;
 	struct add_data add_data =3D ADD_DATA_INIT;
+	const char *ref_storage_format =3D NULL;
 	char *to_free =3D NULL;
 	struct option options[] =3D {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
@@ -3402,6 +3408,8 @@ static int module_add(int argc, const char **argv, co=
nst char *prefix)
 		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
 		OPT_STRING(0, "reference", &add_data.reference_path, N_("repository"),
 			   N_("reference repository")),
+		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
+			   N_("specify the reference format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from refer=
ence repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
 			   N_("sets the submodule's name to the given string "
@@ -3428,6 +3436,12 @@ static int module_add(int argc, const char **argv, c=
onst char *prefix)
 	if (argc =3D=3D 0 || argc > 2)
 		usage_with_options(usage, options);
=20
+	if (ref_storage_format) {
+		add_data.ref_storage_format =3D ref_storage_format_by_name(ref_storage_f=
ormat);
+		if (add_data.ref_storage_format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), ref_storage_format);
+	}
+
 	add_data.repo =3D argv[0];
 	if (argc =3D=3D 1)
 		add_data.sm_path =3D git_url_basename(add_data.repo, 0, 0);
diff --git a/git-submodule.sh b/git-submodule.sh
index 448d58b18b..03c5a220a2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -94,6 +94,14 @@ cmd_add()
 		--reference=3D*)
 			reference_path=3D"${1#--reference=3D}"
 			;;
+		--ref-format)
+			case "$2" in '') usage ;; esac
+			ref_format=3D"--ref-format=3D$2"
+			shift
+			;;
+		--ref-format=3D*)
+			ref_format=3D"$1"
+			;;
 		--dissociate)
 			dissociate=3D1
 			;;
@@ -135,6 +143,7 @@ cmd_add()
 		${progress:+"--progress"} \
 		${branch:+--branch "$branch"} \
 		${reference_path:+--reference "$reference_path"} \
+		${ref_format:+"$ref_format"} \
 		${dissociate:+--dissociate} \
 		${custom_name:+--name "$custom_name"} \
 		${depth:+"$depth"} \
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
index d4e184970a..559713b607 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -37,6 +37,17 @@ test_expect_success 'add existing repository with differ=
ent ref storage format'
 	)
 '
=20
+test_expect_success 'add submodules with different ref storage format' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
+	git -C upstream submodule add --ref-format=3D"$OTHER_FORMAT" "file://$(pw=
d)/submodule" &&
+	test_ref_format upstream/submodule "$OTHER_FORMAT"
+'
+
 test_expect_success 'recursive clone propagates ref storage format' '
 	test_when_finished "rm -rf submodule upstream downstream" &&
=20
--=20
2.46.0.46.g406f326d27.dirty


--7uA5rIA1UAcwYeHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dVIACgkQVbJhu7ck
PpSo2RAAqDPIa2Id5QSfNwGC7PU7ZHXVZYdYMC23ExM/2p+yAD9iQeUeVfSRpxTz
d56jglGINEHm5HU0tQ/aikUi9RltCUGtQdJMw2Tz+69xy88/itClz3mawaxORwha
1XAV4lCYDoZQJwRw8zu+/GuTm4As9n8FaHR2LKMBZIq0yUBEom6KrS3KsTi50GWu
7ilasRYZBxNxPiHW2dtEHxgAsxjac7BHROcYLVMYx5PmfnUo6PEj+Qx00387ipUv
bgwCOVFk1PA8MoT3fkxIKbI39l9FaTgetIa9VQ0o3n5fkfYyAf9RmNAzUjuHiMU1
Bx9z07bFenfaO0T+OftCXIbkOJjO7MCv0XZym7kMGAfanhaG0MNx5mp+7D5HSJbe
MmvKB7W+FaX8sjKCt6qI/NqGCvAbb0mHD22TX44VGTlCo5JhQrA9KfbMHL9v9Zxj
me4MbLLRkvQlp50N3fVkFrl8I/xbi1oK3LV3NE8WdFPWzseG1lFU48/a/6Xan0Yi
XzvcloHlqb7ULFX2+kPlZV90f6VN4RCdEBqz+ynCSgSK6R+5nkYPqeHnY/CPCaz6
MiSS7u0voWamgsybFubZurWUknoqs0sUQMkNg9YJmmEwMbREYqCQAur8Op9cPXa7
UF6yRfZloIife/bTH0gA7PIw5/a9F7PdZEBUHXRbo9kCwzcMHK0=
=kWib
-----END PGP SIGNATURE-----

--7uA5rIA1UAcwYeHM--
