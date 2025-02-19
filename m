Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFF1D5CFA
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975660; cv=none; b=CG3LUNAmd2vSYpxsrDhfvjd6n2sBAITg4USPYgl7VTZ+hB+szpxelppDRsU/HCFbGYx5+t5Sn3+oruRFLJyOdYaT1MO4hz8BrIDWOKnfUaXPtmLWkRc+xQgtZGt2AVLarwIJ+tWeZx83HmRFqeI73zoE84K5tJfFfSRXjRcseEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975660; c=relaxed/simple;
	bh=HEZvfvzWtyMHhQZTE8t+CzyO16w62y0oZPVHD7nxghw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orLz4c38gMjcXZ9QPy5AzW1K0rfHqYUC6f1KuYSjMA8KMXTx4tuB7pW5cuT3+U+5mB9+IIKmDCZaZVxI4/6M/d7k08Wkvf7Sg/vgRWyyLQe3ud3+r254sRqt5hNluDX7uO8hoeyJ2BckC6O9fxrE72z9OAbBvNzSBffA4rKIlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIN+YeGg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIN+YeGg"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so1809888a12.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739975657; x=1740580457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMr429gwcJ+bQ9BPI4RJV3V0IAV1HJbgSZVe00E3ZCk=;
        b=HIN+YeGgvwqatDUKPIx1C/CHgtNlV+DMk08RhMsEMp1tyiFFyV4jwsAY6hMc3Y3UTt
         Ue/enQkSFW+g24d8D1SyZahJB9p+6PfuxKRNz2MyaxbEqs1mR0Eo18HcPsEzRsEoEgPc
         vR0IU2ESLaHuHzLfmJD2XzFwQl4OsZv8/TBZKGxBHa9FwCyNSUpGufqohkA6RfGQhy89
         l8YhyiRb/dUpI5cdp6OznfxDEG4BHN1SSZSsIQJ80R4ptd8iWpVPN1PCfZVEKs0Qpc5B
         mS4dfbMfMvY41RryyymqqdI4tTCK9ONHE0lxUho2RZLEHjQXeyEVhB512tdsKKwchkB5
         PKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975657; x=1740580457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMr429gwcJ+bQ9BPI4RJV3V0IAV1HJbgSZVe00E3ZCk=;
        b=M/oH90zyL/ye/m+dnUw1Sz/sjenJJALbXzQoJhkQPSdKYqGbHY+cLcnOBPNEXfEz6Z
         hagBZ8p4mQcUy2pWhG+dJLvfRApYkZWB55yBT8qmUnssrZeNJXHTlDeIc3TZqzeOVeXj
         XKRwceDkW6YeKbBs3nN+IxIfwzJ8Dpr7OfzUP845sNYP1VWZ+i6Y+gSpSjgCkW9k5TD1
         ZDFiEv3xPD2Z5zxTVt7SGtyeMYvjKWVJYeXrtVmIz0vbUZ3FPeKYRsOhHAnR5HfncMfY
         AcwnvyntQ9+YgoYhWlPgvh0dVEs7Rs2NO+MiZtxSXg0vUBKM7iN3cHZnqlrDmZFIuRZX
         +Oug==
X-Forwarded-Encrypted: i=1; AJvYcCVC7BFBkv0GpfdNrT7jtkcCRO4T4qTuchBx1vjTmaY712bPRWjeILVQdGtmuB+jIaXlN+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+wd7cZzekjL7qe5Hj41STvnUUKPzM++/oEPMpxCqv9wwEnDz
	9V5WBIV7mNe3eiYt0AH+QoQ4/eg8XPfw/QGqwTYMgRakQzh66vqcRK4C7fuwBo8=
X-Gm-Gg: ASbGncvVrDsYaRwgvx97NQZWJ2uH+Qi5QCgb1AWb1xbrIRp+SPkHtjMk2wQ0GS68qBN
	27tr4b6iy8W9rJ0MwJY1BuT9wnWCCr250/N1g3AUD4IuGpbaBLLdXWQobUwt8ecQ3Ocb1cAXNz+
	vdgjZWu6eK9TmmtPBWphyxMNayuLp5yyjU5/aEqHGUyBX+qhmIuJ33LzISXBjEhdYzvlqPy4WF+
	z0UXZrrwTon2Xwy3PeQEycda46kJZ069LPbI2s7UGD12SNnI5NcQgT9hJHMh342y5cSOCssJ3mc
	NBqVixQ+Wl8PmmjByl26mAX+04AXHz35IFQxZ22O4v/ay1GD+nEwl7IV4sWLWuLPqqmomRm0hH+
	n
