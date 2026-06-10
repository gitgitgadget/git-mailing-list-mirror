Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315D2E7375
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130233; cv=none; b=hRnZ7DGjV5g6lsaq4+oqrrkTtwp0gtDD/aC/bA2dRA0W9poPAWdNABdMej5wXzWIR8Nd6cGQFlvsKV/rTem6da8y5mzUDPQF4ioBYDh3Pz9BHmjlnFhnbB9JOBxWOoFwOe4wV+mVC4f7I2T7LD+22y1Ta7I35xt4tHRrg7bfdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130233; c=relaxed/simple;
	bh=yrqy9nt2VEAxFHF0sBZlG3+wkqzZRedDVZUPl9So5FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6Ok9Zt46lcCCCQm0uTtufB/VK5+Xr+4MBgMtHw35P0Ui7F08Dn+07c8BP5J5NOLStX1w7js43OUivys5o0ZO7nvgxOEbZcGw1GTyq8tnq99FLel0itU/6Ng56lFHKohNoGT/TBroHctJXgdoWTHImnsei7PxfIp+sb/0lw2L5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qRU/3bJu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RH4vZwnK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qRU/3bJu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RH4vZwnK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E73917A002F;
	Wed, 10 Jun 2026 18:23:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 18:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781130231;
	 x=1781216631; bh=hFNtyn/x/tPYfhZV+WjRtnnGwBZH/K9pZTTMJlPkKf4=; b=
	qRU/3bJuIYGetygsHdKddMP4EFkhj6scibLf2wJBZrg8BLpBl6c6etv1XBEj9HNX
	vhIQcc3nSXZ0136Iny/pPpD42auSJxewYRUAcq3zOxxaTHR39If90rIzmopJR2no
	rMbECstisoTnGiu97lbJSCXbB4piGiQT/cdJJGGiwaFNzyZX9MLss3FkcdPfBXDz
	xYnB7DARU34NEGVigZC3Yn408TYQ/pPRr4BCBPkkw8yWH9AuawJ1rn8YUQx6nyd2
	YlgSaXbidhpCgp1fTFzBOmUdFhhK02uXrKLhJ6j4jPuvDidfPfpsbNuubvWi+1VH
	c4nZnwUuE5gTONmjvPXwKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130231; x=
	1781216631; bh=hFNtyn/x/tPYfhZV+WjRtnnGwBZH/K9pZTTMJlPkKf4=; b=R
	H4vZwnKpKe36XexssUTcTp6Qdiyv4xIO31depwtoR/2XgX6dok5puOIZR4c4Gy9u
	hSzNYLphlWPXNs9n7zAtJJk1DfUW91If+kt8NQymtdCIn3ZHYZzkVjALyAjUA9a/
	GGgJ923rIGFA2XFjx6dNlSq0Cyfl3q/WQHfuHTuKam7WwTKi84ViGlDlRCPeQEVp
	g/UbkMRLQuqJlEHXrOBO9xvHaWn3zNwlzKyK8essfDpeuWBAf6MswsU3kGj9kp3M
	PQX4/AQK+G3jM73RJuzx0cTynd/CKamGVXDLj4BRn9vLWPlZc+X6DlkovmSjs4yM
	tczvbm3lC4tjPCeIgM0XQ==
X-ME-Sender: <xms:9-Mpar41KiT8rHRl8WiDKckr1577ZmT6HRD5viVfcOrC1nEOT3pBqno>
    <xme:9-Mpam41_XnGyMe-RF3GnIZ9906HgCnCG3WSHFjKvoehcS_y50omrrlo2fxoS4nx6
    LIeSLHMC7i28IXggS96fk4CxXjvvcZmwEGccNZlgKzcETyGeGH_fQ>
X-ME-Received: <xmr:9-MpagGKgUgGuIycg6T0zabFPpKJJIgvqK2OwwTPxzxoerNqk1dF5z72-J12klOKLBfPpyMJ_jClbu-o4CnGsKpXaRtFWhKIs58-BvdIU6j8fF5R6PzS6hh8Hw>
X-ME-Proxy-Cause: dmFkZTGrSoxKMDviHz/3NXLyuxJgY3r0nCaXhrF+/SCsk+7E7K1d05Eg3FWgUDWheCGCcs
    SmbzL9uLRg7xf5+luXp4UKYxIubETIDCKenZt/rSaFsCKuykQ/nyeEqbHdsy7SNmqD76Dk
    cUC6r/Wc3LE2upfleP1fLWYRlSIrzDMSaUU/QWutbTUSJJEAFWs9opYZlVMVQklM2OmRxk
    eppMF/3DUDlBz6ou/7v9RHDJfP1QePc0IVV+XI1W6aGjl/TAFtwUhZE4t8NZ9BVkJsWr0E
    CEYr1dC11yG4TOMmKsN3h7V07zcuAv4fXfeJFrx6NNtxUXjJo7s2qE3Y+M/JY7EUdCybh6
    J+1zj8W+G/umTUeG8IjDeEQSt1mgb4tnew10V+kOnts7g/iGxGducM3rjb7en8UX68UsjP
    7SJBj+VdzteO4NQMeq7my8WB8C7DfTNnbQwWc7S/2x9u2WG82LbgyFVNgb2Golz/IJ3Laz
    2Pp94NbFtvUGgUM3gSF4K5MmGdAFKSwNRlt66NZa/mUuYG1wJfF6TCwhOFeFrpIZPN9/D9
    cFHl8P+vEmlfDqhur+ePTGXnq2hjOMtBqKVjWvwDX7TTaubq9Bf3e+KLFWnaF3QKA7D0j6
    UAB9BGNIXqbVcSLSQzLbwU1SBOMDdxdfRAomDXLfR5LO3PgVVCFexZJKMRUQ
X-ME-Proxy: <xmx:9-MpanTx6n_c5lzqyUmy4OE0cyaHSUo7kys8xnK5qx6BCSJWwBf9vg>
    <xmx:9-MpahuEraSUXneUA0oJpBxR74TBBhBDOsT-Q9YLeIkJF2syL0XWKg>
    <xmx:9-MpauxsDdPnGCQnVCJVu-DqUJFcWh6_-FL1M1DywzzoMuJhjV_WiQ>
    <xmx:9-Mpaj4buNncO1nYubcdUkN7DKb3d2KJOwv_7nCqARvTTbZzfMBpYQ>
    <xmx:9-MpavT6stgJoK29cQl5nA9Qfg9BbVyLAUxEHOZ5H9JKiBl3AC158b4o>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:23:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/6] SubmittingPatches: discuss non-ident trailers
Date: Thu, 11 Jun 2026 00:22:45 +0200
Message-ID: <non-ident_trailers.8f5@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Briefly discuss trailers that do not credit people. This continues the
discussion from the previous commit about using trailers for *people*.

Using non-ident trailers can be relevant. The contributor should just be
encouraged to consider whether it is useful or not.

The larger trend here is to discourage using trailers as a dumping
ground for any kind of metadata in the spirit of “it doesn’t hurt”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/SubmittingPatches | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0b12badf86d..51c308a89a8 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -474,7 +474,10 @@ These are the common trailers in use:
 
 While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
-highlighted above.
+highlighted above. A trailer that credits someone might be more likely
+to be accepted since these are the most common ones. But another kind of
+trailer might be relevant, for example to link to an issue tracker
+belonging to a downstream project that is affected by a bug in Git.
 
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
-- 
2.54.0.22.g9e26862b904

