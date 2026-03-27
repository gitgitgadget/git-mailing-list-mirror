Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74A345CA5
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627994; cv=none; b=egtySgunIYFg2KMNfkf4LNnPwSpzFPftRDLtFxMSYuLNcna6R2ba9kSoUjd/w93y20K06zi//khlc/h4tIA8AzXe5VQTJcg5BzS3LFSbycRJvjzixehMk7xu7ZBRPXZdmdIWQrPQv5KgwM9HP6/JJmawikbSS0nX3GZb3b9gDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627994; c=relaxed/simple;
	bh=gozPdwPSopKymBviz6PsC9N8fRjzJhDm4DHdkQjpEyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGRend4d57saJn9+lPztoSpC8jYNN3SwZit5ufD1uGDeTigKv+HivlmNjY31PGbUTgPLHYbfw3aJqa33wpY28RaJceqbR8N91wnvgKezitqVj69sGWRsSji5eWOgCp5/G0/BLWAUeY1V/aNsjyqcVgURK3v8mp9tJY+BKJku890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=krcSB3XB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z4BsNJqS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="krcSB3XB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z4BsNJqS"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BF9E1D0017D;
	Fri, 27 Mar 2026 12:13:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 27 Mar 2026 12:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774627992;
	 x=1774714392; bh=mMn40k/gXKG5XgvFiYU64/Yzz0BVuiapqq/JaPyv2pA=; b=
	krcSB3XBIyCMouvCQxzYCvKj0Y8hNM350JO7cSH+vMVlVq7Y99ctO5q85n0kALOH
	SbwrkMrrpP65lSF3jWThIWANTvHLIMKFm+bHWudoVVaMNoz7CvU4FealqUSBcINh
	Tphxe76rSqcRIAFdHqs0hcWCO/UCxEiLPOfXNf+H+g4anHd9ADiymlCbk2v3rMXM
	rUCFTr8Pz+w7odO9lSirlJA3zVzYTCLdLjrh1yw/6yVq7gMp2K2qvO3POyG2OobN
	0QV1UP12cGP8sbei/eP0/dUirj/PH1jW0ajRFHWtlPSGXOuCpXBKZzc6Y1l2lndH
	1CGl2GnqZq45Dld+qxnwYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774627992; x=
	1774714392; bh=mMn40k/gXKG5XgvFiYU64/Yzz0BVuiapqq/JaPyv2pA=; b=z
	4BsNJqS8cTdl6K1hXi3SOtDRFva9wDZ3n6ddDkqITJ3GLi/NQoz49CVrtWszKpE6
	qDbfReDHGqne6EgZjxc+jAmSi/vz06Ya09SP44LsqZjzGx+jKNgXRvEIb0cPlRtK
	9BOj4NmKks2N2fVQu3V+ZOgECUZLBwX8LfpwD+emT2RlJHi34SWG+Zd4WIlc2oZz
	ErRUeRCLVGBmWS1+sTmwtBgC03ieom8P6zm05R3hPz7i/HxYo5lxdcmKpbLNZXXp
	kZrnVaI16tIoisjndsKMrDKUt0TQr5hCnHKF83o8YbZXega6JqGm3gl6PhLLlf4C
	WaBKYRf+yOhFtAhgtqS9Q==
X-ME-Sender: <xms:mKzGafEJZ9-vOMGfee0LAkvaRedmeWsh0wv8MfdGzmj5YJVTGzf73Q>
    <xme:mKzGaTOoJvUcKQG0s-mLkvQ58IlPfocpyE7RqfyoGdjfdqg4rjTkJqsXXwsg3Owwb
    9WDWO1iGEY8GzgmOYNAnqBHKHKApjEu3Rt7dcwxPPDNeTqpdpupuA>
X-ME-Received: <xmr:mKzGaZcCqghierNjQMM_M6rR3wSfWXn1tsxEinbT0iQyP3JjLvhFMV3_uqqyiw81njEuo-RVUZDi3rpcPZxf70vf523OcWtEkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:mKzGaYvui0nI_Q0UfZ6IaKHdm3QTmMcMxxY8w27JurX66D4yVErZJQ>
    <xmx:mKzGaSkwH7A67iv9JatLuOlxTwwxTqBn2RsoA4GJRqdMyV0sZcw1rA>
    <xmx:mKzGaSyxVPpIEOaz0VrUGZx6c_OkSSOf9RhmBW_vQ56MsQ_hmnFRXA>
    <xmx:mKzGacM_BoDv7Wj-MmRJKzJJZqAJKWBrqIQ1IY4dU0cxN0lFHyVIJA>
    <xmx:mKzGaVIkZdOS4h-byYZJTvK1Ap1tH-ovkBnl4-wlb6T12Hq6iKVQJwIo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:13:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Toon Claes <toon@iotcl.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2026, #11)
In-Reply-To: <CAP8UFD3kxL5xAcd2OBNmLFMdBaRLgB0WKtvSkuO2m7GP=kZK6Q@mail.gmail.com>
	(Christian Couder's message of "Fri, 27 Mar 2026 09:07:26 +0100")
References: <xmqq4im2npv2.fsf@gitster.g>
	<CAP8UFD3kxL5xAcd2OBNmLFMdBaRLgB0WKtvSkuO2m7GP=kZK6Q@mail.gmail.com>
Date: Fri, 27 Mar 2026 09:13:10 -0700
Message-ID: <xmqq1ph5mesp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Mar 27, 2026 at 12:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * tc/replay-down-to-root (2026-03-24) 1 commit
>>  - replay: support replaying down from root commit
>>
>>  git replay now supports replaying down to the root commit.
>>
>>  Will merge to 'next'?
>>  source: <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
>
> As Toon said that the silent failure in case of "topic" instead of
> "main..topic" will be addressed in a separate series, I am fine with
> merging as is.

I'll have to go back to list to find the original discussion to
refresh my memory to know what "main..topic" vs "topic" is about,
though X-<.

>> * sa/replay-revert (2026-03-25) 2 commits
>>  - replay: add --revert mode to reverse commit changes
>>  - sequencer: extract revert message formatting into shared function
>>  (this branch is used by tc/replay-ref.)
>>
>>  "git replay" (experimental) learns, in addition to "pick" and
>>  "replay", a new operating mode "revert".
>>
>>  Will merge to 'next'?
>>  source: <20260325202354.10628-1-siddharthasthana31@gmail.com>
>
> It looks good to me, and I think the v6 properly addresses the latest
> few small issues that were found. Previously Phillip also seemed OK
> with merging except for the issues that are now fixed.

Thanks.
