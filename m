Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE336CE06
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343723; cv=none; b=nO7ah1B82le2EZA4YpFoy9oBdfj5g0+e8TCEewNGKMq2uZQSZRQ1jsven9SsA20uuiOaEpDGKbXM2DMJ01A6kHIfGlHoMj6zhDdB0eHW1atO9l4VuejR5y7Xtr6NzIFcTBc3Q6bqAdl74AMtStSNywlHxVNQiYG9S3dXPrUziOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343723; c=relaxed/simple;
	bh=0lK0TsgFPHonw0Fe590a/oRrRX/qcht3nHYGOep3NdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjDMsznsVCc3iatLb0Hdr8dKyExxUU7NQTqJtpbKRbEFb2920jds5pK14K9DyS2aU/AyjOEnkP65FbKpoNsTf+hv0jGwVEn6tG583CmoaUHWFaQwKXNVmKej9bjZZewgN/Chj78E5YXayNjOD+K5WkF4Ts3cQOGPgucxhFwcTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvhrzHLN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvhrzHLN"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c6e8125e82cso57454a12.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771343721; x=1771948521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CPH+/SzYRuJPO5db+4TUK2jL5+v9E899t4ztzJUUJE=;
        b=DvhrzHLNRCn91qhnw+MiN66aOgcl63UXV40yuy3Wrc4aMF7kn6xJYmnbF86hMVDt7e
         uOe5p5EJspotet3/dJX+rDGvTS6TEZejFdZ4jgnKwilm2wyDaANpFaohi0nUyD5Yp+M2
         EHTdUJGj2YJdpPF3lkXL3m1/frWmJDyip25jEfjBO521Mw9CXIhCLYOlEaU4VEXyc50Z
         0YPDk4D0zbwHN4/P6aHUuVwnfuoILww+vexSYgcNcUm2/64JQQY9itVFyRw8Zt5n3Zgg
         rcPN6v27JTD5+0Pb+DQTd4AOUTrUoefN+1/hJYKNJWsSVKhRFRY/FATd9ll861b4utwq
         pv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771343721; x=1771948521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CPH+/SzYRuJPO5db+4TUK2jL5+v9E899t4ztzJUUJE=;
        b=pHzPwC4SGSqPiRM9McLwhQN3rDRg659SHzZCPW6QPPc3QyG186znZyYNAgbVb7FsLj
         Dz36MNq1vvPl+Uc6sd7OzVhfcu/IDXwq6Xq55RUMvmDs6k1eL5rl5QGIoxAIQaViwHqz
         6i9X2O9VU5jMhtvp8J3HL/OTQ33p0UkVk3kes82eRsSBtPSLfyt+bDYzDgylveq7mk7k
         KqCgILjsOT3o+6v+/43MZGpokaytpuDrEb2G4Z8LzCt/IFPkJu2ZQAmZqJZin3mXd7dK
         jdqi+bUGipduhvnzNV91g4maJXv8mBZrFUdGmEz7Dkmuibl3WhYq/LJBT93u3YFeWWpY
         4mGg==
X-Gm-Message-State: AOJu0Yw9kXUlmBneTpumtlduSnf9Wb9GKvipUUZkENW8dPoPdzSdSARI
	pxQ6sjK+MyNUFn4pPi8hUwjZyJWB3ClafbAbluLjONgxLYFUyTGONR5S
X-Gm-Gg: AZuq6aIB9bY4hAPaBPGwtB+lQAz9vTnlLFzYD7aYmtcN5ilP29BQHuALTXXz3cCgjIA
	j56ktCGAPT1DC1znIcjvTWmU4A/3yN48xCi2oVzC+eTGPLbeJ+t0YJIB4hPmDZtCJgp/tC//kYE
	bZtr97S606Jl93bWWv/VqHUIDLtEEMuTldMe64mrJXx9dEtYmwwdAsagf8giFM4AdhRWmAbGaIf
	jcI+/hqcptMiLfb1pbJdazO/ejGhGZxMjHti+mdnsZWR+qh60Dtfl7Vtpsc/USn5jd8Z3vGqJ8g
	50gpbeA2tV4vE/wTDt34Oh8V+aEQO62Wg78uG/nMSlFA0a/TXfMNqH+7xxBXtNbpOBNYBPxfroV
	ozZ+wQ+5BPG1TM28rkR0TTutMgl6nwTtH+2Tkksp2nK8NGmoMa43yF0saLjRdVLFmBHGtlc9wJP
	HwCqk7aL7EZw4x+z0pdrfhGrr7wE4QN789tIOlMQ==
X-Received: by 2002:a17:90b:134c:b0:343:66e2:5f8c with SMTP id 98e67ed59e1d1-356a7aa269bmr9963956a91.3.1771343721498;
        Tue, 17 Feb 2026 07:55:21 -0800 (PST)
Received: from [192.168.0.105] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba96d0sm18918148a91.11.2026.02.17.07.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:55:21 -0800 (PST)
Message-ID: <6e038336-6b2d-4415-8710-7dae720fd4da@gmail.com>
Date: Tue, 17 Feb 2026 23:55:17 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC 2026 Inquiry] Refactoring global state
To: Karthik Nayak <karthik.188@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Ayush Chandekar
 <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
References: <7a95b0f4-8242-4418-bc54-22e81cf40019@gmail.com>
 <CAOLa=ZQr_+fx1-j_dEbWJS=2BDUaFZ7ky6M-rLkBAWLVyd_d5g@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZQr_+fx1-j_dEbWJS=2BDUaFZ7ky6M-rLkBAWLVyd_d5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi karthik,

Thanks for the swift reply and encouraging words!

> AFAIK We don't have any specific subsystem to focus, albeit some
> subsystems are tightly coupled and hence can be more complex (e.g.
> 'setup.c'). So my advice would be to find a good balance, you could also
> take tips from the patches submitted from the previous year.

Point taken. My recent experience with the 'setup.c' patch definitely 
taught me to respect the complexity of that subsystem. I agree that 
making it the primary target for the entire summer might be too risky.

I will follow your advice to dig into archives and log to study how 
previous contributors structured their changes.

Thank you again for the feedback!

Regards,

Yuchen


