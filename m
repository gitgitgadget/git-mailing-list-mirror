Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047E236A88
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564952; cv=none; b=AVkMN67x0PDc/NmiSfcwaBYNeZ3ZKZRsT6lUeN5RxW2nizLyPKqvtic99Es8uO6NJ9EAp4w5lSGZkQREe2vtU4ilrNdvARpyI5bcRs6ICfpXQ8no0MkDPdIl9CC1lnW3YVjuz8g9H3oFjz2/YEIGaSUFQKlmIHUH2KUXzb4zHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564952; c=relaxed/simple;
	bh=slrkkFxbhUbEUYS+PFyqaVpTqu5mFcx70IwVhbFmEeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFZMX3fvXW8eCEUfTc8rNh2tkftyGto0hJzvhy7wgNt/QLj2oT2ryaWnKWjiklpjZHBd1TS/01gAw6TC0YNb3fHcmbOnT7bg/4P/tZGBHX1v+HeOlmTsb0REBGIlgtOHJDp9yxsz6sb/epXfhdhsOyvGANb8xg2YpCdZmAhHUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GA86EBWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITWP4Yar; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GA86EBWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITWP4Yar"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63AC111401EC;
	Fri, 25 Apr 2025 03:09:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564949;
	 x=1745651349; bh=2NIsQ+MN61S2KePeadISMk75sRLSb7H5z9zQUUl0nJY=; b=
	GA86EBWuVNaFkLWNIlkpbGLXnYXznwXg+OdO3arWi10ec8EBkWE4xSlecKQWKcCQ
	GpSqfsASuvfU0CuTQf6oNC71XSjdEjytv3so4IRPgzU0VuITWcCIPdnzQfwJ4oH/
	mZlivYRgDcBRaw+ZZBF309vKzl3cDsxJZ3JBE0COobqVol8FZXjp4+lAOaJz/kxm
	r3eudBl55yzEea5Omd1ajuFPbLZm4hjMOFtJjHnIYhrFqk0Lv4fktcB4xb+CY2P7
	BwBmsJDZEim7hHrJzxjR3jOA+FMq2zrBK5M3oLBwqHpHki6bsBTOb2byDq9e+0kG
	EXfou91E0REhlblEQBU4tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564949; x=
	1745651349; bh=2NIsQ+MN61S2KePeadISMk75sRLSb7H5z9zQUUl0nJY=; b=I
	TWP4YarVQyybV4uEgXibWFmUvxXwSdXaMKFozZ642Gkqc+85xrc6ENpFdMWbtKfZ
	QGZtyawN1fhBFvKZHG07mKHk9IfmEwJGEY4VecX6xoQCsBLfFcjRgK5p1M20xJBR
	Zwt+I8Ekje+/A6AaW2PnIkKKKgf3RPYNXdxFCIwMgtrOJMZ1A8JwbnMPleqtmPvG
	MeDzcxXz9LZhD0Nf3/FCuDCjBwY4lnR5URZhmlpkdQfxqlGKrFAABdIHZU/5ZC0b
	rbTdXSCyHNeOu/2kLb9hg6w14R9/P7fJcqVQ3eN4GwjSIUl5cRjoiUY/l/yQdQBt
	pQ/5JLJfVKdZdo1mLfeHw==
X-ME-Sender: <xms:FTULaFaC4Z2J6PWCj7ZMIaBJjmUBbQ9gB7TkiyRG9VRWkcXwAtXr7w>
    <xme:FTULaMbeW9d8NjOsXuvk5RBErjz3GXOwWEZFjZzXcJ8AW-lSAn6uCLoXuAYfB-Z24
    Bx3ye1Ih3S3V2LVvg>
X-ME-Received: <xmr:FTULaH8WLEYTUIFM2Fe_FNONsCFf6AXQ2LfT-VIww1HkZb-eFCVVllXv4SisgSupz53Qkz0L25kS7Sras49z4C56Vq8ebJrDAr2Ewnb2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FTULaDoa86BmOR69qkRcmdMsBoswLFGC-86-1s2TGKBtBYJ2CbxJ0Q>
    <xmx:FTULaAoLzqb9Zlia21abeKIntkDS9PQ6Nxr9o8EVbr-oB0g1qbWEvg>
    <xmx:FTULaJRLxH0IzhXW-ONgSkzZdQo1-UoEq1HonT75K4_9f9Srr-qxgQ>
    <xmx:FTULaIq3iF9oXCDdsVxi79m1xHdnVfTndBL5gMK2FMMBnaEgGOkMJw>
    <xmx:FTULaIENmX293tQxNBMQ_SI3zmeYMAOh7StTv2SpwApv0O1laBIp2njb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc3db023 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:09:03 +0200
Subject: [PATCH v2 12/13] bulk-checkin: don't fetch promised objects on
 write
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-12-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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

