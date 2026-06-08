Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61C388E50
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914231; cv=none; b=ExGtMcHA4cn/iLlil0Rpva41++nlpxJwV5dlY7WU5VAtftEc1rVRHKF595Ya/W2tA1qRFb64z29cy02wIVzJG3cHUHC/t07FDYOASsuYDi/9s0i6oQtrGZazj/4UPHoTi9BH2YyIJqzXzUx82v4aH39IHn5sxZyNkfzMhP6eRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914231; c=relaxed/simple;
	bh=EcKKjbeYPaJXlBxJnW6OMF/Fzr4Dl9gkAugZBURDrjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cj/WJrOyYriRctaDjEpFUVyYGcy3NTyOAM3NMcnLoxqK4x/nfwFvhimPCvCkI7OaRoWUPRqMD8Evw1inhUGWcx03kgoOrrJrtn+GkiLNpz3xUxUqWtSlzEkYxSOWBccE/axB1A2pHuKw1DCL2M0//3MfwFNv5W+KHvKY6eMPeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XMH6yUf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kgW4Ebed; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XMH6yUf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kgW4Ebed"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0556F7A0122;
	Mon,  8 Jun 2026 06:23:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 06:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914229;
	 x=1781000629; bh=KKkHVb/qg1OjhbRKAyDYMbEIWGtVtDoel8jM7K+Hvrg=; b=
	XMH6yUf9FocACIbIbOkGYAXmfUImd4lhLFEVuqNMU1RH8PkxsTXZWfXW8v4SC6N2
	uDPcAbFIa/iDVg6bSoIILjQIUTZk1vqs4W7YlCudZN0idUC8ZXaM+YWm5Z0K49nz
	qwnXED/ZbgJE9M2yFT/tMYb7DVFnen15Tm5JRLZhtdsmgmQ/ZxCB3xOabpW8095u
	PHRGPq165guSXkPDbRdXGFNEs7lHgWq8T24oWRqD2di+p0M32v3XvCvaoRn8QEXp
	GQQ/t4UN+rkLY0ZBVBmvwUXCpUIFjcvAe52uuel8OlYcSZEx0W4jUgUkfY56/C+z
	M7e/Gl+4bmepRGKLWRJN/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914229; x=
	1781000629; bh=KKkHVb/qg1OjhbRKAyDYMbEIWGtVtDoel8jM7K+Hvrg=; b=k
	gW4EbedNgHk68R4GDOCNhQQXL7N5mXMbbSouuAB9itT8xS8nmEYpjIWmM4nz3VUO
	YksUyekpe8clGI+v8T5yvpe5LX90V79P2sI+uadDhxbPzFQg15UPXqCQwjkZOQ7W
	3tUQ8V9Gl4hCPPRkoKceEnd8Vd0f7WbsRfsHmlUKXM5dQfX0jf0tNRetZUkVm3Nw
	1NF/me81wuonl2SpJfcl94HweJaE3BwEGnb/Us264+kgjT3zSZgWIoKpLwA7HQsM
	oon3nnKbybg7Hk/JxbYHAUFbra9y96vIQhbqP0WopTC7q/S+iF8lC/M0tfeNpPNh
	XYU2lmjhH/xWFlcV68Owg==
X-ME-Sender: <xms:NZgmamODdShp196bezQIuIAeBYZ1gVyp5L8hQayyqr-lF8uMQM-GPg>
    <xme:NZgmamcN-UwHyG8oz_cC6iFf-epEMoW5Yps2T0MdAkgRnAypDT4RrZl2Xn199l3zM
    MXQFV6Lh4e1XuqgRSV1hE_siDBcX6FGSdDC6Q9ZpXzdx_fiXFvd>
