Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE79610D
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748725736; cv=none; b=ct2gqT9C/0UYhKqeHWmZtgpkO7f99My6M4+Z/T/6GPoUcTwTFZxDDiBqYjH+AIIqvx2bFTeQFTx1/s6eXpelxvDXTKpKT0YLSca7snaLMhBtOJftg5sRTFCVRzWcd9XZ/3OxjBkkAAX87t6eeAxcCamBm/NNfo6o+LVw0DJK4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748725736; c=relaxed/simple;
	bh=NAQdLz9FQ8aV23TCKwufkkOf/q9NmyfjfBcXxbDfZHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZEYlrYr7a2C+xJViQyu/gruUlqmRg2eD1gyswPYDLVMHqzzPFe70TQ33hzSm47dyj+39UNogELyrKIGnXhy9LZh9e6DrvxdQvyenCferuc6KY4XjZSxrc25qOmE7fmJ/ybe831pTUx+HD6LKWYAZEZbF7qGZ3qAbrmj709W5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KOVqHxIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DstgXmNo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KOVqHxIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DstgXmNo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C016D1380360;
	Sat, 31 May 2025 17:08:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 31 May 2025 17:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1748725732; x=1748812132; bh=Ro
	Gzl/LVC4//yg/0iaIHgQ04+dx4j+caktDF2uw2ewE=; b=KOVqHxInvkMqitKMli
	9O8qxnc9ie0g8crIj25VKuW5mHDlrMgy2pmO70grdnMV7Wz11kF3Sq20UwEdyxNY
	8rq0ivwKY1V3xUFA0zRuBap6qeXvVTJNgPKnaf0fP+oJaRzZsNKT7nDZTFdvD8fj
	N53I/e4461e0C2OhtV8P4uXcCty2YXrULET6GataPVUOK3OOeTIiVHKfCZnvIIf+
	HWYsQHEIVbSqGCQHJc8/KXdyxwR6darN0inYjVHE4CEMZEqKqPuL7WGXs0FSVLnY
	rhVc+Tl/SNKfNgnMsbqT+kuQTK63kB4FATnwyyjwnjBcONe1LJyw+HhWPiWHdJCL
	jOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748725732; x=1748812132; bh=RoGzl/LVC4//yg/0iaIHgQ04+dx4
	j+caktDF2uw2ewE=; b=DstgXmNopInFxM2HCuoimoL16FT+qm5sw8MXisCC+0AK
	AjsJttyGoKQQgpJFBp7x/rV48AhNHzZPDuDOg/jctygnMaiJTlSXaBm/yeaGQSSj
	t//ihdTPpdy6b5L1TTSAj+eozYCmrwgwF9s9uKxKB5hDqDNPkJ948ZvzHVAtWOAr
	1j0y74ZWwFOZiqL4v/rVzYs6tcnMStl2DWIlOLZD3NK93GZfYihT4QBWzGM22bLp
	IMGFqCwyVoME3yylzIC1GepWg0gYbuQAL7GP9tZ3F/a8fHUC2atVqCQ2HyWezpMe
	aPOmjDPOSFtVBQa+L6wXWk0N8F/XUZp1VOp544e+lA==
X-ME-Sender: <xms:5G87aOlDmqw5BfC6QqSQQAHL-Vpgg-g0siTj-y2NhCygE9EZWZE6890>
    <xme:5G87aF1cdAcPsbVHl3JFdjm9GtOhv8JSPSmkKjb_xy9TbxS_cBadzwxd_MLq3lELj
    xJIFMVFEGPmc-75Vw>
X-ME-Received: <xmr:5G87aMo5o3otE6_PaksGTkr83Na4SXNEVxtHaWGyxYEqir262yWlxyIGICEFCoFlS53l38Jr1lQleZUQxf5dObEQUlx0eh_KPfClUg_QYalJnfwIoh1y36nX5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefvdelheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    gggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeef
    ffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:5G87aCmDhpQW-hCiUmbOywIBN7NH5XQGwDGpVnJ2kgMo4h_3TAykxg>
    <xmx:5G87aM1yLMtF6VklmHWQKKAy34F6m9UjBDTo5VddgIxLnacyJcE4ew>
    <xmx:5G87aJur84z5w6FMwxgqZaRY3lqC5i6MXwteucAitL3ZOjv9ef_UYw>
    <xmx:5G87aIXkbv91ocBgiIrODwcgdGV-8U65HvFartY6OwwlJ50O6CRujw>
    <xmx:5G87aNLVc3kIQz_2Xo40E_wNNmI3uA1Y-I9I1RuQRucKb8008_xOFZmN>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 May 2025 17:08:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: column: fix blank lines before block delimiters
Date: Sat, 31 May 2025 23:08:09 +0200
Message-ID: <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

227c4f33a03 (doc: add a blank line around block delimiters,
2025-03-09) added blank lines around block delimiters as a
defensive measure.  For each block you had to mind the con-
text (like the commit says):

• Top-level: just add blank lines
• Block: use list continuation (+)

But list continuation was used here at the top level, which
results in literal `+` in the output formats.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-column.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-column.adoc b/Documentation/git-column.adoc
index 5a4f2b6fde9..8e0047214dc 100644
--- a/Documentation/git-column.adoc
+++ b/Documentation/git-column.adoc
@@ -50,7 +50,7 @@ EXAMPLES
 --------
 
 Format data by columns:
-+
+
 ------------
 $ seq 1 24 | git column --mode=column --padding=5
 1      4      7      10     13     16     19     22
@@ -59,7 +59,7 @@ $ seq 1 24 | git column --mode=column --padding=5
 ------------
 
 Format data by rows:
-+
+
 ------------
 $ seq 1 21 | git column --mode=row --padding=5
 1      2      3      4      5      6      7
@@ -68,7 +68,7 @@ $ seq 1 21 | git column --mode=row --padding=5
 ------------
 
 List some tags in a table with unequal column widths:
-+
+
 ------------
 $ git tag --list 'v2.4.*' --column=row,dense
 v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
2.50.0.rc0.46.g7014b55638d

