Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF33377A9E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270477; cv=none; b=hc4Od+nZjvWVwGUz+MrESEzkPIdjLEYlpNq9Qqi98ETFgWgYTAXztp2HlhNNBh8I58MhzGpAnrIKdySSRt1TTH2nIdXHusJEH3KU57NPW/zMq2prTwM3vkJ3UWdhugoomla+7a6WU62P4yCvv9hsmQmsb/pfP9JUJHaIqP29XWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270477; c=relaxed/simple;
	bh=C2PB3YfNQAjJVNVW7B7IS+6x3i9NK6/Dl0P1m/MIBMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IRyP2JoSEgxnVnPSF97hztJPjjQWKGLXuA6W4Uq5ZD97CUKzmm5HByREKYxIPl32kPidl57lKZ9bB7SQLBT4zvFnz5jq2DWRJJCbhNNx1EGfDCEJlCCDcY2noZ6D1mp7KKv6gG8H37T2Nm07jMiXLxfexV85ZoeNvDSfIbPkJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iRprWah4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U4y0Vaa/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRprWah4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U4y0Vaa/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D44F1D00095;
	Tue,  1 Sep 2026 09:47:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 09:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788270473; x=1788356873; bh=3dHDS1KsUI
	ZYlHFrRPn0H8oYbcu8Mvnc6/H+MfAx6rE=; b=iRprWah4fw9xKXMHuxAgGI64WT
	LqfnhcYivQRDcJqgrpx3mhx62EBJXM9gzTQM/KbUOu2MwF0XfyvHpLU0IyDT+5S9
	afqBxtg7XnT053INCvEGU31z762gmvB3ddx212EokIeQwAfn/fj7WXuNyyi2gFug
	DmAXoVlwDXWBut32KHVFfKJeZ5j6LGMujRYK/3XFfi5yrM7jBjIJXAbMbENz0V7r
	VP6p5n3b4dKB0QBdOgi0bvEL7ukKxDjA2CkxZxJIPsBuEw20zzTzQKvOn3LsMB+y
	7JHB1GI8q9mD+EIH9tHDJpt0azFyiMmWYJdavzKmg+3GyZc2UM3r9W3Lbh7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788270473; x=1788356873; bh=3dHDS1KsUIZYlHFrRPn0H8oYbcu8Mvnc6/H
	+MfAx6rE=; b=U4y0Vaa/Bx1iq3Aj/0EPIPmQTcq4vSaExCPA6LIdugs0LTlJSu3
	2q9UDZXY1b74m0S/Gzt064tCnrn0zcCmyA/RWVTp5hfe8K7IReickHaoVEzaWoBE
	Hm/Ew+h/YLGRJ9voSRC62M3KeB+6dVzAWMgsKnd4O9nnygd7a5mRpIBkcwfTOOuE
	qgz/xd+JWEw/Tcf18dkOzbVm5Mcahc6Fjgtm36ZXUIdm6kK9/ulIJWJS7zeU42aG
	gPuO1IMi/5ZVkvvgKQcqeFUqH935Xxdf7KmKK1n6jLhHfIA3pAR7Szw6CJPvGILH
	PX4sSvkvYI9K2fSDnwCW60TZu7cfHkXPYXQ==
X-ME-Sender: <xms:ideWancOSjI23bnc7P9r1D0245o5AafhZ4Y2HT2xkzF4LpCxHhsurA>
    <xme:ideWag5UrHGmF3fhsEj4vgS5LYHjinqnKRDCwvJgyCWgMRTOtxyzzbVqlbpXyzSz5
    imB3EXwYS1beKKEv5XvQjy7l0uOuJ3bjfjzSatP6DgSu6xBMOeIhcg>
