Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890152DC765
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988049; cv=none; b=T9x53lSty+LFFJTaxtm3vELDYlf6TXPfUEpnQx2hWxoR54OBTzqb7S3GubhumRuRzJ5JvJ8q5KLC+UdI33zOpwvyOeqUwCYQg2UxK4KFyjg4trI2Ndraeys/kuiy6Y8W3zF9D9KQa/X5eb2ntNuAwiku4hjtrAR3hcLJrGOsHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988049; c=relaxed/simple;
	bh=JeXyqVWCnDhtNZislDLN+SlA+67BAvNo8/Pbb373Fpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgHRoidcOaMR8C+XnJL5YHSd/RM5PkNkB2ojVBqCtpPAtwG6hfHoW1yKd9ZkvOEFuZD6S/HxPdvQ7zGB73oL5cZU8mqi+Ur1Yh3RnEfCXMWzXTx/QRbe9LvjtRPs99jStJqkunjgbEmweNRyJ4omXrVJonjVyTvHM384HgFK5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQyu9kjT; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQyu9kjT"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70ba7aa131fso42742916d6.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757988046; x=1758592846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+8yIImkmep3U0jsr7E3K+2ihQH28BHwlinqsp7GfZ8=;
        b=PQyu9kjT02sdD6/CXf6FQz1L2dpUtFIsUJU+x0vU53lcjwwoDbA6OhWbKKZ99lMGTx
         HurFzRYpx7q72Bf8dVnjMc3U1SrJu4V87CFhFr3knnyZt9uZ0XmrHAfda/ldugdiJH94
         j1kaQNClwx0SjpWQxBOr5P+hL0uoMpYLRe2u8LJ66Dbx7qkPT03HLujE1MZ/4/lUcW0D
         SfmdpTf36tQFlK3Ta0RLxe1XaoUyq+KzWxxOkrZmMdhY282Dgo/bSfoxpeN9E/eXHVtu
         GTiClwyWHhNT4OEqZHUqo11eiOFIhFSp0uxLn7wdLZdgW2ubSR8t8J/86bXS7z/NTgY0
         Z6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757988046; x=1758592846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+8yIImkmep3U0jsr7E3K+2ihQH28BHwlinqsp7GfZ8=;
        b=Spd/IYZepsjonpVmnQ+HkXwCsJ4Nuu3H9bZf899w2CNzWluhEUPUivxJH2eTbm4huS
         wu5uefUBO64bF+VX6wnU3LSximRAUyc7xlM/lflJ4vnVpcjNxImwGM2nOe6Si8w/6zBa
         gRgX5Pq/6cqD5GntoI9MzhZlVjvXmviMSkdbgDoUmXYIsBAsRtrAox2wmEn1+8o5ltsi
         Q7aHi0MJXBJjhcx/efZWg4Z6uXASFvBVDq1Gebgi+qgPbNy0/p8bM73Vd8IAI4iUi2ys
         onUfsc/HFG3rtdn81JPAx1URwrLS8vWxVcpo+HEpkaOAFrwePLa/XvJFRe6KtDw6usOQ
         4KPg==
X-Forwarded-Encrypted: i=1; AJvYcCVsN77f1JQ6M3sRLxKnR4zDT/40zry6tVzLhzuQ4R3zjdrv6Q/ub7vveMYDNlRPs79i7MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9XSLRLUUligiL63Ir4wOIzInbjjboFlxljDTi2jeDo5VFdzm
	IHWX8jskWZjR8/4D8UPf33RxVbuh8AHPC3K61gLI83odKfBue+4XMbNI
X-Gm-Gg: ASbGncscktZgELhrzyMHeAfn9u7zVlFBKnNejytopG1oSsAPYP8nNpC0YNscQ/FvQrz
	xgt9ZCrbv/72fW0+M30T41u1pKf/hTVAdU7EqnPp38Eai+cKLwe/XzRQV44HmwQaVFkuyHTcMaC
	D7635uwartBlGixCFCY0RHawwj9L9dl3ZTzSgSgxLTwqrmtzH+/qHjWXB7ViI2C0q76oO6NSDH7
	pRN/o+Y77goQVq/t04Z4Lgyguaymtj8QckVNVyWsOB7t0wsAxHfYJwQ3vT7/cSHxf8QOqBDP/cn
	RCjFg/vQWxXmN4WEZH0iiSEVKbGCblkHihQUSHlnJfcttatTzMKD81q0TbGYifulCdFBKoJ2idq
	uIH9S5V1Fq9wcKvMkBr8awFMIxsOR6v1O9oD+BS4DR31MZiSrCuZQRHbp0f38qhW27bLIDwNwwg
	==
X-Google-Smtp-Source: AGHT+IH3DZFsDCb0ssv8AKI/WsOjbL/3LH2cGlqUe0QaRtk3W+pCptMAWwqr1U8Bx3sV1V2+pvIRXg==
X-Received: by 2002:a05:6214:3f8f:b0:787:907:d26a with SMTP id 6a1803df08f44-7870907e19fmr47252496d6.29.1757988046385;
        Mon, 15 Sep 2025 19:00:46 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:1dc9:62ab:6ea6:19cd? ([2605:a601:a6de:d300:1dc9:62ab:6ea6:19cd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bee7c80dsm85453416d6.52.2025.09.15.19.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 19:00:45 -0700 (PDT)
Message-ID: <9b001093-0d9d-47b2-be10-333534a748e2@gmail.com>
Date: Mon, 15 Sep 2025 22:00:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] sparse-checkout: add --verbose option to 'clean'
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, newren@gmail.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 <2cde464fd4c225144489c222537e5d7549f81849.1757673011.git.gitgitgadget@gmail.com>
 <373d3441-6489-4b46-bd80-bc1ad68f0e9a@gmail.com> <xmqq348nh6mj.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq348nh6mj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/2025 3:12 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 9/12/2025 6:30 AM, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <stolee@gmail.com>
>>
>>> +static void list_every_file_in_dir(const char *msg,
>>> +				   const char *directory)
>>> +{
>>> +	struct strbuf path = STRBUF_INIT;
>>> +
>>> +	strbuf_addstr(&path, directory);
>>> +	fprintf(stderr, "list every file in %s\n", directory);
>>
>> I don't know how I missed that this debugging output line snuck
>> in and stayed through my testing. This line should be removed.
>>
>>> +	for_each_file_in_dir(&path, list_file_iterator, msg);
>>> +	strbuf_release(&path);
>>> +}
> 
> ;-)  Don't feel bad.  Nobody among other people caught it either.
> 
> Locally amended so no need to resubmit only to fix this.

Thanks!
-Stolee
