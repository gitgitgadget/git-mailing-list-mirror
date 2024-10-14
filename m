Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4650A93D
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728876358; cv=none; b=g5v2xyz/55bVmnnc2jKcOhO1OGHD69iDag2WAiiblsQWRs2U47aELJfhWSd0bntPXJdmDDzodTNDEMWsg/916KjF+6gwDFvK3N7dEGqg2gvnDo6fgZLZAkgAFPc/GMmumb6+8N9Uw8Cosmd0zRDWtXFWduFQJUlNZGTRZh+Ic4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728876358; c=relaxed/simple;
	bh=2oNKrNTCVeIihEfpovzymO7xK+x4/CUZQ3CfnJ8iUz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfeB5d7uQAno45L0c2/fqddHv0xL2xSntqrRi6KMXvqSZP1FuuOZEMEqKc6qEUsVgS6u6QJFiMSO3b/muV8EUtX8MYFHUO6kdccznydLMV1CPh7PgS1qpTg572d0+USn38GI9/Fob0JniEOmmal9QVXerC2YMjcK+lIjbRCWh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jzbqqNya; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jzbqqNya"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so2324811a91.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728876354; x=1729481154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofKGMkL87F9IbflS/AiX1GwD+rXJCJ0oezqqCqajLvA=;
        b=jzbqqNyavG4pKMP1H8I1XMOpG7TNxkq+4rRJ+nRh//hFUuHdKMCqI/LrDFUWybgKRe
         kw+y16gpq+ICKZ58Yv7E4WvVcV++NrtvVubLPEcR7jJVqq5UmjswE3v1C6agJKkCkEF6
         wJDNxM+sFTvEhZiWYWx0Im4zEkUnX7XJwKDxBABIlHD84qHCPwOIDitOopxFhNHcapAr
         ZTFqEf+RUdftwjpcxct5h+JiNSTfV9gBzF0A2kE8M7rEamRqv/EhQm9QaF47xZdXnft5
         RRpWZaBwz1O5wNEF6ii8jyWF9SmHoA3Ze0Kt3C4w+9y9NMgrL0xCMXhVXAdvds0hzJjs
         ytXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728876354; x=1729481154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofKGMkL87F9IbflS/AiX1GwD+rXJCJ0oezqqCqajLvA=;
        b=kdEUpBfd4UiQnu6cynVJL6GxSv4fqUvsjN7zzt6Rx0TiZIO6P20ZCvd0KS+9bTRm/K
         Uo8Hdr2VSQ/c33NW4wFPFGs+dIS1gpnGBOcVLKE+pPXwi31o+7ZjKcnglsjS6Dbrxv91
         BxxvUZ/c/m5gyUkuQ6RIXj/p2Lu6N1OnteWPOIuPYGvjYts/mG2mv0PbIOa3O2gAkiLl
         j8Osh8CO/A3ZaBIsJVlFBwtg9gR7Ww5q0pZ6J/cBsYVi+pSQPDEPaRdNHmKJoJjExT4F
         8FC2F9rgGiuAEP7KCzACkrgqr4JyNf8J34bqWK1aHyJVrZjDh5i1JOSThvD/Sqme5SeQ
         iMpg==
X-Gm-Message-State: AOJu0YyKu8nHx+9H2+e8IkGLaZzoBXGeyO7ZKVS9lGDQsd+iNbZALpUF
	L8Y/5CmJQzyfg5Qp/Ds5KKp/oefICnfrqunON7gmJ8L2qgT1rKCZ9BT6uBCAckQfu27VBbtwesy
	G
X-Google-Smtp-Source: AGHT+IFSP3OAVeCD7/jahkberYp3iPI4qHVpVXyNshhPRrpHMjVXL3luOBaG8GFef2Au8R6tAy89sg==
X-Received: by 2002:a17:90b:4a0b:b0:2e0:7560:9334 with SMTP id 98e67ed59e1d1-2e2f0d9a513mr13348155a91.36.1728876354424;
        Sun, 13 Oct 2024 20:25:54 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2ea9d4145sm6256480a91.18.2024.10.13.20.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:25:53 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v4 0/3] repack: pack everything into promisor packfile in partial repos
Date: Mon, 14 Oct 2024 11:25:42 +0800
Message-ID: <20241014032546.68427-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v3:
- rebased to master: ef8ce8f3d4 (Start the 2.48 cycle, 2024-10-10)

Note that this series breaks tests on branch seen, the test introduced by
bc0c4e1637 (promisor-remote: check advertised name or URL, 2024-09-10)
relies on the current repack behavior. I will provide an additional patch
if both land in master.

This series doesn't address the underlying problem with promisor objects,
but rather mitigates the "repack removes local objects" problem.
Until a satisfiable solution can be found[1], this would at least prevent
more promisor repos from becoming corrupted.

[1] https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.com/

Han Young (3):
  repack: pack everything into packfile
  t0410: adapt tests to repack changes
  partial-clone: update doc

 Documentation/technical/partial-clone.txt | 16 ++++--
 builtin/repack.c                          | 46 ++++++++++++---
 t/t0410-partial-clone.sh                  | 68 +----------------------
 t/t5616-partial-clone.sh                  |  9 +--
 4 files changed, 53 insertions(+), 86 deletions(-)

-- 
2.46.0

