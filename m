Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7F3B29E
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917642; cv=none; b=BT/0V+SjyzhRAntOgYoyYRHNqfhT5YakSjQTlTto0nWzulaBrY/LZibrjZpCa5xEdRWW/BMBoY4JUT2sRANVBW/Tz8TxKOp43r96TXbEshmxIim7Dw8KMIqABNobHdmeblYuXbzu+cQmVZaaiGKUbAUIJCKaeTK+wBd25PZrW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917642; c=relaxed/simple;
	bh=OFbfWrNJhT2PW9WJBXIxLQiRDqz2Ou3n+6VRliWswd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OseyOCrP4WrDgi+L2UAYLj4gRkMTopILUs91TFH/y+8pEG+EKoal8VQVl/MiT6WnGzix8C1NbjBcomO2dZud8qlWhC7Hz5JBg3MdMC65g0ShU0CXR8/e+51fBoWgkgs2PWQRrcFdnArzX5v8Z+570KzLzpN+BaRlQ75ApZvhh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SakI4tJE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SakI4tJE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b77b8750acso2607849f8f.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917639; x=1755522439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yxKwDLBaIJ2wldr//fyfdEXI0Yny79Q7D+3+DGASNQ=;
        b=SakI4tJEKiVngflveX8xkXEGxvlLxIvebuXOG+6wwhICOr3gHpw2qAue6HL1VZk5hg
         SXv6upS28QV4shwg9NZr1CRvAFx9Epiy13cUvHY+/O69a0vaRoiZRSIwOl1neRKDlgBz
         iOSEBmI2v/c5LvbrGhvWrbfeWh6/TVMDByG/lSM21q6wEJxh469mrxd48aBpugVzqLsD
         er0Gc5rNOtV8P/7z/1EK7NWoTxLhjyDku8Ucg8IP0oQ52RC0gslwNH7K0S9QhoLXeoJ+
         KBGTckcT2RCXCeKLmXgCwt/tut8Qv5hG9gkEgqzZ9Fd3bCYb6PwoIaqRDuujrzuZlvTn
         q4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917639; x=1755522439;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yxKwDLBaIJ2wldr//fyfdEXI0Yny79Q7D+3+DGASNQ=;
        b=isG3L9mmD7x1/TJEny2uMhWo8/NFKU1lm6GdlZFm8w2lnF3ABlR5Ih7ug8GXmewkA1
         aNlyB/dqzFIevteFHjCz6U7ApAqvYg+i+ggHbBhpNQHsVNiYhVYzwaWosbA43Ky9xEwg
         VbJ5UhmyzQI8u4ShgTrUx7WFAuRMPPA1Q+xzcJPnr2Ikx4DfhiUTOwbmTAJZVChA6caN
         JjSYaK2ogytFCbg5e/OeDBNxqkizeMv75H6FvZMWJN9UyNsIWsvdcJSH9KW45ZTaZMMA
         bt8RHOpIU9wXl/K7RHWJlNXQO7e6238g2UQ1gXC+HQF90qOQo15B0WMMI/YihgPybHp2
         9Rtg==
X-Forwarded-Encrypted: i=1; AJvYcCWyLkgQbdG4odZ5ch3j/2EpoGDq/z/aDAU/aofG1gn/VWf7781D3PPlU3r5jyyIDVyE2tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9d38qlGUpANNXvdhM15XuWp3qCWqhPNq8SlJfiypGOdrRbNG
	H29kRa0StBIyXNEPTv7Zt7ClyITXJ70ajqDKlEwFXg7Q/Q7PRSWcfXCo
X-Gm-Gg: ASbGncvbHWjCrnhs9Jn+pFV6gAgTuO/6znIZTmiGJLNBHLsopiBj6f3ImghQUJDvA6O
	ulT4TBAZmS7ZvZjXLBGWCJSX72ALNJOTzHEosT+P/Y6eoL/clHnqG+OsAznZom8k9lzx+Gr9LLJ
	GOEB5r+uioF2+gTqU+nNjrDgv3UB34X4rDQULpwlUFI1X3m8EDpwoRaQdhiIwQCS9caSHl+tNkD
	3ieUAG/JLxlcXOGknmrVbp7Dff+DOIpTkmjdCPltYcWZt4Eb5Ep0rjIN2+I2rAaLOM2XxQk1jml
	rrF5Fonl+rMnTgA69QmSvM28/E9iypdnTX7WX4C088rnNrQmF9T0ce7QCxDCVNLlTtyeZtu3wHO
	l9B3Rx8iOQA5FS2THAjJxJ6c/OTjKonxm1NCxrwysIvS5SpEc1O82CKVjNs/wpAxSQUdwwzPWW8
	n8nOUQmEs=
X-Google-Smtp-Source: AGHT+IFta+CZWNqhFfiSyC3b8Ywa/brcpMaH0/cw8v/4D1gRqnvK6rKOquhRhI01uJGmvIv0dBWZGw==
X-Received: by 2002:a05:6000:2210:b0:3b8:f864:9a19 with SMTP id ffacd0b85a97d-3b8f97ec4d5mr14217188f8f.22.1754917638671;
        Mon, 11 Aug 2025 06:07:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3? ([2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm40855883f8f.67.2025.08.11.06.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:07:18 -0700 (PDT)
Message-ID: <84258154-322c-4ef0-9ebb-44858a5d58fc@gmail.com>
Date: Mon, 11 Aug 2025 14:07:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Karthik Nayak <karthik.188@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
 <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 10:13, Karthik Nayak wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +
>> +You want to transplant the commits you made on `topic` since it diverged from
>> +`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
>> +by running `git rebase master` while the `topic` branch is checked out.  If you
>> +want to rebase `topic` while on another branch, `git rebase master topic` is a
>> +shortcut for `git checkout topic && git rebase master`.
>> +
> 
> Nit: now that `git-switch(1)` is no longer experimental, we should start
> recommending it over `git-checkout(1)` as necessary. So perhaps, we
> could s/checkout/switch here?

Junio has already expressed a preference for "checkout" here c.f. 
<xmqqldnte6h3.fsf@gitster.g>. I think that is technically correct as 
"topic" can be a commitish and "git switch <object-id>" fails without 
"--detach". Also rebase does not do any of the extra checks that "git 
switch" does before switching branches (I'm not saying that is 
necessarily a good thing).

Thanks

Phillip

