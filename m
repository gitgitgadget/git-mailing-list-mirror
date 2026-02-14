Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB44284896
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771070245; cv=none; b=qJA5tAR6l1aOSF5VNG9Hz2/JJFhhK/56YSJ0E6NjG2ChJS3XbgBFOTLXY9RExDQZz3NvLavDn7/XdyDnSehKxtczcKpxIxLeY/ltVkSdcFDz86u6d4hElG421IoCc2ylCKY2jP8b8hfwMuIG6eJQbPNcxJdWbjeRcF9hgtTLsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771070245; c=relaxed/simple;
	bh=QC1XCl0xBw4Mzfs6vGAKKuu2xvtJ/9zIYQAcuc9KaJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE3VtfND5P2WeMPRneeWK2ObYAzqdaCupK6/sEsDR4L1UiqkDSyhsnXYVBTvRMo3AyMLGRGQPFFWpspB1KkcUoHj8d05sW+jFaaCJhyaOfwJ45aqafLNThCEvaKtDqHnPaCF6UGwpeARbZRHnqUmVxUTkXEmK94NyG4rS9ctyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LS2Drd/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exE8071+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LS2Drd/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exE8071+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF5C87A0089;
	Sat, 14 Feb 2026 06:57:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 14 Feb 2026 06:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771070243;
	 x=1771156643; bh=TiQN5U2QyNv42iWcmhN2oRfN1KTbKq+iiDq41uOL09w=; b=
	LS2Drd/h0m+ndSpoEfqavTWr0SihJPMqqR1vsKm2e9kEQnxYEtp1kVRgHOKKy9Pr
	dW+q5GWPBZVHdqwsv+uqP/O46O2kNITXmTlP6zY1ttzi7O8CTsfPelvXb+kXcms5
	x+tc4Mp87QRTmbH+iyvoTRDAA4VhlNPf76N8a5Yy5F6oJpcy3exB4TtquTKlD24y
	lsSSZjv/grYlX2W+sQmLZuF6Xi7EWHJdW/Vhgkagj0NnUeqRkuzGWZiHCobRPggU
	+a0k9L9UyqhgDnThR93P1elfB2026q/gMHtoFgtfpckmybGvIgwZNhd7SBNO6CT5
	lHVWCu2tUWsA0GYWLDTwKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771070243; x=
	1771156643; bh=TiQN5U2QyNv42iWcmhN2oRfN1KTbKq+iiDq41uOL09w=; b=e
	xE8071+tExP2vcJE1bX8zgi4lNB2wCX9jusLqkhi+KyjDGrlDGp7hlKi1En3OMEC
	CDjs/Efslf5LYzhq/sNYWfhPmQfBqAXI2v07Cs4DsUkL2swNdWW7I0GrbVskdpvz
	4wCVJZUBC2Ei2466HGxjWVswI/3m86H4Gi+1GSLv9+mJxj0wQZPCqZ/0EBwgjyRc
	4GccsOuv0RCYqAboAgE/B5pwF7JZwwFOoZeH32CeIoBCcTKW9Efwbml33Ep73fYS
	sUReYsyHeP269azMib53HvrDNNXYUJg8VA/CdY/iq5iZ/n1h1/33kdQ1sKM6CsHs
	O8dAlqIn+EoCj5X56MoaA==
X-ME-Sender: <xms:I2OQabsvQ0cVDYC0s8m5hxZzeM5nZjB93PxGG0fD1xUsOmjgiSrN2Eg>
    <xme:I2OQaTcVEEKdtP0LvOOAh3aFEAh8jf1OW4oAehlBKjjWmTJBCnOzF82QvWrZksH6w
    hRpOJMScOT7MM0YM24sXg9JdFyPAP2v-_gC1nYuT7qPe-isZ9itVw>
X-ME-Received: <xmr:I2OQaTyAhkLaJoCKI8vNXpv5LeEDfBK1scY86TQwNGZiAwRUfZjL_4YOb8XaCuGI0ZLDKvpRjv5VgzSUXtF7GeCsigKZsAvz7V0Wb24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddutdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:I2OQaZGP6kLLcMx6z0vHgBMNvxLhje6GREErP8Pi6d_0yVT6OfX8Lg>
    <xmx:I2OQaXycyP-qS11dPbD0wl7wA2A31vBPw9PYYBRqz_bByncIBOlELw>
    <xmx:I2OQaatW6D1U8jMEY3PoDw1oQiYs2otLQiFRwzzWgUu8LoZmRbzKKA>
    <xmx:I2OQaU2cWdHDu7V17QW1V5HiJfXxHmc6Q09X9jdSv9D31a4j0t85Iw>
    <xmx:I2OQaeS63TrJXR3CBgcXVTuZiunEsscdQcKTOgtsRpfbTsQQUSA34PmR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 06:57:22 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	ben.knoble@gmail.com
Subject: [PATCH v2 3/3] doc: patch-id: see also git-cherry(1)
Date: Sat, 14 Feb 2026 12:55:43 +0100
Message-ID: <V2_link_git-cherry.374@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <V2_CV_doc_patch-id_4.371@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz> <V2_CV_doc_patch-id_4.371@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-cherry(1) links to this command. These two commands are similar and
we also mention it in the “Examples” section now. Let’s link to it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 1618994e76c..05859990c8e 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -108,6 +108,10 @@ rm "$for_upstream"
 Now the first column shows the commit from your branch and the second
 column shows the patch ID equivalent commit, if it exists.
 
+SEE ALSO
+--------
+linkgit:git-cherry[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.53.0.26.g2afa8602a26

