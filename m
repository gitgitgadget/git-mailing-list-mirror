Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F73471279
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448580; cv=none; b=JnfEP2V+mj48KhxkOhXJzvkhHZnMTnZeVaPJ0Xl6RG+/tW7wmRPcbRj4d1IESJ/gTmCOSZqBs/o0N7saNtueg15Kw5CF6UyOMTCPOSHdXh8MWcgP+3yknCpYhMVv1hQenl8RZXvzXDzZat2vAyvYkDXE5a/HxyZn2bsqgCoPyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448580; c=relaxed/simple;
	bh=ZeT/Qkjjc283/mKyhMhjEjy/lY1bgzSdnjA048nTPdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mO42AF5K8xw+5sIEIZ6CbtgXtLbrJiBNrIr9Fyzt8mDwXRBnvgux0IMysNveCQJ6nML7NjHi4x8RCEc7ii9tpxnL1pvGxz7NKMLWiX2vtx3zItijgdGDRebo+sFprnI9LTN2qBt6+qlmuSpdDBJGMetLnwnMARCANiugSGd5jM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GDJwPD2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hay9eg6Q; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GDJwPD2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hay9eg6Q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DEDEB140015F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 04:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448577;
	 x=1791534977; bh=JIFHmXWOkZaIcB92/2gl5K/C5iaAP0zKyaBBDLHycuM=; b=
	GDJwPD2OGm/0PSU9yVM1x1V9xrSWqTLoRiu3ibuJXskAOVeGolHenJSPpcvjZ0lm
	YedKrlQvndYBDpQQPbF8pMweHAfesZEYthc57qP8mCteV5ZF1J/FxUs4NnUmKGXU
	24UvLu4V8370qIk5zNTKPlRk1pvcv+fcTFBuY8/NGrFVrEgGaQw0pF3MNn3X4/kg
	vQ1VJD2mRcZw1HUJMHZdtYujanX9zyBgNosZxMjTdwhVEngqwLA1XuPaAaV6s5RI
	gxXxzlMxQK3iz0lJA9U24xtJ/HNEtqqCWJiS54JhVH3NRiMLSC3QQ23Wk3jqWa+I
	V5LAkdPfWvu6eiWzW2eyCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448577; x=
	1791534977; bh=JIFHmXWOkZaIcB92/2gl5K/C5iaAP0zKyaBBDLHycuM=; b=h
	ay9eg6QWwCyYrdskDfn/62Xhh/9moGiDGrc+n3R5LknlZh4sRPoBoctibPXkEvxe
	xW9i4K3ekLhKo93Oo42o9A0hDRKiuNJuBKopFiCkeXvQ6PnPDKb5vau7tbzr6zTC
	oueiQQDx0HFMa+D0gBO5LN8M1ejhigcSZg3B8q/tr9ISC7wigcw3twKLRiG0vPIA
	fgwsfjx1BaQqXUsKtpKS/z/VtBpgDETHu4UVcH0484GZ+Gtcd51LM/lHd6xfvxT5
	7igP/8tUSCPAWbo3TxEo6WKIhzt+WMSa9kzdpkQFFjIOhFDLvhzgFN57lZJQUdS7
	duEvxBSu0W7ZLzeg8DJ8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448577; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IinQhMe/I0kO/7IddBmeEP/kmYG6U12AxYX34cnZkUHM77v
	uFWcuSFkzy+o2Ft2XFDDy8XY315sHUxj/3iE9sWLlG7FTlZEXXZOI9eOlkQtYoiQ
	KS6Z8TEEMPkpbLjbciby0Za8GoYIcRZ5jCp8cf7t5wMLV/6t86nJMfC+huMf41gg
	aDJS3Uwqie4hksKcfdIjDt1LU7JHeCfF3GiQrIvtKSa8XRZ/qfppjgiGQHwL9MPj
	GaZSIFlzEugWOIG0e7bRyKeyreH2aFy7NMFOztUYeNtbywUla4ZU1Xa1Qzvjr+qe
	AV1dgDkyzCxdPdVdimA2cJdZZtaD5+oSzJsTWVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:P2KNXQASasD+0SN1IPeL7PqhJ7ZzZVkF1ChZ5yg2Z5Y=:ZeT/Qkjjc283/mKyhMhjEjy/lY1bgzSdnjA048nTPdg=;
X-ME-Sender: <xms:AVbHapkFxJD5AN4qGp2JEj4EpXdT2hfqWxmbQ6mj4f7uQvoc1Rl83A>
    <xme:AVbHaq13HXDuRajGAuVjFr5I89Ao9Hl0SotynPj2d3vqhZZwTkP-W7pAzSQBJlPDM
    LbeanKVBfnoKbWNuD2bEiG4U0s3T4ptdNGRCEj3saUOlq9b9tg6kLo>
