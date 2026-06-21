Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0622AE76
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782073497; cv=none; b=r07BD1A1ufLZI7kBobBme6GHrLwlVjfipn7wsPuiyHid5RsgRYWE8tVayMqFZlIF8NtvsdiP3VpGg3CmTl2zyGBF/+PBqq3J9QBcZI2SSsFDxGQR/U24uQBL00b1VUu2nWAmyN6mwclLuPKjpOg/5NyB2jrUTpt/PagMbibkMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782073497; c=relaxed/simple;
	bh=CoJflLV1IC2zKvn061pA6ZUr7gjdWFUEi4Ed5HRlCNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1iGDj97jMo/UD7WD0jnydtyXa3dRNmunMc/JwihyzFKl1NeBSSzGr2esROZQJAesCwVKOsNB6yXDfL/W9uY2DJKwTuIOZAe4InkEfDbprRs0OeKDzLioO+HVmFcbk0popOaT3E2uU+k5L2oa2/dGUMrspy1tWGGTzr+Bcj/Hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PtOjXjmx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghKNuXuh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PtOjXjmx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghKNuXuh"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7297A140018F;
	Sun, 21 Jun 2026 16:24:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 21 Jun 2026 16:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782073495; x=1782159895; bh=CoJflLV1IC
	2zKvn061pA6ZUr7gjdWFUEi4Ed5HRlCNE=; b=PtOjXjmxZw7HyedgOtuOdTMBcK
	2UsmxrcG1t4P4Wd5xYgAKhkZAVkXEY7YbrjW/0NSSvqsGKVfPk/yN/Q4iHYgtKdc
	XlfLx2dkJIbY56Vkh+DSFdpB/VekT75jCNG4bhmsYZtratSbkegUpb6q/2Xp6yf6
	2Ms3cRCG54OaksiZ/6pcWfp0/eLbQPI/oAEBsvysrwYpTt21Jhi/k3I3G9IzBpSR
	mlpwmamLs8nfuxl/ZSwdhKgVXQvyWr7M/koNouUM3wlqAG037vP3ehUNpaV0dwKA
	jVFEK3i6uA1DTTi9k083qwGSH1oZNBiWIcOov2BRG9z7GNcrClaXjxf5A9kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782073495; x=1782159895; bh=CoJflLV1IC2zKvn061pA6ZUr7gjdWFUEi4E
	d5HRlCNE=; b=ghKNuXuhVgYZWSEbcfNZtnpWJjK5lbwf/5CO3HmK8973ouAWm9f
	bIQxIB+TswNnfgYFgWsEGaVXZzp6d9H2/WDzFfKNiqTrQgPzVGzxqZuBiM20XKvQ
	Y0EBNbtpolQcJs60Z84+DOfWCHTyQ8oK9J9GJLWNNd5DOsI4yzquvTAwy+epGlCV
	47w8+l0gilGU0nRIMmHkMXPao9SeMw3p2PbU3h4hKiCoaWL60K7kRT50JMwxwggs
	cUt43OvtLDQFTlHVDSnvBl5tRhtJ5DEZd2nd9K2CpYRE6it8z3cKqE/LOFGI7bQy
	/so49tbgDDlhc20OlXuNIvf20FgrndvqZQw==
X-ME-Sender: <xms:l0g4arNnOPtwxqARW6UiDttNEO48Qiux2-vRpLjdGbphsL4uXUXzxw>
    <xme:l0g4aggHHeVpJcVSkUa9R9xnwz8aey22z0OKKO1Q9_5754cXxSUpQl-dL0EVqtCew
    W2CX36ApNmouXF_TNBZKHWpE6_arcLehaxQuU0jt5qJxVC5v-SsXlg>
X-ME-Received: <xmr:l0g4am08LeZCThP3AE2fkjLCjbBDJrSRYlDSQ2jvXGkATBBv6whH4FhXqnmEtzovpIRqInx4-WC9lONwiov4y-z_AOENP17iqyTfOME>
X-ME-Proxy-Cause: dmFkZTFkjobu0vuXn1bNp6q1HjvhuvBh6F9K+djnF9ZKkdAML2T0J7BK1tNMTZj1sRzn6C
    pGh7ehHaqSHcOp8SFx2qOtkLmK2WyxcYyQr9siZBYtQDX/jYjYYpksg/wqFnmoCCz9/khR
    3Sghril6oRUzJIa41PAFjFLGqnfJLhUmyhAINVg9nVtvI/NbN8/czCeZm/BfrMkPw6T0/+
    hm7t1zS9RFu2KPembYcxFXtxfw1TvKzHxJmfdbnCxGK+J5u/mea4wlQF5GFIGA3knpPj+E
    6gpnsBxyVER7hXsstyk/E1FmNRIxOkETcwWKnpL6NBCSZf6JV/uXhep4SXw5h3Ms9ddifm
    +p/KgZtKd9ws0NQVPxDk3cltwLr9dF6kki8zQNKrjhTa2Pu/MUhc1S5Qe4fNDz9dFZsbWl
    Ja4q+4cXslEhzzx6Qs9SF+LcHbNIX9J0mHOWp0xFdms+GnsNE7VQ4j20K+2SBFt//yR7Kd
    Ueo+Q3t4UT4hjo0cLeFrUvz/SydlZKOaSjbdpWtGfkZBV7Butt1wYNZwja1Fbg6O0NlXLz
    IVDGx9m79a/xDeS9GyRDHB6EY6GQOXPzMtOMnMKBIm/rlvm04ypy1G+W+ReN9xca+Z+q0g
    l8cf0310WLp4e8Y0xjl7pPqaipLDDWlzlcjlXm+ZBVqIaEg0l3toFqnts3CQ
X-ME-Proxy: <xmx:l0g4aijeSY0ZVwvPnc2OuaGOg5mf4S8PtY1UP_pBZfkmD-t0N-o56w>
    <xmx:l0g4aufUgVHVMWAPwuz81Wx1WkTopH-4gLU_extlspxrBBxrDlum4A>
    <xmx:l0g4atlDbnhkJ2b8gnNumz6mDkzBAwQxnJJzRQ7SGrX0jMvREIrH2w>
    <xmx:l0g4avu_IC2j7Rn7CFoAnEZWI-MX_NW1llhqP_XSaWO74cGd4Yh_cg>
    <xmx:l0g4au_QR_-fAKdhFlxIQxypUX1tna9OvXRC1ggM8yz-55ZhjANv8vRz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 16:24:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <20260621174518.GB2206349@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 Jun 2026 13:45:18 -0400")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
	<CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
	<xmqqa4sog1e9.fsf@gitster.g>
	<20260621172432.GA2206349@coredump.intra.peff.net>
	<20260621174518.GB2206349@coredump.intra.peff.net>
Date: Sun, 21 Jun 2026 13:24:53 -0700
Message-ID: <xmqqfr2f7iay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't know if any of this is really worth digging too far. This feels
> like a case we could do a bit better at, but I wonder how much it
> matters in practice. As soon as you do any index-refresh (including "git
> status"), the racy entries are cleared and everything is faster. It
> just seems kind of lame that we write out the initial working tree with
> so many racy entries.

Yeah, We didn't want to stall for a full second back when we were
not using subsecond in anywhere, with nanosecond resolution
timestamps in place, we could delay writing the index file by 50
milliseconds, nobody notices the delay, and raciness would go away,
perhaps?
