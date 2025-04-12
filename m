Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591501946C3
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744451177; cv=none; b=Uv+qPKryHlTlEtwm83dtnlmqYRy+9zRkoUZlUFs4z72xawIcq0CXYVSOI6WDkvO9YqK9oJ1RvrXCp8B7DyZxDuZJ13PIKm319qqBwr/sgk4cB+EPciP6ba9peG/Ih37ttBe/+VeCe2494uDAxEb2HFR25qrtC5g6YbKLBq71Vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744451177; c=relaxed/simple;
	bh=s8oiEIPN7R/C+zs3iBUGuLgBashwnaIbHZy1EHK3Spg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKztnd/zZ+iFcUBUOTF4954AUulW4syx4pAzmM7A0QwaugHmCKbHG4QfQlQ6B/dQapnL2UnTyu2lP72IAsl2Oe89Kv2HAuOTWFCz7yk78bgjRvfSGjsttMOHHNRSJNfkXNJfY61hopGPbvUJEG5dusj32WxLzZQcjWrKomVi8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi8xoJSQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi8xoJSQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b350a22cso2413426b3a.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744451175; x=1745055975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYbLaEv9p8Kj9Cb8cb85hexRq7nRLgBxNkpUOMDWHXk=;
        b=Pi8xoJSQJIQ50fCBlIz3RLy1mj2uLdKE0xWBKbPj332Cn/Xsoc9jiisxBPkKyfdyWC
         /Cfh2JH/MDn3OI1SFnmzaXGYCUH19Ov/+7BnWCs0Va3jF93WwVn2dCIPDZh88LpUnJwZ
         YBg9+YtRzvxLSN7/6bf9PVFl7eT14oEMcGOSXKFzCxd7Aucp5P3zpmGdEYBzLlioBuyL
         C7hUz63cEvrem3M16lyvK6PWlaPGz4L3KcVXOswXmt3PZ6oVNxhDZRVPad5gotS3nHyC
         t5zrR3UAkY844vjwhgcm8YWuted8GapKgP5VSS3CIGg5ZRsftPzzjxkBWE/HRUIONEc7
         1aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744451175; x=1745055975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYbLaEv9p8Kj9Cb8cb85hexRq7nRLgBxNkpUOMDWHXk=;
        b=AO+YptW+zR33QDIxB9CkRo03VvypFllIFcYBMMONDdPoX05OCbWthIFS7RBoyn+yte
         d8VbyDEfUBPZChkqDB3ga52y0ei9eqm0gHC0G5MBzjdZcXeWKIUR0CgbDM/l1eFgdbLu
         wTV56qMBkfSGEL5BKby4ud60QJO+7KAVyOynH+bB+sTqkEYYU0yHMOEZd+6OiuBG0z92
         Okc+bopwoVvN/6ooSnMKK5fahcIIgE0pd53iUgwYksz13C2HmLAfsbfevvxRnn39CnTW
         xCOr2EYlrE7KSxvgh1q6rwWNAuA9Xwd9fzObclGsvpjLjPk97lNN6Qkiu9CDCCsKFDUJ
         V/Iw==
X-Gm-Message-State: AOJu0YwMMaZEnJTOz54arJKbm5QulJlUeyFS+b6kvbV9Ya6FDzhupx+l
	sYqnYyNKsnlxxIbmC1NCzJ4JleFsUlk6lmm/L5AbH6X89DQc1aat6b8VLQ==
X-Gm-Gg: ASbGnctYqROBM6pmsWOYdkfCgsUBmRePRAExSdIa97AK5bnteKfilwZ57v7hLANdP45
	SJjpUoekXTDHEZ7XzlQ+T/8mWskIXyNzylDjzmLevZ5Q8q/n0nF4HKK7wFFoXd2MRkp6phrJjxn
	oW1mK86CUJ/T2Bq1zqfFpEFYKugjV9DBpwqBKvpDkwk2W87Z9MhomRQOgaCmdYPT36NnCqQPacq
	D+80OBNSy4pJGHk54wvZ8krgQKpQQOjv9mM45ZC/sNBepi7pqA1QyK+DYV3Ia+Rn2m9m3XLrE/y
	OJrac80LWgpsQbN9cfDmL/q/QKRjUyHDZM3cOEfMkjz+wqU9m/m5hhgkM7X2QevvDwZNgh3Eqmz
	ToWywZ3LbMQ==
X-Google-Smtp-Source: AGHT+IFgeQEfyOYTKMK6W5dvliNVAmUiq7NSRZkGDEXtidspK+/g2HS5zn12Z3sGPrwsp1l2Mh1MGQ==
X-Received: by 2002:a17:90b:254c:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-308235db9cfmr10317688a91.0.1744451175078;
        Sat, 12 Apr 2025 02:46:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd2ed48dsm6354395a91.0.2025.04.12.02.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 02:46:14 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 0/1] add: fix pathspec handling when literal filenames match wildcard
Date: Sat, 12 Apr 2025 15:16:06 +0530
Message-ID: <20250412094607.236382-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug in `git add` where a wildcard pathspec (e.g., 'f*')
fails to expand correctly if a file with the *exact* name ('f*') exists.
Previously, Git would incorrectly add only the literal match on the first
run and skip expanding the wildcard.

With this fix, wildcard expansion behaves consistently even in the presence
of an exact filename match.

To explicitly add the literal file, users should quote the wildcard:
    git add 'f\*'

Thanks you

K Jayatheerth (1):
  add: fix handling literal filenames and wildcards

 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.49.0