X-Google-Smtp-Source: AGHT+IEl3LNihba87Wnv8lkCdFWD5MM6GVeXY6096T/KnQc2T0l04+ruT89KLOFeW5vtUrVGZvzAaw==
X-Received: by 2002:a17:907:9411:b0:ab6:fe30:f49e with SMTP id a640c23a62f3a-abbcc7f2de8mr446935166b.28.1739975656449;
        Wed, 19 Feb 2025 06:34:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:9962:1c30:51b2:1ac5? ([2a0a:ef40:700:a501:9962:1c30:51b2:1ac5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb1e1bef3esm972857766b.146.2025.02.19.06.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:34:16 -0800 (PST)
Message-ID: <282b132e-27b0-41b7-8556-cbbdc08081bc@gmail.com>
Date: Wed, 19 Feb 2025 14:34:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference
 transactions
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
 <CAOLa=ZQF0=WgW-2HumRbSp4rUjXikEfecjp5Uxp+zJ+Tun5yzw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZQF0=WgW-2HumRbSp4rUjXikEfecjp5Uxp+zJ+Tun5yzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 12/02/2025 12:34, Karthik Nayak wrote:
>> On 07/02/2025 07:34, Karthik Nayak wrote:
>>> Git's reference updates are traditionally atomic
>>
>> I'm nitpicking but the updates aren't actually atomic, if a transaction
>> updates two refs then it is possible for another process to see the one
>> ref pointing to the new value and the other pointing to the old value.
>>
> 
> Good point. This is true in the case of the files backend, since updates
> involve locking individual files and during the commit phase, there is a
> possibility that one ref is updated while the other is yet to be
> (committing of the lock is not global but rather per ref file).
> 
> However this is not the case with the reftable backend, there, updates
> are written to a new table and committed at the end after locking the
> table. So in the reftable backend, this is indeed atomic.

Ah, interesting. That explains why batching updates is so much more 
efficient when using the reftable backend.

>>> This series introduces support for partial reference transactions,
>>> allowing individual reference updates to fail while letting others
>>> proceed.
>>
>> This sounds like it's abusing ref transactions to implement a
>> performance optimization.
> 
> I understand where you're coming from. This is definitely a stray from
> the regular atomic behavior, that transactions promise. But I would say
> this is more of an exception handling for the regular transaction
> mechanism and AFAIK this is also something that some of the databases
> support (see EXCEPTION in PostgreSQL).
> 
> Overall, we're adding an exception handling support to the existing
> transaction interface.

My understanding of exception handling is that if an error occurs then 
an error handler is called (reading [1] that seems to be what PostgreSQL 
does as well). Is that what is being proposed here? I thought this 
series added a flag to ignore errors rather than provide a way to handle 
them.

[1] 
https://www.postgresql.org/docs/current/plpgsql-control-structures.html#PLPGSQL-ERROR-TRAPPING

>> I wonder if it would be better to provide that
>> via a different interface than shares the same underling implementation
>> as transactions. That would make it clear to someone reading the code
>> that individual ref updates can fail without affecting the rest. Burying
>> that detail in a flag makes it rather easy to miss.
>>
> 
> Thinking this out, having a different interface sound good, but I feel
> we'd end up with the same structure as currently presented in this
> series. Only other way is to really split the implementation to support
> partial transactions as a entity of its own. In that case, we'd end up
> with code duplication.
> 
> Do you think you can expand a little more here?

I was thinking of a function that took a list of refs to update and made 
a best effort to update them, ignoring any updates that fail.

My concern with adding a flag to ignore errors in the transaction api is 
that a partial transaction is a contradiction in terms. I'm also 
concerned that it seems to be ignoring all errors. I'd be happier if 
there was someway for the caller to specify which errors to ignore or if 
the caller could provide a callback to handle any errors. That way a 
caller could ignore d/f conflicts but still cause the transaction to 
fail if there was an i/o or could create a reference if it did not exist 
but leave it unchanged if it did exist.

Best Wishes

Phillip

