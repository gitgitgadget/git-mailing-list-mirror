Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA095446DB
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855685; cv=none; b=afUe/5e5Xx/26iBvGMbjQ805miEldnYsHlo6d6/+GOKBBj4n0CAZ1ZiZPl4jTBg1UKYNbsv4wyVFR1FX6uwMRj+DrHID9tHp4lNQqMbtaTQMEvdKdOEeOsc883n/0AoD4RN9O0SPq3dlsUMntffkYnXIu26rIV9KiCcB4uUmdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855685; c=relaxed/simple;
	bh=vdt4woLISTRfgH8qCq6hyLOEmGWcFylUIFwpHZdT8aY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KRonoIG7xqCD+V59xEhE2LuYTJrMrlyiizKE8m2NfBk3mgOrZbi9QGPP/eUTddkqHp1Yi7pEHpwXfGItuMI6Hd8Q+Pj3mPswfa7PhF71vA117Gr4O336Vx4d7H6clezSkowdtKJGW5+CvW6/JeZwlsnw+qfG7bfOR7xtr9smsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=llGfasOV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="llGfasOV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CAAA2FE8A;
	Wed, 24 Jul 2024 17:14:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	dt4woLISTRfgH8qCq6hyLOEmGWcFylUIFwpHZdT8aY=; b=llGfasOVCLXgt82ZU
	1Q+dPtPTffluqese9yQYyeatkywdJJBOFXOQZxoQrIZ08ycyfV5aoMlUfxRyS0yw
	p4hJFKn+xbMpnb1dD/Hmtioe7IFv4jkauAC+SCl4qAjP4tZ7QRTJqLu4Hg9wKmEG
	XE/a0ene6LsQ302H8nVUK/2eiY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 45B162FE89;
	Wed, 24 Jul 2024 17:14:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C25E72FE88;
	Wed, 24 Jul 2024 17:14:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] ReviewingGuidelines: encourage positive reviews more
Date: Wed, 24 Jul 2024 14:14:37 -0700
Message-ID: <xmqqsevysdaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC67C93A-4A01-11EF-A412-92D9AF168FA5-77302942!pb-smtp20.pobox.com

I saw some contributors hesitate to give a positive review on
patches by their coworkers.  When written well, a positive review
does not have to be a hollow "looks good" that rubber stamps an
otherwise useless approval on a topic that is not interesting to
anybody.

Let's add a few paragraphs to encourage positive reviews, which is a
bit harder to give than a review to point out things to improve.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/ReviewingGuidelines.txt | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git c/Documentation/ReviewingGuidelines.txt w/Documentation/ReviewingGuidelines.txt
index 515d470d23..f78146a410 100644
--- c/Documentation/ReviewingGuidelines.txt
+++ w/Documentation/ReviewingGuidelines.txt
@@ -72,12 +72,29 @@ guidance, and concrete tips for interacting with patches on the mailing list.
   could fix it. This not only helps the author to understand and fix the issue,
   it also deepens and improves your understanding of the topic.
 
-- Reviews do not need to exclusively point out problems. Feel free to "think out
+- Reviews do not need to exclusively point out problems.  Positive
+  reviews indicate that it is not only the original author of the
+  patches who care about the issue the patches address, and are
+  highly encouraged.
+
+- Do not hesitate to give positive reviews on a series from your
+  work coleague.  If your positive review is written well, it will
+  not make you look as if you two are representing corporate
+  interest on a series that is otherwise uninteresting to other
+  community members.
+
+- Write a positive review in such a way that others can understand
+  why you support the goal, the approach, and the implementation the
+  patches taken.  Make sure to demonstrate that you thoroughly read
+  the series and understood problem area well enough to be able to
+  say if the patches are written well.  Feel free to "think out
   loud" in your review: describe how you read & understood a complex section of
   a patch, ask a question about something that confused you, point out something
-  you found exceptionally well-written, etc. In particular, uplifting feedback
-  goes a long way towards encouraging contributors to participate more actively
-  in the Git community.
+  you found exceptionally well-written, etc.
+
+- In particular, uplifting feedback goes a long way towards
+  encouraging contributors to participate more actively in the Git
+  community.
 
 ==== Performing your review
 - Provide your review comments per-patch in a plaintext "Reply-All" email to the
