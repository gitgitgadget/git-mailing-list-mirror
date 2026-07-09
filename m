Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CE2E7394
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615266; cv=none; b=B5gMv0nddFBGULIq5W7xEvo5CietzEIUN7VU9dahkKbOK9suL7cJVVK2qBJLKQZWFBaQdSulTnP0yOXCq+yumMXhRg+CawNjT9O4MAeAoeG/yzM93Y/49NeI0qPqvpayXEsgEU8kciiH96eEP7hZqh9kMRwKqRA55R21budpOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615266; c=relaxed/simple;
	bh=ZuSuO/pOtw4zwqFpdKHhExJGmB/vFo+Fc5eHYzZCRv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxGg8YTOat1yiN7/3dLGs0DYEXCsgkU1RL5vAsG5FbeagUwzLBMaDgEKHxbU6ZCV+Qqe7HwalDxE1phN3pgsSk/JMZOM3qce9kbBOTlLB9z+jzEhj+UHKwAi/lB5vBdkGI/BAQ5nN2yWhvMBR1rUVb3sUttlrgLWwAxiodVQE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RrRiLCq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFg4rMni; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RrRiLCq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFg4rMni"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A065EC022D;
	Thu,  9 Jul 2026 12:41:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 12:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783615264; x=1783701664; bh=GPnATdNsnN
	sZFzjWgjxKV4PqKfXoOb+LltzHPNgKu+c=; b=RrRiLCq2cpU8PHr7zHTktNSrWG
	RtCl+xEnvz/p9ijeoqLl7r2xBMbtYLXRTuGmOguzI4IMW+alecjUN19zYjHA6+aX
	0zF4z9AGRXZUwMKD/1aRj1tbq8CCljr8he+9c5cPeJsxnRGJ2ZGFYQTZblipvsyB
	h1LICqE72jN5z5ZZzT2yW3t1SOJjfv1WJ63lIheeXhQ87r2191gfrVnS7i8vL6R4
	d2lEHPb/krPyONe9GtAOpdr77x79WZTSJdQtPcfdJy9mvSVJZ9V/SU5ZRSzFYrGg
	CASL0GIbyIhzmjNjnHn41gxE7YjbfV2Kz4YlsQhpnRGvW5If2JytFqjgbpqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783615264; x=1783701664; bh=GPnATdNsnNsZFzjWgjxKV4PqKfXoOb+Lltz
	HPNgKu+c=; b=ZFg4rMni9zQtozYWM3sMg/Ni5N8WL89JWDFQLP8xAICjXg+40cD
	sBy+qIcZ7tddume0gAm+U67clK9jGND1hTP/6tXFu8RPGk00KRrj8vEMDrG5txs8
	Vluum5P6cR9i/TS85csrgqcV6uvjKUXCEibn/xhZEIR5xCSK2q1gp3XO40up/tnI
	tXGcO56Lo+o+7J/pEL2wPfSorHcyv095JJRa9IeN2zsLroemaL7RG1rpNhI69mXb
	psjxgayG4+hgkigd6SMC4yX31TjPc8cnnkn3Uog4PK0IQytmcwG7aM1LPfCmPu/Q
	zXeW6PxiRJWZKu7COQs44KUUvVTyABRxNUA==
X-ME-Sender: <xms:IM9PamAW-djFDBCoxfEE-tTOsgJImV-nnSJaGFmwezm4IEaTGuOHsA>
    <xme:IM9PavnBEZv6rvfwsQI77lE7TnfvoqaXsmWz_5UCN1HSgwHBgYVgKasTvt6muRFb5
    PcucZ7-tNJhFvT8vUaX3i2D1JsM0CYpuJgr02CfbEAgsgww5jypbg>
