Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7F3FCC
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512749; cv=none; b=AWIBq0gaM0LM6B3NakiqD3Pk6kIeZeTHcXpCdCzGjtH5Z8xw0H0mFwE8Dv5X+gtmdgKwjmFRA49dTjLwJDUVefZhMDZtRnh6Xew5/XwrTmqu/cwZgoPMBAxM9o+rd338FLH+7e9D0k/1LdM+bW0dMGp0vf+r0BbxrSP4KJceLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512749; c=relaxed/simple;
	bh=0R1ATVTAtHDLCiu8qG2KMnqsInJ7B6rMm+2Kfc7dzto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2pJZ/vrs+891qtshGyPpgv9Pb4PzUcFkuqifT3l9Gw5f0l7Eep13nmL68jovgg4DRq9PKXSzoCC9nNfC5t4t6BK8aoSHFjWD7YhVYtLSHUG7L4et92HptxEDg9s4wgEK84DJ9/5K1rYOnhoRWmjt36f+RirebhffT3oKlSP7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SKgUd+ss; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5oTfAJ+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SKgUd+ss";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5oTfAJ+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47D8F140009E;
	Fri, 31 Jul 2026 11:45:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jul 2026 11:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785512747;
	 x=1785599147; bh=Nzr2KKHxRvVsD+/N8ho0aZ3GZgWNgRJp/NOzP4MO0Vw=; b=
	SKgUd+ssaWiYjxaa+cJ3IBbCHzl8IfOvDAPEahyNheWoxgtW7BmG0qjr+1GWdjGD
	Cmi9kAvmHo7zO9rzZqG33NEwc4Qhmw/aESxL9qHZSH6+GFMsE9w1BDkqiaKPPR2h
	2yxEpduoqB9IZOzl/zSDwTMRiB38avSFRz1tdHRSPaFhlhX+aLw9DhNF4q3HGI79
	uUwOxcjsmrJc9pF+nrQhCu/NDKBOqybg0JD+bgeuCQy8H1dN0R0COgTf6UHexKOE
	mhZKAPmmMvbCY2+DfiMAc3+nFZpwvKniSv2FP6gjHiUhzEStNDW+B6LQh+Pgbr9D
	rsAzkEwhqJPpnANCHB1Efw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785512747; x=
	1785599147; bh=Nzr2KKHxRvVsD+/N8ho0aZ3GZgWNgRJp/NOzP4MO0Vw=; b=f
	5oTfAJ+bbP/T/ri69For4FnuYl5/nPr6PmHn3hAP9NmAbIj1i5/5ixpg8bX68Y0K
	a7AlhD2hOcviJ1zTJDobo1/+CuAsy3jUNTln1ApWQeRd3X19gMWdSEQG/saqlhPu
	wUu8gWK2XmFASVsHUv+LnfVhEasDyOpsh7IO3cBgZMm+K0XQduOTUqTuaBi7ht/k
	SuYedb9M/mwxQ6BxaSCbUyEiZSTJqIAq23OiRd9QpSEUzpznAdXr6lIR1I22+DPw
	EvGza0a2GqQXsRtOmUlaYnZQqztYnQyfKB4S00Zro147XET0WxOvIZiPiTtuQHoA
	Tjuc8W4TOeE3Ylgg9aEqA==
X-ME-Sender: <xms:KsNsasf_s-2Ye_b_qZCF-Vm7JDNXb_OSR15rk09bGQPSHLBkO9p9ig>
    <xme:KsNsah7zVUJDyif-jC_WJZ9Q5LiNf885HJLS819auGCEZFiXcph6Cuw0casrzNt8f
    DIN_Qq2WVxTCXSzYkGzwZvAX6NWPKnu3LgHj8R_N33nTQoybqtrXJk>
