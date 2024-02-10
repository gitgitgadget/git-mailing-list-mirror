Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBE525B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551374; cv=none; b=C9Gsotz9HRg5/3MQ05kRa9z/TD2cvGEwhqqC1Jp6D8Mc8gkfkTo4r6HgyMJ1urskJcILjOIE05Ok9bchjvdpuW64VSNbctyhzOZPCY+9kSVe2U0eN34XJXV/UIxW6wz9TfOsDwy4gxUNCs60Ljqv2T8F2yjBzVbI4TXZA4fxPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551374; c=relaxed/simple;
	bh=gUjfnx1+TUrT2ymvp7WmebZHpKWKQri+VcA+bEuvJhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1UmLmsewGuoGUosY1txWFmxi+oAAg/PQf0QWQKjPVWRcpy0QNsEQnnvreZzwdueTdYTPEMlF9VxMafchKiLKNJkYo9B26K/2XqdNqBsGp6Sk+JZ5Au7gLxz1HkhmO6T9ZMGA6+MgN+uY/e05hMCKuA06fKjc3vTQk/dbYBGXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFKnBjb5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFKnBjb5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0f43074edso843038a34.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551370; x=1708156170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlSJEzXqwwbFHoeQvXTuIpU28kHZ+iUWTGi2td7CbT4=;
        b=TFKnBjb5mj7BNIjeqoW9ryg5Xe4dxO6RZRcLyqTeL2Fz+mtlEaty7V/iLjfRKv+OA8
         SDBLwY39hVzF1x9k1kbJjfWtw/lNtiUXtkkqJmS2XF+ypfYdiurIr9h229xgZfEPehR3
         nUWCNWoGXlOaObxtN8prOPjf/+9ghNTmsn4ebxGbUBdZgtlS7cVcL+/DVcgoKdDTtAOR
         LjpDac6xHNx5G9VywOXKYclXOSRscyKtMjYG79QhTk4TqKn63tqOgweftlwQU1l7geDH
         /sZNFP+D2Z8kVBpMjyBeFpRsu+eyya4kAcghnvXdN4ZHUQWJh+diAQkTXUWvtP3LPkoi
         Y1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551370; x=1708156170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlSJEzXqwwbFHoeQvXTuIpU28kHZ+iUWTGi2td7CbT4=;
        b=YxrvvnwF0rlnSSKuFvdILEkMfrEkqn/3mT/scXnHwFOsPSiTdEH5+fUqEuvl9OxIMZ
         uUjz5LGzNnBH+rp6X+lN1W1zYrFJ1LQQYpYPAyrhjQFDMfVuVtNxXsziy3BDIcUUw8L7
         UQRFjrwvjYO+WWUfUfAOpfz5ewuWtzlqaO4OCgr6SEFQzLvP41ZyLo1ZzyP2fuP38kdZ
         gRxJTQ00Oe1JQh3KmB+T/bc8PhcYHxzhiath4gFc7NqbfkX7k+wgAay1EEvP/ztZQVLE
         /MOyV2ZZpyP0GrY6FOcYbbOFxSZAXWTYIox5Nwyvxkmkl+ceOMr6ZFDKktT7VditaeOs
         vXSw==
X-Gm-Message-State: AOJu0Yy8IMfcW2+0RQZpTfVDrBO7Gw2xX6Ktx74KAPiwVLnWn3DfZPC7
	fBxnv4VIa40KQCqPu8PPFxzinvTi8yRSb4f5ia00rsW17UAdVPUAYmrchUwVShA=
X-Google-Smtp-Source: AGHT+IEGg1C4QACdyxwILRoZhGA9YhoNjrhhKPIAIUmpiKTGAL9yE+CuVuzhR0emCorLALzNmSLIWg==
X-Received: by 2002:a05:6871:3a23:b0:214:27cf:bd1d with SMTP id pu35-20020a0568713a2300b0021427cfbd1dmr1461863oac.25.1707551370410;
        Fri, 09 Feb 2024 23:49:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfH6z4GBuPx9yCGxp0NEquB7B1s5+QyTkxt7+BC2VcX3zdJ6ROzCxDbSN+VpcKydCnF5b/QrVCCN2dr88EiDTKIfmvWvjkul2VhEr6zm8qb902uJxWetCK1tVymPur/zNSuOGLKJzTxvihc920PIyL5ig7lc3d2oew8UYNz/q7
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:29 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 0/8] cherry-pick: add `--empty`
Date: Sat, 10 Feb 2024 01:43:48 -0600
Message-ID: <20240210074859.552497-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Brian Lyles (8):
  docs: address inaccurate `--empty` default with `--exec`
  docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
  rebase: update `--empty=ask` to `--empty=drop`
  sequencer: treat error reading HEAD as unborn branch
  sequencer: do not require `allow_empty` for redundant commit options
  cherry-pick: decouple `--allow-empty` and `--keep-redundant-commits`
  cherry-pick: enforce `--keep-redundant-commits` incompatibility
  cherry-pick: add `--empty` for more robust redundant commit handling

 Documentation/git-am.txt                    | 20 ++++---
 Documentation/git-cherry-pick.txt           | 30 +++++++---
 Documentation/git-rebase.txt                | 26 ++++++---
 builtin/rebase.c                            | 16 +++--
 builtin/revert.c                            | 40 +++++++++++--
 sequencer.c                                 | 65 +++++++++++----------
 t/t3424-rebase-empty.sh                     | 55 ++++++++++++++++-
 t/t3501-revert-cherry-pick.sh               | 11 ++++
 t/t3505-cherry-pick-empty.sh                | 29 ++++++++-
 t/t3510-cherry-pick-sequence.sh             | 40 +++++++++++++
 t/t3515-cherry-pick-incompatible-options.sh | 48 +++++++++++++++
 11 files changed, 312 insertions(+), 68 deletions(-)
 create mode 100755 t/t3515-cherry-pick-incompatible-options.sh

-- 
2.43.0

