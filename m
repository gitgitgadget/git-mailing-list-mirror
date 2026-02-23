Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3A2EC09B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866568; cv=none; b=PoC9Dt7n6BMlUDK7PZrquhAI2+Dk2Uc+Ty2TGQMZlaGw7eSEIvJmvql7+/h1HH+A8K7KiCW3y3g4o/TFjcb4Jvt2WNjq24M9j6R/7xMQeOoh29N/Ww6I57LTP0xC5WpggGzW1CC5r9DViZbpEU1N197100WfplIfgcesG6CjWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866568; c=relaxed/simple;
	bh=meINWGwytK6pgCPln9/SvcH5S38UVcCrZw+k9gAEkjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UXeQaFHA7Ls0JAwwAERGVEuRw0SGlcmLR9/ZQzmqUhBelhfiuU/bkYkjp9PdZzTVx5Pl8EjInxqhv4W3igYnuXo05HHDQJa8hIYkhXsyctJMyzXKfyCL3HnPv9GMQScdBtxZtglv5GYWwhisgHIWqOdbDBuIxqZM6yZ19BYy//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mWvYX0wM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgMTkvMf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mWvYX0wM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgMTkvMf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D32BEC0013;
	Mon, 23 Feb 2026 12:09:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 12:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1771866563; x=1771952963; bh=X8
	rH3HzBSQYmcxkkjKzLFoZIJf0jgLf7mnOHqy/tfPo=; b=mWvYX0wMxxhTw1YECp
	FuYG8RXWySpiAV1mvXoHDUeyWFrqt8OSCjH/sktmWrdKBRqYgE465vMY1eEDaF0+
	Ay4ns0Usy5+CEpwFQUrtbVNYzRkdFqYwO18a+8QKMs+t/CQqpJ+yxHsS3qCTzK5x
	zJQA7LITR8OlPKrSEFWlWJBfbvILtr90iBMyUHZuKsjvtAZFqeMnxswS6RT9QV0M
	h6aKg4HSo+66QVCgcVuNtp9nvX7C3cTUOrYehkRbo+HYfBAZcW6cs3FK9ZMquPnN
	+GIYHgLfvMl/I24NqbHZqkatKf8b3w680wtP4TE24C4kbUp4oVTRxfTJpPtT2h14
	GpJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771866563; x=1771952963; bh=X8rH3HzBSQYmcxkkjKzLFoZIJf0j
	gLf7mnOHqy/tfPo=; b=BgMTkvMftN6+kPImLVqCsvbQH3yvoYeog8OPgfI+rZ6o
	PTb+GbBU6AEwSMAzjNOexGmcQ/nARa8TC/hg2h+z1KO2Oe+RrrVhTtlcbzWTYLAA
	lyljuWtCydWvAFeGi2rhXnvLet/YpH8pnXXKSi8ZtQXHrgFdgTlwYrX+kd2HrClJ
	6yDZAV9H6P+whCbOMSF4AgA4F0wIu2DKk4tKolTXreBshdsBtEvPCH63kDCjw908
	V2YilIhybsHzg0qTiQgQm5OSDj7TTyn0+isxtJLrjfxzg/c3hsK/YjP1WluFkYl4
	5fu+9qTqAm4GoSOZ2ps0nc1mItc9jiCpvCwn4uKLEw==
X-ME-Sender: <xms:w4mcaR5syfHSqH2hUG6F6Psju-6qOGdUp275fht9p-gUwK676YMIx9k>
    <xme:w4mcaRIBXJiVRuSyPbfwPAr297ZOkYb0TA7HXTCPDFZ8aqQFp9qFurO4SfN2CMmBs
    QaFGl2bp4fO9PBYZ4C7zOgYgmiHFTNmKCcR6US-JHtubL_V6MKLaA>
X-ME-Received: <xmr:w4mcaat8_gvn4j7PDcYcgO5Rp7ORAXT7Q7yDGuY8pV_e6JVJbkAA1VvmyRmEwY0J7_zp8GS1hc8EchnNW9Ay9Ql-GicXKX_dBHwP_VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepheelhefhie
    euheejveeftdfgiedtueevhfdugedvheekvedvuedtueeffeeigeevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrght
    rghnsehjohhnthgvshdrphgrghgvpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvpdhrtghpthhtohepsggvnhhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:w4mcaQIlsIUGtEiYNX06dzSf2Yu5bRiWTqIdyGKIaGmTmE7-KARjuA>
    <xmx:w4mcaT9izE4Impm6zkZKqvsFQVsyPy3EdVMa_njzZ7JFmlcilXUvhw>
    <xmx:w4mcaZzOq7NM_PRRRHSlzzgwff_XmPI-PO3tbS7wvjr-wYU_xcPWew>
    <xmx:w4mcaQ58cQ9XMUIF7edEckSWbtAXEH-sp3pX-6LLA-cNwzNIQr8dQQ>
    <xmx:w4mcaedOBLeVKsbXY5R75gQHGIuVLN8TdDHEF2mwwwgQ_PXdYEZInqnw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 12:09:21 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org,
	jonatan@jontes.page
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	benknoble@gmail.com,
	gitster@pobox.com,
	peff@peff.net,
	sandals@crustytoothpaste.net
Subject: [PATCH v7 5/4] doc: config: fix list continuation in alias section
Date: Mon, 23 Feb 2026 18:09:00 +0100
Message-ID: <followup-alias-i18n.3e0@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

ac1f12a9 (alias: support non-alphanumeric names via subsection syntax,
2026-02-18) did not use list continuation for this code block[1] which
means that the block ends after it. In turn the paragraph starting with
`git last` goes to the outer block and the next paragraphs are not
continued properly.

We can simply add list continuation right before and after the code
block. Let’s of course do that, but let’s also change to use a non-
indented code block (----) in line with the preceding configuration
example.

Also use `$ #` for the comment to be consistent with
the terminal prompt.

† 1: From https://lore.kernel.org/git/xmqqqzqqrk2h.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Notes to the maintainer:
    
    This is based on top of jh/alias-i18n (merged to
    `next` on 2026-02-20 at b9a5c15c4f).
    
    See: https://lore.kernel.org/git/112cccfd-ee04-4c23-bc5e-fd269ebc6c1f@app.fastmail.com/#t

 Documentation/config/alias.adoc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 115fdbb1e3f..dc04b0b4bfe 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -30,11 +30,13 @@ Examples:
 ----
 +
 With a Git alias defined, e.g.,
-
-    $ git config --global alias.last "cat-file commit HEAD"
-    # Which is equivalent to
-    $ git config --global alias.last.command "cat-file commit HEAD"
-
++
+----
+$ git config --global alias.last "cat-file commit HEAD"
+$ # Which is equivalent to
+$ git config --global alias.last.command "cat-file commit HEAD"
+----
++
 `git last` is equivalent to `git cat-file commit HEAD`. To avoid
 confusion and troubles with script usage, aliases that
 hide existing Git commands are ignored except for deprecated

base-commit: edd8ad18a643d47dd92b08ab865bf7f4a26f50bc
-- 
2.53.0.26.g2afa8602a26

