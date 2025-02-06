Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CC2E62B
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808164; cv=none; b=iJ15T73uHa2HJl/pTTnMmh7VwhggXwNu5kIOR0DJNnIihZaGbrLxDPkiDE2OV/bgDjSrj2YJDgX7YOS3MydvDWdI/fjzHecngVpLCHPBfBfXk+1t5X4MwZstlJ6kO2rFbCUOi6MFwDnXTODq3PhNfGYKVOqlKlYoWhy6koM3+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808164; c=relaxed/simple;
	bh=0YqfFQPALDp5ScXkk77lpfPsukmEeFIOkRWG9GgUZ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TaDddpeJJySHskldBE5+SBl9h0b2ZX1qnI6Bm4dbOhnvSEDkW4vERa17isHrsy0ibQcDCsFLg3X3p9Z4gUYeZ52BAOYYarg/WLMTcAZ/0o8pKpmozHCnX3L9hXcETel7L60gZje7b9hBA2Vd6GmU6g6bXojyACKjNmb+nCGev5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyCyAef0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyCyAef0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9d5e0e365so508366a91.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 18:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738808162; x=1739412962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQTaHMRe8uWyJC3jB9nvOjAEIB0Gb6l2jCuMgWRD1qc=;
        b=OyCyAef0v52mlwYRHt2tZaxstUqpJyxfXrnqzLgKXZ1eEUsAXAY9pZvqqhiUKlTnFq
         fPKoMQdh9bAfIcLQMBZbSxPnvPs2dYp1KH9JMScvxbDpUg7uIHAQ6BfCCpNJP4fmmjoo
         OPoKDdIVY7qDH2b4ciOyx69BXOzw9KrIzxjuQT+YQvqiMe/3DVYzZ3SBKineVU9mwR4P
         9EgiAvG5NOha2PCPAXWw+a4SVDxzU420Ya7TaGopDGeofV/IIdWZ8fs9kEiRMTh+9GEi
         nUgcUyuDZm09iYcUi6kt0YKgB+g0y0yDilDqyUR6bk3EyCV940lAghfrR7bcl3a5zOIN
         1AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738808162; x=1739412962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQTaHMRe8uWyJC3jB9nvOjAEIB0Gb6l2jCuMgWRD1qc=;
        b=djF1ai8P/ejVRCXpnVBPIJishsbjBVIAZlz5Uu64W2AdNKuhhtZhVOvW4w9Hhf0ZQt
         23B2NlxOv5KxyjGafLH25i3HZuHWWpOm291b+BRAInWtPsuLJkJyV5wNe4nSTq7z/PEq
         ObzvppmRcOL1lC4Q/qjeR3d3KQ+OB39LeI+2FvLpJJ8TyjEexiNJOlwieklj/rwxvMNg
         mGqZanRejsRh34aDKiPiB8Wo9bRIXNZjNAd5GlXxx7oHkqeJRzr/Zm2fRvCAARSac7dm
         NEMsLvzuQbqNs+2XmbygdOtBHzbDBR7aJkckEsQWUSCFBwyGqVTjnrJveETwQ92qKW52
         b/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQM66ijicG96UGJBo2DGzBrbiP8aptbgnI+RiHZFu8duE7x42D5PN77Xe8xNUbumTpkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyjhI0mG9k1IegcyjBeQXe0X2dWn36zqyR3mPhwsLwenIMB7E
	4ZAUVlxlztZSTcraQW2+75Lhu7qR2uq+wAFawK1Kfpq4Hx+cmGrI
X-Gm-Gg: ASbGncs90L+xvfJ9XRux8nd3PthV+uuoXkrfweQkuwcwTypaOkSy5eOuBp9bZ8wJms7
	RErWzGGKIL7EgN/NkypL91DQg8V+Sf/xvVFbHGTcvGBVEbqzzWdxWfBUMDU8rl/QbwG6MnYpStk
	5amyyAbDaI4EWwYDkFl6eyrCZgdw4+AoyUliAFyK6t9Xr+FJI24rVnCfcXHxvG9ENte+Ubd8cUM
	on0yNBhPJa8wIkP4euoQDoATYHzwkkMGySX05OonFhjJH5cYEeWG6rq4J037PZguWJlz7mH6Ixp
	jU9/bZnuKOs91kg5oDMnJiv4LOhrTC0aKJ4S+uDHuKLUJFBCuDP9QgfKmXxSOBh0Xw==
X-Google-Smtp-Source: AGHT+IEPe8GQ3YvgGRml7ToZoGDBHPlupqBpRM7Is3RjZQn2uLGgZqMC/I/lX8vrW0TUu35YBoWGag==
X-Received: by 2002:a17:90a:d410:b0:2ee:db8a:29f0 with SMTP id 98e67ed59e1d1-2f9e0800102mr7735045a91.27.1738808162420;
        Wed, 05 Feb 2025 18:16:02 -0800 (PST)
Received: from ?IPV6:2601:647:5580:5760:c1bf:72b5:6aa3:f684? ([2601:647:5580:5760:c1bf:72b5:6aa3:f684])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e23a09sm2379868a91.38.2025.02.05.18.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 18:16:02 -0800 (PST)
Message-ID: <101b03c5-dfad-41f0-8156-e541b8e6c68f@gmail.com>
Date: Wed, 5 Feb 2025 18:16:00 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: `git p4` broken on machines which do not have python on path
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Kapil Somani <kmsomani@alumni.ncsu.edu>, git@vger.kernel.org
References: <CANF_+=4dG7bVF5n+s4ezHR=HneeMgvYNhsOjsz7e7bFapG2f2w@mail.gmail.com>
 <Z6QUeaoH_tV2ncwn@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Illia Bobyr <illia.bobyr@gmail.com>
In-Reply-To: <Z6QUeaoH_tV2ncwn@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/25 17:46, brian m. carlson wrote:
> I realize that Python 3 is now the default, but there were apparently
> still some people who want to use Python 2.7 last time this came up, so
> the default shebang hasn't changed. According to Python upstream,
> `python` can be of any version, although for all distros I'm aware of,
> `python` is always version 2.

I just checked my Ubuntu 24.10 and `python` is `python3`.

❯ python --version
Python 3.12.7

❯ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 24.10
Release:        24.10
Codename:       oracular

❯ whereis python
python: /usr/bin/python

❯ dpkg -S /usr/bin/python
python-is-python3: /usr/bin/python

There are both `python-is-python2` and `python-is-python3` packages.
They just provide a symlink for convenience.
And one can use Python version managers to manage what `python` means, 
of cause.

