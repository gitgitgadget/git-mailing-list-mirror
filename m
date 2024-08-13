Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F1183CB0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541484; cv=none; b=UsNBbBZz7vA1D+8wExIgEiBJZFrXiz+OyHEzZyXuaxxnm1SyTIKZWxa50cyqIwogydVbXLJ/6wO+Dzt4HGGhQ40UrbwkVjullmz2AgthM5SirtmSv8EJm4A7rHXqbPWM+Ptr3mbaYbnUOXGsQRCz/8/9RSkNH+AS0+mR6ycZ6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541484; c=relaxed/simple;
	bh=JUm3lsJilsFV1O2dMe3PbxtbybHfB4GcBuGmCDuimkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9yJpx0bg1kZ+VkWaR4TAbwXsd5FO9aWMj8NchWbbdUkaH2xQDqaquj6UBxC21UoRmmtWIQCgPZqz509PMpPXYeiziD8qFnkQs/IL//WkJJD7yLNOKtBTS9JkZo02B1comKYdZZ7Sty7hQWMumsp0AEbZNNhvNJbXdxuh4Zirx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qdK5fvLd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fx5CSK4l; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qdK5fvLd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fx5CSK4l"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 732BE114EA7D;
	Tue, 13 Aug 2024 05:31:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541482; x=1723627882; bh=iKG4mzjCkG
	I7jcaSdTJ/I0imjWoGH0ua/2Y5iqWAZio=; b=qdK5fvLdZxmZhNcShVb0OPr6o6
	cBVk9OIUd7mJBWB6p2NPTz/HOKXxnR/JivCEesw76Mpgm143SmSs1adf69fzOeaE
	cn3bn7Y+qswc3W1p/oaRD2uDfYZ0nwjZhJWfStqTPES/BsUigHIRS+VfQgR+/m8x
	pTbGVT4qN5j9ymDu8sxcvFlYhfIyQCd4hDIJQq9G+tDwoQsoC2Al/MivC8t7X1wn
	V5xvb8z6AOPVi23UIHD/Lr0gPrABDTx4e6R84uuTTbHNZO0gmu4GRRpCq68rStfH
	1zOoTuheTbpqhRUyMSsVBrkhsDGqpa2S7mEOoC+XwxG5RJV/o0ZrjaVC3cgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541482; x=1723627882; bh=iKG4mzjCkGI7jcaSdTJ/I0imjWoG
	H0ua/2Y5iqWAZio=; b=fx5CSK4lGTsbDrQEF9qNGFKOuIu2giQ03JST77Ux+w/y
	9ZBe+WUSIhLRWXt4mCImJqpofgmXCHb5WRQV0A6RH3Pu5+JbgLYRpJpaJEWAzF5Z
	NQSOgJYW6R6SrXd76IkRJD3i9IapLvfDuVHCCT9gh0gsEeBKiKuZLZU/tsX3Kkmf
	1fEuCVDQV1NUys0awFVbHZPVLn68HYx0mvCsuPsZQJ/AGchkVQ2mf1ltR8PTobnv
	u0G7kbuK2BdRkoOilZyTYvtBnvk+vwdnN64ebTl4+oI+ehLZS49xySGDIqxR3ULH
	LBzM5HgZ7zc0oVaEHo3oQzqjNnm0VsKRFLprypgjOg==
X-ME-Sender: <xms:6ie7ZuvSK5kcoq1Umda1O4667nDTVuVmqPe40RpfNc1LBh9n1m4Gog>
    <xme:6ie7ZjcMwhnCuZ4DNmEIZ-RYhMWUsq5BRwTd9O11lW2eihcpdc3FRWcibd4Z1y4lc
    gXMNg5_LugN4WT5HQ>
X-ME-Received: <xmr:6ie7Zpz1rDqK9aeHN6xrv3C3DQvye1FJV_NN_rrZCdJY5_i3-dG91BiCbujT4uBku2wLRJjhUmWbA6ZcU1-QvRI9vJ8z8baAN3dhRvL5GkBZuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:6ie7ZpMnAlk8VlvztddQ8be1dozR-hB1rCT8sg1NOuFla7G38AlBqg>
    <xmx:6ie7Zu-vQAfHgtCduASe0dA28XvQxr2OMYZWh47f1Ne1dHg3IWxTPg>
    <xmx:6ie7ZhU_1idThPMZttl0IMU6jPBgQdZp9a7FZumDdMGab70Oy-9x6w>
    <xmx:6ie7ZndL30LkTU8kOxhLe_JHR2iiTLHoQQoL1pDSvbd-0EAD_gAhAQ>
    <xmx:6ie7ZuzIr5nqilk8bH-TUcGzn6WuCSRS96tlBGlGJmHe4aNi-QCoCk3D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e62fa2cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:04 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 05/22] bulk-checkin: fix leaking state TODO
Message-ID: <276c828ad18c422c7cca0503e336c8aee8aeb149.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

When flushing a bulk-checking to disk we also reset the `struct
bulk_checkin_packfile` state. But while we free some of its members,
others aren't being free'd, leading to memory leaks:

  - The temporary packfile name is not getting freed.

  - The `struct hashfile` only gets freed in case we end up calling
    `finalize_hashfile()`. There are code paths though where that is not
    the case, namely when nothing has been written. For this, we need to
    make `free_hashfile()` public.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c   |  2 ++
 csum-file.c      |  2 +-
 csum-file.h      | 10 ++++++++++
 t/t1050-large.sh |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index da8673199b..9089c214fa 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -61,6 +61,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 	if (state->nr_written == 0) {
 		close(state->f->fd);
+		free_hashfile(state->f);
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
@@ -83,6 +84,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 		free(state->written[i]);
 
 clear_exit:
+	free(state->pack_tmp_name);
 	free(state->written);
 	memset(state, 0, sizeof(*state));
 
diff --git a/csum-file.c b/csum-file.c
index 8abbf01325..7e0ece1305 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -56,7 +56,7 @@ void hashflush(struct hashfile *f)
 	}
 }
 
-static void free_hashfile(struct hashfile *f)
+void free_hashfile(struct hashfile *f)
 {
 	free(f->buffer);
 	free(f->check_buffer);
diff --git a/csum-file.h b/csum-file.h
index 566e05cbd2..ca553eba17 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -46,6 +46,16 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
+
+/*
+ * Free the hashfile without flushing its contents to disk. This only
+ * needs to be called when not calling `finalize_hashfile()`.
+ */
+void free_hashfile(struct hashfile *f);
+
+/*
+ * Finalize the hashfile by flushing data to disk and free'ing it.
+ */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c71932b024..ed638f6644 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -3,6 +3,7 @@
 
 test_description='adding and checking out large blobs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'core.bigFileThreshold must be non-negative' '
-- 
2.46.0.46.g406f326d27.dirty

