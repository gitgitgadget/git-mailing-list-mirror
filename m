Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A41DA62E
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787463; cv=none; b=LeecgoWLb+9Sh23Px5dNoykFpr/gl8nxF14DkOK5uNUr8k3u0AR/LF1kXMjkycHAKR/SEDqC7YqDCpfid3HL1LDsIoKRLJGgyO7nQnTGy2GhCSYthUGD+1w+blWth7XpzNphKDE5l+FGKpidQ0uKa7k+bnlrDbADWX5byohKHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787463; c=relaxed/simple;
	bh=peNPAG5HXnOhjqQraobEJTx5uAd5/U588XKDVi1pDV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohrRGl02UQlKc/Tu2gO0CwP5QpyfE14o7e/XTkWtZELW1uTCiIJQ4OodLet6OVZeXk9gVTNgH0IhfIvqu8C/R5gqtoO6E3rBbyokWdjrzaHa5wT+WzapPEfJ9riGNxoUfri8yxsiN28uC8dM/t7qACRUc9PffUdJgr+auzyWpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MDje9zD8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwcFM9Bk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MDje9zD8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwcFM9Bk"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8373A2540076;
	Tue,  5 Nov 2024 01:17:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Nov 2024 01:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787460; x=1730873860; bh=ioWPSsncQo
	I64+VugMot5A/Azew+Sw1bWew3uDxc194=; b=MDje9zD87CQmCc0SlE4/9IBhmR
	QMt7LodPVyufoGye1LyjRf2mvj/LlmDnwPhHG1WFw0mbjC4/iUu0YUtak2p4gjEp
	CyoOPw930P8nxGBoos8H7XKrP1CXj56LdK9ltCapodE7p2NWobcbNiiAYrI5lXtk
	nXx6OlpQZLqH/6nm5gtx1FOjgGJA21Ph60iQMe1Ylo21QkgaWxWt4KWySyGPbvMH
	PvJans3DsIKHNA+vqW5b5efMcpQ0/DJaZPlUn0C+Dz57rUp+s6CrpuPFH927U3YA
	fV7BAQ7tigFpkZ+gP8J8cCwjrTDayXcT2hU8vPB8D8RmuROjIHjqD/ui65FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787460; x=1730873860; bh=ioWPSsncQoI64+VugMot5A/Azew+Sw1bWew
	3uDxc194=; b=JwcFM9Bk0LwN0KjwvkvTn46V1BOoVHQaR9wnH2ECguGWZtdwIyb
	OC25AFu9L4x1WI9n4SQr5qGd8XfwqZMO/q5uh5RQENJvH3Sw3AxM3GHqNoNfxViL
	EtxLAJUjZYBDMysn0nmSToTDsFir04jw1Utb+j9vRtjaDhWGAKOk4g8CfS098y+U
	Nhq2k4aWbzi7IvJ9rF5O368lFil4ds9uZhgDO2sx1OHM1L6NINPkJBz2JCP8ROWX
	HkpPg8BNwhxDlzx2H2cB8gb3pe+JjdWfjXyjWK4LfMhOQoW6mjNbTkPv4Yt4dnmW
	yLIDZBb5cCSkzzrvusnIaK4FdmKpAYWlEcg==
X-ME-Sender: <xms:hLgpZ5OGVzQcK0WntMDLBLW5gYg9cq5XdCqRXkmVIB-xibA7NWDlwQ>
    <xme:hLgpZ796pr2WzZttPZSCpdMoPwikWXGU92POHrlKnKAc3mJg9FsKA8983udVP4pu7
    jk04dkhgUEKVr1miA>
X-ME-Received: <xmr:hLgpZ4Q1nhMiq9M80sm8LT-ad_tfWy8_EPwBTOFi39AMudYqM1RkixlWV8OFmuxfxMAhoG5f4FjUyOk60i1jClrBpfZikGNakaDLa75YXmXcGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehtohhonhesihho
    thgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:hLgpZ1vNBJFZlPJC4hld9yLsX1hM7v0AAlZal09DQdkZKHivjH6Arg>
    <xmx:hLgpZxf2soUKPlOUJG5Alczz7jmATAqhe3gd9CX5C7wxeMzde8ikrQ>
    <xmx:hLgpZx0OZgZYtyzaPTWFWiVYQVtIBQZqox0K3Wvkx92_9f_av24ZUQ>
    <xmx:hLgpZ9-hewWktTT8VJmRKstpOO5EBSHiVe_Fv7I6O7GRvTtOdGmdtQ>
    <xmx:hLgpZ6GvRHb2Z7EcqR85t18mWjg2i_3qCXlSpqAx7slGWBqe9mI8nFtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb62ead1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:18 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 15/22] combine-diff: fix leaking lost lines
Message-ID: <70dd0cb6933c31064f6084bb5a51794a7691b154.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

The `cnt` variable tracks the number of lines in a patch diff. It can
happen though that there are no newlines, in which case we'd still end
up allocating our array of `sline`s. In fact, we always allocate it with
`cnt + 2` entries: one extra entry for the deletion hunk at the end, and
another entry that we don't seem to ever populate at all but acts as a
kind of sentinel value.

When we loop through the array to clear it at the end of this function
we only loop until `lno < cnt`, and thus we may not end up releasing
whatever the two extra `sline`s contain. While that shouldn't matter for
the sentinel value, it does matter for the extra deletion hunk sline.
Regardless of that, plug this memory leak by releasing both extra
entries, which makes the logic a bit easier to reason about.

While at it, fix the formatting of a local comment, which incidentally
also provides the necessary context for why we overallocate the `sline`
array.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 combine-diff.c           | 5 +++--
 t/t4038-diff-combined.sh | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index f6b624dc288..33d0ed70975 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1185,7 +1185,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	result_file.ptr = result;
 	result_file.size = result_size;
 
-	/* Even p_lno[cnt+1] is valid -- that is for the end line number
+	/*
+	 * Even p_lno[cnt+1] is valid -- that is for the end line number
 	 * for deletion hunk at the end.
 	 */
 	CALLOC_ARRAY(sline[0].p_lno, st_mult(st_add(cnt, 2), num_parent));
@@ -1220,7 +1221,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	}
 	free(result);
 
-	for (lno = 0; lno < cnt; lno++) {
+	for (lno = 0; lno < cnt + 2; lno++) {
 		if (sline[lno].lost) {
 			struct lline *ll = sline[lno].lost;
 			while (ll) {
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 2ce26e585c9..00190802d83 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -5,6 +5,7 @@ test_description='combined diff'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-- 
2.47.0.229.g8f8d6eee53.dirty

