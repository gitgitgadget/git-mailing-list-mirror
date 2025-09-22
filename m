Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD3285C92
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569788; cv=none; b=htzREqdWt57TB002hIS0iZWSmNrEDAflSuYqymOMkwXIyZyTlrIYp49VcEiYknYL1tcINSr7t7MrJ24ObbNDP3r07Ox/BOS99kgyorkjFFygK4P5WYh8YSs0yIlMDVOwCeunpVjoLvbuWkL6zHRKm7awOqorCZkLsG/r0TC2Q4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569788; c=relaxed/simple;
	bh=fD+nL9t6vMMqK0nJLnl5GXjdVgP9KcimvlG+WZqME7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/s8aJk2sd48qOaxIu/bj8Rxk0OKZvY1r21FNLN8D8Uw5GfaxgGXNPNM1+RzD5qgUkVjJTEx8vKV83/Qw0uNvXStbldyxStyOnq0KnRdhyeo9SaoJYHmX8A+PPaRh+JMltT0O7TmNOyR9TC192XXaER4dOLbFvi5AjP3dRFXUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dXqVr5ih; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OagxYaze; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dXqVr5ih";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OagxYaze"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BDEF57A01E6;
	Mon, 22 Sep 2025 15:36:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 22 Sep 2025 15:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758569784; x=1758656184; bh=Eqrnas3K+L
	/ge7fpkYEVxTlpzR7H+xKfBFA9pu6rnPs=; b=dXqVr5ihXk8nSs9arcuWeRD0W5
	INUzRskDe2E2P8ShC0Lt+Lipeh8THZDmq6YP28AVappsw/wYxEge+GHMG5GBMzum
	yQGXjtwZlTe9Ee7Pok7O0OY/CiYfWdZjzkQBHanyYNXlUzYK6jSRQLRcALRppmRo
	S2hAk8suQXUx+ZUstrNivZ6vdlydnhX3diUXgorL/rGV2H6rIPTGvB6r531mLjt2
	56P3XKh8vX3QIpJtQXeu6wDy2PiHUliXDO9Rhp0p1TeD3UwWkCnJcjBRV0UzvndD
	s5Twevtqy3QuhnUpTZuCbWkBo8ggj58gVu3j6xQRFL4mk8fr5RmCWtrT7y9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758569784; x=1758656184; bh=Eqrnas3K+L/ge7fpkYEVxTlpzR7H+xKfBFA
	9pu6rnPs=; b=OagxYazeVOcfjg0kfT9FO7NcGU8mPH9LB2dG4EjanZtjeSmGeMb
	G3guG/1PCslXreCIsTDtEJwiN97EFMjjHGy/SopOUpYobZfrj/TJ9/3sjKIlrkku
	5HEoNTAPia7FIHPg56IusWcFEsNR7UzFzolhloyFZ/vFCD3tz/T3sLIuKjL5aZUj
	H3SY9ToguJnbgoMxRQnU1faJds1wgCNxUJz2iFHcSQWueQf/LitUo6XUuOBg3JuA
	gpxD/bTaTmA/eTWx4m5ziMhMKv8vKmBb85MSLXLVMk94PE9jCqEd+yPmnxWqmAtJ
	fTBxFnGZr/AcMXqcoA91urS63jRtY8mg8ig==
X-ME-Sender: <xms:OKXRaHTZjJeE_k4p78W6ZLefhJteVPzwpo4AZbbhUS3yhLCy6sJPZw>
    <xme:OKXRaMcPuBgbpAYnP75OGElCi-Z7b4kUFKuF_KZdIqhVntFZDZow0N1TQ1qbO1Xb6
    YNuQrAb9NWJAJWBsrgkAJolZhOeTzyglqcVcWlQBqoCcHwLEOQ2Ug>
X-ME-Received: <xmr:OKXRaGrcwkoydQ4nLu5bCk668aM4B_ejnqS5nbWhfYPA5C0oLM_k19ZVxbyGbN6AHTWjoKSOoAjfvYOiioEZAGwzlO56QTmzpbg5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghpvgesrghpvgeftddttddrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OKXRaN-EpOg6-056wmqg2MwF0WBIUQnrGLOv3EiPQYdWU_1gJcM-gQ>
    <xmx:OKXRaCe8diPgh337CWmBz4BYMSzb-9pDwR8xqagadBdjIvNONH4C-g>
    <xmx:OKXRaHJFvZsBJ1nVEmNiS9I81Em5kETFjKsZccqF6C9FjJ6Fyy4IWw>
    <xmx:OKXRaCh0G0vbIs3yin14tInDNcnSTFoOxksmYEYnyaTNp1XTIArFRA>
    <xmx:OKXRaNKinI7g-fn_LABII9-7WA-oKNrpFO3JO4l3qmXLOX-LptmO8EPT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 15:36:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Lauri Niskanen
 <ape@ape3000.com>,  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
In-Reply-To: <20250922190555.GA2205919@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Sep 2025 15:05:55 -0400")
References: <20250919223351.GA3906184@coredump.intra.peff.net>
	<20250919224027.GA594545@coredump.intra.peff.net>
	<xmqq1pnywkwv.fsf@gitster.g>
	<20250922190555.GA2205919@coredump.intra.peff.net>
Date: Mon, 22 Sep 2025 12:36:22 -0700
Message-ID: <xmqqikhath3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yeah, I had originally written just:
>
>   test_expect_success 'stash show -- does not leak' '
> 	git stash show --
>   '
>
> but it felt funny, since the test is doing nothing in a build without
> SANITIZE=leak. If we are OK with that funniness, I can switch back to
> that.

We have a prerequisite for that.  Very nice vehicle for
documentation purposes, even though we do not care about a single
"stash show" invocation for correctness or performance reasons.

Perhaps I can squash the following in, unless you have other changes
in mind.

 t/t3903-stash.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git c/t/t3903-stash.sh w/t/t3903-stash.sh
index 7ebeb057d3..930c31e547 100755
--- c/t/t3903-stash.sh
+++ w/t/t3903-stash.sh
@@ -1741,10 +1741,8 @@ test_expect_success 'submodules does not affect the branch recorded in stash mes
 	)
 '
 
-test_expect_success 'stash show handles --' '
-	git stash show >expect &&
-	git stash show -- >actual &&
-	test_cmp expect actual
+test_expect_success SANITIZE_LEAK 'stash show handles -- without leaking' '
+	git stash show --
 '
 
 test_expect_success 'controlled error return on unrecognized option' '
