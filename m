Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F33CF97A
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620712; cv=none; b=C4EzuWMlTSFrXQy+LhPpGuqUmQcRyC8pUHTWy0LbJF9jquiuog1fNzFRnkPXCtD+lCr5rwYIlXKR6dBmiOnWA/KfRJKDuv4xWb7v7PDJIefBc5e4Y9UuXu7VeJHUYXYIN2AWFw2cD6i0oWu86Czk9mPkzP5pEbJOBIGqbGKYU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620712; c=relaxed/simple;
	bh=WCwsjX5tjNgtlfLdTkL6yOKaZbozA758nK1HWVSKmPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oSyYhtWUoWNUmQ3TDmvBU9pH5kuSd2RAYEUSAxHYDAuI1ThGMjDzxZPrFxHIhAwMKqxN/KeTZmLq9ethlctjp5Lw57pz4IXWHDSHIa0GzcV4v4nzGV7PQKFAsmOXxl0QwU/YGD+zqoM8hfFIyztjll4639RyUtogTx3/0PbtcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IAPD4fid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NI3TOiXU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IAPD4fid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NI3TOiXU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E371A140012C;
	Sat,  1 Aug 2026 17:45:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 01 Aug 2026 17:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785620709; x=1785707109; bh=/S+q1vosK/
	JQ9OGk739LS7CzcMDuZL4eXXPyGk7d3hQ=; b=IAPD4fidn7Rj8tGPIMdwJ9iRBu
	WGF7/1+yDOnz1pSU2TjYt4bskyEgq+vKyYOc/glYcOlz6wx9c8C6evwr1/SdiVoI
	bZqGMN9a7EXalboe/C3AzHJUX0MV6og5mtlD50gQAd0KyeWIs3kr1wcrO2SXVlmv
	jI/plaK3CN0O041Ii71LXaq2A40MkxZWFD4FxFIVCiD+zxQrHqqIAWPIGM4Beiyc
	MmRed9IaF3t4NC6ax2/vqUB7607SwCbyTVCbk87kxbv+3qxo2Oes5NJDB65asGsy
	WIeSJ4cjZ8NlGMGFCoUC/J5yQrn6CbYXe8qkT5RvRRppxCjGLJL/ebCH2oHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785620709; x=1785707109; bh=/S+q1vosK/JQ9OGk739LS7CzcMDuZL4eXXP
	yGk7d3hQ=; b=NI3TOiXUgSi393CLCIrAAQR4DujZSz2ehv6muClHbum2s44i/ze
	NMJSy2/4wSpUbeyShz7ALYYSd5X8JoKVi5ybzVKJRmLOlVk+ChZmh9CjvfIM5oxy
	uXZenmRkSyX5H35+fcczU1h5EW/If7MTuGEIp4D7JUBHDqA17M2wjFTE61ePMLTD
	IEtjxfAMZf/xnGYIZPPkiqhR0tRgb1CERSMkR+U5TYWlOaFBqSBaBYXyzR6adGBN
	SnkOhEfVyLMrIikH55sjW1AGSpooePb5+OSTGZisnvCqLusbHmv75UR3LL6zSdzu
	bJI7G5d/Pp/Zj9/lw9iEwu3eZt1f4cUm7Ig==
X-ME-Sender: <xms:5Whuaksx-OR0sKmzGIqIpRexPJUttASaOS37jvmklvrKJ307j5FtOg>
    <xme:5Whuao5W7KZFAn27VjIHS4D6ozEFziTOc6d-5_mCHO-cAXU9_87cB_747uFInhPPy
    il1hjMSCBna62g3SfeRk9nC4SKJLBzOyb9_SF4WH7aAfHhtSu_5ow>
X-ME-Received: <xmr:5WhuatJ2yotsCw8fsLQC8lX5fxK6ULWPwDCgw-r1iE6hyI54tVcClv9AUL7KCREkiI3PWCgufMlIOaz8YGH5TaegrjzrMdYU-A>
X-ME-Proxy-Cause: dmFkZTGJZb4kFN01IRh1UblYnMgHtzeSj86or+Xi62yxp4RZb3TyBbTmCo1rMj6DoHFBgQ
    ifrjFAE4BBChwJvuNmp6H5vmIEUCLGurxfD9bBBbGF3VLb6Pw5lcCZ00Ye3Ieb5lpOVGUr
    ayHG3NMNMbqtXsPAg80B2P+UOqWfnnxJSNWCX4SmDrlj5Kw3Qib49/gWusOmibpdWaFgwj
    bCTIPVNFFMregeFYQzV2krJdeDU2CZgD6Ej0rrQyO3758KBOlJvuh0vFZ9aHXZZPpTavg3
    xVYIln3RxyyDxmzU3V1TUk3TyCWQx2RNdwVQ6TV3lwZ+K6aYgr4df1qoJr4ImCl5B6eYM/
    FXPVOFmj4AryinRqJujSlBQgCV23e2SqecV3z871F07tu2yojcSxOuZh4rJclkY/w6zay4
    Vs2mPl8QhDdbFC95lH32UgMBWdiujiEtYbr0yYfVOw407XMa9/TiL9L7cXWYW59jNSleDR
    U4tra2aMOzP9HJF/x4NbfY0GASICewDdkl2aHWnrhNEwK8LDB6QZguCZdMsIxpfJ6ayJ0l
    Na+gh4XOX1/e/0HVWxj6oQg8F7cuxDOlVz7kfGtBUoDbJR1Ch9d4G2pwUt70jYg4ozOcUD
    3iNS91rE/ZUFLV+W05llenHmmSLsrFU4NoVo/qCu/ctGi7h+EG/xgakJksOA
X-ME-Proxy: <xmx:5Whuag7HV_rK0-XDDL_Ah4suVuPwirYalaVkoWwLoDB9Lqzl6892FQ>
    <xmx:5WhuaozQf4OHa2XVwRtlsuMHjRTdT6yCW2LfXwPo9x5yuTzkMQOQuA>
    <xmx:5WhuasYUa4YzZAC9sTNxNsCAl5eyEhgllldRqn0YEYUkLeTWCKnitA>
    <xmx:5WhuaiTGnLhnO1_DmsgsebWZxmhgloAXa38WFBXXVvzTQGG_4xDfMA>
    <xmx:5WhuappZp9tjIVwn1oy5h6I4mIlNhtZ3jan_YXx36eWMQkrexlZ5yErU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 17:45:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] git add --resolved
In-Reply-To: <xmqqv79t9101.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	01 Aug 2026 10:58:06 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260731125605.3638938-1-gitster@pobox.com>
	<20260801141414.GD2041176@coredump.intra.peff.net>
	<xmqqv79t9101.fsf@gitster.g>
Date: Sat, 01 Aug 2026 14:45:07 -0700
Message-ID: <xmqqjyq97bx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> That doesn't seem too bad to me. I was mostly worried about (1), but
>> after digging into it, I think I've convinced myself that it's a
>> non-issue.
>
> Yeah, our merges that began with "read-tree -m -u" have never merged
> into a path with local modification in it, so I have blindly
> assuming that (1) is a given.  I think "ort" did not change it, but
> quite honestly I do not know where the more recent invention that
> renames paths that existed only on one side to follow adjacent paths
> that were renamed from the same directory guarantees property (1),
> so in these new code paths my assumption truly is a blind faith X-<.

So I got curious, and found out that t6423 has a test labelled as
"Testcase 11b" that covers this exact case.  So it is a bit better
than blind faith now ;-).
