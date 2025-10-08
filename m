Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4E23CB
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954010; cv=none; b=Wu3PcnvPn0gbMCwMu9I4UVgCzp3xBXb9w+bV39jZhIO8u/CvOo9Wnc8hH3PiYhGbzpXo+J96wo3KXYoL6R3mUKxsR+t2WJy3/nOKaAJ3qh2HF2uBjtl6YL6Bsg/wZGDjPGRz6vcGlDOveNOUQOjkbtpcf8cvItuDjqYgI9sGknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954010; c=relaxed/simple;
	bh=BXD8b9e5QKe7ix5cQwAP26hNESsYvSUh4jO4TnbqeXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axRcXxxZ/cUq60ScfUuJCIiSSzexgMq3GzqhyTobfE0bhoFqCQXheTCh95evlSHgbG7jlbPFsjONZiEFr3uRwzYKHZKKzh/TJLPC8Eh0PvmCYldztnwlOQyW7jaVohW6CKopoKdBiA0GyGMNxeaOGxfiJHARrvReKI4+uDnQ/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+FCGhkW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+FCGhkW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f343231fcso180208b3a.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759954007; x=1760558807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJuvdfszWbE1Ar9g7ycRxQUP975EPe38J7BsWAy2TX8=;
        b=M+FCGhkWD7m9HL2YIbRnU8ADc8lgtNGyxTLSVGEAxnKCLrZCC6WbvLBcfPxBHrRkG0
         Qz/A9BdIjBxF/8ZkTwzGJAsTyXHmVDsM2Q5/i/WLAt9Zewlao7M0kD1wl99KRP3VNDCc
         7gYGbmO2Qkt6FgfOkAjV8IhMrSN+umRHw+cajvjuMzIR2W8dav/bCKZpeamXl5+NOFGX
         4u0/5gfL01C3+L9B1MSq90idxqFXIcnO4xLfKOA+DbPWr9u+zUwZZ00dZ7TPo8+RQMhu
         IMukvQw88Rc0q0rVHcKzKKHmY73CtmICB49UUfglZph/A7JSpQkAuES12Heg8B/Mn/dQ
         ndwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759954007; x=1760558807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJuvdfszWbE1Ar9g7ycRxQUP975EPe38J7BsWAy2TX8=;
        b=fOUHyRmkUVFn/xJH/QGOHKO41wjfesS48C45v157rntWrv64slSPV18t1RTnmtma8k
         /PxswnhryjehzzByDyP1CJ7aiRHLI54Nq5Cdl783uoCoM2z7xzujdC1Q9PUwvpeZ9r8g
         O/C3Ns4v5SZBsjDqzxbud56LsPh5NFI6z/ekM83ODN/RLGWcK1E3BAQ2xSiIQHzl1vDo
         rN6u9eJavWPUMVS9ysRG4nK6rLT/Blcl47GtsoCDshHiDIvP415wJ5OLEjAd5iGGe6zK
         iRs02e+mHdwMlE+DzMYFmmi4ketVq0HnYQjunFH2hBq0iPCtVIW8X12rpd7yDj7qOt0g
         UbYA==
X-Gm-Message-State: AOJu0YwaDJRwS4QPzJbt3PMVJt+2WMpk3toOL8PWOydaIx319tNLmeGF
	WXLJ9BpGjJJSJbBZFMcIPJv0XnAq0Zmm+LvXuapQr9tBwS5zdcsDXz06
X-Gm-Gg: ASbGncvec5wuWdPJ4F5wNdt6dTAOy8I0KdfVk7JJl+CXxvc4hN/8JXxR9zPeKm1p6H1
	bMj6bWvDkAC//RHsQtiBotvKa6A+I9ToT8LmooxuOU94Gj7gvgYlf/Bi8DZ99JDNq0/T8uHJwG8
	dEq7xnFie0GE2cqlEYQFCPEjfJEhDULZu7he6dSAwP8fb4yqYQY6lowAlH9YcCoUTN5UbQAkroc
	gBquDg9kB3rNf5r0KHbofgM+4RACmncMZt8EPGEZtvTIxnSE7pochHxUd3J+tQYZe3n1tAetWJo
	Nm8n/N5zP0k9GX3EHiI/91A4B9goAleOTj8NFsg1nl7OGt/RcDb+NWlS0K1HMPDIey3vwRWULOo
	ZzQH+50gWzcOtmmNVL7WFIMtS/1oliG5C9Atq+/ENds/qAGsSg6BPYe2PgXhbBOf7s6o7llmcBc
	HL7SGHi597ZtNkkRAkUMWHHRYgRFs69yNbGaRMezHg++QBY44fI87QW8IoGeqBZ/IZQdscBKR/9
	fW59tZK3camCzYE43QiMLkACIRcs2nWzw==
X-Google-Smtp-Source: AGHT+IFZXFmCLJ7rAnBmdkfe9r0AuRF65zXEQ7cHxr3ONCZ948r3UZZ7SF7o2Co1NystH2ygeC4BEQ==
X-Received: by 2002:a05:6a20:4321:b0:32d:a70e:120a with SMTP id adf61e73a8af0-32da84617camr6006741637.45.1759954007051;
        Wed, 08 Oct 2025 13:06:47 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62dd50c879sm15989278a12.17.2025.10.08.13.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 13:06:46 -0700 (PDT)
Message-ID: <ea7aa170-400c-47fa-b3f0-2623fcbfcaea@gmail.com>
Date: Thu, 9 Oct 2025 01:36:40 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
 <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
 <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
 <xmqqh5wfu3o6.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqh5wfu3o6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/10/25 02:02, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>>> For naming, I am thinking either:
>>>     - replay.updateRefs (boolean: true = update, false = output-commands)
>>>     - replay.defaultOutput (string: "update" | "commands")
>>>
>>> The boolean feels simpler, but the string might be more extensible if we
>>> add other output modes later. Which pattern feels more consistent with
>>> existing Git config conventions? Looking at rebase.* they're mostly
>>> boolean toggles, but am I missing a better example to follow?
>> replay.updateRefs sounds better to me.  defaultOutput with "update"
>> doesn't make sense to me.
> Yup.  Or "replay.defaultAction = (update-ref | show-comamnds)" if we
> anticipate that we might have a third option someday.  That would of
> course affect the choice of the command line option.


That's interesting. Between:
- replay.updateRefs (boolean)
- replay.defaultAction (enum string)

The enum is more extensible, but do we actually anticipate other modes?
Elijah's --format idea from Kristoffer might be a third mode eventually,
but that seems far off.

I am leaning toward the simpler replay.updateRefs boolean for now, but if
you think the extensibility is worth it, I can go with defaultAction.
What's your preference?