X-ME-Received: <xmr:AVbHatRY1sNOBjkgnI1Wl_wc69TcM0eXPowixuTuf58gLEgTszPFew>
X-ME-Proxy-Cause: dmFkZTF2XNziQh5IHy21uzusM1wSVwzayYUsYecByC6quIrVvlZfFXnS/Z0fUeAcJN1h8d
    1CYJVEdPX8ys9Zg4zMEKb1Kt7mK2lsBa/68pZei3KPgCu4zbytMUsxo/amE1tk2/Zjtgh9
    xXMgVJ1QaawSZwDySCpMqzOghfixCUy4m7a+1lRE2DB8rrLb2Jii9cN7X+bRLboIJ8n7IJ
    dksq9fCUHyxIWQmZ8WyNNPygCYx/lSfPenUiCICMFN9w/xkDhOlMaoehqdUzCs9XdLqBE+
    0tP7c2nj4QgT0+KdMqWEeGBsJckraDtsKiarrllvzd/U+lMoQsTM8iJw+A7HZVq93B2mko
    dyvnf59ieavO/36W6fcSEGcylymYVPJymwjHdt/WrWy/arTTlyKBRAt6g7agjIw8NAqNo/
    47l8wp3fiaQ2OI1LwiAy62bKHHaoICvmB0qwkMo66DG3lUn09FFMmlPdHPnlI3DIYqCNNZ
    nd2MVLiQKYHEHvBxzY4FJkPf3e/PrsCsd8IgKH+GA7DeCBEZKBmHOevpPH0aGHV8XYjJdr
    gryPMX2jtoLtWdmY8vqzCvwj+kWS8hNrPcJ/C0ol+00l+ucn1wcKPOS4UlNoO3cKtWciDs
    2sgC+SbRLvYcsSLZatU1WDzLBoRjJFAAtGLXK074WJLn8xeJjgk19R8/PcCg
X-ME-Proxy: <xmx:AVbHakuTXNmq-ZqigqeeAYh_OSVsu7htJSdgJnZExrOeJ0-g56fKww>
    <xmx:AVbHaqaWqnUR5FKsK7kRNbMJtmX1P5u-zrhCS5zJP_gBRGtUjjUP8A>
    <xmx:AVbHahs0m89BVFZx59NMu6QTS14cO75ZcMM07C6wYKwILTQTJ6QEzw>
    <xmx:AVbHakEkXiRMccrb63jenx7xS86ghUpo82Lk_x3w3w1SiCVs2W-0Ow>
    <xmx:AVbHaiXyT8Nt3pRPhJvs8OEVcgBBNiaLqGL-D6DumQT8xOvUPbEy4zAS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc1bb643 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:54 +0200
Subject: [PATCH v2 04/13] odb: refactor `odb_for_each_alternate()` to yield
 dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-4-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The function `odb_for_each_alternate()` iterates through all alternates
of an object database. This is becoming an implementation detail of the
"files" backend though, where each alternate will be represented by one
`struct odb_files_dir`.

Adapt `odb_for_each_alternate()` to already iterate through these
structs instead of iterating through sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c     |  4 ++--
 builtin/submodule--helper.c |  7 ++++---
 diagnose.c                  |  8 ++++----
 odb.c                       | 18 +++++++++++-------
 odb.h                       |  3 ++-
 5 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 18f6e33b6f..f2abfaccec 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -81,10 +81,10 @@ static int count_cruft(const char *basename UNUSED, const char *path,
 	return 0;
 }
 
-static int print_alternate(struct odb_source *alternate, void *data UNUSED)
+static int print_alternate(struct odb_files_dir *alternate, void *data UNUSED)
 {
 	printf("alternate: ");
-	quote_c_style(alternate->path, NULL, stdout, 0);
+	quote_c_style(alternate->abspath, NULL, stdout, 0);
 	putchar('\n');
 	return 0;
 }
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 40a052d674..64412adf9f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -30,6 +30,7 @@
 #include "object-name.h"
 #include "odb.h"
 #include "odb/source.h"
+#include "odb/source-files.h"
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
@@ -1770,7 +1771,7 @@ static const char alternate_error_advice[] = N_(
 );
 
 static int add_possible_reference_from_superproject(
-		struct odb_source *alt_odb, void *sas_cb)
+		struct odb_files_dir *alt_odb, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
 	size_t len;
