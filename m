Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E620E016
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273738; cv=none; b=AaFSg5BN+xRdEVR3XFR0hrDI/9y6GgTDllKaTmz4vPoRC1r6GTT4AoFJxC8NoRyoWD5DYn3wtJzO6bG9ZxuLkU/UilBhNDBZhrZUSNcSvsr1GkBXVPOA7X3zupOZYq2pZaJfmKvR5Mj9oVz6w/plH/pyzGgb9Bp9ei2UrljRQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273738; c=relaxed/simple;
	bh=dDB5ene1M2tyA9QtQHJvkIk+ykfX85KsYEu1fBFoXqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b60uCR6ly0GzzxD6KlWWvnIktxIXLODIYdb/yVEf4a4zo1FwsjgX0L94j0WL6e5HT4iRS2i2uqjdKeW97rwjJ8dRSkA4poHX0RuYHD5lQWRdmEbW5DGz/HoBIxBv9Gxwf7iptW3dF2ZE/kCxLDLPEzNBrzI20RbgjBgjPNgkmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A7sumibP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qE9377y8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A7sumibP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qE9377y8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4891D11401E0;
	Thu,  6 Mar 2025 10:08:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Mar 2025 10:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273736;
	 x=1741360136; bh=W/CICbvvl1qwG0o85IrKeqoAktjxwGQP+8+LnUBJYN8=; b=
	A7sumibPgGL4QHUtyJdR4CIrd7YZTxwb0+mTpvLBNvP3zH1NtI3pZjhu9K/e8SJk
	aKb4oyNimI1rZNnJwjUlqou/CGlzuRposC0N2AM2jV+5Ddr9U5KLgAHWJ5ER/Aac
	4kLMsDTDClHAHnyBnADXlbUdp8azT1QElYHk2ya+mYMT5nDvJseRLa+9L3aK9TcZ
	epiyxuoCVEnfvMBgKj4Adxn7IQ8f3CbrcGP+8vuAlsiQriHVWZqmWFOZk+eq5RXE
	zYuiQKB7PfvnevbzxcQtmAvAwQOrKatseozpY/t9mwxLCmgDFKK+0fmgGM2oquaK
	4ZGJy3QGGX38oVS0pK0Pzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273736; x=
	1741360136; bh=W/CICbvvl1qwG0o85IrKeqoAktjxwGQP+8+LnUBJYN8=; b=q
	E9377y8ywejjQC++cSotQckrWK0+PT0CbX9al9vFMVdy1GKTP4+/j1En+A+XccC/
	lcaPFAmxhzme/5Vrv8otEHlY464s2ggGfBRoXwipTo2UPLt5MvASHC9Ye+ohk2g/
	v3y6HugC+O6wAcVY7S8TF76RgjgOOehu9qFBSUI0HiRYGIojTE6wqMnuLTwpY1Jy
	KV/pOsZ9vYR/7fPns0GlOV0tijXzp/RdFqRqNLFmrLbUzDBTu50kJRPkWzCMvJ4H
	5DCi9TJOBNnWwCzC/p4nvJrj/XG/QFkq2uXkISENtzDw8j9w3Y3++g1wY/dxR7dk
	Dxx/q7ZHwQkCxuEo7raIQ==
X-ME-Sender: <xms:h7rJZzrbRNHu8EW46kvQAD56iQeBwuo0yFkDlbGEUrCi737lt7EaBQ>
    <xme:h7rJZ9qPtaTa3TMmEzmzJmJnsfcxLaiGYrnBg2sn39vI78gh-oLC44hdksRH_GniI
    DUrYqf_oeQRziHDJg>
X-ME-Received: <xmr:h7rJZwN05ODN152966I42LToZwSSnGKd3eVG_GIHcfEhBsNVxNT_UnDMvEIyiCLn_fgF_IM_-lxLWXnEBoJS8_B5AA0_SV_s9CyNrhze01vajA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhu
    gihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iLrJZ26DJ9P8mRmvETauZ_tD0g9ciw0QAWnOipmHvwZJnwdr-IpBVA>
    <xmx:iLrJZy6OkzGVIVXrz1K574wslYPDrJzcDtJDp4HmEoC9s4941BmEdA>
    <xmx:iLrJZ-h53yRAAUJXlyQ4fMgxJeRVy05DvUbvz2UfjTJ9Nh5QC8YGzw>
    <xmx:iLrJZ07pKn-TR3aXPrAQ_V3iaDy-FYJUG02Xp-RHjEaXQUe9Zmbl5g>
    <xmx:iLrJZ5bEah5KBo-8BT5BsY-LsSsj4ZuzeanSM25rWJYAmRHd1RNAzM2z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 626de277 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:46 +0100
Subject: [PATCH v5 15/16] refs/iterator: implement seeking for files
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-15-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking for "files" iterators. As we simply use a ref-cache
iterator under the hood the implementation is straight-forward. Note
that we do not implement seeking on reflog iterators, same as with the
"reftable" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 859f1c11941..4e1c50fead3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -918,6 +918,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct files_ref_iterator *iter =
+		(struct files_ref_iterator *)ref_iterator;
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -936,6 +944,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
+	.seek = files_ref_iterator_seek,
 	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
@@ -2294,6 +2303,12 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				      const char *prefix UNUSED)
+{
+	BUG("ref_iterator_seek() called for reflog_iterator");
+}
+
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				      struct object_id *peeled UNUSED)
 {
@@ -2309,6 +2324,7 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
+	.seek = files_reflog_iterator_seek,
 	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };

-- 
2.49.0.rc0.416.g627208d89d.dirty

