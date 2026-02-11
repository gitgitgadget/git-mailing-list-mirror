Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0334575A
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837471; cv=none; b=rYF8/Pp951NycHlUJCsk/LL94Os12v3HhcCGGxUxr+7PIHrQ8uPyvMkcu13ltibZOVjMptBqzIMwF9kVztZqpaRkuGZh/LQgRpdxnoQtMDjqzr0ZlBiD9WYG3Z3whscVXXG3eCzO7+J4YAAGIUCnAwFHtEWQ7eFql8kFbcOHTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837471; c=relaxed/simple;
	bh=k0zR8uPU2CmtMBvxdWmL8naW2HCrMo3PP9mx3CZvhSQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVde5WhxH0E0+BG/vxaAEpdOeatmcuVAvOdARpWwrAKUJ0ZFmwuWkb1nZbqpQtypaQlbRzurciOAbLc8D9CEy4MPYOKOMvmd8z8hwTx03X3UvGU7qazTOhlqX/klPq267r4/KaxnzAwr+eOi3uZDszaZuGwuatqcTceIN+hXgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QDajmw61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cW9nPh2D; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDajmw61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cW9nPh2D"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F3B3D1D001A1;
	Wed, 11 Feb 2026 14:17:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 11 Feb 2026 14:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1770837469; x=1770923869; bh=7rUxEEKRrwza6sKb9K2ubAozq4UW+Jm7
	SBPcvOWsp/M=; b=QDajmw61HLXQsXNqYVqzpKuuEiounTXI3GqkRmUuLWnNXFvB
	NPlfYO+HFVgQi8vcIiVcPEq38eqG0FzCPxphWL7DxKVRn7pWP6pNFeMhe+hpP+LA
	nj7bSGF+zskk20mGpGgtSwcNuz908O5bj9WuaFr5wvgmAg46HRvHi/rZsMv/Ol2Z
	Z5Cemh9a16LCHpaySCHB21c9E3MSN/kjtMCqgdtZhuTRG8leSwxH06I6g03EZLPG
	kVtl+j3Z3zZaKZYpqKqGyxE8NI3tndMmlK1Fl83R1fPNu37wDgxy3DqF2JNoBD15
	Xym21LoA+Z+qRf28EI7rMmLlNJT/uaHuzRFhrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770837469; x=
	1770923869; bh=7rUxEEKRrwza6sKb9K2ubAozq4UW+Jm7SBPcvOWsp/M=; b=c
	W9nPh2Do2hsoUHLzQVJGu2brXgF7WSB5c/kiqE9upNvPWWbb0+qWo+8tv2iIaul+
	wFueQlpuCVxev31SxuZQyc3emEeUlc3lppF/YCv69UT4GZnuPiHJLvbYQk8HV8/f
	jERvqzGZi3XjJ6/TZfg9WCALwbJOjaPRFOm/sj80k9C5ZLn9yGvCf/bhJBZ0aIYR
	bAnY2ObUVsaZOLMVVGSGT7lSBGf68m+Ui6khxHLMfcN+8yslchNmuUU5QqGJFfWZ
	abCmrjfjQtLDDfjZ1VG0pN1+B65eZwxUdg8va4sEBiUvJCoAk6ExouxEm8o70iuZ
	of8GSQE1oepJ6D64KugKg==
X-ME-Sender: <xms:3dWMaTgIK4HPtKJPPbqnu7c6gqJD0GMs5q-M2siQlsC6vEymZYzgtQ>
    <xme:3dWMaWBv6KS0VLt6R0rLqWXVuUv5hd_5qYtYHeuqbhTZRZNTxC2oJZ0oTabuDM2Xx
    MR-TwKVexn1t4izfoYcsh--3jmHfUG-AkucRNtRMrI1-SwHBMBbfg>
X-ME-Received: <xmr:3dWMaQui0CvIZf4tcodB8rl_v-96hzsEuEdHVnXVdvdTXKENqV1u5khIFysCe6eBxqeSoLFsijYEkQsed_DcYCEqENnKZO1CpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:3dWMabYpaS1840THGCTwE5oupBLxE1oUUbTZQ1M3e9btvcY_IQFCCA>
    <xmx:3dWMaTXEzgLS4gAIDrzgRgj80VVGTT_XjAKKKhdD_1FQz8oInN7Wvg>
    <xmx:3dWMaf4TxWoliTLKFVESLqVk5Ufo1hrTKP5_MhFaW4w_-VJLT72j7A>
    <xmx:3dWMaehpnBNZ-I5VCCq0unAieD5j98oibLL3XbobZ2rJax1-5Zos6Q>
    <xmx:3dWMaW6SgOVmfA5pg-AvErzndqbrwXgBoIOstcKBYrcbOK8P2OjFlXnw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 14:17:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: document // comments
Date: Wed, 11 Feb 2026 11:17:48 -0800
Message-ID: <xmqqikc3t7hf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We do not use // comments in our C code, which is implied by the
description of multi-line comment rule and its examples, but is not
explicitly spelled out.  Spell it out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b358d6bfb8..507d52b0d3 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -439,6 +439,8 @@ For C programs:
 	 */
 	_("Here is a translatable string explained by the above.");
 
+   We do not use // comments.
+
  - Double negation is often harder to understand than no negation
    at all.
 
-- 
2.53.0-247-g50a2c88be3

