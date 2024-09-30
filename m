Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD6186E3F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687636; cv=none; b=L81RIvwhLlb8pogMdOa66jpdDXB5Rr9+6HpLjkCSbze4sX5JII+2OtfI7OZnzNnH7DI626jXInVXyNC+4ooHH9Ct7tcLFjqRVMgCn/dRejJc9td3QMoHK24WwGwou/4B2tGv4W6doo18C7PBe6DFky70fdlR+DfjxYD4kNMuTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687636; c=relaxed/simple;
	bh=ucQzhGntvLuhFM3M+d8I10C9ch0+16AHkiMtzsjw7Zs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0WOyo684kxKrBZbcRgwpb8U0aX8gfpKLcckHNjMde/wCGIAlKhiW6bpIaey8XGFqiwKuVtW3YIkQjrmEJTcdcnr+SVoZK+SqrUFkNAan047+rBH+enBKXQbsWVYbLOUG5Yf5MEyYVU0RzoX9PyX+w8jvPfQYlMG8ZBj2d3h40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QgvBpsqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY/OZ7BI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QgvBpsqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY/OZ7BI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 16BD7138029D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 05:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687634; x=1727774034; bh=lGHcHYVFE8
	grfjeEFfWdVGcBbZNSvt/q4GHswxk1NEw=; b=QgvBpsqRtAdWegNBVBBxpIobeB
	TXn2RLx2htbFBJV0H+sC0ewDN1zAQKtgSB3rbMzQntw9hk9Zme12dlxdmGmIdVPE
	4PpYMJ4Th/eiQeTM/GvRlUuGLmO0UUATMnrzHVi665LhiZAMNhK/ZwGAEfUkl17k
	tvtAOquKvZk6q0LnTJqjkUNitZrcfPLgygRxGG+NRJuURXP+0zhRuMwbwVPffMJr
	WxIDVgyFJr7zPQx1j+rh4uAI3fpZrYUO+kOzLvmykWaozXMCp/fgwhTLpChmPdzw
	007MC8Uyu9/kGW8lGYtmrHewcCnrG+UK5BAkF1mREb53Usxo7Jut3NxIrVeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687634; x=1727774034; bh=lGHcHYVFE8grfjeEFfWdVGcBbZNS
	vt/q4GHswxk1NEw=; b=dY/OZ7BI1KFEKp3L8/7zEVhLCZPSlVGGLIX7oQE1t3F/
	sS6fWMMeCxsrY3WEsI/AeZhktPaLxoQf0DrmDdckdeGSmc62wg18sELRZ4P/xn06
	SdLqI1TA97RG0AuEqZY4rPimxjmxPafP+J/x39k0fpdiFniAKXil5IMPqD37fh2a
	BOak+5KeniXdpIW2lbZk4rxLcOlyfQuJ9tLEu5t8GNIzZajCA7HX+qeiSvhnQ1P3
	Zh1dEyxhbHdhbgTBahuDHjvuUJDGfxDYq6MEE+x0RGq5xYRta6GSWbUCsEEFzz7/
	MnAXLoP1BQlLFAnYGNas6XbzRBsmi2wH3kSwMoCLWw==
X-ME-Sender: <xms:0Wv6Zk2Cj7cFFLUMKefvLz4CppOtyIbMAy5Jhxl0dZAMfCS_M1uBaQ>
    <xme:0Wv6ZvHEHUQb8gK4yBdyHOCa1KgZvJ3FbQ6ldLw46JxZvFGGq6uYqtD0SfWi89Nc-
    0fOCcdNECtyyv6CJw>
