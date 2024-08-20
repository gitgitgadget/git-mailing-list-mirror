Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEF1922C7
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162714; cv=none; b=DSlhcanefxhGxJRKvBV+Cdpx9+ZJ8WS/ohDkbsNIFusmBj8e0voAfbMAwB41hYFQqGGyKJIBcDo06bElbgfJKp8alKyGVjtYSIwlLKJ78T1N/jcw6R4G48XT3B29icWHfpQO2ax1bRqHwWarrRHbUKTgTyL8jt3BNHWlag128/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162714; c=relaxed/simple;
	bh=P5drRehIGea+ag3xyfV65e0jcQew4diTYUjbw+m4vkM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opRopTNfwmBriGXpSI6JgLj88+HQS5GKXPRf9MFE5xXFURdUzsvC7WNMaO4t+1UcleJWpMKGtVkmpMRJU/Kqgn5VSciNfX3REkO0YiPMv0LqiytkLBmeNrXchzVKY1v2Uvo7/Ezgv+dMPlupzPOKupHDbyruiHahR/Dmz6eAL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jnGwFtOq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aj7PS3j+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jnGwFtOq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aj7PS3j+"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7662B138FC5F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 10:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162712; x=1724249112; bh=gIqz7cvmrU
	YU5R0PzCrSfb5630P5WWOl03TGpFeXqw4=; b=jnGwFtOqCIaHoavjXK58WG//+i
	o5DpchX9qqpZTpwOUtmPbsFS9pifvfz3wMZPfzTUMsdVMhPPqk9fpXcarq2FxhAm
	2iwr42dVu/fV2rxQ3n8jq4YIulmQ+Sqyh8ZoJhcyAUfIxdru9B5e7iGCouofYUK2
	t+buDfBS8DlxPEv2W9VW6K7wqn2PGDj2gpVh276NVaAVv2s0KnZoSgDronvfb/q5
	oF7ZolAv8trfM3suqvjV5893D9g06SyD3YkwWjB0QEGHdbE+g7UaxgqftTobGs5w
	4DgL4lLClMohU4VQ3gXd++k0Q6HZULM+bdNEW4y3eCOH9nw+cGlZAM31Oo4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162712; x=1724249112; bh=gIqz7cvmrUYU5R0PzCrSfb5630P5
	WWOl03TGpFeXqw4=; b=aj7PS3j+Popo/uN4J9fx+bcJ12JOERYgr4tx8HvInTSm
	1fj4f7EPCp9ZGdsekTCENg7EpMIS22nsfan2RvURkHzcLI0qsPd5Uw6sVh6No1No
	E0bAfFfP3MzbG3tQSQ2MTMuMHb6d2ZZuicvpdO+xZ0R1JyYx2y6mHzNt6qMABe2y
	vMa4d21BwhBEgKNyAVbRg0cadfmwmWXOU7uGSfGhbAUD6QNIZXOHrr29uiPtKaJu
	n5M8B8THp9rf7x//+jSTm3B825enhpfeirHEazYPoZ97rpbx/87fPs5mnMjDbZP4
	95/BWaZIFO2KHI7/9yvTRIksSQjNBg++Ib3dIpJgGQ==
X-ME-Sender: <xms:mKLEZhEMS4B7Y2qEOdi2qC8r_fz_c2ZSnDn7YcoZrqe-CbwzMYmyzQ>
    <xme:mKLEZmWFbTJtGt35I468I-1CR8bBEN1GGzrbqgjnf52-mBVhZxuWurk_O-4kJhAXc
    -C2EWtlrDiNkjeAKw>
X-ME-Received: <xmr:mKLEZjLi9mRRZwGXTOzQSB2v2uYkB4rqoXQdsqe0QbFB_eVJgSEBL3JrzY1hBFyKmNTT5o90kmokzmNeh36o6T9faYIcjUVw4GOBNgbxEMS5Nr-j0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mKLEZnGnUvNmCVOE52ODix26kVMtE5OdVsRbi2aNt3Z0m2ffffVsbQ>
    <xmx:mKLEZnWVEHP1yRvC17vldTlLAWwP0njUC9hzkd2a2yBdlHSHO5G6Gg>
    <xmx:mKLEZiNdGaP_SUi9fraCd_lCcHOjLoPZqijCjNYEuI5yBdHRmbNhNQ>
    <xmx:mKLEZm2rW-TUkgepjk9AMdwTiOhTkYmizvwtjeEzZlrYXopm8HwYRw>
    <xmx:mKLEZufPUjFWZ4BSIZQfkKokDVVFTjrF5lglc_8iv1xWEqmsXsWcvx25>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92178409 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:40 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/20] pretty: fix leaking key/value separator buffer
Message-ID: <696467780e6a1b3d6050987c9305ff48213e306d.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

The `format_set_trailers_options()` function is responsible for parsing
a custom pretty format for trailers. It puts the parsed options into a
`struct process_trailer_options` structure, while the allocated memory
required for this will be put into separate caller-provided arguments.
It is thus the caller's responsibility to free the memory not via the
options structure, but via the other parameters.

While we do this alright for the separator and filter keys, we do not
free the memory associated with the key/value separator. Fix this to
plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c                      | 1 +
 t/t4205-log-pretty-formats.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/pretty.c b/pretty.c
index af8f433cdcb..6b684d7b828 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1776,6 +1776,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 	trailer_out:
 		string_list_clear(&filter_list, 0);
+		strbuf_release(&kvsepbuf);
 		strbuf_release(&sepbuf);
 		return ret;
 	}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 158b49d4b60..eb63ce011fa 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -5,6 +5,8 @@
 #
 
 test_description='Test pretty formats'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
-- 
2.46.0.164.g477ce5ccd6.dirty