X-ME-Received: <xmr:ideWaqW4jyPDezFCT6tmsMwlcMGVyi68oJAFeIgcAf4cPkFxZeFL4VdjyoaVlEF7KXvpn665kLblB06E6IN8ohPF5uc7eY8YBQ>
X-ME-Proxy-Cause: dmFkZTFBRy2RAsg6alMnHtus8Ty3VOjD90csj6KvGxIlm1XpfRpHXpVF4W6jpYcmcPzov+
    xNRdNc4fwBBSxu+agb7TMt76uH4WvQmi+hrYIL3Sv4faz4U+R+2F0c/nysybdYSw9p4PfQ
    h/bI9e6vbyZ++JmOmC1n67dpFFvKpxk3mKd1Jq3Ru2LWQeFL/QdaMJ8d6YKIOaYIBg8lGZ
    dsmPiBvC/gUM4xy4BEkwGmDlTpSg1jXPk4MkEwobP3VvDM4ESmZAQXcW25z73OV5wpeROw
    vFa6l8Gp7qRZLT6RRb23hswcLOwNYnURwp6BrmDm87t/cLS2aqz0uiY9iwwFWn/pxknQh7
    z8SFEx1+r6j1pJ4VAT7TJYGaduo7pItBfnIV/qaZK38+ypb+wWio5nDEIq5Nokx8KbLRx+
    AEE198Gs4/vH1/Wdrnd5UJOirc4pFgDF9DRL0al0fmjCu8vOdEvMgTV8LrpyU8iJ4zyKcz
    44cuANYkxyLcvxADMycArt6X/U8uP3Ij51vByDsBHohPV8FaTbRPKFzReKgIt5+LAAPrEF
    yYfQs4lzfD/wzAhIJyKwbZxtcPDvm+tgMmsas5jiG0OUheMl/SCU3MFWzG12GJ7ILVTIXB
    hdhWECM+S4R1eZomXLwndw3GSvMaD9/5KPvHgFttoNxHa5W7s4uMnAJ+KX6w
X-ME-Proxy: <xmx:ideWav5LH3Y6wHr-ERX6CCj7kqhyzuOY_QqfFyRb3gAeN6RU3HG_0g>
    <xmx:ideWalpeNyJxP2ywuWDxwfrsX4byGVmNYhCg0yfQ6Jpe-FI5ucRjxg>
    <xmx:ideWaikngOZlTwaD1SMF5jIdcpJW6dE_K9RheQFss0qtfZOVcKHnOQ>
    <xmx:ideWahP5k_2EudwBX5AThik_s44oWM77jT259CUxrVv_8B8C7_HthA>
    <xmx:ideWagYtrQbQA_YCAq2hwVbYFd14JR72lpLlLAVuQ7P9ePK7dZlB5GIB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 09:47:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Gusted <gusted@codeberg.org>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <87mru1wcyi.fsf@emacs.iotcl.com> (Toon Claes's message of "Tue,
	01 Sep 2026 11:14:13 +0200")
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
	<20260831-toon-speed-up-last-modified-v3-6-2bbb864acf93@iotcl.com>
	<xmqq8q5lvc1i.fsf@gitster.g> <87mru1wcyi.fsf@emacs.iotcl.com>
Date: Tue, 01 Sep 2026 06:47:51 -0700
Message-ID: <xmqqv78pt75k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Toon Claes <toon@iotcl.com> writes:
>>
>>> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
>>> index df73c7d0d0..75b18ee83b 100755
>>> --- a/t/t8020-last-modified.sh
>>> +++ b/t/t8020-last-modified.sh
>>> @@ -290,6 +290,32 @@ test_expect_success 'last-modified with Bloom filters and --show-trees' '
>>>  	)
>>>  '
>>>  
>>> +test_expect_success 'last-modified with Bloom filters and top-level wildcard' '
>>> ...
>>> +		GIT_TRACE2_PERF="$(pwd)/off.perf" \
>>> +			git -c core.commitGraph=false last-modified -r HEAD \
>>> +			-- "*.c" >expect &&
>>> +		test_grep "data .* bloom_queries:0$" off.perf &&
>>
>> Ah, OK.  With GIT_TEST_COMMIT_GRAPH=1 exported from the test harness
>> environment, 'git -c core.commitGraph=false' would not be effective
>> here.  You would need to do something like:
>>
>> 		GIT_TEST_COMMIT_GRAPH=0 GIT_TRACE2_PERF="$(pwd)/off.perf" \
>> 			git -c core.commitGraph=false last-modified -r HEAD \
>> 			-- "*.c" >expect &&
>>
>>> +		GIT_TRACE2_PERF="$(pwd)/on.perf" \
>>> +			git -c core.commitGraph=true last-modified -r HEAD \
>>> +			-- "*.c" >actual &&
>>
>> And in the case where GIT_TEST_COMMIT_GRAPH=0 comes from the
>> environment, you might want to be explicit about setting the
>> variable here as well.
>
> Thanks for this suggestion. Yeah, I didn't notice it makes CI fail.
>
> But a little bit of a followup question, I noticed I also should be
> setting these in [PATCH 5/6], but test don't fail if not set
> appropriately.

Yeah, I noticed it when I queued the two fixup commits near the tip
of 'seen'.  I wrote it off as the test *not* checking everything.
If the test is about what the command does and not about how the
command exactly does its thing, you may not notice the difference
as long as two code paths both produce the right results.

So some tightening of tests might be needed, if we care.
