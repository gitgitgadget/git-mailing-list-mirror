Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823883B47C6
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772658; cv=none; b=mM1mplK45QBGvkDkRO8rVqk8nu9oyvR1opznkZmDLhjXZSv0UZd2I8CHxbYO2YONkbY02mDICe0/xubc7XEqWER4RIdEQvZefgoDwIrMR/xwuCVTndqw/OrtKDzvTtJ/oO3REwZPWsrZCQTdF/3Z9enb1DoG9B2cVCy7XqJvgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772658; c=relaxed/simple;
	bh=7HbpbIdjqEgTZ0k9Ay3cIq32LQxMGeP+M3LmNIqGCpQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RXrLfu6cEJsfdjJy1C5GoQLL184E+yOIyHznih0UejVAu7JJVZmO9qIXu25CzuvLbp6oO+QXGcaSODBXhRdnhqDy14YiEGQYZBTFguhmUU+2ecv5hllDf25nGSKmpdIP7P3ScCzPjTCWkjbBB0NRy70EFrURfI+y/La9kdCA0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gPkmjwdP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2mWpgxk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPkmjwdP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2mWpgxk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D0D81D00163;
	Thu, 18 Jun 2026 04:50:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 18 Jun 2026 04:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781772655; x=1781859055; bh=obpHH3RWEB
	OMuLnswM7Czizk52XqSRaMIQYDt1xnCig=; b=gPkmjwdPe35LZr+Gr481XAqoVg
	UmrEStj0AunKUIvjRK6teyaK1gd6OgOpnmEnzDPBw15k5QwkSHvqSN/zAL8f9mlk
	PN6CF18buW/eQmngrPOjvCLS/xJpZP8wxYm3XRyNiIQHr2xMhdnzqj1Jea3q4sIB
	zZTZXNiiBEiib9B0Y6uAt/LL3wxvq9JfApPP6Pg221jQA6d4m34dZfhozazDfiOJ
	xqzkK951E7yZMLHYiUP0LW2Rd5fTMsikZoeqc515F1onwHeV8MyFnZk7tnlkUkeJ
	3Fh+7XWVBr3tAEuuFKrUyH7Ga4vmLRrSjMxH4PSxeJiMt5rkds6H9ZfnDx8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781772655; x=1781859055; bh=obpHH3RWEBOMuLnswM7Czizk52XqSRaMIQY
	Dt1xnCig=; b=T2mWpgxkR31dmjqeHj0KeX4HXSJ+kHu1D9Vn4swrvB3JeBUfmuS
	T3OGBzRMm2D0jq41ELHN4J90attfyIqZmMenf1v1q1oXLliBeCwG/pEHPw1O4ZX/
	Wa594SfmelU/KbqOk1GQci2jrinkqeqR3OyIyN6xOOgXkFHUFlBGXyZXIoBGFWr4
	fFyLs3G/80HZPq93pwvCsd3xLof68zq0VclFoHaCnhKVqRObBz6x05ScIkwpbKql
	GjW3uJ1UVxGFoKtA3RGLDJYWttkMqmMVCP/R5xS6N8Lm4AHHFC4/M3CN0zeJ3//B
	MiMPxGOEfVj+1DhJ7TjBN3JBPn/8KHW1FHg==
X-ME-Sender: <xms:b7EzapoXuLETx8Ar98k2JrFmPVKi247Pwvr5HhIQDx4MVugo87R0ig>
    <xme:b7EzahoIIjc0_jJ5cThb5dtpGmSWT-UvHjFvAKbUOvZ6bZYRarseDcBjBZ0tDffIv
    h26vzFrGwKcpFoqLktLuYR2P801U2Xml186wIQpU0LK95Jat0xAYg>
X-ME-Received: <xmr:b7Ezaj3FBUW4NwZshvr65IpaEdZ0SDk_z8IV_1TaCz7QCZN-g6yDkOiF8LDRDxKaVDezC9m8GO2sBGILTAhFvIYxw6fPhjflp4Tl>
X-ME-Proxy-Cause: dmFkZTFLOwzZkBzExXi2pnxxBa/oDWV1WRMpDFxsrUQy+AtR2u3GnaGUcwjYLUPe3qqTLD
    668p2qfy29znqu9Ix0FQtpUbgwe20G8qxddQjwqgBz0dJvC0JY1ks0As/05sv/SnG/Y1DW
    v918bkM05Kzj272NvkFpaQu3VgisIvUlzTeG5qSBo7HRFMC+3e26GPsrk5s05PXwKWsSPa
    4ZmHDRWp74H8CxV4zoJakrHVMeWUUibSZ1ibrXRqerRoVnyJ/86mVbTnbnNpfvdKmM2tfJ
    yiabQ7VC07ZjxypL/e+yREO92K9D41rqZ+eKeSiBJi9gH521wL2heYbs91EUiOaAQXTahX
    G2u/9vjDLo+uaMw6qRjQexRJsnELT0Z4a5E06BeDK6UBikt4lbUmcu6ZEv5tXigD6K3O3q
    7sV37Ej/9mVGRA5bJ4UljFDVvnkP0ipYvZdDKNt6/cj4paHKJXSmn2y41ZiJsuRqYxPEvr
    3yOVVW/5fs6JZSTaKRe8Z8khh1f4Fyt5iLtmtuSa3+mBje9zNghTz4FGFOw/MfZi9vxxSf
    BD8P9gmNMARmjZkU9Dgb1j7KYcuWFWX8eD62Fv1oQqtDeVdZVMpBswfQ4eX3qZ5xlXIwQD
    +BKauzHYT/fWI9pAbrsn/LZ64vvsoSQvlufP3vQb4+0ir1S3X7F+OcoshLtQ
