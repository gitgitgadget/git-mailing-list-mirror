Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D634A06
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757210576; cv=none; b=szhxAOv1eMCbyHy2O906NlR5MSO/H4aIRCOFGZzAhqs8jmWtHJE7td2Nf4tGj3xa1LVvR/YnO7tjLupjRnJqtSoAuRVfKGkZadBwuTV7t5zVlF0hdptjm384BWHc1bBZKF2mf9PzacMMdHawfQLwJXo9ejmUj+dk8e+9m0+1SzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757210576; c=relaxed/simple;
	bh=9nEA03iAY9jUfF7FLjrPB6rKbYg94mXrBHqnF7w0VJk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=F8sIH4WWgeBzQH8AELphCdkJAupx6lcHMipCrR9wb4buoPhQ/Ix8SCWNLKSTWHxE4YeqipdKDk1+IE8cqP+yYZ9mzRoTtdB4nDSyrh4tRqpzGXTmg/01I9jxyCkL8gsCwIV0OYJz/ywWToy3jZh/x5SeIEvOyvBLqtAFj0V+5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIpJghQ/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIpJghQ/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7725de6b57dso3933449b3a.0
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 19:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757210574; x=1757815374; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phdnvBbQ1jQDWDRM7Tc5eJDTdCgL0m6A2f5SzOzkrtk=;
        b=cIpJghQ/p8h8dI05kMC3Mj3TfX3jVNecgmjTnPvQYQRN3i4sWQN5ngl4JNxbO6REYI
         ep5agiydACfLEUUlwBF9eaEtEmzozNvQ1WEAX8hMCIiMxRMtLv1UTMDV9C179rqZxXib
         CSDSc/He308C1WKsJ5EuPW/Trg3eoDYu2bYCJCe1suKEEKWkEmyQ9xsyqwR8is4H1511
         UlwbRSZbRbLJidPsn/poC+YS8rl1vSUeNBMWRcngl8t1eGQ3THQ5g++59FKnevXl/b66
         T/N4bKJbzYp10oLNR4ucMpN37NjCjXk8tVVqOnHtXQpdlBd7GZ5lrUc3goosNANK37Mj
         a1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757210574; x=1757815374;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phdnvBbQ1jQDWDRM7Tc5eJDTdCgL0m6A2f5SzOzkrtk=;
        b=WiHwzaVJ4nep2KfKUkv25DdigeIAE1jbO+IGMStiCZtdPn5dsmuxZlad7bEU7JzNqr
         OiMx8lOY05ijepuXE4AFMnmlSiY9cj4exgYcb3itzE0tW219cvuuCMoNN6f714M5hJBc
         k3QLN3pERjAisF/6bKO+gEx/NStOM4ammAZcqtz4uC2zgvivT8X8d79lDicJiqqnBGGc
         Ph4rIODu1FzfSC17lTNHy8Es1uBzE7W9cXnDYbqp/Ym6xIrAeKNgaXRkY+BArQd8CCZR
         rOFQUr7kF/QhqgeFFk7GsgLnNeV8wzMPSCSbq1qL0akt67Sle7FP6Jfynptr2MjTallx
         Tsew==
X-Gm-Message-State: AOJu0YxpCgXiBL+dfSLbDLvbHqODViYY5ja/Jh0rcveApzyzCcowMVFw
	Tv3QcSH+I3adM1rNBZTIQuvgcLtwx6nfUuK/3Kmm2F5aLXdAReBRgGM5+jUr1A==
X-Gm-Gg: ASbGncv09TVZS4OYLdZxh84LR6Eek3RBNJzMe3zrKj5B8/T8YWF5QfT9SnTtRW6iuuQ
	iYuw5S91BORQwYJoNspFzkRuAduF+4EkEVoqHrktV2SoaChLwCoBAAnW30GJXtsmLLzBEw48cIQ
	gcGZFao1B4CybPIuN4HXuPd+2Jp2zC157utKcYLdw4G2oH9cTCB4e+HfLX8byiIuoURa19P3Os9
	cZ+GxB+hrSJy9y/ezmDLnt8O2TEkI25xFEDAvC8+MTqXT63wGg01BVlPDfoV5j/CFh8zmpsO//2
	hW+IjFfhHdvDL0e3ythmUmGGEZEzLu9jghwuWUsQVtzordC/BYRPKqTTSHwf9RgMHMy+CSiNKkK
	pmZoYruXcxqMRXsD1uuONdVttRj4mUJKlMjNU+WzRd1rnCzJnXi0CStIUhbo2Ac3jZR3DcA==
X-Google-Smtp-Source: AGHT+IE4DMlNkYO4Br7vKv+mTzZTpFZEwkG3lHunJs5Nv/RnlNkKepNHuKASlyEWEMtpvPcjpQHdfg==
X-Received: by 2002:a05:6a20:2447:b0:246:7032:2c1d with SMTP id adf61e73a8af0-2533fab7a36mr4828128637.23.1757210574434;
        Sat, 06 Sep 2025 19:02:54 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57ab9esm32627984a91.4.2025.09.06.19.02.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 19:02:54 -0700 (PDT)
Message-ID: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
Date: Sat, 6 Sep 2025 19:02:53 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
Subject: Is Git Add Supposed to Work Like This (git 2.50)?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Linux fedora 6.16.4-200.fc42.x86_64)

Let's say I have the file "x" in my working directory, but
not "bogus_file".

If I run

	git add x bogus_file

I get

	fatal: pathspec 'bogus_file' did not match any files

This is what I expect. However, if I look at what's in the index,
"x" doesn't appear. The same thing happens if I specify 15
valid files followed by 1 invalid file.

Apparently the presence of even 1 invalid file invalidates
the whole 'git add' command, no matter how many valid files
are included.

Is this deliberate?

Cordially,
Jon Forrest