X-ME-Received: <xmr:0Wv6Zs64KUOyJD25rkOFJ3GRSxp9dueOh48XuU-g4bJt4hL2ZZzPTKlM1W2r7RR_-OHMTbLI4NsFxIFwQk-zJwfCECAWkPyWfgUIzbQkm9et4K4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0Wv6Zt0vmFvd0I19F2kjJPFvVJUW2NWNVz3PLtk2mh0rGfClm70f2w>
    <xmx:0Wv6ZnGzzLwBUWdkbI0YPRksLBG0OX5HKtcuvIyCZBCtVEoSab0C-g>
    <xmx:0Wv6Zm-JcjcFUOyw6Y2N1tJyI1K7M2LsERjQgKr-SmaypEGuVAcucQ>
    <xmx:0Wv6ZsnPL-o5kpjttRtduKZ5Zr6ibUGWiWfe6xIvrxQzFLjKr1TsfQ>
    <xmx:0mv6ZtN5oJ0T0FSImVG8ucgNtTEPo98u8DgJejbg0LU6Ca1KiTLTWvQv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3fe90d42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:08 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/23] pseudo-merge: fix various memory leaks
Message-ID: <6e7a272c29577536ba992cc73d736d8f66397607.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

Fix various memory leaks hit by the pseudo-merge machinery. These leaks
are exposed by t5333, but plugging them does not yet make the whole test
suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap-write.c |  8 ++++++++
 pack-bitmap.c       |  4 ++--
 pseudo-merge.c      | 19 +++++++++++++++++++
 pseudo-merge.h      |  2 ++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4dc0fe8e40..6413dd1731 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -64,6 +64,12 @@ static void free_pseudo_merge_commit_idx(struct pseudo_merge_commit_idx *idx)
 	free(idx);
 }
 
+static void pseudo_merge_group_release_cb(void *payload, const char *name UNUSED)
+{
+	pseudo_merge_group_release(payload);
+	free(payload);
+}
+
 void bitmap_writer_free(struct bitmap_writer *writer)
 {
 	uint32_t i;
@@ -82,6 +88,8 @@ void bitmap_writer_free(struct bitmap_writer *writer)
 	kh_foreach_value(writer->pseudo_merge_commits, idx,
 			 free_pseudo_merge_commit_idx(idx));
 	kh_destroy_oid_map(writer->pseudo_merge_commits);
+	string_list_clear_func(&writer->pseudo_merge_groups,
+			       pseudo_merge_group_release_cb);
 
 	for (i = 0; i < writer->selected_nr; i++) {
 		struct bitmapped_commit *bc = &writer->selected[i];
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9d9b8c4bfb..32b222a7af 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1390,8 +1390,8 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		}
 
 		base = bitmap_new();
-		if (!cascade_pseudo_merges_1(bitmap_git, base, roots_bitmap))
-			bitmap_free(roots_bitmap);
+		cascade_pseudo_merges_1(bitmap_git, base, roots_bitmap);
+		bitmap_free(roots_bitmap);
 	}
 
 	/*
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 10ebd9a4e9..28782a31c6 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -97,6 +97,25 @@ static void pseudo_merge_group_init(struct pseudo_merge_group *group)
 	group->stable_size = DEFAULT_PSEUDO_MERGE_STABLE_SIZE;
 }
 
+void pseudo_merge_group_release(struct pseudo_merge_group *group)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	regfree(group->pattern);
+	free(group->pattern);
+
+	strmap_for_each_entry(&group->matches, &iter, e) {
+		struct pseudo_merge_matches *matches = e->value;
+		free(matches->stable);
+		free(matches->unstable);
+		free(matches);
+	}
+	strmap_clear(&group->matches, 0);
+
+	free(group->merges);
+}
+
 static int pseudo_merge_config(const char *var, const char *value,
 			       const struct config_context *ctx,
 			       void *cb_data)
diff --git a/pseudo-merge.h b/pseudo-merge.h
index 4b5febaa63..29df8a32ec 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -51,6 +51,8 @@ struct pseudo_merge_group {
 	timestamp_t stable_threshold;
 };
 
+void pseudo_merge_group_release(struct pseudo_merge_group *group);
+
 struct pseudo_merge_matches {
 	struct commit **stable;
 	struct commit **unstable;
-- 
2.46.2.852.g229c0bf0e5.dirty

