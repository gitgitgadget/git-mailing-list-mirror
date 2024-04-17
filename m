Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61910AD48
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354506; cv=none; b=hJms07lut3EonF/LWmrDzaQzqAbtOExM8+SdulhY04gaI45n3lzaBlwPVhP/1vq21/Jp3Pb+2Hqy/Ka2/ylj6v2mqUlWuDn+cavySMrl2ZA8JbOK/fDnCdTmxs4ieDic4aIptIaKNFV2m/m8J8URbiWGVRN1ECxbKpj+gPL2170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354506; c=relaxed/simple;
	bh=uR/LrW1/3Aa2hkENiK96crJW99VRejWfsniUMzpeDPA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RR37Dj6LsRCEDQv/Jp+Nek4LEJYe3vX2FXJS4klBrzBwkH3fkKmBvAlJ8av8OW3nh9cB4NBzsD4NIP4KlMpebHqvUEPptASJ+FrEHlGiWjee3OAHv44mAxEvqkLyvPtEELkQ4J65wOk29NiXxI5ZUMS69RRggJpKmlT4rJUGktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=i/t27G+Z; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="i/t27G+Z"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713354502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBhim2pO5Iy/u78ic4EIcOoxLHihfqDL+YD7tWNx8sw=;
	b=i/t27G+ZYs1v6e3FD+mjNgZRlwlz8H7kWJOe7515eK62gd/eMdEuvWUNh3W0OQo0+8+l9e
	aFkqeLAr/tviJbkmhf+nphRJ7nsnf/OvrbtUd7CQvzxUVH9O5ZJCTl784VoqlPkbJDpDp+
	NrOhaxflYmwSpBJx926Vf5lIHm4f2mwKyI7ifn3OlTyosa+GmM/LxVmWuDXKHh2mIuLaLY
	4oR3FcLX69fL6qnTZB4yogTezdz/yygTvqyZNJejGYHCVPyUxY4F5gGjxhhDursEUJNHXs
	KpQICFwTDgZFf8lyNPhx+ANhxVuLO3ynSLCV/6f4YFc99KWY9rbGlWPAq+oZmg==
Date: Wed, 17 Apr 2024 13:48:22 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <675e2dec-a80e-4b5d-84ab-75ec5604a1be@app.fastmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
 <CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com>
 <9a6a9cb1d9dd07bbbbc47616c510779a@manjaro.org>
 <675e2dec-a80e-4b5d-84ab-75ec5604a1be@app.fastmail.com>
Message-ID: <0ade0ce2348ab24617e19bc60e648b64@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 13:38, Kristoffer Haugsbakk wrote:
> On Wed, Apr 17, 2024, at 09:11, Dragan Simic wrote:
>>> I had the same question but left it unwritten since I noticed that
>>> this new test is modelled after the test immediately following it in
>>> the script, and the existing test also redirects to "patch"
>>> unnecessarily. So, if it's done this way for consistency with 
>>> existing
>>> tests, I don't mind letting it slide.
>> 
>> Yes, I also wasn't super happy with this new test, as I already noted
>> in one of my replies, but improving this and the other similar tests
>> is most probably something best left for a follow-up series.
> 
> I don’t see the point in writing the test in mimic-neighbors way only 
> to
> improve it shortly after.

Well, the logic is quite simple:  let me get this patch accepted,
and we'll deal with the improvements later.  Though, don't get me
wrong, I'd always prefer to see things done the right way, but the
time, just like the other resources, is limited.

> If the test can be written in a better way then the other tests can be
> improved later. Or now. I think I’ve seen other discussions were a less
> good pattern wasn’t accepted in new tests even though they were used in
> existing ones. The reviewer then pointed out that the other tests 
> should
> be updated later.
> 
> That’s just my opinion and recollection.

I see, but this makes me wonder how often the other tests actually
get improved later?
