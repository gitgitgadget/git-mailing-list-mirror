Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639F27EC6A
	for <git@vger.kernel.org>; Sat,  3 May 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299618; cv=none; b=R9CcE2Vn371H1YTou8lgaNoiM1aiz6Co9bsHZp6B2XREMuvj/20oUt5c41awHvM6efgnlz+Dr+bnHylWQMEJprhsnwFCyMBbIgY0/6qoF69tJHEb/px3O5XEXwveaUXgGnKZI7fIINv1AHiKC3QTW9gJ7abD9WEJLtkYdzEF8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299618; c=relaxed/simple;
	bh=DhOjiaB22/LYE7q17wQ5I4n6npPoxcWrnUe189J6/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QepwUEkMMOma/PuTD9MOKiI5lldlR/vngq5g6x7pdDi2h6HpEgMfBNocpQev8zuc0c66ldGEv7dKfuiiMZafbFQCgphktkaichmz0LpoG45GTS0nt3HCwHMDKU74aqggsyJ9opmzlYIU5B01vB81m3O+3EQoFg1SZO9dhaIBIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Sgvq60e9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XZnSSxqY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Sgvq60e9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZnSSxqY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 775F8114013B;
	Sat,  3 May 2025 15:13:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 03 May 2025 15:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746299615;
	 x=1746386015; bh=z6qAOejgEK4L7Vqra9wa9eDht2pS1VCZqCKovm0JBGY=; b=
	Sgvq60e9IgShe9ac1WIBMSm1kurswCmmIU6S3Gicq5KX9vFRgM3mXigwTKBMzGk5
	dme1fN/R491AYb4I/lyhgwMTY0BRfBdmRZbAanODOjksavq7lR+gxWUEKTK/CTwZ
	xzuA3IZOHd9AAKil/NYRAjrgYIaNTlNg+FFb0CZhSdFIIvcC5O6Ks0NSbiCW6GK0
	oCrUbHJMYD2MB+EoqIK6gXG41kjQuVc9mk8FM/BMy0ogaUDe8Dhd49hWdnPI/1dF
	HoatXnf0VMDJ99SM0Ex/+jZfbYarLxVipUC7tQmVo8zEuZB9KWkfIGU/kOuYfBgn
	F1vHu6+SSqcnlgJl+DksRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746299615; x=
	1746386015; bh=z6qAOejgEK4L7Vqra9wa9eDht2pS1VCZqCKovm0JBGY=; b=X
	ZnSSxqY7tagBn6X+mMA2VbK8WXNKcUm1yrdzEN1fWQmsV2wNKIOatT0R/nVKyUZp
	+l82v95r26Qd1GTa3HA3PnNbGY4eXF5JX2uGKyybJXWumZI10BROOdhEjjpB0+Lb
	bpoNlcrqzVT6avZpa1OmyC5Cet8n5IapyfSEjeUWp22/vBc5lVVOrsYhmrFYOwbP
	4K6Hvo1mDhr3GF6r3iuzDV5aRuIaresiX5pc9d2plGxWEHy6oekhVU+aDJhuJZem
	wFwm//xMh8dGEqNrHQITWtRvfDuknWXwe++QIk39x+u88+ZkvkBMp+pabXW8emE0
	xL/ldcWVv9Ix3CdtcZR9g==
X-ME-Sender: <xms:32oWaKyTInE42bi1MSMYdcunHSXt2u4i_zlxK4grfziqX8-yU-64_Ds>
    <xme:32oWaGSE68729QQaqZe0uDKNvE1K5f3LfnDztOYRsJqo5LemcckmfbeSXLq08Xmgg
    FxOL408oBQXtjbC4Q>
X-ME-Received: <xmr:32oWaMWOyW4YDPrgEktQqcEJR9Q94IC4BsvgChfleyrPYtr2GuGD440ICWUSHDyrTavMHcuLg_gqzol5i_E5DsSeuUCAo8iQhrBLyFiLZkhCIMtHNlvqm7klZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheeg
    fedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:32oWaAg0lvq4xxPh_gqVmAfIuH63WUJkDSH8YtqyvMs8HylVAtXMUg>
    <xmx:32oWaMAbV8iSdb0rS7gAcmxGN8-WERz8QXdkLhMgB24rCfnioihGpw>
    <xmx:32oWaBLt6yU50FEiC_PksxO5N8ZVwdIcnIuEzFksOgGYZe1Kp4RVjQ>
    <xmx:32oWaDCup7fWzuDJnzLJmWEVtAN0Q4mSpIgQfJfa5fhcvc2efxFXLg>
    <xmx:32oWaME45JidKmDucrTAfKf1evvu8y1X00GQy3_iJOPg-ClEgehanjjQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 May 2025 15:13:33 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/2] doc: branch: fix inline-verbatim
Date: Sat,  3 May 2025 21:13:09 +0200
Message-ID: <2e41f0f0f0738418375f77146e4b10e0e562d7fb.1746299135.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.459.gf65182a99e5
In-Reply-To: <cover.1746299135.git.code@khaugsbakk.name>
References: <cover.1746299135.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

7b399322a2e (doc: apply new format to git-branch man page, 2025-03-19)
updated the formatting for this doc to, among other things, use backtick
for some elements.  In the process `è` was used by accident instead
of backtick.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-branch.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 50a1e13e1f2..c0afddc424d 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -373,7 +373,7 @@ $ git branch -D test                                    <2>
 ------------
 +
 <1> Delete the remote-tracking branches "todo", "html" and "man". The next
-    `git fetch` or `git pullè will create them again unless you configure them not to.
+    `git fetch` or `git pull` will create them again unless you configure them not to.
     See linkgit:git-fetch[1].
 <2> Delete the "test" branch even if the "master" branch (or whichever branch
     is currently checked out) does not have all commits from the test branch.
-- 
2.49.0.459.gf65182a99e5

