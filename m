Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51C275B1A
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315056; cv=none; b=aG055LzCGRSTbqZLBqeqj898eFmvVmf2NpkCreCBN1Y3mE5KOod8mR8m4+P1GuO/k189iLJFCx5+3zpSzXhaerUuxWLC7xe0GzV5Gs2VtxVPTJ96Kdbc/JSHS5QWDqh8vdSVMR9fXKe+gCWiU7T07BRNnA0EF39RSQEmyYI3RVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315056; c=relaxed/simple;
	bh=m3DgPnokffm4c9ayP/FeKSwF+4BFzXS97SG9aM69/cs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Aq7Yc8g3TBHgkXx/cUa2mDfAWnOjQljTLvRo6x0B38VMqWnXBXIB4BcEsnkXLHhpggjPgbko1qzAm8LzJ0WIPjVKOAHNBgCm3d8h692WPzD1S/0/M8DfOa1AIW+/MsD4yc5S0NXHrfAAx2cuZ6TtMAF4LsXYrEJarw3hqPEWe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ48EjTA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ48EjTA"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824b03d9787so148619b3a.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 23:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315055; x=1771919855; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zTeHr/J4FLBLYSqKlWDUUU3gchI/BmJKCrmGqturDg=;
        b=OZ48EjTA2gj5TlAzI8dgsxqmHhuuNQkhWsBo8aLhBiaOS2/PCdXWKWV3MY1wxefSku
         NZApTD87c3/fgDeQpDK4G+/aCP/c5y/9az7QVesKZ2E0oLIsTMUj90aC/618+ctdfuIC
         gX5XIqigDOQfVduo0dBoAmzVLKhwiXLFVbxz4Dh3+ub42OxEbOuKHx2EELi8EXlctYa/
         UvVpN1yukhgiqNzddie/3WsjjSiWG9FofDMs2nvSi3zumQNqWHUPo1gw5z+PwcyQ5IeG
         8oSBbyq+2miYgF38vTx4oJ2WWF0Ld9r0CS8Rk+1JuKc8GbMTN88P3vERL1mBQd7YNn9R
         iQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315055; x=1771919855;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zTeHr/J4FLBLYSqKlWDUUU3gchI/BmJKCrmGqturDg=;
        b=Hg9uC+h8ZsQx8QXRK/qoChmRHeWrdmqTvP5pTGrMRAg3Yt16have+XSw0N/KAzVkRr
         Fbs+r2kB2cEHFLmWbccbEaBuJEtlsjPZBbAi7nXGAiaE50GpExceb3C/VuderxotDTpz
         0xZTn33YXRfFiZp52K0S9tq+7FMsnLhIJ2H2oA22R6EfKBKq2/FfJQ4BIttrKsL+nShu
         0f+b2iNEE5Y2jONEo8E+wq9quNl0QY4KCF2MJ5N+S1bPKYYWU9Vpd/JygYZjwk50Ba2U
         Wdi2m0iuaIerbBoG1Fzl5xFqZy7XDg9XJl8Ym0uV8TnnPJUDUl/saa0VVjv3HVc+ZCGk
         0lnA==
X-Gm-Message-State: AOJu0YxXtMqfjR6M+yZDPeJ1tlie7O8n7EL85RBqYGUXwgwlVxxCIbDj
	Xy6KOasxbaX+rh7u97FPWXQh9DUGcRKqzyrVK/gegL12HMxOFL8HW8C6/bvlrCOs
X-Gm-Gg: AZuq6aJrSN6MtcfZnmSL1RADewU6yCcBTU91tnmROinrw9DMrzAgEn+6OrwZrYnXhAg
	oyHI8I/eP0zild0p6y9h1zzMnW711PmexVI8vYHh+O7jYE0pLAkNT1y3hrr9Wi7ZiMvNBoWnAAe
	zz5wlwPEb41G5EVGKsjS/EUt9XkSXNl7O2P8CP1hwbtQx2Aa25nASZY9XcSp0PV2kZ9dX6wqcQV
	cRjG4EC260N8f9I4PedaVnoF08dDrjZcD8D61pN91/nLhIiRVmMzDCdx7QDgOci3/6zg95JkDly
	p983cM20e4Qd01r/qVlazgUYtzocJNKHBt7RlBCxfgGaCCHtAoAmWCtHehnCVv4IfSUW5u+OIOC
	9Cc2teDDIzvwlVXCtbc1RQccNfJ6u3VtMbfUMii5jZeRuiVEAYt7QNY0jqbxQARK92g+D9Yyp0C
	mqKr1pxGL1zOJ3nuQvyQqYtx0GWnfuLnDSQlFcqg==
X-Received: by 2002:a17:90b:5643:b0:341:a9c7:8fa0 with SMTP id 98e67ed59e1d1-356a7aa21fcmr8037251a91.4.1771315055019;
        Mon, 16 Feb 2026 23:57:35 -0800 (PST)
Received: from [192.168.0.104] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e538d6sm21737837a91.3.2026.02.16.23.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 23:57:34 -0800 (PST)
Message-ID: <7a95b0f4-8242-4418-bc54-22e81cf40019@gmail.com>
Date: Tue, 17 Feb 2026 15:57:31 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Karthik Nayak <karthik.188@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Ayush Chandekar
 <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
From: Tian Yuchen <a3205153416@gmail.com>
Subject: [GSoC 2026 Inquiry] Refactoring global state
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian, Karthik, Justin.. and Git community,

My name is Tian Yuchen. I am an undergraduate year 1 student who's new 
to the Git community. I've been hanging around the community for over a 
month now, contributing almost every day. I really love the vibe here!

I'm quite interested in applying for the GSoC project "Refactoring in 
order to reduce Git's global state":

Coincidentally, just as the new idea list for this year was released 
these past few days, I've been working on a patch that has some 
connections to this project. (setup.c: handling named pipes/FIFOs during 
git directory discovery, currently in v4). Indeed, based on my 
experience, this requires tremendous patience, but I'm more than willing 
to give it a try.

I understand that removing global state is a massive, multi-year effort. 
I assume the goal of the GSoC project is not to finish everything, but 
to pick a specific area or a set of related modules and migrate them to 
use 'struct repository' explicitly.

My Question:

Do you have a specific module or subsystem in mind that you would like 
to prioritize for this summer?

For example, would focusing on 'environment.c' (as mentioned in the idea 
list) be the primary target, or are there other areas (like 'config.c' 
or 'setup.c') that are currently blocking other major features?

I would love to align my proposal with the community's current 
priorities. Thanks for your time!

Regards,

Yuchen
