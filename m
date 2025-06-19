Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55216221FD8
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347340; cv=none; b=JbwYJd4L3oO+LX7c6wY0JTRcn10pYAAWlyjE2uJVkHcM4+OLluTqLriRgVb9mjL7J01T/5wJOIJaAl9tRbtW+W2rjTs46hhIFi6f4y8XG+XmTerDZjlzgsqg6guHoj+ikqE1r64adpvPPyzn1/yrkVfXDxPSVG/XlFk+PiT6HYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347340; c=relaxed/simple;
	bh=2vxhXNHFdfD4lmA5IkbvpCKdioorO9NHa1aN/KW2TYQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQoxQnOc1++CkFrz5LYW0IN8YTtOJEYHwq8ucaAZ4tqRydNE3KW0axBCigXQkobOnLeWSxExfo7wyT+TI3excEdtcpkMBRf9Ron7loGQhie95q2hMX6erplg22U6xsERfSqUW13yqMtpWSLBDextv6tRHc1+1VrVD8hUV2ILaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R1bRh4Md; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WK8A75tf; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1bRh4Md";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WK8A75tf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5685C114019D;
	Thu, 19 Jun 2025 11:35:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 19 Jun 2025 11:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1750347337; x=1750433737; bh=JYmxwOI4TNcln019i0Mt6JcpN46K80qb
	f7WjOto7hC0=; b=R1bRh4Mdw5e3ZDq4woqK5/BovfBphDQ3renIsClFuOhPd71A
	r5SCsMspDDh31ByvE/fyX+fHnr6EOZV4gxGIY1yzUr1lYPK6FX51WKXhRtVTIciZ
	TzMtDKUV20Sec+MhRQdVdND2dxlNf7qYnW+eCetawmLaENpE15sIKogaZcn1RGSS
	ly1pMuKMR54mtqjUmHXbOA7Ls9iqdhNc3A7bZtzPEY4XWY4yVRVu3T0NwRyH7vVc
	1Vt/PPtInykDvUb8yt4R7eurpG+wxi2D0vIjz1xz2LVuhn6JB62GXOUb+aBOI66h
	lmrduGS5gcYl8yfHABonZ/vpERTosvqqdhDPAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750347337; x=
	1750433737; bh=JYmxwOI4TNcln019i0Mt6JcpN46K80qbf7WjOto7hC0=; b=W
	K8A75tfLYfdAdwbOPt8LAEuafXcccppLIfD0XwdcA3avfaxyGxUALQyUOHS2VnJB
	jXOvqu7RneiGxDkgcpLCf4pvveXfOOp/21s89NKhIvaeDWzEy3K9FokJweSPDPnV
	5qo47zY0+zlgnXIPG9nqsDNvY/Z4UpmycaXHFPkEJo1pPV/1T773Lb8Pn3R+Hkkg
	x/C82msPRe2H6BHAelHF87gqKC1os/v2zw7xKOH9pK+hKBCtKnIZCtaJ7abrQW5H
	BgwdcbrfURcYlQByKKU+Ac/9499bj1rolmI7W5MyhGES+AbxqU17ENEcmOqeIbVe
	DqKSnIi885w0PwmW9cB6Q==
X-ME-Sender: <xms:SS5UaPp940Flrf8Lj5Quf1cwcA6Fr-nPaK-rlMhUEKuUhNJlLC_jow>
    <xme:SS5UaJpbeafJPzt-ZMP480l29hXaIQ6PhYsmTLKAp7N_8FZqYHGKPSPwKje13Bfke
    1Lyzx1e6ktLTLppXA>
X-ME-Received: <xmr:SS5UaMO0UEx4gFO6Nc7IZmJwS4VTDba40wGYtg5CseAuheteaiCIdPedd6Om7vVDQC9kmfLRGFc58PW2uDyOhTAIc6Yib5_VMyBx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertdenuc
    fhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidr
    tghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuffffke
    fhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpth
    htohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SS5UaC6VawOIYzKEN_wG1DXwBKwRqXegpLX09MN8KMZkHBZxMhCjLQ>
    <xmx:SS5UaO6cgcOnsdLUoM14ptLsSmp7LGcVpsa-7f9clK9WAsauUoU2Ww>
    <xmx:SS5UaKhBfEHFjJUVwebHQiAzjQh9rFKdDypxrii4YXKmQhrs2wn_eA>
    <xmx:SS5UaA52Yi4bZXF4MGdbWkmgtfYZ1saeoWnG8y8NvvWXu0jl_ZUhqQ>
    <xmx:SS5UaDod4WmFrTAHYp1JhM-3SY6eBwHmM_WhOioFlOwglnz_OxD-PWZD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 11:35:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFC PATCH] coccicheck: fail "make" when it fails
Date: Thu, 19 Jun 2025 08:35:35 -0700
Message-ID: <xmqqwm97bv7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

With "make coccicheck", we generate contrib/coccinelle/*.cocci.patch
files that contain changes suggested by semantic patches, but "make"
succeeds.  Admittedly, not many developers may run "make coccicheck"
in the first place, but it makes it harder to notice when they do
run it after they introduced an iffy piece of code.

Check that the resulting cocci.patch files are all empty.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/Makefile w/Makefile
index 70d1543b6b..2c17868a24 100644
--- c/Makefile
+++ w/Makefile
@@ -3475,8 +3475,10 @@ coccicheck-test: $(COCCI_TEST_RES_GEN)
 coccicheck: coccicheck-test
 ifdef SPATCH_CONCAT_COCCI
 coccicheck: contrib/coccinelle/ALL.cocci.patch
+	! test -s contrib/coccinelle/ALL.cocci.patch
 else
 coccicheck: $(COCCICHECK_PATCHES_INTREE)
+	test $$(cat $(COCCICHECK_PATCHES_INTREE) | wc -c) = 0
 endif
 
 # See contrib/coccinelle/README
