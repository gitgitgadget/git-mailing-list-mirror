Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71E3DD51A
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407831; cv=none; b=OJHoMkNI2E7uvf0DGz6ryTa7OWjlKsxB3F18Gcs+4JI35tgl01lZ1Xlqq/ptkoiElA3OffSDbjAVod49hG3GH0HfHg0ADNIJGJrO4XPnhv/U1020EmYYNow9zXDGwLR0daZDv5+oASivaYEkloc/WK+D7Q86pZFoqidlCCXcZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407831; c=relaxed/simple;
	bh=DcjWlnFzDMQe418VWbfPzkH1dtSi0QL1a/2nIZtLD2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iL6Mt8gP/scvG2jldDzdZ/KKPhrkwqz1FUeQiBembziV7e+Dl9YX/3OiB1lwvXIXBYlGnxuXbo9qbvBA/9AlynQaJcG2oUtRYyGhsspcw15q/DcyTZrIXaVUlQx/2d3PNCbyjTgn4MB6w8VMyYZbdSI8KpTnsYBUoPIZFXfU57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h+N3ghuQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoEz1p6l; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+N3ghuQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoEz1p6l"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DE44E1D00071;
	Tue,  2 Jun 2026 09:43:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 09:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780407829; x=1780494229; bh=Rgk8ODBwFr
	m9c3oecHqfn9wSbNXYZRSRvrLZPKin1p0=; b=h+N3ghuQiZMvlozEQ8tOZ2YWlS
	N9GuD1K027GXFpeMNZprM1V5H8OZoU3dRBwYjISWbHnwPX6YE12N2afbH1IhNuzV
	yp/NiqIILyOhmEq0LsJmUv66V/oAGrScso/Nl6aquedDlWGfeqrJjUkWBGEaMDNL
	K5seR/za7aLz7JJq2GSV9602IsLlaA6GGY76vxj6y4t3pEf6Vz8/V3tLp+m3LHKM
	siS9LqWJkUEJISqMKjb8ewRO+G79LD3Sf4EAKTrxlQ/MyjuOIUAkGQuMpgA/CAQO
	Ba+cjzr6r65/IRxjrYztda/ZAi6N81datRL/nIzD44vOiLjwuuyjo6MqUigg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780407829; x=1780494229; bh=Rgk8ODBwFrm9c3oecHqfn9wSbNXYZRSRvrL
	ZPKin1p0=; b=IoEz1p6lRaxMC6gGjLgF8+3I5TNKHdjhZf6YBXnVtu7HwhuuwlS
	8tV6SkD/BTC6WHTv7ozW5woGPEcWT0p78Fqq5GUISQQ3119ZnpsD6EJrCBqKOBs0
	QXW6bOwktoGB5SV79SDH1UwAle3aOO1Fzn2XouNtKRaXNP/QYfr6H9hVO9B86Td4
	jXbrAklce1lJ1pOWN6ttHxWJ9nJHN59O6UjAdYQVfLRo+lW4wEP9LFi8Zb0x8Ie8
	yv/6SVsC6Ski7edeXCHlBYLq83NGqWrmwra/dpEh3y6sGGnEq1ztoOKc3TwGF/tv
	b71M6qA9IwlL8TEOR/TR8cXw01UjmE2G7jw==
X-ME-Sender: <xms:Fd4eauDJoVmDzQvJ10uZZEBFS3CYIX2LVIBydNUBH0KmbGtRK1rOZA>
    <xme:Fd4eav8rlJHjhJPGKbTvHubJ_b7g0y_K2CHeA6ENHOajLVqdm_UU96WFnDUXhyGLc
    m3p--JPvmhKSeyZ4_OL2-auQaKvmXIlPSIlB7g9CjVPuh_UWh11-q4>
