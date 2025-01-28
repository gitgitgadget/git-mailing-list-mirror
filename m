Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0851DF74B
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053700; cv=none; b=YVhfDyqydaSCH0zb/dg+7rNxYsWGkpQ424veKvgQzb8mlckwWsJiqQgZ1pGiOQOAboSFNCfHvwktidKdMw1YgRp17jUOeJOciftn7O2tthCMnd1ToPV5mYtbJx4wCgoSIAsfmwkaZotvzN8iADGH2a3F0rFFACSeX6b7B6D1/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053700; c=relaxed/simple;
	bh=121J9JWOr5jf0VhEvcgwA57p85egwHpHhICEV7Ps618=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUw1N1qdI+nhMHw+EXx/LaSh3gWWdiCrdRV9APuHAfeBPB3mG9cQXAK/3W3hV7qYmucziKYgzux+7V7yQxtDvhd3Mqn8LMXUMsUBqB9bCF40iP9nncxIW68rvUIOa/FWpyH6AocQrJOXhlRN7qsWtirPUKtSydPOwEjh+PzDFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pGeTXwjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HIFn/9lS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pGeTXwjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HIFn/9lS"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CCD111401E3;
	Tue, 28 Jan 2025 03:41:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 28 Jan 2025 03:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053698;
	 x=1738140098; bh=/TKmkuRQ8fCGfId8LqblSiLznYgf6b2p18zJFiaqnJA=; b=
	pGeTXwjS/pVZVFNLZnPEWZgEeK96QUZcZJ0qRZ1eq+aVUPsQSYDBLcvF4ByrSn+e
	26c/sQ2snyTR51vS0islWoeWhO66OC/7lT14fgNkcHfq6lO2AvFGcFlSQgKdTvj2
	ciD13/sR3Q87thg1MhTUGVThgRhaSBtV70osch0IEfKFfyVBj4cfEcfHWk9bCKV6
	nTBRawTOhRjPDqu5z6UZ1ptypzwGbFtPhma41IYvCq5lSc/nRiw8PZ3iq8/Pxl1s
	wN9G4glYqUvRQNhvM3OlANeX6TORMq26HGfbS9Esyq5kieWbRxUV5kcXsatDZQtU
	g/mg+7JYoKwljB8srUR4Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053698; x=
	1738140098; bh=/TKmkuRQ8fCGfId8LqblSiLznYgf6b2p18zJFiaqnJA=; b=H
	IFn/9lSD0oo4VoWGGmhnnpJUeyrgIm2AQTU6dIqgrzbxExeODLLLk//LIdd5jYo+
	PRTnLMRtcTmsV+wEv7qC8LbgnSvnt4q5HryCcxz+Bjw1eQT0oeVNzCnhMb1BqfEp
	L4jPulUqjIbgBUuud8sbjPjQl9zRs8+FOQq+sHGkb/8fVfT1zyvoRmsKY6sah15h
	b1ir3N6/9BaQkHh3qAuAXwRaoMQHS/v2Cew8FxvNSUNFEG41yXJaOdoMA/9ukn4D
	lCUGwLxAKVnQEp/LAv/L4mPOnq2jDe7HUitFxcJDGkPFeU+U5A+W3a2FCq7m4L/P
	ReMzPecNgJjicMV3LwNgQ==
X-ME-Sender: <xms:QpiYZ_rVM0vlyH8fz-hfBGIfJ9pem4KDH83D3q5nefUj_mwRAPVPjg>
    <xme:QpiYZ5rTvu0hzAVWMeZDYIagR9t3fNG64vLUUMWxCbssarEI48sJ5uWD9re5dl-A7
    6AJtDN3ycrUlsmpQw>
X-ME-Received: <xmr:QpiYZ8PMtEEN9L-ehDKgzWOEmYHjr3JMp82Dg8rdXh8jXHLlZOnLAeYoNnjIdKFkllKDBAe2yw3wCy52-ZmKL0NK7wY8w_CcCha6k_XhTG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QpiYZy7NmYwHI8OPLhuTe9gxPPhkTFjkAs9sU-hQUO_Te8eJtd_-XA>
    <xmx:QpiYZ-50f1JTYM39nMTOsZMeP3M5NLKYaDqukcuE4OdDj8L53g2GGQ>
    <xmx:QpiYZ6g5oVPa6TlBy-7QTTlqp_1uo5D2pTiJicCdcGu-suWFtzBgkg>
    <xmx:QpiYZw4O8L6K9YAP3I296AhFj7BKWxckeqYwhR-bNkz_Y4SWevR9hA>
    <xmx:QpiYZ0ksiH3NA7AgjIlNtIpt-qHB7kFf7krEx7xnW7PSluM9qIgpSO9j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e90ea057 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:33 +0100
Subject: [PATCH v4 07/10] git-zlib: cast away potential constness of
 `next_in` pointer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-7-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `struct git_zstream::next_in` variable points to the input data and
is used in combination with `struct z_stream::next_in`. While that
latter field is not marked as a constant in zlib, it is marked as such
in zlib-ng. This causes a couple of compiler errors when we try to
assign these fields to one another due to mismatching constness.

Fix the issue by casting away the potential constness of `next_in`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-zlib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-zlib.c b/git-zlib.c
index 2e973320c2..651dd9e07c 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -59,7 +59,8 @@ static void zlib_post_call(git_zstream *s)
 
 	s->total_out = s->z.total_out;
 	s->total_in = s->z.total_in;
-	s->next_in = s->z.next_in;
+	/* zlib-ng marks `next_in` as `const`, so we have to cast it away. */
+	s->next_in = (unsigned char *) s->z.next_in;
 	s->next_out = s->z.next_out;
 	s->avail_in -= bytes_consumed;
 	s->avail_out -= bytes_produced;

-- 
2.48.1.362.g079036d154.dirty