@@ -1779,12 +1780,12 @@ static int add_possible_reference_from_superproject(
 	 * If the alternate object store is another repository, try the
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
-	if (strip_suffix(alt_odb->path, "/objects", &len)) {
+	if (strip_suffix(alt_odb->abspath, "/objects", &len)) {
 		struct repository alternate;
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
-		strbuf_add(&sb, alt_odb->path, len);
+		strbuf_add(&sb, alt_odb->abspath, len);
 
 		if (repo_init(&alternate, sb.buf, NULL) < 0)
 			die(_("could not get a repository handle for gitdir '%s'"),
diff --git a/diagnose.c b/diagnose.c
index 5092bf80d3..89240e47d6 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -59,13 +59,13 @@ static void dir_file_stats_objects(const char *full_path,
 			    (uintmax_t)st.st_size);
 }
 
-static int dir_file_stats(struct odb_source *source, void *data)
+static int dir_file_stats(struct odb_files_dir *source, void *data)
 {
 	struct strbuf *buf = data;
 
-	strbuf_addf(buf, "Contents of %s:\n", source->path);
+	strbuf_addf(buf, "Contents of %s:\n", source->abspath);
 
-	for_each_file_in_pack_dir(source->path, dir_file_stats_objects,
+	for_each_file_in_pack_dir(source->abspath, dir_file_stats_objects,
 				  data);
 
 	return 0;
@@ -228,7 +228,7 @@ int create_diagnostics_archive(struct repository *r,
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(r->objects->sources, &buf);
+	dir_file_stats(odb_source_files_downcast(r->objects->sources)->dirs, &buf);
 	odb_for_each_alternate(r->objects, dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
diff --git a/odb.c b/odb.c
index 0200e26f21..9b70859c23 100644
--- a/odb.c
+++ b/odb.c
@@ -14,6 +14,7 @@
 #include "object-name.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
+#include "odb/source-files.h"
 #include "path.h"
 #include "promisor-remote.h"
 #include "quote.h"
@@ -435,18 +436,19 @@ static void read_alternate_refs(struct repository *repo,
 }
 
 struct alternate_refs_data {
+	struct repository *repo;
 	odb_for_each_alternate_ref_fn *fn;
 	void *payload;
 };
 
-static int refs_from_alternate_cb(struct odb_source *alternate,
+static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
 	struct alternate_refs_data *cb = payload;
 
-	if (!strbuf_realpath(&path, alternate->path, 0))
+	if (!strbuf_realpath(&path, alternate->abspath, 0))
 		goto out;
 	if (!strbuf_strip_suffix(&path, "/objects"))
 		goto out;
@@ -458,7 +460,7 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
-	read_alternate_refs(alternate->odb->repo, path.buf, cb->fn, cb->payload);
+	read_alternate_refs(cb->repo, path.buf, cb->fn, cb->payload);
 
 out:
 	strbuf_release(&path);
@@ -468,9 +470,11 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
 void odb_for_each_alternate_ref(struct object_database *odb,
 				odb_for_each_alternate_ref_fn cb, void *payload)
 {
-	struct alternate_refs_data data;
-	data.fn = cb;
-	data.payload = payload;
+	struct alternate_refs_data data = {
+		.fn = cb,
+		.payload = payload,
+		.repo = odb->repo,
+	};
 	odb_for_each_alternate(odb, refs_from_alternate_cb, &data);
 }
 
@@ -481,7 +485,7 @@ int odb_for_each_alternate(struct object_database *odb,
 	int r = 0;
 
 	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
-		r = cb(alternate, payload);
+		r = cb(odb_source_files_downcast(alternate)->dirs, payload);
 		if (r)
 			break;
 	}
diff --git a/odb.h b/odb.h
index 797eecbb94..3715351bb3 100644
--- a/odb.h
+++ b/odb.h
@@ -12,6 +12,7 @@
 struct cached_object_entry;
 struct list_objects_filter_options;
 struct odb_source_inmemory;
+struct odb_files_dir;
 struct packed_git;
 struct repository;
 struct strbuf;
@@ -257,7 +258,7 @@ void odb_restore_primary_source(struct object_database *odb,
  * function returns a non-zero value, in which case the value is bubbled up
  * from the callback.
  */
-typedef int odb_for_each_alternate_fn(struct odb_source *, void *);
+typedef int odb_for_each_alternate_fn(struct odb_files_dir *, void *);
 int odb_for_each_alternate(struct object_database *odb,
 			   odb_for_each_alternate_fn cb, void *payload);
 

-- 
2.56.0.406.ga2d225a756.dirty

