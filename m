Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1835DA40
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795336; cv=none; b=kAtzaqqyCGJtCCoh59q/em5+zC+LP2r7RCuVa959dnfcUXl6qHHTzlaC8wuV5m+iEjjH6x+sL7UT2MT8k7QRfdcapcp44uFLTO0DLwhUXay/AsHeFYJYNdYLJfHpZkhDMNpiQVw0sFgjKEWG+R+QXPAjM5tbkxNTjf1g5JW9bMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795336; c=relaxed/simple;
	bh=IjdWaCrw2lFgsrtWt3RZK4Tyi2ue0lapb4hFhXiuAAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5gJRJJVPFIJMQFfxCBw2NsZXXmpF9i4ShS/xmtiRk5XGk0h9fj8Rb4t6ExMr5lZN4bBXIamO7Rz/KK9cblBtEBN9hjggMCcm7OPLbgOjIc38/ED4VAdDtpPfHOEi+CmnCinZB2Ymtup1vbCqHYm6zAGizKRVU2vpVw4TVZLp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HTX4bwqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b30mVARS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HTX4bwqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b30mVARS"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE9CF140015D;
	Thu, 18 Jun 2026 11:08:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 18 Jun 2026 11:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781795334; x=1781881734; bh=Uh6kzsV1lM
	IWqLumkaJjTwosj6K2+GVGEn23o6BvoF4=; b=HTX4bwqYSG8vw56GLdHzbipyDC
	AqCcnkP/Xbobf8z3w3fU2Y8tgr/kv0V998BqrXlawtcpCH29GAKiGIK76acYqj7G
	8KNYoxxl22KMVlndb5XWSjlIGnZsKQv4mzfi2KkfvvDmtAZ+X+QjhOIOfl3eab8c
	MLfSA3c1lhT2XGw9jE276tFL2OhsbLih4YEG2iOxrqir4sQqLvJIfCO7hsx7+Xrd
	g+Vib8jxF/c+ZdOxh58AgsO2Ytd8nfpe8opML6wJ+eKYx4p8A/4iLOHXyemKBFy9
	L2eF0YOd1pSTo3VcghqJkBhuviLYaKvz/V2aka9dHNWiaA5kOdHXBe1WJbzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781795334; x=1781881734; bh=Uh6kzsV1lMIWqLumkaJjTwosj6K2+GVGEn2
	3o6BvoF4=; b=b30mVARSME/sWhMMVgI0261NQQSFoNgtle+F1zgyxsRuxEHTK7h
	5jCB4o+sMCt5zok8CLst/BRJj3nsb/OQ3k6YY4KQWJLNEbYo2KIdY37UKcB4UtBn
	G4oXmCREuMFbxC08M5Hw4gpX3mnRQZ4JhCo9YH6MOfnc7YpSOD1LQ/Z3t7zqwlqK
	/KQ9u9e7ye8T74/gSl0bSdwywyemUVMZhJTLnY6Ki3UVacnslCrKv4Ro4wlZIEpt
	lyqOHT7T1Yk7QaxIR4xSOkrwpiibJN314aMMWF0BaIY+Soez/LFUBoOvaswqW1ZG
	0kdG7TwYF33yWb7fkBQgYqBjUfRyGvVa88w==
X-ME-Sender: <xms:Bgo0avRgDbCY9zVmWgIUgn5j54gd1IHc0LvcJmcNf-k8SDdujl9Kzw>
    <xme:Bgo0akfBLuuqhXkSX9ZvqKROA4zmnkInuMxPO0jmi6OTNxdjNDvLxPuHR46cAw-Pr
    Ct2ig2dqa_FY4vEuniOlcmsEv16pG6QD8IcrQP6oFk81wOG3gpRow>
X-ME-Received: <xmr:Bgo0aupvxSyqSvUnOpytwfPPTOi1YMnzg5IM1l8RFdgSYMTi4buR0m0cVU6tbJADqf_0P6mrH3jxzEg5v99g-JGfVp66MjW1bOqb>
X-ME-Proxy-Cause: dmFkZTFjdiA/Tsw1A5uPq9/tGeFhsh/BdJvYxdMmmOcytfTLadGnqrvRdK+xC5FnkyDqiy
    d8c33N6cGvjrm0KCMHlDRqFOGdGTz+JVKNRb2mgUgkY7JhxJM6GJRFnwvoG19NEFxuyIHW
    vdm6b5NKGc91LazJ3c0s7Bhxjf8cZ9yKOaxC8P1rzad7EMIgP4hvxtAL9g8kbLFfRhc1E6
    nRmrvXCeoIThLfu0Vq9dbb9/qzZZjYZjpqh8bAxBpus0IQHdQUp6UqoYx3henpl6cjFm6N
    c/gBKC8agKtZpr4GjCvHU4+C732NGn4K1YmVWJXAi4MF1aIrggYCBJNtid7RKPL92gTWE+
    HRhT8GkD2OHXSzddEnpXN5v9ZOoOizXw/KOhth0/+JFDvGdEQUNvyCTPvFQVkus4KU1SnM
    XJJQ0d5GZ8wmSwxE0uVk4tJVZuxgBlv1iJp4xNE1tuX5SQg8B5uU7BVih8cfju4+III+Rd
    zdZ7eHCmeZ/acTZIJ8ryccUCOtsnN4TDPl7/If2l3jdx/5LRfBoLahKPIDymUF3wFXh5vV
    IFO3q8D02Gr3SZPc98614EOrvLVxWpHP4VPse5mbRbSPp82A6zugBg3Yi7xzPXgyUzjpu3
    9PkT4bjO5aDGMhzUEHdcAs428AY1JRLL/brBAOMnwLG38wL6PwNm2waZyytw
X-ME-Proxy: <xmx:Bgo0al9SQm4-P8jiBNAlXNonRhkYKPUhWaz13lg1C-O-B9jG9U-GkA>
    <xmx:Bgo0aqc7SEA6SVmbtw7x1Ml87GQXmSZDkGdSTOvfPwYVdnkd4k9wRA>
    <xmx:Bgo0avKOfaNj9T1FNYGCnz6Z6VyXyzv5Qv5WWtE1lXDN2qPB9hDq0w>
    <xmx:Bgo0aqi_Axwza6FTnVvuZKk9gqFS5FQskMPIYU6Em6QJRn85sZcnvg>
    <xmx:Bgo0asIdORZxPCnfMfoU_M4YRNI-mNPKV6RKt8HwVlzBez339kq0j7m6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:08:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] More work supporting objects larger than 4GB on
 Windows
In-Reply-To: <ajPhBn7n1wR-sii4@pks.im> (Patrick Steinhardt's message of "Thu,
	18 Jun 2026 14:13:58 +0200")
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
	<ajPhBn7n1wR-sii4@pks.im>
Date: Thu, 18 Jun 2026 08:08:53 -0700
Message-ID: <xmqqwlvvsx6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 15, 2026 at 11:52:22AM +0000, Johannes Schindelin via GitGitGadget wrote:
>> This patch series tries to address the problems pointed out by the expensive
>> tests that now run in CI: t5608 and t7508 verify various aspects about
>> objects larger than 4GB, which Git does not currently handle correctly when
>> run on a platform where size_t is 64-bit and unsigned long is 32-bit.
>> 
>> Changes vs v1:
>> 
>>  * Rebased onto master, which merged ps/odb-source-loose (with which these
>>    patches previously conflicted rather badly).
>>  * Removed superfluous size_t s variables (thanks, Patrick!).
>
> I skimmed those parts that I was previously commenting on and am
> happy with those changes. Thanks!

Thanks.  I looked at them and found nothing iffy, either.
