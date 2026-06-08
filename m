Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91416352022
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901402; cv=none; b=H0JQz4t3hy+K0luRHgmrzvNWFy4UGOnFDiw4fqR+dj6EzZm6om4uq09X5dC7fZvUFc9rrOnHJnulj2cCiaDi4tkmCXfXuRDnjooQBi4J+wx9cQP5tsMCHOcUe2NOEdtwMiPXd2lxEgOYF8SCbIW1t4JO1OVxORNoArq3M565KNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901402; c=relaxed/simple;
	bh=HAehNFFnpAVWEaLDtLhrdOMt2XHdC5h+0bXoBOo7zSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VaBtzOnoHSBVdggQWFrlIminhBH5kc9dqHdWhn9osG+NUoWOW/AFmkNV9QPhn3WbtdSvsxBMPxUT+hOAkKO4dR/qTPcr4tzmA78F+cKiLdmAq5I5Q3nZRuwjrIL8ZTiwtmHo74YJhRZR2eto5E8xtj6LcuiJAoW4NORU2H3AeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ProOrCUt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knXyLrEP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ProOrCUt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knXyLrEP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA7717A0068;
	Mon,  8 Jun 2026 02:50:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 02:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780901400;
	 x=1780987800; bh=NCkvqm31d581igDWN+Iidt906aJ6oJphKefrMuqUKaQ=; b=
	ProOrCUtSKosi4cLPsq2c3QHVSjgQOc+vnN4ICyuHDoupE6zK0NGsUMwqbJ9XJ9x
	Hw8NgX7PqAayP6TmzeLo54RrfeY03EiQh5JMiULoAEfICeN095tkIIZg4vwlj8Ck
	cqvJSquBvg/kmyheT5UgkNyBcU98pesAuE4d+i0InCRn9lK2TP4bJBZlGWsXHbfJ
	M0OLqjJ7a62Stb14CsiH1TVqT9u7nCWdCY31a0C4jFXafCtIYUyUY1xlw1NJ19RW
	+YB9epDM8UqrHi2p5Mt0n1NklS6RWvnj0n303jNcT6m/z5RgVi4xMAy3knQePSQD
	FdebS3X1SKfMJ3tcRSppzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780901400; x=
	1780987800; bh=NCkvqm31d581igDWN+Iidt906aJ6oJphKefrMuqUKaQ=; b=k
	nXyLrEPm175cAV0PjMXDphM4209UNuaUMmMnDQGvccn+2pEHC9vQks3d/Gk20chP
	VNOJ/0pJWZHytpa0ic2zeIBSZHUQLxqXBuZm4r6UVysw1KNX77+XXiAemRGNEjlH
	2Wtyg1Wx4j8QPQyvoWtPCD6ptF17WLyw3NrWjhQ8QucEAA27C2QNbN6yUh+ttFbX
	vokfOU0unMOljHHEYQqoujnMJPFyUQnAPerdbt5raqdp3pItCg+73UNBWlM1nHPz
	1qdz3imvN4tn7a5X9xg4RmdPALOOKyZBmrgym11K3IAHTazYabCDNemmEg8TFNXg
	9lG/PmkDE3YwLEPWK3Mpw==
X-ME-Sender: <xms:GGYmamJdpdaLfsRUpBCWfFL4F8L3VMxwbNv1LoUOPFYpxzbEr3V5ng>
    <xme:GGYmaoLsj30he6yZ7RdFYY4Cd0D8xbXk9N9FTgZPmQOyWhuFfXoBXwJsSiR9W1cxq
    IdgyUJcGfZC9brUAhAk5Rs2IQLlKDuF1Xd0uI9k5FU9JSjzTas46A>
