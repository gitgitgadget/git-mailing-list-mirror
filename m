Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39354414415
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070066; cv=none; b=ZSS87drf5SD8dz40pXQCUStWDEjO0imnfuQJxpt8JxG1nDmJfop2THKCMaCGWcNRMOnZyOixV/xGGG/KRAZEjLXXPfmZHG3VFmMuMOeR89atTzTqRGdyY+IR/Aw63TMZNrKxzV24vhBOet5EbGq4Nh8Yv0/8eO96G9hxTD/CNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070066; c=relaxed/simple;
	bh=E7fHiqDRIl/weUlrhFupBVfCSX0FqOYLqjEuDNafazo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCBpEJz1q3OCPm1b9gr54YN/J/brZuJi9Dl9yv95EBjRsNXB425vhP1xahRYSSnVxK88eMJj/hT5syJW7GGzoxKi664Vv5XVtoZpJyayYnJbRYVoYj/gDm0ESPXxvcbd4OOptJHS/Vr7h+Y/vFbb0K51FA18lDWgd+XNLOzgDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gs92db4V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RrrhZQ8S; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gs92db4V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RrrhZQ8S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 17EFCEC00C6;
	Thu, 10 Sep 2026 15:54:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 10 Sep 2026 15:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789070063; x=1789156463; bh=JWDB5L1K4Y
	HVFv3slzyRvtqmxGcG7KbrYLuhj/DPUKI=; b=Gs92db4VWXMKsNTbrg+otJahwN
	b1ujvrvrIDWL5m9y7KbGbaWe2oO1fKCsx9OTNRq0w6bm55qVAoHou3XGNXhtUGL8
	bzHDdmExro4DT5WlOLJeuhj+cBGk64LUaM8OFQBhzoDuzTwI3b83ZIYpQzBIhtYH
	hfuRV105nlgkmHPB9eVRNZa6PweKSqpZnrnAa4WqowLx1GdwbSbkpA9S74ZUl3Xa
	61S99UGuNzkkPnaFrm46jfUN4qKTcWKLdTBVfMr5hWSSc4/IgQ8W9t81/u/fIpFl
	TK3Uj1NYMPMKZgAq+5ggJYH4MAWzGqUf+oNIKnO9tAmW3SpM6fLx5k7m+onA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789070063; x=1789156463; bh=JWDB5L1K4YHVFv3slzyRvtqmxGcG7KbrYLu
	hj/DPUKI=; b=RrrhZQ8SYbGo+yJQfLTkkXtpfwR1yPB/PO/ov+TNzNV0yZyjReu
	FGodLmKYNqMEwBjzmanuImp7sv7Fc80fXcNDRFHIs0vCzg0G/BpbtnUMtxDKiwty
	25wc1O6ANxMwyHyxSwreMrxXx2CDfHo0ceqepU7jMxG938n0MNUqv/oVRUoDNq/h
	U5BdiDNaiyjXyLBULO7twgq1ntiXV1eLSbqepJQPj0L/Qh0mg5FRxKJsRUjzC944
	Q/jAqBfhYPlSR0erRvAgjOQgDRhPSsGuVNgA4DZQOyPuJZISB3m09O53doR2/f/h
	VuoPrWtBamGzje9Yv7D8dO/ySpxX9w7O6cg==
X-ME-Sender: <xms:7gqjasznp9zspgKl8Ius21PNA4rU3rKN5tcGX_ZqlEq_bmuQiSSzhw>
    <xme:7gqjaj87QF2cWd0KrtG2YfWc2sE7TEf8Ol72vvLJptO7XGvmnmGWnQjbmDrSVSfZk
    1iCn54nWtgeYT0FEmEJsJWddGFL9D6QvE7jiNmIe5_QnAQS8manXFs>
