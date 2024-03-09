Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D747A7D
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710011721; cv=none; b=u12KIoNKOmj7OIED5N/mIUDEMKHzT/bPR3/op8O8/99Si54nBEfi4Epm/jcbyNegp7ia0/beErMf+yY2Yu7dvCUqOM5cFqzfz/70tJJuZYUSVy4Sxs6CuQDEjBfmWwoKgf1SerN4ac3Oe8egFhh73N+GH8QNOK7oHehz1HdcP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710011721; c=relaxed/simple;
	bh=wiTuF8ihD75U8lYT5+Z92TUTGTL+CrVEti5vg0uHOSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4JEtZIh0sAO31zfrWRKUCy+N193kcbj5fgXyVQNq+1/ku/iZqwhFHMJH4WsotOLUFZxReFla3AMknQ2mdVAVZmVtGBKIqJgCvhyRFUb/TT/gvw66s99yL4MA2chHwDsZLeRWS2G0T5mByuEHk63tXGHduN5vCcVrLzj0vHl5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX7yum/N; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX7yum/N"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d422b6253cso17162131fa.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710011717; x=1710616517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oIpz12pbgjjet7fGvuXOmPIjt48iYKHOFPTgAnTAwzM=;
        b=RX7yum/NVyTpYnltaXH29l9bbspi05FaLycdVV59bSe92ZkwDeSyYRmi/sgPnA+Wyn
         i4QWVgUhmbu3QM/7XsEhHl+NyvlB76QuC9wibPVcG8eNQCz9Z9pyLV+UTpMIEr6tIpv2
         UgrRKx54LSCLLY7Mp3RpvJOPd0tAXKw+r1k077hucosJg8HwZziD1zjsgAO/uMdc9bRt
         NCFMptmaLpIdA6ymImq3HzlpOJ5HFZKPAFBes8O9Logyz1NbAXXHAUjHiJOzPa49Ad5V
         dyJoEhzh5jfDwivDp3rx8tmJ+Z7Yugq0ebaZ6ATitHV0umznxclNElpOGH/7FzBvmf8l
         Th7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710011717; x=1710616517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIpz12pbgjjet7fGvuXOmPIjt48iYKHOFPTgAnTAwzM=;
        b=UmZSUG53F3g9nksOF2WAe7k12Dm5ArXJv57XaiTSCiZMOpKI+I6T7n6b1zpjOxn/k6
         u+6F47ky/6AgOFpvZ/B4H7ybrdrqgsFYWVKL1Picf3nDmPH4dREfqdRP+oqnMCI8pP6m
         sBUJISxQu8oT9iW6SZDhBJVm77UpERLzE0jbF6VfazG/jcaCTMZb5zy427byllh+wpdn
         0vm/mtrJ+A0a5rUsKxbAz21QK4js6E7B1hQ+uAJPbWxeQd0Pgo7BzOTBbHMfJC1Hk0JY
         QF5Uwfo8mWqbpggHlUrvXjPKZO8T36WkOBbiiexu+0RtpSdkmCbf6iC+e8hqW5TBaV5f
         XFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/dmBI4Yne3VXqRMEfgZ5BK/EFSSq7YqqoJA+nTdmfFDBw85fY/RGkUl3xde0EYiDtbxMDuV626Xg3E43z76sO2jBs
X-Gm-Message-State: AOJu0YwXX6+ANJKt7dStQJrBGYnUw90OciQEbjGOZ7/zONdDj9TcKVj/
	ISEmBu2kHPjllmlV+3QVo+XUtCNGWBZFUyLQi3csgAMvVJnJq/oA
X-Google-Smtp-Source: AGHT+IG0pr8AGB28kgCgcsllTzAzRt4ciuLJn0lGk/0SVwIGSiP/SHCr8w0RPJ+ggsTpwhUQx4PpOA==
X-Received: by 2002:a05:6512:3488:b0:513:1cb1:fd9b with SMTP id v8-20020a056512348800b005131cb1fd9bmr1253480lfr.18.1710011717391;
        Sat, 09 Mar 2024 11:15:17 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id j20-20020a05600c191400b00412f016a151sm3412944wmq.9.2024.03.09.11.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 11:15:17 -0800 (PST)
Message-ID: <b52a8678-a13f-455b-a817-2df2b4fab795@gmail.com>
Date: Sat, 9 Mar 2024 19:15:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
Content-Language: en-US
To: Philippe Blain <levraiphilippeblain@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
 <6a31efcc-c6c2-4729-80b9-eecff4ec9e31@gmail.com> <xmqqy1axq3t1.fsf@gitster.g>
 <12c84208-23a7-5ba7-18a9-822d9a8f66fa@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <12c84208-23a7-5ba7-18a9-822d9a8f66fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philippe

On 09/03/2024 17:53, Philippe Blain wrote:
> Le 2024-03-04 à 12:56, Junio C Hamano a écrit :
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> ... So we probably do need a new config variable but
>>> I think it should have a generic name - not be sequencer specific so
>>> we can extend its scope in the future to "git merge", "git am -3",
>>> "git stash" etc.
>>
>> A very good point.  Thanks for your careful thinking.
> 
> OK, I agree we can make the new advice more generic, but I'm lacking
> inspiration for the name. Maybe 'advice.mergeConflicted' ?
> Or 'advice.resolveConflictedMerge' ? though this is close to the existing
> 'resolveConflict'...
> Maybe just 'advice.mergeConflict' ?

'advice.mergeConflict' sounds good to me

Best Wishes

Phillip

