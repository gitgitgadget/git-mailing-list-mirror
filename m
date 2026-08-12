Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F538E8B1
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513166; cv=none; b=ln7owDeb1yr4Zr7ziYBtFzlYfg7dwqfCQxZIinI/sFFXR4UJABFhfelTrusPGm+3RTrxPlpM2CCeiyFeuOfkbZpIVPfFR4UzTmKfsBLTeJAizSAc3QjmPdu/yfudtalmkdBSXYgBGO/f9jdn/pqQOJueuA85XngS2FkGGaxr5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513166; c=relaxed/simple;
	bh=7a2iqUBXQQyiR6woOKMElpIjiZwTd+ouZOkZyIZZGD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2YnwBpTkgvn6eNgGPIpn63C4EzuqZUIY7qVv8/9xmlX3kJYsf7JL99FBoK2a1h/2fMa1YChehHhU2sHcKdur6kCGPU62LjXrMoEFxNFYVAQlKVRPzUWj4wRjzhMyMVApkuqQ5tEAPiVtpDIDrnZPIAJKrvzQMY5/+p6pGEZ4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NAO++zDD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jp6EqCye; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NAO++zDD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jp6EqCye"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 01E07EC01C6;
	Wed, 12 Aug 2026 01:39:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 01:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786513163; x=1786599563; bh=YZnbN/eCDC
	MZyy3CdIkwmY5YOCtTAeGfuFzQzwQoQLA=; b=NAO++zDDJLmEWyWDv+2yxPUMFh
	D+F2wVlY/LU6fUqvmAK0lT7snVBXGik1lIXTQkmisv5VX/BFZmEzgL00z0ZgFS5u
	zV8ayNGjJ2xEKHelX3CePT24+g5OdzQ8zforAF3F0bZyoRVwT5Car2oyZj3Y1d5M
	AvshPPhX2hGELwVG8Z9T+WtCWIj1Y37MqyVfImO5zz4LKMGuAReIP49HPgRRX/D1
	bRBmcjmEGpQQYxUHZ/5f4apie3uwSrYNsop/sI8MNjHXFrqdnzKDaUjDYjUTAIEP
	7ahSOBLSfJK8RfG/Zz6dYiywn1w/QPKkNEMmsQoMwGGab3Py55As0GrggkxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786513163; x=1786599563; bh=YZnbN/eCDCMZyy3CdIkwmY5YOCtTAeGfuFz
	QzwQoQLA=; b=Jp6EqCyeh44P/JiLKCBvERxvkrzc9iWFaHICAe+/QWJyJeXoSDz
	ysyn+xwiQwW3UfpMM+AyULVx9CyJuU8Ti5B7SjTVO7hrmedro1kNkMuY+dKnjiSN
	XGbvPVxLAKKobobuTTkvm3k7bqn3m2qqyC9+1QQFDHfM/jQXjfSqqZqeH5GPucTA
	r0M+lZGdF7tuQ7j5/BvRUNLXAU7kVpaMNzq503Gvv3sh5iU+R3gep54Vvmth6UnO
	ELyfPv9evsP0wdFd4dLMqdQ2RXEwmlgbMm8eBf94qCPoYlO4dVRY2aUwnm/FZJy/
	hviM9JkbjPXK7zisiMQlbK9tPFiHq6AxqwA==
X-ME-Sender: <xms:Cwd8akjAGx4ahY42MyTZpwTKYPXZxWTwY6LVUBxU9kYxgDwqS9gkOA>
    <xme:Cwd8ajAuhUtq7GaokRRkpyTNQlTQdutoKTg8QfIypGzV_d2FNNv3yzsmyFfma_Db3
    KVz9bN416VI7ivhxntohjkyG6qfWEOuHU18oZ65x7jyzlfwA69yEg>
X-ME-Received: <xmr:Cwd8apvAvDdp_0qe7bpPIhdInK9BfFmLDcDFVPwl3H4HHmrXsa9kI1r-mk7whhPDuoSgDeasYmhzULznxNFhcP1BSZ-MxwxQDDZPgi7R3g>
X-ME-Proxy-Cause: dmFkZTGr9ssf0/cMkN7fp9OZbDCNscLG3zZlA/yjmd+tbvzYvdMaKES5AdHFCYV4Ek7uYV
    9yDz+hADhEkZTT1WG8fBE3NgN+MScdedDTuF7WgTwHCFQ8+sB4kSGQSZSsxCIa1zipJne9
    /pPHNHBBKe/JI+o0/L3sqO77LwdN3Bdq/kl4HC8SasJ5RpaLc2AiBomdasGIuTPcFJo8oS
    eE7Y/1pkhfOLrxfdzAwiQziU1sY3JuRhv+pD2z3qNEy2M9dFISatkjuSvezbW/yG2u1iVp
    Egorg2Ca7lxPUfMrowWzWJzum06DVT1b9QPvYwwDdfFkp4LCXMY3ii2A8IKYhq7wUQNMsI
    n/qje5JyDy9w3UKHa4vESDM+P9dM+kaW4QR61Hd6iQArej4k91RpE7ErCC1Qk9aWTdw10S
    UD2GQhaCiNsVUBydOuBbFcANj6wP2xkwqFmsLjNm2ZobczwQLOZJKWQgJigTj0gwEOrcOe
    tthrR7WS626mBpxJfhuEmePaOd3jCg28SX3cGz6IKh3OnF9BGkZQCm4g/n7CPUdan1PQd6
    O6lwqlsyPgWifGTgH6gMDHXN3jcI+poYAly6Sh6kBnqWj5qKSSEOD6Ex0PQYdeEA66EtC4
    oVwH6sywDrt5fppCrmXUeHnI/aYbZSCUfqyt6mAaoJxpJTonILmVL3G323DQ
X-ME-Proxy: <xmx:Cwd8agaNJ3H6yLxQ36-fI0YSbq8tWOq2_jS8xCvhfBWSvbMQTsj9vw>
    <xmx:Cwd8akXt2NXdFgEvp_octtoELJ-F_IfeCWhuoGtpFW5bFfOjau5itg>
    <xmx:Cwd8as7vvCF-ErZG0JaQatqnmUHsjDkZILvnNxQNuMr7q8eOkI244w>
    <xmx:Cwd8anjhYa69oI_CMbYYnhgvl4ZPVraWWFimRl44MUmNBK2MRayCZw>
    <xmx:Cwd8asR_R7tFdkz9p2Wv65j0cpy7zkBcW5znBO2sDJhtHYGm3sH8zCn5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 01:39:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a167e75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 05:39:22 +0000 (UTC)
Date: Wed, 12 Aug 2026 07:39:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] odb: eagerly initialize alternates
Message-ID: <anwHB3rWh7YLK7ky@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-2-f0fa4a4004e1@pks.im>
 <anucxvBIF-5Wmd33@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anucxvBIF-5Wmd33@denethor>

On Tue, Aug 11, 2026 at 05:15:33PM -0500, Justin Tobler wrote:
> On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> > When creating the object database we initialize the main object database
> > source, but we don't yet initialize its alternates. Instead, we have
> > many calls to `odb_prepare_alternates()` cluttered around the code base
> > whenever we are about to iterate through the sources.
> > 
> > This lazy loading doesn't really add much value: the moment where read
> 
> Should this say "where we read" instead?

Yes, indeed.

Patrick
