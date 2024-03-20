Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB61E87E
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977955; cv=none; b=KHfmo0af8ePs1TiHqA1G3/Dk03j9cXUvuwoSuqeq7Dlblc6+mHjig7oI2H6cHabXhc24qMNs5x07l5SdyDqyocUu7CnALgpd3LvohrShmie/eeEOes78FT/sKiBauR2pd7gGRMtqxUBU0AxqhkmPk5+b6jBY+N+iDguOcip2nS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977955; c=relaxed/simple;
	bh=/gGmysJuz154kzPuBcp3BA7CefRZ1tcrP7ct4CMN7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvGzzubtuoa39culJSV1ZEvrQIURKtZBPTlbwBwxyMUHxoTd85c9UepumezLzlwiqV3lFj40g/ixLYYA0XzjSIn2gjc3kuGmT/ICyHlwDFKlNcCcJ5bn1G/ZdltgJCCOMnzcy+ZkIQs/G6q3kUR9UEtideXywn+c+9c8vzup8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+pX0BqK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+pX0BqK"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78a2290b48eso30981385a.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977952; x=1711582752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25KjxdY9cgfhPxHWLcK/hd7wGvOqIVO30w4kIEVGA1Q=;
        b=L+pX0BqKfLvi/Q4Bp0aawUFOxu490Hw2m/UI1f65lTLImgP3yIpaY0YmSJhZ7MVT9X
         ZxI1548dscaDgfHjo5no2V3acqnjeC+N1ikLCFA15tQygv+OrhXc3UaSEC7bYgObiJeu
         tj7MjlYtVfhNDZZdkUgETAnlY/D8GtyzfuW6lmK4lt8XM84UHuZG9hP2gwKhmKwRNVsJ
         Zy4C1wwETu6vcmPIMAFz6fd8L0xmbhM9dOLsJbeEXdZh0Mn+LD+r9JlbgA6Txo9XNp0d
         YgN9BszVOCRtRRz5PrTiTXtTothFU8c1O1sus51JAvvIFZTzDN4ECbQ0dPllWMMTAPP+
         bNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977952; x=1711582752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25KjxdY9cgfhPxHWLcK/hd7wGvOqIVO30w4kIEVGA1Q=;
        b=tCIaKBjNdARTWtlK6F1u8sWPntCHMJfIf5NOS77YWwrLr9gHhQ2LEiGcajB5ThYZiO
         KKBvCOXJiIph6NW9nXwfj+0zLpq81kD5KE6VLYRmd8MIKYgsq0yaXawIWCc50CxN+Re9
         CuEhnI2kpiuFteKBwYKCQLqd8Qk/x1IWUOCuW+Krjw2Dn06ndSKfKefA18+QEuCAYCYD
         UsZeMCmZXVdmp/SG/LVKWACzuC0/3vDLsuzQZbE5GV4WTJYN//XzL93Xuw0vpx55jlVy
         /hHHYTKLrQz7mQ5Mnjp3BbpViquloBHm6QcC+48ttcKkqqURSTxME7LMGO211uHv2cZH
         C8sg==
X-Gm-Message-State: AOJu0YxWlVpBwpbVsKlm320Gf7UlBxuZAXMTQtu9m1LZ+Xs3DV+GK0Yz
	2RNQR59yrTLmeeWJHA2nQ66xyFwVFk5B5UPhqE8nPJZnPquZTZvJn1QbckCfXH4=
X-Google-Smtp-Source: AGHT+IF00uZTeVpJj304vBkqhjt8MFrcpwruIqlh7ZlV/GV4apYwLN2IhPiWekAD2CckhRCknXO0wA==
X-Received: by 2002:ae9:f114:0:b0:788:4e44:a9b7 with SMTP id k20-20020ae9f114000000b007884e44a9b7mr378600qkg.78.1710977951709;
        Wed, 20 Mar 2024 16:39:11 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:11 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 0/7] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Wed, 20 Mar 2024 18:36:55 -0500
Message-ID: <20240320233724.214369-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ultimate goal of this series is to allow git-cherry-pick(1) to
automatically drop redundant commits. The mechanism chosen is an
`--empty` option that provides the same flexibility as the `--empty`
options for git-rebase(1) and git-am(1).

Some secondary goals are to improve the consistency in the values and
documentation for this option across the three commands.

See "Does extending `--empty` to git-cherry-pick make sense?" [1] for
some context for why this option is desired in git-cherry-pick(1).

[1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com

Along the way, I (with some help from Elijah and Phillip) found a few
other things in the docs and related sequencer code to clean up.

This re-roll contains only minor changes from v3.

Brian Lyles (7):
  docs: address inaccurate `--empty` default with `--exec`
  docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
  rebase: update `--empty=ask` to `--empty=stop`
  sequencer: handle unborn branch with `--allow-empty`
  sequencer: do not require `allow_empty` for redundant commit options
  cherry-pick: enforce `--keep-redundant-commits` incompatibility
  cherry-pick: add `--empty` for more robust redundant commit handling

 Documentation/git-am.txt          | 20 +++++----
 Documentation/git-cherry-pick.txt | 30 ++++++++++----
 Documentation/git-rebase.txt      | 26 ++++++++----
 builtin/rebase.c                  | 16 +++++---
 builtin/revert.c                  | 38 ++++++++++++++++-
 sequencer.c                       | 68 +++++++++++++++++--------------
 t/t3424-rebase-empty.sh           | 55 +++++++++++++++++++++++--
 t/t3501-revert-cherry-pick.sh     | 14 +++++--
 t/t3505-cherry-pick-empty.sh      | 51 ++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   | 32 +++++++++++++++
 10 files changed, 283 insertions(+), 67 deletions(-)

-- 
2.43.2

