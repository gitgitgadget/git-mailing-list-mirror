Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE582D4B5F
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875275; cv=none; b=s6bKwjTL6WlJufQjDvRPbCd4X0JhZ6Y72oPCzmFt55IrS/a7i0PD/1d0jynPZbReO5rBi4bbV1XkfrYqc2KRsywIU2dZpbRAlCD/oxAf+MQPIDWkdSjP1SvOKrGzcQJq6XyiYb5mT9+d7DuPl8MDgJOju9A9XisaRGOw+JQwxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875275; c=relaxed/simple;
	bh=7WpihuV3jC53yTIGZMXQZ1E6QLZX61X1EmLQuHFQYfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qN38nMRsRF9vsBQeOIKnXyD1I9mpT3fRc+r4aT8L7kUQQhv1JHCm+q3cwNJ1zwets8zVKoIMbrEaQLhbU38m0pK/bH4LBVVvB5Hu4js7HlbX9ZS6deGuTstjj4UbHn9K7PoGlGfMZERUGCliaNq1aI2IucbTg6jkt9oZR8SljXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i80UR1R+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kscDef1U; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i80UR1R+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kscDef1U"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FF1414003FD;
	Wed,  3 Sep 2025 00:54:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 00:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756875271;
	 x=1756961671; bh=KqEL9O9JnZetul+4pZmqPGfzdOl9OZUrafNCEGJvc4Q=; b=
	i80UR1R+chVDBBlPvkiBIhTK57Mry+1s1wyuaLLXe/ZjmgBirejveDiewwRIMXtl
	y1q+6BoxVaSEJQrfKftSsHnuX2z37HiC53HBVfmzSp35vL5FLoA4yff053ZYRDWH
	3ub5FjEhGOe/z9BoayIJ+S/DZOdoW0HsXEODLqC9qRw+UWNK33lSH/eBpf0zblGn
	uw17W0IfvJiyQSDv6pB8U95hV6iDuO81kY78VB2yZKLViRrEq3C76JMNLc60ag/S
	9ne/RY+n0Yjik0Oc5Yx9QCapFwGamJyUNhurqg0KxZz3q2AC5vDfu5ZWu9kAIX+/
	iU5PYmKLxJB6Tvbj+yhBqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756875271; x=
	1756961671; bh=KqEL9O9JnZetul+4pZmqPGfzdOl9OZUrafNCEGJvc4Q=; b=k
	scDef1UoJu6+9TuWY7alfdWjpnwT2+elOM/AqEKAkzXoFmpdxYjKgj6Wa2Tryg4p
	A64w7ZTjLEGcJM8cVa5mzXDPelEVaYS/YwwARgYg0LnhiHF4fdgiHJrebQNig2AM
	wkusgjy4fK/8BKFUDgdqlugeUpkBFvlF3VaVtA/3VD1UTba6swbgAo0vnjEmA2gX
	pXEE42clKptQ2beD/ghdEJP7FuQTFHvG6RR9i8obLqhrHXSMzE7QjZt+7uLPZgZR
	WH1dL8jBoIslgbrw4WkKYPz4B/Inn4oP1KJScWXrF+joJVYeGWWmJpdLVnAl9EXu
	QErvygoRCUuhHj6XkYFVw==
X-ME-Sender: <xms:B8q3aHPjWwHia28ebDPmvKwA8Hsdal1xyZeh8myCUfpg2v7T0f9FeQ>
    <xme:B8q3aMg3Z_j5R44-YL7y2XE-Mr6kWsJOYZQKufXp-YyXelU-ZdJZyvmEzzzxLht1D
    afN2_SOsraoPdwXzQ>
X-ME-Received: <xmr:B8q3aC1-kDXS_V_m1GYL6ok3wLRjLrwnlEHanVvd7Sf84MpbYCpPDHpRGbIaZmXx4NJwOfQhJoN7XPEPj_GT-2uJomJpks2u8yR3XJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:B8q3aOhcn6SMdXxKSuy9xYV2AmzJzm86cH-CV4WFLYzmxp_1Ke8fSw>
    <xmx:B8q3aKdMyWkwM82bPqyaiR4JLTGoaaQCcMvEdUxoVHQFZcoDrKz9sQ>
    <xmx:B8q3aJnAculaUcGveqmMrO5dHfFoF_AE0cTb3RyfmixCizlrtm61Ew>
    <xmx:B8q3aLtdHtWIWCQXcUCHrtiWUtk9K7U4_2wpc-v_KRqGq-PuBxSP6Q>
    <xmx:B8q3aDdGzX2wB9gPXsWkCSWyF12N_m-M1bj047Pr13SUievAYxXaPFLb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 00:54:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5af4d19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 04:54:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Sep 2025 06:54:11 +0200
Subject: [PATCH 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-2-4e019af4dddc@pks.im>
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
In-Reply-To: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
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
index 4f26f6afc7..fba3e339e2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -476,20 +476,21 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 
 static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid)
 {
-	int we_knew_they_have = 0;
 	struct object *o = parse_object_with_flags(the_repository, oid,
 						   PARSE_OBJECT_SKIP_HASH_CHECK |
 						   PARSE_OBJECT_DISCARD_TREE);
 
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
+
+	if (o->flags & THEY_HAVE)
+		return 0;
+	o->flags |= THEY_HAVE;
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
@@ -497,11 +498,9 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 		     parents = parents->next)
 			parents->item->object.flags |= THEY_HAVE;
 	}
-	if (!we_knew_they_have) {
-		add_object_array(o, NULL, &data->have_obj);
-		return 1;
-	}
-	return 0;
+
+	add_object_array(o, NULL, &data->have_obj);
+	return 1;
 }
 
 static int got_oid(struct upload_pack_data *data,

-- 
2.51.0.384.g4c02a37b29.dirty

