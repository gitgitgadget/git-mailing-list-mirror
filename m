Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AC2D7DD4
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311231; cv=none; b=g9enULEwsyT244BS4GU9RmCCmU5fWQRiD++5pysKm8ANc0d0UuSfaIkHVugxflZsHFBMNgs4m2IUozQ38RPGcyHFHXDmPogrATYBX0itEGSpVc1CNnwymoprDFNlfIcJq+HZ+Oc8trhEWzmcX/QuOqkQSllwmswgGOBhzZk3XcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311231; c=relaxed/simple;
	bh=fXSj0NwgdZXG5f5NtvnzBa0dKbthWoIWbmHAaKcBL5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S85bzPQb1MkXYhwfL7vfWEMtHNNUkKVsy3N9N3omUHzAT6R/XvPFvsFjyh3XSJY8Ysm7Aj16U0HYgSQpaGh68PLHsULOTl9KUuPMVYYO5YA+VwBgkgTc9dHEZkZBsU0NtXbyYmGGo95XgMhgdVM5F2UFyfVcfs9KbLlMcBGb+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A3E0lOOS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lr63Bl6D; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A3E0lOOS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lr63Bl6D"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 672CA1D000A8;
	Fri, 25 Sep 2026 00:40:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 00:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790311229; x=1790397629; bh=gffD7uPPTM
	l3NprZ2tZjpMhJ16Yf4TUXO5NehfYdnas=; b=A3E0lOOSogga5HjQyEein3wW0w
	OYEK7p8B301arj0Dit98dczTp9wQrjMqEqQzKeMwcRKepAc93wS602zRigCBInZX
	hWsfb/Yb8V5gqluEd0sLlSJz+rNFO1rjWoDSVAE2nGpjqdZmJGxijsentUXQBA8U
	fMVJwEOBhRBGWL4ArlQ0o1RTI3Bq8VZ15aRPZTU3rUKF0lVNZ1PRkNbfm9/7oPWP
	2q5zMeaSeBlnStilN8HN8wBBrzHvsCXT9YMzQ6iUQ33jc7rfmv3orBZEvpO1Zx3h
	VMJ7JGJiIAkeXnqDQ0WjzrCJr3IjrUkaK85SS/jj7ouPnVQ2uhgzhO7GkvxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790311229; x=1790397629; bh=gffD7uPPTMl3NprZ2tZjpMhJ16Yf4TUXO5N
	ehfYdnas=; b=Lr63Bl6D6at0WmIsr7kyzfBeed8jY2Y0Zdr3qAbb7hv1spFxPU7
	+AAuRnyAhja2OPNBw//ANKIt6IlwLRyZboxKcIYzDe91xAlh2p3jIxjN3DGIy/jX
	QVFy/hDdHnPosfWNV/Re6CWkydG0MLjCD6Ym3u9fo5I+ocdi6uoF9OWdErWnGlLn
	FbzcbggPpntNGVPe/FisoMvHWxaywH1TFa5XvOn7fKsHG1YhW2rFnB6xucsmW8e1
	TxIB/dbXBa6QX6qNsBrBL6W7qyrCZB11Von6qx0t6Os/rtORa15uxWSFgMDpaOly
	rDe4zexrMsNp40ZwlgzzLlPVfcEDGqsjRQg==
X-ME-Sender: <xms:Pfu1aho1jMCEieKwWaNQBZxh-0sR57mWm9XDl2Aof8ZvU7X2f3Sggw>
    <xme:Pfu1aqq4jtaHilgn91QkoyS6ICwSe9xaFtbDPsCh_RX5wJkXMdf1gcI-ieUOnpTJb
    bgozfjxMYatyAr67PBRmh6lO4Di7Om8FSsl9Ec3TBKQQNrqPAxkv_U>
X-ME-Received: <xmr:Pfu1ajNqT6vAGsUPlz8mbHbyVlPu_ZdT65pr8YO6nsjShRTZEiAN2JwWbKpfaV2NNB1EEzaqfrqEDDreA38dLfdoyOCWTtY27Rn1>
X-ME-Proxy-Cause: dmFkZTFRC13vW0FkmnaTJrsvmWibymmPWYz3J8AXLkPb7H/7KjjuaXhzncOBltCEKcqqV/
    Kd3jn1GjoaoplGYljRyAdyogieiwAq94Y9RyeeEDH8B1+aTPROJGfjurLGy6RCKLzYbnSx
    qQJ00ufavoDnjTSifzu0NkLhxlSLLDTeNSUQlyNJKGgvnam1mt2c0U1lNx+x2yJh+ZO+t2
    TedwUOd5iW5xTGOLbqtniFPmlsQamJwwgYmO8Ch9n94PTW3BMhGOzVLnqKZy92aLPHwnMl
    eIo7jmUgdyOAicsNJ4JDsZGjviq7O5CdqH5TVjaDvvFT50mj1OHgTLwqihbCQFd9EgHtX/
    YbjXeSBHm7T56QAhWyuZvgPZDwcLbwBaPt6Vs+a/HPSg9MuPCH2c3e4AvUBV/fX1/LOYrC
    vV+3cyEeBZtPrssC3QMskzUixWOkHWQNleZDFqsAWlOvhhl+mWgl0aMnepD4fX4IQcFWqn
    DR68kPG/cikXgtlYJe0kBN2jrsrDsOLYZHQbIf5Vhq8jpRs8bbJUVItQ3F6wroRFrdm68u
    cuSToQuHWbTw0ye1vFLt6e7P4gKrb0TQgPr8hWTv357ZnalOs1sKwDk2hoYgZNNZpsOBBd
    flEUC5U2TjX+iM9Di17bTDdeyshreXE6rf019brre0/VzTsPIroJPkwr4Gig
X-ME-Proxy: <xmx:Pfu1arwXXkRKzEzbPaD2nu19m4F8y7qFfiTlyA1cbhmHfxZV2gJxCA>
    <xmx:Pfu1ass49DsSxSy-UWXBZkNUVL75sZmvZDW8FFoVTOf2YMWVlajS_w>
    <xmx:Pfu1ak7evKUZbUdGuxkKiEGdjDXeUVTa1R1kHbmPlU_TSZQ87OTO3A>
    <xmx:Pfu1arTO91wqCvQSYi68X7MRhDRkAHShgiaEQvLkEbI2CZsiTMR2uw>
    <xmx:Pfu1aisudyv8rjhKaVf8SWJLvYYmJ_w7rRmyV8Nlht0JRFWbk5Fm-x72>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 00:40:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Nathan Froyd via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nathan Froyd <froydnj@gmail.com>
Subject: Re: [PATCH] builtin/fetch-pack: indicate when we have an exact oid
In-Reply-To: <xmqqtsnexflv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	24 Sep 2026 18:51:56 -0700")
References: <pull.2420.git.git.1790257834680.gitgitgadget@gmail.com>
	<xmqqtsnexflv.fsf@gitster.g>
Date: Thu, 24 Sep 2026 21:40:25 -0700
Message-ID: <xmqqbj9mx7t2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Unlike "git fetch" that is a higher level wrapper, in "git fetch-pack",
> a heuristic dwim like this is unwelcome.  In 
>
>     $ git fetch-pack <repository> <ref>...
>
> these <ref> arguments are meant to be passed exactly as given.

Need a bit of clarification.  I should have said

    ... passed to the other side on "want-ref" packet as given on
    the command line.
