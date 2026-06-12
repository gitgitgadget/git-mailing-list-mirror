Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89C2C032E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294830; cv=none; b=tu60VjxpDcDu8bNi8u45tPVXoWl2rLCo0D4A/DIVBl3ljq/AD5y9ZtwVRz73wlE6tKxnZtjcZka+iG+ZkOjsWy8Ytgph9Id+Yoz0xkfPGqrMobXWJTDiK12rjH8X9DxpU1QbJVtBBJzKtSvjf0pleClVGuvY/n0zub9fhNztIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294830; c=relaxed/simple;
	bh=3sGNN7IZ2nGZnYiohCskMy5hOzm+nMEIucjFfTbRnu8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IPt+HUh3tms3lRJNnGVjsvy8rO7Ppu2xqWB8311WLu+RBbRJWuCsoO0MVZPwaOmMo0+GGT1VDahmGAM7qfQVm0Ms6E5T+6CfNZbOG7BbTohjPgaHG6d1XMzH9N3WxQtREx1zhRq9S4rpqSTMT17HX6JNPKH2VR+7ESO0qCm/OIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=E0zZ359M; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="E0zZ359M"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66077c46c5cso1335496d50.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781294827; x=1781899627; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS9OUutoPsiwSfpKlNZbcwgsy6L0vhK7BBwTsLYcSzI=;
        b=E0zZ359MKNjMfodiTbG8R3AJmXXb6ETEY7oftWSFaab2mbkXfEgxrjBMaxE2aGTbwX
         JE4sRssPTW6a0vjcst3n+XMczeTkqjUmwQf3KL/JiyqJr4ZwHx3o9ylQlcU/PoVWoP38
         rdRa/6Unq64vD0NZLAYVNsJ6VqiNoTp+1ZRs+NB1vL3kDvQRA11AG9xqknRUdvvuZF9c
         BrMkK9LUd6Y2xt8UIHuJ8IdcWjbQ4Pezv4zv4TIf9q1XWX5h26/r/5d1Y+QPKrym+1c2
         j9fbFKv1bTQKJNquCdpEhPZk3FUaE0R+6ls2b/E/AqL7V0ISVhEf6kXAlChFyG9thm6k
         JGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781294827; x=1781899627;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS9OUutoPsiwSfpKlNZbcwgsy6L0vhK7BBwTsLYcSzI=;
        b=SiU0Vg3qeG4tHpZMuoneZZtNGi0anu38ANQVcQ4D1B1laHTrfLc4un/6Xetthoi5KL
         WQbYQxf+z3A7NKbGdtbzis6+PW10eOePvONmtqlGPuUFYcOd0Pxwg2yuPf2aTVdfZyXE
         Qz4FOvslTlc1yMpdNldoLtvntwcgYx4Uo29SaWmryFw4vGZb6mZ5Bjx9xJCU1hYgpMMk
         mPvpLqvIgdFxCHjW5GdLpyxTqULjOCnPWyDsBZseZPHoS+s/8lbSORwygluNY5hVPRFl
         jM4P/l3lBxNLILnmZz2FjgT2S8LDKYdHi0PbIqo/LE1CUOTTcFXKPAgyMhpLaBSybwF9
         boNQ==
X-Gm-Message-State: AOJu0YzA4dkPFKCLNdoUfwQbcOQzwhR+kTjmSe4Ep6qxMeUgVUFOeYvk
	KJNmw1unWcRPNGXmxKDeZUIoWqDhbqxLm+eqey0rn2KFm2ey+e08sbkj3gLbAWMX1J/MN0OtI7a
	C6NF6Akk=
X-Gm-Gg: Acq92OFg+qC4iL8hXg9oHedazMa9ueBKgrCdZ5x6SfD6qAszFZ7Y7rUcBK9H8Lwtsut
	Qc7qUFQ7gUIQdlvkp0F4uIHblwPbC7cqVcHLYY/Md7Yui80MUNNZ2HcyRytLTkvvJAWn0KEIwih
	P3iS4XIz6C7ngwDk5lT6y9hyvJo6NZeAaPlrT6Zv+XLUeaSIqKSaY6jF0oiQUD8QPStLTx7ipyc
	NMYtQtyhBIR+9fS4cwfLDILfAQ+6STdzhudTCpaN7wItWtX/5ELHaY3OPrNIw0AiSZx4rHp3Dia
	DH6wpgvSw9e/9M4aGaUANvZIIVh5xgMNwSgr/mKHu2ymWPPPZIjMqZaLKk98bMwUgC4shx77dk6
	J2CE+o5SfkybmxQ4IT/N4PekgbrMA8XEldIuTlYf7VeoYM5JKjUCtQPgN2JX6RilW3ausowkafV
	37bR1fOpH5jeBy4OQnl2kDkhYtnyDfJarsBOJwbTP/VS/10d/IkdZDg9AJmWLNxm75+g/t1aiBU
	AlKY/F7sRtMLCCl2p/cM9yghiUISktpdP9By+FZ++EQGmFQI8t0nKnRl0gItBpF/NN8TGiDnTf5
	gU9oxm886NLTLvL1
X-Received: by 2002:a05:690e:128c:b0:660:109:b90f with SMTP id 956f58d0204a3-66278398a12mr3950933d50.56.1781294826751;
        Fri, 12 Jun 2026 13:07:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274c4017asm1625780d50.1.2026.06.12.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:07:06 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:07:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] midx: honor custom bases for incremental writes
Message-ID: <cover.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

SZEDER noticed[1] that t5334 was trying to call `nth_line()`, despite
that helper living only in t5335.

Fixing that should have made the test exercise `git multi-pack-index
write --incremental --base=...`. Instead, it uncovered another wrinkle,
which is that the normal MIDX write path parsed "--bases" without
actually passing it down to the MIDX writer.

This short series fixes both issues. It is structured as follows:

 * The first patch moves `nth_line()` to lib-midx.sh so that t5334 and
   t5335 use the same helper.

 * The second patch threads the parsed `--base` value through
   `write_midx_file()`, and consequently marks two t5334 cases as known
   breakages.

 * The final patch fixes the pack inclusion check and marks the tests
   successful again.

The result is that `--base=none` and `--base=<hash>` now correctly
produce detached incremental layers that include any packs above the
selected base, preserving reachability closure for bitmaps.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/aiuaf3fKJ6kIITrf@szeder.dev/

Taylor Blau (3):
  t5334: expose shared `nth_line()` helper
  midx: pass custom '--base' through incremental writes
  midx-write: include packs above custom incremental base

 builtin/multi-pack-index.c              |  3 ++-
 builtin/repack.c                        |  2 +-
 midx-write.c                            | 18 +++++++++++++-----
 midx.h                                  |  2 +-
 t/lib-midx.sh                           |  6 ++++++
 t/t5334-incremental-multi-pack-index.sh | 20 +++++++++++++++++---
 t/t5335-compact-multi-pack-index.sh     |  7 +------
 7 files changed, 41 insertions(+), 17 deletions(-)


base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
-- 
2.55.0.rc0.3.g7bf7c87b605
