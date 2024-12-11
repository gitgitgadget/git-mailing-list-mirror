Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B119F471
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933472; cv=none; b=nXLkF+SVcKjOb2zziKmSy+Mr4Q+1jigZc2mJbyZ317ErBdOPVRKYnoOj1bhojpJLEQmHKwgvpvm1NHWzoqywo8/tmbSUGZauVbz6V5UvIL++UDJlOKXJwAmHShdBjf5iwq+jJrLFOfsY34ihV5sFUJkmVCKh6ApFPrbp3ncPE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933472; c=relaxed/simple;
	bh=gcZsNUIQou8HTXPPAbVkRjjpxQMlGl0JSecUyu4mVXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPU00JZ8w6lm8qmUdNSMSnBSVcrS3DJ5W4UXrvhjADZAQdgTLhBfmzQg1XrfbcmjeTjoQa6u6fWyPOHuLr/bfEaER2AFJu7TG7t1tSZ0+Qn6V+X7KpGOuMKfDEl1G1CRvlabwxDzxFHHECIYEtBXmvIxM+KgXi1K3DNKGdr042I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ukm+eZIi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDgHxLjA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ukm+eZIi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDgHxLjA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74A161140126;
	Wed, 11 Dec 2024 11:11:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 11 Dec 2024 11:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733933468; x=1734019868; bh=+LegoQ84bp
	V9I7dkDRkjSYRJnHy0hUhSzRHrXyEhs7I=; b=ukm+eZIiBtREuGMGaixuCSlVFX
	OYoybeXF9kO2Cbo1JOgkOP3HWF4wg2PCPU0trYNw+NSx99vqnRO42bF5SnMxoHHD
	ZodyyBJWkUaYuymI+PK3ypZ07CDJ/icGk03WL8aR58uRp9EVxrL0fwpheV3bk4tx
	PI3wog9azevqlOpRTDYUyCxuhdw/NQIlnfS3wlVdiMtIUAtT3m7d7G5ql1Bnkens
	Xltw38Ss87SrQ4pZYwMondxHqvgUdNuzaRK4+yKmKF/KsC1AXHMfjutka9iA4wiP
	QHFvCf0v8soSgnCORIWAvaehT3zd5veCFOKScRO4MLuilszH2jVLq5j3R7Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733933468; x=1734019868; bh=+LegoQ84bpV9I7dkDRkjSYRJnHy0hUhSzRH
	rXyEhs7I=; b=GDgHxLjA8czCVQpSoUFW1KYty4RTaQh0NYIarTViUxPbsku3crr
	nKfrHJFjPSlIlyINppbzv/jmCNt7HN7H+z27gTTFNDjsn+81CkX7SkwHPeuV/h1Y
	yYvh9jDA28rarS+f7S7DBndbd1Q4XFSZEtCDVa9/XGALA4dnXN0vdW8OY9fBGILJ
	7cNTGNvMQUS5BIXmi5xOZa/JuC/eCAc7TgXvojNe9h4DD8RbZ4PSXDkvfJKx9j1M
	mFqXFlqpTgEM1feMZRlIyLdNddXL92ZLOFa7dI/SJUMGvze6W8Azg9WeKxEA2VTZ
	Vum5qJphQfXf1BCG6dckpTkYQHhpp/Vs65A==
X-ME-Sender: <xms:nLlZZ4_jeoAIkbXdfaUJFxlX3DICARl9x5faD9SEMGMVQ8CKBMPFtw>
    <xme:nLlZZwt6jy5aNhumn9v-WgySCDiOHgePp04Q8P4kJnqjUdrUjO1S11rraM4oiodOV
    NynI0PNo6hnL594rg>
X-ME-Received: <xmr:nLlZZ-AwQb6V1SYFo_LcWqKzeyKeZovCObKSm8UdtG-cq37qtgejmJT1bqRIszSLtcH7x_kk9b7ISGwobG-spxm3m1sxpcTb0IW6AqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nLlZZ4d7DictWvdNYm2cGR6x5hgwVTwf5-eSR02VeVqOSyai5BD1VQ>
    <xmx:nLlZZ9Om3dKtm-fdMqm_dBmkRLboQUpf6-hXDz22wlvfRCNzb_sBKg>
    <xmx:nLlZZyk2rDET8Te2uKn2Kj1f_zNTP-Xnk-F8Y8fVEex3QIG8CJQObg>
    <xmx:nLlZZ_t2Zc1sY16fbp6U9K9HJOs5aGvb6KHySmi43i3SK_H6zuywvA>
    <xmx:nLlZZ-rXa43eUQ_sN8z3DthqC5gi3C_LkA8GbK4KcCnMU4CHqIe65AMZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 11:11:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>
Subject: Re: branch description as a note?
In-Reply-To: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com> (Bence Ferdinandy's
	message of "Wed, 11 Dec 2024 11:39:28 +0100")
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
Date: Thu, 12 Dec 2024 01:11:06 +0900
Message-ID: <xmqq4j3ai4it.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> so I've been wondering about branch descriptions being just a local
> configuration. The only use-case I know for them is generating cover letters
> and request-pull, although I could imagine maybe the maintainer uses branch
> descriptions for storing the - well - branch descriptions for the "What's
> cooking" emails and the merge commit messages. 

FWIW, that is not how I maintain "What's cooking".  Rather, the next
issue os "What's cooking" is pretty much edited manually, plus a
tool that notices when an existing topic advances in order to insert
these "(merged to 'next' on such and such day)" lines and turn '-'
bullets into '+', and move topics from other sections to 'graduated'
section.  Especially when writing comments on a topic, being able to
read about other topics (which may be related) and the list of titles
helps a lot.

There may be folks who find branch descriptions a useful way to keep
a quick reminder about the branch.  I was also hoping it may be like
so, but I seem to have failed to exploit it as a useful component in
my workflow.

> Now my problem with the description being a local configuration, is that
> I often work on patches on two different computers. I can easily share my patch
> notes with myself, but not the branch description. If these could be pushed and
> fetched like a note, I think that would open up some other nice possibilities
> as well, like having a standard place for MR/PR messages for forges, sharing
> proposed merge commit messages, maybe other things.

If this is about draft work, I would use an empty commit at the tip
of the branch.

> For my personal issue of sharing branch descriptions with myself, I could
> probably just make up a convention for myself, say using refs/notes/branches,
> but it would be nice to have this built in, instead of the local config branch
> description.
>
> From usage perspective I could imagine a new `--branch` flag for notes, which
> would tell `git notes` to operate on notes attached to branches instead of
> specific commits, probably stored under refs/notes/branches by default. Maybe
> add an `--edit-branch-note` to `git branch`. And of course have the option to
> use this note instead of the description configuration wherever it makes sense.
>
> What do you think?

The notes tree is a hashmap that uses object names as the key.  The
point of a branch is that it can grow by accumulating new commits on
it, or its commits rewritten with "rebase -i", and there are branches
with more than one commit.  So to what commit on the branch would you
hang such a note on?