X-ME-Proxy: <xmx:b7EzagASwHSwyweeGNzBLMNXyD-epCO76Bbqk6_-oUu0OZ2CLM2ufg>
    <xmx:b7Ezarcnusds84BvalDcej80ATF6KpW_J5vRcQYPfdA7Pyg2bpRsrg>
    <xmx:b7Ezalg-PTbohCdSE_AJ8NFB_5p-dkGCaYP1fyf1GDrjIfTX7ydUmQ>
    <xmx:b7EzajpOy8LHLFQs5gakChMFgZvHh07JIk0gQ0wQfvnB2X0MfeZ80A>
    <xmx:b7EzatD6gvNnyKFTEZ5QXQagwm84Nrn0jRCoSkc-k-YEqvcjbuFnHH7P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 04:50:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] SubmittingPatches: address design critiques
In-Reply-To: <xmqqv7bhxiby.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	17 Jun 2026 09:06:09 -0700")
References: <xmqqv7bhxiby.fsf@gitster.g>
Date: Thu, 18 Jun 2026 01:50:53 -0700
Message-ID: <xmqqpl1oteoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Contributors sometimes fail to answer fundamental design or
viability comments from reviewers and submit subsequent rounds
without addressing them.  When design decisions are resolved on the
mailing list, the final justification should be recorded in the
commit messages.

Instruct authors to be particularly mindful of critiques regarding
high-level design or viability, to defend their choices on the list,
and to accompany new iterations with clearer explanations in the cover
letter, responses, and revised commit messages. Also instruct them to
explicitly document the resolution of these concerns in the commit
message body to keep the historical record complete.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Rephrased the instruction in the first hunk somewhat to be a bit
   more explicit, and added a missing verb to the second hunk.

 Documentation/SubmittingPatches | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f042bb5aaf..bbe759f3d9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -51,6 +51,21 @@ area.
   respond to them with "Reply-All" on the mailing list, while taking
   them into account while preparing an updated set of patches.
 +
+You should be particularly mindful of critiques regarding the
+high-level design or viability of your proposal (e.g., questioning
+whether the feature is worth implementing, or if the chosen approach
+is appropriate).  Defend your design decisions on the list first, to
+avoid wasting effort on an implementation whose design is not yet
+solid.
++
+Make sure that any new version is accompanied by a much clearer
+explanation and justification (in the cover letter, your responses,
+and in the revised commit messages).  Aim to make the reviewers say
+"it is now clear why we may want to do this with the updated version".
++
+Topics that fail to address fundamental design critiques without
+resolution will not be considered ready for merging.
++
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
@@ -323,6 +338,10 @@ The body should provide a meaningful commit message, which:
 
 . alternate solutions considered but discarded, if any.
 
+. records the resolution of design or viability concerns raised by the
+  community during the review, if any, ensuring the historical record
+  explains why the chosen approach was accepted over alternatives.
+
 [[present-tense]]
 The problem statement that describes the status quo is written in the
 present tense.  Write "The code does X when it is given input Y",

Range-diff against v1:
1:  eb5f96ab04 ! 1:  aecdcf0bda SubmittingPatches: address design critiques
    @@ Documentation/SubmittingPatches: area.
        respond to them with "Reply-All" on the mailing list, while taking
        them into account while preparing an updated set of patches.
      +
    -+You would want to be particularly mindful of critiques regarding the
    ++You should be particularly mindful of critiques regarding the
     +high-level design or viability of your proposal (e.g., questioning
     +whether the feature is worth implementing, or if the chosen approach
    -+is appropriate).  You want to defend your design decisions on the list
    -+first, because you do not want to spend too much effort in the
    -+implementation if the design is not yet solid.
    ++is appropriate).  Defend your design decisions on the list first, to
    ++avoid wasting effort on an implementation whose design is not yet
    ++solid.
     ++
    -+Also, make sure that any new version is accompanied by a much clearer
    ++Make sure that any new version is accompanied by a much clearer
     +explanation and justification (in the cover letter, your responses,
     +and in the revised commit messages).  Aim to make the reviewers say
     +"it is now clear why we may want to do this with the updated version".
    @@ Documentation/SubmittingPatches: The body should provide a meaningful commit mes
      
      . alternate solutions considered but discarded, if any.
      
    -+. the resolution of design or viability concerns raised by the
    ++. records the resolution of design or viability concerns raised by the
     +  community during the review, if any, ensuring the historical record
     +  explains why the chosen approach was accepted over alternatives.
     +
-- 
2.55.0-rc1-93-ge727df1850

