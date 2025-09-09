Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41522541B
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447297; cv=none; b=mzh6o3RZdUZ8vAOItj6LyDyupfplzSUolm9Fsn/TXy383AZ5MBw66g10WEo56TcydP04njGfwiao91fC3qBbvtNzovRPgfcR5Ky3/Cybp9PGc/HGHzgJAZS37JOmmj0+H2d05L2cijsCPesWG1i3XQ/M5aOFM52fIHuR+MOmgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447297; c=relaxed/simple;
	bh=eZsa+1ZZ0/FrPPBMmO0vum7o5KwqIC9Ja+eXOwy5xS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUk2Uk1iZurkDp+pT90ilC9/JvqVDmKf1cmhKLachAM5p7pajK0/qa0nah9m6nsAywn3ANK++FXcXeS++Sg7UlCedux5kvKImaTgqdbg4x33WoFgzGRhLJ44k4m+KO/6gKvr8XVNcUsqV1Mi6yAu/27FvEcD+frt+QKIRmxnrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ilrWnsq1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BVyOcH3X; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ilrWnsq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVyOcH3X"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1942E14000B5;
	Tue,  9 Sep 2025 15:48:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 15:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447295;
	 x=1757533695; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=
	ilrWnsq13+NGpZ6cAV6Iu0hLxxTWH/e1vATFONQHFk+f60WiiYLkkp9WQ5osP7PK
	lr134UCciuIzXMz8qJDbloY69qG2tLjLlYatgELDk4r6U8ah7sNa9O9c1UCMb8eZ
	yy4Y3DrUjbt5egWnAXXIpn0abl5XvlEvHSwRdHNoXC8cbytL4ruL1ey0kzQKj2zD
	ieT5KvBikBM/Gi3wLHovYRKwr5RfBuRNZWgZFxg6GEnptOC3Fo0IP9AB0dZWz55o
	8dmlooODQgPB5yxuu1/dbYyUsqTBQ12CYrkNJwVCJ14pmWQuEij2MUBpLvclF7UO
	OY4uJuYUhpJiZe42okZ4jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447295; x=
	1757533695; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=B
	VyOcH3X2cbxfkA7lh6++5WTA6NJzfXdErPthyB5s5sRiZxt2RGnGL5X8YKAty0vU
	LpZgT8uFaVRW2K0rPz+Pi9+GrTUyeXue+5D0WzKUFkHI5Io5fKEsPSdu+10cWp/f
	VJZV4qNE4GXklFJBvzvJjdlB97ltUpCiTZhmZBT0tfYJ27EPRbLZfcwRYo1+kT8/
	mv8+5u1xdLkQDnugH9TqudHpnoJ9EZ+4k0NEXC0r3j9zA+vMmpH9j2/69qKBAGAg
	QdWg6tT4qxcSeNyY+SVfPzR95C5yZGoElX65ZIokZ8ac4X81jkaXh1aBhk71Suu7
	nza2dxzqk0CykSOnpbEdA==
X-ME-Sender: <xms:foTAaN8ewPGh-RZhTnLv7U7DzMk1IEA1JIRLDNmh57imn4eXtoyd0mo>
    <xme:foTAaNMRMAXUBCjABIz0SPP9UZCwOmDvoQngKlvrroJwVJdtdEtpRncROEIexs3u0
    s2fR1NnBYPklntHrw>
X-ME-Received: <xmr:foTAaBdToFOR62uefCQwPOvHX8ZukyE5NYqJXjS1hmIU0ougYcj_3CDOnzBdPt1djSZlLPYbz3IWBHNS_YiNEAg1D5HTORUr-RlzS3SFH34wWPpBJUX1moZ2uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:foTAaMXHM2aeFdZZuD5F8P7u7rqjSQLCEBhVXzNsWOdbEQUTYeiIJw>
    <xmx:foTAaJhmHw28VY6lT1lTvB0N03nWTqU_zpTCD7_zX7Qp8fAJp_G7Ag>
    <xmx:foTAaL-G5IbCPjjTZhn2QjW9bw6I1qCRyIXvA5r9rDAabVVXrsTa0Q>
    <xmx:foTAaLY64pG7QO9tXQRv-qvUeWMo9-7lN4CM78BYXgfQhLwkOZfQmQ>
    <xmx:f4TAaGGDJ1gqFSwlx_yNya1-vDRfCRtXPrNllul4NBnLppD_zwTmrkfo>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:48:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 6/7] whatchanged: remove not-even-shorter clause
Date: Tue,  9 Sep 2025 21:45:56 +0200
Message-ID: <407b430d02c95c2a82470e76ec0d5d810169314f.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
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

