Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7B17167A
	for <git@vger.kernel.org>; Tue, 28 May 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908561; cv=none; b=Ha5sIF4mI3p5Lm/ILPNNy6eUDPMNG0A3hPMA0SivajvcMDHiZ81ysOfS27yh+TTZvR98T2iSKYOhyJcqR9APmqXLiUR37C+4yJmFUxSotLxCpxOnb24G5JhhQ3K5GgsCC8wwYkQLlKWr5pn5k07jR8T+oQBxFZ1YvvNxNWKRIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908561; c=relaxed/simple;
	bh=ILMgiIO/CF93phHU4A0gK4jN0mKA0I/S9UTAECLwAWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erPOmABDmk2xSEq0yvhpEFGmY9ZalcOK36XLFqcYRabNXQlocN8BkesVLMYQ0XFXoLUGNPV6GTldBxhby1/X3Epwn+wHjIX7CaIMCJIGRb2czQULuXJ7HgIEey8VjPbCzWi5LRM5qrbosQaKBd6s5mhkCxPtInsewN6gOeOHaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE68gHS7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE68gHS7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35507e3a5deso2519015f8f.1
        for <git@vger.kernel.org>; Tue, 28 May 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716908558; x=1717513358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzmiodl9yfD/I8WKO33M3U+7yn5aTqtMnh94Ew0s1gM=;
        b=NE68gHS7SAjLwVeiDjzXrbLtvBNYqVmx6FOEAMOPJnWvau3ewAKVXBOTgha222Syhl
         tp2RQdjMmndhRBHf/8RBCXKzub4RgWvw46otJaOjWYt8IMpt4mchg4Bx9jnaZO4WSo6M
         GcOZ7yLmvfnc9S2baL3SDBeKN+tZMq+7hJ+MNFzcBQrPl0Pa90jY5lAQhTJj9pBVBJQW
         JfVuS1o281/ohytDDENoW+9ZJe+0+1T+vfbp8qKmrVFUuUrl53KfGjZXUBQGfPoiMwAf
         LgOKldHcem+29Ic0aM+P24HbpRm1vaOHbb9rJpI2JV+KnftrUi7zr3GDn4F7i1VbREgw
         usHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908558; x=1717513358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hzmiodl9yfD/I8WKO33M3U+7yn5aTqtMnh94Ew0s1gM=;
        b=L9lh8lRFgW53QUYyL6GUuhS64o6fQdvsSgV4mTZoobBfusscmjT5gOd5KydLBYQ52u
         M7xba6oGJ+dfXhEE1uniy0nqtv2/EgW0o2fbbgQabctkdM0KeXih2Px8m4HxveB8+c4y
         boh6vrEQ9DjRKuoKBOEQRoFA3MymoiAFkTZuuPliU4VmGsqnfVv4dDJ3uoJ2zKJtX5Ra
         3dZpu999EydRa4qiAI42JS2hfyCTMvcdiEHwLIGg5iVG9mIjD/h9IA/CkV5RhZDbR23D
         0201jvvHPj2xsQ0hmnebaLtwpckMNl9GT98zYeweOlbcaSbpwjYOpD1EMQELTZelWvgt
         KbgA==
X-Forwarded-Encrypted: i=1; AJvYcCUfCC0zrNJH+Ns2ETdIOe0lvqjPJ8I97XmPhGez81gWrmjRRAsd+8+3UkBDiZ+ioSZaevcHirLUO4RfWnZKbyH9yn9s
X-Gm-Message-State: AOJu0YwWmQKR5ggV4PjFcZt0LUWy4QjmU/EFtr0HKn6vZMqqhrl8dfvf
	YQa/OtkYnSZQhZ8ENoFx+ZsmA3ElP0Ojm98Yz7epiv5mcGlCBRrr
X-Google-Smtp-Source: AGHT+IFrdWHGuvAF7M4KWxwMX5e1VRXRdIA7RHtE8cjndRnqBBoW18v1lMHWKaEcs5KDMQ0TxmxCpw==
X-Received: by 2002:a5d:54cb:0:b0:34d:8d11:f8c0 with SMTP id ffacd0b85a97d-35506d5db22mr9405059f8f.18.1716908558425;
        Tue, 28 May 2024 08:02:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf06dcsm12131656f8f.106.2024.05.28.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 08:02:38 -0700 (PDT)
Message-ID: <8353645a-a684-417a-8b0e-d8cbd7da6b5a@gmail.com>
Date: Tue, 28 May 2024 16:02:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in 2.45.1
 and friends
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Joey Hess <id@joeyh.name>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240521195659.870714-1-gitster@pobox.com>
 <Zk3ChIHr5amGh8Mt@kitenet.net> <xmqqv835xekc.fsf@gitster.g>
 <Zk9vafYPijqyWpXv@kitenet.net> <99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 27/05/2024 20:51, Johannes Schindelin wrote:
> Hi Joey,
> 
> On Thu, 23 May 2024, Joey Hess wrote:
> 
>> Junio C Hamano wrote:
>>>   - The extra check seems to have meant to target the symbolic links
>>>     that point at objects, refs, config, and anything _we_ care
>>>     about, as opposed to random garbage (from _our_ point of view)
>>>     files third-parties throw into .git/ directory.  Would it have
>>>     made a better trade-off if we tried to make the check more
>>>     precise, only complaining about the things we care about (in
>>>     other words, what _we_ use)
>>
>> I wondered about that possibility too. But it's not at all clear to
>> me how a symlink to .git/objects/foo risks any more security problem
>> to git than one to .git/annex/whatever, or indeed to /home/linus/.bashrc.
> 
> It risks more security problems because `.git/objects/??/*` is not
> re-hashed when it is being used by Git. That's a very easy way to slip in
> unwanted file contents.

What checks do we have in place to prevent git checking out blobs and 
gitlinks to paths under .git/? I'd have thought we should be applying 
the same restrictions to the target of symbolic links as we do to those.

> And there is a good reason _not_ to write stuff inside the `.git/`
> directory unless you happen to be, well, Git itself: Git makes no
> guarantees whatsoever that you can write into that directory whatever you
> want. A future Git version might even write a file `.git/annex`, breaking
> `git-annex`' assumptions, and that'd be totally within the guarantees Git
> makes.

This seems a bit harsh - many tools store their state under .git/ and I 
think it makes sense for them to do so as it avoids creating untracked 
files in the working copy. I would hope that we'd be considerate of 
widely used tools such as 'git annex' when adding new paths under .git/

Best Wishes

Phillip
