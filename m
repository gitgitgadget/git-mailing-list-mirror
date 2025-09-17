Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF21A9F86
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140891; cv=none; b=LSEXkwAIbkBw3piSNDl1aoWlcq6i3HHhbArAXRzV+EOBkOQH9SbLxGayMyvBXbpf5Wl5ArYNRbwrB4HeK0EY6Yf1Qe1XoIRHWDXtwTRn9mvdBGoa+cH5eUtR9gOLSyYXmmZpvR0eRXH1u9bf0EwtDp/Pn53st1miZ7MoBzBp9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140891; c=relaxed/simple;
	bh=dA2U/kkAuEhA1dEMRBKYfSXqoY/5o+29TzHSPAjivko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gISI/x17GPjsZpxKTNofpYhd9YfYnKaGJph3LalaNEe9TauRIaa775TkHsU4KrDk2igJfeLaheildOZ+TQQwS+BRx2Q3dLx4GhFOR+gczjgN6xYhxnvu4aXmdeZgP+cUeN6/Ben3FbdxoV6eVA0NOa4drAE/CjhkTE2fyMhNpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bv4UKc1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ihJGFQyU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bv4UKc1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ihJGFQyU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FB29EC0243;
	Wed, 17 Sep 2025 16:28:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 16:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758140889; x=
	1758227289; bh=M9AhnyO3SZgAarZ3XYRIClcqktLJOWC642qHt3q7XUw=; b=b
	v4UKc1Dpb/12pBsrv4e4AmcdfyKRki85z/Je5ps4mdyQ0C2g+ijhEgzW8gXctgyd
	KIxg7EwKMF9wIbZz2RLHO/mc4Zb8i4onBDawpJXcxS0a0Ss+DqniAs7GXvXiyE1e
	SFY2w98Zensr3ok5cnttKi/i2qtfWnVvjLPIwPgaFUwgK4Wvq2dmVPwcxHVVyAYw
	bzi42EamZ6QxA14RjRRr/D1j4B1wFa8WGsdWbDfnEtdF8H4SxrJ84UeooLDOah30
	90ddE01+cAZ1LmB8vaOtKIaQPVsat2p0hHN5fmkK5/0Ux5N+RhykPznqtgT7ZXzk
	fIpX0nVCiUcJ0d3l+s3UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758140889; x=1758227289; bh=M
	9AhnyO3SZgAarZ3XYRIClcqktLJOWC642qHt3q7XUw=; b=ihJGFQyU/f1DVATGN
	upb7rTZaI/fLC7qZ/Gl+AZdQ+KcXjkX/sdHZqRk7USo0djhWo9kor3pbSN3MR+q0
	YI/M0cQrg9r9cnNALktK6nTedcIZxI4KFFu/gRDlMGiHPoXjpxJRh/T3aArqO31X
	l+4T1Jjyo+nfjfQYNw9oFMFdWKZlvjsA85QEjNoOPscgX3qp/87yPNGS7T41oGVO
	jrj8CtZGKyZtKrJqlLZh0B40Pxo0Fs1tPwU9ReQI4Y/gdAfAAsNGsD5o9O3yenYR
	m0nfjnP2YjKl/Ou4GUjdjs8PNUZ07BSRm0l0aKc1ZNLE2zKW7nXR+oi+9boq1ur2
	GndnQ==
X-ME-Sender: <xms:2BnLaOqRiOZqpjP9zb_6B1xaGaGiaJ3G6-94EeQP4rRN5UQ-w8J34k0>
    <xme:2BnLaFG3uZPtOfa_QXmI3G02LrhnYnqLmWnyhFpOKw_moVR_ohkISeVSGu41l4Puj
    NNFPx01U7BX5f5KXw>
X-ME-Received: <xmr:2BnLaDpDX-EXFgUH8aRMa5SBIo3ksT7f6qxZbkqybulMSooWl6PL7eTRFqM70to5K-C3mFmnLuu7TOzFyGRCYCu3E8ueGQj4sqI6ifXI_Li0I9NkBZ2rcAphdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeefheetkeeftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2BnLaOaK4zcXK_YdvSuIzZ8TLf6JdJq6V_VhKSSyesoHIdQISYvmXg>
    <xmx:2BnLaMXm5EnqWRagT6FQQaOlRDGB52WcVU4ebSa1xrntxbhNh8hblQ>
    <xmx:2BnLaH-2b7_fEULrxUKUHhgRfLcq6yjUbwkekVt4ggbynV_EhnVRcg>
    <xmx:2BnLaF_SaD7shNVkYdEvd5YySphs9_w9xA_1JWiGzTtYtd3whInp9g>
    <xmx:2RnLaHB7BcPjyLGToFDb5p2HvHAszUKLYoFL9fs3-folmNKguPc9JGsu>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:28:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 9/9] BreakingChanges: remove claim about whatchanged reports
Date: Wed, 17 Sep 2025 22:24:19 +0200
Message-ID: <7dc3d.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This was written in e836757e14b (whatschanged: list it in
BreakingChanges document, 2025-05-12) which was on the same
topic that added the `--i-still-use-this` requirement.[1]

Maybe it was a work-in-progress comment/status.

[1]: jc/you-still-use-whatchanged

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Footnote solely to avoid awkward paragraph wrapping...

 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..c4985163c3c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -235,7 +235,7 @@ These features will be removed.
   equivalent `git log --raw`.  We have nominated the command for
   removal, have changed the command to refuse to work unless the
   `--i-still-use-this` option is given, and asked the users to report
-  when they do so.  So far there hasn't been a single complaint.
+  when they do so.
 +
 The command will be removed.
 
-- 
2.51.0.274.gdcb64e51a0f

