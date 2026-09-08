Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97234A0157
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891144; cv=none; b=KDQxPWdWYqvze+OVcZkDrSUibbysIFcz3kUa9WufbX7ikpARp44wwniAz8suVM4PGiRwd3fghw6jL+x/gv32qK9Yn4x1iD5934CtYH7LIMHTErXFs1Rh7VK4cDfoUfFu5LPzrzjj4ek5eHkMjBK+BKvDwGx07kJhuLb/zDVfGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891144; c=relaxed/simple;
	bh=G5gWw2r4XaWNEcvX81mWrfCT1JrI0OFAwEsSItLEdG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBhVbFlHcPSj+M/IT/lrSx/oCPDzNDIgTB8IsSfg8+9qyNs80QmuX6GsRCJx7CApfrjhVMqNv+cJqq73kY20E26ZlQNQ94XPwGrT0YUWV4AF0+Zej/l+Zbp3WZ3XmHM8HcciRCLoqOp+Paipm4eBS2I5nOdUAK+xi4T0iPcQ4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TjIokyot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbmUSPMS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TjIokyot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbmUSPMS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8414DEC011C;
	Tue,  8 Sep 2026 14:12:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 08 Sep 2026 14:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788891141; x=1788977541; bh=uLeBBTVgnL
	O8aY8xNS/Qnuuej4LjrSuBuYVmUONqEh0=; b=TjIokyotVKJxtLLvbCLfH0NeoO
	xdVmVAaCSkMRvKMs4NOQgmFYjSeAMZodfJi9zbfo/jJGZHPFxcTtfRoJSUoFoETM
	tYz7bDnHbJ1e5sWAZxnUrqRDf9OyEY1u/kQgQqCMYwz9K0yA6Wh2aGdplPRcQTo2
	fzdDuy++K2OEIq6MG5zYMb5v8TE3c5KioyYOb03rVgEOaob6n49AbK5SsUuP/BWD
	BIBShW6dQQ2TYpdyxFd2nTdYanT7I0VKiTMOsl2ZOCFp3cmH4zRBCimmWJcQMNfZ
	4oK4q7I0VB8faKHj9L8DdPWRs5AHZDBW9WpMdxY2q/TaFGi1InuYSY5Z+9Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788891141; x=1788977541; bh=uLeBBTVgnLO8aY8xNS/Qnuuej4LjrSuBuYV
	mUONqEh0=; b=BbmUSPMS+lSaMR1h8mY6vaKv5aDnIU+yDjw2LQuWTf4EznwF5hC
	lxJ1i0g5oc6gM8PIKM9C5+YzWg9hL9hcpy/ENeU0iGDjJF/OH0hp4vHtg8pr2BPt
	+ZXyb3Z+CN5ax2ZhtLv5p82mwgfiWJOpgwPusSZd9zaXo+N2VC89XBMmcHyHqHo4
	2S0IRQLN2MZkq/BIbuhX1To4k/MGyiqjrhDmoOqRTpb9Jz1XvOckCdlKTgJ2XK3A
	eJ0ZBJb3AbZE4hIIWqIPZMP6TsNqQuRL3KzqsOTRzhONKXktnsbx5/5vouSZ5lND
	JlN/9ydoSSSIHlV4ejQbOTVoCRBdVUXntYQ==
X-ME-Sender: <xms:BVCgatBhEL_cWTnTeDZw3upy8w6DnY_xsRVpCrpqe75c2YjZPbkxFA>
    <xme:BVCgaqmAAyx0i42SOCw2X0SNIufm6B4bjRXiktXDTlO3UahrQAzT85naaE9wQSGEl
    lHTsDSVti6yk_EJw9jMkFBHxUJ5oX-wyvok4UpML1QLqZiowUX99No>
