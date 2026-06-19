Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA040D57F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848033; cv=none; b=i6TvgmhTbYZakC2NiUW3xCm2eOGjjSPej2XnZjuBbN7wsqppX4aecfJn8a7Bif/O31EGePGIuX6kLJhCh13TpRKoqO++OFZQQat0hVK9ky76bRaW8K/L5xohKXwXMANAvg5rVGCinpDFv+W8R31uEdWXn7hjrhwiQvsP/wQmMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848033; c=relaxed/simple;
	bh=i9vLNSY7vqUj+Xc19flkObBlAzdaTzqXa9NRsEUt+Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgZgxxkE6bpU2A9qZ8RYSt4xkRIbux0uW8eE9mh2uUAZesd5tkDtxF8p7BtGwWpn9ZHUADMeSHYFgfbf5UhHCjqehpstqWEkpdjPD+E2mfWPoyb7ocwrvYgdtmx3O+ui53mbRwqJmtl9vbPBkExPE5KJfODOTPNpD8L7szN9yNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ylwg6C3E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgDAoi1k; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ylwg6C3E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgDAoi1k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A22F14000CB;
	Fri, 19 Jun 2026 01:47:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 01:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781848031;
	 x=1781934431; bh=68rh2X564ZM0Mz91PYdGyycLtfVnVReG2qyBuQ0kM/4=; b=
	ylwg6C3EYI9h5mT1TPfCttHONXjnDcrvRPVBk7XE9aOnQO/mRAnG4Dex6qDV0D0G
	LYlBPBHAsoPpYfl6GSsVNUxbO6xQadfic87UeNj4UmWBodlChvwUfCcmyEkyfgXk
	m5ROA8mDJWdr/9ofER4L+Ppo0vFmmyQytmQWwT7doT24e+5THTRi+TSES0rkLPXM
	H39wjYFm84x21ygS1H5iKPu+09sMfkzlQByg8xCR0peQtWRS283ZmD+CLelaJ+IE
	riaM8h0jQsCeDy8zuEN1mG+FycKXFWBoscsbhBfd8beXK3Y8CekuQnGJC84xjmGy
	31rm1lmztKY2tIiZITkzcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781848031; x=
	1781934431; bh=68rh2X564ZM0Mz91PYdGyycLtfVnVReG2qyBuQ0kM/4=; b=B
	gDAoi1kMoYQUbIg93cECeLGZKt4WK463m+vIEhgkjh9KIwMnxOBiiWYDpLwmkiul
	8M9cOojbf8dAktgk6QD697Ky8z7SMfgKfTNJZgcIIbA1MomgPrLOsfhGVRUYNCZM
	RMwwJ6FOmdPAzHvGPMloc0BQNdYRV1F84s81pECsro0gQzXpgNaCHJ7jx+QzlVAU
	3SvifD+AzSz/gkmqqfyi+cNWC6f9CcDnavkXneTF3ouEplDwlL5mIWcVk75o2+uZ
	f6snPLnb7GXXbNx0EiCOKzQ+e4H4V8jfXom+IrCUDIxZf/gISSxMgfJjvq0AZDPV
	FW1YkJnM/23YdxVy6acWg==
X-ME-Sender: <xms:39c0aibGSYt9issOjrNqAHmIsNaOjdsk72Cjjkzji-2i0OJVcTEhCS8>
    <xme:39c0asZCppjNC9WNiJ0b9ZzUUA6FApftstAfYMyqvvTbUre8ixOODYBF4zyQSoZny
    1_gI1RgYv-cvMyj9QdZpeizh2hCzDiqCqZNHeUH0r97h4eatU2r0Q>
