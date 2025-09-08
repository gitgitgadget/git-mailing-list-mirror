Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8130E0D4
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346019; cv=none; b=CtdAM8U9n935pBu3RX95dqT4sdN/hMEgNAlQwO+64cv7eiKeFi44urZjUyJ5RmlnipPP6zd1rTmvRLjPFXEQsk3w+6Ps6rCEAbFNW2WqmZKYd4HN4PRH/h5roX6bsDMkHcm+gKkt00AmGfoerQvqPlaTyra3nqw1SSjismlAwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346019; c=relaxed/simple;
	bh=eZsa+1ZZ0/FrPPBMmO0vum7o5KwqIC9Ja+eXOwy5xS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYiV/VjJD3pEBkNTXE4yuzg0CRmViMfRkxVH4UZfqg5uR8M7WCv3RCWqJTr2/SWtZxzzyQWO7ffIPfpv/s0DvkMOWiFLpq0plKOcCIqyfbhTK7eFx/NjRbX/bvAjGEbgktNqhKsUCMpbAMublez3e4uR9+XnYxXYtmyiL0wee6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UvzNonEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ct0SgLjK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UvzNonEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ct0SgLjK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E6C1FEC00D6;
	Mon,  8 Sep 2025 11:40:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 11:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757346016;
	 x=1757432416; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=
	UvzNonELuBGj7lEfe0a5WcJaGr6efy/SCX6BDKITOZwEe08FNMwDoT3pZqUUsXMY
	R7H9CflkefkvaJ4bFD+nHlP4LLCI9fbzvLrbzEpF/P7E0dGrxZQBPOfJRnHnMEtU
	En0ULkVgH+9I3MaKbbH60HjJ4zhJJaTrBYrWn+PxsVaqEy+AhQZMXH7Jwho1V/es
	MmP/Zn4QonmkgXT/1BwI+NalayjhIBhdW0hTIyv5S/hOSJuMBbP7B+dJ7COLE3D9
	LDIYO8uDJlBqNrVlnBvh+cE/OMD5dnm0O2ANWrkoZeKEaCcELtBNmrtWg5kXar/W
	5N0pxTcN6uSUFgKldLmlSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757346016; x=
	1757432416; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=C
	t0SgLjKyk89GC4CF5/ycqHm9TvrsEGb9ULWoDW5E++eBLK3WZI6lyGEnFSYw3e5Y
	lz3ORITEXM/ZdMFRvbSdyzxVL7gMVDt8ZNS6TPEqnCMeavGqRZ/CANDBKvfgJQ2k
	YaOBc+3lyvSHnV8KjQwMsARV27BSsxQvePq1h3bb84KbD8Y0OE6EneA4UD6Ug3N9
	3jOmuc4T3fUsadd6xy5XJg3br3EfW62EBSHfBi83zlNCwhl64DamUvrBRmZ61MQ8
	hdLRCXYn7NG8vhQxPt5nI89/biBItLuo1QCerW3rhsBnWHLh4+jP5CI1BipBuSsH
	G91bTXVbvSpg5FIS6p+Ww==
X-ME-Sender: <xms:4Pi-aMQ5lW6Kx_hEg96RGbrySlbUCrc7Og9iEvAlYXuoJQFKOoGUUwU>
    <xme:4Pi-aEW-Cc6j8r-zRZUj1REFzomInEZeNjmojOjUIoQU8pI8OgqXUDkHgEl1Q_PrU
    C_gbn_8IITyRScpcg>
X-ME-Received: <xmr:4Pi-aGYP1JFefzu7mfSN3PVEKMknrUX_KmPRmAAqPF2z-eOpK3Ybg2-6Xf3HQOBD2snIlxT4qoil_SQI8fD3koEDOscaw4E-tPNfNSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:4Pi-aC1oafBMdipjgChOMUyaQgVY6Y08wdzByXihuGIfhfeUfcP7JQ>
    <xmx:4Pi-aAgXjG4r395fvPBgXmcSc6LMPoiXcV1D7WNkUNJ5ZJE1kychEA>
    <xmx:4Pi-aOYRoqE5lepNQCYyeOkn0TJXeb-t3sC62WFVvb943o01D7PJPA>
    <xmx:4Pi-aIQpS316bKsLX5gJhprqtHvMMur6ZZg_pZaZefGgaQlsvi5wXw>
    <xmx:4Pi-aJCa6ydscXt9wiWScXvanw4rtkWDtRU_TFRpVjM4cFWZLal-9ght>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:40:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 7/8] whatchanged: remove not-even-shorter clause
Date: Mon,  8 Sep 2025 17:36:18 +0200
Message-ID: <812c9870f1ba466ea001a05867b9b95bbc681d00.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The closest equivalent is `git log --raw --no-merges`.

Also change to “defaults” (implicit plural).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-whatchanged.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index e71d2aa2d27..436e219b7d0 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -15,7 +15,7 @@ WARNING
 -------
 `git whatchanged` has been deprecated and is scheduled for removal in
 a future version of Git, as it is merely `git log` with different
-default; `whatchanged` is not even shorter to type than `log --raw`.
+defaults.
 
 DESCRIPTION
 -----------
-- 
2.51.0.16.gcd94ab5bf81

