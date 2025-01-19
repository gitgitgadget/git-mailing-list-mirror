Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56F18C32C
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737281627; cv=none; b=JIYpXUNGg8Ntq+9agPqUmqrjrUKiwgbrzkfj/504Mu3XDhm/lJdGNtYoh/OcehusA74m9Yh2l0bU3uudVCdUXSdl8q5qE0DBn8I76NszKAAwISJhFsqIQV3VTt6V0MA0j6HcBPt1QmM0VcBUP/1dKZ+X7vUU6doKbcJObpv8+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737281627; c=relaxed/simple;
	bh=Wfo3Saw9a0DWaN/sRpZpuppjsLLvTOgViAagvS+o4Ko=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=jzGao9Jo4dAyHdMfSIG/BknmQUd5VbXSLg1Vf+t7p8+BmpwfcTSOqaqBZ5ZibRM0R7hIIWK4btZZMiltR5Jty2xQFIB4ChbfQRuY7ettelJYr2zHMCnOSeP9xguxmakzfgzhT2uCDehJ5AREqgFeDtG+f46hVECGr0NxupygdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNhY6w/P; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNhY6w/P"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so6434309a91.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737281625; x=1737886425; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch63CeUphfEKC6JXmJEZftZyIEc1FTWo/nbPE4R+Ng4=;
        b=XNhY6w/PVFyga4kLjSERFLlmgWoSUY2qP37y9h6dZwAmbeSy+Wa4nOh8It7MSYui3v
         XnG/f5bhVVB7cK3vsG5X881HYv8lnGVqaV/x3uLUdVtHnBHzLaEgFutNfmHeUM2HzlZX
         8D7Zaxd5f2W+5xbjiRlNQFsNqevRIOkvtpM9vJ0CMTSGGYEai5SCoHffUBSEFDFmikzO
         Pt2e0mXSiAaNjcC+Q3iCoOfb6dxmNY7ayOqsbHTecD9Bbd+EMrhUPkF6jlT4HiCXZoCC
         Cra1522PsBqLVie9V9PVX0DzG37eq7cRf70cL3Qa9/cljo3XMfo2Beh8I0cBeWtTu0jk
         S82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737281625; x=1737886425;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ch63CeUphfEKC6JXmJEZftZyIEc1FTWo/nbPE4R+Ng4=;
        b=alnmw0xTiTx3Hh1JxkXYZZpUGkF6q3ZisVwhhO0WCp6ERc72dn8v9SlIAAYoMHSnpk
         Dyy2WHjaD3TYfzZMyATmm6FzrJtemNEgyS5UEAnsO0Fkj654Zn7sFk07shuaUb55oCkG
         ON+OBHWqPjm+lH8wFE3f13GB7vBJI6u5kI0crz98wlHe1N/VYVn6GaPPq397vCYAQJ+R
         rzHoYMYdsDkvpC/gl79pgnSY9fWtYdaTdHKMTV6DkOToyfDInjt1f5w7LGqLkNc/YuKw
         EkNuyabi+pX6rigoD2RwdOU4j6WKyVi++Eqp1P8g1fpmND9CiFhWeQEXPZIUOnAoKaT7
         GO6g==
X-Gm-Message-State: AOJu0Yzg37Mz80jcX96Fu5hI82Oqmo6O/vk0ljwzz6zQAFCvSO4fmtCs
	IeymL/gG2Hg7xQz/QP84dNLFyxDCnNitrr/9zzu6Ni3HRsbzmdhjVS6W+Q==
X-Gm-Gg: ASbGncvpQ0zFAMEJdNgLxGYP0HJnMOIeZ46gt6WZihG1bq6gMmXeWY0mcDAlhEKM9sA
	STVIll3Kwm2eH7f+UbenL7gBHeo64mq5DszYq+WyvZiHz4jR0XPov1dQU418H+dSsjIDhp8l3Lq
	zLugJr8QcnLOhlqrJU0ix+EBlkJEjKUfUfgZ0HOcfksPUtIxglZ8IkKvk5eJZsUNzgia9bkpu4I
	dZpyyBN54vrNGYriCrvmJWFGAQzkdBTEOXusv1S9aerFJ74zw7SVRKY42zbGEu+fGnU4WM1VJ0W
	Wjc=
X-Google-Smtp-Source: AGHT+IHJq3Poe6+ovUODrzusiYIy5Qim2Lf8taqYG/qqdFmH1vBFQHYgz7p1SriZNVUlr5bsB91j7Q==
X-Received: by 2002:a05:6a00:ad8a:b0:725:8b00:167e with SMTP id d2e1a72fcca58-72dafb714eamr13186535b3a.16.1737281625018;
        Sun, 19 Jan 2025 02:13:45 -0800 (PST)
Received: from [192.168.0.7] ([106.51.26.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f086csm5098525b3a.11.2025.01.19.02.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 02:13:44 -0800 (PST)
Message-ID: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
Date: Sun, 19 Jan 2025 15:43:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Christian Couder <christian.couder@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Git in GSoC 2025
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

It is that time of year. GSoC Org Applications for 2025 are open now[1].
They are due before Tuesday, February 11 at 1800 UTC. It's good to see 
that few contributors have already started working on microprojects this 
year :-)

I could help as an Org Admin like previous years. I prefer not to
volunteer as a mentor this time owing to other commitments, though.

There are no noticeable changes to the program this year.

The GSoC contributor application period is March 24 - April 8, so
(co-)mentors and org admins are already welcome to volunteer. As usual,
we also need project ideas to refresh our idea page from last year
(https://git.github.io/SoC-2024-Ideas/). Feel free to share your
thoughts and discuss. It would be great if we could come up with a good 
mix of small, medium and large projects.

Do feel free to ask if there's anything that needs to be clarified.

Just like previous year, there will be a GSoC Meetup in Brussels during
FOSDEM weekend on Saturday, February 1st in the evening. If you are
around, interested and haven't received the link to register directly
from Google, let me know so I can send it to you.

[1]: 
https://opensource.googleblog.com/2025/01/google-summer-of-code-2025-is-here.html

-- 
Sivaraam
