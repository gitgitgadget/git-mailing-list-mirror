Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B32AEEB
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935714; cv=none; b=S3cfct9TDQIAE0LHmLVYzMexJqHQrN8ZGVB48RTbZ2F/HjoAEvATbIhKtXVClACifjHwMMbWx91w7cQreegtG9VsqQZJ5YLiJ/TpOuqHa4O3l05hgc3HXjYLuAP8afHtV119A/QoqgCbw7cmqg3dpQ4tqmraWtjDDR0OlOiz+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935714; c=relaxed/simple;
	bh=Sbvk5C0yGANkypIhjhw7yOSBX5ayvhQarKuX2fbO7OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3yaS2qppSsjLg4qvc4EkfBUmhUD5xVUMCIYH7nuyXCPEn9W994JDSX+5v4ER7xm6nhmvA/A+eH0012Vm77cqu3tn9ay743jqG65oGqsIXOjtZRWWVqoXSUSas/yjHWztwA9LzCcAJm3eRFAplq6RFTUQxDTXly78nVN+KAhdsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HxRYMUwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hkut5suc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HxRYMUwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hkut5suc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 91981EC00C4
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935711;
	 x=1791022111; bh=Jkka4aJU2W9wBB+hyBedu+OI9R1tO6gaGz0/G6xUo4g=; b=
	HxRYMUwOKruH/idAxLyFNT26enCk03TIIXgzpPQIGqdmJXwLBRsYwJOgp38z+BS9
	QS+pqQZE9fxSg9ezauLdxNc7tnGZJHzVF6wciLS75lTiAiNgXBF1DynOcwZz7XO2
	9SfoXtj4BLGSmmhulJEQCf0rQmpNTTN3joWXi45YrS9jDEfNqWR9GWy0KJMhA6Y3
	6i5r9fiycS75AwSvpn7e7BN8KUnTfSA4nor7T3Dl5zUJHA1C+5r6zFfLs028vA5J
	Fi3pitZJrGU3wlHwxr4kTu9fli1VIWWrwI8sfepV4xDvt0YMn84IhtBNZDrC0soy
	OIG5EOlQ5Klec3Qk1u+N7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935711; x=
	1791022111; bh=Jkka4aJU2W9wBB+hyBedu+OI9R1tO6gaGz0/G6xUo4g=; b=H
	kut5sucVD+giUNz752Y/diSYmam0z4mqfadvJe0FQTpad2xuvnHppjFiNlP+8jI6
	E+muth2VV/+ya9AwZP+FgaIyFbB9LBCjqCKIKKG+21rYPtX+SwE2ymfwBZuJuUuc
	fZpI+mDQqnbu4uN7K+0lUVgf/YUJ0Jf83ZbkKRjLD+bar/0/EBu1ZerZ2wwBAqV8
	b7SiT9/zHQnwwLA1kkCX3omqAsIbmM8ePyHHba5knEPb4UESyMthos6QoMBiQzb3
	ZbgQGMRZgk3u2ujR7tM2Q+dJLZZ1X2pAhFJ0sWWTAmChBEA+Kr614kvZzdJRyooB
	3booJIXFkUWq9NE/BLPzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935711; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jmw38UTmHJsNkBR8sl1w1TbOH8a3deVYjcf8fCOqmtONYcv
	BTO44buXdRa5AweC/xAQs0rMF3pI+zR7y8haKHIU8L3cqv+jqp71U9ut9pCUvFmk
	kMf6BmqBgc9SwHdKvugqsbLNmo6C2C79Q449lwc/NKJbS+YaZgjlM9pjvPA8kymy
	OaUiLusQnIllB6lGQ2Yrtc5738SPTBXnVUlxvwZkgymW/0i4Y65S+69UERfSWgyH
	5nY0curZoGyL/YFrEO1ileSPE53DYf2TX+RQwrvDqxt1yEzJlUknu/lREiwuUR0G
	eI/ASfyU2jwry+Ox1GX/KAeQCDxDO1i54z8fxzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bqiD6mKYqTuDVD+9tIC4eb5t20YjGPXQ+dkw88pz9uw=:Sbvk5C0yGANkypIhjhw7yOSBX5ayvhQarKuX2fbO7OQ=;
X-ME-Sender: <xms:n4K_aidJwdgegeI6-UVgbuWHJtGng-lLwIfr_FT9kpAPoEl-18svTA>
    <xme:n4K_ajJEmdr40dHKSUz-F5uUYRE34OUp1yY26iFmORPASeX8wSIvUaJmQKEbEtcWp
    6wLDJCu3jPcVYjAox5utcHOlbS_pyvqqrs1M_Jo7B2AibB34Chk-g>
