Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C317E017
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516053; cv=none; b=gHM7DNVHpsgaOHHWbsDHzSP77jMKXNzYFwCAWpTzMI7Ka4h8gCp63r3+1HQp00zDC8CiphHuwrWedJgQK9HXjrjUMDBP+3SxD/vuzx+jo0AKJV9HHzqpncGcvKczDDyDjz64mKSRfTzUgjKciX5X+qHIU1lxOGtZxMtOg9Zn7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516053; c=relaxed/simple;
	bh=yyGAHWNO10+vPDF+ajELcoXd8PccWysMsgLBrp0lJ8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSl3vvLbiRbnliBOMFA+CcP4sbn90hNLbfM3nb9++vMd+xXql2UuwrGZrgwzG9B/u3ct2ERMT9RcdoQBA0avGe6CfT/+OeOPDw9TfOf33lkumJ/dETtoRMlu7BIzwrYMHNUDCPPqH5q4McvCcKkUMMA7NPFVpBup9HcHUm2UiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j6vzr0N+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvMSUd32; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j6vzr0N+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvMSUd32"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 087AB1140166;
	Mon, 25 Nov 2024 01:27:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 25 Nov 2024 01:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516050;
	 x=1732602450; bh=nD+DDeGqgCNriQemiuGj9BWLq0r3GJR5sg2g+8PHLfE=; b=
	j6vzr0N+YjOsDRyYcTMeMXK6BUmSkiBIrDMPO04lO4NbI80VQ1nLFnHi5HFy/SwS
	fZ01SfwReeree+gQ3KMGJPzlMSztsz+E8R9vF9UNHb3o9L7EKyxzVCcavCPYOqiF
	CkVTsP2+rmhYGyxlF0eA0JIbygX/SNseP+YQ14/ggL4yal+EfZealXOlP0tGKq+G
	xz/x4s1uto+yTy14pYuS8bF8taKLHps2PpQxJSrrDHXGhF+G1VnDoj7HPermX5Ff
	d5fVBc2NUvvyYeQUIOL415ezbui09e0vBMxn1eNEP3bCa1oVRZKLEwnqVxnsBEb4
	R4oFBXm6/jlAC61QhAZ8vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516050; x=
	1732602450; bh=nD+DDeGqgCNriQemiuGj9BWLq0r3GJR5sg2g+8PHLfE=; b=O
	vMSUd32nElgXdx5FFYoSUfIzwYjLhVkereCeCQoTypbHUQyIipToE68RJnHZ2Yj+
	rJcRNz2OGclrQ7GkHuA4cutQitE9nqEfavJ24muAYo6FhwREh6xNugzSH1MyVki4
	6RZH0kUx8RbM8wQv/iw0AsvCpfColyHb6PWPj6vIXYv5nM/RsMR6Y305o6GByt6O
	5hrzUNBZ4BBhPLxJ30qcDFXYEc6hae1NqiAVGqrXweQNkll01U2VLpoyakFF07Dn
	WL/VTn6PRp5aorGsH5BS0XUSe7YB0pCugjYNeg5Cn1Rk52aedT5m7lRG7kiL6NtX
	4pt8cyFhquA+xLUapVjKQ==
X-ME-Sender: <xms:0hhEZw1uHkrRUefOLHOnfBy-NKvZQonoODDu9ihAbWbRNJIr6Z8ipQ>
    <xme:0hhEZ7Glxud42XoggW7Ps239iXk1AWEWbRlPULyL_GXXr2-h1l70FigyE58cJKXyT
    YbuSWMUrP6iwAfD7w>
X-ME-Received: <xmr:0hhEZ47q_Vz_jayoXk5HG9O0yPfk4GWepK5AvYCGh0rW_HVDJBmJWkYyoDcyCTDyvIvJXnymyiWX8H5wIfBwzE5OqtedNvz2ChwQ8VxicvDzbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtdduffdu
    veevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0hhEZ53eo1wVvbXSjY0rU4XXIMiuM3UYVU7j-ER--A6JhKJonJBAZg>
    <xmx:0hhEZzGbxkZ9XXwZRH1My-hh4fNAQv-fR_OPiE8yD0lENSZKFfyKtQ>
    <xmx:0hhEZy-2EKJmPy5sfdmBNmum1xlO18W4c0-BrkR_86Bh7sLnthiX7Q>
    <xmx:0hhEZ4ldvSzCGaOfYEpgU0DLJ8zAU0GwTx0Nx1AB0uttHfuyIAu_9Q>
    <xmx:0hhEZ0OdLOQVmIzGhEsDsN3GkD0aj_2bvi6QO-8GECA7LRXfyVmyA1H0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d48fcd03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:12 +0100
Subject: [PATCH v3 07/10] refs: don't normalize log messages with
 `REF_SKIP_CREATE_REFLOG`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-7-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When the `REF_SKIP_CREATE_REFLOG` flag is set we skip the creation of
the reflog entry, but we still normalize the reflog message when we
queue the update. This is a waste of resources as the normalized message
will never get used in the first place.

Fix this issue by skipping the normalization in case the flag is set.
This leads to a surprisingly large speedup when migrating from the
"files" to the "reftable" backend:

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     878.5 ms ±  14.9 ms    [User: 726.5 ms, System: 139.2 ms]
      Range (min … max):   858.4 ms … 941.3 ms    50 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     831.1 ms ±  10.5 ms    [User: 694.1 ms, System: 126.3 ms]
      Range (min … max):   812.4 ms … 851.4 ms    50 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = HEAD) ran
        1.06 ± 0.02 times faster than migrate files:reftable (refcount = 1000000, revision = HEAD~)

And an ever larger speedup when migrating the other way round:

    Benchmark 1: migrate reftable:files (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     923.6 ms ±  11.6 ms    [User: 705.5 ms, System: 208.1 ms]
      Range (min … max):   905.3 ms … 946.5 ms    50 runs

    Benchmark 2: migrate reftable:files (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     818.5 ms ±   9.0 ms    [User: 627.6 ms, System: 180.6 ms]
      Range (min … max):   802.2 ms … 842.9 ms    50 runs

    Summary
      migrate reftable:files (refcount = 1000000, revision = HEAD) ran
        1.13 ± 0.02 times faster than migrate reftable:files (refcount = 1000000, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 65d42dd603c6cfcb7966c795166b054343034608..ee870817466b7d6d6a6619ce0baffe17f3d5a39f 100644
--- a/refs.c
+++ b/refs.c
@@ -1188,8 +1188,9 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
+	if (!(flags & REF_SKIP_CREATE_REFLOG))
+		update->msg = normalize_reflog_message(msg);
 
-	update->msg = normalize_reflog_message(msg);
 	return update;
 }
 

-- 
2.47.0.274.g962d0b743d.dirty

