Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0E16FF3B
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653913; cv=none; b=XuO1THk9Hroic5bSt52zWuFpHsjJC0urCY+IqClkMNpega6LxgxRetSyZ8gLzpv6AnFkDcKv5XRJ+OP8w2mkvsrSt8OLj6aExHJwpeqDsKts2YZRwxllEuS7yn55B1f1vThgTvH+Aefa7bZAruh9L66+B8RFeZ2kx6fnlEyFf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653913; c=relaxed/simple;
	bh=Bw6RXKZq8y1VLZSVWOPDN3uXSi9CRbLvo5HR4oYXlk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Em22O5k3x5wBVxQDjWtLVVwnG9WoyakyDn3s3NtKSS3Sxi87qZiB7XzEUKSagk0MVSmpi1uY6of6JI5DN63olxGB3BnMoaWykGf/o2Wbre+nD0DU/n1M5unHbYSXMqMoCnZakYY/hJaGz2DuIJiNrT5gCJWj4MXV0tqSXhf5mOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8gysNqQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8gysNqQ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f763e9e759so68488021fa.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726653910; x=1727258710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rMCPAzBVAq9VzLL1GQ+SaUoI/ni0r29lKH36HmhpiYY=;
        b=S8gysNqQMoC5+YQGgxtXmFaJffuYEdCc8pN8Y7xlEiSyY3GqaQS5ue6niNUjhpaU6m
         cgtb+eLRWHzgL6QoYwUhYjoMssAnOpoQovAQ3/M+NboSEbgMga2OkuK5Em0toxUwS0St
         ag22yKRe0MM7c31gkFoeS/oiz/p04DfvrLaC5tUbMMFg/LmEe4K2lQN0gEDWU7lkvg3v
         AoHaUJV0sVLkYJ9p4m8cStTPuzvLASCVfrrqlaYrUQ0ByOaPqv4asu5hTK7rNmG6vjCz
         gjfGg3T/Ye6Ii9jIrKfkbGZBSIfBEmRfnwZXHahv16+qhdd6mTEHK/w2zrVUASY5dHgV
         8lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653910; x=1727258710;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMCPAzBVAq9VzLL1GQ+SaUoI/ni0r29lKH36HmhpiYY=;
        b=qTHUPVO49wKaII2/AvcXB8yZzgIlRtWvI5On7hfognJ8ihXhjTsbGGOIgNi//Sg1rR
         bwOY1zuTsdShCj/tbDBuselNNqbext56cY7JPt9ITqnqsJseIFKK2t63jzmCDJ3D6zQ0
         x9tEfyzMayLqI/vwJVo/4TFU5D8pruws0rGamxw9ctAXf0bg71w0qh1W1/Nzp129NO1I
         AQrm5xEhNkyc5XQXbX6RWplqyvh06nSiQysmFhqaldM8HvRS16PlpTAGREx71KJtm1i7
         o+PNVTP0gQ7gk2cVyN5ndZbFKoF99adiugQzwhIkcztN0humxKUwhHoj6jeLAQvL+RPH
         B2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU/gRZdLnnKlnJywpdMgqhNQ7PdDRhyl6OIDTX89bmGFbv+hTeqvtVIylRGDqrcFmTzHM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClUiWTlH/O1Axuhmjb0HeKkMdO8Nu6UICWVLDMJQ++S6foZ7e
	ag7dO+RW7mR+i6w5Os9TGoCiidoQetpGb8KH9gjfSb2czJ541YC0
X-Google-Smtp-Source: AGHT+IGiY+BMyqywuWlJ46i7sNqobp3JTwJW1h6OZIOOcpFomFwc8IYTbtgX/QCDZCRzBd5d7SYBjg==
X-Received: by 2002:a2e:a587:0:b0:2f7:5d73:92a3 with SMTP id 38308e7fff4ca-2f787edbc0dmr138748631fa.24.1726653909339;
        Wed, 18 Sep 2024 03:05:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e705090bcsm12727495e9.26.2024.09.18.03.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 03:05:08 -0700 (PDT)
Message-ID: <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
Date: Wed, 18 Sep 2024 11:05:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: Matt Liberty <mliberty@precisioninno.com>, git@vger.kernel.org
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

On 16/09/2024 16:08, Matt Liberty wrote:
> 
> If I try to grep the output I get a fatal error:
> 
> % git submodule status --recursive | grep -q "^+"
> fatal: failed to recurse into submodule 'tools/OpenROAD'
> 
> I didn't expect any output but did want the return status (0).  I'm
> guessing git is unhappy that grep -q exits on the first occurrence of
> the pattern.  I don't feel fatal is appropriate here.

I assume git is dying with SIGPIPE. As the only purpose of "git 
submodule status" is to write the status information to stdout that 
sounds reasonable. If you want to collect the exit status you need to 
consume the whole output so that the command runs to completion.

Best Wishes

Phillip

> I can work around this by writing to a tmpfile but would like to see
> this addressed.
> 
> Thanks!
> Matt
> 
