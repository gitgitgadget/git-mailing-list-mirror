Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952F1F4CB3
	for <git@vger.kernel.org>; Mon, 25 May 2026 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779747914; cv=none; b=OtV8vS8H76vViaHAKD+hM17SJtj0N2DXCFJAeiHHj+P1XnYfUy1yCpZwpuf/X44s4YQ0vopTocDdBsYdaSFAO+3EsAc46ydxC4aQb5A9i+AEcOV/+8cm7VK3tar3wuCunSdhpuRzdmy0hLPlQKpi8vTo8pO7rxp+c/kKZWR9l6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779747914; c=relaxed/simple;
	bh=OFkQu4wTpLAM3l8ueMA/kS8iYVTN9sSuYX4l2fQN2rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qUOF9hhPz07WwC6r+MDs4h/4jSbFGdnJRvNhBLbuqqvn0zjePYPMWjpJX/bohq93eA1WxVb62u3R0Q13+E/3i7tiomWKdUUzW2e+z40svfni1FNZ8ArTv6NEm9uD0+L5D+Aj4OUgE6AhnajGRqHDzGYWAmjryAAPHAAb7tWBd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDYk3z7R; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDYk3z7R"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8027e876fcso4100828a12.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779747913; x=1780352713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxWkHsqmoI1rIfLz57XYn+EKbEq558NA5HFSgWM4vEY=;
        b=UDYk3z7RfP1UBRi9bimSCTBAPi2+4uKUAlw/aaBQ0CHtxHA3jS16TYy0Vy0qvvlPst
         O41/Slp8KwAZ6rTgfFk//BQR43EgDz5GG4auSkM/wNhWzFj21ZQkOrX1NkcZr68yLqc+
         2+4OwpUhjSVry3HLo/Ahybu7Y2yQ/yt+IucrAJQfitftzK6RK6Ebbg8XHwBVvKfVBt38
         jcxrafu/DzeHKPGtEo8J19rJg+B6moCPe+BnIbh7KWWeyXlVD9sxLGgJYraiw4h3UG5f
         w1Sv2jJL/oQPxOuow7DhTSUnlf1z/+dNm995hw9IPLadzzTBkB1IBXQqKzTHoBqxNJEp
         wemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779747913; x=1780352713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxWkHsqmoI1rIfLz57XYn+EKbEq558NA5HFSgWM4vEY=;
        b=EwIJ712M9bONeWFRlJMszAMXZOLH/zG46GPuNLF3mjYm6kX2TyWSNQSJy5/gh+Mi6d
         ksR9o4lou+XLX3q+vBeDjquFJSZFM3OaLdnLqW2+M0d8/w4F+b0EFIAFgcoWa2cOW7fO
         zyKVrFw2offmez1I8uA3hgWbZ7eNsjpzzK6Hmc624V8ewCfcHUbJKIaNHdsRJdVzwH7E
         J7QdIbuFi0V4BYS9FD8p2hZniIDLTV3oeubIotqB4t5aefXYyPTwpiW+6hE2H8p4PB3r
         fdESRS3MLblfDIPGZOc2Ws88kxI9Xe20qMmKU7n+XPsqP7hItunvSXKTfeOvPbGUVcMc
         2Lbw==
X-Forwarded-Encrypted: i=1; AFNElJ/hFc0XjN1mBay8+g2m/OXq9nbycXW26FfZEu+GGsd8cNDkYXB9dV750eYrHuATbkRXiCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZW5HkJxmBbGEARKf44RHigEwgfU8rFeBgKayqrbn9G62WWGH
	SbsmaSBAjhOcdAzwLhY8Dhb9IECYcc5Ch6HqCNsX3KaUlZfbmCMuxzlI
X-Gm-Gg: Acq92OEUdfnUPgdwAsvC+sLW8yx0WRKuEBaFQrt6KjlGuhoMLf+p0pyKNgPfmfJuqEA
	OzXcMZIdoMgfZMpArEx3FKJvk8p200CEU0+cCt7pKLzLTCYC8DuIfY/PuebarKAihz/wujG1RoD
	3zkUcyt7yuO1HgzuchIXzH2Lfpw7bi2Xt4mfGv73jMKrwTCbVDN0ODREKQAF3QppA+8JKQFuG27
	nyCPDSHL/25OjRXTxBhwsAQct8lYQrDKqSrLM7y+q2uWm3Ietmiktfyw/PqmcMMHHggKxbWgJiB
	3WuxpLlX2Gr29Np4m4czajj1f1NrIPFr3t5EX1Zh9jqtiSopLsf5lpP/SbQuGOiNo0yV3v98hRB
	4cUdKJiEOkIi5miUImsnxgfp265jLUrm5f57jarZv0MlEYwfkcIGEOzqMMweS/fUV52g+BI2Jql
	WNd3cgNiGVOCwiiHtCAWmC6l99k2WaIVf9HanuUZQbmt2+If+cOhuvgg==
X-Received: by 2002:a05:6a21:6010:b0:3a3:327:c5c8 with SMTP id adf61e73a8af0-3b328556349mr16302335637.0.1779747912624;
        Mon, 25 May 2026 15:25:12 -0700 (PDT)
Received: from [10.2.0.2] ([159.26.103.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b3867sm8382419a12.11.2026.05.25.15.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 15:25:12 -0700 (PDT)
Message-ID: <4649049a-ded5-4cc6-bc2b-d5f543e6df99@gmail.com>
Date: Mon, 25 May 2026 15:25:11 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Expected test suite behavior
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
 git@vger.kernel.org
References: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
 <20260525072711.GE2737798@coredump.intra.peff.net>
 <23221493-ea81-47c3-9647-6c6ac8d03360@gmail.com>
 <ahTKq_zCmEDJpoN5@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Amogh Dambal <amoghdambal1@gmail.com>
In-Reply-To: <ahTKq_zCmEDJpoN5@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > What are the OS and file system on the host?  We tend to see
 > executable bits set when NTFS, FAT, or other Windows-adjacent file
 > systems are used on Linux and you're mounting `$(PWD)` into the
 > container as a volume.

Ah, this is a smoking gun. I'm not on a Windows-adjacent file system; 
I'm running macOS Sequoia 15.5 on the host. Specifically:

$ uname -msprsv
Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:26 PDT 
2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T8112 arm64 arm

But I am mounting $(PWD) into the container as a volume.


 > Git doesn't use `/tmp` for most files in the tests.  Those are stored
 > under `t/`, so you'd want to create your test directory there.

ACK, good to know, thanks! I am still seeing the same behavior with a 
`debug` directory under `t/`:

root@ec94ab1b260e:~/git/t/debug# /root/git/git init plain
root@ec94ab1b260e:~/git/t/debug# ls -alhrt 
/root/git/t/debug/plain/.git/config
-rw-r--r-- 1 root root 111 May 25 22:24 /root/git/t/debug/plain/.git/config
