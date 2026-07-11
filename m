Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8931D7E41
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803508; cv=none; b=CHKLA1eRjAKXdJj/PDHmlkVV6NqnfopNxpwvHTbZ/JJfvZaFHCQ5/dDX6qLMmJGdrHt8OgcX2SHdjl4L2S4Df2SSJNcHgFKILX66qgindX7Bt3ClV5wX7xyux/movHoDFW0qwjTHlFw2wyrhCjiJVAedl/IIsx2s4r9YnUKCs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803508; c=relaxed/simple;
	bh=4lyizhs9F5nVghIEVupo9rj/m5j80WmYjv4iCuBWv6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mcspoOriAHAzzxYO0CxWG09eoNPuDQ+ymeFFuB+t5pTQ1sdiqqOspYN+02uhUUWLnT43uPQL+ifgi1Ax1PZC/tUTeTQ5CJ1oxrKSm2aE/QK1Cis3iQRimgwBREPuqwXtzBZZZ/8ZX5tW5Xay01rlFv4k8dn7H9vUXdzxk7qYrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cQlptfJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KEOtrkr8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cQlptfJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KEOtrkr8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F0FE7EC00AE;
	Sat, 11 Jul 2026 16:58:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 11 Jul 2026 16:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783803505; x=1783889905; bh=u68gFoUXKe
	o7VzIE5v02gZN7aKJx5KzYrjlnWiNIWUs=; b=cQlptfJINXuFnzN0TQNXMNP4NI
	qSGuMJQkUHWfcJgon2s9NZlq6baGvoVcOreqmRlsqSuZh15en/PY6Qd0PLXRpmEZ
	eKhb9ocTc2c/KBpx65WXVcqGwBvAx9YK4a7qJKCqk4DcYyVpGQUpoxZ6N2QLgr9R
	Ix+sfSqENn6IMxUcHsEeg8vw/Ke9yHF0PZ5usvG2mh+Ee31OgjXP9iaebnWDZfME
	vjtzbYHH2Yu1qxG8FgU1HFtlMvzh3+m5HQnCr8clqlOhC1qjf6aRy5KaAKhXQFrC
	P+jXGHXZkZNkJH7A2ueb7vOL8k+jczKVU1VYYMN1wLaHGsZwy29g0HF0N1bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783803505; x=1783889905; bh=u68gFoUXKeo7VzIE5v02gZN7aKJx5KzYrjl
	nWiNIWUs=; b=KEOtrkr8tImCMnlUKPPbYkqY1p82wvFzgL1Doxa0G7ePXHiyO49
	n66SkkOy8xk2yCgJP35s2K/yIoCgj6JOdRO8G4PAu7psJB5bFWqs2yTzpVLjFxcF
	DSGdOQdSR9gyXmHmYQIRY/fFGaviqLbdQYlIndhaOdFfQMgi4GYFur174BNZsi5D
	1f2vFeTVddJxU5HXTcWHeNi0JFVrRFrKnPbwDzIaJ11ny84jygMcDiyAfKqF1LvN
	ZUHUmyCjORvdDiiYVF9RcWb2W3/WyLMi2b2YSJxpiBuVLFW8G8Lx0VhX/Wc/c5oy
	15RxsolNDUjo7130715NBO6uopRBRmiALBA==
X-ME-Sender: <xms:ca5SahXG9R2cLAbeUE0YsVGupBo7wYLH4Rx_P8jVpZzmbR2Nzn5p6w>
    <xme:ca5SagowYfFyLxbxK-AAaQI1eIK880LzHYumsAcqNa2pc3wrXwWYOpdLgBD39ZGVL
    iQAjHwXdBsWYKB7A3gENU0fSJDA9I7fCk9Gdv5r8lmIjc1sB1vv>
X-ME-Received: <xmr:ca5SajkuT6DCv5Iypm1z2WlNRgC4n8-bUaFme-EnooybgpAF5OjLZRHgPAeWhmA4YsHJJ5bIF6tcnFpTnezZzxgjYc6u-m_YC_p5jmw>
X-ME-Proxy-Cause: dmFkZTGTpFjh+OUQ0Q9jhRSO0aE444B7fGZKgf/iXGpCyEUnP82SloizGWoImM5aCsl6jt
    slrCX6iq68uwUAC0i+wbaS18mkyFfVGwAWLN7kwqwJC0rnFmxM1zRKmKhllKynPAVxI6FI
    3l5g+7FO5rT30bCbSQY6lASpcZFJgrWfMlKX8FRh0g+dPSTswTVSE8sxbcxXGIvivad2lo
    z8GZu2l79WMe5/dlk9bNhCHA7cXJENrDVM+ipAZRDLxsyIb+E1offKwq665K8bUr9DZ5y/
    8cdikpU1UUxtjI2NXhqKpQC/vqUpOw+DohSKxEGulMD/Nj+ocBfIyKnoUZpkRldBEBcRZ1
    AND7LhrwcANd0lwXjV3fG+l+w6/olKKXVGpMGEsAzlkJeSKfP6JRffYjnKx5gTOIiS5l6v
    Et/nECOpgKqYDRptusoSCDIJZDiT9LBri/nsiDQ7hJHSGHHdbyYfoO6LQOAmp1wXO0s851
    M4OAtfkewQSgwtAXBx9TrIxyagiKl0+EPtJHd5k21xAxgdz6YdjP0ZfcdOexR4EGeDL6f9
    M8PU/QbrqmHZZwtOvkTSHJg4gSLKcf3ucXS4t8CKstLcWQOZjij1tbFUz+LUAABKz+7i/5
    3UQzHpnA9cslz4mUmDvsjWWTk3GyNtJqKQUqkMNrXhWhAeLmherCNIYOM0JQ
X-ME-Proxy: <xmx:ca5Sag0Cs-Tq9shpopt7js4f0hVejD5EXKUqmRX3cjP_B4_Ak4YcRg>
    <xmx:ca5SagQcSobPehqE_40cqi5BCyNU075uoaf-n1wUCBMq3l3qm7hpOQ>
    <xmx:ca5SapyDIe8VMezcfTCFrGCBT62fvmkL0FLS5I9wKGk8zek2cqiGHA>
    <xmx:ca5SagCCFgxyDNpv-MSZW4qU9796BUEd-LRV4TVQqbK9YpNQaFDzFQ>
    <xmx:ca5Sap8gcIWI6Pcs56S7-aUhlGoiSSQvVv0auIy6MlqYwayiAIuEF4dU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 16:58:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Kristofer Karlsson <krka@spotify.com>,  =?utf-8?Q?Re?=
 =?utf-8?Q?n=C3=A9?= Scharfe
 <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/10] commit-reach: terminate merge-base walk when
 one side is exhausted
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sat, 11 Jul 2026 13:27:35
	+0000")
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:58:24 -0700
Message-ID: <xmqqv7al9rbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v5:
>
>  * Rebased on next, which now contains kk/commit-reach-find-all-fix. The
>    gen_ordered guard from that topic is carried through patches 7-9 via
>    state.gen_ordered, then removed in patch 10 along with the date-ordering
>    fallback.

As always, do *not* base your patches on 'next'.  I cannot apply
such a patch series to my tree, as merging the resulting topic down
to 'master' will pull _all_ the other topics, including those that
are not ready, plus commits that merge these topics into 'next',
into 'master'.

Instead, choose the topics that you do depend on, prepare a merge of
these branches into a stable base (like v2.55.0 or master), and then
build your series on top.

Thanks.