X-ME-Received: <xmr:39c0ah9gOg_6O-nc7UpovMeST3euAVq8H30h2bA90INJnppM1CiMlhKd27DXbf-pfsimAnlNEzXGEOHKSUI3SAkJGW_O757pOxEEs_SXJmfi_tw>
X-ME-Proxy-Cause: dmFkZTEVoJViyCXqLnW1YbV3bfakKhJpU9H18zFovGOnk2r5I27tufkSSC2RInSBzRcyxy
    jXMbMFawwv/AFAcTb1VTKeAmgZTEK4IAEmE+O4Y0sNNSSanZcVzypzIxEnMg33/rmgcNgg
    z3fdSNziYxoKBrxjVsoIjfOtVkMgFJF96kS19Yv30O7gFGFhRukH2S0x/xJm3aCSGzEM3O
    rcDo/47wW52Tj6Y80fUI4WJ2zGFcSo+hM3Ojh2VvJhTbCei6GCcOnDddgIrpkOGfEB5ttg
    OpczVvOfzIRLh+1SQJ5styzQQkrLcqZS5NGQ0+s/cqWHoBBThOBa7bkfhBukUOl3CvrWhi
    7tyFMVteGQIsq+SnkRmPWJ3UCvTAuG6La29Q87fBKlFclhWxRg/SdyWwpNg1VgiNw3LwO+
    Bvv0nZDUrAHA4/VoNjNp8WoIbJXveNbLg9v7OiDgu2HOYeGcSsS5jc9rMEdtFiYSbjSA1z
    ISNoKKiJbC7YrB66lD54dwHFgxzwxF8+y/oGEbrWNKWSWpIxITU2aQ0u4lH6OP1WAr+8B3
    WsLI6wBotjjEPqUkgPRe21N+sGWrKcV8g8SwqTQVtRyX2Cg7zlntG+BcLe/kGl3Z1Pze9T
    ZBEt4JoDSVmoKAOo3BcimQT0wYDjHFjePXfuvy1kNzmelOGTeZsqaDkqj+bQ
X-ME-Proxy: <xmx:39c0ajjV6kVizK3-nDGgcQf_XVEICwN1qKTK-nRauvzPpDXwEcXhEw>
    <xmx:39c0apdObo0l52pHSMPzZ68yi5xnf95_oqQGH6lqAiYiR6rmzjbVkg>
    <xmx:39c0aipuXQZY6xW7eDa244PDwSHEZU9qgWhMSdJQkK6zHgW_ys3Nwg>
    <xmx:39c0amC3ZClDgEbPjbUvZjv6V6nUTUszU_B1DNvY2JXxAEO0OSHJEg>
    <xmx:39c0aglQfUxtpmB1N82zY5XawsHHA-5qyBMShid6ckDrjN1K40nK8Htg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:47:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/5] SubmittingPatches: note that trailer order matters
Date: Fri, 19 Jun 2026 07:44:54 +0200
Message-ID: <V3_trailer_order_matters.9f1@msgid.xyz>
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

It matters where you put new trailers: they should be added in
chronological order, and each person who passes on a patch should add
their s-o-b last. You are signing off on the patch as well as the whole
message up to that point.

This also makes it clear who added what:

    Acked-by: The Reviewer <r@example.org>
    Signed-off-by: The Contributor <c@example.org>
    Acked-by: The (Late) Reviewer <late@example.org>
    Signed-off-by: The Maintainer <m@example.org>

The first ack was added by the contributor and the second one was added
by the maintainer.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Mention this in both the DCO section (new) as well as the trailers
      section
    • Emphasize and lead with chronological order and let everything
      fall in place according to that
        • https://lore.kernel.org/git/xmqq8q8mt4eo.fsf@gitster.g/
    • Msg: Drop “the the”; one is enough

 Documentation/SubmittingPatches | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 125bc0a2d63..56706e55ea1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -427,6 +427,10 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+Place this `Signed-off-by:` trailer at the end, after trailers added by
+others and after other trailers added by you; see
+<<commit-trailers,Commit trailers>> below ("chronological order").
+
 This procedure originally came from the Linux kernel project, so our
 rule is quite similar to theirs, but what exactly it means to sign-off
 your patch differs from project to project, so it may be different
@@ -487,6 +491,12 @@ particular are not used in this project.
 Only capitalize the very first letter of the trailer, i.e. favor
 `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
+As mentioned under <<dco,DCO>> above, trailers are added in
+chronological order; one person might sign-off on a patch and send it to
+someone else, who then in turn adds her own sign-off. Further, any
+trailers that you add beyond your sign-off should come before that
+sign-off. That makes it clear what trailers which person added.
+
 [[ai]]
 === Use of Artificial Intelligence (AI)
 
-- 
2.54.0.22.g9e26862b904

