Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EE2BD013
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028742; cv=none; b=shXJgPsQPwg4shAUZ2FZjYC1CAFNAQIcuagKW0MFicBhzLnOQZMJpR1JcjfYTVDXOMTduFrtoRVllDRGXh7dHq6OpPAhre+iQ8xpIOGoNonjipGh8EhPaPjhTzlIiol7tUZ6eVGq+WW7iOHmbSRALg9j63z6iq+Ito9qVP0967o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028742; c=relaxed/simple;
	bh=4uOkLiQBVTRaHCFNkhcFI3x5H/SiwsUf1nitrsBKhxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=by5lRlwAXGEBYX0m3m8vNKoAsEXZ9nTAZQdBUhmTYbjdQZ2n+FtyP3ltudJvcyWx2+1ko04YsJvPWlQpvpx/UpoMOtf9EoPuxokGhRIjroX3GsfHDC6QuqVnOrX5PJ91RCHcQgF0odvlvzq5xPTr4Lp9eb4Gt1uoS/5k+c8PEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JRUvwtYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KW1d0B6z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JRUvwtYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KW1d0B6z"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59E6811400CE;
	Fri, 23 May 2025 15:32:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 15:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028740;
	 x=1748115140; bh=JXF8e/eGKbCjbPBM+5epqCezePmiSiF+MwgqB+TEzQQ=; b=
	JRUvwtYiSMuEsAaBp+C8Qt+tdOBjpzvvui6scgLYD6svAyk+i6GceXMHDO6bX+5m
	U7tPNErZtZ5ySHqT/OWshcq+JkUg1+fTVkZ75+IzGimHeSnx2xRP7hqC0sdCISWC
	gcJr4BX8Jth16OHbyjzgOVzdl0Kh7uHxdaUkWhkGuA3KDqqqcwRsYAlyw+zx8SBT
	znYejd5asiOFLmSPOxHT4xCcA/AXmTv0NzeESgxDeQnM2qYFo/2tx+9NHaXQFIwZ
	7Km0SaWizYf6vT0tEUBS+d0ZXZwj87EQ+inix2UNh2+CEckjKFSknAOZLokHdRIe
	MeYyTDcUgaYDJ7kdiRoM6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028740; x=
	1748115140; bh=JXF8e/eGKbCjbPBM+5epqCezePmiSiF+MwgqB+TEzQQ=; b=K
	W1d0B6zEoLM72GFxmY/2RmRNbEQw0w137UJ7F0L/j8GlSuqHJ/W+P4G+wtFpTfVo
	0ubCf8EM8b6abWgWxUycEqMe/UsqOTYFkRx536B+G++/QFZ3dkaLk5ZzgPZ16bU9
	3sBkg+tLcZK6Jx5gup5hbOLUxjKYbinRimIj3LlNPjsVAImB63t+NTzsCXcn+/o4
	8igDFixBt9dvqruj+8zCDlS0yCuRtM79PBaiu7+0d8ieEst1AYVuPxldU5ps7IJk
	A4bZisx314KEsPRrb0KJXAzUbmaGe56d6MzbNDyd8c1XhnEDW6dOcz8w2VZBAwWB
	IW4Z7VbuWteQIVnV3QfNw==
X-ME-Sender: <xms:RM0waCg_Z4HkAvjBqAoNf-pUDOjQGAYlHu-hqsnNj9BUpYQFBZ3wO68>
    <xme:RM0waDDwiQw_uunXUiNb4P_TiVGBp4sZ1DCr4KTf1RlkGR4b25a8M2OLHZBgkkN_Q
    CeXVT-nqbmlaaRg4Q>
X-ME-Received: <xmr:RM0waKG8JkhbnsoQSDsPP-09CBgE2ynLhmQDxIZ6poMcAsMHeTWMdZdJvISLCOvOOQew1XxAoSQVSSy5wsCvZUKHnXRi-TABMbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeek
    gfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:RM0waLRiRk3eI2VIk1fGZTtHqDinAVXIjEHuUzUZg6SzPtsDXfh3GQ>
    <xmx:RM0waPyC2XU9OuShaPMbaheW221lWthlzEZJbvSvxfU5qoni8ccf8A>
    <xmx:RM0waJ7JgWKRnNvM6GO-2UjT1xf4uq00nB1m6V1FiQgysmIbLmsZNQ>
    <xmx:RM0waMxdrOCVkg3phWu5qde9oZMc_e2atp5g8EPjKemOnEwVVSVruA>
    <xmx:RM0waLOc2wbywR22Dcf1edTkBvvws5Km7RKKg4AVFQ9Ogpvf5WppSOqs>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:32:18 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 9/9] doc: notes: use stuck form throughout
Date: Fri, 23 May 2025 21:29:55 +0200
Message-ID: <73bdcaecae585796ec212675f3a2ff92d1ec306c.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

gitcli(7) recommends the *stuck form*.  `--ref` is the only one which
does not use it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • I didn’t spot this in the first round.  Hopefully it’s fine to include
      it as well while we are editing this file.  I would consider making a
      separate thread if I wasn’t editing nearby hunks.

 Documentation/git-notes.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index a0167af5aba..43436daeccc 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -199,7 +199,7 @@ order of similar options. For example, for `-C <object> -m<message>`,
 `--stripspace` will be used because the default for `-m` overrides the
 previous `-C`.
 
-`--ref <ref>`::
+`--ref=<ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
 	`GIT_NOTES_REF` and the `core.notesRef` configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
-- 
2.49.0.780.g892193c3f50

