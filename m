Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258523B62B
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053098; cv=none; b=KWPDmjtfH9JX5K8cFNE8nd+DHXHsvp3MTR+mtEfUzN28/Y7B3jQrMPtHPrBMi3m9z+EdAql/o0pNs4WoasgFCH6N5+SQBZU+PIZ/DRDuTIcNLOixTUhYYkUNt4uo0eAPU8oOoutCC/2ePd3iOLOhvPOdUEJkDHEzTdOXp+w7OUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053098; c=relaxed/simple;
	bh=x3lMpUCouU5kUjao/i72nJBERNoZB9VthKs5UAg829o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBDEZI1RuXI70TRFyPOMjBkb+2d7X5GMYk6ftAWaS7WziLy3CFHiijg6cK4e7QxYiLFhe6NQULswJF+56MmKefm25/8X2o2wLcWVdRj/2AhYILdKwAub1E6y2j/sO/MhPhi9AYF4uH6+rdVk9mN9+bLGwOdqvqgm1VU3owbiwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IrsndHLF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWeQAjcb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IrsndHLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWeQAjcb"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id ECB931D0042B;
	Fri,  5 Sep 2025 02:18:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 05 Sep 2025 02:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757053094;
	 x=1757139494; bh=hexaemvpd2mp7lG96b05bPL4142ArCFwsK4s9dJiIlM=; b=
	IrsndHLF5urm865FPt1gqWCi/fQ2mnVuOfyMGnhCjW9BVFvYaqxuG0tA4gmCNISj
	mTFySgiIFk/aQS7zpsVoDGD+3PwUH/fzo8nCElfUqSDlyxlI1FNFxYZwlFTL4QDH
	3wSeLcNoJKyJCS1U2S5UM5URrIrZgtdVpPcks31wdO0GV3KRqiwZb8yb18BPJ4bV
	TiUnoBXfLDxHhzR032dK1KtESTcPFJk8eoli8Sv1JAnmJX0e78tjWJ4fSc5WtQKJ
	hQzapaq444KDK0WEr9bxxiJbjQXqybSxxHv5bTCZ6zmxJUZiMPuwhwEvQ/X/0oNP
	OB4Trs/BXGJFlpX3RYhC/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757053094; x=
	1757139494; bh=hexaemvpd2mp7lG96b05bPL4142ArCFwsK4s9dJiIlM=; b=l
	WeQAjcbjAKk5BNcr18IDbB7ObL7Al3GFBJdBjV+LeVD6uTo5XpJ7CwL+ElJ0uK+z
	x668lpWbhPm4/Xl3nE1/w3+mWIfDaHZdPQxX5EDnyQE+f4bpKKHUfSUMdLpORxX5
	Ac9/JbnYmLD+qIz0Zn9bGUjj0tJ05lSoZtNyEbCAV9UFHQOI4K1GJZA5fsDvDUf2
	sQclb44SsgqhtWbn3/WllvZZtx7Pnmoth5F6iQXEGAIYiID3Y+P9m00h+7RzDtZs
	RRNC6T2wJe7hV00N9P+ZAdua+rxufZOuVrIoS1ByaeiOHKkPHEuvBR0B4Ss+3Bub
	ELI2WGoVUibC33nkbYv3A==
X-ME-Sender: <xms:poC6aKyjDM9lGUNV9kNmLwEayTVXcmqh0b8UglJnr2XYmd_Sd6_4zA>
    <xme:poC6aA1G6PvOEuZw2c5dbKOlvy8k4qtW-fiGqNEG-aYj66yVorD1lDoUa4NLFt7TU
    iAF-g6ZWTjHPQDBGg>
X-ME-Received: <xmr:poC6aI6P8aM1SIdt8RW2mHTKbtngSNgABFYmJtgaSTqr3EYkvuByf9fLo_DetpaOgufIlmm79jgNig99rO57Q1ILtUpbiFnt6nDzkzqtaQz2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:poC6aDXp_PyiC1ZebRnQDjACmakiAE1nv2RNTyoqoigE4CCrRhbKUA>
    <xmx:poC6aHA3pzJ_7bauF62DzdtsYNgTfwqEJX4Kwfs59FUZEyxwo49n6g>
    <xmx:poC6aC5OLJD8-Z6o9ui1zHoRgu8ASQ0Wfc2WPod6HgJIa6vSKUmWTg>
    <xmx:poC6aCyEr0KPahrZNfEfcV2daeWligJoyz69JZNh2clSHN9QNU3zkw>
    <xmx:poC6aNh6rDkTREp5PZPXlEBuGsIK8BGGgEvAP9CsYFhl5guuIRFrUYRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:18:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6bda9c2b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:18:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 08:18:02 +0200
