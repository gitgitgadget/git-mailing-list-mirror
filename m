Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E7265CA7
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708142; cv=none; b=mvE97DgKCwNFhAd4y+V32hT+I8ZVtRz4EaS/Ms8+P21od1uIMl/PxBfsBNjFujDKbE9L9Pe+RiDc3kcS/e2jbFrOL6DTx6WUyL2fXI9v9ZovPzvyJlKbp/rPHD5DGHp+UHXxl/aWq5SiLuY0FVt0nkC0LQ8qPS32fC7aU9jtQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708142; c=relaxed/simple;
	bh=LJ3lyfORakHaAgogZ1Q4MP1ppsYBMTLMQL4RLzFIKCU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NXm1KFZT6K5N7vzen9OyP5pe7pc1MgV3JSl2QE3Cl3qQ5qdZbTi4lYlunkyVfg0k6SqpXT1pj+iHHLpV7nBBtY1aFACbDPYk3Sc0DErI3Mn1lfdWj3Wq89NDqgKuSyVjTXRETkcuGjW0ozbKkTcOKkZU8GKaZC1X4hWcgQ8Y4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H1Zdbao6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOoXJt8/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H1Zdbao6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOoXJt8/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D46EEC12D9;
	Mon, 28 Jul 2025 09:08:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 28 Jul 2025 09:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1753708138; x=1753794538; bh=zJg8mPISLu
	uSTnqpNP57E0blFmhBaldag3zuIW/FHGc=; b=H1Zdbao69cI2DoSGI/De4sk2AD
	1DTlmwup7nr8BozX6zbF136rZj4XGkEoYc8MRp2uLsxVWTDLRS7b7wU3YNN/taBr
	T3mq0tQ38lNbMq/DHNrFp1v8eUxjgc5IBLl2F8HjmH4UwX9zv1o1bBQH/WYmJEt5
	UqMXQcY7qNvU124SThNwZBZXE8VOCjFKUDX65cvv26R4x6pSiP+LATpaFlgPbeu3
	Sfow3EhwSz7OOFaV8jcRUqgZ0SKnCBYHOVtPioTyuGB69e+FmRGjoAm4sVjeDsVK
	ICTei52K3FmyQvYF3odsyXdXEYA/fN3T8FmT0YUINZJ+h/JJ4ygUuLwp+zDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753708138; x=1753794538; bh=zJg8mPISLuuSTnqpNP57E0blFmhB
	aldag3zuIW/FHGc=; b=dOoXJt8/7PhinwA5G1jXC0CneDTIAATGTsGBUwVk4I4C
	CkBfjWfHt4gjtjA2kwpEp1lH+ndimQwF9RR+b3He+pRhkMprPM0le5TbIsUr2Hw9
	XwCSLRXDklkGAJw5f8AMwfWPdi0XtRdm6hLEwLqniMxnBvHI8N5LPjVfkhOycplx
	IMxbFOfG4hcunzmnP2HUl9mr+B40x1CIjOuZJp+cAWahr3qVgr9UVjEiu1eDI36y
	oSW51VsF5SEuKRQWHoFwWiNTIjsIn5z76T2S7bV+C1zmpVzKmXQx1DFuW65MSSSU
	l5gEapymXCnNrnK0l31rstib5JwE4NoHWRXqgJcSbw==
X-ME-Sender: <xms:aXaHaHdbOdH5YVdikbapwWGA6hpGyg_W5BbkK2qy7pLJXwl5ggr4qg>
    <xme:aXaHaHzpNo-DV9MbQXBJvmLpxTk2yzb9aDeBK-fgj-FEfsKBaFFYKsjmiDhDvEsfS
    RJpZnYaXGEcwwd84A>
X-ME-Received: <xmr:aXaHaNHflu_hFDAwolZehuhOUue0XM2t_ZhBSm9Fn1g4zxlPaLucGClzCgHjiB9IKXDIS5UKxR0rjTuzxefOqu83Zj8Pp2e50ili21GW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtkeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffleeghfejfeejtdeufeffgfekkeejhfeiffduge
    dtgfeuvdegtdelhfejueegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvght
