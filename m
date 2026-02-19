Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA73346B9
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487883; cv=none; b=CDc1Kv4igkweBkTysby2q2N9n0SXENbz8f9PKKEnZd/oIgLPIRPXBJi02oGJpGYmnJGfmZ8HFTfoUPalM2r1vhrE151QyL1u41cFUMisvV5j5VyrkOuogys1iG2REb5WtCI1lXC+pd5H9eKgdHfE+Yq0PwSlgJDsb6VFPNEXvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487883; c=relaxed/simple;
	bh=u+49EVPrAJs0OPfftiyRMbz6wrj2SbrD0GY7O+zrvH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=W5lcJc+aCmnZIbQCJ/Z11sC1GtXCLnAzIRyk6MpAuj8qybeFWaclD14yM47T5MEBPrn1hqHatawfyfLz8dmYYtRS0x94Fk95S7OdlBYIkd0+TdD8jVqKzLI3Ud5SSaOZuk1J0d9CCrLu//f7/iY4cXlHSRj2id+/Q4jXSQsYGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NpJAVXrM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAANvHoK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NpJAVXrM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAANvHoK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C14BEC00CF;
	Thu, 19 Feb 2026 02:58:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 19 Feb 2026 02:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771487881;
	 x=1771574281; bh=KEMureGzJoay3Wf+7dEil6NRhZGJDx6HMAuyWhwbiA4=; b=
	NpJAVXrMyc/zKVG2Iq3g+G8ZD12OKbRmv8XzZG0ZEVp+FjSdO7v5LLKBIoSl9z5J
	CbtzNUGLhCtnMFCC7vR9t4lu+MN2BI2ABICCmFfFN7DD5R8J1iKNQt8T8F6WGKEj
	VNY82rjIuxOX2ttkjAS0WCAv2oWU9gUqQQy/J2DPVXqI3EUHPp9LEGLCz7Qo1wEZ
	HZ5Ow/GDuUFZDNXlyj7FwJ3O37lcrZ8wjHxKsgaM7chWynvWzxTHW2PcMvDlmKUq
	692PYfgArj692nUyNu9Dp2NyEctHrJoWEstuVWGrCN0x1mv95Cky8TP4Yf9ZTBvD
	PgbkouEIjffQYzc9xUvXgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771487881; x=
	1771574281; bh=KEMureGzJoay3Wf+7dEil6NRhZGJDx6HMAuyWhwbiA4=; b=F
	AANvHoK0rW6VrKxPUxhA5+dpNA7/7MCYDpwFq4FM8bhx1EPoUsqDDORS56WMgbLN
	MWT48h/BHgklNbMTUNC7qEjtQVx7+E1+4z1d3dOH7b5jQ1St/+Yvb78+MuWl2HSV
	eGZgynGMyuGxvsXdbQG3O4q2Bry5v8qmn+kREGvcu1EQoStpCy8BolFn49IV6Sos
	5qxcOqBEm9zlvDl+9v8U+n/1mWRvKBpt5u7Dycgj8xtlhnZhjFXAjxrrgS7urAN1
	z7KhDNQcbN4Lkh+G0ScLPDY9ZRFMZGu83qqI/jSW+2+nK9HIEasN4j3gjNMIMSWv
	ak3IpURYudMXCx2Lo7NiA==
X-ME-Sender: <xms:icKWaR1NrRY6kUF009GLX77bBD6GILR7DW8q_hwnF4w-XMXzi4xY9w>
    <xme:icKWafGj_PrwA3GMqmdLe6VNAtHkWC5oGdoJy8MABc_5Teur3q-pJuD5CTiHCKzJq
    VapNzB6MpgGHI8XuI3eVyWhvVXzZoyQs89-FANJ1Is-KEuYvwGsPLc>