X-ME-Received: <xmr:BVCgauxbbqDu65-q5h1T2aEarBGqGJQSVhsVpAkYtmT_fIH6QzyoiUe4_Iu1VHyv8QvkxeMOK4noTwYpCY3ZosMoRzZE-mHFtqiq>
X-ME-Proxy-Cause: dmFkZTGhWO6TP7KoYORew/wXoxQbM/US06bWX45wWulkFYeF3yKroeo80G1lHMZQHWzhQw
    0XcdeCvJ8xzKdufdvuuUObPHZYK95vafy2IDzEZZL8ff4NlELV4A4+ALyV1im6jMBNuMrs
    UPQNkVgWzu6sA8C5s6k9VaGMHU5LJ2uBPh/Osnsu0JR+hZ+amy8EkpgT4zRdPjt+L2HHcF
    U3Ttc8PpSSZTiZCFnm8fAmKxt2y2k3yQWLwuSnHLmApFByu2B9Fs8RJQPQA1Uvk5IUnnOg
    2nPpsj5T9V35wK+IpJ2YByZ7vDikqT+bEFu87iYV0beI/I/nUZ64cEHPYWyZ2HVB5mqVI7
    nJ4xE+g49Uw3kIOYr8vMW5bsUtLLIGVcsPU8KcfTWYYvfNlGgo5TH3I4qEuvdM8efyWkOU
    7u7R6i4KfppvkIaR9AEGOmIDaS8mvVJhhHOkjhBywoHw6WHxn7KMvtKND24+yqMw/aspvK
    1aR5uy3djy1o2WAxBZJ9G6abEP8ciFNwtE5ITrzm0AkcHJ73el41r882C/+YbUUwhVzRYC
    H8CdkkXL0PObDkL7kNMuRu2bzKWDdpBmkNSMJzEBugveXBa+4vGYKUKR+Ylz0ySHBu3z7M
    px3CdfQzxtwSCRapP+OzhinaRytEqwOnnLt71beWIo2oN1q9poSKrUg7aDGQ
X-ME-Proxy: <xmx:BVCgakRJDFD8j9fz9XN9HszE9KRn-l6acVd6yMoUaxY0ycGWiscZfg>
    <xmx:BVCgam_Y_MloXJOFfoQE7q6xqwbyhvkPjjueOxLPJ8OWtSCmYh0gOQ>
    <xmx:BVCgaivfJ9QwwoZykdQsYcFHinMek-LAJ8aknZlekaWlZr86w_Wz0Q>
    <xmx:BVCgauP34a960TXGoJBpm6jFWnpCzOrsUqDxhcvH3AOFUsgtarcxzA>
    <xmx:BVCgahG-ifeXRDWbDDKvbd6Bs1lVnZiuWNBs2hqRQkucEjvCyjRB0xzf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 14:12:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 4/5] promisor-remote: prevent infinite recursion when
 lazy fetching
In-Reply-To: <20260908164129.560396-5-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 8 Sep 2026 18:41:28 +0200")
References: <20260813154748.2378747-1-christian.couder@gmail.com>
	<20260908164129.560396-1-christian.couder@gmail.com>
	<20260908164129.560396-5-christian.couder@gmail.com>
Date: Tue, 08 Sep 2026 11:12:19 -0700
Message-ID: <xmqqqzj3wr24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It does not recurse forever in practice, but only because each level
> adds one more variable to the environment of the child process, so
> after a while `exec()` fails with:
>
>     fatal: cannot exec 'git-upload-pack ...': Argument list too long
>     fatal: unable to fork
>
> To avoid this pathological case altogether, let's use a new
> `GIT_INTERNAL_LAZY_FETCH_DEPTH` to count the recursion depth, and let's
> check that it doesn't exceed a MAX_LAZY_FETCH_DEPTH limit (set to 5 for
> now).

Good.

Does it have to be "unsigned long", though?  Just like oid_nr, I'd
prefer to see a number whose range or signedness does not matter in
practice be typed as platform natural "int".  Even though one could
argue that "anything_nr cannot be negative so it must be unsigned",
or "int might be too small for some platforms" or "int or ulong have
different width on different platforms", or even "anything we count
we should count in size_t", I do not think any of them is a good
argument against it, especially when the value we start with is 5
;-).

