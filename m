Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1292222C1
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447246; cv=none; b=eBNPVpBqbqx3zLYwSjuSiV1tmMsRLSEcvN2Z5IVAVSQ5H8qjBendKCqa0gzQK98CEocA9dXPayHq9QlOZ/XusEKnobrlhInIkfSF4NH6T3PE8MSgJYsnpR8Jc5cX3zMUmGNbGX1GFuKnE5zSwVDo9HK9LKBpKYcjcwJoF4WviFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447246; c=relaxed/simple;
	bh=s2VZ8sVMjpuXGYBVbVuDEZlOW5zuII2b23T1981HnpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGdBj6pIgGzkkp5Wxtf4FzXmNuPSmThWi0jy88IZRv/Yp3OiJQrihDPQvldoSXXUltMkZHymLiGytBSQ74Y2Vx1nc88UdEPfBLHP+jheq7J1xZu4PtzYW41+p96kwN/o1cP4i72cAjaS7qPPpilB/ijlB2fw4SOKoiuORo6Pa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g/kI283A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByWvajFu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g/kI283A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByWvajFu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77B54254026E;
	Fri, 20 Jun 2025 15:20:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 20 Jun 2025 15:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750447242; x=1750533642; bh=QwXiptX7I+
	lvmOzElnI5RNfH9+V5FkReogX5Jr7Yea0=; b=g/kI283AgT4CsrReCpGjI1/YFb
	QmeKp91NjLNvbQOQhCW7WHt9ng8WCqTFwEVkNn+EPWZIvbQZi7WHxuOApnFGu0lS
	CM7/8xrP/RKMP4PLlSKyU18sHyF/c4TdoqNXSLF2bZMrsXENoIcPZmfZBf8H+SY/
	qN5AzlFiDsQBCog7CJY5OVnqAuFknKyI/39RdMbQcAGD8qCXzgQ/S4TvxRerzOku
	VoLrCuSxC5oH4qNHj5jUMt6VjTlOV8DybjtS2LjS2OupWPAaMyv1hl8lZNsXtGVa
	mCvk2csp0ETc3G0ZdvmKHBXWpAPoOreZYc9xxZS/at+yBPsIZthxgXb1Iu/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750447242; x=1750533642; bh=QwXiptX7I+lvmOzElnI5RNfH9+V5FkReogX
	5Jr7Yea0=; b=ByWvajFuxVPuE0uyTtItMf/ScxAI2JvL7QohR4OU/O7fxd3130Y
	VxiJkqIQyFkDNdKW3S8Kx658qN/2TQQAV7YX4N/Upcp4QP4mz1JrFa1iMt2PJMBu
	mpbL1QRS2B5qBKi9tWQanV9FWyQIs1Mn6VVSoaY+zXbGpCDaJRoVh5FYiKO9jFFV
	7YHGNs/27pXBaWwvaAuhU9DzPUuHOsyVu9MDBGZWpKhQh58lffuHO+P8JxRsU5GT
	IIP35AhpAxruk/gbjvyc9qieqfTJzOJcIhFK7NhFrQCxx0rMQSqzVj1ZB7IO/Ove
	Tmyp+AA2UOZdXZaF9wIKKWYu6Xzo8mLic+Q==
X-ME-Sender: <xms:ibRVaErEQWEpGaEtyc07uT9N1ZnCzcnCaATZSlI9m4_y9gIiY3EuOg>
    <xme:ibRVaKoriecsmNfcSkZ_jFy7emFvmEqPgkffgomaCvfq7cbe-fGZyWgZc2D0xJjXq
    H5cW0PgQ0ScxnFsjg>
X-ME-Received: <xmr:ibRVaJOrunZlYWepOhTPl618ca3-rYZn__eObyBQMwFCyt5EphHAbBgacri3rh8AygflehUvnSlIWJ2v64G6RqYmsRSN_H1_Y-D_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ibRVaL6LCC6M6CBzEeNgHBco-dofHBusxApdaX1jIxsFdSpE9jjn3Q>
    <xmx:ibRVaD74mxqKTjWCi8wg1dBGGGCTeRDdGbCCAAqDQe2UYKl0OQyeLw>
    <xmx:ibRVaLgCf5MIaAf1HBdZneSpbmzwkmOTOaB5onH-1vEkeySMQsKoiQ>
    <xmx:ibRVaN4Jw20EYxHwl8JrXWeDWOI6Y6SMCqKPChQlj7TvG37klq5azA>
    <xmx:irRVaJqZpb6G_9GyCCSNiAtz0IFtuJOxGIOdu54OfMKUINd7dAgsMgbH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 15:20:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com>
	(Christian Couder's message of "Fri, 20 Jun 2025 18:12:36 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
	<CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
	<CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com>
Date: Fri, 20 Jun 2025 12:20:38 -0700
Message-ID: <xmqqfrfu2pa1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

tldr; 2 brief requests.  Please

 - Be gentle to people and expect that it is normal for them to be
   off of the list for a few weeks (or even more), not able to give
   a timely comments;

 - Fully stand behind your own patch (unless it is an RFC), even if
   some of the idea came from elsewhere.

>> Why would it need to say what type of signature it is?  Don't the
>> ascii armor lines have e.g. "----BEGIN PGP SIGNATURE----" and "----END
>> PGP SIGNATURE----" around it, which fast-import can read as well as
>> fast-export?  Is the idea that we strip those lines and now need to
>> replace the information we lost?
>
> In https://lore.kernel.org/git/aAq1nvcPRlIPal5l@tapette.crustytoothpaste.net/
> brian said:
>
> "These should be separate fields: one for the hash algorithm and one for
> the protocol.  Alternatively, we can just keep the hash algorithm field
> and parse the protocol by reading the first line, which will differ for
> different protocols."
>
> It would have been nice if you had then said that you prefer not to
> have the protocol.

Let's remember to be gentle for those who give varluable feedbacks
but may not be always on this list.  A late comment on a topic that
has not hit 'next' is much better than a late comment after the
topic hits 'next', or no comment at all.

Also, even if the idea came from somebody else, if you agreed to the
idea and made it part of your submission, then it would be better to
explain it in your own words, in the most appropriate way to answer
the question asked (e.g. the original from Brian and the question by
Elijah may have stress on different aspect of the problem).

> My opinion was that it was better for tools processing fast-export
> output to have the protocol as they have to parse the "gppsig ..."
> line anyway. So it should be easier for them than to parse the ascii
> armor lines.

And if you do not agree with Brian's, perhaps discuss a bit more to
(1) either convince yourself that Brian's idea is better and rewrite
your code to adopt the idea, or (2) explain the reason why your "the
importer reads and parses anyway" is better design and stick to it.

> ...
> Yeah, I would have been happy if we could have been aligned with the
> goals of the format and the fields earlier, but better late than
> never.
>
>> Thanks for working on this topic.
>
> Thanks for reviewing.

Thanks.
