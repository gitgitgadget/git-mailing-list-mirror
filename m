Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00147CA67
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554802; cv=none; b=VNsI5lYZdbj3sALtMXiq0HemDcU5dpaPVO8RI+M5NUOK9densYaGupGnENROzo2Be/YnLO6h5anH25Lho/kwOu4B+4cpjL/I2sFQTLGUaXlb0vNFHLlD0PyR1dJCCoTKkZ6UDqe1a6OtL1JB6JQUwWPIcGaKNpsT2SewubpKio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554802; c=relaxed/simple;
	bh=mJcNzPFpe4BLfNA4VuA+xkmO3S3bxwuKxbeOye99Ess=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBtQ8J1yNyyNA5ITlL5gnqufSd/Ea8NXwtIdk4DeDxng4WB+lgRVz6a/q4FHvsAnmmIByFQYIHjmdVRrJzjsbPuw9igGmxHCj0L0Y52nPsKDb8abEuCBGgp2t2iLQS2cc4HMKXsUWuspgIkdlFbssj/+jY0vch+7nSOIiLY8258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V7lDYan8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1ojuWLH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V7lDYan8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1ojuWLH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E85A21400098;
	Wed, 12 Aug 2026 13:13:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 13:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786554799; x=1786641199; bh=IUCJSoJQML
	E03wjnYFS1sK5x+v1CrWcH7YAfZmAa2jQ=; b=V7lDYan853Mq8PlJke5sgDOnGL
	Rpw0/Jn4IcyZMMzI7ZPE4euyiltQCIean4mUHxiL8OIlavKoOnWz23LNkIkfoH0v
	/P6HLIXoDJiaKaZng0Ki+V3CKxVNhGsPGJXkxk4W4HUMtd4/1Fx2Lb4W0CizkUsx
	57yzmGzkrpAtm7cBq8eOUBLNUFOfNlr3CgCGKRwVqAZ7BswL2KGM8NjCT3xCQXql
	TXKeprYNlOZgOhhkOPLJvX7ZUeCmoaoIoumPbBh3g84VLH8mDxg8u4rUTztlFZgZ
	gDI1sOPF1FLlgPn+KjXU9BRhZyaPLUtH+wNNu/Q1q84CdgNbYWV22aD+ijXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786554799; x=1786641199; bh=IUCJSoJQMLE03wjnYFS1sK5x+v1CrWcH7YA
	fZmAa2jQ=; b=X1ojuWLH6FKZs4mdO8HBCT4iXTakoaT3//wo5JS8xExEfLIi3kH
	ZUECPRbQQIW67VrIeemG2gZftLZCdVfPkzN4nEh+MGuYyZAAKQlQUM0p/v7/Uctm
	cJBX6aVu5+Aela1Xa8IpjUgX9m6ZCAP4Sy5sP5g4mroU4FjSUm2thlhvHr0FaN0A
	3c2a7tsuhYSO46Z2S3CjJR1a8EbG5h10JGRysOrMtFGKeCid2AeCfFnV1a2wyJPj
	ueSKmiGJE7JeU/XEIrhZM3WbCGG+2EZHLU1CSJMzZNrr00J7Z0YwjGNyTyDF9iVP
	oX3yJHFriG/VbFp6Tabs0q2N19fE4OGxdJw==
X-ME-Sender: <xms:r6l8aukWD_SqTkEtRtxqp-PaKiLTvViqTxmJi9nqbOF3HscAk1S6JA>
    <xme:r6l8aivs6yyqnStvH2VfD1XBjzsmntp-2_UllKESB_JyMmmu47kV_K3FL241K2QsZ
    ru0G2GQNrq0EYR4Sg7e5Y8a4a0wd9fWqlzmW8n7ah_LZypD33beXw>
