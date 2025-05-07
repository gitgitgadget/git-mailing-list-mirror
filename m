Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AB14F90
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625132; cv=none; b=VBmiIQqukD83MpVkbpGO3fRYqi0jmuTX8prYEJIvfL7LeBjOSUqB7sqV8Z2/cxt9A8ZG/R9KkTisnc9nmiuXFoYVvKhS6kkWBPqLHCUxPpouAQVMMJ+9H9WC1tuHE49givJHxdr7cfNGGEz5UfdA0Fkw753J+PxMFQuToiUWu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625132; c=relaxed/simple;
	bh=OHWySNHMbArI8NYevrk/pQZPMxk93EUG0X1mYBmjeTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwAbOEkmtkm89nSOlthn3W2YDZ8CuiJl+fp57zZgU0DdfcTypIjU9YvED3a5qBHQyemdAVDFZvRvh7edNj1BM9srW6I4kKgvsq5HL5+TzvNhfmU4uoIcukjQXlEfYftgRhNFFx7NrFh6GQDKJr0x+rb5NMoWjW7wJoWheCgRbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRaMwu7F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRaMwu7F"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so59808855e9.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746625129; x=1747229929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wAD2tjJxChlJMYU4S3peJsFR22Avm7BtcnCJodiSth4=;
        b=CRaMwu7FwqAt5MCp/8GPsHk7uHb6mxlpp2DE+/b9nkHz9I0dZ+F0L4WnILEqFAX9pt
         w8SIPAfQELFmx8C7wYtnHjOTawgi3q0cd45JfX7vXXjnlTG9P2ZAqrqNP1usrn3yFgsm
         t53jFpm72ZDqIyXWS/kBjhihNT56gf8id6g5UWGX9u2K7idgSO47KzuBw3FWrtmIE0Pr
         OYSSwkooZD193sc80mz1N4qtzvaul9WWmiSIZJ7OAM5Tb9hbhp1c6TcP7XrM20dLzdsR
         lYayMM6J2s0dwxFlDJYJ9KzqGA2o+VO/D6Lmzjx5I/o6P3rW5pT/Awg9blT2b4SY+0oF
         0HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625129; x=1747229929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAD2tjJxChlJMYU4S3peJsFR22Avm7BtcnCJodiSth4=;
        b=KnIE2VUJOglJfaBuzD9C5ONkguIo8JYBWEUMDwKBEObWgDGGTOcGUT37SKvXLpzXZu
         NOl+VNuR+nFoasLcweb1iA5Qos8dYqvG8yc+dEKMbdWFNgqPosnR1uoZCRgML00h3F4T
         4PtgNTC0T0+iV2A1tzHfy9LmtpN9IBoN7QrfgR2a852XKMxnTlJH8gqAHE/scErUl7AX
         o7kP+nu0jvX3gwZTo2XMANXwy1Rr6yWS5zEccw24InUxJ/0wNk4VfB3+cLdEhVUz25rO
         8xl4X9BQqAkZ4S76SG4i//MUVayfTZJboAnR05wwfi3lSrSfQ2fh6EPnHWkoYM5rDp7L
         Qryw==
X-Gm-Message-State: AOJu0YzCwZ8aEjT9LXaLaIAkygr8FMW8gB0RILowGRZuZcBAQJEHj0Ls
	Q4vWnulNskEZN+SRm14iGUObfebf6PzU4GC7ij2PqUVjMGS+1uBy
X-Gm-Gg: ASbGncuHCTiVP1LNynH9SpXQAATCZS2C/DCTPVOn02iuAW6KKuUk1hi7K36AqXYpoZF
	3tKwgUVNUGaLcyVtkMqtqFaJUUZPLxshZuNpw3TY/IjbPkHxTusELnJMz6uJu2KHh77oQeVDbz5
	X9MqbtxqhmOehwOmixlPmy+ZP5CeL3daZzbVw8C9tm5KLP+ZQp5tgPf0wMo4dMTiYlL9tzlreC7
	w+iw0/TsMBJT+hRv9uCJ6RRQ0aOK/eVRreVcA85vnczXGszmngk/Yn3EWm6CK6CCB07e3astyYN
	y7HnsAYXavT5avtng4Nzf9qLUC/b3HOSDjvuraII3feQfPjhIZSmlN9pYjZFJT0a4UST0Bdtkbm
	61EAhg/5yt17XNbdY
X-Google-Smtp-Source: AGHT+IHYV4ARnh99RhxOLF/v7mc66zFNgLLk3wIKFte1LtSF6zYdD9JlnxMPqppUkcmucP3KKCrbAg==
X-Received: by 2002:a05:600c:34c1:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-441d44bcdcemr30009735e9.5.1746625128645;
        Wed, 07 May 2025 06:38:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d11a44d3sm42609565e9.0.2025.05.07.06.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:38:48 -0700 (PDT)
Message-ID: <67417874-d22a-40bf-b35e-4aaaefe6d2b5@gmail.com>
Date: Wed, 7 May 2025 14:38:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Li Chen <me@linux.beauty>, Junio C Hamano <gitster@pobox.com>
Cc: git <git@vger.kernel.org>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
 <xmqqv7qdk3yl.fsf@gitster.g>
 <196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
 <48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net>
 <0c4721c6-9ca9-41b4-a2aa-39f521d66426@gmail.com>
 <fdf7a827-d8ca-4edc-8427-a2c6eb470e1a@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fdf7a827-d8ca-4edc-8427-a2c6eb470e1a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/05/2025 11:39, Kristoffer Haugsbakk wrote:
> On Wed, May 7, 2025, at 12:26, Phillip Wood wrote:
> 
>> It might be worth thinking about how we could extend the trailer option
>> so that it uses the committer identity if there is no value specified
>> which would reduce the pain of adding things like Reviewed-by:
> 
> That could be confusing for people who use trailers for
> non-ident metadata.

Yes we need to think about how to do it in a way that is helpful for 
things like Reviewed-by: or Tested-by: but does not break other 
workflows. One possibility would be to have a 
trailer.<name>.defaultValue config key but I'd be interested in other 
people's ideas.

One other idea is that "git commit --author Kristoffer" will search 
recent commits for matching author to obtain your full name and email 
address. Something like that could be useful for expanding values 
--tailer=Co-Authored-by" or perhaps we could teach the completion script 
to suggest suitable completions based on some config describing the 
values we expect for certain keys.

> I was wondering if `git var GIT_COMMITTER_IDENT` could be used.  But
> that prints a Unix timestamp with timezone as well. (I don’t really
> understand why after reading that part of the manual)
> 
I think it is because with define GIT_*_IDENT to include the timestamp 
to match the ident lines in commit and tag objects. You can always trim 
the timestamp appending something like "| sed 's/[^>]*$//'".

Best Wishes

Phillip