Subject: [PATCH v2 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-2-d2e67f3cb94c@pks.im>
References: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
In-Reply-To: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When a client performs a fetch or clone they can optionally send "have"
lines to tell the server which objects they already have available
locally. These object IDs are stored by the server in an object array so
that it can remember any objects it doesn't have to include in the pack
sent to the client.

While there isn't any reason to do so, clients are free to send the same
"have" line repeatedly. git-upload-pack(1) already knows to handle this
well: every commit it has seen via a "have" line gets marked with the
`THEY_HAVE` flag, and if such a commit is seen repeatedly we know to not
process it another time. This also has the effect that we only store the
object ID once, only, in the `have_obj` array.

There is an edge case though: if the client sends an object ID that does
not refer to a commit we neither store nor check the `THEY_HAVE` flag.
This means that we repeatedly store the same object ID in our `have_obj`
array, with two consequences:

  - In protocol v2 we deduplicate ACKs for commits, but not for any
    other objects as we send ACKs for every object ID in the `have_obj`
    array.

  - The `have_obj` array can grow in size indefinitely with both
    protocols.

The potentially-more-serious issue is the second one, as we basically
have a way for an adversary to allocate arbitrarily large buffers now.
Ultimately, this doesn't seem to be all that serious though: on my
machine, the growth of that array is at around 4MB/s, and after roughly
five minutes I was only at 1GB RSS. So this is concerning, but only
mildly so.

Fix this bug by storing the `THEY_HAVE` flag independent of the object
type so that we don't store duplicate object IDs in `have_obj` anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5530-upload-pack-error.sh | 39 +++++++++++++++++++++++++++++++++++++++
 upload-pack.c                | 19 +++++++++----------
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 8e505786f1..d40292cfb7 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -96,4 +96,43 @@ test_expect_success 'fetch fails' '
 	test_must_fail git -C foo fetch .. main
 '
 
+test_expect_success 'upload-pack ACKs repeated non-commit objects repeatedly (protocol v0)' '
+	commit_id=$(git rev-parse HEAD) &&
+	tree_id=$(git rev-parse HEAD^{tree}) &&
+	test-tool pkt-line pack >request <<-EOF &&
+	want $commit_id
+	0000
+	have $tree_id
+	have $tree_id
+	0000
+	EOF
+	git upload-pack --stateless-rpc . <request >actual &&
+	depacketize <actual >actual.raw &&
+	grep ^ACK actual.raw >actual.acks &&
+	cat >expect <<-EOF &&
+	ACK $tree_id
+	ACK $tree_id
+	EOF
+	test_cmp expect actual.acks
+'
+
+test_expect_success 'upload-pack ACKs repeated non-commit objects once only (protocol v2)' '
+	commit_id=$(git rev-parse HEAD) &&
+	tree_id=$(git rev-parse HEAD^{tree}) &&
+	test-tool pkt-line pack >request <<-EOF &&
+	command=fetch
+	object-format=$(test_oid algo)
+	0001
+	want $commit_id
+	have $tree_id
+	have $tree_id
+	0000
+	EOF
+	GIT_PROTOCOL=version=2 git upload-pack . <request >actual &&
+	depacketize <actual >actual.raw &&
+	grep ^ACK actual.raw >actual.acks &&
+	echo "ACK $tree_id" >expect &&
+	test_cmp expect actual.acks
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 4f26f6afc7..9b9b149068 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -476,20 +476,17 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 
 static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid)
 {
-	int we_knew_they_have = 0;
 	struct object *o = parse_object_with_flags(the_repository, oid,
 						   PARSE_OBJECT_SKIP_HASH_CHECK |
 						   PARSE_OBJECT_DISCARD_TREE);
 
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
+
 	if (o->type == OBJ_COMMIT) {
 		struct commit_list *parents;
 		struct commit *commit = (struct commit *)o;
-		if (o->flags & THEY_HAVE)
-			we_knew_they_have = 1;
-		else
-			o->flags |= THEY_HAVE;
+
 		if (!data->oldest_have || (commit->date < data->oldest_have))
 			data->oldest_have = commit->date;
 		for (parents = commit->parents;
@@ -497,11 +494,13 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 		     parents = parents->next)
 			parents->item->object.flags |= THEY_HAVE;
 	}
-	if (!we_knew_they_have) {
-		add_object_array(o, NULL, &data->have_obj);
-		return 1;
-	}
-	return 0;
+
+	if (o->flags & THEY_HAVE)
+		return 0;
+	o->flags |= THEY_HAVE;
+
+	add_object_array(o, NULL, &data->have_obj);
+	return 1;
 }
 
 static int got_oid(struct upload_pack_data *data,

-- 
2.51.0.417.g1ba7204a04.dirty

