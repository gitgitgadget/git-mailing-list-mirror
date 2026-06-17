Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674D48C8DB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712391; cv=none; b=Su2NSURU+DuvJdezQK8H7dbxNtjVmKrT3xfN+46J0sS2k9uicSFJWD6NxGDj5RnFiSXtCGSjsxwqdZ6QywAj/WR9Kl7ECri56rH0k/M/KrNr5kTYvHDfVyrbdZ6St8d2qk/WeHK9Qy6yE6DE9SOEdF0TnTMjaoF4ipZFMJfD1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712391; c=relaxed/simple;
	bh=K0UD+WE814dVlSIUU4CjzS3Cd3QPBujEvklhkOJ593Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+pE0p8AZWJE9/idPjmN5fEXZt4IQvjQP6jOKhdTCJWiaDtPuKGWtGm9PGe6kxTlTk5lUJta7yS8liaP8YnEznLPERIh9Qaw8DOFnI5jq0u4ohZW+jcAugxw3EfAPZNz0nPbXDKgk2Yz0aWj+XwCrGNvnoGh4RDGuZbqVX88Vbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U5GG6zCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crlpp2mn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5GG6zCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crlpp2mn"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F17847A015C;
	Wed, 17 Jun 2026 12:06:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 17 Jun 2026 12:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1781712378; x=1781798778; bh=TILc4TeSyme2qnq/W2rEALUO0gtp5SBp
	+oxBln0KbL0=; b=U5GG6zCFYNtH/AlVZjeGb47E7HcA9IZt91vqvzhOx8vi8vV4
	wIqZ/zqNP92WYDFE8D6sBNagrZA4ns4JW2YGN1TfP7xKmpWBcwo3LvT3eg204EKx
	q+eZhHbFifLq3xjvRHeUZSyFggIqXwByt9rGYfD03MLIiz/EbENFCCxlaeaZ7KXu
	dPfF1M5/rP367ls1qImwqLa0KpzdmNzElNiP2JfNsnrHLtCM2zD0ilrnh3MtPVRW
	G+jcGAdVzk5YKt8Hceqmui49m954P8jTduBaC5iCZCXEO3skAfavgBLt6bNJf59n
	j8veEwCTV5Z7udXGppKdJ+9dP/xV7GDoCl2SHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781712378; x=
	1781798778; bh=TILc4TeSyme2qnq/W2rEALUO0gtp5SBp+oxBln0KbL0=; b=c
	rlpp2mn++sqLO6acaYfQtXOEY9hjWRPmF8oR5hv3Bp1ErUSrGl8wo98o58Pg3ShF
	Mej/zPsg3Hk4+7ccMK5soHbp/vjgOcS7gJFykP3L3CdVeZKcs48MXg9ll3oiGdpt
	4wajRwsfn6QiuWqcPZT7SRfUObHnr0E70FV+mKT63mRDH+THWUuCuI9BkkHbyu6v
	CdZwzTMSM7zoCphVms686J8ju0DwsPMtV4NQkYoWPWduAvhgHT4ijeh2rp42P6lw
	C7hgBTWaBPUIMB1hov9fL+LUFmVBhC+jL63Ir5KHEYX+6csMzvGwzzrXgZo1ELCO
	w6Jc6jZ1mcW6OdjEEhVlw==
X-ME-Sender: <xms:-sUyagqUo_waZZ17TyL_MhmaD_Uce73Uk28oZSlQRP9klXMhAfwYnQ>
    <xme:-sUyasqjcoYKS-Oe5cBmpC6wBSfeeAxvnrBffY_ePM_ShZNggGzggUNSg1rcek-mY
    4hA_ZNj0ebE6HWlUgBIZTM5S_Em8TW0OQ06gpERDokHkJsxyXsn>
