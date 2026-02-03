Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFE37A4AF
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112154; cv=none; b=dnXXa6wLWJ51KAxVgDqyy4HP8dshlvpS2yaBE3wNHR49SRMvBL+bH7gSUkvnvqiLgcmyefYiacXluE364jcDst384PeWCxypHNotUx0azzfXwNvE+zdQckJYvNaW/vUSYuwFjoiB2Ejnrk0PjctfryOB7JEsTuGLxdVfElATMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112154; c=relaxed/simple;
	bh=igUTwi3JNrDC+9F0aHV4gDd1WkZ/TbRij0mCSPaIAfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPEGWTVVTdXwHE/+nosxqS1EckmGmDuUrrJhPBuYGVytGFBj5Zl2DDhcf8LthDdAuuPDgFUYZSVuVj1bMYD/MVx63zQLiv+v2SkzsOy2l6iYJvvK0KHjpwzK6LTVjEBzMnt+OpZY+/5efj1ZJA33gH2nq2DzsjH6BJQQeb99L98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=C/QMX3qb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/BvNsj0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="C/QMX3qb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/BvNsj0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B21E7EC01AA;
	Tue,  3 Feb 2026 04:49:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 04:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770112151;
	 x=1770198551; bh=W6ae3ZAdAnQp9OzixZ+K4TYYYwjnyv9LZ880X94dmvE=; b=
	C/QMX3qb4iIg9ouOFlObO49OTl7BGaXO1Y9neHNSDo9Js2v4/CxvCazYHpND4hIz
	Am6uhc/fvqpjFmJPvpxevgSk8sxd2E/u74ZE6Q1Gh+zV+jpchlRhY09ARNYPtq7w
	oiQe962gBOySg4mY0osnazv4Gp+NhAuNzCxyYmucMhROGTIME+TvW0P+did4zFx9
	nma4Ez0BoZu43ZIJJKFkHxiRRJwWU6QEZsvJaGJcmiZxbQO/pBrTl5Q5fKD8KD1A
	AcsM0rgcoHs1rCbyiMkTOiuCdhHdMXoCEBP6nFydpTpDkLtnB4KVbzJyn7gnkV+T
	Evm4YJyQsvdVe0fMU87WOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770112151; x=
	1770198551; bh=W6ae3ZAdAnQp9OzixZ+K4TYYYwjnyv9LZ880X94dmvE=; b=f
	/BvNsj05Q8259Un/JCEPzEEx2qQNF/mSouTbbH6GgnUCM36jQNzBPxjrNpQaPb4F
	S49uhCn1/m1pJriR6QntmLFTvPYMp1IoLTFD8N5mqkCJw75eCGau8gpQBWW8/LRP
	Mcc9HmECrWlhL1AMEqUhGHbIIxoCvPvyAQubnuBfPPGT6n2pnVc1u/QUcAcRxisB
	RL8AvS5+i1FwXCLJdtug4+y8eRkms0P1O8UwMzuHgcYorbxmNi4f2tewrcqpJx26
	8v7h0kxwv7aTLaeCpUqqi33UZlsRKuGncyeAL3Jcy2SKS0B8qCGu2T2r89rOYRLs
	2j/MVSCAjGGIbiW189xAA==
X-ME-Sender: <xms:l8SBaeMSAtbAdAqNyJxzOyVSDFQp4mc-wqHp9y4GXv_ll7ioXkIF9BM>
    <xme:l8SBaT-9TKIV888gBv6UBwuBEdxTynz4ZtD4YvjIfpGniIVXp61aZ9lnmQpxccZ0j
    x-Vju_Q4XmIgsb3JQJLy4M9aEqBmk6APmBTmEAQR8LEosIuGBiDQA>
