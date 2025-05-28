Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7421CC61
	for <git@vger.kernel.org>; Wed, 28 May 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435064; cv=none; b=sHwNAY9W+WirvWLXm2qQGCL3vrJrxHPSubN/r8ZoltVCkNWAIRtQcc4CA1QlTbJE7LNkzwa0FzotWo6mfUJsnMQPCwizQy+iNgux/MR4V4bXjHrO3BWyA8/S4KvOFqssBlYRZ0eV9nbv5WlQEczePoOPN0YSNXK30F26loblYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435064; c=relaxed/simple;
	bh=/Vh8y6nDxHQ/wOEy+1/N4R3n55W6qAy+XDVXtXlHBkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XR5RugiRXqIj/qpXGjZRwVwjf+izMlvzcHp0a0smachcFQESsMvOriTtxhAvT86r3e1KUJKYFjZ2yfFhODOd3ALIHO4ID5etTBsg6lo1bIKs7LDdd1rzjjMvLk/KPj6u8aUFaVAoGygin8OgicLsgfALjVDYj99TQEQ9+10vpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wd0TfL35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYJ5GVCq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wd0TfL35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYJ5GVCq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 436D41140108;
	Wed, 28 May 2025 08:24:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 28 May 2025 08:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748435061;
	 x=1748521461; bh=pyxzODNfB9iqifH9ntWB0tovhAyambwG0s4ZwLj4mi4=; b=
	Wd0TfL35v1F+TZwi6E61jzmPh7qdwJTyerwQRD2eUvZn3ChiMtW1IVN7IqNKtBxf
	QiW9gksQaBwXQh1XrHjX8HL/7la8g6A4RKAIfc51WjIsC/hInsHjn5xB65JEj2pI
	r5ETI/94WE5oNJYHWr7cw0x7zuZNzzqla+YcizMzc2/5Hsfr4cuAbj4RP+iD1S5P
	Vh0morLFSu8Pcc2816K+n11DI7nFy5NuWyHVB3RLSCOKyLiVEYeANrlHHsXDYsaz
	2uRl9gkpIJQnYj1kG/ehl9XN3U0fYpTggherGpeb3R+Fy9MAkxkQyvsBcxftqS7x
	7IJKzxgZnE3YaZVkFIOVKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748435061; x=
	1748521461; bh=pyxzODNfB9iqifH9ntWB0tovhAyambwG0s4ZwLj4mi4=; b=R
	YJ5GVCq2cqmxFs7pl/i7vRBx0Cd6eyvCtptn7j9J39R1prMH+bJHHeCDDVcMPqqn
	RDBrSNaWlDBiqgIOgCdhBgtB5VUa6v67xMReMBpzLGrhiIibyWdLjV9hlQAoTGM+
	LcLMEbVJMRfUxY8tfCgtaooVBTm2T4bNpdURZU3yIKhcd7h9Kv1t+S37ziSnMHLv
	du8Ji/qev5eo6W+2HFImwlqTcr9LykBmKMJADe6ZVFknLdjcPbBG+yAE8AScZzsE
	ebSQRneQM1uAt/rNISxhoto5QVsuO7z+fXu6Yok5pFvclP3WKaKLVYC/IdY6I3CV
	zX8/lXFyMFBv2JVSEpbag==
X-ME-Sender: <xms:dAA3aIjMm8crvI7UrcCOSrU4H5hIh2jdGNvXH1zGW3mna_Q219kskg>
    <xme:dAA3aBBibrwPgniMC6Rx-nMdV_RzuF0k6ZbGtk1YenZ339A0Cgz58kky_trqGJ-22
    WdAM4zNVU7MQapUoA>
X-ME-Received: <xmr:dAA3aAF5OqVqBN3dTjbpldjK3wHc20JFk7yWbnmhjn1vfK2WGeWi2vGrInknsfLi0ySz7OtjYvPoYe9nzfKCYDlruxJMtM1gLQhIco7H9OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddu
    gfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:dAA3aJTXa5KmPrdVLOj7dP1i2265n8MvO-Jm9wdC97yrNzKHPFLwHw>
    <xmx:dAA3aFyGTYyNik_2p_YawI4c5VaSLHymSRjWlKDLrE7nfqDpSE6MBQ>
    <xmx:dAA3aH55b4klScIDKJBUaE6ZGwXTl4WYMxO87xlrlhlwPuoZ3qsO7g>
    <xmx:dAA3aCyAY2Jo2HkFzpUaT_GSkJWslvNcuup2LxPPtOX6br6hgbnRLg>
    <xmx:dQA3aHtovKqsTnnEZwewVXZ5ZAYYDKpWb0IeVvag1w25hdFr6tvOE4WG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 08:24:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6307f271 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 12:24:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 May 2025 14:24:10 +0200
Subject: [PATCH v3 1/2] packfile: explain ordering of how we look up
 auxiliary pack files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-pks-pack-avoid-stats-on-missing-v3-1-4cbd0e14bed8@pks.im>
References: <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>
In-Reply-To: <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When adding a packfile to an object database we perform four syscalls:

  - Three calls to access(3p) are done to check for auxiliary data
    structures.

  - One call to stat(3p) is done to check for the ".pack" itself.

One curious bit is that we perform the access(3p) calls before checking
for the packfile itself, but if the packfile doesn't exist we discard
all results. The access(3p) calls are thus essentially wasted, so one
may be triggered to reorder those calls so that we can short-circuit the
other syscalls in case the packfile does not exist.

The order in which we look up files is quite important though to help
avoid races:

  - When installing a packfile we move auxiliary data structures into
    place before we install the ".idx" file.

  - When deleting a packfile we first delete the ".idx" and ".pack"
    files before deleting auxiliary data structures.

As such, to avoid any races with concurrently created or deleted packs
we need to make sure that we _first_ read auxiliary data structures
before we read the corresponding ".idx" or ".pack" file. Otherwise it
may easily happen that we return a populated but misclassified pack.

Add a comment to `add_packed_git()` to make future readers aware of this
ordering requirement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/packfile.c b/packfile.c
index d91016f1c7f..933036e2606 100644
--- a/packfile.c
+++ b/packfile.c
@@ -737,6 +737,17 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	p = alloc_packed_git(r, alloc);
 	memcpy(p->pack_name, path, path_len);
 
+	/*
+	 * Note that we have to check auxiliary data structures before we check
+	 * for the ".pack" file to exist to avoid races with a packfile that is
+	 * in the process of being deleted. The ".pack" file is unlinked before
+	 * its auxiliary data structures, so we know that we either get a
+	 * consistent snapshot of all data structures or that we'll fail to
+	 * stat(3p) the packfile itself and thus return `NULL`.
+	 *
+	 * As such, we cannot bail out before the access(3p) calls in case the
+	 * packfile doesn't exist without doing two stat(3p) calls for it.
+	 */
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;

-- 
2.49.0.1266.g31b7d2e469.dirty

