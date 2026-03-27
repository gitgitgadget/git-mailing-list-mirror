Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBE344DBE
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628329; cv=none; b=XtzTFKftO6PDx6VSZcFzF7rHoyHw4stMU/aPPwe5uKYvklz3r3HiRbF/4fbnVO3EO4y+vN+Ae5jPYdQj+dlsOOJEdlrr0ujtzXvqlc9U0pNrE8VXG7yPA2bs3uKiuwdmN9zoRfobcfwEzrS4HzT4na5ZbaUZvJsyxXds5z2EV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628329; c=relaxed/simple;
	bh=1C5LGoVqxiFZlcaKT7il8njoaZAgzFOwSBiN751sRBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c8buzpdVGpvcZZxQAn/CqDQY/nswx2nUxRpsvZGcYQu+/z2BUsoFecF2k6jOFX37vGkCCucigCufIZ46EUecLACG3v4OAWGUe2T+y/bjMaSBbXwpdXTDct50gzO+Z8kfNJ4yoFAx/PkuWOM/fybG88p7uk7GJ2nx6Dm2tPIKTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cArtaH7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rl4cDNEH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cArtaH7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rl4cDNEH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EB3301D00190;
	Fri, 27 Mar 2026 12:18:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Mar 2026 12:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774628327; x=1774714727; bh=DtfgODfTZ5
	I+fJqe/NCGku+P7F8xhLBLMz6AdkHt8t0=; b=cArtaH7xZf66ZuW3yZy5SZXNXg
	qZqf1GGPtFhMAypKvLYqjMljwCziL2Js2Ri7kjzG0rj6digjff7DrFy+y92EoaQX
	DrkqmCUmfIl4AxY7uVdjt6Y+yi9Vq7Rp0BmmRPZkC5jnjoQElxsqf0kOMdDfVKQs
	3Q7wN4NHdtK0O2bnrB0q6tUJFm8RDdx5ju60Ibz7dJ6FR9Z5OEiihxeno9t9NGtY
	KmjynVxTqNJxEHzvA2FnvoJPwYQNamHuHAwYKTPzUNtvOeyWZK+v2NGTHHmRYoEM
	e4TgP0QXEpkKLcLFIutoyzl7R7pEjKAMYQi7fVVJBDTMM70OlCsdDm/Yv7oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774628327; x=1774714727; bh=DtfgODfTZ5I+fJqe/NCGku+P7F8xhLBLMz6
	AdkHt8t0=; b=Rl4cDNEHQKNskqtsm6Bwtp6A8U4/L9SbhJkX/g5pvsRz9g03EKg
	2JWb+Z+N0XTeDbAzjNcH69H7Gj4VdgMPMFlc2gCr73bEye1FMwupVnvoy7B5hqto
	UfMvOwZTwN2b/0+cctLGfNDBSrbgYwI8eE5BUPl2KXUXsae0YowwTXB4nn4tAXH3
	5u4pYEHzjQTKSs1pCC0g3f7MQmWb2QVW0N5/f9xFEmKQ1KzK/PVj7gCzVCzpqfpp
	DxTPFQ2QSyutSxf/2bzj43cPAO6tRv1KZoqewk75gRmUxAPLNEEi8FyrVuhCkh4D
	s4GgXLNCOfCOFrBKLl9syMXlYfo5vs/gR8A==
X-ME-Sender: <xms:563GaY7p6niJwI_-9fj50gNzit4Z1l8QFU6vEW566FgiaZgddHpByA>
    <xme:563GaRX9lK5hc6Or0qdwibk4r5tcCJNsEcta-C1nVEs67XRlhEQewIgRtZJOykE5O
    japc2EwqcfiojtVFPGyyOj5rYMmT9UvqfryyWgvI6SIK4pFAnDfvw>
X-ME-Received: <xmr:563GaU2oquqd0JhlT754iQdURYao2hFL6VN86v9wuV0siCdbrrxktfzx3Ge5cPL8s2LSv0pqNNIcH7Y5WbOHd0fvw8WULhhNig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnsegu
    rghnughrrghkvgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:563GaW1apROJIhvdfdqzqoNJz3xS16akHo3R_Tb1azk8UbWe3W_4rQ>
    <xmx:563Gaf_pgjnfXaXjL67fQeUKXcn0hzHkObD8Kp_CU3PilwnXC-Flrg>
    <xmx:563Gab08nv7odZwP9HGyPvL2IthUjS-tJ94OLOeh6yEGMKoVpF0kwA>
    <xmx:563GaU-0AOYmwfS0_fDpOcryHenomgO1ltIcP4jVEItjdOZzn4Qp6g>
    <xmx:563GaV_NQNpr9exI2P2YpKypKMdYVDg9Ew1ZeSFJNtxouvow2jeWdyVP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:18:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dan Drake <dan@dandrake.org>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitignore documentation for info/exclude files and patterns
 with relative directories
In-Reply-To: <Qdk5yVH_yWgKl_bjCjdasusfe3PuzHCZ2rKgKIn2Xx5rcw46jmQDfA6K2vkv3V3XLSy4aqwyUlfVEmF5VlIv3EVEOlZLEnf-paw11tyhZKE=@dandrake.org>
	(Dan Drake's message of "Fri, 27 Mar 2026 11:20:42 +0000")
References: <Qdk5yVH_yWgKl_bjCjdasusfe3PuzHCZ2rKgKIn2Xx5rcw46jmQDfA6K2vkv3V3XLSy4aqwyUlfVEmF5VlIv3EVEOlZLEnf-paw11tyhZKE=@dandrake.org>
Date: Fri, 27 Mar 2026 09:18:45 -0700
Message-ID: <xmqqwlyxkzyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Drake <dan@dandrake.org> writes:

> The documentation should mention this behavior for info/exclude, as well as 
> the core.excludesFile.

Yup, my mistake more than 20-year-old that nobody complained so far
;-)

Yes, these exclude pattern sources that are outside the working tree
behave as if they are specified at the root level of the working
tree.

Patches welcome. Thanks.
