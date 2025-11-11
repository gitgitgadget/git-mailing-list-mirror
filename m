Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D2A55
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871169; cv=none; b=qCNmiqCJ/5lJIwZpLFZ4257BCWk8iXNLYx2Dyfxg8lrDGbifBww2+eDDgNg2HnM1M9ftXljeXdJES+2WWLZ0RjJhrVuTTA/n8GxbRS8FVeq24Un/3/xz55bM5MYQKXd2wCR61Nif39GixTiPS0ykDCM/bUIMXaa9Dl+Fq1OsyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871169; c=relaxed/simple;
	bh=aCyODXXmTcc/WIvhguCt4kEm4VT7JMA2lBi6QSBNfRU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CSJc9IdwUAUDcWa+58yeiWzhrvtp9La68uwyN+O9uut/eA2f1RAmipqpQy+eurSGJ6+IkOTjBX82FAkrdsCuBa6OPFC0hSHEox7sruFm5mDX6O3FxS3H7o4+3/mZLHF3A4twFlv5jVXXb0034L5Yb4UIZpB7HNZI+vufQdodKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCRaO0Hg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCRaO0Hg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so1058856f8f.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 06:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762871162; x=1763475962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YMmZuA+QLkgoqGyTsXPI6zRMqTZB9tc4YNGPHuHG2g=;
        b=MCRaO0Hgb3umRo80nV7qCxGy4nh6PBWU3/TpNrt8aZM+T93lTvAArtpY8DIX8ZXGtG
         4NDpPeF+Y98tFrju93A9HXioc7pGYTVtZGC0Cc05axgoqTo2OBzQgg23yEGGVwTwDWPg
         spM88qZvxvFDpB+6t6VuXDM35RF5H4WtreZbAyazcIjeCbeZJxU/5alOtGzS0w7ofnui
         WGSvLhJW0yHSr1bci8ah2F2JB/hEFfxT08HgZmAx3enAg0OtoJ1IIA51ycggsVVvlThT
         M2VGGNyb3Zz4F7lG54QjIlxl6vdESv5+ojrnKgCrmD9CpWA21cJ53a2MOkl5a7R2dlhP
         xAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871162; x=1763475962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YMmZuA+QLkgoqGyTsXPI6zRMqTZB9tc4YNGPHuHG2g=;
        b=P+8Uvu5sm17SDRU5LAWELTxlV6eqE96zByddTFdFd9rkTNORJAU2JyZMYkFFm9w904
         aHc+vEthrmjtv1KwpCpJbd9mP8P91t1xQqyfL9ZTajUjkpSG9dGRbn7v1lvnP2ENDSP+
         wgRWV2zAIbtYNwUeUryDBd6Fsg0af/550JbtPWlIqTnF+to+5J4gwgx5+SAXS5ljaCIe
         g37BZScbHZdXQWGasJPNabLCL96PBQgKkOV0OMTGylnptyEH75AjbLj0TF16tNAK5OUH
         HoUeo/kFfnCznuraXHf+Y1J44171m2Fk/gzrRP90r9FR3E2EIdSF2a4t5+O7KSdokiXQ
         bvsA==
X-Gm-Message-State: AOJu0YzhxYxpjL0AHGx4SKnTHRWSej9uf4z/17UEXFDUF/W65DRH5gjM
	DZdITqgaWsfX9wOahrib2g4+E3QWhIq2q/tG9DAs/NYnV9M5GjY58Wof
