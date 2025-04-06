Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E01D554
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743941722; cv=none; b=ulaYy4eB4uH0wC6eHFlB0jfViN347/jBpDaEs9G2hxmyzixwBs9runxjLJwhhpOBAJj7Cyh3wItDEEOvW/Kqz5riR47w4nn1cm5vJIzR0CaRsbLY/HEV9N+44dStTAGSj8UWm2dby1/LyNZahZUFozuX7itrRHJde+EvzRIE/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743941722; c=relaxed/simple;
	bh=w3brqMO0+Ua7ZxIairshSXBktptM5OVe5Dqe/Gyy/eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjfN7nH/xnUE/Vf/CM1XxS/DZoP79TUd3nsABVVjIGfNl0wyuf1WHCF8A4BuOI/BYQweaLKN26C5X/pJT27+5fTsidEAnRpNy0GIgd+XCSfDe1QAFnF7IyDoKwnvyItTS7RIeni3x5Mdtg71QZwxddT/6UHVu1hQO439Pwqlwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoQ0+9NA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoQ0+9NA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22548a28d0cso46724155ad.3
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743941720; x=1744546520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jsdQ2hwGvyD2KGLg8vKQGNw10B2MG5mtT2+d708/fI=;
        b=SoQ0+9NAKqxYQl1tNBJJfCHm6dJv3z/0Q80cSGpmjZr+19aIqSm/HUp7a/SIue3Fof
         Q6+SYg5U+LVuIJtIKmn5n6wPzYMCRi9b8yw2wogqWMtn7fXtAFZ9/A+M3BpoaAyktYN1
         xjp8XVGxkwRDLPdxux3JbfHn4VnN6dU0rD6gXwxJodudJoxChmUf52lEdgVSAKwBI7KR
         1zSIxRSYpUv0MWv6GpqbUxdTH18xZRbNppkBwMpgDT+wiytNAQCOFvw5UZ/wcdc2xBfx
         0GY75wfvFpXPdTGqT68gU1a3+z5mCSFRzCktxoUNWPfsLF7zVFOI9WS1CbPk4qCLRHue
         wGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743941720; x=1744546520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jsdQ2hwGvyD2KGLg8vKQGNw10B2MG5mtT2+d708/fI=;
        b=mT+zdvqzKJuN5Nv5678TeaUzgno1cSD3Smt/YNB7To1j3UkVrMGCQ0boUwuwW4OyR1
         JKnTH4o7Wg0OezUfT2kV29CFM307L2I2MlUkn4SxEuZxgOQqRi4H3GMdDADgPpUF/ZON
         MwlTqXsd5IvNEVzPjm7JAOwvxudZTtXBjQqkLh8UL4Ig4+k6fg7qTPsVSdcFPREpR4Q0
         NKfpK4/IefheldmTMsAiRrzU7CLu97bMzi7dbKNO+nrfqRP0DSOjws6URy/ik4BcXzat
         x1CQErf+8sWHLMXNKsSTU+3ltLjtnjdsrMkfRvH5dkPljeBj5vSuoPZewx3Jk7yGEcZs
         XKjQ==
X-Gm-Message-State: AOJu0YzRvtR9L+vtT8Mecs8XRQb01KETU9ryav8/rWTejySpjc4pV8YT
	PB0LdjodsG1Qkzl0FUc7Zg27YfqpkLgKqofIrP4e7/US+IrSP1zFjJGalaKS
X-Gm-Gg: ASbGncvM7AGZMo+KINWD8ZT/PgOYKDMI/2Fkyxw8Wf5CxIpkL57l1b4Uz39Oksx/yAn
	DxZmy5IlcAnL5Ts57K3TRWUTw5UcskzfHBWu3wX4RjIUop0mZl3wbrdv3kvc1OhGk+laM0XmVXf
	rO3nfSO/qIgB0TVHi9GT9e8JtIbb0Z5IHS+Srt9qVQtZgyAIVDUJcBRtVRRzVOQmcyeI6O+oFPe
	w485Y9w1OiX4bPGWeyhP0DWgzZqEMf8KsMX1RiNr8wpqW4ztVju/dMePp1thjnq3MHB16yhLUWb
	VBZtP7FjDQ8X1GqohzuLtonvh/srQ1CwVkozLfGdKf0uop94adlqk8imaKAqXRLbiQR6mg==
X-Google-Smtp-Source: AGHT+IFDapoRacEq0C0zXAy80m3EeX/Qibzyoxu+1u8QfBY1nX6w79MDhtTAqrx1NgaxbBX3fxLHCQ==
X-Received: by 2002:a17:902:eb8a:b0:223:377f:9795 with SMTP id d9443c01a7336-22a8a7cb9d2mr126554155ad.0.1743941719914;
        Sun, 06 Apr 2025 05:15:19 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978772ee4sm62410865ad.233.2025.04.06.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 05:15:19 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v2 0/1] remove unnecessary if statement
Date: Sun,  6 Apr 2025 17:44:11 +0530
Message-ID: <20250406121513.154084-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
References: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an earlier patch[1] (1a764cdbdc (Merge branch 
'ua/some-builtins-wo-the-repository', 2025-03-26))
which has been merged to the master, we checked `repo` is not NULL
before making call to `repo_config()`. Later, in another patch series[2]
which has been merged to master, `repo_config()` was taught to allow
`repo` to be NULL.

So there is not need for checking if the `repo` is NULL before calling
repo_config() in the earlier patch.

Also, Patrick suggested having the test inside the
"t1517-outside-repo.sh"[3] instead of having it in the individual test
files like[2] and I also think it is a good approach as we will
have all such tests in one place. So, for this patch, I added the
test inside the "t1517-outside-repo.sh". If this is accepted, I will
move the test for previous builtin cmd which has already been merged
to master to "t1517-outside-repo.sh" file.

[1] https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/
[2] https://public-inbox.org/git/20250307233543.1721552-1-usmanakinyemi202@gmail.com/
[3] https://public-inbox.org/git/Z9vCDFRUG7IzU_AG@pks.im/

Changes since v1
================
- Make reference to the previous commit that this commit depends on
via "git log" 

Usman Akinyemi (1):
  builtin/update-server-info: remove unnecessary if statement

 builtin/update-server-info.c | 4 ++--
 t/t1517-outside-repo.sh      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

Range-diff versus v1:
1:  d6054cbc0b ! 1:  020b228eb1 builtin/update-server-info: remove unnecessary if statement
    @@ Metadata
      ## Commit message ##
         builtin/update-server-info: remove unnecessary if statement
     
    -    Since we already teach the `repo_config()` to allow `repo`
    -    to be NULL, no need to check if `repo` is NULL before calling
    -    `repo_config()`.
    +    Since we already teach the `repo_config()` in "1a764cdbdc
    +    (Merge branch 'ua/some-builtins-wo-the-repository', 2025-03-26)
    +    to allow `repo` to be NULL, no need to check if `repo` is NULL
    +    before calling `repo_config()`.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>

-- 
2.49.0