X-ME-Received: <xmr:icKWaW5h8mY_Z_ZEgzffYYB64lXLIIc_pvZGoAGhQxyVzjziey08yB995INCKJyP9QQ04z1jeq9y4ixtcrushSf1aYYu4l6eDLsZq54yyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtud
    ehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:icKWadtdRKcRwgbbTVkjNhp8mW_wxNTLaP2DkXbDDSmgmcDpqopZIA>
    <xmx:icKWaf7tk8EfN6HKnHVIsgOV4sv901NZO3VoYtl8WeHVpB7mPf8FOA>
    <xmx:icKWaQXXjExzV6sIJ90KbJicAuFAOz_f_UsTNgS-Wk0i4pQg6LUbVw>
    <xmx:icKWaZ8erTdRU7DhwkOjzhDg_g_mOmf99otmL8Wnv7NHnpS6V60XIA>
    <xmx:icKWaSZdpqG-IJ-q9hWdsH_eASoEE1oUs4WX6Im5Ru27QcSP9mQ_PPBv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 02:57:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1933813 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 07:57:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/4] Fix misuse of `refs_for_each_ref_in()`
Date: Thu, 19 Feb 2026 08:57:48 +0100
Message-Id: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3ClmkC/5XNTQ6CMBAF4KuYrh0zbaGCK+9hXJQyyMQIpFWCI
 dzdwsKfHS7fTN73RhHIMwVx2IzCU8+B2yaGZLsRrrbNhYDLmIVCZVCqDIoEumuAigeoWg9kXQ2
 eKuAGbhwegSA3lowiLbVNRXS6+OZh2TidY6453Fv/XCZ7OV//0XsJCCU5Z0mT3av0GAs7vomZ7
 tUXp3ENpyKHSZIXMs+syeQPpz+cQrOG05GThCk6XRqb4pubpukFOtuaDG0BAAA=
X-Change-ID: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes a bug I have discovered where configuring
"pack.preferBitmapTips" to an exact branch will cause Git to `BUG()`.

The root cause of this bug is misuse of `refs_for_each_ref_in()`: this
function accepts a prefix to yield refs for, and then strips the prefix
for each ref. Consequently, if passed an exact refname, then stripping
the prefix would make us end up with an empty refname, and that is not
supposed to happen.

There was one other caller that got it wrong, too, and which is also
fixed in this patch series.

Changes in v4:
  - Fix a typo in the documentation.
  - Link to v3: https://lore.kernel.org/r/20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im

Changes in v3:
  - Switch the approach to perform ref hierarchy matches instead, which
    is in line with the changes in 10e8a9352b (refs.c: stop matching
    non-directory prefixes in exclude patterns, 2025-03-06).
  - Link to v2: https://lore.kernel.org/r/20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im

Changes in v2:
  - Explain my thought process against why I chose to also allow exact
    ref matches in the second commit and clarify the documentation a
    bit. As said, I'm very open to changing this if my spelled-out
    thoughts are not convincing.
  - Apply Peff's patch to further simplify code.
  - Link to v1: https://lore.kernel.org/r/20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im

Thanks!

Patrick

---
Jeff King (1):
      bisect: simplify string_list memory handling

Patrick Steinhardt (3):
      pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
      pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
      bisect: fix misuse of `refs_for_each_ref_in()`

 Documentation/config/pack.adoc |  9 +++++----
 bisect.c                       | 16 +++++++---------
 builtin/pack-objects.c         | 19 ++-----------------
 pack-bitmap.c                  | 29 +++++++++++++++++++++++++++-
 pack-bitmap.h                  |  9 ++++++++-
 repack-midx.c                  | 14 +++-----------
 t/t5310-pack-bitmaps.sh        | 41 ++++++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh    | 43 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 137 insertions(+), 43 deletions(-)

Range-diff versus v3:

1:  aa71011718 = 1:  0c2a2a122e pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
2:  d15aa04be6 ! 2:  a923e92ddd pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
    @@ Documentation/config/pack.adoc: pack.usePathWalk::
     -	commit at the tip of any reference that is a suffix of any value
     -	of this configuration over any other commits in the "selection
     -	window".
    -+	commmit at the tip of a reference that is contained in any of
    ++	commit at the tip of a reference that is contained in any of
     +	the configured hierarchies.
      +
     -Note that setting this configuration to `refs/foo` does not mean that
3:  2f1b73dd08 = 3:  7e1dbf1b4e bisect: fix misuse of `refs_for_each_ref_in()`
4:  f579e31633 = 4:  094aa2345c bisect: simplify string_list memory handling

---
base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
change-id: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5

