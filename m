Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7E186E52
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541476; cv=none; b=f+m49yT6SSgMZM+XHNUxq/owOinJNqamqrnIKsTI+pzx1paCgd3hBnq9f3fwns6vmX/WXP3ACOH4BSOoTEKrz1y5HSA361ywbCOXZAOMdQ1qiB+zdw5VjV6wB2neiW8D4UQakysHXQVuhlA3vCAaHMNzqR4vF8R8Wz/soh77YVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541476; c=relaxed/simple;
	bh=hoFFcWuv/vPMkUdi5Yo7jCwyC10IxIxjt9eqsrkZNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9dO7hIvYXH+NMYief+l+r6q9eDno2Wo2ctlLIXPLV+1H0C7mAX5UencZMrfnCTsWNraDc226WFOBHaTgaLIWePewEud3W7hAEqKEyAa23aQCvppmS2zgaK2MbAbFtSweqicBS4CljkQz7eje73LZfW6dUq44SCbPVxq2r45gFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B7mBrfuu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTOMTlD/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B7mBrfuu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTOMTlD/"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 36996114EA7D;
	Tue, 13 Aug 2024 05:31:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541474; x=1723627874; bh=zF6cR7mg03
	Nqj6lX7Glae3/XyFq1o41rAfNOBYrNcFA=; b=B7mBrfuuZi9u/kVHrZgAkOcynl
	QVNbHFpobmN9zWxIOu7IFNa61fsiXEBDJX4pLAVn/M3Uye+REEgZk/SQop5g16LG
	+9t03Z5Y1K77HY5+ywPgB+wQ9Cih4VmU58lj/bqM3ZAk9jMDg1Q7ScaqdO0HJg1P
	XLkYNllCjXsbjyN89eefuStBdtih3BJ7i66GOl/Ghrcu46y9QGdVnLYxobOrAgNt
	KiGUlOXywwuzbhy4riyPa+Fyjlr4u8UXiSg+ARKD7zVk51wnnRXIBYV9fjDFKQ90
	HYHK50d+rD8uiBXtvyz/ouQPw1fscSrYgraGmZvv6LzEw4N4dqfBRKHl3eEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541474; x=1723627874; bh=zF6cR7mg03Nqj6lX7Glae3/XyFq1
	o41rAfNOBYrNcFA=; b=BTOMTlD/zVT7oqGRN+z1rXXQfi8SXkQg6NKsIz96Z07u
	zWFgGq01i+r4dnTL9hgLtcQeK4IDFkl01+ZAwZ8bkPbOeiEsqeANouxS5r8Qgzxc
	VP6KcsvlyBRYG5o1OVqVHDL8FFEXBbezckF1gRRt1KOBst0a7RPBiErsuWn4xs3s
	cscBhQxOs+sjlWs0rx8D2LOVGpjGjMKRWDEouLKm2z/IK/CImimAeDDAMoRRIGZH
	KnDoq8bcnm9J6ttMrDoWK7AhJwmsfji4wRfo9QuRCqBnLMd3QpzdhGPsYYzojfhM
	2Z8UaJ+Y1Mkn1VM6VZr8kUfrdlqYZ85jJzdkAre6lg==
X-ME-Sender: <xms:4ie7Zrn7JJXcrANBWUdHD4buJTuy-jmRn-rumCjmtdfosJdexYKykA>
    <xme:4ie7Zu1_aX9vYsQi8j7F7wFf4dU1YGNCsxjGEyqdNqZr9D8OODcjA9THJX_jeZmqL
    KllR6UKtRdnL-rppw>
X-ME-Received: <xmr:4ie7Zhq-tnRnq3SxukADt5dcfXmEWEIrCdjS5FTyExyPPaP2X45n6b_ydoeqOYbIrdaSm9qhTa_E2L7AGqXIyBqWb651hB0s88kqS1jPRVJjkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4ie7Zjm5dfFP7FMgmaw4KuGRzYpQe3XkDU07SSS1PeYBk0tNgFi2xQ>
    <xmx:4ie7Zp3XWP4L29uCny_U5AvalXP659KC3uOEdQPh4VV0FqzVstktCg>
    <xmx:4ie7Zit4LYmEx9woXWe8xOTjyVXVRvUZeAXCljitudXM0ZS4LclU6g>
    <xmx:4ie7ZtVdlMYYrC-xhBhQnDUFOrfDbKpaB3645p3rkpPd0WTY4OcZkg>
    <xmx:4ie7ZjrBnEM-fAsboPjvAoqn7tVmdJVpf4seOK0ob5WDfj4viB98REWt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d342611 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:30:56 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 03/22] object-file: fix memory leak when reading corrupted
 headers
Message-ID: <0415ac986dc8c04917502a1bb0b03afcca47ec67.1723540931.git.ps@pks.im>
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

When reading corrupt object headers in `read_loose_object()`, we bail
out immediately. This causes a memory leak though because we would have
already initialized the zstream in `unpack_loose_header()`, and it is
the callers responsibility to finish the zstream even on error. While
this feels weird, other callsites do it correctly already.

Fix this leak by ending the zstream even on errors. We may want to
revisit this interface in the future such that the callee handles this
for us already when there was an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c   | 1 +
 t/t1450-fsck.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/object-file.c b/object-file.c
index 065103be3e..7c65c435cd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2954,6 +2954,7 @@ int read_loose_object(const char *path,
 	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				NULL) != ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
+		git_inflate_end(&stream);
 		goto out;
 	}
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a456b1142..280cbf3e03 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -6,6 +6,7 @@ test_description='git fsck random collection of tests
 * (main) A
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.46.g406f326d27.dirty

