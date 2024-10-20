Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371E19580B
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451738; cv=none; b=hIQQo01vSBc5dkMipvZZ9aN5IbRlysl3Vq0dJNs7AJT3x1+L78xccaM3P84sRnVA8uKhXIfhZpm7lhy8t2rXoTe17ta9/RiodKLnEXs0wBnshnGdAfsfpUnsDLoamKyx7HSt3iUvt8XR1Sj36BifOGMG8D5koA7fnJFEZHqjENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451738; c=relaxed/simple;
	bh=0+BgZkjSmyjRFmxz89GrCNbGDxwZ4PpB6LR0GQzEsdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLehVb855B/QY18ycZDt5xCqRt5b4NpGoHQEkoZDt52EZrp1VsqTfpFTYFKBPYF/wxVGz8jCCB+rvhqQkn0U4bv4C7/DKelR+hrDAutiiV0AD6giKF80zIzSBecdikJdUzBqzLCajySfPs2pInHZay1WIuZU2fBq1Rn5eYHjo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U/c8tpGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HsdUrvmo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U/c8tpGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HsdUrvmo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E58E51140179;
	Sun, 20 Oct 2024 15:15:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 15:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729451735;
	 x=1729538135; bh=Ano7V7VIyEJBflUNcHh9rZN5tCZP/ksRYK3rcV9kJbA=; b=
	U/c8tpGxG1Xe0Eq5MBsKiMcXQ4BbWTZULqorgnz8XQWYFeNtp4IBLs5TRElpcm0x
	IQNwRBWhMD83oLJ4EeMRtg/eBrWNGU9I54b6tbAQCcbdMK7otSrsyYYP5hm7x8VO
	DotthZambW5sr6E8K9gwEnAnAILNltLuKQ/Zj/lJgP7CA5HN8oi8XQGnqImkKx6h
	N1OTBmIWH+v3gTH6cHJ4euh7F9p22NdGeNNe+/iBjhUwbVyyCEfaoI8Y1FMhdLBc
	P7+4z66qGPerjLJtiXHnqDspKhg41AVubucOYphQpCske2xhgnk1VKc6EbT+ihxd
	5HykjqoJZMYixCn9tl4VRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729451735; x=
	1729538135; bh=Ano7V7VIyEJBflUNcHh9rZN5tCZP/ksRYK3rcV9kJbA=; b=H
	sdUrvmoyt0S3FVrp/iLQNKthJyfI93I+KR5hzCOEH3ghWY0maHO3aV73DfFqdVY4
	EbHqch5dYxfrhcWAk3DicLvBGSTgmnkj66mRR+Diig3yvJOE/M+0LPAGQDyyNCpK
	AOGn5n6qbA32vjSD4Onx2+uxJ71gRcNgnlsPiwGMVAnuUHSuREYLx1k4m+s3DfWU
	WV7T3R+yLNanlEJ0xaBGoCBDXtYrZLalemGGzPDGZ+B+NHtRy9IOPVoB/f5Oc16Y
	m44CIRUj1WprF4xZiszFLTg8wR3TsHtDUaEMhUC/Sg7GMQQRjhRJ8LqjWTw84oXA
	yi3uY7/Sa6FHgvIsi1opQ==
X-ME-Sender: <xms:11YVZ5eOI-If-mFfhMFQjm_NcgWWgJ5Jv5aF4z_F6__0WiSmOMO5v3s>
    <xme:11YVZ3N8aejRqhouohKY4G5r520RxmDtuJ0Hynm-UaQCJq_lx_1MslrMXoTYzLHT9
    0JP1j8mrNtVaZSEMQ>
X-ME-Received: <xmr:11YVZyinHSas1p2MgJnwQbFw5ashL3h_N4Ii6fZQmRxnWS-XcjaRCQ9HliccMEXFlPhE-Jol6aMKcrAsDPw5Q8rq-Plv8ZRKtzFulFZJQWEGy2NsQntp4rdo2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:11YVZy-IkezmOyv6YsKIDtsT3sHTgCzG3oG4rxHnHunbtGyE_3IRGA>
    <xmx:11YVZ1v66AMvKpIAtPgJJQ_OgxSGuXjmayiGPLrMXpn619QRrCSGqw>
    <xmx:11YVZxH36jGHePGzsLetApV5TGkVgnUDS769g8DpduLyunxlAgqKHQ>
    <xmx:11YVZ8MJTk-Mqc9Dg3tzvFGL3nZ2WkrkP5ygeNue8qGR9kcdh92Xdw>
    <xmx:11YVZ9LN2oiK-uTl3eVqByG7eLEhzoS5Cf-ovD4Vn2IX9kS56uERUtFh>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 15:15:34 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: [PATCH 4/4] =?UTF-8?q?Documentation/git-bundle.txt:=20discuss=20n?= =?UTF-8?q?a=C3=AFve=20backups?=
Date: Sun, 20 Oct 2024 21:15:02 +0200
Message-ID: <63a431537b78e2d84a172b5c837adba6184a1f1b.1729451376.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 63a431537b78e2d84a172b5c837adba6184a1f1b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It might be naïve to think that those who need this education would end
up here in the first place.  But I think it’s good to mention this
high-level concept here on a command which provides a backup strategy.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Correct mention of the section?  All-caps seems to be the convention.

 Documentation/git-bundle.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index cf25e6e8540..b5cc4746b45 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -324,6 +324,20 @@ You can also see what references it offers:
 $ git ls-remote mybundle
 ----------------
 
+DISCUSSION
+----------
+
+A naive way to make a full backup of a repository is to use something to
+the effect of `cp -a <repo> <destination>`.  This is discouraged since
+the repository could be written to during the copy operation.  In turn
+some files at `<destination>` could be corrupted.
+
+This is why it is recommended to use Git tooling for making repository
+backups, either with this command or with e.g. linkgit:git-clone[1].
+
+See also linkgit:gitfaq[1], section "TRANSFERS" for a discussion of the
+problems associated with file syncing across systems.
+
 FILE FORMAT
 -----------
 
-- 
2.46.1.641.g54e7913fcb6

