Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF614659A
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735430327; cv=none; b=sJVMyF2I8ThT1jwFc6RCKUdEvKIWlLUvLOKnfnYQPii9zXJY11C209pVANH8IUJxIE2x+W+k2DFSeG3sL9A+TGpy2YQdLzipsQI4ZWF1RP8bzscieFtWicnZvOxvPYmNonlVzI5M4Vi1wsdBbMnTKGMRN5/wT4kZuvd8pEbYPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735430327; c=relaxed/simple;
	bh=H7nmiHEAE69/KwUAOoyk6MGCaehrTN2Or9UwHVMow+g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=H0zt8ZlRauf/tZCRnnTBj+JCeps+yFNX+zDyasI5R70empn79p4Ug7RVVibeevfuFtBbtLGx1dbw6Jpk/Bm+V3if3M3aNaeEiAit7XH9QB+zWd4SnlEJkvTGWIhraTW80Wi6IFcNobBgKWujPW9OcHbpLAqv2kTOdcMGxdPkoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrwzD8hv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrwzD8hv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso710091666b.1
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 15:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735430324; x=1736035124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :return-receipt-to:disposition-notification-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7nmiHEAE69/KwUAOoyk6MGCaehrTN2Or9UwHVMow+g=;
        b=HrwzD8hvEbKbICgCBvoHuZj+RINFrp2zeBrGthKvtL3hJN6vlYyYFiFy6gr1+OLFeB
         HQP7QOmWPX8nR1HcTmdZd4YiMvfbBVL7BhK9Q1FrcThXEJGJzo+t2fPzPllXQgQ3rLg7
         FRvvEa05ubOJ+KAjZsjIKcO40l+fiOW7T8b1dqbShMsuHFKEaaVF8ZiHgZnMMTjNGH85
         TYzu7HxpJsuF8UeEX6UAy80GeZxUF6ovoe/jh7LPKl2WeXZbQ1z7oYcKgxvQyiQo0whL
         eXQgCzW86cUUJdzWpyvFSt0jU09zqT9zULnE+Q81f4R0UxBfLX10uYqrTBiAB8loMjj/
         4WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735430324; x=1736035124;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :return-receipt-to:disposition-notification-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7nmiHEAE69/KwUAOoyk6MGCaehrTN2Or9UwHVMow+g=;
        b=NSKC6R9RGULKe9C8YOJnPjvEAobQUeFbb6tyVRTN7wX7KYFoOW7I3LjVLIjzbc6lb8
         wdvp0pb7P5w1v/Zr+Q8nWu5yePsRjKRRPqBqsHdR2wdPfW9c799JpkVpBmfqFyd4UryT
         Lz51wdV8bFaN5ExPqRHoH3x9IY3dzdt6fYfQapl7KXbBFO7PoyZn3jnKS1CP9/lwE2gZ
         OwWcX1e1rNMUhWggkaEfCfXHvVO8dYQamuO0BxEn730hrRyb6LYnFefHVLFa72EmPAMm
         IRHhiAbJna6g2Uf28VeiVCRjquW5imu0a3F8TG8O3NUfO0AgQ5A3EgAgkFhDsZx35Z9P
         bi6g==
X-Gm-Message-State: AOJu0Yz1AHsZcd4F/e6lU7MiLW/IsJoM6CPhwEudrWmso1B4WbgbBhKp
	ZczXxBz0ga5T6+hkEYXk9qs5DcsfzIQc7nWzhRRZ3BN/TC44qCZXGRjciUyCVOUmZx2e
X-Gm-Gg: ASbGncuZTSAD7pLAtNJtQMuuiroTK15pjIdHeBz579+qIqwyZUgrGH3RgMjtTkpf8yM
	yvCJFQw9shrcIHE+KNG5hmy3BVLLxnvAN0N85r2ghe7RF/m7cRAXP/LlS6/ly/FZLEhLF7ZhVvu
	iA2brGmuSmpAphhORLqxKg447MJVnmHK2AM8V7Mw2ttFVaTfXb0KQyypIs4n8RcrTl6ZGRRlWSM
	OeqkEk8jJuB7m5im/KbSN8rIeb4JXaDZetEyzkHqy7zIkTx0frrovB8BA23/yyVJ3up6TeikEHN
	mDu8AIPeiw==
X-Google-Smtp-Source: AGHT+IGcwi0GNqOC9UFpuaK1cnSm4DkYzIhGQ62PqyyqlEPeXYpAR1boEXne3tWGoZNYpLcZ0jxCUw==
X-Received: by 2002:a17:906:7314:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-aac2ad9e06emr2587348466b.14.1735430323994;
        Sat, 28 Dec 2024 15:58:43 -0800 (PST)
Received: from [127.0.0.1] ([185.252.220.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895d31sm1310080066b.61.2024.12.28.15.58.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 15:58:43 -0800 (PST)
Date: Sat, 28 Dec 2024 17:58:38 -0600
From: Google Account <rtqenh5emx3s7o5vmnxtasgr3pgciy@gmail.com>
To: git@vger.kernel.org
Subject: digest ETA
User-Agent: Thunderbird for Android
Message-ID: <41B080E7-DB4D-4F4E-BCA1-9D7A13BED84E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a new ML acct=2E How long before I get the first digest?
sent using Thunderbird