X-ME-Received: <xmr:l8SBaaQ7sZKH-AbkbnhTOuk8tgkYmPVgU-tPtoiAWnAsmluOPAZrUG6-AydYKtM_IkHNKik32ZtvMADQypb3hiFYA5_VSSKftIDNlxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhm
X-ME-Proxy: <xmx:l8SBadnKW71Ay2KQ9_wFw4wJrUZ86HGGgcx7psMuqxmuhLElCMQ9aQ>
    <xmx:l8SBaSSKofOB7hChL2AU_rFWQuS4DhW1IkLDmpaVxnuYRjHvkgeoNQ>
    <xmx:l8SBaTN3qr3WAQ3ULvdjjF4o_xzkl1IcV9sUylrJEiYS2vHjuwa4nA>
    <xmx:l8SBaTWmm40cTGqMt7QnsmdVzGqgeRtuUkt7RLfXF0gdsNhe1FWWtw>
    <xmx:l8SBadzWsXaKPaU-uW-bFkfU8tZT5DzAubTHO1mxkFbPfMtWn9S-Be0C>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:49:10 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] doc: shortlog: put back trailer paragraphs
Date: Tue,  3 Feb 2026 10:48:52 +0100
Message-ID: <V2_shortlog_trailers.254@msgid.xyz>
X-Mailer: git-send-email 2.53.0.13.gc85a2adbf80
In-Reply-To: <shortlog_trailers.253@msgid.xyz>
References: <shortlog_trailers.253@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

47beb37b (shortlog: match commit trailers with --group, 2020-09-27)
added the `trailer` bullet point with three paragraphs.[1] Later,
3dc95e09 (shortlog: support arbitrary commit format `--group`s,
2022-10-24) put the single-paragraph bullet point about `format` right
after the first paragraph about `trailer`. That meant that the second
and third paragraphs for `trailer` got moved to `format`.

Move the two paragraphs back to `trailer`. We now also need one blank
line before the final bullet point so that it does not get joined with
the second bullet point.

† 1: Technically the bullet list formatting was immediately fixed to
     include all three paragraphs in 63d24fa0 (shortlog: allow multiple
     groups to be specified, 2020-09-27)

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: add ack

 Documentation/git-shortlog.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-shortlog.adoc b/Documentation/git-shortlog.adoc
index aa92800c69c..a11b57c1cd7 100644
--- a/Documentation/git-shortlog.adoc
+++ b/Documentation/git-shortlog.adoc
@@ -64,9 +64,6 @@ Each pretty-printed commit will be rewrapped before it is shown.
    example, if your project uses `Reviewed-by` trailers, you might want
    to see who has been reviewing with
    `git shortlog -ns --group=trailer:reviewed-by`.
- - `format:<format>`, any string accepted by the `--format` option of
-   'git log'. (See the "PRETTY FORMATS" section of
-   linkgit:git-log[1].)
 +
 Note that commits that do not include the trailer will not be counted.
 Likewise, commits with multiple trailers (e.g., multiple signoffs) may
@@ -77,6 +74,10 @@ Shortlog will attempt to parse each trailer value as a `name <email>`
 identity. If successful, the mailmap is applied and the email is omitted
 unless the `--email` option is specified. If the value cannot be parsed
 as an identity, it will be taken literally and completely.
+
+ - `format:<format>`, any string accepted by the `--format` option of
+   'git log'. (See the "PRETTY FORMATS" section of
+   linkgit:git-log[1].)
 --
 +
 If `--group` is specified multiple times, commits are counted under each

Interdiff against v1:

Range-diff against v1:
1:  e3cdf4b44ad ! 1:  3383edc5164 doc: shortlog: put back trailer paragraphs
    @@ Commit message
              include all three paragraphs in 63d24fa0 (shortlog: allow multiple
              groups to be specified, 2020-09-27)
     
    +    Acked-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2: add ack
    +
      ## Documentation/git-shortlog.adoc ##
     @@ Documentation/git-shortlog.adoc: Each pretty-printed commit will be rewrapped before it is shown.
         example, if your project uses `Reviewed-by` trailers, you might want

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.53.0.13.gc85a2adbf80