X-ME-Proxy: <xmx:aXaHaLxHQNANciEMqa2B9RrpB1opQm-rNkYgVmbllhNtgfjhITOBOg>
    <xmx:aXaHaOvAt-NJuJO9BS1RwmycySLFkHwSzGlqhYwWH8OaW7gtlGCrAQ>
    <xmx:aXaHaI1ZHzf6vpB3NryigyNdS4KUCwHsKRDgVSCLjGlkzE8SN4F4oA>
    <xmx:aXaHaJ-19pGm7tygcK1SClemc-_JtQtJXmVEqCptBfvDoinKir3kQg>
    <xmx:anaHaNNBKe30ON0ubjt9CEOQWZ9xc7Mw2o2vaNP3phPhB2jiIGoTFIny>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 09:08:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07be500a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 13:08:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] builtin/remote: rework how remote refs get renamed
Date: Mon, 28 Jul 2025 15:08:44 +0200
Message-Id: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFx2h2gC/x2NSwqDQBAFryK9zsDYZEzIVUIWoi9JE+ZDt4gg3
 j2Nq6KgeG8ngwqMHt1OilVManHpLx1N37F8EGR2J46c4o1TaD8LilwXOMqYPchN64qMsli4pwk
 8cH8dEMlHmuIt23nwfB3HH7xE24RwAAAA
X-Change-ID: 20250725-pks-remote-rename-improvements-85ce262146e0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is the result from the discussion at [1]. On the one
hand this series fixes the reported bug where dangling symrefs are not
renamed via `git remote rename`.

On the other hand this series reworks the logic used to rename remotes
so that we use two transactions instead of one transaction per ref. This
fixes quadratic runtime behaviour, where renaming 10k refs takes ~4
minutes, 100k takes hours. This results in a significant speedup with
both the "files" backend (benchmarked with a smaller number of refs to
retain sanity):

    Benchmark 1: rename remote (refformat = files, revision = HEAD~)
      Time (mean ± σ):     238.770 s ± 13.857 s    [User: 91.473 s, System: 143.793 s]
      Range (min … max):   204.863 s … 247.699 s    10 runs

    Benchmark 2: rename remote (refformat = files, revision = HEAD)
      Time (mean ± σ):      2.103 s ±  0.036 s    [User: 0.360 s, System: 1.313 s]
      Range (min … max):    2.011 s …  2.141 s    10 runs

    Summary
      rename remote (refformat = files, revision = HEAD) ran
      113.53 ± 6.87 times faster than rename remote (refformat = files, revision = HEAD~)

For the "reftable" backend we see a significant speedup, as well, but
not as extreme as with the "files" backend:

    Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
      Time (mean ± σ):      8.604 s ±  0.539 s    [User: 4.985 s, System: 2.368 s]
      Range (min … max):    7.880 s …  9.556 s    10 runs

    Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      1.177 s ±  0.103 s    [User: 0.446 s, System: 0.270 s]
      Range (min … max):    1.023 s …  1.410 s    10 runs

    Summary
      rename remote (refformat = reftable, revision = HEAD) ran
        7.31 ± 0.79 times faster than rename remote (refformat = reftable, revision = HEAD~)

But in any case, it's one more case where the "reftable" backend
outperforms the "files" backend.

The series is built on top of e4ef0485fd7 (The fourteenth batch,
2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
invalid old object IDs when migrating reflogs, 2025-07-25) merged into
it.

I'd normally have withheld sending until that series was merged to
"next", but given that I promised to send something on Friday already I
decided to just get it out. In any case, if that causes problems I'm
happy to wait a bit before this series here gets merged into "seen".

Thanks!

Patrick

[1]: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>

---
Patrick Steinhardt (4):
      refs: pass refname when invoking reflog entry callback
      refs: simplify logic when migrating reflog entries
      builtin/remote: rework how remote refs get renamed
      builtin/remote: only iterate through refs that are to be renamed

 builtin/fsck.c            |   9 +-
 builtin/gc.c              |   3 +-
 builtin/remote.c          | 275 ++++++++++++++++++++++++++++++----------------
 builtin/stash.c           |   6 +-
 commit.c                  |   3 +-
 object-name.c             |   3 +-
 reflog-walk.c             |   7 +-
 reflog.c                  |   3 +-
 reflog.h                  |   3 +-
 refs.c                    |  63 +++++------
 refs.h                    |   3 +
