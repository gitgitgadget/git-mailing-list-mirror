Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB412158DC4
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466703; cv=none; b=Ad3ZNVA/XMzdygVGbjKDkiHYvwDgcvA1AU1ANYR2WAspNQJMAIJaOnaenGxDS2c0SeNiXKLXliWlAb8kYOXxB16o7rS6DYVR+brgmj95PaahZK+vqnhAKN09cGacUqpAo+XYN8tWI6DAnnyEN7t/8ToQq/725EmjnOQONbrxVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466703; c=relaxed/simple;
	bh=fOOBKjkTFOKtalzbnK2baQCemovvxQnAbXbgT6ZlkoQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QkZYlnFsASXBoDCotXJu+Auqng/zFc/1OmbtX9ZjOs0R9QWlmwEFu00moWGhcIZVV6aWjlWg7Ru6VyC5xFCcCTs4FxM4VXgq5HoHGLPVCm9ShIj/NNhGS7+n6RhoUFNzXCj0URljKj23APZjZ/+2VpIe6NRpihLiMcZHnLph0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FNkHsWA5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FNkHsWA5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 016452540106;
	Tue, 12 Nov 2024 21:58:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 12 Nov 2024 21:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731466698; x=
	1731553098; bh=IimZoOVdmf4mICQ1b1McSXiTbafKWJAG6ubcXD/33JE=; b=F
	NkHsWA5wdiI0bq7zT0LC1ayoN/rJG+S3lNRdQFMH3zJtLk8dmMjAe9cvw/443KS+
	49UqogIX6dhCsA1azgfIHLhHU8d71uNPtg4x17SIVcMJGkhe10ZEg+98NltE3xBl
	OMWtpSA44cv03I86eXdkyunqCxMoz4aP0zJ6QjvpmOLWrkPZmQ+CaCPMtUHO4dfF
	y4snA4oJXgxruDHZzgpefQmh/nsjsKWyik+ZTa4aeOytYT5N96mtdTyr+VwsDH/v
	2pp6ErWNIlGN3VYG8ktYhTXvC8oQwGFnw81c2m41ou7HZWiRZK3udK/x97V5IYZP
	w4lpaNkjt29xhpQT9yPZw==
X-ME-Sender: <xms:yhU0Zz_qe8GJbJE34Vv5178KET_hh4kqhc_t5Y9wyzKR9lBM2hbZog>
    <xme:yhU0Z_tyQZK2Npq8JCbXpgW0ca8XoICvgvQT7cfv3gbrZOPx8Pqos0yN38fOq4EYf
    cOSY0Bxll2Ey_R7aA>
X-ME-Received: <xmr:yhU0ZxDP77NCEDq6DVkuiIG7iNohAaQzhnZkr7q1LgHtgz7IXvJDNlL1i7Vmh3uT4g4suEhEN6IMEb_DD-v1nu1a3QVuSTLTxAfu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    gfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehg
    ihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeegieettddvge
    egtdffvdduteeivdduffettdduheeghefghfdvvdejudehhfehleenucffohhmrghinhep
    vggtlhhiphhsvgdrohhrghdpphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomh
    dpvddtvdefudduvdeludeghedtqdhrrdhshhdpvddtvdegtdeltdefudejgeefqdhrrdhs
    hhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yhU0Z_f1xhh9muMyYORG-VEa91Y3NwZGgfCJe-bMNpL85t9mfi9a5g>
    <xmx:yhU0Z4NoqnvpW1p4hWdD0kAt9VX1hiwO1vvEZPSYOvDMRKZMLoMVog>
    <xmx:yhU0ZxnOHjWNMAJR5u45Ibpkjlsidr0o0YLkd5-5tuY_tCcsp9TNOA>
    <xmx:yhU0ZyvI8WrfDiVdPrC-mmg_0DD09ucFCXsDX2DGqCzGe_-xjnZT4w>
    <xmx:yhU0ZxbjmvyB4bCXAYISF_fBQgwjEfNq2pBcQGq1dblq2eZZGkq1vhN8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 21:58:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] ci: update to jgit 7
Date: Wed, 13 Nov 2024 11:58:17 +0900
Message-ID: <xmqqmsi3262e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The version of jgit we use for CI has been 6.8.0 for the last few
releases; try to update it to newer jgit 7.0.0, which is advertised
at https://www.eclipse.org/jgit/download/ page.

Note that this new URL seems to fail to download (together with the
URL for the older 6.8.0, which is causing CI failures) right now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index e2c6ef0f66..65b34d930e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,7 +9,7 @@ begin_group "Install dependencies"
 
 P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
-JGITWHENCE=https://repo.eclipse.org/content/groups/releases//org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
+JGITWHENCE=https://repo.eclipse.org/content/groups/releases//org/eclipse/jgit/org.eclipse.jgit.pgm/7.0.0.202409031743-r/org.eclipse.jgit.pgm-7.0.0.202409031743-r.sh
 
 # Make sudo a no-op and execute the command directly when running as root.
 # While using sudo would be fine on most platforms when we are root already,
-- 
2.47.0-383-g8012c4ff7f

