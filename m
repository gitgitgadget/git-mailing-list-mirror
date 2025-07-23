Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D481F4CBD
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299092; cv=none; b=F1iLd9qOd8S/C6arWL2iYhPvE9AiCM0STA9go31vrPdDXuPGR9L8c+gEfOAkR7AInNZjqvaWEz3Ux3Nk7/DnnsCMBAGhTRmYRLyNUgAOeN3PbKpYGjJdbMFtwF3vURGhbcXML3Cp6N8i6/MusFMeKWUOnEVZjKcmqdLJtdnsM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299092; c=relaxed/simple;
	bh=+4HwWPSxQzqYmFxBtgdal2R8pLFSdzhda0CKJ40mCpQ=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=nZ4tLb2nHJUsizC/j6bXLoppk9HQEazQPBQxlQLISCe8elor+JZCI+nGIW5FHCUrUq5GkX7oIqj3j/e6puI+Z1jteXG0VOrdyEJpP2D/9uIsYmdm+kNDJuSn4wqGr0cbzNgcJnUGJub/Hh2AP/CoUA4nC9Hi8In31cIke1SwoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cFqXO4Y0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFlZjfLs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cFqXO4Y0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFlZjfLs"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96234140058E;
	Wed, 23 Jul 2025 15:31:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 15:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1753299088; x=1753385488; bh=c1GRvUFosucgXQzwsLmVz
	50Q2FfS9cf/zj2VL7s9nd0=; b=cFqXO4Y0NveP/kadI6E9/SXd0UFGvHnm4Woyc
	WX1PvJpj5H3axDS/+VDIGlgPe/DZ9kbHT5oqj/nYZPkgysdNxpuvwZpqb4T6kIEW
	XE81VgqP3u9d2AoTjUVdfOdxs+5ZmmYVkRzJVYPaboD0DwvNnfUHrFTY3xnWIDi1
	GOW/K5DCfkgLLgZNZESynB0QO82EfssxpWPzjyiurBRhdaj+xNIN/cwghYj3aSZW
	0n8kpC+FAtsDQ4FdS1oeO56bms4jsJn1DI5W8vuFDaxfpTeW/wu0QEJi1viTuk6B
	Hcla4SRq5igFiPmna4Vp685nHq1d9TN3mslD0m+3/NBKl9l3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753299088; x=1753385488; bh=c1GRvUFosucgXQzwsLmVz50Q2FfS9cf/zj2
	VL7s9nd0=; b=IFlZjfLs9KIbHECcUx/TAkusk/SUipJfKa2/QKHeMevy4joMmOj
	uTjUKXuvpqSAz+nQXBgWaT9PGEdRieT8gppQqQyBTHJotHbgqILarXZgvI7d0CTU
	+hi4D15fv97uh/DwTco/U84xr8pT+q+tFSyxHV1LtVX142192PxhfLaedluwym9+
	ZW4VXAhCmbzAJiJogkPmdWU4tDtuAbOoGwLkElKYqsHToOhL3ac/ChnoK2oKAHXe
	olL/TdlczomOgfIw8EmWbRAxwDjXjitNkAkzEGl+Y93/N7/RbafHX7nE4PsrR0xG
	w3tTf45K1ngvFNlLXqkVu7i0fK+FxL+wDXw==
X-ME-Sender: <xms:kDiBaMg2UFjDLDueQyLwq6-CmGDZkhie3SiYQdMRiGxg80sUg6bHxw>
    <xme:kDiBaPkQqQlI5PoxLc2sV03nRWhBzGfiu49Fm26Hzo_lJwOYm14XFE7UY0thIJPef
    oFvKXeg97WaslfLiQ>
X-ME-Received: <xmr:kDiBaAr-527FNlU97hWfHLLA1n0S5urmI37Umn1qYrS4W2elN-VCwniXe1gx5n6FgTEDPj0OgElBbQHJp3oo04et2VFV4gRrHKIDReE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufhffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepieegudefueeijeejvdeffeeiueetkeekvefhvdfhiefhjeekheehgfehteejleev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:kDiBaAFcfTEDxNCGrL_adxbk8b-WIu2FNgiXp7yLWcM18LknmHFbSA>
    <xmx:kDiBaExgi7BPsnIIhXRyUKCjheVBYirQPeXcG0m7U91guYw3OwVUfA>
    <xmx:kDiBaNpb15m80aGHoq5bYUHUP8dgmmZIjPWlwNsgYHaBImMxVqgxRA>
    <xmx:kDiBaGjeXNFtxc4aPo6jUU9YcJwFxxOmeKH-2dSSAWcMq7x1_kOklg>
    <xmx:kDiBaFRck_sKa_yzMb8AdqvfiWYEeZdk4RlrrShrzpOx84sv-JeCHrEg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 15:31:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] CodingGuidelines: document test balloons in flight
References: <xmqqldoen5v3.fsf@gitster.g>
Date: Wed, 23 Jul 2025 12:31:26 -0700
Message-ID: <xmqqecu6n1pt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Due to portability concerns, we do not blindly say "It is in [[this
standard]], so we will make liberal use of it" for many features,
and use of C99 language features follow this same principle.  When
we contemplate adopting a language feature that we haven't used in
our codebase, we typically first raise a test balloon, which

 - is a piece of code that exercises the language feature we are
   trying to see if it is OK to adopt

 - is in a small section of code that we know everybody who cares
   about having a working Git must be compiling

 - is in a fairly stable part of the code, to allow reverting it
   easily if some platforms do not understand it yet.

After a few years, with no breakage report from the community, we'd
declare that the feature is now safe to use in our codebase.  Before
that, we forbid the use of the language construct except for the
designated test balloon code site.

The CodingGuidelines document lists these selected features that we
already have determined that they are safe, and also those features
that we know some platforms had trouble with.

Let's also start listing ongoing test balloons and expected timeline
for adoption.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c1046abfb7..0776d15a95 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -298,6 +298,14 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i = 0; i < 10; i++)".
 
+   C99 features we have test balloons for:
+
+   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
+     compound literal syntax, e.g., (struct foo){ .member = value };
+     our hope is that no platforms we care about have trouble using
+     them, and officially adopt its wider use in mid 2026.  Do not add
+     more use of the syntax until that happens.
+
    New C99 features that we cannot use yet:
 
    . %z and %zu as a printf() argument for a size_t (the %z being for
-- 
2.50.1-521-gf11ee0bd80

