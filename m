Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBC2652B7
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393750; cv=none; b=MyEZkzpCtdzj+7pVrN65CHHdugTp5aB0AJdVyCtvtstjB/3AfHE+fJS+DBOvP12ZRF+eG37hmHh8PWa4/HF3LJTAlgdak0U9k8iKlC9nsrrznOa+eYxseB3vCZqIkhj+XtF05JEppJdRztBh2gp5ov6oGh/UnwzqGwdhp5oMRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393750; c=relaxed/simple;
	bh=nsLRw1Xq2drKEPm6TPM2LsegygQhJOe3SPpbllkdV2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KwA3vOCk99XFchY3TwUryeZn91jytRy9NkDVU3vdWR3/3OM5/c5VGD0r9iDcKXBBUdC9aZWNllw7k6xsuGUhBRda3NH6LG5umy7xNM1HR9ksdLFpro/jbLeEywDbtqKidN41QUILGpzjxAqtx9cwznj5jBQu0r/EGhqkZQcp8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yl0QSBLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+5jE1id; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yl0QSBLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+5jE1id"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17A287A01C1;
	Thu, 28 Aug 2025 11:09:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 11:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756393747;
	 x=1756480147; bh=SxcHA/3Auoz6oFdjkVf05sXdBR/9eMb+Q9VX3yklj9Q=; b=
	yl0QSBLkWM5/MjDTw8O/qw7DVpkmatLTtOGo7Tjp/MQ5wpO5OXXc1hIVU2SebSVy
	cmTEy9cw+RFiesk6Rp/rnlUJSicbLX+vzh4Tc3F1Q+9/INxyt1yMlEkwjiutNlBR
	LnL3c+avo6SI4/rf3y9O3Tv5Br+Bwk68by2f5wUoipXgV8PwUzMKY7sXpRTQ2r6S
	tamJsrDOg11SqQ5T6+L1vL3+uIg9avQc/LEXppGY4sA16lQYBc6qNAbU0FJjKaqD
	agSbsR6twIVue0SilCSdpKxqMrMFfftGrpww8A+vqi2S2uCtmT0F6EoEji4BRNjI
	f5emzoZiQYgT6e3/cIw4xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756393747; x=
	1756480147; bh=SxcHA/3Auoz6oFdjkVf05sXdBR/9eMb+Q9VX3yklj9Q=; b=C
	+5jE1idwzMx5GMLymtWt9xV1EUFq1HEgP0HCF+eogaoIavqAgK3YxwXjEN79yyaS
	HIGYL1pbRaT+HSalxUP7wLihAL/AMjvsdIFet1QKEMUWhkjxDrdrLCUQIrJ3Vv1K
	deU8laf9lU1u3I6gDQgW3awPcy94Zkf3rq6tfMR1ReV5qitB9KBcbrzRZv+LJLBM
	XwGg8LSWCUWagbUnkffQjxCOFjoaA/3T7rlV9Y3+NAWy0Gb16K2nbeTFHsj7YFVT
	mLpewGMz4XA7YAgKWoMev3LC1uQVnpHQ0Kmx7aqzmzdcX7AMAYQxjguKToZGK16Y
	JFS4iCCK3xASOFbLTVJEA==
X-ME-Sender: <xms:E3GwaAmDzC0jG2KSAPfITdP5GCx2t-BuIEOy2czM5wiGbwmJzy0BHw>
    <xme:E3GwaLVzLHsaMA23Lzb0_hC5mINjTvG1xjAmkfCDEvjG_021EkA922bRLgrFAjp0B
    bIv0CHoRBnsyJQFCw>
X-ME-Received: <xmr:E3GwaFEMX4j4ox6b19COTn6i4GrtVJOuA0GN8cVeTpgBzz_uzTC6ZE6sjkze9ptNj8lgX1DdEvVFv22wlrsjsCJmIl7HHFOI0QyqSA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E3GwaHfBSkOg0wlC_NNnOAgaVPIHPG62eYx1EbcF4ylWwUvkYm5QZA>
    <xmx:E3GwaGKjVWBzCBgDh_wsdbzobcu0feRzijZSaGt5ULg_Lq6kWpkOnQ>
    <xmx:E3GwaMHk0eW57kXGEnh-bTKEzeB9yPd42kDfG9yZZ0sK8rxFNh-8tA>
    <xmx:E3GwaJANQaX7Zs1xpTQBEvujljPaDpvDlyFrOtdN8h5-KSnPNBKFEQ>
    <xmx:E3GwaANE8-X9t2oggsfIoWPiV2O1jJVenUvSRSYsFV4XKsjJkDpZWM_P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 11:09:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] usage: help the user help themselves
In-Reply-To: <fde74862-a5f8-495e-aacd-59429fe5cd20@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 28 Aug 2025 08:39:55 +0200")
References: <cover.1756311355.git.code@khaugsbakk.name>
	<e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
	<9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
	<CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
	<xmqq349czcl8.fsf@gitster.g>
	<CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
	<xmqqy0r4xuy7.fsf@gitster.g>
	<fde74862-a5f8-495e-aacd-59429fe5cd20@app.fastmail.com>
Date: Thu, 28 Aug 2025 08:09:06 -0700
Message-ID: <xmqqldn3xz3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Thu, Aug 28, 2025, at 00:26, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> command being retired -- was to reference the provided hints. So,
>>> something like this:
>>>
>>>   - send an email to <...> to let us know
>>>     that you still use this command and were unable
>>>     to determine a suitable replacement using the hints
>>>     provided here
>>
>> Ah, of course, yes, with Kristoffer's update to tell what the
>> alternative is, your phrasing is perfect.
>
> I think so too.  Just keep in mind that pack-redundant does not have
> that part.

For pack-redundant, isn't it because there is no need to find
suitable replacement?  That is, instead of finding a redundant pack,
all of whose objects are contained in some other packs, which
practically is impossible to exist in a non-toy repository, and deal
with it yourself, you can let the normal "repack" to eject redundant
objects from all the non-kept packs.

> I think I’ll use that suggestion verbatim.

Sounds good.
