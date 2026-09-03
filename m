Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1769371D1F
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426321; cv=none; b=S/Wo6jqvXiaA4uw1mcsbiQyPjTuAGkAFb3AzQkKajnQreZXYxfASSLGMnre15HA9A0JtZVreZT5YXL6xSgmSwgjkHAcmSBpkqtGLrWA/Hnle2b40uQp+D5UHzjUKGArSsOiP5jTLyJjNOv8VTsQLljjW7U8vvEmjoK4nTzIztK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426321; c=relaxed/simple;
	bh=0/UwbCoyXaCPL6icAFo/OdcRfDpyk+XGLwtvMM1R244=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlRfUTFjQPdtl+KMqjkhppM+qTy7tTOCSHIFeNsC8ZaeXMTgDy3J/m7IGTYMetCWpn9EEDH1klWSNEGWSlcEyBheNfGFhPnjdVQvsa3dswQhDAB68VKQxnAJwxYUkKA5GUX/4nC2JKAXGIPJtLD/OwC0RhTHpv60xv8HN47nyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZEWk2T4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLuVMO4F; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZEWk2T4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLuVMO4F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 099C71D00141;
	Thu,  3 Sep 2026 05:05:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 05:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788426318;
	 x=1788512718; bh=WLnOUK4ei0JYVIOwKMEt6uEln2JdI650DT8rJ3cPUNw=; b=
	ZEWk2T4cCiCayUZbXu1aXwGFUDEaIFlGLNEqijifeBIr/O6B/PWaDdJQOvyq370E
	NzuSziH/J1+gcR3tKJuHrdSr09EfeoglRnRKLZWW5z5lz9L1FPJ5HOrAUYJ4CAVb
	NOP734aAs2CzEhnMVClhx/FSDq2oq3AEIa4/qn8yabMvvN1jJJ3GJxMpjfkp6M2k
	pCFTHrHK1wxjbpIxOH2xPVrM/PDkyhcZ8LhgTHyV2Am2bbBjgm0ldSFMGEaKrXhV
	HBfwSWz4Dp2ufPGZWbbfOadm7RkrSxSX1zryhSzgloh86eZv1zPpeY2p/pfK7bOS
	7yxprXRaupe7y7rzwusihQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788426318; x=
	1788512718; bh=WLnOUK4ei0JYVIOwKMEt6uEln2JdI650DT8rJ3cPUNw=; b=n
	LuVMO4FyuvlZQXILyMmgVKbX9jIf3xyKaKM1NxN4Ou9MgUsjdiTrcGxUvwa0hrRq
	ZtSkaC75ydpIVTYJKa/xwB/tkbBRuICcAfU/80KoQ5Uap6cFyeUOytA3kEaJrU+W
	0AfIuQ/HJ1w5wVm1CkCzpMbXdwvz3/Kju4Ibhr8iZR+SSVcDK0iXBq8CJBNzfTOX
	sE5wOsTs91O7fCCs4eDFr1P6nTTwUrZdvX5DpHBBY1j9Rm1cGfw1OUTeRWoJtcIG
	0VJL/JzhCobvo4idNfcY/5tqV0KpOscmwyuPsX4gWI5HowpXY2orGcGwzORtf4rO
	pQJN5vwFUaMXpOD5b7rzg==
X-ME-Sender: <xms:TjiZapI4ZKzSvl0u65SOo2MRbzOOg-RZXA51i2dD5vC7bsrbjZoKbQ>
    <xme:TjiZas7F4RwP0o6Ruu0AwNAXVVNisrOPRQzjuBKblV91eNloPJ2x3GY7GRdNUaCwd
    WKLMwZSX1WGKN8UkiDzCBOX0KOF4GzQLVNbbFM1PSNNcHI171mvvg>
X-ME-Received: <xmr:TjiZakzIIYyRI7T4KgALCLtwFwfqv5r-FB6wBGEsPInw_o-JwKYmNw>
X-ME-Proxy-Cause: dmFkZTGG1rmFGyG4DoLVtVInsCxuK/22Z88b5nOvs1xGsZ6MmPTx9MVcHr+eAyQnf9GoSn
    mlns0ySW6dLcgtVAFw5uX0waC9Po9Y3Lg4EE1rM2+kkQkFAu8Km5gOvUS716nJyYsTgghT
    vTeoOLmXfTVoPbgex4wXlFc0HC1/Q22sz50SYpLnlOeCTUnrr6ZPCM/oCgkAtCBDlZGsC+
    z28P4M6JAeNVIq8HF5UGA+PFCg0RZb4zLQ+qzJDjOIC75broBYFLFC32S72nzlMLCUzeoY
    eag2ZBVniII8ebE3XaEIylwq7FpIJgB+08Ea/QB8auG0vhPlCqzTeCguAFk4UzXBVdKVaz
    XVtYEkrGXdbUqUUtg+PzyyEpgb/c/QRNkMMBcou/K0lZzuA9AVMGT0fMdG0MrE473Lxj49
    FmEouvu6jf1agf/kioGc+RB7EhVPqcZ3uVMcaft5yQD9YpHH3cprb/+J28Kvfri0E4mIqr
    UtNMIffCmpjAd3RtS5xOwhiJivkv723AR+f5Iw8Qc9QgWCUfr6QMtf7V46IrFsYav2KlL+
    RCO7HnjU5YEG799YBQPLZ+KFugdkbpjHfjOVXW60nIUqkMgb2xbQes0q+IuWy6b6kOq/c8
    MxCPBRxROj6psiUOJAgbz4/HLfHg4gKwSN7Pd2YgSA5nmkiLNdxz5D20iO6A
