Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04B18C36
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240317; cv=none; b=T2+9Nwz57VrnYQeZoAgGKEP7X3yPM2Y3qYIqY90w/TtcFH+y1cN02sQ8jsGZiIgF/2q+9w5NtNGVjJnKcY/P2JdPUDj4JOX9L/iR3q1E3aA6NHbS1PWQCjrVj8qndkYwHWGYFc5AR6VNy+Y3OJ/d6XkTxsg6+qHfAGMWrRcp8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240317; c=relaxed/simple;
	bh=AG2MCNncc6T4jCD2gu8pOpqAbWwEn5/zDDusxMVUwxk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fvN/FfdM3PsWZBKKML2rcfiUZs5W2tuCp3ivCuwTgefhjYVkwz2jx8+pcg0Q+xGe1NwnkWgnoxE/1/QhWVp/P5W93yIBBwvdQ9LWJgCr07J/+f+cJAuR9p1nxKta7S47Mw2fcyhUfcUMMNLhL+FoKFEI1fDSdrfRKVvdhj/lyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EunkUck8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EunkUck8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so21965815e9.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240314; x=1726845114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7jbXaRjRs6342+JpXckajPFfNx/nC66XwXy043hyxg=;
        b=EunkUck84QWpaqAYGl5OvvfOfARVcT0SUtRfK9RZ8glue8StFYGQlSfJP0lhElfIkR
         6u1wbChpwUBm4rxY3Zq2Pqw1L/fwKazFWSXuuYAdO4J6rSoPAL0tfbxGqpCFFVyWW47F
         QOcOqdMhAjiS9B1t2AdwGqSAwTe0mMrPQ7LYTB2gAIYcQGzpZhZV+BiRygggWr070Q83
         glYy1CZxuhO8tzzPvB7AAgBv/oh1XFBrbVXMWPhhPZSyFBNAi6a1++DQuqILLkNll17C
         X5GrxsXGQDMhY6GEkFlvokpursYNLU6Fw+J0+eelMQCjJ9vqFuVL7UM1Bg9XC67ScXem
         4FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240314; x=1726845114;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7jbXaRjRs6342+JpXckajPFfNx/nC66XwXy043hyxg=;
        b=lFtWP/yD4LO2fgImh5pRXjusMwglhLW/08hVjp00bEMySx0tE+VVhru38A85TUhm2p
         /xDyRlUqqiLAtdG0SGYL78AkX2u0KM3H2XS5ODo3cy8VqJUU26DoStB8zV7AMvU8XHK9
         ASumo4E1YITBv5SQwZSYW+jQFPYIBxZrTYbSrsEo8FCdj/cwrjCtLm7IQRqJxeh8EWg4
         Uk12HywUrJwIMu3LH23NHITWm6y5L9uQU+KnKuyoRdmLNkj/TciQYaIN95hYimD1OJyX
         rWZUAowfvLcKTDVUgri8WwSzPt37RLSkdsCYJK6J6EdbtBGVpjK+720hkMcrfoJ79g4Q
         rL9Q==
X-Gm-Message-State: AOJu0YydEpTGjdWoMqYrRahYhdidc4X/BIoKcp0awHV4q35VLux4Ro5b
	m7ZzWeoueDWV9WSV/PbSuGxtcgBXhIcswVzKC+wP9jDUkYpgUYgc
X-Google-Smtp-Source: AGHT+IGHsZKiqlGIf2yhSb/xrtcRM/ukmXArdMi2992+RQxfhXFTef0jLNGcDXwnGT665LFhV9DByw==
X-Received: by 2002:a5d:4e81:0:b0:378:90fe:f753 with SMTP id ffacd0b85a97d-378c2d11838mr4433654f8f.28.1726240313833;
        Fri, 13 Sep 2024 08:11:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:628:b501:20f0:d089:108a:54d3? ([2a0a:ef40:628:b501:20f0:d089:108a:54d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d2ec2sm17323601f8f.75.2024.09.13.08.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:11:53 -0700 (PDT)
Message-ID: <acd287c8-990b-42b7-85dd-a206a887b8ee@gmail.com>
Date: Fri, 13 Sep 2024 16:11:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] remote: print an error if refspec cannot be removed
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
 <xmqqseu56hhb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqseu56hhb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2024 21:52, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>   	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
>> +		error(_("could not remove existing fetch refspec"));
>>   		strbuf_release(&key);
>>   		return 1;
>>   	}
> 
> It is a minor point, but would it help to say what we tried to
> remove (e.g. "from remote X") or is it too obvious to the end user
> in the context they get this error?

The user has to give the remote name on the command line so I think it 
should be obvious to the user.

> The reason why I had the above question was because inserting error()
> before strbuf_release(&key) looked curious and I initially suspected
> that it was because key was used in the error message somehow, but it
> turns out that is not the case at all.

Arguably we should refactor this to use our standard "goto cleanup" pattern.

Best Wishes

Phillip

> IOW, I would have expected something more like this:
> 
>   	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
>   		strbuf_release(&key);
> +		return error(_("failed to remove fetch refspec from '%s'"),
> +				remotename);
> 
>   	}
> 
