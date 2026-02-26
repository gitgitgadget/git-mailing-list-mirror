Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13503ACEE9
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115402; cv=none; b=eaCj1joztZ1T2+7bs+KNoqfnh0A1ff8G3aZHwVOFxy7vW8OR1LnMJlqFUzXVIXZLtX3dbevHQHs8oIwqB4ALD9qkAwRL166rem5ExXes8uJVuJGaOvfyBU1rsaxL3deTK/KI3cIRHo9sI48VeYusqRdvZNeQG7XkBM0nY611N8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115402; c=relaxed/simple;
	bh=LaivFQBYjSz3KrmPX3kBhTDniXO+mT0tau0bpVk71lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUTkxIjdWZlIuYQqgVN0LiFTQfmxpl0d7ZmUVgHXx3TB9zEZj/1Mw6oS/lULlAT/3lpX0m8Awqz4VGq2PTu7Jh8md+KGErjH0ApRUGVpOk+KKIdF4YWD2qj/N8eTpTjQQrtVY9vEe8rvm7pX2ToxzegT7jLdh+h+D1m0lbm9zRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQU4h2+X; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQU4h2+X"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124b07e5fe4so55415c88.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772115401; x=1772720201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Qet9vm+5Z/4xR3sdobBbOY1GP3iNragvYG/00DSEIU=;
        b=YQU4h2+XkRRL+d4l5w0CrDtgAR3RRMm36k8ZD7LddJZmNO6CKG8e1rMks8BfoO7X2+
         SZSZdt7nnK9GTYsrMf7LUUpNAbxjnu4TW6kzU05NNBh/vAJLXsqx22PLzTUwm8fBVb3a
         r4zZxrgk1aLsGfEl5OXCAl1C+3fY1x+TxTUXreGJomTw2ZIXwVabeVZ/QF2PltUwaUUs
         Yrw7IiR6Z/wzb8TyeWisYtVFi3TsVspXWMcew6fg606bv4Mk4BYrGN6urQDaeT5S4O9D
         dx7fw5/k5a/FG2lFkommDC69EdAmzlSP7mLXlIU8j4fJNMqoQI4mP96iJJR9OTAqCe5f
         +3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115401; x=1772720201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qet9vm+5Z/4xR3sdobBbOY1GP3iNragvYG/00DSEIU=;
        b=wR0IdGh/k4tQLe0oD/PYZvW1/+IB7OFXRhozXTdkVJ+txsWdhGRV0n++uuSgMALcjZ
         kMo9aevuG72pnTO6Sw6DTxuaSdUBehmFL+OXAWQenGyRrdTBx3YQMBV7jiLqYduXkkJj
         iREUU95Tr5rSG2X4/bg5vf7adW6KZSR4w4uV5z8h7B6lVtZhyM/Nd0NSSyNTTkgRovGH
         TB2PaRbaIvZu1Po0lzcPNjeO2nK2j0XK8vJHShqDrLeqS77P73TL/ptqttNqAqEMvltR
         LswftZ12HotLT0/x6xY/kKB4mi6fNZ8lfOexOQL7msWKSbhGegYHiScXPbho01f+Hs+z
         LIEw==
X-Forwarded-Encrypted: i=1; AJvYcCUJcFKD0vM8+gRDh4GV+4ds07DPvcynrj98tJxFvNEiyCzS7+gVvylBzpb+W8pDtPWhaY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoUxUS8nCFEMLbws+9PZNv9m2hSscj0zWjE2/VfMovQeU053h
	6l25n6h/cTNooF/7f7gWm80OixEkCezIZy9HbDwhIw7ffHNG2zJbO1Kk
X-Gm-Gg: ATEYQzwssv6lh1ojtcXFcASctXGpiLWO5wZRONWnxIjqj8/ssjz33yPbJG8ouenMT+T
	yMZVDjh20PJE9PSPuq+QRUovtNhS27zhXcui91MSFSE0Vu0wb73cDU8brh1thJEnlBDNFextGmF
	F5nFDH/g+x/FQaltgSm4idfHkz1VreSNHxO7qQYsHfR0OewELXQKdcUv8EesbKXQZcM1+a+eUw+
	l3jGyaAyiksI4qDA76wnfe0YjcuNyxTDT7pvVSvr+YIHAbMDMOSDHGBcFzyMKtTr7oaUFKPb2Ou
	AcJZL/ECt45E1NmHfVQstpf3QsMF7bd/a47uzwptP+URRxwuMz3aHunZTBTEkxKEcD+x+okRAkq
	js6aawgwuWWvBt8C7rDVIlM0Esw9sYzcqVkul2ItKLZz7j4NGrLkt4OtIU6sn7QtsnQ4zMhumGP
	Q4k/ktoGo4xzFDYO3HlUuvhLVOfXY=
X-Received: by 2002:a05:7022:f8d:b0:122:8d:39d8 with SMTP id a92af1059eb24-1276ad3d416mr3816602c88.6.1772115400831;
        Thu, 26 Feb 2026 06:16:40 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f45e23sm1847273eec.24.2026.02.26.06.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:16:40 -0800 (PST)
Message-ID: <eca82f16-ae97-4dc1-8d2c-bb84cc856d9a@gmail.com>
Date: Thu, 26 Feb 2026 22:16:19 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v3] Refactoring in order to reduce Git's
 global state
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Ayush Chandekar
 <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <CAOLa=ZSyeNg7kSGV4=5wg02FYomGe0CbJ7GzCzT6okC64UWHMA@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZSyeNg7kSGV4=5wg02FYomGe0CbJ7GzCzT6okC64UWHMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi karthink,

One thing I forgot to mention—I plan to practice with a simple target 
following the proposal's process to see if it works in the coming days. 
If you have time to review it and offer some feedback, I'd be most grateful!

Thanks,

Yuchen