X-Gm-Gg: ASbGnctU/2+u1Ms9a5gyeGseayMM5GowCAhXTggei+Ng3fQGi8+eIZQBPr5znvfmzi3
	j8bA+vFUK98HEz7dR3EEOr8um/cQh2VVoEeNWbAZ6oV4cVV9Nz9+AJfEWh155+ReGV3Y8IT7Fpo
	Ki5oRVUKjfX6mULT8uWIr1sFAXjtk2URdfvy6ShoPJ5HO6+8HBfaV9By04UyjswuHDYmSwt11hX
	g5YXUBuczrwcbxygg6cZJOisSpDIPrppwm9MrYTdzcIzRY+y05awMxM7QxdnqOfw1VgPVbdr/yu
	0ovC/nWSNqEbXY9ud86pyYmwEeXO/MU/aaKwZSbbtaSRW79sMJi6wTh80sGYtNruAO+VXyjbI5O
	NAzAXn+E3BVZeLSABAVdWLk2aGvqM7ZOXprfHimoF6ThHwIxjXsX4Sl4Rb2VibYSChDE7yflqjo
	oDbC7O1fVBaSW6g7TQHrot5c/oYp69D24MdgzYzxv3Sb3X93Y5LLl/RzVdU+0khoE=
X-Google-Smtp-Source: AGHT+IGdF2j+GKmhTME4lHoJOZWlFlNyXRm+5c7uFD2gqcW6SJ5tXKOwpWigQxwL+CUVBb/JCXINJw==
X-Received: by 2002:a05:6000:178b:b0:429:bc68:6c95 with SMTP id ffacd0b85a97d-42b2dca46c5mr10782735f8f.47.1762871162409;
        Tue, 11 Nov 2025 06:26:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm18429224f8f.16.2025.11.11.06.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:26:02 -0800 (PST)
Message-ID: <4506b9c3-f4ae-488c-988c-e12b2d95195f@gmail.com>
Date: Tue, 11 Nov 2025 14:26:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/12] diff: fix incorrect counting of line numbers
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251104020928.582199-5-gitster@pobox.com>
 <c41f3c65-d7ef-4e73-a1e0-03540df0b212@gmail.com> <xmqqjyzx213a.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjyzx213a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2025 18:29, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 04/11/2025 02:09, Junio C Hamano wrote:
>>
>> The "\ No newline at end of file" line is an annotation on the previous
>> line in the diff so why are we incrementing any {pre,post}image line
>> numbers here?
> 
> No particular reason ;-)  As I said, I do not think these numbers
> are used after these lines are seen.  At least this change makes
> these unused data incremented in a more coherent way than the
> previous one, which unconditionally incremented the number for the
> preimage without even checking which side the "\ No newline" is for.

It maybe coherent but it is still wrong to increment the line numbers 
here. To be correct we should remove the erroneous increment of 
lno_in_postimage.

Thanks

Phillip

>> Thanks
>>
>> Phillip
>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>    diff.c | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/diff.c b/diff.c
>>> index b9ef8550cc..e73320dfb1 100644
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -601,6 +601,7 @@ struct emit_callback {
>>>    	int blank_at_eof_in_postimage;
>>>    	int lno_in_preimage;
>>>    	int lno_in_postimage;
>>> +	int last_line_kind;
>>>    	const char **label_path;
>>>    	struct diff_words_data *diff_words;
>>>    	struct diff_options *opt;
>>> @@ -2426,13 +2427,28 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
>>>    		break;
>>>    	case '\\':
>>>    		/* incomplete line at the end */
>>> -		ecbdata->lno_in_preimage++;
>>> +		switch (ecbdata->last_line_kind) {
>>> +		case '+':
>>> +			ecbdata->lno_in_postimage++;
>>> +			break;
>>> +		case '-':
>>> +			ecbdata->lno_in_preimage++;
>>> +			break;
>>> +		case ' ':
>>> +			ecbdata->lno_in_preimage++;
>>> +			ecbdata->lno_in_postimage++;
>>> +			break;
>>> +		default:
>>> +			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
>>> +			    ecbdata->last_line_kind);
>>> +		}
>>>    		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
>>>    				 line, len, 0);
>>>    		break;
>>>    	default:
>>>    		BUG("fn_out_consume: unknown line '%s'", line);
>>>    	}
>>> +	ecbdata->last_line_kind = line[0];
>>>    	return 0;
>>>    }
>>>    

