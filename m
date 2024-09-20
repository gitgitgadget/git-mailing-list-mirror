Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B2183CCA
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860051; cv=none; b=fiMxcwuQjwP2di9r9spEoO2R6MygVMOPv54BamVJnwYkPYABzwsyJ5k73bDsED7AqROfXZtIh68q+mu5cAgTusuqXzjh52DMSPL3D10dMQ3M7ZggBjqf7F9Fx5XM3VbcK4zqYIQe2DoRwH+ODlgX21Rhkmz5cAFVXwudVZ8K+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860051; c=relaxed/simple;
	bh=/DVz1lHT3jSqUDAYcDPIm1SjtWtA6WzORuWwk6W6L+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZb4flvl712hF+f1N6eiOdKJOYGjOUfiK7/DsuawRqZ4W2l5c6DRPBEoUtnBmlRlc69iLsBM87A+Slduaf68f5l+Egw4/znpjXAMxrK7mL9xP4ODoJVo+mnPaNVp2mcwFaQDmqbq+0zt4k/9ikGxIuWj++GcvtsSXHXCiCZMzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCM0Regs; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCM0Regs"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e1b72fc5f3so1326777eaf.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726860049; x=1727464849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejQlvKgFH/Xnv2QP8CW5PpIMmvFFtYOR/3hAYHKHi9M=;
        b=NCM0RegsRenYQRKMasaTQlc1vLec7cxHTHL0P8+VWsIj4nZhT2xnDxMVRUFm7PLlG6
         6doIv8JyMyExd2v8ELkD9Q7cFWJqM5V8R7yMBpZhfIykZb9jt1cY11//BgqLUj8QfjHS
         uWA1xY+4bYJ3wtn/mAlowY3NfdE/NqZCh4RnWsIrIMH7JGIMqaMxyq4G1A2ASiP4UdJN
         p0gSXjGfOPdXlBqc0aCil5aew5KxuoKK7GxzBFCT1nC2sJDiU1rIqbTMOFPw81/JoZ95
         fwEl3eStYTQ3DD3WK7uhoksI3Vm7iZhBSKxthnbCRnnvGW7MqslgtDgBIUeOb3VxVLh3
         BKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726860049; x=1727464849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejQlvKgFH/Xnv2QP8CW5PpIMmvFFtYOR/3hAYHKHi9M=;
        b=i5ln3L4RnNRi3t+OrsBctGlKQp2gjVcKhsCCaG4/lz16311X+BtWve6HytXOY5IH3w
         G6JTI95eq5+dHZj/jRzH7HVf1zbJd6MLK7ydoR6uhcCYt/8UsABldXga0E/sb+wNHdzK
         ZN+9yZtM0KBk3bZDH0nINDlB2x8znYBuUcM3Nvq/PulwLqh3P3PvI4PrfUp2dPrlxTMM
         StEHyjlLWmS0CgdRIS80fvn5oo4HthTrCX6IaknJXv9oJn0BLNQhptYayJzQB/3gXezo
         KIERoK1Xmasx5jUuhX9zM5DHUo40kaIm4wp1ryKasnT2j0bXowVdicz4Sy/u1m4aIKaw
         CZMg==
X-Forwarded-Encrypted: i=1; AJvYcCXPOIumDBi4sro+ugxqoJKe8I2VD3b32w9U3p9XtefHNNpR5SK4BCSTa/S3arnsNr1mwyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3F08AKpnF+5EK5bPsM2YMpZBCVndmZv2ThQNsPxWYrstdu0q
	6dDuVPJ90U7qhMALfllRGHCmZyYLBraLvLKZDAUp6XP794FaL8+HPpkrxA==
X-Google-Smtp-Source: AGHT+IEsZnlyHtc3Exq2CzNk6WDDnSpPIiuXqgbCd5Qf3v/xLoSUuUY77uQKatB6wO5NLOLm+XjLpw==
X-Received: by 2002:a05:6820:221c:b0:5df:837e:92ad with SMTP id 006d021491bc7-5e58d1bcebcmr2174429eaf.5.1726860049109;
        Fri, 20 Sep 2024 12:20:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b25a4c31sm2357199eaf.32.2024.09.20.12.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 12:20:48 -0700 (PDT)
Message-ID: <b67c7b6b-f11b-4306-b3ba-c440e8cf7cab@gmail.com>
Date: Fri, 20 Sep 2024 15:20:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Prefetch maintenance might lead to thundering herd issues
To: Shubham Kanodia <shubham.kanodia10@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <CAG=Um+3C1JMKoW+j03nF6uS2DjcJnKD7+0PSaiXGB-td9qyc8Q@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAG=Um+3C1JMKoW+j03nF6uS2DjcJnKD7+0PSaiXGB-td9qyc8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 11:15 AM, Shubham Kanodia wrote:
> The current git-maintenance prefetch command allows daily, weekly, and
> hourly schedules.
> However, in repositories with many active developers, timing `fetch`
> to happen at the same wall clock time can lead to a thundering herd
> problem for the backend server.
> 
> Ideally, these fetch requests would be spaced out by a small amount,
> so as not to lead to a co-ordinated load on the server.
> 
> I don't see a way to configure this at the moment in a cross-platform
> way at the moment. Perhaps it might be sensible to offset the cron
> schedules slightly for users so as to not cause such an issue?

This is already handled by using a random minute of the hour, as
implemented in 9b43399057 (maintenance: use random minute in cron
scheduler, 2023-08-10), for example. There are similar uses for
systemd, launchctl, and schtasks schedulers (look for uses of
the get_random_minute() method).

Are you noticing that this isn't working as expected?

Thanks,
-Stolee

