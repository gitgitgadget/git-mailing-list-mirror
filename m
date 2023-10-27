Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F50156C9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crinan.ddns.net header.i=@crinan.ddns.net header.b="BJeImqbe"
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 03:29:18 PDT
Received: from crinan.ddns.net (unknown [90.242.223.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7DD7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crinan.ddns.net;
	s=september; t=1698402156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QvL1ZifEcXqeHJ7X2fiCFvLEE8BTXalnGg9vc3tMEs=;
	b=BJeImqbelUHGpcSMl3W0xJ4LzKABigR154hau1KDN8AzKQdqZNvK7vva6V08Tgub+VHWGH
	u5uS4WvNgMjb/zvNCE1NTtVBhjpV36miKbV74+q3IDxc3y29IWwm0ud7dStcbLiJrIIIZo
	3JSLj7IIGs0+W4K07ejJupyABaJVhI9tEr3sdHlw5G0qqbXHqLVouL+48Hw2lyEZX0uMaQ
	ZEYTWb+xM6bKlEFWvf91uMh6bvwJNae3oHws5B0G6kSTatfP4xFnq0chT/iT5IWjzdHeEz
	YiupaSFXvvEJHAzRiwujyGms5BJ+Dm95hRorKev7pMRpcbajLTQ/ABkU6zE4Kw==
Received: from [192.168.1.101] (<unknown> [192.168.1.101])
	by crinan.ddns.net (OpenSMTPD) with ESMTPSA id bb2fce39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 10:22:35 +0000 (UTC)
Message-ID: <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>
Date: Fri, 27 Oct 2023 11:22:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly> <ZTtyHScKkMg4qnMH@tanuki>
From: Phillip Wood <phil@crinan.ddns.net>
In-Reply-To: <ZTtyHScKkMg4qnMH@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

On 27/10/2023 09:17, Patrick Steinhardt wrote:
>>> +	CI_BRANCH="$CI_COMMIT_REF_NAME"
>>> +	CI_COMMIT="$CI_COMMIT_SHA"
>>>
>> assignments need no quoting to prevent word splitting.
>> repeats below.
>>
>>> +	case "$CI_JOB_IMAGE" in
>>>
>> ... as does the selector in case statements.
> 
> True, but I'm simply matching the coding style in this script.

I think it is quite common for us to quote variables when it isn't 
strictly necessary as it makes it clear to anyone reading the script 
that there is no word splitting going on and ensures that we don't start 
splitting the variable if the contents changes in the future.

>>> --- a/ci/print-test-failures.sh
>>> +++ b/ci/print-test-failures.sh
>>> @@ -51,6 +51,12 @@ do
>>> 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
>>> 			continue
>>> 			;;
>>> +		gitlab-ci)
>>> +			mkdir -p failed-test-artifacts
>>> +			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
>>> +			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
>>>
>> you're just following the precedent, but imo it's more legible to quote the
>> entire string, not just the variable expansion. the code doesn't even agree
>> with itself, as the line directly above apparently agrees with me.
>>
>> regards
> 
> Yeah, as you say, this is another case where I follow precedent. I
> honestly don't quite care which way we go in this case.

Yes, if you're following existing practice I don't think this is worth 
worrying about.

Best Wishes

Phillip

