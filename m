Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BB85C4A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682695; cv=none; b=lFiuDT7fzQseqhdQB4AilWFQDEfrThiiZljAAUsw2vMXxLLolcfIIeSi9N7ygD5g+shOrksx652dISteuh1KzYb9C1CaTm6VYqnqAr0lKlKZuIyiC5B1FU9ZuDhPrP6VLGHYssQ6o0H9MnnqI+oVRz+2Dm10wk37/YZhdD57RX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682695; c=relaxed/simple;
	bh=bakeOSxMZK+zqKbWZBDPHXIUH7UCBktrr8Keu0UhJ6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVpV49ReOcmWLpOGvmpUD/AL+deUvjGKT75trV4RFkGIAyf3J8ia7xM/BJNU+gT6ccyWH7WzkzvfF2xvedv6UYZ/aQ0WZOL2Ow+/m9/RhAHgHR5UfkSxVgeCfgAcES4CMJMutePjSRkrqcv5AVwB0zIUIi7P8GbEW7WyK5PWpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPtZfFDt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPtZfFDt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e0798so91757765ad.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682693; x=1762287493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Faxu/uT9nzNqlrdL7ZBHXcNTMgf4yFVevFRErA5bqXg=;
        b=UPtZfFDthgUXZu9J7NdkCi1+laKw5piwY3YvrMdzlSpWo6Hm2mDDY7sHYrKYZaT3sH
         LNvZKzinHJ4Mpt2+aCb+SgTEiRUErHcfgqPzuj8EKt18A1S+JXJyw72FJ0rLM3izjeGO
         4eQ2yQElVEVmPMHmsj8KteeGizEYLRDUTfvFKJpZkoqVNhC0wdqiTXYuvKLNiWSsnuhW
         OgreYY5zvIV/nl7WxGJQXOuMMSb0GDCT6jbiOS9Qh/y2jw/d3yZVobH7boKoE8oXlrXm
         ViDARp4/9MHCAo29lXFHc+YdlLXNylY33b2EBQkqfGFkCnRxjwIdntywSgPBKadtIigH
         2SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682693; x=1762287493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Faxu/uT9nzNqlrdL7ZBHXcNTMgf4yFVevFRErA5bqXg=;
        b=Bs+IyvwD0Mj9kQ9SBhyn6IdORopyFDs7+ZyJzJ1Q0495s3d/etx8Xwq7jYGqCbKLot
         xF7X9mh0LZuqq6Fz31WrwYMu5VxFswpRoJXVE4Tr+rWb/w1nKc7ulk0KAywN7RbSI64z
         ZJohNocFzQXi8YLC3B+gX+s9BBbhe4lXzsdZkMLR0zHjMCF2/SRpbBc0LFD2k007m638
         z6Jw/iBJ+xvFF2JYlT3oLDH5JaN/yDW3FWpSxGEIL/f7X73WWrFPyWAmxJwm8+xkIHWy
         U6hgp3+xYdXVHjbcy+MnttX8mzaa+QHHJu/QuBsHLMqxXmsVff5ZVVhvGCRFLzKkSrdu
         1y3A==
X-Gm-Message-State: AOJu0Yyp6YuKrU/Qljx5snGsMYexrcQ7NvreLJgEZWpi8Any0RIWtO1y
	IvYLZaksEKsTefyXp0xQWjgXLtW0u/+RALqRAVvfzOjXHJDQrbwxwslT
X-Gm-Gg: ASbGncv+tOucYJdn+KhMEMy7Vidv8apP1U5ZptBHTFxUEyqpjtyeNAHAdYrbhdn+SWP
	KT++ziaveHy5oeDc12F05OWqYhb9kougQDLapqJWMRD+sKfNCHy4Tricb/zfevttCaB47WqHzZe
	QSusRnwymfeoqeq9BXaNTqd/2A7DpvvZ31PdnQHKq9tQCDEJ7a7TLXSICdLmaUDdXam+OX/ejgO
	DULzKi94Y2KwABmkGvjtRRFfNmlQP4HB1NzYLSXihqT2pSWjG4o7fc5GqeNQmxQubzWmqm2n8tE
	VpsMU1XeNSucmmZZhMzE7/OevoPCXp4LKOTXEninm2YFrM4Fk/LtI64TY0tT0DQ5O00y/Zl+QTY
	BJ3XhA/KOI6ezKwFcFpJ7NYEFbORIL34UnlLLDU/33JSBWjEmyaxMz4Pt63+qTvS40ABpfIXqe7
	bSdEqlB0ojuaVmZPQ2UAvBGbiiTrbJyH/GcNlabR/pVErXvYKIYeMEB2KPNyw12UlTequJvJxEU
	cp9PgZ6tx9phHnkvvvIUhMGL8pKd4Y38bamFjkUaZzkXtn5863g6f6Z2Q==
X-Google-Smtp-Source: AGHT+IHR6jSKK8MSrkN2E2p/qtDny5q9MODm+pOGAw+XtwQXjfAnJ+ARaHxNoKB0whxDhGsCBg3agA==
X-Received: by 2002:a17:902:da85:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-294deed21abmr5026375ad.34.1761682693336;
        Tue, 28 Oct 2025 13:18:13 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf33f9sm124831375ad.22.2025.10.28.13.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:18:12 -0700 (PDT)
Message-ID: <90b3f359-6b24-4858-848a-531478b21f65@gmail.com>
Date: Wed, 29 Oct 2025 01:48:06 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, newren@gmail.com, ps@pks.im,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-3-siddharthasthana31@gmail.com>
 <CAP8UFD00rE7gF+baidmoi7nYwVKa3UDQgj+TB4wJLtjJF7u9gA@mail.gmail.com>
 <xmqqbjlwqq6d.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqbjlwqq6d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/10/25 20:53, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Wed, Oct 22, 2025 at 8:51 PM Siddharth Asthana
>> <siddharthasthana31@gmail.com> wrote:
>>
>>> -       const char * const replay_usage[] = {
>>> +       const char *const replay_usage[] = {
>> Nit: Not sure this change is worth it, but I understand that it might
>> help pass some automated/CI tests, so not a big issue.
> I think this formatting issue came up recently on another discussion
> thread.  We found that the prevalent style in the codebase is that
> an asterisk in between tokens neither of which is variable has space
> on both sides (i.e. the preimage of the above change), so unless
> there is a specific reason to make the above change, I'd rather not
> to see such "reformatting" thrown into a patch that implements a
> feature or fixes a bug (iow, not a "clean-up styles" patch).


You are absolutely right, I will revert this formatting change in v5. The
`const char * const` spacing follows the established codebase style and
there's no reason to change it in a feature patch.


>
> By the way, I would be suprised if that the reason were a CI test.
> How would the preimage have been passing the same test if that is
> the case?


Good point, it wasn't a CI issue, just an unnecessary style change on my 
part.

Thanks,
Siddharth

