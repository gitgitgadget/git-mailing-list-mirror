Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A58A92E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830054; cv=none; b=EK5IdMARwPhSyHipMHouqQXre1Z1eBn4vwkVS+YZjHDtR0cZy7M9IiqPwalGtnZELE673g9tN6m/0L43bZSe1E43YvXkqafxbHsEJ1RRX4NLdYpIbKThkfVV6zoo/WTOg9qfJjlgOTJyIKJe5H0PwRdGqDqKu99EIIyrqieKjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830054; c=relaxed/simple;
	bh=BOsu43LMrMG1h7aG+UbqBb77TtMwtOKSFgJQqVSP/Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/qdlSX6sgCKhhBaw7246BChVrfg32zgeOkwbl9qx121I5VzTzWXuR2lpfmMPtdOvtkFaKgQ90AMa7NZ4BKW2lPPhwkTbffsoOfceCJpAOPL3hjzUoF4GXa/djkjkywgAGHYOhPRyRtKuOY6kDSYfWHfaTi8Y6rkNUIGFcaXueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FodFCoKB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FodFCoKB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e8fc8aef1so316814a12.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 23:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771830053; x=1772434853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrLX06lBUhWgpVY0zqmC5JT6aYyoh7cKPnZHMDoTysk=;
        b=FodFCoKB8gpFFgfYHHGfkWmWVyXz1Z49uFzrQQigp/yKbGpGFtNOEA4tzqNzb/0C4q
         9qE8p1DEqLxXp5Y6WRu1tUuYzcDslU8KhVo8epFsmtN8ZBZOGY/ukkq/3LpvfyGG0hRp
         OwVN5fzGtp9HKmWJcd8czsvp9T4euUUXy0yPIwB1ybdEqoAWnmnyeG1PXTUxNYXXVAy4
         30CjueeXRmLBxPexfgcW31y4rCabeF8Ll7E9naN+6YB5POyOx45iNR/g/1Qg3q5T4Qm3
         4Gai5Qq1FoJYRkYBnZJsWst5LCpN9WSDwM+ylOChqdENmJfnMjkxEMMCl/gOAh4J9edA
         ijiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830053; x=1772434853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrLX06lBUhWgpVY0zqmC5JT6aYyoh7cKPnZHMDoTysk=;
        b=bZ8A5ARRkQTUilLkkDR2ToGaz5KnQLPILRJFUZZCQmcNcTialYtmirNjRamOcdTUnV
         XgXaxQyompqN9BbRSVe3XnCRh3427mkzOtuybidta6WkVOD0sYoU2JRki/Td/KowIKm4
         FR2m5WOdv8a5Vq+mTAfEp4rb6nZB6O/WA70mMJ5k60T34hUH+AYHqGDSY72U+S+ScgKN
         dbQhYpzNBNaYVQjMwy/3woKWAC9eZoB5/bnt2hnrXFWMVZJQoKgoNUO91qf3AVl6+DD8
         yRcSyBdrev/at2vNvCOvHFPXbp28AB+Xgescj1hj1wKAZ/T21+0iLkf7EGDDeMGjh6Z7
         iNIA==
X-Forwarded-Encrypted: i=1; AJvYcCW1oUklP6syFqr2OX6znU8RKU2KE+lnzKVQpYZImwVNstx+U1pFMf/u8lBhMNm4hciLZbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPICiaq5ml3CaZRACT9NNSRSCFliQwPMqAOSjzDqkUudO7s5h
	3s9NVKNbEBt9S4I+/GTTrq6SRZ1wS6k/+i+2UYF+AnMdgbvIKX+ActbQ
X-Gm-Gg: ATEYQzyh3qo6O+bUm/HCCHMv2O8aIHZOzN6GsZY3Ex4Mol008vjm69rK6usTDGGPz3C
	t7M/PZG8xSHvyxZaZUe/56NTW12qGhV8+sWzbHjm75eSd4x4amnAPi8u8qsZDI+M5M8Li+9WjKS
	gqrhw3nDD56dQFWDaoOzcEryRoxsXtsnMa5Tx3RlHIFOR1GM9VyyC/Ybe3rxRqW4QEXEa0YBd5Q
	M46D0OYkZkQtMofmjIfkZIkXGw3HcfNn2F/YTgaqBEErHAwGRd3GUogzqDu6mk366wW02OfodOO
	aoKtwaEJ4E+VH7kJw9k8HuzZ8PYCINPGEwy/UvdG803FrJt3YntmIf+raf5hVRXLVlWXRHOZIf8
	MA4/KplY2hVQfkCfrBQaBeMq5YyQQAICn/Jx7qT57GQZ5cSChM+JUDzcbkbp+3zaQqtgUCZ+XUx
	MfiOiRJSL+LTOKF6WX+9vkeXcKfKoT
X-Received: by 2002:a17:903:2ac5:b0:2aa:d04b:73ac with SMTP id d9443c01a7336-2ad743d07f6mr57589685ad.1.1771830053146;
        Sun, 22 Feb 2026 23:00:53 -0800 (PST)
Received: from [10.226.142.119] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e350b4sm63610735ad.4.2026.02.22.23.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 23:00:52 -0800 (PST)
Message-ID: <2008a0a2-7e68-463c-9790-498f4bf7b779@gmail.com>
Date: Mon, 23 Feb 2026 15:00:49 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260221083001.220061-1-a3205153416@gmail.com>
 <20260222102928.377519-1-a3205153416@gmail.com>
 <CAOLa=ZTePRR05M5VBxxk0OA=_RyNd0pLe=Bq6xwnE3MyZBjBAw@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZTePRR05M5VBxxk0OA=_RyNd0pLe=Bq6xwnE3MyZBjBAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik,

Thank you so much for the detailed review.


> Where is the 'uninitialized variable hazard'?

Hummm...seems that 'die_on_error ? NULL : &error_code' would just 
immediately 'die()' internally if NULL was passed. So there was no 
*real* hazard of uninitialized error_code being evaluated externally. 
Anyway, this change hardly qualifies as a major focus, and I will remove 
it from the commit message.

> I couldn't find a discussion, why did we merge the commits?

It was suggested by Junio, ensuring that every commit in the history 
remains strictly atomic and bisectable.

> Not your fault, but some of the errors quote the path and some don't, it
> would be nice to be uniform here.
> Nit: should we also cleanup? with a 'test_when_finished "rm -rf
> parent/link-to-dir"'.
> Should apply for all the tests.

Great catch. Will change in v11.

> The rest looks good. Thanks!

Thank you again for the guidance ;)

Regards,

yuchen

