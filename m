Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DE2E266C
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765701; cv=none; b=ODhmL5rxe799Yk1OeQ6ekm/UFY4guWviJdk/V8K7RIqQ4XG7CtuIhySaNeBa+8kkH1BVraHOhd8LONL77Rv5FOfWZs+aqFhw2EAgyQfZoGPpEf5kHyvILTceqk+BVb9iExn9ZS7dJ/fCxBxdDMsHVnZCjhFhcakmZu627W8+tdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765701; c=relaxed/simple;
	bh=Q62EbDwJ42JhDZk1cuFswzN0yr38Gj7IDbLXKEB0X7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNVXT/OkLzFVA59JOQm2bfHFsyiuGRCcsvpT+yXbq4VVB9L/hhFUfpCNVw2TEZnA2aBJLcAO0aCAwRkngUIyYkWO3e/fJQXHK9bjaHnHE5MUQC4Oa3eDwlady9h8HfYN15v0q0T7NivxKhtbMtsFNBf4jcnOBsRgs0xTJVmNv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JD1WFdLS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4Q7C9U4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JD1WFdLS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4Q7C9U4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01E027A0179;
	Thu, 18 Jun 2026 02:54:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 02:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765699;
	 x=1781852099; bh=CMhZsBPAKXPLYubbB7zg3fr9zgFv/MTcq4U4QvMyHtA=; b=
	JD1WFdLS3+K2NzqFPSjfHdhVAnXfSOMznOnwICBMlE1ty0ZWKyeyCgOAfKhGxpT1
	ulQ2hWnKGa3z3Tak5i+W67cy0ONxMuCIwl8DKZEWfGqen13uHDpz3stRyGLuqMkJ
	B3eutgwmgo23PiQ7LiyB1txcv8PhisRjhyLaU3sZrugwlAFmu2fMssaJPk+a9bSn
	KYP7PC49ycqbTHbbXg52GCcD91EW7tVdIc3UmIb8WJkVbt7UQIHzNX/wF5OEJMVV
	fjNrWnnhZJx1gm8hxuetOdklBaSiOoQLIrADL6xlNaolz24kCM+591cCbyvdfYSi
	doKhGhGO+M2+y61NXZ69pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765699; x=
	1781852099; bh=CMhZsBPAKXPLYubbB7zg3fr9zgFv/MTcq4U4QvMyHtA=; b=K
	4Q7C9U42cf26GoY1+EWGWzI4wDmZSkvJ5aVgXNFashbvJYtL0KUejYVxmt/CZ23H
	X+TMo0r+ejUA9lOx8eA3XC6S4Rf4Il5Rqxa80mVAaqfa9jI80xiYdy3OMtdz+ton
	5wmsv96q/AafTIYKP2IHQ/w7hIyLHVag+UbkiuQoKXE1P9ixXrwem78upPZfSI0i
	DNTYQlP4txcgmU6TugmhYpyaV/2uUApk8Ff0k8Rt08AyRUTqJVNYdezCgMWHo92q
	ZxKTNWQAYBzRXynAAjygRznMgxGUkyb1EF2SDtAPzn/6unNdsfXZ++6CR9iliI5K
	RByDNBiL94cQcmuJhJowA==
X-ME-Sender: <xms:Q5YzapjOxN2iZbkVzRl9sZ2rt_3RiW4oo_vB3XLypDcL2FNxW8YybA>
    <xme:Q5YzalBHt-W9rjiiz0l1XgujhpGsivSeAzuF9U_fyjAIF0m3kBGcHsU8K8YCAm5Bu
    fDTQe91zS4qxRFI1eiF0Za2q0CuBnpeO4ayBRvj6GfQmz_gztONkWs>