X-ME-Received: <xmr:GGYmatUN27DdcUb-VLzkASROK6J-Id7vrxWi9GQ8MfWdyJ2gS9M4yv__Zy3J3lioOfJy_Bp-QdtKtyweiwXspuncKQ_NxL-pLj2M8izTig>
X-ME-Proxy-Cause: dmFkZTF7lVlAIkNc2jTWqc75BhWUcSTTt+f9/w+8F4X+Q72HljQo5YvO4MtR35Rw1QK7sY
    7riHVFK5oBhB2RqcfMVkYjv/LA+jKl2gfD8UnKE3G2IRnhTnGhGZZRssQ1257VJXRqUK3e
    yIXa6LPSyfnKEs4KQkqSYbHsKvlDZ9XIVvJJHtwsMMgft1sq4FITmkW4hG/7BFkzoiB8a3
    gkg1SkFMeN5KIe1Ad0I2QqXwWfEEHoMwbhSWsSp/mBxs6CXhiZeiwbeLVPXXdtYHwYjcay
    ZlgmraYqrRQRxslogNsMwuzPFFWaMSG6SMwSqEMiYjzP/X18aVE0CPOmgSebt+u6sE2fb8
    P5MhPG4pWJjYAG0Js8lKMUMzQxyhzHhnnP1udGMlWoqtZG3PBdox78AXePcM3wfH/Q3+pJ
    XdzjxPKMBZTYrpA94657kP6PGwM13O+Bb9kiNG+cyHQT1kphIi1QCFHtCPseADwr+hZ8Zp
    n9Tb16D4xx8clbm3xHNYuIUpRtPzR8Yqo260rFdm4ZQYhCPg8J9NrNrAeT5q5ObCrV9bjE
    L/UYYb8LEeHR77SQAT0uI56smdVTvPdcb4ahwyM/XR5GcJNgV4hznyiWH7akSJ21/fQOtl
    LJtIA81+qG0MVGD3qWChxY2oS4qWnWb34YZRbpeADGaRp+Ub6Rrjr11l23Xw
X-ME-Proxy: <xmx:GGYmapk_xnK0dcwbyTVqpZvl6DLfIze3KVsEpjc_g6644pSYL9np0w>
    <xmx:GGYmarnaW82iclBDvg1wV0KSfM8DmSp7juYndFfuiOdzNP81irOVLw>
    <xmx:GGYmahY33jnVuhVUxJtQ8UqJvSScZDrZt5t6_rxven94NNvljcfDcw>
    <xmx:GGYmalQNgazuS3airnvAhxdKXTDSkTlFI_CQj7FXPpYD2GQdK7Mvfg>
    <xmx:GGYmavGGBYMlBN9dWUV-XnXrJFwPULqCJzzRmxHgoU_lxAlqlbTpJetm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:49:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e22b3d16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:49:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/3] Documentation: recommend the use of b4
Date: Mon, 08 Jun 2026 08:49:52 +0200
Message-Id: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABBmJmoC/2WNzQ6CMBAGX4X0bE3ZIj+efA/jYSmLrEYgLTYaw
 rvbYkJMPE525ttZOLJMThyTWVjy7HjoA+hdIkyH/ZUkN4EFKMhVrkCOdyfrTOrUGFBN0ZZZLYI
 8Wmr5tQ6dL192z/pGZop1NDp202Df6yefRu9v1KdSSSyQDphVVJn2FA57foi46OG30VsDsSmRU
 CGCAb01y7J8ANoxCYffAAAA
X-Change-ID: 20260602-pks-b4-31cc20d7f84b
In-Reply-To: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series wires up b4 in Git and recommends the use
thereof via "MyFirstContribution", as discussed in [1].

Changes in v3:
  - I wasn't really able to judge consensus one way or the other
    regarding the deep vs shallow nesting of cover letters, so I still
    have the change to shallow nesting of cover letters part of this
    series. If we continue to be split on this one (or if we favor the
    current status quo) I'm happy to drop the first patch and adapt the
    last patch to use deep nesting of cover letters instead.
  - Hopefully fix some confusion by saying "shallow/deep threading of
    cover letters".
  - Fix some more instances where we recommend deep threading of cover
    letters.
  - Link to v2: https://patch.msgid.link/20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im