X-ME-Proxy: <xmx:TjiZaoYR-JwXXsMc15GDdcHSjI7IFxTjprb8CN5A_SX8a9Z_qagfPA>
    <xmx:TjiZauTjuH4ObMnarzrRXXmDc13DLFTtFTfvPXUi8_MEJmsPYZmznQ>
    <xmx:TjiZaqyg1kJyII9fzc1cVouPt_Avk-VNwghLWGbz05fxQfrApOrjgw>
    <xmx:TjiZag3_Nv6bNrsvRi_64igye0dfuzWl56C4k7-qK9nCRDUZGN3aDQ>
    <xmx:TjiZancdLh37gIK0tdnr8W2dWNSdvppTSLoZIA78vzKgls6c1vLXRzNC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 05:05:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c031db2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 09:05:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Sep 2026 11:04:57 +0200
Subject: [PATCH 1/2] rerere: extract logic to determine whether entries are
 stale
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-1-9929c45a9788@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
In-Reply-To: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

When garbage collecting rerere entries we need to figure out whether any
given entry is stale before pruning it. In a subsequent commit we're
about to introduce a second caller that wants to determine staleness,
but the logic is not currently reusable.

Extract the logic to compute staleness by introducing two new helper
functions `rerere_gc_cutoffs()` and `rerere_id_is_stale()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/rerere.c b/rerere.c
index 3d3bd0db16..d01af6b71b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1173,23 +1173,38 @@ static void unlink_rr_item(struct rerere_id *id)
 	strbuf_release(&buf);
 }
 
-static void prune_one(struct rerere_id *id,
-		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
+static void rerere_gc_cutoffs(struct repository *r,
+			      timestamp_t *cutoff_resolve,
+			      timestamp_t *cutoff_noresolve)
+{
+	timestamp_t now = time(NULL);
+
+	if (repo_config_get_expiry_in_days(r, "gc.rerereresolved",
+					   cutoff_resolve, now))
+		*cutoff_resolve = now - 60 * 86400;
+	if (repo_config_get_expiry_in_days(r, "gc.rerereunresolved",
+					   cutoff_noresolve, now))
+		*cutoff_noresolve = now - 15 * 86400;
+}
+
+static bool rerere_id_is_stale(struct rerere_id *id,
+			       timestamp_t cutoff_resolve,
+			       timestamp_t cutoff_noresolve)
 {
 	timestamp_t then;
 	timestamp_t cutoff;
 
 	then = rerere_last_used_at(id);
-	if (then)
+	if (then) {
 		cutoff = cutoff_resolve;
-	else {
+	} else {
 		then = rerere_created_at(id);
 		if (!then)
-			return;
+			return false;
 		cutoff = cutoff_noresolve;
 	}
-	if (then < cutoff)
-		unlink_rr_item(id);
+
+	return then < cutoff;
 }
 
 /* Does the basename in "path" look plausibly like an rr-cache entry? */
@@ -1206,18 +1221,14 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	DIR *dir;
 	struct dirent *e;
 	int i;
-	timestamp_t now = time(NULL);
-	timestamp_t cutoff_noresolve = now - 15 * 86400;
-	timestamp_t cutoff_resolve = now - 60 * 86400;
+	timestamp_t cutoff_noresolve;
+	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (setup_rerere(r, rr, 0) < 0)
 		return;
 
-	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
-				       &cutoff_resolve, now);
-	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
-				       &cutoff_noresolve, now);
+	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
 	repo_config(the_repository, git_default_config, NULL);
 	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
 	if (!dir)
@@ -1237,7 +1248,8 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 		for (id.variant = 0, id.collection = rr_dir;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
-			prune_one(&id, cutoff_resolve, cutoff_noresolve);
+			if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
+				unlink_rr_item(&id);
 			if (id.collection->status[id.variant])
 				now_empty = 0;
 		}

-- 
2.55.0.979.g7e5102b832.dirty

