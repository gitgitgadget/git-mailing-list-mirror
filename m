Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CF33D50F
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820652; cv=none; b=uouFSp/yw8x5tWvt1+GOvwCP9uLwVQXjrjzPEl5NamssNyHMdpsyKIwiZQrMX5cNWuWhCvwbfIBJqImSWdYUAAp52OeBZNcB7t1qNLRCK/CHX1wNSpg4KKMVRniGycEC9YiYwOssaiMyBoRJ0cMvUu1z75H/XfJlUwjCtmBMRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820652; c=relaxed/simple;
	bh=Sa3hCRpNaSAaVbxK0pp6+7y4Icmu7ohW9gWUXY5WCCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNataSW01dDK+wnGVclcPBz6eZg3llzHwpRXHgFDiAALk74kCL5L0761e4/dCEYUgrb9BYLSQmCHjvvsIGIXUj/fM+mgKM+Mlz/s3/mxiU/8+Rnd0TVu9vvzRz725y4iBasNqoewFkD66utt/7zfMVa5bHdnToxUXkDoYmYePVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R8leLVbc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2l5Ggfr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8leLVbc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2l5Ggfr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AB39EC009A;
	Thu, 18 Jun 2026 18:10:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 18:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781820649; x=1781907049; bh=NoStXc0Kc3
	7FGhDVe+rpjWjtImnwUK19hSsF+90UGYY=; b=R8leLVbc6IF5c17dAIlkSe9TwK
	Vbh0bpZNitQM0PztGwyKIyY4LCZg9G+/yaVTgaQxa7yVbr2ovqFLeWyVH4ie+9G+
	OtzkjH07BwCOiQ31p5kkzWT5p4H0aF0MYa/2F98xhIOZQxpLwvRK0od22lEo/66a
	+dv3vnB+UXt+Y3VC06Jwl9wE8rCaPGpwXRFZp1bSmUDmt0MxzMrd2itsrXcAMFeg
	LXkqvK3loWGf1iQNYOrOzqXZSv3D+fCfd1ID33yz/hiGnb6xwukbOC6eosOYUa0V
	iQmwBajqRCpYIac7hsTw7PFIU/io+9/DTN407+bhNqEZRnzJ2c3xCVSCpimA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781820649; x=1781907049; bh=NoStXc0Kc37FGhDVe+rpjWjtImnwUK19hSs
	F+90UGYY=; b=F2l5GgfrtGB+Yy/+Kum6FIC3goIFRaiI7R89ZlKt3avQU8ZYx57
	+mw1CrE9KnammeUCCoiMszL3Upjiammz4VFT8MWcxVa9/AeccP3uYmZ5ru1FpAa1
	7r7IbNarqc+bUFXRNcurzn3JloaRYiPIYTbajbBDPv/pZ9uwzA/lWDvXhJAkUaGT
	UXe1nmK8zmV1O5hRihQYOB3D43BePdBzUQEblfIfS+Y2DSZ9zaRHLLYkA6ooqYq1
	pX0tEWYvfHijZ9GtgBVBaux5MPYZT9zSkDiaJfd/7ve8Dr1AkzhXdlIwLEm7/Pcy
	QIH9FOcVzXwOt7au+6qOh40PY9JRFCKag4A==
X-ME-Sender: <xms:6Ww0asY87zxIjiiW0VcjnwdhpRaURQsJ-pjH_7V7Yv6L6w_iXvA1KA>
    <xme:6Ww0auSqK7gWd8qGukqZ9uvTCmrfLO9T4ChnB4UwiGj_E8yvyUYOgXN4nB_XHGzJt
    vSYC6sSJhcCmSo6hdD88tZtbn8UwWMpr9E_H4NrzBkEQY44fWw4rm4>
