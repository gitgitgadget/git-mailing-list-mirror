Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43D24113D
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924404; cv=none; b=CJFLzgIW1jyxv8PAptOlniCvYifZdzKmSNujNuqpDX6MFYlu07s4o1P+D2NWSVc+98bhItUj/HtrS/8uj3gOpzdLaQT+ylmFD8nmJThj153f8zb/0d2btWvCCpKHSzqYYfjPMg916JcCqDPt8ASpTzmjRJXz9jmjMZ0JLHhk4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924404; c=relaxed/simple;
	bh=nujd1m8TWoH1+O7Fs0fo/RjsUkjjW9BhHdKmY2fHDTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oC56mhAW+1LY2EgAoU3yevgjky3IsXUaL7RGxWc7fg9txI2j+Ccpox/W/QbhSwAOQ1B/BXYzKr0mnpkdEGaXzBGBQNj1q1dTc70762hzWD9NiBJspxf5sOT+jDAE/4bW81ETnpJk4SNEYpozya6+7chwqBztUwgwMoNkvyr3AAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJnQRGiN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i78JLeZf; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJnQRGiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i78JLeZf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FBE31D000AE;
	Sun, 23 Nov 2025 13:59:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Nov 2025 13:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924399;
	 x=1764010799; bh=zrJK914hr3BgMV5VMI7AuCw2+0jEvRW5hISl+iJ4bLk=; b=
	OJnQRGiNZpXCv2UO2X42hqsDSnj08KOQ8yuJ+RGtTBsDZZZtNub9FPMnOorVSiDS
	B7+Pf1z9MFMhPm8jWGSBF35j5IGlQsVw0i9tMdA4WiSKm1VVu3Yl4vGcQhXbqGOK
	ci8d01bGEbLTIdHc+TlAnRGoirPrBNfEl7JvZuF5U+NIIs24GHz98xwDmgndjZ5U
	nmPD4ELJW1cVFJtxjxrij+2u37kz/ydzHjVeaiA7UHQv6OSdIprFS7X4l1QW8yeT
	zjWGozCTDKTwy3EXfcJxRdbbfm+lkgUSEi1O3Hh919QDgs1nHLrr5ryRn7qFz6QM
	BZKHuw2MvSH7qyUm0zWp0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924399; x=
	1764010799; bh=zrJK914hr3BgMV5VMI7AuCw2+0jEvRW5hISl+iJ4bLk=; b=i
	78JLeZfJxaH+he3ZZOU1Rc5F2rimtCpOfxQm4kyJb5JcXlye94guJY/p36VhR4Oi
	jxvz5pP5AmkUU/dWh3Inm5DBHgTdEjcZBAwG3ZT/RP7koBLlSAfUEp9JXYUGvfC2
	kAPW6FCPp4ZCG6RDByzDNtJOvXN33XWgo/wThbFdC2xRC1thhePG2mpr+5GwfSCN
	KL8HgYKO4O9Uz+/j+l90iS/DMmZbXfijNohbUq/HFkLwrwRcH1Km7uK+r/9pPqs7
	UMleYew1/S29GgyG/Jnxw5PH179u9vNKLNSQjqXWZyULJm3vOfVd+nXYR8VPrvac
	qv7tdWVUZXDpsyHCGIKhQ==
X-ME-Sender: <xms:r1kjabGxgmTjHeqaRnKCdHmX_0KLGOCAOnsiKnYYqO-EoO_2ToqaGQ>
    <xme:r1kjafVupecvWIeqzyHgI__Gtda2sAYAytvjVtTLTqAJdxpSs_ofyWF_1MM9e_Zzr
    _ZvwSr8kU6QXJyBMrUi60u-9A321bny2WfBPIP32EF4XnnYh1tmdXI>
X-ME-Received: <xmr:r1kjaSJq5nCfvvgBH7xMdQWi5eqcA4RxcP1sokk4FT1dWeUBZAUteK7O2HVBAZThg4LLyke0nSpNGK4Sq7WG0VjfUwMsWVczy36Iq9kIOmx6XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:r1kjaX_K7UFnSiN_2WQ1oQrJLwQ_i0YL0uv39L1-JCAzazUZkHWgSA>
    <xmx:r1kjadKHgjIMoggZ7GV5qqdtUiyW2HMagaCRH8g9jVnSrw_OvT8rQg>
    <xmx:r1kjaUnOyGeJ45GmyTz37sY4erauVIZknfVcQQKuF42zDXgZa8E2rA>
    <xmx:r1kjaZN-DJv2J6E_qwoFTcE7G3wUsNcFXNbQE2q6zCVvxh6MdIVqQg>
    <xmx:r1kjadrOhMBj9QMIzY6nqWcayczzQfLV7DEWvhjeSNmiZQhTx-vurTNd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8993600f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:29 +0100
Subject: [PATCH v3 04/19] streaming: explicitly pass packfile info when
 streaming a packed object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-4-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When streaming a packed object we first populate the stream with
information about the pack that contains the object before calling
`open_istream_pack_non_delta()`. This is done because we have already
looked up both the pack and the object's offset, so it would be a waste
of time to look up this information again.

But the way this is done makes for a somewhat awkward calling interface,
as the caller now needs to be aware of how exactly the function itself
behaves.

Refactor the code so that we instead explicitly pass the packfile info
into `open_istream_pack_non_delta()`. This makes the calling convention
explicit, but more importantly this allows us to refactor the function
so that it becomes its responsibility to allocate the stream itself in a
subsequent patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/streaming.c b/streaming.c
index 665624ddc0..bf277daadd 100644
--- a/streaming.c
+++ b/streaming.c
@@ -340,16 +340,18 @@ static int close_istream_pack_non_delta(struct odb_read_stream *st)
 
 static int open_istream_pack_non_delta(struct odb_read_stream *st,
 				       struct repository *r UNUSED,
-				       const struct object_id *oid UNUSED)
+				       const struct object_id *oid UNUSED,
+				       struct packed_git *pack,
+				       off_t offset)
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
 
 	window = NULL;
 
-	in_pack_type = unpack_object_header(st->u.in_pack.pack,
+	in_pack_type = unpack_object_header(pack,
 					    &window,
-					    &st->u.in_pack.pos,
+					    &offset,
 					    &st->size);
 	unuse_pack(&window);
 	switch (in_pack_type) {
@@ -365,6 +367,8 @@ static int open_istream_pack_non_delta(struct odb_read_stream *st,
 	st->z_state = z_unused;
 	st->close = close_istream_pack_non_delta;
 	st->read = read_istream_pack_non_delta;
+	st->u.in_pack.pack = pack;
+	st->u.in_pack.pos = offset;
 
 	return 0;
 }
@@ -436,14 +440,10 @@ static int istream_source(struct odb_read_stream *st,
 		return 0;
 	case OI_PACKED:
 		if (oi.u.packed.is_delta ||
-		    repo_settings_get_big_file_threshold(the_repository) >= size)
+		    repo_settings_get_big_file_threshold(the_repository) >= size ||
+		    open_istream_pack_non_delta(st, r, oid, oi.u.packed.pack,
+						oi.u.packed.offset) < 0)
 			break;
-
-		st->u.in_pack.pack = oi.u.packed.pack;
-		st->u.in_pack.pos = oi.u.packed.offset;
-		if (open_istream_pack_non_delta(st, r, oid) < 0)
-			break;
-
 		return 0;
 	default:
 		break;

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

