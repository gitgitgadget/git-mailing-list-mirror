Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FA3A7F4E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503260; cv=none; b=pkw8ZoCes+X8Bpd+ShRzDMLykHLq4Htz+cbmCeFKFul3Mlt1c79Rp4yF8pYuCMJBH4af8KWkY2zG1LTfVqzujNAgXWh/30KaY+xPqXl5hBng0YK0Nwy7cSu2HzVQqDzJ/Erg/GT9bbvxm1M9Ri8N4llRYWzgirTtTLry7VZWCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503260; c=relaxed/simple;
	bh=8jqUFn3OFxgGcRR5Pv0FuMKBoeYRFWKYnTxmcuUrJdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozuT/cfDdi9SFlpKpSAm+VM9dYMN1ium+rbiILhB9ZtOaq/ZTzTuq0vSYpGBszxJ9t8xQ4XT4skIiXZ00RaFJg6NhVac8HMwJPtVtI/Tuv+/Yhf99q8OYi3IoHEUmsfbKW6U0a/6kDZkLxF5KjRgfgi85GCJhmuE9c8WCmNWhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AzDtEAxU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GAfFCAb0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AzDtEAxU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GAfFCAb0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A7C27A0079;
	Wed,  3 Jun 2026 12:14:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 12:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503258;
	 x=1780589658; bh=euxZC3GNuVSkZRhx3DayJsW8QEI7FFqgl+l7OGGIRTg=; b=
	AzDtEAxUNhNvaR5w11MYmxsClVrCmQtaiDLxJzM6cf+u7iu4I+80dhjaNnu5Yh1u
	Jc02+zgSH9Akfu4Ud6dRyuqLVxoPE9xb5RVpKUMpBggJ0aGdaX27G/qWyX3FxLn0
	msAGFR52LT+aMovB2N/RRd0O7CC02s3FTPnT+FYN/GJbLMKvoHUtWcQgHl+Fktn8
	tN8bHz1O9qQaspl3uAo5QO21hcUSR0qwvxgu0hRahR9/oTrUlM5Xdy+6LCvE2GND
	5c3FmMymGSiRevYvDHMlY3balMCwXg6LFh4z5mfUlPjMknK0vqaWMcOvVljJpJyG
	NXiLMiu7Nl4f1p0Krxn6bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503258; x=
	1780589658; bh=euxZC3GNuVSkZRhx3DayJsW8QEI7FFqgl+l7OGGIRTg=; b=G
	AfFCAb0ru/NsDlqNowLHzhLu/oQJccFFBWAzgkZ/QJsyJZ45onxQ+lRJquVYVh9V
	M+d5jomBUt+28qm/YVrARJVEM6984qnrIbmgN72XKlXn0mo6biyG18kasoLaMzPW
	tV8vXt6vlIVbbSz7Q9xEPJeix+4rMtgsJzMwzwT/0zYUV0cnV/vWXrnOfNqNejQ3
	/jljCiyyiTeXVCOoNZjqQ9L0SbIjBUN3PMyopfRPKA8xijDdQ/CVJ6KEp5VVxHc6
	Mkt9jvZQo4uHRs9TStEqR1gv8oko0RdIrf+zpo+46d4bDLPk9djUidMIuVIVQUWk
	s5jB/k1705/PKpax1kwnA==
X-ME-Sender: <xms:2lIgaubgnnag-scJq9wDNYYWxEb3jXttOCo_vEEQ8V0tTOfY8OdK5Q>
    <xme:2lIgao1djrkJW9izFZfEyNhq6JklOgVNCyyeWiJBwgapuY-c2DpGnE52ZamASOnOR
    n211JxEe99-kpyezKTAyZZFZhi9jalqzaohnveEdLR1cOmFP0pWIA>
