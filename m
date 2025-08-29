Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B982765D7
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480954; cv=none; b=fSwHR+5/Q3or/2iQm2t+ufDktsAJVLTxaTDSH/cDBkYCogdC1EGdGuwy6MDG6yVdNawxTXxX8lRTf6mLQupFVNsaY0WUlKu57RoLMvcHCFHT2pvvuNzS7UmHAhF3gjaU1t9Lo8ubLv4RB0LnjgRZksmrO9P6UWjuTTmMuQ+OyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480954; c=relaxed/simple;
	bh=eZsa+1ZZ0/FrPPBMmO0vum7o5KwqIC9Ja+eXOwy5xS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5MhVIiOuedJGJgQKfX1tZNsmIdFo9V/jrc1cbwz+l+k88lBC9cSqJnYnwRV5XvisDZxRU6k+oYSJOONd6yHldJ4JdINKHPYqpQphv12vPN3erTHNDAGTSedy7ml/6NEYVzsaDul+xLTqxvYYglPxXTUAPn01C9h5yJn0tAB0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BTNJ2yo9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rau0L/VJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BTNJ2yo9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rau0L/VJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 05826EC02E2;
	Fri, 29 Aug 2025 11:22:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 29 Aug 2025 11:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756480952;
	 x=1756567352; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=
	BTNJ2yo90+pJoXD96lGSLO5pAzCtU8m2KI7JspbPDDDLk+PH9On/pkzRh/zjFKRj
	4BiArLpZENqc6HHQNeXRZ23uXj+JwpjXvldlb+T9Jc8nZwTLL6jdy0lNC6QLuhZz
	hFElc7KgpSDV8CKC0XM79U3ACNnN7XXNqGa8JZ0Ksgw0iFmHdQAkxDtgeq7jCnaO
	tUToi2aXdf4lPUnOz3EL6bk4KsegBurKaOU69wqZSP/3TawvZQimg371NrWfcEDK
	4e76iKKZ1wYUARDoebBbVFAjW0kxBXXrX79vQzBITxGa5OUGFR09cZziaIJrJExD
	BVR++EW+sEk3gAYuYyQyUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756480952; x=
	1756567352; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=R
	au0L/VJI6bxRIqn1I4x30A51gvz02QfmQT++Qqk2DpzxjolOsRWZD+nWD4apktkM
	1/HiWVP3mibEHOraFkbFL1y9RSdhcNSFXUAzUTytF5CtTGRWDneE+vZN42VBrIbX
	fqDn+HC3/syPMmQVBO47YMYC99tZcwy720dwFd9ybdCuH7pH1c9RJNR2NG8FgEIF
	JePXslZhOsn4mt4QmyT1CNlOzkz0NnNIOmIiuSyj4uZ+kP2cc6AFVJvYP9Brq+N2
	ZwT530A7Ep0lKhZ/EHcM/pBZU2s0ArpqCKI0YNKrB86mY7CyrtDWxACMfQoc0rjE
	crKlbz7EKLnUQifmKdGyg==
X-ME-Sender: <xms:t8WxaCUtHqLvblFsDfliIekM8Ov6uHcJ7BGKUfbjl2clxjhDoj0rFOM>
    <xme:t8WxaB1_AgzSI0f6IskTe9OF8rfwqZmV_M46_3k7T_FXtEZfqZYj2XQdMbLlx9S5s
    FL9pgac4GONwyz5UQ>
X-ME-Received: <xmr:t8WxaP2wypgpqXA9qzsA5nr1331ISwdmhweodgrFy_AMIfK9loSmFl6efXplqIsZcW4zoKj_4JGBiXVWCv8b0JwdF_ORcBMpF2aWfiSNRksJeBOD5dQHbL1fRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtth
    gvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffh
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhk
    rdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hm
X-ME-Proxy: <xmx:t8WxaE8l7iLF6U18cM2Mx4MH_GSAAmwnpsPYmzHGd81PhbsPCOhVSQ>
    <xmx:t8WxaM1dUMbuc-trXGXivYkCD4-SUgPsvU4qPVsdV5V2szeUTaQEWA>
    <xmx:t8WxaB8oTVEnQD2IGCoamQigZm27JvGdyNoHI_3EPDRyRcogBBGUIA>
    <xmx:t8WxaMuvqDEs5CFX1DyiT7DNnbImFl_bKM5txIe-mtAuXZUs3aGmTA>
    <xmx:t8WxaEHpGBLkBZeQ4HhFJYAIRrT-eHl6kY78cGVJfSkZ4CAradcnMASW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:22:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] whatchanged: remove not-even-shorter clause
Date: Fri, 29 Aug 2025 17:21:05 +0200
Message-ID: <a074e7be4222fa2d3b92db5e5f6eca1daf2e1867.1756480827.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756480827.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name> <cover.1756480827.git.code@khaugsbakk.name>
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

