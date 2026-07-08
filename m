Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C172E7631
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530592; cv=none; b=cvt8+gLCmQdMYaseLOgFKy6XQmLo9tCwT98iASvjN4aMh5Knr98bFCY1iuLV4tIPjrH52Qc5/s+awr+XqxntzsBo6H1LNC/3x8MXL9iRNzk0uBO0oRwppkeFp5tnYIU58uZsKc1W2iqepsHEmQ6sP1Lv2+vFCBt8e4T21EKwg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530592; c=relaxed/simple;
	bh=44UV+/XXoAhUTTnunbjX9/E74yG2elszc4YwKL/FEFw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QTy/bFxRVt0pQsErYy6qabgvvzsSZbjzm3Q744uyeTcdBntaQtYWSHO/ritWBkPHFrba4Y5ZVepMhJssV09MsCFVWel7OYNVXo8rPcJXtMSEB7E/O7s2C21azsJfZxENynwenj3jGMbVWe6JLL/Ic/hFlyzuvmUL6UolEafY6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hvWrchM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjPIxNyE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hvWrchM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjPIxNyE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CED32EC010E;
	Wed,  8 Jul 2026 13:09:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jul 2026 13:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783530590; x=1783616990; bh=42geA5sdkn
	/dY46kaARjcTHi9qIoucFE3l2d7gHcjmQ=; b=hvWrchM99tUe/wFwu+8Ch0pNBq
	ymx9y12skyctWqkl9fJUXO3ars0kfx83T6F9o1qFayuQaXpw48x4EBc5ifK2kBBV
	D8oQcTqCqZ4gFTari1yyw6k9qKlrSYQ34dCpp2gQqfU6DneF9x42xPLwBElNdrCv
	LZQv6wpbrpI27ClggKgm8A8azbddv4K7Y1kdeKt2AIFafetMdZhmfMKpFnHho2xF
	iiE1T2ArAObWHcuHgLlqb7ba/2hlygQnNuagJ0Or/yfz+FIgAN/8CQTGxPoWT+8Z
	ugAJ9EA5xI+q0jaPvB5SAz6ea7xwhFv/IpyXy4EgI/a7YEEsH4mnMpBg7ByQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783530590; x=1783616990; bh=42geA5sdkn/dY46kaARjcTHi9qIoucFE3l2
	d7gHcjmQ=; b=hjPIxNyEqtcy43qRsfz1QrHP98QIq6Vo8Dw/6934jHBKsIiOxEQ
	zRs0nw6MtzsbIJ/inpB1+4/nwwghmpt3Ia8A6A27q8fQ2S6+JffMYPhrshLAqwzh
	jyEs8CmicTGxggF2Sr1jS1BTDjSpDF64e9a614QPB7fsyPmkr4GCtDNIwlWaAKiT
	jr29cXTxWrhwrRBXVpDYZ3EGkxDBMzAh6luzviqvVRi8Ep5NajgNX0NZCwSeACwO
	qlKb4lKO5Br1+VfL7GwbJncHggjELN+7lH6JIFW8MYNuFr5snfp8hvD7/5EGg2TM
	nwqiaGuX00BEB56P13adTBIH2swgdYMr2Bw==
X-ME-Sender: <xms:XoROapgu54TMXzAJOZHipyztcgTV2vc9UcnlXxuynPRvChcl7_l2TA>
    <xme:XoROakAG_-a0QEGfpZhI4dsxIdA4le6BWxXt0xSOqdNGW89s0nn1-0zLKQYsEx-dA
    hQmeXBLf_zNXK5tRfEWqtbAbLfeK8YhfaWAQAw-RWcnnlTCuHscGQ>