Changes in v2:
  - Reorder commits so that the b4 docs are added first.
  - Add a section that highlights how to configure b4, and that points
    out that the per-project defaults can be overridden via Git
    configuration.
  - Add a patch to MyFirstContribution that recommends shallow
    threading. I mostly intend this to be a discussion starter so that
    the `.b4-config` file matches our preferred threading style.
  - Fix a typo.
  - Link to v1: https://patch.msgid.link/20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im

Thanks!

Patrick

[1]: <xmqqik81xpqx.fsf@gitster.g>

---
Patrick Steinhardt (3):
      MyFirstContribution: recommend shallow threading of cover letters
      MyFirstContribution: recommend the use of b4
      b4: introduce configuration for the Git project

 .b4-config                             |   6 ++
 .b4-cover-template                     |  11 ++++
 Documentation/MyFirstContribution.adoc | 100 ++++++++++++++++++++++++++++++---
 Documentation/SubmittingPatches        |   6 +-
 4 files changed, 114 insertions(+), 9 deletions(-)

Range-diff versus v2:

1:  f7784c8f7f ! 1:  4b0c4f9aca Documentation/MyFirstContribution: recommend shallow threading
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    Documentation/MyFirstContribution: recommend shallow threading
    +    MyFirstContribution: recommend shallow threading of cover letters
     
    -    The "MyFirstContribution" document recommends the use of deep threading:
    -    every cover letter of subsequent iterations shall be linked to the cover
    -    letter of the preceding version. The result of this is that eventually,
    -    threads with many versions are getting nested so deep that it becomes
    -    hard to follow.
    +    The "MyFirstContribution" document recommends the use of deep threading
    +    of cover letters: every cover letter of subsequent iterations shall be
    +    linked to the cover letter of the preceding version. The result of this
    +    is that eventually, threads with many versions are getting nested so
    +    deep that it becomes hard to follow.
     
    -    Adapt the recommendation to instead propose shallow threading: instead
    -    of linking the cover letter to the previous cover letter, the user is
    -    supposed to always link it to the first cover letter. This still makes
    -    it easy to follow the iterations, but has the benefit of nesting to a
    -    much shallower level.
    +    Adapt the recommendation to instead propose shallow threading of cover
    +    letters: instead of linking the cover letter to the previous cover
    +    letter, the user is supposed to always link it to the first cover
    +    letter. This still makes it easy to follow the iterations, but has the
    +    benefit of nesting to a much shallower level.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/MyFirstContribution.adoc ##
    +@@ Documentation/MyFirstContribution.adoc: We can note a few things:
    +   v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
    +   three patches in the second iteration. Each iteration is sent with a new cover
    +   letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
    +-  previous iteration (more on that below).
    ++  first iteration (more on that below).
    + 
    + NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
    + _i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
    +@@ Documentation/MyFirstContribution.adoc: between your last version and now, if it's something significant. You do not
    + need the exact same body in your second cover letter; focus on explaining to
    + reviewers the changes you've made that may not be as visible.
    + 
    +-You will also need to go and find the Message-ID of your previous cover letter.
    ++You will also need to go and find the Message-ID of your first cover letter.
    + You can either note it when you send the first series, from the output of `git
    + send-email`, or you can look it up on the
    + https://lore.kernel.org/git[mailing list]. Find your cover letter in the
     @@ Documentation/MyFirstContribution.adoc: Message-ID: <foo.12345.author@example.com>
      
      Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
2:  e8f3caf73a ! 2:  625de75a33 Documentation/MyFirstContribution: recommend the use of b4
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    Documentation/MyFirstContribution: recommend the use of b4
    +    MyFirstContribution: recommend the use of b4
     
         The b4 tool originates from the Linux kernel community and is intended
         to help mailing-list based workflows. It automates a lot of the annoying
3:  35591c55c8 = 3:  a95973cfb6 b4: introduce configuration for the Git project

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260602-pks-b4-31cc20d7f84b