X-ME-Received: <xmr:-sUyai0veJxW9PyjKOu3tJRYQ6OZmzUx0svIx9xYHPuLo22RAYysqNFT6JphjPtIHGP0H2t-o4AIuFDBVgUHIcNKvsMi8Cv3WOeX>
X-ME-Proxy-Cause: dmFkZTErFkKFiFAlbwRelPAOkN2Mx6IHyEBEh11qauyDyMwbHldhKwxthMCiIt3iShFnvm
    jDRwscxfOgyFB2j8cymQmF52tPOHUubojS3k44nfT3FvLRzdEhi/9pT+wZR0cnq5TKPJ4j
    ll5e8pGg1CRbZwW0B4wnHap8It16N92IeLRtHjkFGgGTjJ7XDscvPTBYMn9seiUCdI+IpH
    ZXfgg9fRZDGAFLaRTXLFZ7924HcalQQJtYGdCLPEhMKUFSwg1F+G2B0s/aRBNR0Ii/gO/3
    0etdkmne3awIcw7eYbdGkUVGIc1FH3TGNT5tlyGfkOaSPhoFEocRIXqd4DRh6LhEbhiaOd
    iuI/OLKkJO0n10SiXPpCcB60CaY/QQL5wImtkb90xWmAbIaQicZOiv6Qq295bMIsfE4vg/
    jWY1MtTFc6CMekk3YnBR7muo6167U4YaIaO0/WM1602br2DlPjQAvalQSgBzCPCGt+5WHZ
    N/nuj4p45hHvqcpxJly+Ice+1bslM+vOnNml3u5+i59pIS4c9/4AumlwBD5XedBWN7ESMB
    PR7ui/1HnutFFdZn/3K92YlqtmMz6+yOlddbqpHgmBTGuX3FX18km97JRL8fVjzigc4bci
    CWVCuKglQozv2+rPKixqodmnFAwLB9RwGEUevIHDrna4mE3Um345crpUYeQQ
X-ME-Proxy: <xmx:-sUyajDN5EQY5iVfgH26dhySMlUna_cMO8MNMHk01vcJ-VQrLjJb_Q>
    <xmx:-sUyaif7ype3nkJ7D_SUkQsH8igxDzJksT57d6L2xuk8ChXT43Qy9w>
    <xmx:-sUyagjlnfYI_4S_GAkE6fZdhj4G5AZxZDkSwMZtnACfK3ByGfS4Pg>
    <xmx:-sUyaipn9MsKWlTfAcrPUoQAZYh0Q2SdawVcUAiVe7RWkwgwk2YB9g>
    <xmx:-sUyakBvla0VATMaRDha2pY_5AzhDK0BXMCJ2DtuDABGMI4Cin-ILTZr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 12:06:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: address design critiques
Date: Wed, 17 Jun 2026 09:06:09 -0700
Message-ID: <xmqqv7bhxiby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Contributors sometimes fail to answer fundamental design or
viability comments from reviewers and submit subsequent rounds
without addressing them.  When design decisions are resolved on the
mailing list, the final justification should be recorded in the
commit messages.

Instruct authors to be particularly mindful of critiques regarding
high-level design or viability, to defend their choices on the list,
and to accompany new iterations with clearer explanations in the cover
letter, responses, and revised commit messages. Also instruct them to
explicitly document the resolution of these concerns in the commit
message body to keep the historical record complete.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 176567738d..bfe3745a54 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -51,6 +51,21 @@ area.
   respond to them with "Reply-All" on the mailing list, while taking
   them into account while preparing an updated set of patches.
 +
+You would want to be particularly mindful of critiques regarding the
+high-level design or viability of your proposal (e.g., questioning
+whether the feature is worth implementing, or if the chosen approach
+is appropriate).  You want to defend your design decisions on the list
+first, because you do not want to spend too much effort in the
+implementation if the design is not yet solid.
++
+Also, make sure that any new version is accompanied by a much clearer
+explanation and justification (in the cover letter, your responses,
+and in the revised commit messages).  Aim to make the reviewers say
+"it is now clear why we may want to do this with the updated version".
++
+Topics that fail to address fundamental design critiques without
+resolution will not be considered ready for merging.
++
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
@@ -322,6 +337,10 @@ The body should provide a meaningful commit message, which:
 
 . alternate solutions considered but discarded, if any.
 
+. the resolution of design or viability concerns raised by the
+  community during the review, if any, ensuring the historical record
+  explains why the chosen approach was accepted over alternatives.
+
 [[present-tense]]
 The problem statement that describes the status quo is written in the
 present tense.  Write "The code does X when it is given input Y",
-- 
2.55.0-rc1-92-ge545aa9d3e

