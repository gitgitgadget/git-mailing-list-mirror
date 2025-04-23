Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A926C3A9
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394517; cv=none; b=YtWujBfZJwDSTpfN7lpvdPvedlscS+v8ulZ19w5DQQ3pGwMZw8v89aYev/QbDOlpv+lVAK675NYpXRkq/f6nmtGYk9IlDuZvzntI70XbtlrLPdbLEz5xDrXvZuwEuIoQDpzgZE3Ws1S0+Zw1XD2XP8sQABQr2ds7V53Ixkddi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394517; c=relaxed/simple;
	bh=slrkkFxbhUbEUYS+PFyqaVpTqu5mFcx70IwVhbFmEeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYQ719u1cjdXkzxVg889ynrIMh+a2kd+1YdejqfzK7qmZMViLNgjpVYrTiiNPrDi7JSWN/ePg4KGK9BaUAtG1T5yh+1lONqowTjwMAj/M0eOpe0n+no+JHL/zUncwoA2evwvzEsPaBPXtEoFwT0R9HbPGG4C03f/wvOWhRtWbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+9MRBCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmQ2MnCT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+9MRBCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmQ2MnCT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B3F011402F0
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 23 Apr 2025 03:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394515;
	 x=1745480915; bh=2NIsQ+MN61S2KePeadISMk75sRLSb7H5z9zQUUl0nJY=; b=
	V+9MRBCnzpiqvXT13kDAcxxP1kk8Xx/vHBp6mrnIsxqVxk7eg7oW/kHXqdglhxLj
	BlAix7f26Zs1GA8ZrPkMzdTWJ/RdcERCp8wUyCMcX/mr1swTuZs1IlbLfvZnEctl
	vHS61OmFbVkZ9ITP89qLk25MZgqs2W5bW8L+bPhifuG7G4j9wla6bcMRyrH75CGw
	52OQp1bLFJYH2Uu5iTY3pf3haVWGSySwmApu/xXX48NLJ+o9HArB3IYdjO8X0IJ0
	Ji4+PXLQCjs7cfMGTddDG54g2A1iDCV80zonaf3yfg+9bgwC5gxievK2LhSa/RNg
	Yv3WnYgXLZjwr8IxbZq8RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394515; x=
	1745480915; bh=2NIsQ+MN61S2KePeadISMk75sRLSb7H5z9zQUUl0nJY=; b=W
	mQ2MnCToFn+Z5Z29fgcIHlGhaY55/sie5H35nv0cTLGBCrK43gE0RabcY5KYJGda
	gzOh6ALFyDLBVaByybTi67FDUzY5Adywuf0i3QKTtoE9zQ1/3XC5Y/67UysEsoLJ
	bUB3vGAqIrJBBDbLN7g4d627yqPEGTDJQFdlcGFCiGIH9tZfZt/GEACroh/3LgKB
	Rjzu0XFsNCi/gIWSJZ032NiIbaTmQmx7Wk1jAdRu9GXzN2lFudkA+re/u1rue7sT
	1tFmai9LCiFNusSS/Fzp+VXfbJ8vW1eCayRBw1qFNYBDppG/aNiGXdGsReQ0Yoi5
	zxkCZh+zEDMjnuxmz7tnw==
X-ME-Sender: <xms:U5sIaB-7lpGeh0kwq6JO0gsKeogVeN5eBsZ5l_TOE1ztRo8JnwYczA>
    <xme:U5sIaFui1RP24d_B0UaOWABmI8CZ4N61d6fp7Ue2BmtmLb3332p3tu-1XpCp2L6zg
    GtBno6d3uMu9Vb7Kg>
X-ME-Received: <xmr:U5sIaPA6GO8-ln2y0nEIke-CdyN8jivsLyBjIqLNyY8Dlxd_CNd8ZjcDDUONhvU04b5RcowwhPr5kKQPeqW9Ln2NT3upmifaqZ9eraVDSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U5sIaFckaEze0FIGt0J_Qr3rF8_MVCAxkReQ7iFoKdjlriKddAvN0Q>
    <xmx:U5sIaGNndUcxTX6KLFfX--hqHEfMrjaYXukGi_sOsgs6ggnsAY945A>
    <xmx:U5sIaHmTCpIUg4uPF4nPpiXDmuaDQWmFZbE12S7gb8I9S3KEz_sgDw>
    <xmx:U5sIaAsSKQMY1YoPb90lpyawhJeeeaTh66OvjsHSdah7JlXHqaMu1Q>
    <xmx:U5sIaNoIO2t4A20QFs048PtX0z2x2KcHiqI9Kdymn0rGu5E7I61wpYLh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc071e6e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:22 +0200
Subject: [PATCH 12/13] bulk-checkin: don't fetch promised objects on write
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-12-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When writing objects via the bulk-checkin subsystem we first try to
figure out whether an object already exists in the repository before we
append it to the packfile. This check uses `repo_has_object_file()`,
which knows to fetch promised objects by default. As such, if we were
about to write an object that is promised, we'd fetch the object via the
promisor and then skip writing it. This behaviour doesn't seem sensible:
it should be significantly faster to take the locally-written object
instead of faulting in objects from the promisor remote.

There is one counter-argument here: it could be that the bulk-checkin
mechanism will end up writing an object to disk whose content collides
with the object in the promisor remote. The local repository and its
promisor remote would now have two objects with different contents but
the same name. But the resulting behaviour would be wrong both when we
prefer the fetched object, and also when prefering the written object:

  - When we prefer the written object we will now see a different world
    compared to everyone else who has the promised object.

  - When we prefer the fetched object we will end up with an object that
    is different compared to what the user just asked us to write. This
    seems even worse compared to the first scenario.

In an ideal world, we would protect against this by fetching the
promised object and then performing a collision check. But this feels
exceedingly expensive and ultimately rather pointless, as more common
writing paths like `write_loose_object()` don't protect against this
scenario either. And in any case we're talking about a local user that
has write access to the repository anyway, so if they want to do any
kind of mischieve they already can.

Change the behaviour so that we don't fault in the object via the
promisor remote. We shouldn't have to worry about hash collisions too
much (yet) as the mechanism is only used during local writes anyway. And
even if there was a collision, prefering local data that we were just
asked to write over data controlled by a potentially untrusted remote
feels like the better failure mode.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index c31c31b18d8..b182c456d69 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -130,7 +130,7 @@ static void flush_batch_fsync(void)
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (repo_has_object_file(the_repository, oid))
+	if (has_object(the_repository, oid, HAS_OBJECT_RECHECK_PACKED))
 		return 1;
 
 	/* Might want to keep the list sorted */

-- 
2.49.0.901.g37484f566f.dirty

