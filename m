Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3928DF1B
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046602; cv=none; b=FeRdeRZYGXLBNVo1h9UpqI1fZ1KgH82QKlHXkUuhjD+j2GJ5Mkflp1/MpO96zY5r7VZe02icZkge80VOY34dYP6dY3Xw24gj55BgNc5SaEcyjuwYTa90q9jHpu6rENLOkMLwUg8/WcMOvT2h5yT9W0Rq3VzPEDfHOcKf67Q3EbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046602; c=relaxed/simple;
	bh=2xLvFnZO1IsfguQ1Pw96mdFK+lBBFyXrhWHE2P52ajM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JzLstYw1hPB6gtdfGtGLjzWc7hsAxErod0QxMaSxc9ZUwhqMVqdMrZ95sP168uIDI+XYA72LcT/JawWwFsFsAE8Kv6lttRfo+AOs1Y2h8Z4QuyCydGEP+JW1pwd/xPd5v6kchCDzOv7CfVKxRKl+FGHnWwt+7JuYYd113eogVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxSiUoxe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxSiUoxe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so46990745e9.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749046599; x=1749651399; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/ejsdh9jAn787bWPFhSPCEPj0KFJ2wqDGjggFJDNxY=;
        b=cxSiUoxest0ZQNveuxwfQAe+wd+vSNXfYNQEHCryIdjnY0wOk5OmTB7W0usUbc1sbT
         GoB3MBlzeThkgub9WOUFF9TpsN9CkIIi1U2ADxNWmFKMFCbM+c6PAzE8JiFbfFJMcFGz
         30vWJyApO9dsm9/USxCuYQbz3Th6IC8agHs4nHu3rpaj6NGo/UbyJgohJTOIWJWDT11Z
         +k7LQktXG8vNzY1xz4G0Cf6jI/YKcDj+5ESUFATLQ6tek2DW6fQIuWGxEq9mRPXl9NBP
         EJY1gpjCHz+gZdXSdO7Ta+c/q71TYUZtDqR7La3yM65dCmd41n1zD2Gz9/jEGtxC8Mds
         sOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046599; x=1749651399;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/ejsdh9jAn787bWPFhSPCEPj0KFJ2wqDGjggFJDNxY=;
        b=Eoz7LRPVeE7Z6ruFtw0wBEoltXGGLG89NfXBWWfYoeRcPVAO8WQoVurigsU8GbtJGz
         RyOXRUWvOCT/cK5aj3/VjldmdSCFN+gcgT33KSN34UF6ft0ksQZwpLcGTzLpF60kGlLp
         f7IzvWujr87TaLLYo2TUzTbIhf74IJkdYAhrJgj2mX4gtcbf0lX4NIftRjlORJ5OcAx7
         yFF++BASi70pVXnB+zhGqFO+OnUSJZWNsJfeoe5ZGR9aXOKzIn6/DCQMu9Dn+eR/lnir
         bsApqdwc9kDLTDntjMQOpj85vgUm57smFrxTXj29XKojKRxLgXdNftXriY2DO66NnIAq
         scnw==
X-Gm-Message-State: AOJu0YwwNL2k65OGRVTq0rc2YJTZYQK1f1ESFXSjwY3lKcONzuQEiM2B
	K6+vteiY6sjeglK4hcL/VV4HJ2p6eQl3BQAVRO7J3+SPvK+CKqvw4WBesDVdbQ==
X-Gm-Gg: ASbGnct77PDu3ijLRXkKB7NhqNf14ysYCeBWzp84pDu7S6NzSI2SIR77lX4GaNVEGX0
	DvD/tVfy0gVG8E90zJYjSr8wE8pdxAvcdQ4z8u3lJ6gruIJz8wx5kg+gn289nF3SDKjamYPOVoR
	01lPHNB+55UzJfiOvt4eNjMEkScrGg+J0HhNynelVq61qYXdwaSTBrOwAQ9jAecSvrB9QT7SjSm
	AhNv9r8a/FtojwkGcIcPJL8pro8nuHMP45BWzD4LZrrMcv8xJLKMFkV2jumoS6pOHZTFAu5UeZv
	Oyr1AYpDGoRDSQn0nladyEqJhfpKLIdgsFksfLr045RPvpvpuv+P7FORGErXMk4=
X-Google-Smtp-Source: AGHT+IHo9rIVdDe0KHjxhRvWD8YWdJQftyiEMd4dNpyIumfl7ZRKzuVeawH4FpziLcTzGczAkS6rdw==
X-Received: by 2002:a05:600c:1c29:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-451f0b3f724mr25270855e9.33.1749046598486;
        Wed, 04 Jun 2025 07:16:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8ed27sm209417935e9.2.2025.06.04.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 07:16:38 -0700 (PDT)
Message-Id: <pull.1928.v2.git.1749046597.gitgitgadget@gmail.com>
In-Reply-To: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
From: "Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 14:16:35 +0000
Subject: [PATCH v2 0/2] contrib/subtree: Add -S/-gpg-sign
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: apenwarr@gmail.com,
    Junio C Hamano <gitster@pobox.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrik Weiskircher <patrik.weiskircher@nutrient.io>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>

This patch adds support for the -S/--gpg-sign option to the git subtree
command.

Currently, git subtree creates squash and merge commits without applying GPG
signatures, even when commit signing is configured via commit.gpgSign. This
causes issues in repositories that require signed commits for policy
reasons.

The implementation ensures that -S/--gpg-sign behaves consistently with
other Git commands, passing the flag through to git commit-tree and git
merge where appropriate.

This change improves compatibility with workflows and repositories that
enforce signed commits.

Changes have been made to this patch according to a discussion with Junio C
Hamano gitster@pobox.com on my previous patch attempt.

Changes since v1:

 * Adjusted commit message to not mention the not implemented flag yet.

Patrik Weiskircher (2):
  contrib/subtree: parse using --stuck-long
  contrib/subtree: add -S/--gpg-sign

 contrib/subtree/git-subtree.adoc   |  19 +++--
 contrib/subtree/git-subtree.sh     |  66 ++++++++---------
 contrib/subtree/t/t7900-subtree.sh | 113 +++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 40 deletions(-)


base-commit: 0bd2d791cc9f745ebaedafc0e1cbebdebe41343e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1928%2Fpweiskircher%2Fsubtree-sign-the-second-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1928/pweiskircher/subtree-sign-the-second-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1928

Range-diff vs v1:

 1:  fe7e918ba18 ! 1:  5bbdbf01636 contrib/subtree: parse using --stuck-long
     @@ Metadata
       ## Commit message ##
          contrib/subtree: parse using --stuck-long
      
     -    -S/--gpg-sign requires an optional parameter. Optional parameter
     -    handling only works unambiguous with git rev-parse --parseopt when using
     -    the --stuck-long option.
     +    Optional parameter handling only works unambiguous with git rev-parse
     +    --parseopt when using the --stuck-long option. To prepare for future commits
     +    which add flags with optional parameters, parse with --stuck-long.
      
          Signed-off-by: Patrik Weiskircher <patrik@pspdfkit.com>
      
 2:  45ae2c31bc0 = 2:  af5b4a65b63 contrib/subtree: add -S/--gpg-sign

-- 
gitgitgadget