X-ME-Received: <xmr:Fd4eau_dLwEtHCkXgTSC8herwif4P0NCbbkYSJ_cOa_zJah86v098W1snbmr7HgnEawtbCVNrvX0sZChbSyUOZmIz-aeOBMJl1_i>
X-ME-Proxy-Cause: dmFkZTGhn54uc6wCeo7GjJcRkDygjKav8dWbgLPYN4E+0f5m063dk56mYtn3nywY24yPmW
    5ZNQ6OwmCJYAKMzIepzzuk3pJ8R02snPjpkhFsaEiuH3Dp+GRgA7tT0nlLNRxj/oPVYzQM
    uBZ7jprHXGXPoK0VyrK4r/Xo08C9k9nKD9cHo2ooDueHFloFKPOTC0A1WJSNAR6YPDz9wo
    sphORIuXEwPAFwwiouCiAUCtdiNGYsQ4RrZZ9cbXYYF5Qio7aX9SvtZ60Uzxf5dA8P/MiU
    0cD1vH/41NkgyQUhLdvHXRCQwudrJI1SQXsHeIXV91suLel8bSSg07kBTJN28hxHVs0fhL
    N47IwPeuAdp8/1u9uKL0aoqmoeKjvZZiJY3NYFoMnNvvvNB8W4EUMzG/0oHDaUSaMpoY+L
    K1QP1pIDLkOkCVMKfBiKG2Q3Zr/vsuXt5s+kdQyKAIroVhl249FrJz8gO0tfZa8ch7CS6l
    NLmYwQ+Pz7M92G2gmik164K2ToV03U4FoTYqyhM0hbsY2QCWoes4di5HUUcmaK3jbvYxH/
    XV3fWbAj0pkWwyEJknNcPhVp9uk1Xyk9oPcNc7beJU6Dz9Zp8jm72xOfJsWw0DM++6FwGh
    YqMpeyT/+0Bl/JoeYWtdkgaE57T8KADKz2ZdB+6MaT5wKljcMQbUJfz8A3xw
X-ME-Proxy: <xmx:Fd4eame85EXV3p-DGLbD1oY4jICq6WWgIMdUGf-pplHrsAo9YQFALQ>
    <xmx:Fd4eanE9_q6sYVzlBe2GwAs49m6Qms7m07BFgwekjYfqqbF4FEBxeA>
    <xmx:Fd4eakcwMZr8fb6_D5DmbvFTMRIOAcylMPdaNzprZJHd4DCivpzoMg>
    <xmx:Fd4eahFimFm1cmVIOU2G0K9hcXoF7IpQoNN0RyEXcrzAPSuNHukuLg>
    <xmx:Fd4eav8q0kygARIYP40TjLfsvSlVSSYympkUCSV30ci4-Y-dXluD3yrO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 09:43:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] SubmittingPatches: describe cover letter
In-Reply-To: <fd588cff-be2b-4422-9c01-cef06b2ea5fd@gmail.com> (Derrick
	Stolee's message of "Tue, 2 Jun 2026 08:29:11 -0400")
References: <20260602090808.87837-1-gitster@pobox.com>
	<20260602090808.87837-3-gitster@pobox.com>
	<fd588cff-be2b-4422-9c01-cef06b2ea5fd@gmail.com>
Date: Tue, 02 Jun 2026 22:43:48 +0900
Message-ID: <xmqqa4tdvyzv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> +. Make sure your target audience can understand what the patches are
>> +  about and why they are needed without prior context.
>
> The thing that I like to say about the cover letter is that this is
> your opportunity to communicate why the value of your change is worth
> the risk of regressions and the cost of maintenance. Perhaps:
>
> . Every code change comes with risk of regression and maintenance cost.
>   The cover letter should clearly communicate why the value of your
>   proposed change is worth applying. You can also describe how the risk
>   is reduced by the design choices you made while writing the patches.
>
> Or something similar may be helpful? I may just be over explaining.

Yeah, it may be a bit on the heavy side, but complements what I
wanted to achieve with this update very well.  I wanted to encourage
writing for wider audience, without leaving those "not in the know"
behind.  What you wrote above is more about what to write, which is
very much appreciated.  I think it fits well as the 0th item before
the three-bullet list.

>> +. For a second or subsequent iteration of the same topic, make sure
>> +  people who missed the earlier discussion can still understand what
>> +  the patches are about, so they can judge if the topic is worth their
>> +  time to read and comment on.
>> +
>> +. To help those who are familiar with earlier iterations, give a
>> +  summary of changes since the previous rounds.
>
> I find these updates to be particularly helpful, even for GitGitGadget
> PRs that include a range-diff automatically. It's good to double-check
> the human description of the update against the computed diff.

Oh, absolutely.

A GitGitGadget generated cover letter that lack any human input but
just range-diff dump is often very hard to read, and the receiving
end is better off pretending there was no useful information in the
cover letter.  "git diff @{-1}..." after applying the patches to the
same base is sadly a lot easier to read than "git range-diff @{-1}..."
for many series.
