Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D371DD88B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022126; cv=none; b=gFnrPOFlHjgCIbrXRKNp//kKaKwXFFQpZoaXx/pkMbx7SfpAimFSk0tRJCA9AjCfGAxcfd3mMRRmM+OS7b2/Q7KTaHuj2vZalKj3YiDYQugDXM8OJvC9drX3u+l6Ey+E21LxCILMKTVyEgAvTfFC0TxaQPVQTZqO4mEYfL9nCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022126; c=relaxed/simple;
	bh=m87Ho+3YbBoyDrPxeA/eFFv/F5dhyzsCeokoBgpmhXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAjwfB0LI1bveT5ZifH/jotZT5lA/q1gJKJHOcx3U+meXkdm4oN82rJDNWdOkf3CDvynSYd2Kf+LbX8UqSAI7oerAmk+RYxremvSwqhPuke8IZ6YAXh026xUSvuGytZfZTx6NthFemhvPZBDgo29TtuMbADbJhytURlmqFRMmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vo5c/Xid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oiZDOaht; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vo5c/Xid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oiZDOaht"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DE9B25400B8
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 05:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022124;
	 x=1737108524; bh=QD+ejurp6QxirfZ+QI6M7kUKEnMmt+/3awOEb8PtY1U=; b=
	Vo5c/Xidp2LnfCYkc/gns25FqX09KV0sshfEq16/3/0I26sdc0R057F5+tQLdwov
	o7Gw35GvNZXybAMqMlQHAbqp0UxucLNIj+fF5ZzQ2PsABGAhUVuy6Hutxdm+9kXG
	ozJ+lsiHqqubLel1FfL0/kTT9FdddS6hsSvhBDZ6wcDa5j6Cp9UXfWojIAeH7y1u
	y/RRBBEyqLiki0hPEaTmAA3kV92wilH9lVX820rZiKVLkp/j5Ew90alg4qqRGubF
	VsoT8ejzewvLiDh57rrof4QQ/t5NMZavyREyuVuE3J37IsEucm5SHp/YgD4PGM90
	r11aBfzI9ypwaYeQOHSevA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022124; x=
	1737108524; bh=QD+ejurp6QxirfZ+QI6M7kUKEnMmt+/3awOEb8PtY1U=; b=o
	iZDOahtfsZVzsLpJVAvS86y8HIHYkaYEKRlfe9h8y42l8LKxG9Jbs8nB8DsrQDuk
	zl2i2I6miX4Vsc298gZNQSv62whpQd37yaQ/IMSOMQXJ5zadutpisAOpLj8TkS6D
	Zu7DvOn2MjrFzohEAy3QLyMy09rGq4sDNDkDkEKQ6aKl7NgI5w6D0/2ASX74N5FY
	E0zWesKBLjhFzLu0XixSSfpUB2tSw7Jo6RMErnpG1O3HSDmxuQ1YsW6SaXIPEzLm
	1g5EH46F3vrBcbdcaD5c2rDesIj04ZARpKeAB0BnK/BDeD3aWw+l+u97ajrw9Sd2
	TeAepvaLE11u164yJ80WA==
X-ME-Sender: <xms:q9qIZyBwzWlJRi81acFAXoQ7dpF_MINVA-4fKxLNVcHfdTF2GP0EHQ>
    <xme:q9qIZ8iZqwS7hzc0BD6VBBGP48RdFsmQED16e1axm1a8nEH1roAI91WOeb6KyGNi4
    12_fFNftHycdOTxtw>
X-ME-Received: <xmr:q9qIZ1mC-lSmPqZh3fWQHN1sRxzffgS2fFbQUcImT0ZzE7NK52W2VbThW8_SAgn08uNRUTxnShjnjIBxDDajieIaNpAkocm1cIjEPyz5VbQv8JUf5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q9qIZwzitNxA5B_x9YUER-az6VD8f3PzNmyItf0H-NY-MboBnWKBpg>
    <xmx:q9qIZ3TLboM1as2UnYe0k8A--ZaDZr5q1wLZRH_mjyDSnQAM1nGoQg>
    <xmx:q9qIZ7Z0zShqvgo2Px56L_C67aTTkcwiQ16qqwbkA__PQ9dsJkIrig>
    <xmx:q9qIZwTHu9RkH-IPeIqIDFa30PjbQnFDCQWCHkQ6bQGXmWFmFF_cyA>
    <xmx:rNqIZ-KiyQahqdfHCSxbdAY1n7gz7Spbt6M7wX04_ncvsN7UEkqgIdeZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e77e71af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:34 +0100
Subject: [PATCH 02/10] reftable/record: drop unused `print` function
 pointer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-2-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 42c424d69d (t/helper: inline printing of reftable records,
2024-08-22) we stopped using the `print` function of the reftable record
vtable and instead moved its implementation into the single user of it.
We didn't remove the function itself from the vtable though. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/reftable/record.h b/reftable/record.h
index 25aa908c85..a24cb23bd4 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -73,9 +73,6 @@ struct reftable_record_vtable {
 	 * the same type.
 	 */
 	int (*cmp)(const void *a, const void *b);
-
-	/* Print on stdout, for debugging. */
-	void (*print)(const void *rec, int hash_size);
 };
 
 /* returns true for recognized block types. Block start with the block type. */

-- 
2.48.0.257.gd3603152ad.dirty