X-ME-Received: <xmr:7gqjaoIua_J_vrNZbisE0HsnAcpbKjJou_fG-_A8_YNNHBbo2OhiENLKniLhz_oTzRf7TapU8R2Uu0dBSULbiQjdKoyG4tS1WVuS>
X-ME-Proxy-Cause: dmFkZTGUvykYuhGxUYJ0BFkh07Gxe/G+AlZrR/C/C0n/RNbsWZpnJHDtUHrf9sniNpfj/6
    OWVGvtVUrrfMPJ0aa2BTc/XNsGaJjfP0Rxp9KUuYeczpVPjj2zzZfHlnW7J7Fb1HzdG9r6
    Al66KUpbYuOTmKzV31VKh9dkhD4m92iIc/qWHbeVG47SUBDwr4W3nn+0HobDJQ/44yPSBo
    TzxKCSDqFZoClOJ2tX5LRekhs6DvjHzefXnI03ksHuTg2TNjw9zq/v/+IaTAUBqFVKpl6M
    5H1sFmGFFhTQ8vLMsXDvXTJk3yl9nAsWBv8TuN+gIMEmcrebP6HInWOyvT7hbINRQqkiGu
    X6u2egLwhwCPQICMkeqA08y+NEurnWSXfo5j9fke4iwQqqaRJePJkoVj5/TXuunehrh9oG
    o4eaaGhS2ARNeMn3GyBk3H1UPxhmSkJBMw7XIlCI4GSwm2arg+0lF7sasXwuaLGHfux16n
    J8SOEHF3+fzwtGmDu29NsoTrx/z3k/qIemjnRQM9zNAw4IgtySM27FNshjH+vovowNTsmQ
    banOkZMo7lRWpqxK9j5R4e7ZgoDhBDeNLUBNwdsJyGYLaR4gveYvJZIylCebl5i/BARo0V
    j0ylgyPSHjT1LIf8fW7vBQGHjk4c09tSlAlsYIoPvReWfZMRJvfYfPhhpyLg
X-ME-Proxy: <xmx:7gqjahcJMQNKRg6XXSZZtvmAHNxbOW2Zx_EtJjFIF5puhc8riFUV_Q>
    <xmx:7gqjav9XtSMDeT7blma4WZPjCjC2w0I17WRBsZAkYJVgoDHe6eTHyw>
    <xmx:7gqjamqwifEcrDNgsjx6QbB7OI8ZYfFFTHS-PcijR7zSDE64FGjVKw>
    <xmx:7gqjasDP3yf8-BWN0_9BU7sJPjwbA_Q3MK_Q-zzWsqtmiDh3kKndKQ>
    <xmx:7wqjanYBnh_Whqulvg-NjXbp0e61wy3cfoZ-aYtzrPJxkOgRcZx8oHMz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 15:54:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  git@vger.kernel.org,
  ben.knoble@gmail.org,  gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260910190345.GA903701@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2026 15:03:45 -0400")
References: <20270829004959.90983-1-ub4nal@mail.ru>
	<20260910085353.109373-1-ub4nal@mail.ru>
	<20260910085353.109373-3-ub4nal@mail.ru> <xmqqzexpf78k.fsf@gitster.g>
	<20260910155247.GA251185@coredump.intra.peff.net>
	<xmqqpkyldke1.fsf@gitster.g>
	<20260910190345.GA903701@coredump.intra.peff.net>
Date: Thu, 10 Sep 2026 12:54:21 -0700
Message-ID: <xmqqh5jwevbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I kind of wonder if _all_ advice should just say "--global". I cannot
> think of an advice flag that is really repo specific. They are about
> silencing extra help because the _user_ understands the situation and
> wants Git to be less chatty.

I think there are two things in play.

 * If applicability of a piece of advice depends on the workflow
   employed, and a user who works on multiple projects that use
   different workflows, set of advice messages may want to be
   squelched per project, hence "--global" may not be appropriate.

 * "I, a physical single person, understand this piece of advice" is
   inherently per user, so squelching a piece of advice that the
   physical single person understands globally may make sense very
   well.

In hindsight, the latter argument should have been given more
weight, but I think the primary thinking back when we designed the
customizable advice messages was instead the former.