X-ME-Received: <xmr:XoROamsffPHg4oE_JtQMK6AUexBZSc5v0q4kiVtGGpgxI8EI5LsQERXBNGakNwdHzd8U3MQuVZqyD6osbQcTdBk-Y25Oww0D9QnIhZs>
X-ME-Proxy-Cause: dmFkZTGa9BPxQDyyDDSNa+K9zu4Q5wU1tUYhC7c61d3qV3nuMwBnLlUK+Wo8o/iXxnRN47
    hPcTAasMOuMC3ap3ydWqEtxY0Wk4gBnEA2QU6Yr0+3GME1wcSODIdQwLkY0fqXYIdDdEhL
    imtfhfuZlxg1auyztsrXvPsH7KTtHFy/lOM0ZPFoqdH1aIV64VOKP+o/Pox7c81urRKVfq
    hS7Ga2xKcLGIqmJ8SOuOCtJHSlo/4hb2tWBigBnVDARMYZ6A/nqS4wjkEy/ba4eK0eHqtp
    m55Ss/oQe2TlZ/ZftH+ESWGLQQuk7QnufItGSum2NqsETkMjMsNG07ovO8n76bPZatUIn5
    9N8DnnhGg2wHnIYdW427GfvPjbxI+0l47TjrAqeTMHq70+f0SUu419RCpaSJNCaiQ1UgER
    9vc4HoTo1T5GLRh9jQ4nwaQgT4gPzs35lUMJ0/q5QeCYhGKUJojYLqEsGBuMGqwcI/iQ74
    FBich306dm22QgdXFqD/3+hRwgGvCAwd6OWRcAfQWStiq6Wny+2mJITjIRH6UP91BXKD1J
    W8BeBNe+SWK6MJ6623ZeDlHz+dYMSGuyBJ3H4ofJEKTaMf/PoUzWaWEz6Be1CfRmwOvxXs
    qe+8bSw7MUgmzd7aKlUn5zjkGl1Bx3hLeZVX7xj5zy+AEkYuJYvaK2Ndg3PA
X-ME-Proxy: <xmx:XoROapbLkT4dVzHWhDSed2qt6QWOL3vp1FtsvGKNkSkh-k8KwbPyLg>
    <xmx:XoROapXwCk0dXomBMmMMK41fuDvxU0l4qWRz5_9uFly1S5bPBQS0rg>
    <xmx:XoROat44wj6VlqWCZKHtApR712oZTj_aN2T8eiZXIp_TLeZLQLfN_w>
    <xmx:XoROakhdBgTmrDpF03K54Lp9nAC9Ag65VraBbhCx25Z8y2CDpyCS4A>
    <xmx:XoROas5oL8E3TPA70-HHZkAf-dxcUx8bcci8ei8Af8eqSgHCTsUJKmpy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 13:09:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] SubmittingPatches: document how to retract a topic
In-Reply-To: <xmqqzf02xonc.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Jul 2026 18:20:55 -0700")
References: <xmqqzf02xonc.fsf@gitster.g>
Date: Wed, 08 Jul 2026 10:09:49 -0700
Message-ID: <xmqqpl0xv25e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

While this document outlines an idealized lifecycle where an author
develops a patch, refines it with reviewer feedback, and
successfully merges it into Git, reality is rarely so seamless.

Sometimes, a topic must be abandoned. Doing so explicitly is far
better than leaving it in limbo, especially since topics can always
be resurrected later.

Clearly state that we encourage contributors to retract any topic
that does not pan out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Added the third bullet that talks about when and how a topic
   becomes stalled and discarded.

 Documentation/SubmittingPatches | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d2d82eb543..c269e474e3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -123,6 +123,20 @@ of review.
   top, it gets merged to the 'master' branch and waits to become part
   of the next major release.
 
+But sometimes things do not work as planned:
+
+. If a mailing list discussion convinces you that your changes aren't
+  ideal, please explicitly retract the topic to save the maintainer
+  time and effort.
+
+. If you must drop a topic due to shifting priorities, lack of time,
+  or other commitments, notify the list as a courtesy so others can
+  take over. Anyone can resurrect the topic later when they have the
+  capacity to do so.
+
+. Topics with unaddressed review comments that remain inactive for
+  four weeks may be discarded by the maintainer.
+
 In the following sections, many techniques and conventions are listed
 to help your patches get reviewed effectively in such a life cycle.
 
-- 
2.55.0-302-gdbd766b094

