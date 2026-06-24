Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8D2853EE
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297439; cv=none; b=l3+JRQkQQ8oi4z3L6FFifZXiRnj14rHRK1Nh+zVzu63mEzw+z24bVNsuvzeDK0tMmhdUvyh5+iT1NMiIbK4v1uNCGb+slD5rVSFKtiBIsCN8s/UVNcYtK96Sx5wqZ0t6EFLXdTCn0I9/mBCqqFiTP8PqE6kqqhrNQHqRwdfF2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297439; c=relaxed/simple;
	bh=hzNHZg1bDu5aGO35XUeg9X35WCEklFPLzX4k7t+ftEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEZRf4MaoUP+I5fQ6CgDO/1fHDoaxLz7hlAVpa29BRXAQjXaaFw2BXS2GnxKKF4tIPdsYC4/so/CDQkUfBObgG9zc7ocZmEOk8MEfdmiXQgGTO83VQpJxPr6xF0KDv2aeIHoUloVe5i7jAUl+5yd6nvqDumZUnj66gG+qlEjD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rmvirw8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hqo23O9c; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rmvirw8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hqo23O9c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5E267A01FC;
	Wed, 24 Jun 2026 06:37:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 06:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782297437;
	 x=1782383837; bh=euRYBlkRVLLBGwTOGdFo6186jVZ8MOrtDDVXwOGYPLE=; b=
	rmvirw8MGawd8KGSYqujYyYmillY3UPzts8jn5dqjz0BHMm0XdWlYNiWRQ5D1GCm
	Oghs4RZAP4DLBm2jZbyCYNf8AAzwuxSef9LVY9lny5TLalWPM89JL1VY1cn4LB8R
	ZUNyQ6EidRfQFjyKHbaAelbegW2WM4miaI76azJ2MZunYIEb4+BxXYP2HwkU6FZp
	2g9K/IMDw+H1Mbf2sb81syfTKOiF37tQTznsJ2StTzKxj4skiztS1T6NPGA4AU88
	06OPsba6TbYmwvfOJw7gl6mLZhmRXnt/xImrdye09oK0fdZbpUt/ZYHoM6j7f8Az
	BgAaD+5qmhHzoGlqlpcZ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782297437; x=
	1782383837; bh=euRYBlkRVLLBGwTOGdFo6186jVZ8MOrtDDVXwOGYPLE=; b=h
	qo23O9cVFsd+3PVaYyJsYwPhe4R1bkUkH7pBhvn75t1TlQRrhf+/DOyxJsz20dt0
	m6MmtdvUjEJBQgMewRwOr3ORh1gjnsYdPY8Kipe9n016pWMJLffbmYkdDPLFNUTO
	vwlTbJd3guHpHR5jQw4/aZCaT4T19yHBJ/epEA08xxdU5RTb4VY6Cwa04GsrA6E/
	NJeOmLF/fyZGB4VKfVOZFBoTO2zoF3Ng8bcgXJ29OwJlpfMGUktWBKL8gGg7Hl2S
	yoz0ZXdjatJ8BxuOcir1Ykbp/JqI+qeN+OAeoIzHgl2+cfi/DEKOrpjdzioPnDJ+
	I4gjO882kpfXET7jUrW7g==
X-ME-Sender: <xms:XbM7aqggl1EEcNPfCDnwh2VFkzk8uUIBSJtJon9tKYoCf0V3VjG2Iw>
    <xme:XbM7aifPYQHHGPAvhC0aDv2x8DpYCz5vLYMzO6LhgnqqKD7JBacngnppJSR5RIxil
    qJO-9AJzIu7DCUhdSVpYnxnicn7pA-2qjX9xax0bZgl47UgZEIgvw>
X-ME-Received: <xmr:XbM7avdFNHVtANpAAMHSoheUY-SVAx5icYrhHoHA6tifG8z07GXFje4Z1yhWZN2EZL3zn_rqGXI5wiEBejVP3oAMJov7MXaBz1EiBu7b>
X-ME-Proxy-Cause: dmFkZTGczPop/HeCrTmNZOxHU4iWKi7RCuRxWpVI/34nV130rjuTIZDC9yKQAIWyfwUdXf
    UmzIuSRP9DsYdRNGaaemJ2e/qiDUqqMCzJfh79SfjAF3SDjQWRWZUii71Qih5W3S6ceyLS
    F+LibdTv5ABFGtUuS5yE54AKEEk5bemzmT7SpurHC5nr6qD9aeQfEMCMA+rDqHpdhciySD
    Lhd5IPMdCG2NLoLLxQiCBIaZmIdLhUY/0nc1VW1BJt+G2O+8CTV3YlK49LNPwF4FLbUKlS
    9rWn4TTmlZn9WJwwBHuxKtqJIv56eTkdfq2ZCG4cHQCYJ/FBIHjAX+EInYBguCJVNho1Va
    nJN8eA7siytGMimYVXxkniLDnKq6Y+MARD73NbboDbcCWvcvS1jhe1XRW0bHyM0Wy/HEmk
    312j6jstaWzLl/v179sorLW0IXnCMyvdwcf4p9g//mpnqG8ubjEj8JGs6VbRCH4arRkH2k
    6bfsm/tc1xJDNoI1ANEnC+gPnQA/rKnXE4UyGCfgIcJlUUm5A0v1iZGfoOkUeBukIxDgK9
    Hn2q9iNq+6ptolT+JtdRcfIKAc1Ezwx0Y5v8sMNE8mKyGfXCwnLBaBhZwYQUhQO9z8xm2d
    9/MEkDePKmpXo8wS3/MTwFXyCrw3nZfgdiMu974IOwhlHzbnI3T7Ihtv0Lxg