X-ME-Received: <xmr:IM9PavwK7k3x50ibs9p3lCYWhvd0VyX_2wTRRZf9bCrBq-3ejz5Pdoo8MG6YgyonYw8PFJ0stea_nnQKQonXaKoy3yJauUawGKSzne4>
X-ME-Proxy-Cause: dmFkZTGPB+ho28PO8utvkIpIOEf/iIPCxlC8BwIfmamiWQgHBwkh/e8sn1hFT6W5NVEhjt
    MECRUAu/ZXX2TJNIc+7wQ1T9Wu+L3ocbIqei3jVwd4otqCm2a6lBJov/IrSW3jF1JlxKi/
    9rlGFc1lHZCAX0EkxSz3iC5NqMgNreg7xKp8mc6g+FVdFdMcaniZUMYFwWh8ns1m5pg/bd
    9+Ng0FZUSwjhKXl+eeFzZuiA3LIt1R9+ggMw0eQSV7Dixp9tVahw/1PAS79DS1dRm4Xa5t
    MRwjX04GDslx18RaqW/8VjCTJRkxn5bKqIXybcG6OQgghL2jIHUaLRrHMhNAuMAWcBk0ln
    jTgQYKOTSEYLGTlDKLs4GoF9bx+Ndw+bXHGm5AbxMR6ssysTOLRM6QMkxqhHGpPqH29ulw
    2T5X6dbZuuCHV/XSuqfxw6IYelbcLflGj8umeew4X67k7rZ5Nb+JbgxZQXbnkmbzaJxF8M
    bxFlBMtNryY0DPm/heP11aUuM0B1TLWolOKi7yLvAzoQW1/8vv6leH8AWSrnDbpOHcyHSG
    pvmuQ+JlSzIJ/UsH4xWRiHpyv8HaUuRcQY77lDSaIw+rp+S6dZnjeHVW3wrVrDVcREZuj1
    ENstcAKG8GTRVZub32BCNtu3RzhscY443mXpmZLNHMPWukygZZv6w2+tlyhA
X-ME-Proxy: <xmx:IM9PahQzcin4VyPhrMlp-JyabC1dLsWLR2K6QZJFEL10sQKVJpre2g>
    <xmx:IM9Pav9FMtb6WEfNO-1g8wyQjImbrCXK9LMqbI2x_ExLGPYj3w2_rQ>
    <xmx:IM9PanvlFuhZFSIPG-2ezv7bmPjnnTj34eLZPDIMV2R2xCdhmagUsw>
    <xmx:IM9PavOHEx7VMQLZNlWye8zQ8dmPoQnmHK_sXWYoi94jw2_3UPYKLA>
    <xmx:IM9PajtSJfcmyy-439kwoj_TXG2_MWiIVrSZjX2XM_yImvbH1GG-uWqo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 12:41:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  szeder.dev@gmail.com,
  Christian Couder <christian.couder@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v8 4/9] environment: move pager_program into
 repo_config_values
In-Reply-To: <0da20189-4e5b-4af0-b504-e99ac16d40af@malon.dev> (Tian Yuchen's
	message of "Fri, 10 Jul 2026 00:12:41 +0800")
References: <20260706142530.3681520-1-cat@malon.dev>
	<20260708160300.8852-1-cat@malon.dev>
	<20260708160300.8852-5-cat@malon.dev> <xmqqy0fkq0nw.fsf@gitster.g>
	<0da20189-4e5b-4af0-b504-e99ac16d40af@malon.dev>
Date: Thu, 09 Jul 2026 09:41:02 -0700
Message-ID: <xmqqpl0wp141.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>>>   	if (!strcmp(var, "core.pager"))
>>> -		return git_config_string(&pager_program, var, value);
>>> +		return git_config_string(&repo_config_values(r)->pager_program, var, value);
>> 
>> Isn't this still overwriting what was in the .pager_program member
>> of the config values struct?  In check_pager_config() below, there
>> is a free() to avoid such a leak, but wouldn't this have the same
>> issue?
>> 
>>> @@ -91,10 +94,10 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
>>>   
>>>   	pager = getenv("GIT_PAGER");
>>>   	if (!pager) {
>>> -		if (!pager_program)
>>> +		if (!repo_config_values(r)->pager_program)
>>>   			read_early_config(r,
>>> -					  core_pager_config, NULL);
>>> -		pager = pager_program;
>>> +					  core_pager_config, r);
>>> +		pager = repo_config_values(r)->pager_program;
>>>   	}
>>>   	if (!pager)
>>>   		pager = getenv("PAGER");
>>> @@ -302,7 +305,9 @@ int check_pager_config(struct repository *r, const char *cmd)
>>>   
>>>   	read_early_config(r, pager_command_config, &data);
>>>   
>>> -	if (data.value)
>>> -		pager_program = data.value;
>>> +	if (data.value) {
>>> +		free(repo_config_values(r)->pager_program);
>>> +		repo_config_values(r)->pager_program = data.value;
>>> +	}
>>>   	return data.want;
>>>   }
>
> Nice catch, sorry for missing that!

You do not have to be or say sorry.  This is a team effort, and I am
reasonably sure that I did not catch _all_ similar bugs in this
iteration.  So before you send an updated version, please make sure
that you just do not fix this one only and be content with it.
Instead try to see if there are other similar issues and fix them,
too.

Thanks.
