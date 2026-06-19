Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270C2C9D
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847995; cv=none; b=BRbUa/3WrHeWrIhIih1UI4HbVga8LwzAY+MjunK1QhUSU5dlOr0zM0jdyoohZPlFB3xyZ1MzcawBsPw71aMhC6jYtsWqirl6i1o8N1Uvu7GVMCw3Whsks6brAixB2lrsprcmpfHreNGYsHDyS978TQrdHFqQTdYBdyjFZBzqVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847995; c=relaxed/simple;
	bh=6m7sLZCQYsbDLoR7Zg3hU4y9V5NdwDby5YN+X7Do4u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5nifU4Lwu5HTC3z4sCwg/9KaNBcWffBycQMJ7a6E4CKb4t75ofcoHSykTZPHY5bunSSN8Ofh3/vymOVY1UK5HOOTcP8EILQQ3h8QTNrQ0Y0/ZUgE5AsnEvAF5IL8IWF5DXsqTAGoZJSCyLCXd1rG6ht3MVvgef2FgbzsWkqR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mOySEKp9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+K845qI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mOySEKp9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+K845qI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44B0314000B2;
	Fri, 19 Jun 2026 01:46:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 19 Jun 2026 01:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781847993;
	 x=1781934393; bh=J+sdS3RdK91CwHY64DXJSjBNK/nmnrr50rBwB/afLxk=; b=
	mOySEKp9uCp1CziJn+rA73am8SbHzw7kO2yDZMxuKchKI45DQnZEhiQyGTyyTgJ8
	4Z1DrxWTnf4GKYqO6KCkpmeLkFh28ynQp8Iu5UO6Ac07eykkWM/HtN/scucVbhNR
	CQy29HPK8DsGbzP5WHBw981HvjYg35hVQuoy7HCtBoyNoeZEf8XshQInhgTwz4PJ
	L86olT+C/Vjnzw7L3At3T5kIFYeAt088sBEJ0Lrt85FgvgiGQ8lfsspXW6IpUbiN
	n2itJUsuEg3QCMN4NJFXNPgJILB3op1ZhN+b9ALpxDCKBlyyUVuP3u0HJlJE4Lti
	0gxDFWnFQ5iWe8wIgduhEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781847993; x=
	1781934393; bh=J+sdS3RdK91CwHY64DXJSjBNK/nmnrr50rBwB/afLxk=; b=N
	+K845qI56QPq+wLt+iyPZ3Pma+RBdV6QRIyre6SgS03jFwnbpGsSuImG/2wVAtt4
	BiRZqHGUxp7SoCXyQVcV0DuxiNQTzUGPKLzFBSJB1OrVqy68ZvroIe7ajnTXPrY+
	F1dw8W99fNeRxlGnD8VI6pTtU9BL/QwWUUQxPcCg4eQWyAbmpcDOYbD9OTRlotNB
	sSJ2ElvkGWJ4cYNZIW/1uPNjD4mx2UxyRsVPxoerLtfQM98LT35dzIHcq30IuNF8
	dUujtcUX6oH/7eC9X7IucC+fJPE5mBb2mheBeMEzuDoqXKZMbXUau+M3IMZqxsOu
	6DILUThL5yq8LuE8iT0Lg==
X-ME-Sender: <xms:udc0ajV8dUS4bH-w2jDitG-x5OTL2KOE5QpGxoRCk9UJRR3YiNba-dM>
    <xme:udc0ajB4S9y-l11b-fOtGTA6Rm_yLan6Tk-cy93px1Idviyqhmn9H3NH6Q5lkFx6A
    ztoTQcTw9XmBDZfz2jmsHiiCraz3r5K7kr3I32Q8IJyjdbsjavCZQ>
