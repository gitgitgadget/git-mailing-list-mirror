Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9C1C69D
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743342100; cv=none; b=u6V9ivji3vnPc7A8hUq6AnqyyDaAnBTN9hfjHAhKedxzyVIKRa19KKqk9bq03WLZ2eJ3XqzfWIuECipjjRmdyKRkgM3WQf6AD0GLO02xBiEhfBRJQpEIXYEXQ0FXhK8ol7bZFNjLMPh/XZmUfoDf5ntOORvrwqpo2qn1clDxuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743342100; c=relaxed/simple;
	bh=I9x/J+Q+m8GA/MbIkLXWm2SMfXJr/dQuXzLDx88S94U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHW1rw5Ntq9J7kXKGr0fOBSswSEn+C6r4g2LdVntppJ+orSqd+Pl8k0cO7iKGcr6PVHf4G+BPXwSg5RLwpuY/S23WsuQUsrIcwsmDi/v0nhE/j88SPmbnqLZWL1fBrwndNUqbVZZJ5+7LPuZlrlYpex9Jv3EEsiy/lWJE1AwhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5aHG4+m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5aHG4+m"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301cda78d48so6519343a91.0
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743342098; x=1743946898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqt2HTw/DSFw/ANqiWZbt9dtWVMDWKLYvdjLjEWpHtE=;
        b=M5aHG4+mnhJOOC6f4FOAzOtrUCKeJ3vcFwPLNnQ4r7ScZagDgFs1KjwHbU3FR9NQT3
         uzdjGhhj2YVW7T/JW5CwcA0T+kYzYrdVWRe/pR0FCCt4y4H/dvu+4WBMfyDMTkKAgJh7
         xR2dFTqUkQ+EkkhhyaUA8Hk3RioUykB5nloMmjFXceKbkH86VHEwEIX2Dnje2enbeRvx
         RWP+Fbz8hZfnWbWspLkUKHyIQvOCOBinRd6lEkGu9G1Se9uNVzSpQ9Qk1yEfETmm76P9
         uw8X1jRq77J15l8dnHxXFLfXzPZkk8Qz12a4xqcJcCRC5hbBqtA7AWcRFE/R0Wf1InBD
         Eiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743342098; x=1743946898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqt2HTw/DSFw/ANqiWZbt9dtWVMDWKLYvdjLjEWpHtE=;
        b=Y4bqr6j0nLHOmD9VQPvn5wHBSSkIrlbaa1Xs3GSzwFsWoAL/xrWJw1T60ehKC8/LdC
         CsQ42ZN7HYmZF58Fq2+1TTjUwNEO+ZXrMBWNlRdimywQnyTPP3z7Bl7yDaIoH78zanD3
         wfGHCSf90+zudXCO/h3dufSoCMEBlltPBI4LrdaITdEzxC/C33XXr1DNlhUGpZ1o71d7
         kwmGiEGlYhqbhFW+m3gj9KPyauQ0c5qfnLbYyxlAX5n2KpgIM+JV7nT2Rw55Q6giM/GX
         TIptV+kWJiVdmmkpDOHH4DTCkgQbsFMNlB1WgHC93iBOD3sypyzam2ea/RfMgCfwLYAL
         1Sqw==
X-Gm-Message-State: AOJu0YxK0i+NmrB2XatkbggXzkHJXxzn/TK38nXp5tiwy4sd/Av2n7e9
	Un5QuFYhAmeSQhAZxGyIpopBQu9IOi3X7NHAJp+hbVo/fHCxU9QKJ1BOjQ==
X-Gm-Gg: ASbGnct5d3lkr/gKimquCrgiCpcRvCBdCgMLCn9ndpgE8L0a1lCLIh1ffeyaU+IxTgB
	Fby3spQbBNaMPjqYWlvromj4DCzFWigj0gtqhzwij6dG5BD0PuQ7jRrAUm/VgLB4nNinYexlluH
	HsHJojs+HvmnD/iyPCvqx1SIM2rHVVW/KO4npdvvt9W9YiOvjbIiZjyU1ERHzdN7ua4w1xIXOSS
	bD+rSa/q+mjoA+Ltef9EezIO1QftXB16+URiJMN31tu4O+1fCfSBEAh7BO/p0nvLb1eK7fbSKrd
	ZcC4X53FahP7EfzOUPGS0iqHBJQs0HoVJfcHLOj3NupRPxPBkCc/qQTypnfyMmRCtQM=
X-Google-Smtp-Source: AGHT+IFQaa5Cqb1v+pb9B4l+sEbtrWYeN0WTo2gszIzA01HiyAcJbnt8WipshVlh5pgDXJqd8ZPH5Q==
X-Received: by 2002:a17:90b:264e:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-30531fa4e78mr10346062a91.12.1743342098042;
        Sun, 30 Mar 2025 06:41:38 -0700 (PDT)
Received: from localhost.localdomain ([171.60.225.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d5786dsm5996620a91.11.2025.03.30.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 06:41:37 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Atharva Raykar" <raykar.ath@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v4 0/1][GSOC] userdiff:Added newlines at the end of the test cases
Date: Sun, 30 Mar 2025 19:09:56 +0530
Message-ID: <20250330134018.9662-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250328200525.4437-1-dhar61595@gmail.com>
References: <20250328200525.4437-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While making this change, I  considered whether shell scripts can lack a final newline and whether it would be useful to test this case. Technically, a shell script can be missing a final newline, 
and shells like Bash can still process it. However, this is uncommon and generally discouraged due to POSIX and Unix conventions and
also although Bash can process such files, missing a final newline can cause unexpected behavior in edge cases—such as when concatenating scripts, where the last 
line of one script might merge with the first line of another.

Given these considerations, I have added the missing newline to the test files to align with standard conventions and avoid
 unnecessary confusion for future developers.

If testing function detection in a file without a final newline is considered useful
, I can add a separate test specifically for that edge case. Let me know if that would be helpful.

Moumita Dhar (1):
  userdiff: extend Bash pattern to cover more shell function forms

 t/t4018/bash-bashism-style-multiline-function |  4 +++
 t/t4018/bash-posix-style-multiline-function   |  4 +++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 30 +++++++++++++++++++
 t/t4034/bash/post                             | 25 ++++++++++++++++
 t/t4034/bash/pre                              | 25 ++++++++++++++++
 userdiff.c                                    | 24 +++++++++++----
 8 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

Range-diff against v3:
1:  3d077fadc4 ! 1:  40cffd3b4a userdiff: extend Bash pattern to cover more shell function forms
    @@ t/t4018/bash-bashism-style-multiline-function (new)
     +{    
     +    echo 'ChangeMe'
     +}
    - \ No newline at end of file
     
      ## t/t4018/bash-posix-style-multiline-function (new) ##
     @@
    @@ t/t4018/bash-posix-style-multiline-function (new)
     +{
     +    ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/bash-posix-style-single-command-function (new) ##
     @@
-- 
2.48.0

