Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3F4156C5
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293826; cv=none; b=KLnt3U10PQvQL1awQjvJVbGuB+4EQq1H+HM7reHFZvGIeDSTR80A8lBdmo1TQlt/OnlMx3x30OtQGxTe2vrD3c+XTejTh7CEj85q6pEqzplma5gs3J0pE4EuhkRrUySs5FGDAFfS3nEoAozPpLkeE9rWnSyKzxOpgodmelxT9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293826; c=relaxed/simple;
	bh=YrHZU3ct2/rIzgWF+ZVLscVeC4lYl452PLzzpkrrW88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5GCkJ4G3UVQsmGR540JkKfREqMAEB4SvJEZxlIkbnVlnNBiHq0PgfPMx2KQ6rs9CGk+LWnNVfT1CsQs/q3UjYDoG6miBy3X77Ezt1bmUMcaJ5zEGO+XkboJ0hN7kcbYWi0wEQp1FWzjEZ1D3lziGVgYbehIbN7BMzmRJac9xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DY3xNtji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuRTvAVV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DY3xNtji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuRTvAVV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ACD4EC02A5;
	Fri, 21 Aug 2026 02:30:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 02:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787293824;
	 x=1787380224; bh=Ump8Tgbz+rNvoofkrqZuO1fVDOagx5nKjdDaeMx5uSg=; b=
	DY3xNtjiAcgpYJLPC+STZTIyV6qKAY4qyxXAHLl7DGvQbQl62uiQSWYRXzwmpMZP
	7XMe90P/zUsM9jVEPgupNfpn0JSut7pylVbkBinz7XWnF5J3Nywin5229e4Gf8ah
	zdtjU56oYJyunJGZCGC7iyiG9bQeiRbhZIxAsR1pnT5/xRR53QtL87/GbqTe+W28
	Xgb0OuizN3OuaiBYUoXn6t6kIKadwoyf13PNC9xPN30ZaJunBq5QAZboJ7vqtQ8h
	y0PviZiUIC0Uc04ahBnv/dwsKWJdazg7qYJwmWrpcoedzyBFMy0vpPIYT6PNb82k
	J03PFzd4V7FFgUlCSomyfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787293824; x=
	1787380224; bh=Ump8Tgbz+rNvoofkrqZuO1fVDOagx5nKjdDaeMx5uSg=; b=K
	uRTvAVVXA3GBCEQd0EBci0xFoK6hoDxd3fCOGZBLpbMhkxU4nD0FK+dyiWamVem4
	/8XzJz3nUrQJW+GyhmOZQCHREREbcSP0adgDwUKH1Cq/HOgcdrzIKyiYUZKc/EyR
	EsYIA/BO8w0QQ6sjIATbFQfVJIzUS2obBMPCnXI7YFJ1Tt7PgGvIpJ3y8Q1lb8Jk
	6mEqu6WwcULEdWWSuWyWzkmbQqP3Mhj8sYatTWNVwpFapDDOPx2GnLvCXgDRmobQ
	qYMU56qbpJnR3/AhBxz0GYRqFHlJMW/fJeGSBUqSMcdvvMxTGB6BGB4lEVBlahHZ
	BMEtBY3hwM+PNowPlww6w==
X-ME-Sender: <xms:gPCHagbaLe-8IBgr5dAyroDXcFmQucSUjXwmrKU7LbzapoQ_c3PYlQ>
    <xme:gPCHaiQfHFVA_xOtpruZELLaS8l0OOWXZ4hp1MS_vaN8bAIgwlt0sspjFp_7UxXH6
    I4t0vD3FdcoP8pPgoYexkQ9axGlcSa6DwwP9KudQc6phb0rOG9xAw>
