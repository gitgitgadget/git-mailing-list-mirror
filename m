Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138C2D8DBD
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834761; cv=none; b=kpOm+BJ2nLY8jP67ziafz/v3GTuI6QcBjLlSitx4CkwnkyYpBohiwGj357ZfFf8bulctn0Il9hn3zv+sUkuv+N/dNgoVSPTlkVn4RPUmosSisHujSohpFHufGkZIJkVxd/Hh3DsnJ0aP8G8LgaxMbgmB1waRFCbB25JcGzvrVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834761; c=relaxed/simple;
	bh=0q83IBBP9EOiS06IiTbeJLK/RsGll9h3CCmFipeV6o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shAuWzr+8Jza0npo2/MbtgxaN0dz9EKl8k0YAtsPyiiPZ4cl0iMGMrue/ZfNa5n9AsvdVtFxXiHMTdT9USg2Cst/QFpsyWK+USPAdwJRNaRq+9bt9Meo0X+uIh9S+q/y0RHHzczOPToHW6D7zklCys5WqN4IOnXcwYqT4YhVMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q4bWEZFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBuKWGv3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q4bWEZFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBuKWGv3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9470A7A008D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 06:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834758;
	 x=1759921158; bh=O97aGnnjHGEJBsppce1yK8nljxlpx6P6xJ/R/X2e9wE=; b=
	q4bWEZFOn1GtoiroO1bQvu2t6xO4njpyc+GfBo/PCymp+ZpnWxrlT7Ypu8TlL+WY
	tBPMyNUmfqLvrQ20EG3a7a9JdhrEBtGSSwEZqf4F5Y5mx4CuFNhqxHIgsVGiNfhx
	GoP+OBqGXDTAYwjDY+ZVsZZZXz0Odd7+TLlTYFJcIvJijP5Ot5AoVIvP9lVsg8Lp
	4AhHO653KQPnp2TUVHMkhaIeQakyLP8bFybJn2pyTEFTeJXUaWs6GKUdAgedfkq+
	nqiW8yIfMR7n7erHoPw8QAjD7PbCHaJ1kuaOL4g24yzgX9ntowNtB6p2N2Hx1f/+
	olFdnwaSNiIQ2sfnv1brSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834758; x=
	1759921158; bh=O97aGnnjHGEJBsppce1yK8nljxlpx6P6xJ/R/X2e9wE=; b=w
	BuKWGv3C3u/WZYJISbbamnQveWzm24DUKE6FjVqE6Juc8yvsnugamPLQT7AbXD2C
	FJitJBPvjHea6AFQv04xbWS0OZXft4sTiBfcR7Rrw4UUfiGM4nV6njsgEv3EGaAr
	d/IqOo3WU5vI16I5XDV0kKa5Q+stgQCy96AhvSb/Y5pKVcX3TtvjH0fkb+28SiZz
	uvlKfWt6RGnXWXpxbdejEKlRhbU05gswc2ISEiu1rISeou4FrEHXq8rh7uE9l8u2
	C+ns5EDCpnUMdmKBv2lZdcfYcCx8JLaYxGL+WVNbmYRpkZ1tjMCwEVAAve4bYkc3
	EIiy6gfDYO6nv+HhVwgxg==
X-ME-Sender: <xms:hvLkaIDEAgcozPfRzUIBgwcVDq9rPx5GE_r5rzxZefal6Q8bjMSvHg>
    <xme:hvLkaBe_WEXjzSow0zvGOTmfcF8WVBiMHykU3Nc6P_ffYKXaiUStJD4NtByLwHTfl
    0p7rfW923LWofD2pLgLJE_uCgSg6OnaQrRjh7Vm01d8bUvJ0vsx>
