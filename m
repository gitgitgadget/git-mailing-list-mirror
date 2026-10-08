Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0683D3CF4
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448572; cv=none; b=QlbEeNFL7uxBtsCPus9U7CfuNq8PIsJ7LhIxmlRCqipSOzGMk8kY/sZ2FcMjQw3XWA2g9aPjAP4tnw47d8OMnkpU9hPxKuzuDqdchPBQs1g+S9wDLAbkZ9bEQw7ytVgrX+p01CIu17LVl15V7PilGllRAy/iT4iZ6nApRxgvq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448572; c=relaxed/simple;
	bh=+CXg47iByJiHdmCj3CqUSCPwLj2vRrnMpG4XvbBlBLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QA9lwEjHjQ89AWBTWBmSDAM2Li4VENINKYpbhWmGG2W49aZ9jtTOUhgkdd0E6w1cpYeGhMcyG+dtRBZ606vjwz29oFh+RiiReN83yKVOcq0vp47sUmMSFeikrAxQ3aaDREdSup6L6NXqqCaVaD9rfYGoV27r8zdtIUgiG9qUlIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KCMfrAlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZVx0il0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KCMfrAlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZVx0il0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 44B04EC0053
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 04:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448570;
	 x=1791534970; bh=nfXNYTq5ObeA7O3OGnxu+Ya7t0FjqcBkeEjc9ct7qVg=; b=
	KCMfrAlQBBqhbTGGsXp399Tglm6zxquCBp9ifzGlbfA5qzefGfshpY2Um3WTccaS
	lxxc0KysSYnG9J/Ek1E2qx38RPmsiPyVbBCSxVDrVK2035HLvlkyeX3xRCSFWTGT
	Sr2hntgSMkoAInTdzqrHkUan1jioRNiuM9F3J+lz2LffHBGUgFBhlUtgdxGoud0/
	0audfKGY5B44coMmveD8XofvarmfmLqBYMyaAML85bO1slKKSVyvhJEmbkoS4OMj
	h3eiJdcjhUrlyIFBiw/xY+fyToMiLzFnzmwk1dnrq4/qwgmHQOFmxtsmRY3xNiiO
	7+0mUGkImibnD3YkQwVtwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448570; x=
	1791534970; bh=nfXNYTq5ObeA7O3OGnxu+Ya7t0FjqcBkeEjc9ct7qVg=; b=Z
	ZVx0il05F5PWhQP2AE+YtgAbxTcCN+j0SbCBmPnlm19D/9Cpkn+f+rR5d1ksTn7X
	P+7yAIRZ6MjP9r8E7jYJZYiH8M/Xsi1wD3024vK4AetvkWo5b7lPeXkKhP7apD6R
	WctqWx9DlTOhyWCd25QTVt4tXRjShCwST3ZKs/TEizrbML5UKTRPo6JdzfHGpDF4
	6HVYIfymb8lxvByL4JKpNTJvHq8JAqKhYTaNfZEtEala534IJcUTCEuKoC3E3Loh
	LyZMCXNaSZfO1FqI1KyDS9v50yrAO5cY1ym3se28HZ54dHa+1iaF+ad1V3aConJJ
	wqMI4g7DJuJU4L3F63x9g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448570; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kYhGlZAWomNgZgNyZaKMfZDP2W6byqvoo0kvvMKl4HeI/nv
	KntO4/qA3lZY7zI1wl05+zdrQ/bj7wv39zt0SQiNdYRDBCIGqr2GfPey+N5QMY2M
	GetfCr48FTzAENHGEkL8ZszF71tYOpic326VUu5K89dyaeAX/hvZkqexva/vug7x
	/7SeBeBxEDCKHQTqegfWDtbXS5KSvSs/fXRUNXxBjNVuo8chvwtw9UJxMUybUKFp
	AWDGP1AAcc/f0K3VOibBb1xId9owVZGnTszMpffsX7DZ9pVHHyMyQvX8zcV7293C
	W0cpr8iiHnAVad4dUPrM9gYXNOjRlYZhMnEAczw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9XNanQ4DxAu+6zgL0BqByxpD/qH8x60U/LQxSCzOqIA=:+CXg47iByJiHdmCj3CqUSCPwLj2vRrnMpG4XvbBlBLM=;