X-ME-Received: <xmr:gPCHajQtNhGuyAWnLYr6aor7-B60gQvcX6qHRH6gdHoDUG6FyW0UUFlmmv5v90pxYO0RxQ1fTr11h3p8F_UhxOJI-96aUucje5bTyfJBtI3t>
X-ME-Proxy-Cause: dmFkZTE4livzZQEViiFuJlDvtHalR/9FSTk/Y5iWxY7udKBKIfnP3uN4Essy9oUEXw/ddw
    JijVdUG6GwV9ONoYIvSUP6ZXdwNbHLP1I5sDorH6MbJdga+4XefrN7F8JAR6WJ1kIDCwVW
    jUqxpCGQWN99uuNwjONbIV9Cgsv647mtk7LKtY61U7aqNOsrn2oCc5kVoXMrsiykDm+AKD
    wd1uWvXMHNycNPQjyv9EW/kjunufvBtvaINiX6v8Lnh91gcSwqsU84wBaG4q2220XUSxvJ
    3kVoCAYCOjix0Qq21t3CSWP5sxd8DsXxdFUbKX9hvR5VzbbAT8G9Gw6OV02lwetirSiwXv
    Qx1RmutLKkCYWVuT/+2uMiO+LljUK4esW3A1rBhzHc16kf71puFC51H01344ZaAX/rGv0t
    URE4vB8kHXo6KOe0d4Cd56a543IXSWdY4lUSOUWdE968lnmj00Zk49Ib47ed4Y5olZE9ez
    KnBNgVBjCV8VDWWnHj8qHHy/WJ6Ni7eMQykADIbC9eD/H3fdWOzRjTAhdK3tISRX0aTebI
    xHsM7K/iziOjwOQXoiwWspygw0TkQOZGhT2YIsSPMbGhV29aFHR4v7FfFg5DJD8O208OuA
    oGcKjzaM+Vz7qZjMDT07uHkG/WHNhPGTjiLZENXjhq04HpVNEgBfzUPxpR4A
X-ME-Proxy: <xmx:gPCHamQhP0qjaMg7BOSNdek4sJUEahuVzfNssTq5s9Hn5ld1ZYP34w>
    <xmx:gPCHao7MJgqUl-V5KVs8UDWVtRy5xGMkahKnLL0i_89G6SVApYtc9g>
    <xmx:gPCHai0GMenimbPXjHDwqYOZgFAXF5UGSosw__RVSd7n4MfHIIfktA>
    <xmx:gPCHajBXIWPA_pf2mpm7qtPqDFIfyeueHbi67_crclU6pR8b04AaUw>
    <xmx:gPCHapioK1dehWwDEPP-z_TQft-LTiVHKWCl3djolxj3tUxfGSW700FX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:30:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a61bee5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:30:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 08:30:06 +0200
Subject: [PATCH v4 6/6] bundle: generate packfiles via the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-pks-odb-generate-pack-v4-6-074e8bd641f8@pks.im>
References: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
In-Reply-To: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.15.2

git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
data that gets appended to the bundle header. While bundles are not
part of the wire protocol, they are a transfer mechanism for packs all
the same, so convert them to use the pack generation interface of the
object database as well.

