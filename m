Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B52344DBC
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770525732; cv=none; b=IkiY1D0Ar1hykvQRkuvLea2kB6ChwphujaVTBrW5810hGQsXIkBel5hP2ra+DVrq3EYROM1rZze9NeUVpg7KLyqDOMR1B9QmsYkcTklG5bDTXpKuIxvTTRg4NoWp0eRmOhUNHuTohr5l7H7ZrwYaWWlDHN0AIgwnb9DX5AT0Hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770525732; c=relaxed/simple;
	bh=gyCvaCQTK/O6LMwKqBxMZqP6P3kF52QLaPFWNIdJgKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+bD2fCNpH88Z8ytwaxG4vToo+jtXKXUnJ58MrWuNF/kj86sgtI4xGldLQ0gsYYm/T511G9DzcsrzkiSMnexzGxIL0TmYYKXHyHhXb51eXkKjuFhcVTBPDL72pVUYI5PTBNN6TTPowM7Ah1vibRg3+39XOjlxNbVuFa9t0KPJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q59n7aoX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q59n7aoX"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so212970a12.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 20:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770525731; x=1771130531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsxDJjfpg2GsexDKpYOSfdokN2cq8sQ20d6jpDUAy9Y=;
        b=Q59n7aoX65yGuvQGYv6ZyyLrcVnki67m967kDq9Shxdcqw5xgeUYgJ8gFH0w3VbO3/
         PLaPm0ZHn0HcvfjkOfGcPfIjRjxk4FeqHes3Ft/6ij/1GlpwG+A75nJrFleLbz8zRBLj
         FbWRXiFDPVGKxe3fAi7zWOiJ4I/SHJg0+MTWsOtVJ2/yMpVdc2OElTt2NbSVbOnU4KIx
         bQfU0mfcu3uV/PnfoFbVGGotD9LtrEyoA5QNEOOIhnJCQeaMfhY5OQ++YcA2PexMQtL6
         +qfVryPABvmbLCZbrwZyXj4oxtybTTJenE0zmmSxCv/Ft156SGSV1CC33Hy6AZ4/O1bh
         vA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770525731; x=1771130531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsxDJjfpg2GsexDKpYOSfdokN2cq8sQ20d6jpDUAy9Y=;
        b=ioTOOD3RPtT25i7Njp3gvMlztwj9F0m3x3Ta4K0LYvxKp6TyH/oLoH8Jl3AZbNrq80
         12BrhY1t6LRjK0vcVWgS77aTLReSqM09X5ZUkuee5tZKkm2l1XWGKa9H9pvvD85mcR5d
         jTsj2aOHMogQHKzBxYnSnxPb7pkFMAqe9cJ7w7zwP+eHWi3NGJt6jU+wvcAn8cC/w0Zb
         omq49jjtXBZ8L7sH9ZDpLQx0XbQZz9bDQNzdYPHlD+Yj1M3rKQtpy612H72Cf7pZgu7K
         qsubiNZr8SXui5vJjKIR1jKRTshrEbzxcFWfaxCav9gKccyzCJN2UGnC/lk3I19b78zq
         GmTg==
X-Forwarded-Encrypted: i=1; AJvYcCU4SAc+6SZs21eVh5wb32EKc7ibwqBSBfCfies1K6A0fAJsFAas6N/UXQGSBXEIMJxPF3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjTjpsC9gIzItaf3nPHhY5CMaVuSH2N2ZD/FRBzcIwXTjK9d4
	T9wB9HoKZ1LZ1NhEAoKoEG2efLZoFyqkOY/0/RnBGBOjk+0Xibnan/bIwPFjX/nV
X-Gm-Gg: AZuq6aIlJWccHGb8xgS8LReUbqP4JNAhx3ZmKAMWSO7BOFPBqobf8umzhm5X5XP6K7L
	D4xaFVXybNDuoX9FcyJv8TuSZkf5/R6vCAKwyAMLmMa5CnXKLSPoW22qIvpjxAOMaCTRtaf0O1x
	gonisQCQebwBX6DP+ztxGEzjRxxZRBuZtcFZwaxxW88DEREpVOJz5DcfWewGDuJh7FTEeC6Ia47
	kmWsFIyfVCcGuNV8schsVUJfrJKAgk8zhfJl2pK1xggfmR12S9xZRza1WhHHoRDcBWUuxaaOfys
	BORT+2u+q0jon4WQxDztVhW8EQslfe9GX2JJCh4rbUQL1tQetWy8lWBsKSo5mnngTAtOPhQxN/D
	6qkPNCemX3VrMLEvBmDf218Q7BVWv47HLlAgsHLVrUlcHyxV2XIUfsYbA1ZaaawKR7amBwPBWzZ
	sW0SNlR21eJCiYXAo=
X-Received: by 2002:a05:6a00:3a06:b0:81f:453d:1ab9 with SMTP id d2e1a72fcca58-824416fdeb9mr5334565b3a.3.1770525731514;
        Sat, 07 Feb 2026 20:42:11 -0800 (PST)
Received: from [192.168.0.107] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b3b80sm6348512b3a.48.2026.02.07.20.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 20:42:11 -0800 (PST)
Message-ID: <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com>
Date: Sun, 8 Feb 2026 12:42:07 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
To: Ayush Jha <kumarayushjha123@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260207114007.40-1-kumarayushjha123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

 >The codepath read_attr() is in is usually not that hot but it is not
 >cheap.

I'm a bit curious—under what circumstances would calling this method 
result in significant performance regression?

Regards,

Yuchen



