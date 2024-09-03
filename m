Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFFE1CA68F
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372053; cv=none; b=KB5Z52yRrK6FNd5jApHUIq2eShm35nIMAhQh0D88JT3fGqXnmERFvZWQcaESnpZWA4B+S05OkHeRE4+p6RI1flm2xudXtpPN4x8D/FzhFaVnuWdw03IbjeT17ajZEpQ8mF7c0PfuSI13kGBaDZQdcjkKLcxRcQZ3lM0aCcxln5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372053; c=relaxed/simple;
	bh=cZYRK8fJSsNXWgxjD8TTYdynrWYX00PoFf7ptnpe8PM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LmoFNLjK0M4N+CDkU49M5fxmmVMCBwPoe9MQ37yMdf3n5KXhLmdeqyVOqC6imBz9pbEwt78C7X+BlMZ3w3FTDsdzdXd1zMvbX66xyIUzf8p+1B4wISeptmqLVqCUoIu7Pcrern7qSWBOVS/GHnylmUqGS2EILha2nrkjuROGMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYqLSN55; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYqLSN55"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4fce700765aso1653642e0c.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725372050; x=1725976850; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZYRK8fJSsNXWgxjD8TTYdynrWYX00PoFf7ptnpe8PM=;
        b=AYqLSN55w0HbcErr2KkqqqgWEcFlM6N2ZQ81b+2HGFscg3a1kxjzCEBenrcbkie1Qm
         w1Ou1INoqWPFhvsRPmGcTJkEO5NtpgWnnHxuyDUyGSFtU06N8w1PX1Jm97UZ3ibNSfnj
         n0FWVbAmi3OKKLqfmGCca5zmOHFXqkZUN/LjUxWjntACZyp7Q3SBc4sQPYhPCW8acl2u
         Lcj6LQ6Mze6iD9f3ekQL+6MZaeREAMGOF8IvJdAMh/JD90eur243lsbqU/ZQf24F+0mf
         ukNDuya5A15Z61zaXF58e8pJoK0vcgkLrW9BJjv7Qq92Sr1uXJIOYEjVutq1Wt9n9Ukj
         rEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372050; x=1725976850;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZYRK8fJSsNXWgxjD8TTYdynrWYX00PoFf7ptnpe8PM=;
        b=rEY0FRxNQMrhPSGIhgJP1TTZYVhWCRMBVMYg8RdIiRtyZyhnHJgnZclTXxp5yYGtvh
         WMPp5K6bFXMzWXyETK3ZZar18xj/UuNcW/2SUlH8G37dhFKu2CF7BHbijrGOPSpsg3AK
         Xmrpd1v5MrNkBEySamd/CH2wID8SX3SAujQ2odBdQUa35jVDSFg0rw66B44iEheR5uWQ
         aflCttdxvaQXybvGu9ppyrWrcavBCYDJoKzfDufLCDY9CK7RDpZpNAqTaaqqUOLCEu2C
         yFRshamHw3blQffMYJogH0Crrrjn8hTIdxNLS03dPWGL0YiqbqtlGQIgXa430rsI3bYn
         b6Pw==
X-Gm-Message-State: AOJu0YyRHFIsWFSSrcFXgQsYNJXUvPKGKXejIeJJmMPpFyiWVR6xKsHo
	jW6ebrppfkfT1Ha47zy2Z3aJUAgqrZJ5T3q5kk1KLd2tprl3d/id+oc0E+2WoYMgyGo94nKFMLo
	8wMidVodGz2GmYraflkK2G9+f0N81bTo5ixE=
X-Google-Smtp-Source: AGHT+IHDUBcBL15wyx4hlJFOdDnHSdFN/Eh7EEP29d1JOnz1b1dfQQzWwCwKgilg/or7JDznYzCftebX+gw39r/DvZw=
X-Received: by 2002:a05:6122:925:b0:4fd:591:e30d with SMTP id
 71dfb90a1353d-5009dad7e37mr12082672e0c.2.1725372049523; Tue, 03 Sep 2024
 07:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: tao lv <thebookofunknowable@gmail.com>
Date: Tue, 3 Sep 2024 22:00:39 +0800
Message-ID: <CAFePT4wau_YG-3wOs94YrJ42im+x=Tp98Fu6vBJUG7pVDviO0Q@mail.gmail.com>
Subject: Is it possible to resume download on single file.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi:

Is it possible to resume a broken transfer on a per-file basis in Git?
I am currently using git version 2.44.0.windows.1 (Git for Windows).
Due to poor connection between my workplace and GitHub, cloning
projects often fails.
Therefore, I often operate through the following process: (the
repository is chosen as git only for example)

```
git clone --no-checkout --depth=1 --filter=blob:none https://github.com/git/git
cd git
git checkout HEAD -- "*"
```

This allows me to download Git files one by one.
However, sometimes a single file in the remote repository may be too
large, causing even this method to fail to download all repository
contents.
So, I want to know if it is possible to resume transfers when
downloading Git files? Or will this feature be added to git in the
future?
