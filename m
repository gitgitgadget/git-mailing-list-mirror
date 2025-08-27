Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD24139579
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312266; cv=none; b=STD0i74bY1JuYlbdt+An9Pgd0G2i+bK0RPf3jX5EY4h4xL+FALaydM/Ro0wOHNrqTS+INQXdmjZCsCIvRPWy/ZDRC5/El/VWDutUwu1UmqGMGmlW6n9Ja2Z1jM0Bn6pN8MXB6wpnJ9Nqno261wBqyDArFpmfpS3Q4LKIeV5tpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312266; c=relaxed/simple;
	bh=APlmG5gLMyquIws0ADluGgSoq0CU3wQfCt9ZFQ6IZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eluc0/ZXrzkmQxJAT6L3HN8oKleAXyd3awSV9h8LdWGkyMmgx+6B3phzDt8Abc18ewlrXz0WvqicjHxmxYV//1kgIXcqhM3JFx4jgZJPveIEjawh4SyfOevPYEoJEchddpIxE7HMYi55LPcYa1xL39aSXlY9rZD1H1QbDRZ2Xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Jw6Es6al; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQDny8F5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Jw6Es6al";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQDny8F5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 01C65EC00FF;
	Wed, 27 Aug 2025 12:31:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 27 Aug 2025 12:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756312262;
	 x=1756398662; bh=8Ax8v3IVxOOjkOPbodw8bz8yTo68ANqQYX7bgTHve6o=; b=
	Jw6Es6almBhy1BqOO4eH7nN91Quga9PRaRILdaxt28AatfCwRn8RCekKeklnEXp9
	3OLWNPPk8qlvfXGgU7tn3slygSKdti8FCQC1BqX/Q+eHLcZ44mU9s+5EN741lgRg
	RoqFfX2ImMNYp8VYiSI/CPF6CMnmwq8UJI1qGbj/mmp7bfzFj1KgEtwSHP71ZZiN
	G73/hkbr8bRAhek/fEqZsasLIx2c1AL/AAmxHepJVFMtTyKfoEmnkpWQRFab0mjm
	hZxikDI5UOOaJMg1EYLhTfgCxe0WTr7tw2ZkYYxXW/Wdll4Txc0rvlvh5LtfVFGI
	xtC30fE8xtJWLsndPaFQ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756312262; x=
	1756398662; bh=8Ax8v3IVxOOjkOPbodw8bz8yTo68ANqQYX7bgTHve6o=; b=W
	QDny8F5Bh5U5gpr13AvDwP/tmmjFLhdRD6s+yHP4jKvqcfgFxVm5EGXb3YbVe+A2
	/tDAgfCmkT+bALDmEUmhOpd9qoe0b7VVEZR1L1Fkz9lMT/l4JtLdSOwWr4NlC7PL
	QjSijJbNvcjVV26VOicFL0iyyD9J4Re34DJEKZKjrwMoSlAjH9h8pnhUCdNgLcuW
	Onvm8eCwQU790cUkLnfwDz+aLOrn42QIlk0d6NugZgvVv242x0EIePpSn7Irkmv7
	OKcSVDXtkLWCFaaj6nJ7KpCxCB+4iqMVTuq4DgLtJ0BLHMnTKn+IyqOwcdgGKD3Q
	mf1Fbi44fHhNoJ0qaBAfg==
X-ME-Sender: <xms:xjKvaNbUqDQIpHm0549tt6pplzyMItjwKQepm0rmqnRnTRPr-jTnYPo>
    <xme:xjKvaEnZqxitiqktVlo6lPIGxPZWb9xm80D0AGZ3j4Y3O_HMoCP0mSKh8aHogxWM2
    8sFFLAMSESj5OCgRA>
X-ME-Received: <xmr:xjKvaBxjiavyt6jkr3q5x2Xjd6DUGyLUGurHMHOpHjOi2Vy8HU1QE_AwbXTZQZ1-3cwpJ4slNN3_4hteNffLemBdLWde4DFZolRIlvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetie
    ehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:xjKvaKPYIAjVvquHYBtNj3Bh9TfviZYxeDnc6h2X54GkXqUHlKUFxg>
    <xmx:xjKvaNSaeqaHuJ2e5Pnik-VCF0mS4vn-WvPAl9fU-GsEj2aw7HyjeA>
    <xmx:xjKvaAYXU3jWMFJgplczZ4_c7XutEmrC8CiNnmgMH2vaAMGMwD6X2w>
    <xmx:xjKvaC0pagGAyR39mhaBiZb565h96Z7hiTwVG_iXJmaQt053JC8Qmg>
    <xmx:xjKvaH_zgq2czKYtg2BEn8oDII9IHzBdERejcH8YKzS8icGvz0yCfPrg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:31:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/4] whatchanged: remove not-even-shorter clause
Date: Wed, 27 Aug 2025 18:29:48 +0200
Message-ID: <5fad164d7d1333feabe644a3df1d491648001f9b.1756311355.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
In-Reply-To: <cover.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
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
2.51.0.11.g23cedd8a747