X-ME-Received: <xmr:NZgmatX7HmrfdyMNS7tbFx74ml-m0_10GvU7XEb1Se0oH-9AcuqbSBn1KvtBREIQrcNl26w8DwpLdaVEr1x0aT8a5EKYwbx86xyKMKlqhg>
X-ME-Proxy-Cause: dmFkZTE5TQe8hpv70ABKPBTJxGWpdo/cGQ72TfL6sqGzRnXYRKe2zl1W4uOIootjY7cZ80
    MniDNd/FNRDj1su/0pnc3HD+a/NtQ4/l0tMPv0ndV+mMpmp9/FVlN8MEifvX4kBYvCEMGg
    YbFb3qassHDopf/x+IzqMaPdLLZBldKr+Hf9eA+gNF9LzdD6ZHfzYJyUrRzMUMjGYSJxev
    D+UZFjhrRS8B/kVLgTLeoJ5Ei4zam2XjDnc6pKm4P72xLHD+niqliX1XcVTKQbiQsR4F2R
    Sq3LHl/JD0qLSnR9kovfQmrgSYkW6S9Si0VQYG7juxkUvbtkOBzqIja7YEM21vPF3WF/QW
    98FrvKEtF2XjP5cuCcZjVUMdHkcB/1zwrJ5SeCzXOoUkzX84qnxjf3G8M5uIMqSDycfBp8
    ldXCez0Htn5yi8dFSQQkmxNuC1LX08y7uvfZ6s2tH57EOiIJnkXWKadwufDW1MtmFzNnBF
    6ZQXd8Ewbm4GdaUn/ptdZBYDJb6DcngYb4SkixbHrZF2lJOlzncEcV83zDnJmw49/D7trs
    LGWn3/fekqyGmgBviSmx2b5zXbYTZXoA28vSWTBE7purb+iQGRu/J9iiBi0obZQiR5Kadc
    Ud070goviwvZQ8HO/9yw97hOjKfrTVqa6BTMUxm7qEdfjGAxyw8PP5AClbXg
X-ME-Proxy: <xmx:NZgmamjxyueiWXiY1lbCkWo-FsEFLkQqBVuT-C345xwjsDxVU99KYA>
    <xmx:NZgmak-BZRgilYVDrJdGFJt-LGKtOJXuGHFygweq19F61nmaaiBffQ>
    <xmx:NZgmagZKqkNpBBuzctGgcASenGaFuvrIr6Qf5fVrlAAk6yEBY90JsQ>
    <xmx:NZgmaj1DTojxiBIAN0otZc_ffaCQwMfxGDt2737ekQ7rugtOU89DDA>
    <xmx:NZgmaqZ8yuY_MZIu2IcBuGTdSKKwFKgVftQRJ4dN3hr-zzF52-Hwydsj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5bc6ef4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:31 +0200
Subject: [PATCH v3 7/9] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-7-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
we updated `reset_head()` to stop updating the index tree cache. This
was done as a performance optimization: the function is only called by
"sequencer.c" and "rebase.c", both of which assume a clean index before
they perform their operation, so we know that the end result will be a
clean index, too. Consequently, we can skip recomputing the cache as we
can instead use `prime_cache_tree()` directly.

In a subsequent commit we're about to add a new caller though where the
assumption doesn't hold anymore: the index may be dirty before calling
`reset_head()`, and consequently we cannot prime the cache with a given
tree anymore as the index and tree will mismatch.

Adapt the logic so that we only skip the cache tree update in case we're
doing a hard reset. While we could introduce logic that only skips the
update in case the incoming index was dirty already, that doesn't really
feel worth it: after all, the mentioned commit says itself that the
performance improvement was negligible anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reset.c b/reset.c
index 5ba9a3a574..2fabc54d9b 100644
--- a/reset.c
+++ b/reset.c
@@ -166,10 +166,11 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
-	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (reset_hard)
+	if (reset_hard) {
+		unpack_tree_opts.skip_cache_tree_update = 1;
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	}
 
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
@@ -196,7 +197,8 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.54.0.1136.gdb2ca164c4.dirty

