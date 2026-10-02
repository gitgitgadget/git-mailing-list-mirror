Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63247532A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935722; cv=none; b=sHhLABsSe8YZ5qi+bPChBeKWqkSp3Kww1YxOcj1iFsteUmpzdpgIrP9BF35HXxtfOsxcEMQn8geDzZq++w1xPxDgBENj9Jzbw5295wwYXmg/n+Ex4NG3Kq2keQhV3d4Re8a7p1N5SoSopdUBY8NY8L7akgDMkB8PkMFfNN3sPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935722; c=relaxed/simple;
	bh=HUcypQU0lcOgLxvy2JH7WeqRwKPcyhg9cqlT4apFHiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2lTNvAWrX3TYrRwt+Beyk/p1A8Qo/aq6oJRLpusH304CVV+4czl/LYRQwoqwSB2a5lSSlADohExt6oE42IM62Cn8h2523EBvR34drbuKeEYgrSexVLtEz+5PMVL4IlelaLLT4AnGYdBNhI0oVoCc/G5/N2tFcnK/CUPftv0km0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tOlq7Hju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZP1btKsW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tOlq7Hju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP1btKsW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 970C11400100
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935719;
	 x=1791022119; bh=rHipP7CeZMZdL1TI93UT9snCu0sCT/qrw51F/sGeut8=; b=
	tOlq7HjuN9tOMFiCekrpwMw5S5IMSDWWUJuh1h8EIpBNv3nKlPFzDsbPcCbr1A6U
	xIaQ8IBBgdHeUqmxzE1nVhv/4Schi2tJXYvyZNDNKQf3mrEXIZWBSQeYGRppsTMJ
	/OOJlkZrDBsuad2foz50bMtTjk6Mcb5lTyswA9PdPNkm1s2sTRAtb9TLk5lLumhZ
	Cnw/Y+LJ/vMxhE3XkRiRngX5ESBKJPogRloj0nmttvFmLNBVZGGVY2VaTfFBSebA
	UoNEzBE0znzvzSWGkPe9RBD+51v4isIIBl8BhzUUVMgD7k6CLgboHPXLDwerA0R4
	tUp7ZHC3sgfwvCGLIEheEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935719; x=
	1791022119; bh=rHipP7CeZMZdL1TI93UT9snCu0sCT/qrw51F/sGeut8=; b=Z
	P1btKsWJ3VCtb67qKX/NDlzkV873E03iAOSqGtG23zo5jx0AWysFCv65V0GFtPEI
	k4WvD54zmob7hmC5BevhfYt2sxenOD7whzzBjjcksw4K6BlgD7gSclFb9xUd8kG9
	UXUnoZkQTgVBIZRxkRBEYiToEBTyxPjKHE6avVFzE8U2++3+OrEUGIBP+23kW3fi
	vMJhVUm6NvvpRw1CQujhmDE+Y5BPEJeVTIwFPYRZ9lUfqUeDZKhXox1ssCxXmoBF
	iQ8EpPdD9IFranq5X94l3biTq7UzJPL8HeBFNYKJle8Ytsq0zQ9SIGila825VK/X
	Dfam7Sx29bCZdBKQBe2XA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935719; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:rxZYT5l+W/pxB5jwvokhlpKhyQmaCNDVOEGoCDFqT34vEKN
	S8FAOES3cbKqEEbRPGRiqFhlxxVq4tLJ4FnQYvbXgioXP9SNojxtKfB/zjojRflp
	w08eSl3B+NzGbl4PUapoSeH4a4yZMmqlQWchtbBe6ypOw1Y66u9uVNZIdRHe9Pu9
	03dGrfS8r6V1LdCO802SJ8Q8NyfySAdoaoMnKl0EsrX+HOhcGhA92Vx+mclz57G/
	xIr7VLnclg2WAP02P9tEPEvnjy70gUHbLiDruxj4eEwrGOAHZF5dUIC2Jhf75PRK
	739aj5VHrGBHhEg84fUmAHo87v7tzD9PaWnu8ZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nF74MQaqNxjnWyXqYeCn8GKczTaf2hmPBqGfGfsZIwQ=:HUcypQU0lcOgLxvy2JH7WeqRwKPcyhg9cqlT4apFHiY=;
X-ME-Sender: <xms:p4K_ajvlWmRnwB8Zd3Oiq2A4P7SfmnZXBmpBbwSC4-T1LHmtezPj4Q>
    <xme:p4K_arawqocIkMlIzTZTz6NQ0PZLSxBBtZrDbMBe6vat0GuCe_v_df5dfa8t7uHfN
    uXymGj7dd1Jc1oi6mf85GUouYFtXjZDqZEBdfxgEnkhs_boZs2Geg>
X-ME-Received: <xmr:p4K_asYsW1amOiKxT8T4dS4TraHkRT5xpzNXeyzrp98PrX_trBUclw>
X-ME-Proxy-Cause: dmFkZTEk3H+AUKr9O0Ow7GRbgblx4uf2zj4ETyQH6x90LBsT5LiyNUArdbRpTlRPy1OCyO
    1Pd/ECTkc4HK76y6uQMTAO82LMLlywQQqW3fRgX2bjzSdrlWY6Y7SJZjHYxoz3kdkLeJ25
    SpHYKmcs+cLgNX1OvKIPv1aFILPoREvhoS9oIsaWYupItEtfbxfUc1AYfMtJc1t9qGAUib
    Y7xWtP4gOvuK1IAG8w0nKknXHRppHJaeplUN/oAs+ZbWEYKKCh4BuI80dNCs1ZvfqM0npL
    HkcUWjFH/J8iZ+SQFybm7nSvyDiTAhXb+FcgLnFAq0ZphQwnn0MH6VUejq1KH15YIkWciq
    rNoFzvItQtjNcEwYV0xfGhkKg3bXZF16Yy6hhRk47RMWPsmJRq4aL2eRvHMp0UWUJ0Im8U
    p7GifzDoxikd8XBorjlUMkxpqDvlvn8bEvYPr5yXiXY0INyD/2cy9KPnCZo/S7DHHciHpF
    ikd4IOruXG1rcFvisui2gE5zZibvpY0ulVoN1y1s2tY2JB5ZraRIqtzn52BPUcohGupopZ
    gIPAppiAE5O+KWGcAGgarDLYFJBxZUSOFHIW+Ag54oZmbGNEN0ZrA0JMNmxB/Jc3MJljGO
    7pIgwaIudWQtWD9jXlHIp8dVeicT/C8nMkfYByQijbxOUmY/l0W2l3Hbn9+Q
X-ME-Proxy: <xmx:p4K_anV1CRK0S5d2YF7NvRuaOsAOhw91kcnvXLbiqMu1jcFAjh5zrA>
    <xmx:p4K_aj0Wj4zzVFY9-Mo5zQo_ycsuSMiCvQP7l6OFfQMa3RYlqJeTdw>
    <xmx:p4K_auYyzo5O_5w1aDJtV9hk7p3yMjHjsUkJCwtrKZQT_azfa5Tarw>
    <xmx:p4K_ampZjX6FNybHbEWihxxeBkfsN58RUabLlewJriIB31PUv_jOCw>
    <xmx:p4K_aicMSiKMdJXz6Jif29pwbt4i0xtg9xWN_jLEWhvOJRjw2qDRcjPO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0cb0e01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:15 +0200
Subject: [PATCH 04/13] odb: refactor `odb_for_each_alternate()` to yield
 dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-4-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.56.0.379.gc618271300.dirty