X-ME-Received: <xmr:r6l8asbl0iXqG_O2hT5z5-yc3ofXEyP3w2huncjTOlsBAvevkD0kf85bEHBeYVuYpDSuap4KeuJ66vuX3g8dFW4h3FD6hCmV7w>
X-ME-Proxy-Cause: dmFkZTEw6CnMyY4w34JMtF/zJqVBa+8zbRo8rSBvWBKLiRTvQQs5b1/xBX+wVzoeIb7ypN
    JAUAxV7qQft/w+fyxaz+HSW03nhXuE4SeiQPIueKdA0Wl7MOsSd6o2o8g1CIxyg8UO95Op
    OajRCi+6Z2ril55Rx9NehKf7EBsmrrgxqcfw7nQ9paB/27YGevLAj8w4BcO9EZp2vPK4nG
    pDu3ENpQDR/wxpcQzSj8EOdoRRAUraWWsLYHJiWj7IR8ekWm0acMDWfNewwR1gc+n9DpgZ
    0RN4MKGi+8gbGmieaoskatTnJ7cgEsW10KkDtB0fzdscCVr4velsayd097cUTLzCWMLHrz
    uX3fsctWsHAPNhyou6CWdcKSWSBU7mVuXFmoempkhJFYZ9IhVGu2DvvQ5r9cN2kIklbeHg
    qw7alWpfG72k+9T06pzNcQtC5gqBmDlYUzJrR1DuLOTSmuK8u+Siek5xuEtpcV9fI4McW5
    UbvXkCzezhd6bPvEAdTcwe/JGgoObFlAIVxPDMpXzDz/dU3RUmEo8efNQd2JB0Ds1GomlF
    29o517FPyhSstqC6ARG98zLTpEP98p0Du4A4KS8ydipxRpNI3yqMTn6mARnKBAL8J8Behi
    5IAzrbAU4UVh+SncMZRtbpEzhzaPla8yENA6dsJFtSkj8vGBdFwFjnSi2BNw
X-ME-Proxy: <xmx:r6l8aiDpQ50PtQ5TKqSWwpXHkJn-zQ96SGKuM2LICZAwdFuV2iHmKg>
    <xmx:r6l8as-4frTWc4kWvlko9aTu8u_IaqwzxBPWN0FaDIEqyu0l6HDAyA>
    <xmx:r6l8amSm2V18MyC_wIn4kWfWAH4mYd7H3zj32ShtEZhzMj8Ef3QmNA>
    <xmx:r6l8aoWXJRVW0Nqz0iFpWHl_4aoo2G98CvV2bJnNvvFs-9ls5wqgYg>
    <xmx:r6l8auV9qulCofh3N8ehPjnOJz6TNXGWbfSrhXGL_3zxDH3bSp40oCq_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:13:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git: avoid segfault on "git --shallow-file" without a
 value
In-Reply-To: <CAP8UFD1BoXTo-bNyaQeWeC1QhrpdBAOOW4BwXCi9XYMr7aRuZw@mail.gmail.com>
	(Christian Couder's message of "Wed, 12 Aug 2026 18:15:42 +0200")
References: <20260811121446.2080190-1-christian.couder@gmail.com>
	<xmqqcxvo1n8w.fsf@gitster.g>
	<CAP8UFD1BoXTo-bNyaQeWeC1QhrpdBAOOW4BwXCi9XYMr7aRuZw@mail.gmail.com>
Date: Wed, 12 Aug 2026 10:13:18 -0700
Message-ID: <xmqqecg3xnwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Just being
>> curious, because (1) if there are, this addition belongs there, not
>> here,
> ...
>> and (2) if there aren't, this addition may not be needed, and
>> (3) if there aren't or if the existing coverage is incomplete,
>> perhaps we should give a more complete coverage while at it.
>>
>> With (3), I mean something along the lines of ...
>>
>>         for opt in -C -c --git-dir --work-tree --namespace --config-env
>>         do
>>                 test_expect_success "git $opt without a value" '
>>                         test_must_fail git $opt >actual 2>error &&
>>                         test_line_count 0 actual &&
>>                         test_grep usage error
>>                 '
>>         done
>>
>> I do not mean to say that (3) is my favorite among these three,
>> though.
>
> I am fine with (2) or (3), but they don't seem much better to me than
> the test already in this patch.

I think this is the case between (1) and (2), there is not much
coverage, and there is no coverage specific to "git potty" options.

The 't0041' test is a suitable place if we eventually aim for more
complete coverage such as (3), instead of piecemeal tests, such as
'test --config option with other config-related things in t1300' and
'test --shallow-file option with other shallow-related things in
t????'.  So I think the patch is fine as-is.  I will just leave a
'#leftoverbits' comment here to remind others to consider whether it
is worth extending the test to cover more 'git potty' options for
completeness in the future.

Thanks.
