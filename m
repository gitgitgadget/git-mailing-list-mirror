Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE72F6905
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445430; cv=none; b=HZyK4jG26XynPjKyNl8JTmcFH5UAp+Ax37BOmtqGp6Ossp8llb8A4k1DTMURN8Ofeil0cwE0Mz9+wEe+XJ8qWbLzc8jF/UEkm6uVWYHKip3WYyVemWOx+lhRRxKarj14GTKeD/DNLfbdoFKpAEtrCYL1vWRiQp+c7R8PkMF6oZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445430; c=relaxed/simple;
	bh=ZBinx7s0b7vypGao3FOJqYe5qgsFQJbivhhLtf6l6Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cA4F7MzLT4IeuHySXulBh/LX5ZsldQEN8yVp7wnwJmnXmFF1+aUoJVSPbDXcoJbzcd03AXsTKkiPDc+xo8W16yiHB5r5f7JdYpKctpUW1rnrL67vIqiB5L/W3Pja0lPurzmJD7ZKQ2BNpVck+I1HfN+rrkatrM5YfTpXRflGy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWtc0T7P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpJ8YaQz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWtc0T7P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpJ8YaQz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DDEF1D0016E;
	Thu, 11 Dec 2025 04:30:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 11 Dec 2025 04:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445428;
	 x=1765531828; bh=FPF8j7mBBI67jd64wnvIYfrti+4wU0NlAcXwTivGJo8=; b=
	kWtc0T7PGl39kTcanHsIysuDfkyE2lZd7EWo2ci7KVk2VWHu09XkiGFH4MSDwpRE
	H+i+do+QHXbxX8HPgDW+beHIfM+6ma6IyROSjiG76HXFgQ7lhlkjognFNxGuJ/pM
	zqSQsrQjx/L6/EbqTciy+smViQGPDxNvqLeELczO0iP7BJa0AR8++jlLCfybmi09
	xZVschjWYTa87nZMpnmeyP4+Fb/9W4Xy7FxopjDKxxlrxf27rlGC3Qpmblkeg/Gf
	PXsvLy4ro0Of9cmJIXoJBKmFQ1DK+JzoCubdqBRkJXDbm/X4iUY8gaQujKDxxVk7
	uvBCkE6/RQ1PPpArqqTNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445428; x=
	1765531828; bh=FPF8j7mBBI67jd64wnvIYfrti+4wU0NlAcXwTivGJo8=; b=Q
	pJ8YaQz18ZIzT8mwVgmTpRMOMx4CAh7XLtgg5FRkZ43V/6cgHqOm3nURKu/jK07/
	KWyCJsUyVPXMxLyFDo2W4mAaoJo/YLj41T+DqkNFLp0pS8MpFOqB6SoYk9E/F/A6
	p2tnvUUQiLU6MQMgNCQNrh9WHPFSF1Q6CmFWt8B0zKus2Kuikr2eGmy4vhOtNTN1
	EDTXwMw0iFT1YZ/HR9hLroxdbRIPw+SY2x7cjMsh+fVqi/UHyJ9nPwg8Iz2ZkKR2
	AQ5NUVCxRo9HYrLg9hRJiESYZoeoB4XWmvlLhoTU0NlMgbGT6x6+1vyyIIlkKHy9
	HK8GaehZEfWmTENmdMnoQ==
X-ME-Sender: <xms:NI86abEkfL7SJBn0bkNFbpBonvz8TE609vgiTebectSwO_2uDdptWA>
    <xme:NI86afyc0Kbh4FVxbn8WaXfQjbQ_TV3WrUmmPy_LcDUe-l0hrovFeUqu-o2A5K3HH
    -fJWSQF8YXwTNNpCtjRlkJorq99-1c-z_0pJKiuXFuecKjfhuLLIA>
X-ME-Received: <xmr:NI86aahHq-gWAyFm5lW92c-ibkOskyDttYcOWXK71Qw5MtdKme6B_iDQmgDOE0UvYMGRNUgG4jzkjnE04rXImEoCFH2RapfY1CxzNeMnox6r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:NI86aSz2-JpsJhE2t4a4jK_37vgqrLx-k3bg0L12vd2UYewZYu3Qyw>
    <xmx:NI86aVLUHSyUIZDiA40aZQBIe6fhT5H9VtqhEtPGBY_dm1qyhZTWOg>
    <xmx:NI86aRSUnndNUINb0uw2KxJUYZNne9lhJmWWr0SG4Rnp8FrSv98kXQ>
    <xmx:NI86aVoO0q_xVr5t6FbCnsRErwVltLh_KaV4-LW5gZxAttMvfTGTcA>
    <xmx:NI86aQPlwJY-II83rqimLrMmRJBk1cGPh1Iq2n9W27XQ4tJQLJyl349z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a8724ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:13 +0100
Subject: [PATCH v3 4/8] odb: stop splitting alternate in
 `odb_add_to_alternates_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-4-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.3

When calling `odb_add_to_alternates_file()` we know to add the newly
added source to the object database in case we have already loaded
alternates. This is done so that we can make its objects accessible
immediately without having to fully reload all alternates.

The way we do this though is to call `link_alt_odb_entries()`, which
adds _multiple_ sources to the object database source in case we have
newline-separated entries. This behaviour is not documented in the
function documentation of `odb_add_to_alternates_file()`, and all
callers only ever pass a single directory to it. It's thus entirely
surprising and a conceptual mismatch.

Fix this issue by directly calling `odb_add_alternate_recursively()`
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index e314f86c3b..3112eab5d0 100644
--- a/odb.c
+++ b/odb.c
@@ -338,7 +338,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
 		if (odb->loaded_alternates)
-			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
+			odb_add_alternate_recursively(odb, dir, 0);
 	}
 	free(alts);
 }

-- 
2.52.0.270.g3f4935d65f.dirty

