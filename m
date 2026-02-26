Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C043368968
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122197; cv=none; b=rw4MMJaNk1/IlE1O57nnyojX1Yz7iHsizaYYxf902cC8l8fMlAq4cv+lR3u1oUhaQOAflB10fDTyAGb7hCXL8qk6miIQQNizsE6U0AS0VSQ4xCVbycnZRc/m6E+AMyFdrQ8OW6boKa20x8tVCZbnm5+DESG/W4Jg8fPBzBjYVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122197; c=relaxed/simple;
	bh=r4TJKHvY0Bn4gawH3178cleXTUP402J39ytnHuG/jqY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LgwQnYOxzpduxYfvZFr0tMmxDtZddZ8NhwMV3I4gC13dOUK10mgggQfi/n2tCyueK+kbsfHg9Tpf9QCMIq87ko5TDn7KnIr6b38X017rOHJwmpTsqHMTnVRIOhoUhfNgRGTwCsagVTCs9F8mHi+DIcTGChFYChaxbAKg+XegCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7WIDhFV; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7WIDhFV"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4398e850783so750052f8f.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772122190; x=1772726990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/60EvuzKjyIP9JGI1fM0uO3d/eBwYoRpqhTXbLkheI=;
        b=i7WIDhFVe4nZ90vm8sLILhNRBs6aT2kUTzCTzQNoBDLAzJ3lwOiG8IJw7A/9hzKUzD
         r2eX17C2R7it3vOmFV48RJGvKEiHEHxBHGaYnEk6P1Y8DVru+H8DN8Mfe4zDOolTf67J
         0z85ctV1jFbIq7TH3DXt89jq3aXIxbQnS6/7AfmDR0BowGT2oo/1Z0tF5oIcWEovaqSy
         mh2nIpxeUtboYuJsveF7wQrI7VbZMmfijJdgm2WQRe5zt1Gp3bY0IXiRn+RNMCHGQEu6
         DIYOeE66jxQ6EbqHqGqRU0Vaasf0vfi8ljRV/ca0SpTkfVe2KLtIVymmqicl/K9SmyiF
         J33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772122190; x=1772726990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/60EvuzKjyIP9JGI1fM0uO3d/eBwYoRpqhTXbLkheI=;
        b=t3gF6nuOiM9rlxt1F5qbIthUsAkgxm0efeUWkXPFlg8vLXRImXrdf0QCoPAQZgTQ6j
         6g/4Zs4J9XelcmQhRxfrAlCdaUjJN5uK1Jy8zXFNOsjOjr3XoiwlcTEUKjKnRFo3HqUw
         ZffrhT40dITpBK26tpKQE59NkvtT98OiD7zsOSPfEbsZVujCSR9Oc16BnKbolL5s+VsX
         smMXDocY+JAr2Gy8cXMNV+iFHVHPEnc1JKrEFmM7oDgFLXXQbu1sHFOgn6SqVhm49pXh
         7js4cdNOMEAC0hinESogK/n+Nes4ArvB1uYT87m2gt/TrVSFFJaLGFJvYd0AgSgpzvO5
         QbYA==
X-Gm-Message-State: AOJu0YxJWqHgvMmiMI53hIJ8xuS43E6uU1DtRF3kzmu3kVVe3MTKAhKW
	R25vOyWO508lNQwLrKFq+qm2yKc5KULl/0Txf5IxBWjGZWMjFzfI/1nS
X-Gm-Gg: ATEYQzxu3T3bFmJ7kHXqk4K04lcd8BbAkA9nudXK634621MEnvFSyulIfnFtY+z16bU
	Bq5EdaACP84ixsvLdsFUmEFSTckAXzY+KYsZf5ll08HXHvb/iusoMMJX7P1JsfyKLEz763f2Ihe
	rztbnJSzge1YYmFGrhDuRnpficRRqzIqtG8NSUQ/13AxYGLSczQiz0VQHOYgM2nqowEgwgyGnAr
	PgBpUWOupgCFN+vn/0G+rCPhYFDqODw5OhfSw8HKWaM4vLgjJaD7lOWZEQnAWfPqVp7432Pu7NH
	7vy7MRHubuHZBA1UpXTj25QZoFgZNMmI0ZD8dXLUAiFGL/QIJlk7BGhkzqPuf6fZO0ZtXJKPSMT
	T8fCv02AxCNxLU/u1idt4LT2DswM1qqqqms4YIddrmxaCe4gy+MI2u190/98CUPLUt1bXmJEu/p
	nsRH6e03uYhWdscO1fkSGXTIzEgms8iijpciOcYbXmOUdD9q/tlh0u4t0dvNhKc4lu/3rN7k07q
	fhDOg==
X-Received: by 2002:a05:6000:24c7:b0:439:8f0c:dcf1 with SMTP id ffacd0b85a97d-4398f0cde0cmr12344039f8f.33.1772122190322;
        Thu, 26 Feb 2026 08:09:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b327sm507177f8f.20.2026.02.26.08.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 08:09:49 -0800 (PST)
Message-ID: <d5866041-3e2f-4f5e-a8d1-725fd3eac2e2@gmail.com>
Date: Thu, 26 Feb 2026 16:09:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
 <cover.1771511192.git.phillip.wood@dunelm.org.uk>
 <902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
 <xmqqv7fs4jlp.fsf@gitster.g> <xmqq4inc4ghg.fsf@gitster.g>
 <8397f971-39dd-4a18-b520-3157ae15324f@gmail.com> <xmqqjyw0bve6.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjyw0bve6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2026 17:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> This series isn't in next yet - shall I re-roll with an extra
>> preparatory patch changing is_current_worktree() and
>> git_worktree_git_dir() to use wt->repo, or are you happy to have that as
>> a separate follow up on top of these patches?
> 
> Thanks for investigating how we got here.  I do not have strong
> preference in the order, as long as we eventually get there.

In that case I'll send a follow-up series next week.

Thanks

Phillip

