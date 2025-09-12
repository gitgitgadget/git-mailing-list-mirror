Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E44214A9B
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650401; cv=none; b=YRleAooBoT2L6Os99asgacGvKVfiEUbPao7bJc/nYgmWI94mctjVpPwJktldMjuGwY5y/R4sbYAj33hiYXoQrnsoO7mevW1A0o7VlbwoQdoi1qTzYFLn7ykVk7CELAom+zdmuDuQfould2aJcaI2eziRQqbaxQkAKvJ5fo0Boew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650401; c=relaxed/simple;
	bh=Lvq56kx0Mbaj4V7YL2qnpLZ2snH2YSF0vDEoBM7Qe20=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TSd+Pds+HKvd2aR5QMwYjdqHEMZFE3NaM8b2bsRQbcQLiCD0y7IupFDTXcPJNopX/UDKsP0Bpzs2muWPkUERXBamxNMbhMU4RLmQiIGp3dJIjlyMHGixHKNfWjyMQWSEDpuLsGdRXmlcbcknTmxCDKLH10tROBEPVd3WkyT4Ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkLTcWkm; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkLTcWkm"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6241ab7fc41so603679d50.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 21:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757650398; x=1758255198; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lvq56kx0Mbaj4V7YL2qnpLZ2snH2YSF0vDEoBM7Qe20=;
        b=DkLTcWkmlMNtmdGSJm044l09KGbT/RVuFUzf7YGbpfW1oi6+ZQdNJQ8EwCAXgZl7UP
         yrtiNDcp2pe2zGPjDkPROBf5d+5E+5qwobZsZmKHif7pvClEohpHlhm62LEJLEmjmi8k
         haLJjLRQJqFHCpUH/MJXSIgQXLPXeDBMZMtCTC1X3d4RnV++g3u2KrQaiGrE3Y91e1fx
         K+6X9uFxXai/iMynhWNVkXk1Oj0nKTcM2CM5s6SvCDe4VNwxOmcyGko2UWV7zIJz6rPA
         ydAof0Rb/KJlm1oaJL9ZWXzKp/JWcP8+J//HKmfrvoLAEA8B8BHyjpWEomrkhzr0wUo2
         oPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650398; x=1758255198;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lvq56kx0Mbaj4V7YL2qnpLZ2snH2YSF0vDEoBM7Qe20=;
        b=ETrZ2d4l/k3Mgey5z1CCYoPCTr/gmZ5ScJzfHR6z8eV3d2ak0gTBJq6a/fqbGsbt3x
         p/V50IoUioykQlf9oIeIw9NlZxfWAlaEdBqp/W/THXKksq953nLlsK6TWYAQXqso5/OW
         TyPkc8g8qZu2DFLD5DasuOP/JJsQqp4yA+VP+yuRU+XiJEjUdyxzjtotXFAYXC3hjTVi
         KgEOCO85rcLgQSOYGap+kYhzQIxz72m92bUSNur66smWWzcGH9AF9wCskBO6358Zilq+
         Kay2IYswKf1DlVxxTRn4UNEdu+2+QVZqxDLDfQ/tiKxXglonesb0ZS8c5TA6wAU+WxG5
         lBnQ==
X-Gm-Message-State: AOJu0YygtKoDT/5sV935v7AMkb94WSd2BAPqHWUlvfHrSabbqr6b2k48
	vfxKxKV0G4TRXdanyL1X4X0U2GVro4j6PoH8a0JzHvbPCzSEQHrxGVOWFP+X/ejAJmxqoaUwb6s
	NRWfmZzOcNqe38HjsyU8TPn6/veSnYLQUURaj
X-Gm-Gg: ASbGncsX/7hgcDiyJTQi9wiBQsR95XnhuaMCgUBeZDjKlWj3HG/MIZPrzyiKZr30I7+
	/dByF50elqAYI1586ytqZml6qSKR4u/LMCK77C3XkEQMbVrrmoo/Yc+pZK6Ew/vJCj3oNh1Ghvx
	fRNQERTvgC+jFWmST8U6X1OJgaK7o8zKToWkVrQJdG/KyEufQx+my/ntFGPUlBDcYXz3i7AC0CT
	0/x+CIoOEz/bEpdnQU=
X-Google-Smtp-Source: AGHT+IEEUb7SxzKloy7qmlA7AdTae+L+rYoW8In6O/4cv89sYIZ+P/VXfBUqi/xCdFCmtK9u5U7DSUiDX5aL6ZaKMJc=
X-Received: by 2002:a53:b54e:0:b0:612:2caa:105c with SMTP id
 956f58d0204a3-62722978ec5mr1261686d50.20.1757650398101; Thu, 11 Sep 2025
 21:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: usharerose <ushareroses@gmail.com>
Date: Fri, 12 Sep 2025 12:13:07 +0800
X-Gm-Features: AS18NWDsbePVnRXGCT1rAK9HgsTFIT09VLfHje5U-PEDsSqxKJs5I3KhkwTB-xE
Message-ID: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
Subject: [DISCUSS] validation on git config user.email
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Git Community,

I'm a Git user and curious about a specific aspect of Git's design
regarding the 'user.email' configuration.

Git allows any kind of values without restriction when setting
'user.email' via 'git config' (e.g., `git config user.email
"not-a-valid-email-address"`).

I'm interested in understanding the design philosophy or historical
reasons behind this 'lack' of validation.

I've glanced through the documentations, archived emails, or forum
topics, but couldn't find a definitive or official statement.

Thanks for your time and insights.
