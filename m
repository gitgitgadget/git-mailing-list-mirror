Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE871922D9
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368030; cv=none; b=GJbe9IFLqJCSSy8EP3t4u3GTBuNjvB63J+iXG5yCrp/ta/mbqjiqv0HtVd/+MX5Wn1R5qZJMsOAnjcjjHmLU1q0Fi78XjM9kLaeQrwgeLjGfJZuUrhtVZnyQk9R1zBCWA4LX9feR1Bq49ymOKQBHxBlnmMTpVp/mAx7/B0msWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368030; c=relaxed/simple;
	bh=CrPBbdyObAwKKRed52XrPZSUew5aoYGYz5S5H5y+hE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByeA4dmcekWktqp8QIPlOx5OlgwsbyCynjV7O+S5Zoh6e547S3nBalq5GRmSC97U8P3y7xfRGnqPirifL20KzyQ3UrcPiprqpsewsaa61I7JhncCRpuopBJlkhfRKknFbosB5iGbI+6iyIgy5F07HrSOq1H9BBGlRDS/tgqyKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pC6+XzGL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PgLGdXqR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pC6+XzGL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgLGdXqR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98159254008D;
	Sat, 19 Oct 2024 16:00:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 19 Oct 2024 16:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729368027;
	 x=1729454427; bh=0aV/4BQF6BTXIVmGBI12bxjAlGPPQrqMqF6P1oS5tK8=; b=
	pC6+XzGLK4QLp95i7E/4LpM7dlsOzTySXpYhhH/lhHWAMWAKsi8RtPu9CKmJxmFj
	7A9aEBk0/7AnMULUgKdwm3CHiXVLh/wCG2S2+MCXjcGwJKr2LPFEXfm702qvbhSc
	vlf50vUmW59DW59P9cvUOA0/4ij5dSMUB0HbxYWjeKcfmQyh2su2rDUnomziESqs
	R1tU5+7p2K4SoV3T7f7/PBUf3EWWVYzHHE6VGhivVXpMzNfEWHyhPeqFl2mQKcAp
	dpY1bM8+81T0+8QV5Dh+X1VNOGwrxDM6bCxxO/ywXUMdnTbxe+pG7mWZHVOPNnLE
	t1Hmd9whhnHdT6NeYDDZIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368027; x=
	1729454427; bh=0aV/4BQF6BTXIVmGBI12bxjAlGPPQrqMqF6P1oS5tK8=; b=P
	gLGdXqRs98MvN+RhtHZWd7RjGrKEdWogNj8chYtl21gNxE+qvZl8G1CKSmGyoMQ4
	MfVGuh3c9eCag7k9gnBGGTzZzk5yuKbfL4noeuKH+57G2mHQlf6A4rxXs+9pgoY6
	MH+2rYfXRRYjqFOdVbOy7WGHqRaf/Lx5XY63l0X9uge+G/VZB2So0uWKVUhRyUC1
	Kx4/8+5JRb8RUqPh9WqBZ9GGuuBjsevSFgs5BQfytw9gcY5IoWvPZQN70pgU4/H1
	0/D3Q4R3mX/5x1rjNKgplGHtCDRxqPjQ7skWtAs17CDgp+AjexcXKJj7QymXQ/w+
	w6eepFzGuwPVdo020GQlA==
X-ME-Sender: <xms:2w8UZ6wr9MOtu0LOId_co5gvYoag1zOORaBZXw3gsyC7DznfhCiKS5w>
    <xme:2w8UZ2Q8uYDT59h0FeZrdPUxWYT1KTJ3KOpJAwI55HOHzKDhI-75G7OSMJbZd_kKU
    uNZKHQkhSRSBRAYQg>
X-ME-Received: <xmr:2w8UZ8XmsJYDMv30nIVRRdlLCYiHuT0uDo6WbEcW6MNiON2SUGixwFlqHcBAc8FDDaZXPkO7jDJmtChqsOeuzU2FOiKxogBV8Qc8ceM07WvWH05pfnuG8ekmkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:2w8UZwisJvHg8MXToxrMMO14y55suu9-mtkP2nzrZBVsnzjPyhCymg>
    <xmx:2w8UZ8Azqi9HhlFqFEOItxaZ41v1RIkRHqG7A7L8fEmYmjQiHHhHzA>
    <xmx:2w8UZxIl3euXCaZP1wS5S6wk9-3UflJsTIwRR6VosuZ4IinouIArSA>
    <xmx:2w8UZzCGrFenkOU4ebDWyH9pyyWd78TCxtbNpCGS5b9xGvyAZYGeVA>
    <xmx:2w8UZ40Kq02FZFnkhjrywxZ3fgfUVgQZJatpPdF4f_PMWE7Tu07rUNRY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:25 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 4/6] Documentation/git-update-ref.txt: remove confusing paragraph
Date: Sat, 19 Oct 2024 21:59:21 +0200
Message-ID: <769fd20945dad7ec60f1109525466d916afa97a8.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 769fd20945dad7ec60f1109525466d916afa97a8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This paragraph interrupts the flow of the section by going into detail
about what a symbolic ref file is and how it is implemented.  It is not
clear what the purpose is since symbolic refs were already mentioned
prior (“possibly dereferencing the symbolic refs”).  Worse, it can
confuse the reader about what argument can be a symbolic ref since it
just says “it” and not which of the parameters; in turn the reader can
be lead to try `<new-oid>` and then get a confusing error since
update-ref will just say that it is not a valid SHA1.

gitglossary(7) already documents what a symref is, concretely, and quite
well at that.

Reported-by: Bence Ferdinandy <bence@ferdinandy.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: replace “this” with “the”, which avoids two “this” close to
      each other
    • Message: Mention that what a symref is (concretely) is covered
      by gitglossary(7)

 Documentation/git-update-ref.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index c03e65404e8..4bb3389cc7c 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -25,10 +25,6 @@ value is <old-oid>.  You can specify 40 "0" or an empty string
 as <old-oid> to make sure that the ref you are creating does
 not exist.
 
-It also allows a "ref" file to be a symbolic pointer to another
-ref file by starting with the four-byte header sequence of
-"ref:".
-
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-- 
2.46.1.641.g54e7913fcb6

