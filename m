Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EC23643F
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564948; cv=none; b=TNiTpkMq0eif9GPlJ1cZOcpvImqKLJ1LSqzp/4HVokLj9LmAcYBkRlfBqxdS0x0Rm6LiLhVDCQadcW6aX1dEAqwmWhBqFKIfNozrxnAuMmoxpqVvHh8o0RC31UFdZCRYBKnwH/HV9rO7IzbOjZ5dP6ygDfoaEIAx8K+/un9GfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564948; c=relaxed/simple;
	bh=XhZ/bCkHeb5ZHQymNNyO4nPJyDkMHesb62KPQSPJd68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZT1eHuUeyHA8QVq5eeoCRSUwAuVJmRiHuPSpGOWoMOyk3LE9zDSD2UvdbJoJJWDgnOJrf+p/H8fzr+oUK9GPbyvc1q8h4+PCMlDLJR1HtBtEfFwvqqidZXfCJONVSep1AzwmFwCZ3pl7CXvaeLNOwUisJQtI9E9R4GPfkWak3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DvncJVVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flb8Reug; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DvncJVVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flb8Reug"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A823C11401EC;
	Fri, 25 Apr 2025 03:09:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 03:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564945;
	 x=1745651345; bh=HJEJ9ja2Xdl/bRzje1OJKAZbRbdH7jNUlGhDdlp7DOU=; b=
	DvncJVVGjX1e13aevM5hxl8855BPRRdCVNnGyBUghJ6rsCPNGB+XvS6YJoHkHNL/
	/nZSvBGtdeJvI/gMVBqFlqFey7mPILia9nX3wUY2EGRK2QM94UwK/AgCu2HxY2Es
	UqvQgiSLv65g9jdwHMbZ3C30pD8Cv9di+o3A9oWwdPvI6s791rz7SHWwODJMwoQp
	u42oSvhNVM6ef+HFlHE457Umg7KTpuJ5SkGqY14kNAZ+t7D4mPKw6Z7YxIwChQ+p
	XkbHFVXFDeP/Vf9wHuFY8PLlmfm0YCKFHg1e8MnfBYzwL2G696d4z/GFXzj2a0+1
	gAZNwvmUYIjRAYHS74HP1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564945; x=
	1745651345; bh=HJEJ9ja2Xdl/bRzje1OJKAZbRbdH7jNUlGhDdlp7DOU=; b=f
	lb8Reug2SoWaDzWrpohenkxiCP+DKlSm7u7MkIsK46+2ai/n1dysJT0d4eX14dbD
	o8OCg6ro1fU/QRIuNYB2V140eF/3hVCGZiXm5AxbIf1iGBSC8LUjJRlqufFCAQ8M
	0EZNvpU8AI1xZLnGYAL8e3/y/aB9Ou0bBeGU7VBJH9TzPweYDWmCM+t/nhnDOIsF
	zO/s1XinLKzB56VSqgPlo700AaEO1aFGC30NotCaorU52+6wHiKQgYt1tWG2LQdF
	YwV9/gjD07TfS0+ONDYQaV0ZdZgJzxVOSk/MLOOhRX1n7yK/DS1fhkFh1zDXWiv9
	lpnlePNt+HU98s22J0DGg==
X-ME-Sender: <xms:ETULaFUn-66mgBL3uY0BqyVwQCXvS-C9E6AeOGXn3HROlvVPXsHZ8g>
    <xme:ETULaFk5mGZyu7y8kC7_j1x_sAplG-fT-uBQit4nM_tMCzOjWptvQKFt5fqb7NBXw
    819sk9p5WxDWoc8eg>
X-ME-Received: <xmr:ETULaBa5wnV0b-B03T70AJecAwKFtn_BYGsA7todXQUpSck31P2G0xwzZ1rxwoyPQe31TOk4yc3-4qb0fiAyZmpvjJY93nYDa_h-El7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ETULaIX-XQ8f9HU30CV42V3SlREUudeSuLyhet7myYLnncmhumr2fQ>
    <xmx:ETULaPmgkDIlI76puGPoRQcI_JuRD14X__mgBAZv5i6v6LqvrTin-A>
    <xmx:ETULaFfcpkxe-RmhbR9mh9ohZCV21zRu4ZkmfoQwC3a3NZ3_LeiuOg>
    <xmx:ETULaJGM05H-i1I6c2kph6LGEDlsjYugVaWbTunkWUeRa_LqZa-0rw>
    <xmx:ETULaHCqfFgDl4v6epKtKyOSzO0b8SMn5KwFEPZi1ZfjLjPwZbMkKH2k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62816b05 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:59 +0200
Subject: [PATCH v2 08/13] builtin/show-ref: don't fetch objects when
 printing refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-8-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

When printing references via git-show-ref(1) we double check that their
respective object IDs point to an existing object. This check is
performed via `repo_has_object_file()`, which knows to fetch missing
promised objects in the background. We shouldn't have a need to fetch
such objects though as no reference should ever point to a missing
object at all.

Convert the callsite to `has_object()`, which doesn't fetch promisor
objects by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f81209f23c3..fe592b4c202 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -35,7 +35,7 @@ static void show_one(const struct show_one_options *opts,
 	const char *hex;
 	struct object_id peeled;
 
-	if (!repo_has_object_file(the_repository, oid))
+	if (!has_object(the_repository, oid, HAS_OBJECT_RECHECK_PACKED))
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
 

-- 
2.49.0.901.g37484f566f.dirty