X-ME-Received: <xmr:udc0asxU2zqlUloijAXmi5hk53B1SnUvP4lPtPqMVTof3Z8zXyutt1TpoBytjf9MAXB0xkRlGulhHmPlnmqAc9-3S6_5HJxZalKJhCbkYkQtDVA>
X-ME-Proxy-Cause: dmFkZTEVoJViyCXqLnW1YbV3bfakKhJpU9H18zFovGOnk2r5I27tufkSSC2RInSBzRcyxy
    jXMbMFawwv/AFAcTb1VTKeAmgZTEK4IAEmE+O4Y0sNNSSanZcVzypzIxEnMg33/rmgcNgg
    z3fdSNziYxoKBrxjVsoIjfOtVkMgFJF96kS19Yv30O7gFGFhRukH2S0x/xJm3aCSGzEM3O
    rcDo/47wW52Tj6Y80fUI4WJ2zGFcSo+hM3Ojh2VvJhTbCei6GCcOnDddgIrpkOGfEB5ttg
    OpczVvOfzIRLh+1SQJ5styzQQkrLcqZS5NGQ0+s/cqWHoBBThOBa7bkfhBukUOl3CvrWFw
    hLirVfapTKAElNPv+8CshnGknba5eEObKYICMyDssk4l0/q8LSibcYYpnGF/ZGYJz1WVRx
    6Cf/enIgyFYtohnSaL7dTHFqb73+VPQCTHFKuQL5S0Ir2YL24u1D7zYWmx+fy7kKLTn2CR
    /u2SJisfcaqTCK+nL+tR/tzpyCUxI7OYVWFFnO4wDNLIsfia5C/xqunhZVZhJRxXXBtUfS
    aKuKY2RDdC6jMNc8q3LAaKMvY7EttK1vrz4xlwcxS9kb6/KHLSVrj1jRTJRkTZwGRoQ4Sj
    VE3wsNz0nsVS++wz4YEuTaJXLA136LV6DwKFJ0tCgETVl6Z+WYFisjD/TsHw
X-ME-Proxy: <xmx:udc0aoDmbBo-iHNwhngpspRASqtmVz0S64jbCHmzosYuLRd4CphOJw>
    <xmx:udc0ahag1v-0cHgwhD9xmX17Rfz1ZDss33qiR-zyxkL9heF9gpm0NQ>
    <xmx:udc0aohuD3Xbd7D5BPo6yLQPeVnA2LyrVbbNvzg9ZUkBQq1hJ45VIg>
    <xmx:udc0ar5JE_jZrI-SnIZW5AtpWA0ztEVFewC3mfsvyDdyEJnQKZHSag>
    <xmx:udc0ajK-FrAgrm-OKl3AohyUXUIcV2QSjj0Q3-uPQYlB3LQzYjl2psYR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:46:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/5] SubmittingPatches: document Based-on-patch-by trailer
Date: Fri, 19 Jun 2026 07:44:52 +0200
Message-ID: <V3_Based-on-patch-by.9ef@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This trailer comes up often enough and the use case is not fully covered
by the other trailers here. For example, it is sometimes better to use
this trailer instead of `Co-authored-by:`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Do *not* say *without sign-off*; do mention the precondition that
      it is signed off, and cover the case when the patch author did not
      sign off on it
      • https://lore.kernel.org/git/xmqqse6tnho1.fsf@gitster.g/
    • Drop “without a commit message”. It doesn’t seem important. A bare
      patch is just a patch, not a patch plus a message.

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8d946e9acb3..5b4ab93543c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -465,6 +465,10 @@ These are the common trailers in use:
   and found it to have the desired effect.
 . `Co-authored-by:` is used to indicate that people exchanged drafts
    of a patch before submitting it.
+. `Based-on-patch-by:` is used when someone else authored parts of the
+  patch that you are submitting. This might be relevant if someone sent
+  a patch to the mailing list with their sign-off. (Be mindful and ask
+  them to sign off on it if they did not.)
 . `Helped-by:` is used to credit someone who suggested ideas for
   changes without providing the precise changes in patch form.
 . `Mentored-by:` is used to credit someone with helping develop a
-- 
2.54.0.22.g9e26862b904