This makes the pack generator the single spawn point for all pack
streams that leave the repository, leaving only local maintenance tasks
like git-repack(1) with direct knowledge of git-pack-objects(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 13 +++--------
 bundle.c         | 69 ++++++++++++++++++++++++++++----------------------------
 bundle.h         |  3 +--
 3 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index bfafadc984..5c6d8e1343 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -68,8 +68,8 @@ static int parse_options_cmd_bundle(int argc,
 }
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
-			     struct repository *repo UNUSED) {
-	struct strvec pack_opts = STRVEC_INIT;
+			     struct repository *repo UNUSED)
+{
 	int progress = isatty(STDERR_FILENO);
 	int version = -1;
 	struct option options[] = {
@@ -92,16 +92,9 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	if (progress)
-		strvec_push(&pack_opts, "--progress");
-	else
-		strvec_push(&pack_opts, "--quiet");
-	strvec_push(&pack_opts, "--all-progress-implied");
-
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
-	strvec_clear(&pack_opts);
+	ret = !!create_bundle(the_repository, bundle_file, argc, argv, version, progress);
 	free(bundle_file);
 	return ret;
 }
diff --git a/bundle.c b/bundle.c
index a9330bf0d3..f55a521b2a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -332,51 +332,52 @@ static int is_tag_in_date_range(struct repository *repo,
 
 
 /* Write the pack data to bundle_fd */
-static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
+static int write_pack_data(int bundle_fd, struct rev_info *revs, int progress)
 {
-	struct child_process pack_objects = CHILD_PROCESS_INIT;
+	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct odb_pack_generator *generator;
+	int ret = 0;
 	int i;
 
-	strvec_pushl(&pack_objects.args,
-		     "pack-objects",
-		     "--stdout", "--thin", "--delta-base-offset",
-		     NULL);
-	strvec_pushv(&pack_objects.args, pack_options->v);
+	opts.thin = 1;
+	opts.ofs_delta = 1;
+	if (progress)
+		opts.progress = ODB_GENERATE_PACK_PROGRESS_VERBOSE;
 	if (revs->filter.choice)
-		strvec_pushf(&pack_objects.args, "--filter=%s",
-			     list_objects_filter_spec(&revs->filter));
-	pack_objects.in = -1;
-	pack_objects.out = bundle_fd;
-	pack_objects.git_cmd = 1;
+		opts.filter_spec = list_objects_filter_spec(&revs->filter);
 
 	/*
-	 * start_command() will close our descriptor if it's >1. Duplicate it
-	 * to avoid surprising the caller.
+	 * The pack generator will consume our descriptor if it's >1.
+	 * Duplicate it to avoid surprising the caller.
 	 */
-	if (pack_objects.out > 1) {
-		pack_objects.out = dup(pack_objects.out);
-		if (pack_objects.out < 0) {
-			error_errno(_("unable to dup bundle descriptor"));
-			child_process_clear(&pack_objects);
-			return -1;
-		}
+	opts.pack_fd = bundle_fd;
+	if (opts.pack_fd > 1) {
+		opts.pack_fd = dup(bundle_fd);
+		if (opts.pack_fd < 0)
+			return error_errno(_("unable to dup bundle descriptor"));
 	}
 
-	if (start_command(&pack_objects))
-		return error(_("Could not spawn pack-objects"));
-
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
-			write_or_die(pack_objects.in, "^", 1);
-		write_or_die(pack_objects.in, oid_to_hex(&object->oid),
-			     revs->repo->hash_algo->hexsz);
-		write_or_die(pack_objects.in, "\n", 1);
+			oid_array_append(&opts.haves, &object->oid);
+		else
+			oid_array_append(&opts.wants, &object->oid);
 	}
-	close(pack_objects.in);
-	if (finish_command(&pack_objects))
-		return error(_("pack-objects died"));
-	return 0;
+
+	if (odb_generate_pack(revs->repo->objects, &generator, &opts)) {
+		ret = error(_("Could not spawn pack-objects"));
+		goto out;
+	}
+
+	if (odb_pack_generator_finish(generator)) {
+		ret = error(_("pack-objects died"));
+		goto out;
+	}
+
+out:
+	odb_generate_pack_options_release(&opts);
+	return ret;
 }
 
 /*
@@ -485,7 +486,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options, int version)
+		  int argc, const char **argv, int version, int progress)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
@@ -594,7 +595,7 @@ int create_bundle(struct repository *r, const char *path,
 	}
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs_copy, pack_options)) {
+	if (write_pack_data(bundle_fd, &revs_copy, progress)) {
 		ret = -1;
 		goto out;
 	}
diff --git a/bundle.h b/bundle.h
index d664b2f2d6..471da23d1b 100644
--- a/bundle.h
+++ b/bundle.h
@@ -27,8 +27,7 @@ int read_bundle_header(const char *path, struct bundle_header *header);
 int read_bundle_header_fd(int fd, struct bundle_header *header,
 			  const char *report_path);
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options,
-		  int version);
+		  int argc, const char **argv, int version, int progress);
 
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),

-- 
2.55.0.822.g20453c30eb.dirty