X-ME-Received: <xmr:KsNsanXScOOOp2fkK-Xz0ZNKS4F0jGTd8k1HeUZ-d2Z6IxnIhRu8ozPFbN061muBNKCNc0fIBeE0tISxrFmwg_IqXWaD-fud0w>
X-ME-Proxy-Cause: dmFkZTE+7QRArqlu+8bdYl4wH7dlMzRnnAMV82BRi7Sh+ywozYlVkJzgDM0Wz+0Iyfb3ww
    9MbXYc0cw2eSttXeb8EA077EyIG56x2Dp+bPOBYQ2wRQS1p2hnECeVP8wug21vQRyrC0+N
    LO5uHOkyC7WWMGoFQMwLuN36Eo1gMFNgwprGmRyRKIMzJjHs8gX42CPxr6ykGydtsoQgTQ
    AYz8fzuI/l1wgoesultyYGqNtqcAfTt1eJ67MLUkKssU6+aR7f60BP4El7FAPmcQfFKXeS
    oWZfJipLoDt/PSzKUrspRhBOEqb/RKQ/mB89sPuSYVB2zOaOt+oF4KqIQkBcEKZ2UEmnWH
    U+dsusl1H6GIwTMhEUvGoaf51/j6wmtgBRVX2rT3CzwgZy+M94+eH/KMFrARIfN0VrvUHJ
    JcL2I7O9yJSGAlXRq3/p6+eVFIc6fEJrYZXCMAPjKtghoK/MAjHOsL/OMKwUOIUL3JFMG6
    4/2vzKiiYZG9IXaRyOJRbK6DzKeVgh0+vY+W4ByJ/WqMwapmk2NvAgr1x5pe5qTJhmJ3ww
    WMRXa6dqUEdNQmsNCzGFVfjPK3zRLdwtFdH2MluPjlpPlrt9cgVMSmIVvj5HWGDwv0l4BS
    6uYPOxefJTq37ZLMYz0AokAXK4VYEOaNzzavt/A25/I2F5es6JveuKjtmDrQ
X-ME-Proxy: <xmx:KsNsao4p6JG2hQdYUeIR3wvEyjJWR8tSmGqoQBG6D6pUhYnbE_nPtA>
    <xmx:KsNsaqoUjY6mlHDBarrSnnMdVbF7zRWnnl7LuVDD_Cs5FtVqeure3A>
    <xmx:KsNsajmninptfXeX2H0QCTsWDH_4Z8G-zoZ8-I0iX7mOiZAqq8A3QA>
    <xmx:KsNsauPf2mNLt0p2U35lgQkAt8SCEPlvpYGtx9XUh3_oI9yOHCbaSA>
    <xmx:K8NsatihRd2q7QbMMOMk11SaxlhA8Ftqvkxco9IwJFlSnY7cAfA_La56>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 11:45:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  Siddharth Asthana <siddharthasthana31@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/4] doc: replay: fix config link
In-Reply-To: <87h5lfd0oc.fsf@emacs.iotcl.com> (Toon Claes's message of "Fri,
	31 Jul 2026 10:26:59 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
	<V4_CV_doc_replay_config.af3@msgid.xyz> <xmqq4ihglab5.fsf@gitster.g>
	<6bcc7490-6dc8-42a7-b3ea-99bf948d7997@app.fastmail.com>
	<87h5lfd0oc.fsf@emacs.iotcl.com>
Date: Fri, 31 Jul 2026 08:45:45 -0700
Message-ID: <xmqq4ihfduxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toon Claes <toon@iotcl.com> writes:

> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Thu, Jul 30, 2026, at 18:19, Junio C Hamano wrote:
>>> That's truly minimal update.  It is a bit surprising that the topic
>>> was stuck for a long time, nearing its expiration date.
>>>
>>> A quick look at the thread
>>> https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/
>>> tells me that there weren't any outstanding review comments.
>>>
>>> That unfortunately does not say if this version is good enough or
>>> people got tired of reviewing and did not pick all lints in v3, but
>>> we need to work with what we have, so let's see how smoothly this
>>> round goes.
>>
>> Yeah, there just hasn’t been much interest in this topic. But thanks
>> again to Toon for taking a fresh look.
>>
>>>
>>> Will replace.  Thanks.
>>>[snip]
>
> I'm happy with this version too. And for the record, I've locally
> rendered this as it would on git-scm.com, and all look good.

Thanks.  Let's mark it for 'next' then.

