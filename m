Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED4213252
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380801; cv=none; b=KgUs6Shl8NRMRMEEnGmc1DTyiUy9jgEGodVE5VrxAwrRvEUdo4/fHRUbUmUmZKJAb2uQBF9fsKctCrnGnHRbZSfbnx8Rm2M1oJZxOcR6jPUFdM13A85+FRoV55HrC7pjfb+uqXj1/ahvVYnnVVS/AJK4wrPdR+exsazsjdAmvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380801; c=relaxed/simple;
	bh=rt9oQld5OfzMYH6A0MnFkx76vypwH2In32Yf96XTBKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHEXtuZDZV6CFlEkFRYUXYoTorrXTo0U1yUOQNuodbtQuBig/9ztCe7b6JCosRdzUMmhGqYBmLmbw33SAjqCuJIMsLw9rMWAQMPmwuDMWATIXXZ73mj52t6RKMomw74wYgCHP8nMFtipNiii8aY8/+TZF9OnITtL3fHPiEYDQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ay2G2jI7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qzEVz0O0; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ay2G2jI7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qzEVz0O0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 810082540132;
	Tue, 27 May 2025 17:19:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 17:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380798;
	 x=1748467198; bh=hXPTLxTWAjvSulMd55xMHPwYF5PEdwGFqcpyZdCh6hI=; b=
	Ay2G2jI73PCc5D4Z3e0h5bCJs1dsd0Ytq/1xOgsOS9FUZI24dOXkmDz9nliM/oCt
	P/MYtOJQtKqIbmtBQpWZLAsKYUlvnHu1CxYHRXVXTnfKsxbJ0UywlB4UqITuEA3L
	gpKFkv67T2Rcj+F4JsrJjqAR0gMdeXwlsnRpGRF89rOrfKBx7QESLIHYzb0Q34B3
	mMfHIKCT184ECF+Bt3IHhHSZ+/fG/xeIB/qTPJlUpXYh6EtgXJgBmx5LJJJVZZnO
	sUK768uS2MdUOonHB4UEEfjmAEoUGeMprwleancBORFVxm3EbPowQAu9B3HrUNfT
	8OEoRAL7v6zZKJh4cXW/eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380798; x=
	1748467198; bh=hXPTLxTWAjvSulMd55xMHPwYF5PEdwGFqcpyZdCh6hI=; b=q
	zEVz0O04FKyyXGEuQeRlLt3XmggiZu/s+a06WD13Kb189DU4f5kaQHq+ObBCjIuS
	hMx4p1VAs7paNbs4W2SdQWrERINC7PUJUSdyH7N+kBflELmhswZpSlP6qHRcZZtX
	GEx5Zm1ZtvgknOb027QfxHqk3fSZDF/OCPvn6TFqVbDnF9r76vkvVVgE/11Of4Qd
	oXbTvkDDMDjJ2BYZULLc0XH3jOYlY33rVm6E5AreWtKhWCXguNt52S547HZY1juA
	pdNUcWTL+h3vksZsdT1Znhd04yAeZBQoviVusnR/NUa9CYY9rh6lCGUBnpez/tHd
	wP3aTq/tS2KLuIkl8Q/yg==
X-ME-Sender: <xms:fiw2aM5sg_Au3h_cn8NiMAvpDyvBmlGxV2eSvm9LowxrcA1nEcfOFuI>
    <xme:fiw2aN6DlLV03w1URZFhWLJAbKuPDdKiW8P_EteKIsXSAoZkeGdzFHMtizXMLj_cl
    8oSCM-PWNQlYPvPjw>
X-ME-Received: <xmr:fiw2aLfxvcrf8XsNuy4j7DVw9qTzOKcHNkz_SA8eMsF3VViAbWy9v9awWIM9KddQD0CxsIsosk__TL4Ep2TeuwLGpP5RodXdWPZMDeYerpKX0ORJBox3P7cGFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeu
    teekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fiw2aBLBocVZUJ54ixz9dVw7hhaQe444Vs1zjdABVPTUb1baT79_7A>
    <xmx:fiw2aAIlMU6hUqnB1RmlhQABqfx_3QRmvKsIcsYjMkTyDFiXDDxzGw>
    <xmx:fiw2aCwq68zGGUNfWlNeCItL9vnS4eQTTgKwiIv4o-f_p1ksnDyEPA>
    <xmx:fiw2aEIOMgN0sfNE_00o2LPuUO90quIuRcQ3Y_MJI9QMrnem0S0FfQ>
    <xmx:fiw2aFE61BdL5xev01ir74KAsbeWmf43GpS3Ge0J1ys5inoVdj-ZPmRZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:19:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 1/9] doc: stripspace: mention where the default comes from
Date: Tue, 27 May 2025 23:19:30 +0200
Message-ID: <bf3ea7f23c08b5c477fedd42e2a0e518607c8ec6.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Also quote `#` in line with the modern formatting convention.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • More terse mention of the default as well as the configuration
      variable.  Don’t link to git-config(1), there’s no real need.
    
      Link: https://lore.kernel.org/git/xmqqjz6bhzkm.fsf@gitster.g/
    v1:
    • “modern formatting convention”
    
      It looks like characters are quoted with backticks in the commits I’ve
      seen by Jean-Noël Avila lately.

 Documentation/git-stripspace.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stripspace.adoc b/Documentation/git-stripspace.adoc
index a293327581a..37287f211f0 100644
--- a/Documentation/git-stripspace.adoc
+++ b/Documentation/git-stripspace.adoc
@@ -37,7 +37,8 @@ OPTIONS
 -------
 -s::
 --strip-comments::
-	Skip and remove all lines starting with a comment character (default '#').
+	Skip and remove all lines starting with a comment character
+	(`core.commentChar`, default `#`).
 
 -c::
 --comment-lines::
-- 
2.49.0.780.g892193c3f50

