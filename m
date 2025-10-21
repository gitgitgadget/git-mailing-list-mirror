Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C15BA3F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056173; cv=none; b=S3IgqYVI9jNbfW/GsFtqi5jDR26ynn+2do+GoZ/ZjfTmqsEwyVWfXsgr9lDVkzHaTypLRNcp+LWvzOz9Zw3zclH8rTV8sD5tm4wNapFSfBscBWiqKQ/NqvlLDSlgAzPYms7AUBeEgWhoOZmd1kcxa0iPAmVB4Yr2kaFc0FD98zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056173; c=relaxed/simple;
	bh=DZnchXmmZp9zRJ+hYF0hEWOmXC2HLrZRLZ5hxjjIIhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iI7CPr2+oVesBjtHwQaDy50bO9pfjQPWfTMS7W2dOmToKu/bXJdrxQT66CKNP2j0rj8tKx83c1bceCz10VPyE+3OCexQkNLvWCykV4ZcQMRosDZuffjK7fk4qgPfRZv1wTtNSlwtx6VTSC/wPAC56Knu05Qm1W4/OLhH00TDvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CY69z/pO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3Oa/O+L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CY69z/pO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3Oa/O+L"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81FBC14000C5;
	Tue, 21 Oct 2025 10:16:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 10:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056169;
	 x=1761142569; bh=RoVvEDjuWukLlq89HRucNGNDZq2PKsZNncxh/7RSk3w=; b=
	CY69z/pO/WkuxvGd09klYVu5E+VMcIaiwk3MqZIbEwkN26JUXStf3MHTfmDpBxuI
	w2o89KjriG/CljcWvhzCOv48QRDbugMgaiwE7E8W0pMnJdxNtG6vnIydqHQGn1Fw
	3evIhhMiV37WS3GYUaK89e9tj6wJM11pSYNisQ3NKPQWgBeFyhb5Ahrz+kZeMGyw
	TUP5Q0l5j+wHsTvNJPc/AYdMOsURR8fBFj219ylPHSAsFt6EbyWcGmh/2ZJCsoF2
	aUwDAvjjhfASwNvHSv1uNAA9VCjs75Z5pBUgj+dwdg99+JUh7ewnySF9NqC5oaL7
	+JeUF7SEa5ZPo1g4OZ2+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056169; x=
	1761142569; bh=RoVvEDjuWukLlq89HRucNGNDZq2PKsZNncxh/7RSk3w=; b=s
	3Oa/O+LFAqm72XVSsKh/Xsc2GOuPX4eH2QwpS2xLl3v6Jb8S1xZXrTbhPOx3nKGk
	cZsAGXkB72PjktAAt81e0l65fB7M1yEjlRVhj8AanF+22OjWVTL3Av2q2uvgtkk7
	ahS5Jkkp71bzLlkkCatL0etfxSdq75urLLKxbIZuAEsaXHJ+/N9LMEtvz1eGhW/4
	pCs5nAaVPZlyo/6rCsZPAAlw5drCWA2miAL7BLtLixxRqA0XnC8icj1I8Wg5b7b8
	tYN73UwuaMY9mUCpDoqh51MYtk0cSVlRh5nt+91RJDMU3zGgDjUrOjdNmxn4tgv4
	QPXQ/W7V4jB6gTjOzWERg==
X-ME-Sender: <xms:qJX3aA324hGUyxclQyG5x5d1D1Qr5dLdtKAKIuGLcdTWkzh8NSiTDw>
    <xme:qJX3aNpRYtPgJYSiuB1WppxWRnklYgM3INUjiqsOobm9qI665pkEg8x_lc2PczqPp
    sOiy4eyH_YXA3oAyQr49b-6YnChjE2GIaLing3m12s-cxTR_XWjbJY>
X-ME-Received: <xmr:qJX3aMiKfF6Fyg4rOfI671hWpLXe29kF5jeSBipMjwh4S_3ZtVdCTCNo-XZdAaFg2xU_-mhLK5uNllOeTqZIb7RpFIU28ufoXM45WXUHHqmzsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhii
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:qJX3aJ98o42fjj6EwIAmjhpp_bYopTQomDQgDJBXKzPGBBB39wq4QQ>
    <xmx:qJX3aIUZp3aq3rebu-uXaAu8rZmHChrK2NA4JkDb0hzAEOxKMCU44g>
    <xmx:qJX3aNARUZQqSGxlZWCtu6NhW2TDkv2bQGVfZckr_hgEPUrg-5JWZA>
    <xmx:qJX3aNFxTJHhyQGMNC8HqxM34kSy5lJWhGRgotzbo1jii779KHWYMw>
    <xmx:qZX3aPy1HKAAOePwS55lYbAdyFTv0HtPygSp4CG7s6F_IX8s13Btfa3p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4008f74b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:52 +0200
Subject: [PATCH v5 04/12] replay: parse commits before dereferencing them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-4-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When looking up a commit it may not be parsed yet. Callers that wish to
access the fields of `struct commit` have to call `repo_parse_commit()`
first so that it is guaranteed to be populated.

We didn't yet care about doing so, because code paths that lead to
`pick_regular_commit()` in "builtin/replay.c" already implicitly parsed
the commits. But now that the function is exposed to outside callers
it's quite easy to get this wrong.

Make the function easier to use by calling `repo_parse_commit()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/replay.c b/replay.c
index 13d75d80543..c3628d2488b 100644
--- a/replay.c
+++ b/replay.c
@@ -90,6 +90,9 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree;
 
+	if (repo_parse_commit(repo, pickme))
+		return NULL;
+
 	base = pickme->parents->item;
 	replayed_base = mapped_commit(replayed_commits, base, onto);
 

-- 
2.51.1.851.g4ebd6896fd.dirty