X-ME-Received: <xmr:6Ww0avQtY4sbswJvjqiVE0Cr8fN7ao5Ti_RE1WGb9nucXrD9RPBUaXpvtvkCk3pEZfWbJCyJ6w3cV5j-VkJZKrXzMiNcDnKvvmX9>
X-ME-Proxy-Cause: dmFkZTEJdjUgD10YMPBirU0RYSLDq9xr/dnOc/oGkp6IGWBEpEkioT2dyxWEwJmNIYJoc6
    KIu5lfgqz7n3k/Hr6uMJHX4NbxVnfgOKNSVbVp/23fz+QwXn+a/shpu7gjngetjVTUwGI8
    7trwocH0eT5nWfZQQzw2Elohkigi+9btdKaPm5gUi+ei/ag264LogbqI6RWl3Zta6rFTL6
    LGCt6hscKna+U2GOKAj76anCMiytrCWtdetjWUGAGhN6DIU4GMYz9u5dKwMFPxZ6NWtWb+
    vPuFmzoJLtBenLGjrjsFB8UMRg10ENXXSq31UsW35E3ptXp/7P8a8HAwdMI2rnoujoMdWB
    CuJEUKxADnG7ezpro3DExk99S1BXCegHcR4gK6incuspMbIBsC1SfEHpi7r3L+MSqbJzX1
    /1VTmUPaKOKzJoSYkch+MYUWu0XavOo7V0zHKjYb9YKYeOwkBYueqKBYHigUF4BU8ppuz7
    3bhnkQgKiWMbZi9rHD+Cz3D6y/SeX3+rvODYXnNV3U7wEsyChJYm9U3qW6Q0ERxk21vBNE
    lwrsZWjS2YKSCv+yUri5Upyu6ZYV4YQ4fwDRpW9LyQN2n7HqlzzB0VRW+S3F6aPkM2o+26
    ay1V/PhKgso4bpV8qPuAOAy2C8pH6oWSjFniD142Jbz6Z2kj0CzDf+MZLNvQ
X-ME-Proxy: <xmx:6Ww0aiTzFO9tHb55ioiPbqzqlTNhU7MsSFy3aP-5ZsWTImXfFq2PtA>
    <xmx:6Ww0ak6bozCqNL2ziqJeLhUrrQtLwOeLZ2SPayqcyFqSYZKKDwx5IA>
    <xmx:6Ww0au2NFYfgt9Oq_3kEDRujtEnG-No8CvtqWndjJ8MJUvIdkttIcA>
    <xmx:6Ww0avCjZZR8p3NsUy71AxPn8IY1pgXQVmxwwFShZQHNx8EoBhtA7g>
    <xmx:6Ww0aorBEmvRIr7fRChvX7X6DjRceLBDcmqa9wcUPJnrjai4WmoIBR0e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 18:10:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: git-2.55.0-rc1 t4216 broken TAP failures on non-x86 arch
In-Reply-To: <ajOP1IOjA3EYvRfm@pks.im> (Patrick Steinhardt's message of "Thu,
	18 Jun 2026 08:27:32 +0200")
References: <20260617220330.n6byiFQr@teonanacatl.net>
	<ajOP1IOjA3EYvRfm@pks.im>
Date: Thu, 18 Jun 2026 15:10:47 -0700
Message-ID: <xmqq4iizpkig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Building git-2.55.0-rc1 today, all non-x86 architectures
>> failed with:
>>  ...
>> This looks like it comes from the following chunk of code in
>> the test:
>> 
>>     # expect will not match actual if char is unsigned by default. Write the test
>>     # in this way, so that a user running this test script can still see if the two
>>     # files match. (It will appear as an ordinary success if they match, and a skip
>>     # if not.)
>>     if test_cmp highbit1/expect highbit1/actual
>>     then
>> 	    test_set_prereq SIGNED_CHAR_BY_DEFAULT
>>     fi
>>     test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
>> 	    # Only the prereq matters for this test.
>> 	    true
>>     '

The "problematic" part is from mid 2024, so it is not anything new
in 2.55-rc1, is it?  Nobody built and ran tests for the past two
years on non-x86 boxes?

> Hm, this thing is indeed somewhat puzzling to me. I assume the intent is
> to give the developer some information that their platform is using
> signed characters by default? Other than that it's not really doing
> anything, as the prereq is only used by the one test shown above. I hope
> that Taylor has some more insight here.
>
> There's two potential fixes:
>
>   - We can just drop this completely, as it ultimately doesn't even end
>     up doing anything.
>
>   - We can convert the call to `test_cmp` into a `test_lazy_prereq`,
>     like done in the below patch, which retains the current behaviour.

Yeah, unless Taylor can tell us something we are not seeing, I am
inclined to say that we can just get rid of the whole thing.
SIGNED_CHAR_BY_DEFAULT is not used anywhere else, and the only place
it is used isd to run "true".