X-ME-Received: <xmr:hvLkaBNyztmresDSVrM_7sO3_LSSt27Znhv9iCbj9lrfTlHPPSdjEVhvi_VhliPxuyLtM7jF5jeWu7TbdAI5ELSBCpXlL7G3TckujKTbEVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:hvLkaD4lXUMod73WhFOxCN0GhsnVKHaN9L6nI29bf7HjMBhY429XBQ>
    <xmx:hvLkaNKEaxgzyU2MDQskgdeLSwZ6hlqZXJNhMJdKwRNPuD3S_V4BQg>
    <xmx:hvLkaFcmX06HEUOUlHKF0Qj3zsapelxPWWj_x0Kb6L734teb7a_gdw>
    <xmx:hvLkaIeGKLSiwUrRZ-tQzsC3LrAg0RkohrZpoYTv8_ZKAnj_xKAPfg>
    <xmx:hvLkaDBA_VYIVllHgSmpVWrwED8j3uhQvwFWvXdTw64mFdlhc1FEJk-0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22e938cb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:44 +0200
Subject: [PATCH 07/13] builtin/show-ref: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-7-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The git-show-ref(1) command has multiple different modes:

  - It knows to show all references matching a pattern.

  - It knows to list all references that are an exact match to whatever
    the user has provided.

  - It knows to check for reference existence.

The first two commands use mostly the same infrastructure to print the
references via `show_one()`. But while the former mode uses a proper
iterator and thus has a `struct reference` available in its context, the
latter calls `refs_read_ref()` and thus doesn't. Consequently, we cannot
easily use `reference_get_peeled_oid()` to print the peeled value.

Adapt the code so that we manually construct a `struct reference` when
verifying refs. We wouldn't ever have the peeled value available anyway
as we're not using an iterator here, so we can simply plug in the values
we _do_ have.

With this change we now have a `struct reference` available at both
callsites of `show_one()` and can thus pass it, which allows us to use
`reference_get_peeled_oid()` instead of `peel_iterated_oid()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4803b5e598..4d4984e4e0 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,31 +31,31 @@ struct show_one_options {
 };
 
 static void show_one(const struct show_one_options *opts,
-		     const char *refname, const struct object_id *oid)
+		     const struct reference *ref)
 {
 	const char *hex;
 	struct object_id peeled;
 
-	if (!odb_has_object(the_repository->objects, oid,
+	if (!odb_has_object(the_repository->objects, ref->oid,
 			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
-		die("git show-ref: bad ref %s (%s)", refname,
-		    oid_to_hex(oid));
+		die("git show-ref: bad ref %s (%s)", ref->name,
+		    oid_to_hex(ref->oid));
 
 	if (opts->quiet)
 		return;
 
-	hex = repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
+	hex = repo_find_unique_abbrev(the_repository, ref->oid, opts->abbrev);
 	if (opts->hash_only)
 		printf("%s\n", hex);
 	else
-		printf("%s %s\n", hex, refname);
+		printf("%s %s\n", hex, ref->name);
 
 	if (!opts->deref_tags)
 		return;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled)) {
 		hex = repo_find_unique_abbrev(the_repository, &peeled, opts->abbrev);
-		printf("%s %s^{}\n", hex, refname);
+		printf("%s %s^{}\n", hex, ref->name);
 	}
 }
 
@@ -93,7 +93,7 @@ static int show_ref(const struct reference *ref, void *cbdata)
 match:
 	data->found_match++;
 
-	show_one(data->show_one_opts, ref->name, ref->oid);
+	show_one(data->show_one_opts, ref);
 
 	return 0;
 }
@@ -175,12 +175,18 @@ static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
 
 		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
 		    !refs_read_ref(get_main_ref_store(the_repository), *refs, &oid)) {
-			show_one(show_one_opts, *refs, &oid);
-		}
-		else if (!show_one_opts->quiet)
+			struct reference ref = {
+				.name = *refs,
+				.oid = &oid,
+			};
+
+			show_one(show_one_opts, &ref);
+		} else if (!show_one_opts->quiet) {
 			die("'%s' - not a valid ref", *refs);
-		else
+		} else {
 			return 1;
+		}
+
 		refs++;
 	}
 

-- 
2.51.0.764.g787ff6f08a.dirty