X-ME-Sender: <xms:-lXHarggr8WdgJ4FKafNsi17O8-vQvewybKme5j1ugnGG8y0C86qtw>
    <xme:-lXHauDdKRWkyqyQIekjqXs1UOh9yoP7EhD2S_qY2MAFzWxOumLASAlpAufRdY9r5
    xC9LFPZUZ7D_3yQVNdzYRIcJDvpscWtI0X2xk2fOUNyNFi-uugaJco>
X-ME-Received: <xmr:-lXHaouu855wyvJJS6P1OlKGJJioJ6agde5le7fw09p3HjqTNHvdww>
X-ME-Proxy-Cause: dmFkZTFM+ESHzMLvk3zeUx2ODARupHW3sMHrPsl3CnMe1Ktq4y6bx23zY/qC2//OvxrQfd
    B8uXrDVryRhIcOlllhKQ9PnlkspWrr6Wbg86cdj68t6U/NqGy0E7VVj1TpAcUnZwO2TW9N
    HtapTDjp3jhzIVJw2+aCuW/ZF1UarUug8fSczp+/ndKUnJB8M6QhEUPjAktUzdXHq/bP9n
    Q/fk4hn/LPKSUQCv0ygN5qSin6W1EuX0KEAk86qSs0GagPawyU7tHX1wMA+7rQOPlxlfVv
    UTqcdvcyhBop61sUOa2KJTGq50DVbj+En6zPSkpWIHSi6sbmYSrlMxGDkNx/VT4PEEhTls
    a0IIFlNHIK3dPYFZ683mlj1a6498PF+A2gVgh5Pgdq/OmEZNTSJ/vHD4dLIAmpzTBSngDP
    DX9iOWWXfWbZcPXlTWLdacWwNjZqHnF/yzsh1vbFhcyseFbwm2NhHtCuWQc7bZySHquYCz
    hwGTYGpMReYUWFl9vDl8eRsLs4db2+dRLswQ0DwuPUSeh4PTNdzvuWbeyLJTk4r7q7XdpZ
    4csm/xG6pmha7gJFpcRJoTbM7NCitJcn+wci0thv9YsZ8b1ObOwcllw/cP0nvcJD1ihzI5
    Yo0sQq06B/EQ0u/oWsIiYtAlJxFqkdUPnQmTdhduGhNQmHW2yST/sp2LwkQw
X-ME-Proxy: <xmx:-lXHajZ8kDYVGWHDJbWDxUTZhDTfbn2ldyrQUGUdp7F92z9LZBJJnw>
    <xmx:-lXHarXkq0p8X2dsCrGZY1aGPo6vG1iZxdhRSlrLgdUgykLGN3Yz5g>
    <xmx:-lXHan7qHqWusOE7es4MUKmzJLaDfN-z4_HGp3TtmAUpJBXuaKj6Zg>
    <xmx:-lXHami-k2CkGDDmux7QiNkOxHdcfue75-VZQIPNpyhJ0r2TzsEGxg>
    <xmx:-lXHajRnt8DL30GufkYnzsJHBp5-k9gEwj9JPG2iEnS8Er8i0ZF6kcfV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa2c957f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:51 +0200
Subject: [PATCH v2 01/13] commit-graph: require resolved packfile paths for
 `stdin_packs`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-1-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Users can ask git-commit-graph(1) to write a commit graph specifically
for a set of packfiles via the "--stdin-packs" option. Those users are
expected to pass in relative paths, and those eventually get resolved in
`fill_oids_from_packs()`. This ties the logic in "commit-graph.c" to the
specific object database source, as the subsystem now needs to assume
where a specific packfile is located relative to the source itself.

Refactor the logic to instead require the caller to pass in resolved
packfiles to untangle that dependency. This also makes the next change
easier to implement, where we'll get rid of passing the source to the
commit-graph subsystem.

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
2.56.0.406.ga2d225a756.dirty

