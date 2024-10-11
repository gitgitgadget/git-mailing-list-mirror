Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BA20B1F3
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635057; cv=none; b=rg6mJcfWtFzGUzKHiy1Oi8MRWt5C7TZSmHQUO3TmaUPydd4uj8mIB6+kA3BbORuGYJYG3Pf66kvE+mJHFjwBOJ2uCn1fj8kL8dCxC6wLGcWHiKKORRpq2C3NRZn4HzGBSBryf8G0x6cTnQPx1l+8PFfj12LEyGeS8VJR24Do+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635057; c=relaxed/simple;
	bh=KlRO9h87nM/LSELz1LqyBup/KFgmkHF+Q90ppAt/pUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaiXtdR4InaVGSotePeZZS7CswIIqFlxo1OzaVuN4YvI9iNr8bNhW4c0l0shwwSYUFm64XwS0eJCwYrmGgMQJUJ7aNdKj1U5u5a3LYDO25aJ2N1/6rmEC+jO6LcBE9Ml25TYBRTNOMxi49jc+5EDXN337YWhalB/QZckingA6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ElkaFyil; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ElkaFyil"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso806785a91.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728635055; x=1729239855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHpdo/IqtUQFXAehwR1zf5UyhQTNM0GrZDpH/NrHIJM=;
        b=ElkaFyilnOVGvGs4sy4ZJJVV4jOF3m4+5rB2mC08JXwhOig7MwM6MCwrzcMjvOE/lE
         3cLgMwPD++jdx+CPLWd7eE7FMn3nVAQuSweqc5AAtNf/xYzGkZPFr+Uv/5SoTwsVC2Ek
         D1vEavmzUW721PKwTE0NJTHqzFDtjjNzTWqmoLVrq9hRoeYuRcw+imL5I/DSnyeS5Cbt
         us/3O+b4vosEAfXMqtQjH1mcsAwDS2Aa3Sfsfy1Uajqvj8n9mFyzfzR37gK+A6MUYyiH
         wHDvsJafh6sEncFsnzhRpOkfBi1vYeuz97QHevFzIvRBH9hM4+uYOh5jYYXcrvnUftHK
         bJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635055; x=1729239855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHpdo/IqtUQFXAehwR1zf5UyhQTNM0GrZDpH/NrHIJM=;
        b=Q4Uab2wkUW8qyJFLfDW7nyxR7HLkwZPpxjSisL0r8SSYNogH14AhAAC7hKp/1zYr5o
         f/4MReOOMl+HaAKH0GPaV3zqqZkOrbJXCPX4WStGVSkjO5d24rvnxqai56pAofk8DmJ0
         4PRqFYFQpdrME9IPBkIQlemIta0t4/xcVCLUC1iEUq46K6uzaf4ObUjcP0KHMkLROjmy
         RyO0YZFxID+hIqcy6v1qXXOz5QFeovILibiGb/AQ0NnjmiQFd2WKYVQzQxHiYe8b5wC0
         8aQNRcqz2i5q0KgcNTwqdZStz4RO6ZtEpWBIiuA4kaAcFLFSE6AOF+HPeL6CFYg4C9SZ
         M+wQ==
X-Gm-Message-State: AOJu0Yx8+Qmm8JjJwQedxGIQTvzLfM8hd25OKx88nAo9NPbm/LzU88tU
	HQAFXMJJrKN0RSsr8UJcoPcyxP6fhmBKvVvcD8hfde6H9HTvcMkKqbN9UEbtxWB2q5azLX+d9IW
	puV8=
X-Google-Smtp-Source: AGHT+IFSnUP50EqTCkD81iPxcZDLjqD7LVmyVT1l26Glh5G9SDSFGnokNPeCvJLWfPPibTxwq/70+A==
X-Received: by 2002:a17:90a:5e07:b0:2e2:d9f5:9cf7 with SMTP id 98e67ed59e1d1-2e2f0e001a9mr2612421a91.26.1728635054620;
        Fri, 11 Oct 2024 01:24:14 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa8ddesm2643121a91.39.2024.10.11.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:24:14 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v3 0/3] repack: pack everything into promisor packfile in partial repos
Date: Fri, 11 Oct 2024 16:24:01 +0800
Message-ID: <20241011082404.88939-1-hanyang.tony@bytedance.com>
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

Changes since v2:
- rebased to seen: 89afaf27d3 (Merge branch 'ak/typofixes' into seen, 2024-10-10)
- fixed t5710, "repack all" affects how the test repo is initialized
- use goto to skip normal repack

This series doesn't address the underlying problem with promisor objects,
but rather mitigates the "repack removes local objects" problem.
Until a satisfiable solution can be found[1], this would at least prevent
more promisor repos from becoming corrupted.

[1] https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.com/

Han Young (3):
  repack: pack everything into packfile
  repack: adapt tests to repack changes
  partial-clone: update doc

 Documentation/technical/partial-clone.txt | 16 ++++--
 builtin/repack.c                          | 46 ++++++++++++---
 t/t0410-partial-clone.sh                  | 68 +----------------------
 t/t5616-partial-clone.sh                  |  9 +--
 t/t5710-promisor-remote-capability.sh     | 15 ++++-
 5 files changed, 65 insertions(+), 89 deletions(-)

-- 
2.47.0.266.g0b04b6b485.dirty