X-ME-Received: <xmr:n4K_apJgwXyR4iYczznUBw5X7Qa1j1t7DLzkg-I6mjVwqJAS1QCnzw>
X-ME-Proxy-Cause: dmFkZTF34l82022tRH/XgLve1GnCAagsK1/sNQ03J1wZMCaKRfCFCANyInDwpxNlKo26XL
    EXnDaIhvf6eeyj8SFpLxHe7kMLyAMTddf/VH/Rk//b+JdUzKpEnqhJ/mj6T6WBc3r6ZJE/
    Hr1v675783mYwdLtIr+rwnhjt9V2Sg0kW0Y2Oh+akYz5iWsSjkq3O4mWIO7qqzL2LqWlBu
    4qb3Nz76srjHiKLX7WGKMZWL03bhjvTx5w07iAecZ2+wGDzrZnOrFMya6obWUIWKlk9RXi
    ATp2I5KNGIOri6x7B1ZipZsHWqVLLL4aev/pKUNaysgOv1nDj7mFcdqRSD+T2EP7frLRSZ
    94rHqHr4BuxwlHxaCckRerMjUeD2+ySjrp4/4+p/QSdvnkWbphprbfArSrvkL1e6j6ux09
    Fmk9/Aho7+fQ9LK+/nzfOZVKrg2EAv4IULu3eaCIXbP1EXp8EGrT6mZak93gj8JRkAsPM/
    UilxE0scKTbivgo5exWh5UxeXTBGfr19I+8Q23PVf08gpGvPfeq/AKydOvyGbxbtvyo1fl
    hxyHXHOJZyUH4CkS5v4JpUvm/vgiBwZWI2pBUUa232QHehpu8XbJ8Bf9pSaidkx8UH4Ybc
    V/+r69k/CYfZZdZ+VK00DNthbmDCE411e9xybkDw5/TV191YlNUl3lfUFUIw
X-ME-Proxy: <xmx:n4K_alHLJubz_TPjTJXcsbzJTLsWzKsvfDehse4PmpMJO90w3VQgpw>
    <xmx:n4K_aulMACc1PCShGAh76YSIFL8wtne0nQaxKJWp_TGyFPiikKcu_g>
    <xmx:n4K_aiICsZYB77NfiJdaezHXMPgu0p71bKAjSRN5NVamrptjR5bXgg>
    <xmx:n4K_avZ9n7OLyg0QEHv4CUHfnrVC7dJRlNiY9Qmnio7ScicwS0fjNw>
    <xmx:n4K_agORGKCDhVFUukSCILSumIfkhOIvHIR1FiIYuvdOM8Q7V9xr_H-W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6e1f657 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:12 +0200
Subject: [PATCH 01/13] commit-graph: require resolved packfile paths for
 `stdin_packs`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-1-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Users can ask git-commit-graph(1) to write a commit graph specifically
for a set of packfiles via the "--stdin-packs" option. Those users are
expected to pass in relative paths, and those eventually get resolved in
`fill_oids_from_packs()`. This ties the logic in "commit-graph.c" to the
specific object database source.

Refactor the logic to instead require the caller to pass in resolved
packfiles to untangle that dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 17 ++++++++++++++---
 commit-graph.c         | 15 +++++----------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d62005edc0..b5784ad3c7 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "commit-graph.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "progress.h"
 #include "replace-object.h"
 #include "strbuf.h"
@@ -302,9 +303,19 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts.stdin_packs) {
-		while (strbuf_getline(&buf, stdin) != EOF)
-			string_list_append_nodup(&pack_indexes,
-						 strbuf_detach(&buf, NULL));
+		struct strbuf packname = STRBUF_INIT;
+		size_t dirlen;
+
+		strbuf_addf(&packname, "%s/pack/", source->path);
+		dirlen = packname.len;
+
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			strbuf_setlen(&packname, dirlen);
+			strbuf_addbuf(&packname, &buf);
+			string_list_append(&pack_indexes, packname.buf);
+		}
+
+		strbuf_release(&packname);
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
 		if (opts.progress)
diff --git a/commit-graph.c b/commit-graph.c
index 983c11ce85..73814c1622 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1936,12 +1936,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 {
 	uint32_t i;
 	struct strbuf progress_title = STRBUF_INIT;
-	struct strbuf packname = STRBUF_INIT;
-	int dirlen;
 	int ret = 0;
 
-	strbuf_addf(&packname, "%s/pack/", ctx->odb_source->path);
-	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
 			    Q_("Finding commits for commit graph in %"PRIuMAX" pack",
@@ -1954,15 +1950,15 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	}
 	for (i = 0; i < pack_indexes->nr; i++) {
 		struct packed_git *p;
-		strbuf_setlen(&packname, dirlen);
-		strbuf_addstr(&packname, pack_indexes->items[i].string);
-		p = add_packed_git(ctx->r, packname.buf, packname.len, 1);
+
+		p = add_packed_git(ctx->r, pack_indexes->items[i].string,
+				   strlen(pack_indexes->items[i].string), 1);
 		if (!p) {
-			ret = error(_("error adding pack %s"), packname.buf);
+			ret = error(_("error adding pack %s"), pack_indexes->items[i].string);
 			goto cleanup;
 		}
 		if (open_pack_index(p)) {
-			ret = error(_("error opening index for %s"), packname.buf);
+			ret = error(_("error opening index for %s"), pack_indexes->items[i].string);
 			close_pack(p);
 			free(p);
 			goto cleanup;
@@ -1976,7 +1972,6 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 cleanup:
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
-	strbuf_release(&packname);
 
 	return ret;
 }

-- 
2.56.0.379.gc618271300.dirty

