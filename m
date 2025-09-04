Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CE14AA9
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992663; cv=none; b=e2/XMmWNRcyV7TQt34FDxOFIgoOOxGxNjsidl3aU8tO1Tp4JNQw6Gcg9mXv555tqRh+AQfItd+efpjpaTHutehJtTO/rZo3uZyIwOdgya+Svg3pJqFF2jem2JG7xiLwVBAEOJeGFfnrHeeSJ+Q4xTYZuPIZozFTi7GXsdRq2fwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992663; c=relaxed/simple;
	bh=NSgpYzudc73dZ9ZGEKvCd1K30izC2lTHLn9oLsJG6L4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p9sq/JInzSPJbqYt99BYh4EbKd9vETe9ZLC4ZbZL2TYYL3illWbWowrhHbpodoFi0RKra2yu3fYyhEu0focEDlx2ZZomn0L83IHbS2bGVYdbzsedfcR1fU3KpiP4sPmL3falCQuaK2RgsRWygiiNZjM7MoAUB2OE6ubVwOCabv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmV820mT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmV820mT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso7654605e9.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992660; x=1757597460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itOvdXQMkgglOCMeEYn1AuiGXyixFeEAXTMDG1OaLcQ=;
        b=QmV820mTqJTN5+tQP16ZGWOJCekw2yI0iw4Bu3+iQ+zKZTqNQ6KEaSvciGf6oQOzWw
         1u3KlO5MfkB3Ww5XM2yxx+SeH5BhEHkCjACgdkxtRRQt6c8MjWkIc9VuovfvsIKQhkWT
         nI1T6HLXYr958Kt6EaGwLhxW/cvXOYV0Pc8pHDxv9j/GUrnISMb3VGmGTIIp4zBGlpE8
         pL4s9Gc6C+Ycy00ajyGjD+7L2QoYhENAHE6kaVY/QJ5OW0B/jhMAQb1u0h8hmiLqvKpQ
         upqB5wWHn7HqdZDNRzVk+4HgqPMCOlKhwiNzkEGn+z2jC4AynfwbStO9Ai0PyrODefHf
         24aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992660; x=1757597460;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itOvdXQMkgglOCMeEYn1AuiGXyixFeEAXTMDG1OaLcQ=;
        b=fbBdQEfsy7KqRWK1MXghSiuGNP0KboHxWldCuyw3oURHTav9gVbjUqmWUNRXjJf0ji
         RDeGwoW61pLw7Tduml/IH5/+AtQDoQtHe3Dydj1K5e5Midm6s5AjJDezlPyvDjVm9Bpf
         imvRlA3bVNLzF3C7sm7aa8mq84dRHoFZJ9HgIgfy/+wfZfNfWRqcKVc2rb3i3LBptH/E
         46IsBzkmdhA+ilIXSV7mbFR+42iejjR+q3NQs4DsORxI7FJfh6DjoXwewMXPc36QcMJ2
         Te2xXLO4oIFmRrWhbLZRicCHtd7YSFsqV829uvri8qX7oe5E6avcF5TUC3wNKgLbMtQg
         1siA==
X-Forwarded-Encrypted: i=1; AJvYcCWN2dLWOsM5++7nIVy4sas1M9fjQI+h1Ii5BUmCfsSwHY8aEbpX6HpDM8bPPPZHGpbEO+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm2bA0JGUhNRWP8mOGt1LSUV4Gd9iDdKatbl39/DPGdrba0ap
	tPQ5Eiz1jrjIjUYHBIOMzhEBldalp9sLWzys9hYKMkrfl9yQLzjvC626
X-Gm-Gg: ASbGncv6BeusAx8rxUK3ArezJ1EqcQxJqglk9RT3HH9+mls4ictoJJnb8SfQQzhhpER
	YmhiA0cvlSJPRT7bWVNzZKaUiP3eytpo+To3Yg1QWO9WmiZzUOHt7qw7aCYV8QPERCg4Qm3m04D
	kolBubZIDUrVaf3wv4in8hhqpeEXI75AJFXWNCR6sn5ikTXnDYwPJgahyFFLlVC2c7GVz+k0K6L
	TQhYs9vzqjJGT/s5wLypsltp3YiXTl3G7ia2ZNrFQWhThs7eTEd2hv+VACoQvS064lhmaf9cHUI
	YIJWEVexYxZcBvGMElLdubB+3PlvtXPSt+POryioF5Hm2NaWERR3o7jsY4M+gbpzNUwnTO5JLSE
	55JPkX9aM81WDil8mZCsibUUlN3Za4U6sNahc/2nn65ly2nvNrFN16bXdtsuadtWVGo24DL9Ruy
	CDg07D
X-Google-Smtp-Source: AGHT+IEx8NOn4VnlwYpmLg9S2pQok+SoC4p/Ktp/gvzPdPaDZCDs8lVeJA7/JihyzbPeFo6BLJeZSQ==
X-Received: by 2002:a05:600c:1f0e:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b855335a8mr167620695e9.11.1756992659853;
        Thu, 04 Sep 2025 06:30:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm298145965e9.18.2025.09.04.06.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:30:59 -0700 (PDT)
Message-ID: <d990d908-5513-4f35-91ec-ff860ca126d5@gmail.com>
Date: Thu, 4 Sep 2025 14:30:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im> <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
 <aLfHvl5JuttXrI0y@pks.im> <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
 <xmqqcy87fkhm.fsf@gitster.g> <aLk7QEEWy4nWxsQK@pks.im>
Content-Language: en-US
In-Reply-To: <aLk7QEEWy4nWxsQK@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 08:09, Patrick Steinhardt wrote:
> On Wed, Sep 03, 2025 at 11:40:05AM -0700, Junio C Hamano wrote:
>>
>> I have no problem with that.  I am still unsure about that "reftable
>> cares about the name being 'master'" thing.  If that can live with
>> any 6 byte name, we may want to fix it to something different from
>> 'master', for the sake of removing 'master'.  Perhaps 'banana' or
>> something?
> 
> Huh, did I miss anything? I scanned the thread for reftables but
> couldn't find any discussion around it relying on a 6 byte name. Could
> you maybe provide a pointer to what you are referring to?

c.f. <xmqqwm6ozn7d.fsf@gitster.g>. In t0613 some of the tests check 
various sizes of things in the reftable and those depend on the length 
of the branch name

Thanks

Phillip