X-ME-Received: <xmr:Q5YzauFKxQSqxK7gv6R-D5aoKpp16n97qWDii32pmXvTgNzeCOdL7O0oFJU_6et1H7MPJeHErPuUKJnXOUthO_tcU4tF0qpMiRju0qHaDg>
X-ME-Proxy-Cause: dmFkZTFD6dk3bOvvX0yaVMjewMZkeTdhDwFjQkN7CKbrsc6RX0hrYV0S0wDnX/SLDtagvs
    OXl/+ys6J6Ef+ualX4oOCc6rpWlLgwUd+CDYp+J4f9tlVotwnOyNo/D2Ul+hiGJ2GnOpwO
    20YD1dz+jK59WSjSeqbvZIbS7LjQbwOZCvQ25fWlXFborkKwttqiF//EPtS1SKQOJhwE9p
    V3KhMGYjicitMSxnodz6t0JekyXT6bD5QV2YO0G8PEP3srRCCjxK6NZiPsNL9hezzRVkL4
    4yQ1ZKu2ng6hTy03G2N6EA5XYfWUIQofvB/33+yVj+xfadwE0sg/Gf4tc/U+tgG/YyDiKj
    tPURr+lQqEudEn+V+Hwol9rlPN3yrGOOpO3RDrhlk7joK0XlfGcM35aPO9uKMlF+yQrdvM
    k4VFh1HVebKVNYn7dnFOcBrK8Ejg4oRCCabnyfS4M3FQ3CXcseLVzgedsyYdvW3eLykfSx
    279bnW76bGL8LSgkQWFc66twvK/uEXqB6VN5uzASifRfoY94jlCGfebMJuVIKD542GE1y4
    Zx0YTPyKbacC89IZpwBHqKOmZ0eIkFrYL54zlfhsliJA7EzWKgcn+z06udJi6fmqLPEqEn
    bWMGcNln1FK3cQ7vsXNxLAyXMfD9/VGj9JxFiMMia19VgZ7ojtbIiVNps5Cw
X-ME-Proxy: <xmx:Q5YzatIV00ceh2YPloGAb0wIZFJ5VVuvomMieRaecl625ccHyyhd8g>
    <xmx:Q5YzaiksVCFs45rpiFrcdzTPuU6YlZDU_mcEFMxlPMniVPYvbtKcCA>
    <xmx:Q5YzalTx5WJFJgyo2fXyLx4zSVDdQg37bVna_rUAojADJJzMYo4aLg>
    <xmx:Q5YzakJMFIy24qaVagiBjhyXLROg6fAxbOtcOvhjuZaWqa3Roal5VA>
    <xmx:Q5YzamKWL6dJ1v1oxy26bbHQiHrK2q1FHLmPtRVq6aom0tbvdncxBYQ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90c87999 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:37 +0200
Subject: [PATCH v3 8/8] refs: drop local buffer in
 `refs_compute_filesystem_location()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-8-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We're using a local buffer in `refs_compute_filesystem_location()` that
is only used so that we can fill it and then call `strbuf_realpath()` on
its result. This roundtrip isn't necessary though: `strbuf_realpath()`
already knows to use a single buffer as both input and output at the
same time. So all this does is to add a bit of confusion and an extra
memory allocation.

Drop the local buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index e69b9b8ac8..4912510590 100644
--- a/refs.c
+++ b/refs.c
@@ -3571,8 +3571,6 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 				      bool *is_worktree, struct strbuf *refdir,
 				      struct strbuf *ref_common_dir)
 {
-	struct strbuf sb = STRBUF_INIT;
-
 	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
 
 	if (!payload) {
@@ -3586,8 +3584,8 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 	}
 
 	if (!is_absolute_path(payload)) {
-		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
-		strbuf_realpath(ref_common_dir, sb.buf, 1);
+		strbuf_addf(ref_common_dir, "/%s", payload);
+		strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
 	} else {
 		strbuf_realpath(ref_common_dir, payload, 1);
 	}
@@ -3600,6 +3598,4 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 			BUG("worktree path does not contain slash");
 		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
 	}
-
-	strbuf_release(&sb);
 }

-- 
2.55.0.rc0.786.g65d90a0328.dirty

