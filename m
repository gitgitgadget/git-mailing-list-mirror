Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A4242D91
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214672; cv=none; b=Mo1ldNusHiyscGXznV1jqWT1/H9OpNLrkCkCV4pQPISpaKgbp8snCs8AdGeZHdIsalpzpNBLh/O8Bsw4BAidjZmPtPFhQTQn+SDRpJtiNwYxu/TJBZfi/0q2jkhboFeYNnbY2iNnnjSJ7OMsF8KSSVQ9ID/BXOFQAN5dY7RgWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214672; c=relaxed/simple;
	bh=q0GoQW9Bjktl3ba8PWiqpmGoSqgvlJgtt2k/JG4cFSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2Ou4KQH84Z2H+DocUpvkcZeT3FjW0E1ib6EjSW+nJdVY3Ix3KIPvyw5gcKaRC7R/JYng4HS2yE2HWcbd9T3zpN90Qc3NoNnvDA+1OPwZUL0s+SDpTbKkk1ukmcja7VqlCp59f/raVCzRgs2HKq6f14tP4HT70kkaGsMEJLMyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BaGX6kAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRnaut9r; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BaGX6kAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRnaut9r"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44B60140022C;
	Fri, 27 Feb 2026 12:51:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Feb 2026 12:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772214669; x=1772301069; bh=NObeGo+Pop
	kusN/rvPdt6t7SCHrvT6vW381SWK6hn9E=; b=BaGX6kAHy0IarpM0U3VHHxMLaw
	BQtLbTJvLu9egreHR/ZgB91P3bhNUs6yapcelYlKC0o3b1ddBSahpiad8Pk7C+Ur
	tQIewWM4tpDUs4aiw853EJ/dQoL57TkqxXORLV4l2yIbQnpOmJySfdGhITvUo4YC
	n+iDwtL6lKaQtlfWFnNpt59IoyyhnxaZgABvd69Nfb0McAB1BuIPly4mCZRjAACx
	kpBq9lDDJmy/kOAjIdipmY7139wx4uipAecAXuti0LAVD+FXwKcdb2rojmbf9Hdp
	zlDPtQIyo7MxXmtvyETXniXbzE2e2g4DYTsF6pzRQP1QuX8GmjDgODKEHRrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772214669; x=1772301069; bh=NObeGo+PopkusN/rvPdt6t7SCHrvT6vW381
	SWK6hn9E=; b=gRnaut9rj4Q6eOnKq7pgssRse2VWdu0BffL6Yg6kXPCAwG8kWCF
	VcjrPKpXYKy3bvAvfzi6lkWXk5jJvHeFNw4nLECoUYyK9lCYmegYWkHKBg3Bn5Mx
	NT+wxk3ObObKfu5txAyHC9k/GgjJN075snvrz6MUaSNrcsE+j5oBhtOPW4jUP83t
	E0yirW7iJaao1xEbsPuk+da8BiHCVdqW/n+pGjQ+ccNe5sYEhFPnvr/tq/ZVlIee
	zqOH8VlIbUApAN2AbhMt57lQ5PCqY5nX+DKtnrcJ4LxmH3onqO7jcyTtT8C3rKAR
	xc22jltGQirOQvlEowyMVPq30PGD+hLKn0A==
X-ME-Sender: <xms:jdmhaSYpPSvhFQkzbKRIr7GNVtnzLLSGbR5x7I_v3HbXp6Y-IiJG5A>
    <xme:jdmhacZpOaI9qtNSY3Nghjajb8jntrx7UkAhGqjJ7dLhypL4vVzfb83IbQ-DM1_vV
    Fe5MXkSYWeYBPkLX18lh_G-gvtHq_2f8oRxs15A5-v91oCMF2_fsQs>
X-ME-Received: <xmr:jdmhaR_760vMUGznjdLjl87HvWawLhbwfguQ_cLY66b5XepLDidWmZC_o1SAnT3aT457hAMGQ60-LXA1RAszRlqwV4D9PjCggg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jdmhaTjUy5J9rRgAdaTlVgLQHCQgAsrCXRDqueeYjEKFC7ZJVbaOTg>
    <xmx:jdmhaZfhVIKF3f0YBi62-0MivxLDEYFiWjaMmEwoKuFWczORhqJTNg>
    <xmx:jdmhaSoFnPjdDh8YE_NDO6bJfRG4U0NSuNC0nqhZfyz-TpvXdifROQ>
    <xmx:jdmhaWACtb23c0flv8KGDBNa7XDP2tGDhzT7MeyjAnYr5V3IK7VuQw>
    <xmx:jdmhafeCR59UaWh-AMwptB3w4XTQIY71hRWAs9CZhrXDNn5J95b2BV0G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 12:51:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 4/4] format-patch: add commitListFormat config
In-Reply-To: <f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
	(Mirko Faina's message of "Fri, 27 Feb 2026 14:18:12 +0100")
References: <cover.1772156996.git.mroik@delayed.space>
	<cover.1772196510.git.mroik@delayed.space>
	<f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
Date: Fri, 27 Feb 2026 09:51:07 -0800
Message-ID: <xmqqecm6rs6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Possible values:
>   - commitListFormat is set but no string is passed: it will default to
>     "[%(count)/%(total)] %s"
>
>   - if a string is passed: will use it as a format spec. Note that this
>     is either "shortlog" or a format spec without the "log:" prefix e.g.
>     "%s (%an)"

Hmph.  

Some sort of DWIM (e.g., it is not "shortlog", so it must be "log:"
as there is nothing else supported) can be beneficial to help make
it less cumbersome for users to type for command line options, just
like we did for "git log --pretty=X" where we take a string with '%'
in it as a cue to default to "--pretty=tformat:".  But as "set and
forget" facility, there is no strong need to prefer "%s (%an)" over
"log:%s (%an)" on the configuration variable side (other than being
consistent to the command line option parsing).  We would probably
want to give an escape hatch in the design to avoid painting
ourselves into a corner we cannot get out of (imagine what happens
when later others want to use something completely different from
the log-pretty machinery, making "not a shortlog, must be log:"
assumption invalid).

Something like

  "log:" is prefixed to the string value, UNLESS the value matches
  "^[-a-z0-9]*$" or the value matches "^[-a-z0-9]*:".

would probably be extensible enough.  To avoid exposing regexp to
the users, we can say "a string that is not an alphanumeric token,
nor an alphanumeric token followed by a colon, is prefixed with
'log:'", or something.

WIth such rules in place, a new fixed format other than "shortlog"
can be introduced (e.g., "middlelog") without getting munged into
nonsense "log:middlelog", and a new parameterized format other than
"log:" can be introduced (e.g., "pretty:%(subject) %(author)")
without turning into a nonsense "log:pretty:%(subject) %(author)".

Or we do not have to worry about these if we just use what the user
gives us without any DWIM.  I just do not think we want to see the
"not a shortlog?  must be log" burned into the syntax that will have
to stay with us forever.

Thanks.