X-ME-Received: <xmr:2lIgamWLJKJ4JIJG7wKB9McVv0xMYKCWmVSJiXBhJEjRrCrWtzZn4RFz2_C5KUxp5NFTFA0GLB1IZp7UhZ2AZQ228cZ4PRXRxZC4BhmXBUts>
X-ME-Proxy-Cause: dmFkZTGdlIonfplKpFXa/+DN5l0Fb2humCV2KDAOVEKyP+YPvmRBKflqZmkwAq9rePEQEk
    tFWbGVHfEKLtOw94e3kwwUvfEq/biapgD0LFxEGjNoceagFbAdw8S44lP98A4A6KSEBzBI
    FK/Zaf4iM+7r9UuVe4A2HKmR8OR4YocvA/6wxorfK7uRUU2fV0yzyhSTCXmRlDtYfcUpDj
    W3y4seHxmmHClyvMTnpX7w52yD4rY/DK178Gw1HIPAoq8c0YVNdlYew0Ju9pKEwEpdY7jk
    aRnqh9h1yCWlfj/W0CqUM74g6F8iUs+FEHBRjFPLTPipkR6XYgqphPOg5F7L6g8vVu+vGs
    3Lf1jxrAYzq7nEbnTOawF22507sg8c6ARu2KT6zceZJjk0M4MrgK1DBr2fLMHq0IdFcqQY
    F9RU5+g2juAGe8PNj9LKw3l3e4Bruv/fIG1N5ad+lFPTV9mcy1L7ZHkSF4i728Y2aommNM
    iyF/hFJVj9yIH/S6jhcrvnYB/ebxclGVF49/XZ5STyO2hKGQp+JCmiuBC9EDVBgkGU8hju
    3IcUTPjeNzQ6DZvxRfc+7PSlwrd9I2rFEEfv4Jj1Q4FDRb6MwtlNy4tx8cNCoCEX68VVmi
    hcpYPWtFxgrd8aH3TjpUNZxn5RgrYg0M056/A+mVloGHBIGy4k9PFhdz/Y5Q
X-ME-Proxy: <xmx:2lIgaqWbst7A6pH3EhsZtG6H1Lm_eqT7txyG8_kNZkWopaqog93MbA>
    <xmx:2lIgatf-X0YOtAq-W1oDTzn2eZ5c_Adn1dQRMgfqHKS6l-meoFAhNQ>
    <xmx:2lIgarUsmqA8ZYYJi0vSvgQcnXbl19Rx6YjY1cDbD4idszAqz2dCNQ>
    <xmx:2lIgauewfoCubhIUsotsE4jUpPRCeiSRePbSY1TmM-MPZlgbC0boVQ>
    <xmx:2lIgag2altqeIJ14nUWrvSls-khHDBwJvIzo45IAdupUMUu2KzfLjXPP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 533c4c6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:04 +0200
Subject: [PATCH v2 5/9] reset: introduce ability to skip reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll introduce a new caller to `reset_head()`
that really only wants to update the index and working tree, without
updating any references. Introduce a new flag that lets the caller
perform this operation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 7 ++++++-
 reset.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index a8d7eea4d6..ed9df6ca5c 100644
--- a/reset.c
+++ b/reset.c
@@ -93,6 +93,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
 	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
 	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
+	unsigned skip_ref_updates = opts->flags & RESET_HEAD_SKIP_REF_UPDATES;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -112,6 +113,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
+	if (skip_ref_updates && (opts->branch || refs_only))
+		BUG("asked to perform ref updates and skip them at the same time");
+
 	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
@@ -196,7 +200,8 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	if (oid != &head_oid || update_orig_head || switch_to_branch)
+	if (!skip_ref_updates &&
+	    (oid != &head_oid || update_orig_head || switch_to_branch))
 		ret = update_refs(r, opts, oid, head);
 
 leave_reset_head:
diff --git a/reset.h b/reset.h
index 9f696382c1..cb0700ffa7 100644
--- a/reset.h
+++ b/reset.h
@@ -27,6 +27,9 @@ enum reset_head_flags {
 	 * any user-visible state.
 	 */
 	RESET_HEAD_DRY_RUN = (1 << 5),
+
+	/* Skip updating any references, only update the worktree and index. */
+	RESET_HEAD_SKIP_REF_UPDATES = (1 << 6),
 };
 
 struct reset_head_opts {

-- 
2.54.0.1064.gd145956f57.dirty