X-ME-Proxy: <xmx:XbM7as83nHhrXQCP1p-uojdYrizMpDT0naYvl0sxvgPXM27y0QZl1w>
    <xmx:XbM7ark43RNwrkTAI_Dz27UQOmGOzBztwCcDgPTxB9x9m38cTVUt0w>
    <xmx:XbM7au_dRPn5CUpPhF8Wt4MUvW0Z0ea5HFhFkIK1J1QCZQE6jAy43A>
    <xmx:XbM7aplC3klVVJOCaxOC_VMz0dVCOcTvqYA5bBd6rnBoUpMTg18ZZw>
    <xmx:XbM7atFDtfKbIZ3wwluBsyVuk_a0j8CeNVX1w1W3KFKaR0WaOq6ZeWOY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 06:37:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ead384e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 10:37:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 12:37:05 +0200
Subject: [PATCH v2 3/4] connected: split out promisor-based connectivity
 check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-connected-generic-promisor-checks-v2-3-132d73ee47b9@pks.im>
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
In-Reply-To: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When performing a connectivity check in a partial clone we try to avoid
doing the connectivity check by checking whether all new tips are part
of a promisor pack. This makes use of the fact that we don't expect full
connectivity for promised objects anyway, so it's basically fine if
those objects are not fully connected.

The logic that handles this promisor-based check is somewhat hard to
read though as it uses nested loops and gotos. Pull it out into a
standalone function, which makes it a bit easier to reason about.

We'll also further simplify the function in the next commit.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c | 85 ++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/connected.c b/connected.c
index 7e26976832..d2b334173f 100644
--- a/connected.c
+++ b/connected.c
@@ -11,6 +11,49 @@
 #include "packfile.h"
 #include "promisor-remote.h"
 
+/*
+ * For partial clones, we don't want to have to do a regular connectivity check
+ * because we have to enumerate and exclude all promisor objects (slow), and
+ * then the connectivity check itself becomes a no-op because in a partial
+ * clone every object is a promisor object. Instead, just make sure we
+ * received, in a promisor packfile, the objects pointed to by each wanted ref.
+ *
+ * Before checking for promisor packs, be sure we have the latest pack-files
+ * loaded into memory.
+ *
+ * Returns 1 when all object IDs have been found in promisor packs, in which
+ * case we're fully connected and thus done. Returns 0 when we have found
+ * objects in non-promisor packs, in which case we'll have to fall back to the
+ * rev-list-based connectivity checks. Returns a negative error code on error.
+ */
+static int check_connected_promisor(oid_iterate_fn fn,
+				    void *cb_data,
+				    const struct object_id **oid)
+{
+	odb_reprepare(the_repository->objects);
+	do {
+		struct packed_git *p;
+
+		repo_for_each_pack(the_repository, p) {
+			if (!p->pack_promisor)
+				continue;
+			if (find_pack_entry_one(*oid, p))
+				goto promisor_pack_found;
+		}
+
+		/*
+		 * We have found an object that is not part of a promisor pack,
+		 * and thus we cannot skip the full connectivity check.
+		 */
+		return 0;
+
+promisor_pack_found:
+		;
+	} while ((*oid = fn(cb_data)) != NULL);
+
+	return 1;
+}
+
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -46,42 +89,16 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	}
 
 	if (repo_has_promisor_remote(the_repository)) {
-		/*
-		 * For partial clones, we don't want to have to do a regular
-		 * connectivity check because we have to enumerate and exclude
-		 * all promisor objects (slow), and then the connectivity check
-		 * itself becomes a no-op because in a partial clone every
-		 * object is a promisor object. Instead, just make sure we
-		 * received, in a promisor packfile, the objects pointed to by
-		 * each wanted ref.
-		 *
-		 * Before checking for promisor packs, be sure we have the
-		 * latest pack-files loaded into memory.
-		 */
-		odb_reprepare(the_repository->objects);
-		do {
-			struct packed_git *p;
-
-			repo_for_each_pack(the_repository, p) {
-				if (!p->pack_promisor)
-					continue;
-				if (find_pack_entry_one(oid, p))
-					goto promisor_pack_found;
-			}
-			/*
-			 * Fallback to rev-list with oid and the rest of the
-			 * object IDs provided by fn.
-			 */
-			goto no_promisor_pack_found;
-promisor_pack_found:
-			;
-		} while ((oid = fn(cb_data)) != NULL);
-		if (opt->err_fd)
-			close(opt->err_fd);
-		return 0;
+		err = check_connected_promisor(fn, cb_data, &oid);
+		if (err) {
+			if (opt->err_fd)
+				close(opt->err_fd);
+			if (err > 0)
+				err = 0;
+			return err;
+		}
 	}
 
-no_promisor_pack_found:
 	if (opt->shallow_file) {
 		strvec_push(&rev_list.args, "--shallow-file");
 		strvec_push(&rev_list.args, opt->shallow_file);

-- 
2.55.0.rc1.745.g43192e7977.dirty

