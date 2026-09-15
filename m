Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888C41685A
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515215; cv=none; b=o3591ncYMigRB3wrLpmCyXHtQEsRo975onqHlIni4KOYdIVAkDwMRWvO7VwVKfFEOx/GAfAJp+A4DyZHu3KDVCjGyI4VVsAKJjqYezyoX94bIO2TH2B/JBJPXpnZcoQ1hiUYC9eqaUUqolvMzEIkuPRE0/7Qtg3gvl4H7pkHjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515215; c=relaxed/simple;
	bh=nFbny1HZEAC9TRacbTlzd8FAhKwi5ahriyPLjNVUH3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLebPWfcL0dGKCH/KOtyLN2xGtB5kY7W5uO+7BDcJtxVINcIwVsVNFCKu18MgDJ9PwXOfOTYUdmd5qjqSXq8ztGoVw/znav5KbIBGxxGx9UYz5dxzXfKVjECBdMTxWi1ZBmYSTXDJhlHqMxx85kAxecfefUAqhtDUmQ+Q53HZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=auNUIVMw; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="auNUIVMw"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0766cbe64so216710b6e.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789515212; x=1790120012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcpTFNJfXj0uYld22B85sbpIvKqo1YZz0i+mj5DQCww=;
        b=auNUIVMw5yUrG9qZfVNZB6C+Wm9MhrkJgGOgCOusOWjwMkjNUBMME24F2LEO2QHII9
         C1nipE5h4nvvggHVqKZ2sdvcSCwJHhG8+f5owuDJfOF62gapU7U7OWn4Q502f0Ra2Za0
         wncuMQtri6linfsGzdqiunz38a7GZtwcF4hFsu2mMFB4w2nujkFpenck1Q94jA6a7DGx
         RigXnuVE1vqIqGHSChcOCUvSV423+NnAjwsET0jXv+ZRN/Vz1H9XcWVVY8rQKBlqZU0V
         lqg2bRUhMkY24qgMIJSqaN6beW6PIKm66L4zqmBNqAjr+ZcefxhB4xZV1sF4+E9nCYUH
         a1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515212; x=1790120012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YcpTFNJfXj0uYld22B85sbpIvKqo1YZz0i+mj5DQCww=;
        b=XFOVZ8s1ObSK+hbeidmm9QH2hA+whHMH+IFn/BkMgVyFDVILcg9DMhn59TCLO//mBw
         nrskuZN9su4EfxiKH5ZHZvbygv2Bv8dGU6kPxOEtL7/DGLlVDgV8P9esa0Z1VxE/Uzhv
         4ihH1gQNrHVsX8eZac7qsA+6URvdt+YxlsGD5hgFF0uVOPjsQhDvzSSDA4pom+b36VNK
         XscrUtf0a41An7emu6h5wp+D7fM5mwrME2FIfrHeMmmbK43YYAGV3vxDcjN6SY33Wx/i
         TaEmfVdh40JcqFD3Aiz8kmAGv2kb1ZTMmNvqZ3itNbKqhuU5ecVgG5Rl5O9AJeI1PWYg
         qfaw==
X-Gm-Message-State: AFuF++nDq0Kee32iVfSMkmT3yi06mQkrIjb0QaroZLSXpBk+8P7D9lMK
	/iKtcrAyyJ7V/snPN4ooyzjYhVJPDK9QnVcyQUV6OGAxLqCRmUdhSDEzqgJbCz/KEYmZdxPzUb1
	NPVI31UE=
X-Gm-Gg: AYBFou2rtevOhXad04SMdfsVja799lpbRSfrPNGUUcGuI/ENqMhBtd+BUkH+gSNBEW/
	VinpEVd/6CQsT9q5Lkd7hW7YsukD/FfWBn2icdwe4k3pLpVNeYbi44J0UyusCMlv9mZ+1ewcnyx
	OXJehckR/kuDqxHp851ni2qtvSKrRgK1HHCB7lgKQpIjXiyZ54y0dKplVruAHykX/jxRcxXLvqE
	7zjaxPtooO+4r6o35iqd0KwQZMoBsTe3dKRkhfG+TSCux3V6uGky1dDyBt7+MjXSspoSCWhMWiy
	EIppNzhdLmjVka0ZCejeaaTqGzXCTIPVt1dLz7+aiA1HawpT73s1jmrDDETXNw/zCagVCFzanWH
	v2hb2s5EefvqWOOrX3fCC6naS6ftwhVHrvk6ydLWai3dbJfEDpYeTO5HRXSWbHilTUrS1bmtswE
	mVPJqzp06EFPHVWC0UmFvWClWPkjWYKOuQg5LcDi7brCGZyc0GiqLk1JVTMrJF4fM9YodntFo=
X-Received: by 2002:a05:6808:1242:b0:4c5:a75f:c5e1 with SMTP id 5614622812f47-4ca4bf7b68fmr1109939b6e.13.1789515212390;
        Tue, 15 Sep 2026 16:33:32 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4ca242e7034sm879819b6e.15.2026.09.15.16.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:33:31 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/3] push: check pushed ref for --force-if-includes
Date: Tue, 15 Sep 2026 17:33:02 -0600
Message-ID: <20260915233305.334115-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v4:

- Add patch to series: Fix case where fast-forward pushes are being
  rejected by --force-if-includes: an existing bug that I made worse
  with the previous changes in my series.
- Add tests to cover allowed fast-forward merges when using
  --force-if-includes

Changes since v3:

- check_if_includes_upstream unconditionally resolves peer_ref with
  RESOLVE_REF_READING, now all non-branch ref pushes will be rejected
  when using --force-if-includes
- add test for --force-if-includes tag push 1/3
- clarify log message problem example 1/3
- clarify deletion in log message 1/3
- add missing blank line between test cases
- shorten long line in builtin/push.c
- reword advice-message wording 2/3
- rename 2/2 from "detached HEAD" to "non-branch"

Changes since v2:

- Correct patch threading of 1/3 and 2/3 to reply to cover letter of
  current patchset vs. cover letter of the initial iteration.

Changes since v1:

- Clarify in log message 1/3 that --force-if-includes will reject a
  detached HEAD today (when the same-named local branch lacks the remote
  tip). And note that this change makes it explicit to always reject
  the detached HEAD case.

--force-if-includes has been checking the reflog of the local branch named
after the destination branch regardless of what's being pushed. This can cause
false rejections or unintended data loss.

False rejection has been reported twice that I could find:

- 2023-07-26 - Stefan Haller reported local branch with a different name
               false rejection[0]
- 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

The same root cause can result in data loss: when a same-name local branch
contains the remote tip but you --force-if-includes push an unrelated branch,
clobbering the remote repo. PoCs are in t/t5533-push-cas.sh -- new test cases
fail against maint, but pass with patches applied.

Existing tests covered refspecs with different names for --force-with-lease,
but missed --force-if-includes. New patches cover:

- allow fast-forward push using --force-if-includes with an expired
  reflog
- allow fast-forward push of a tag on a different-named local branch
- allow forced-update using refspec with different-named local branch
- allow same as above, but with HEAD
- reject force-update using refspec with different-named local branch lacking
  branch tip
- reject same as above using HEAD
- reject detached HEAD

Resolved question: the detached HEAD case; HEAD's reflog was considered
and rejected as too broad for purpose in the original review. cf. [2]

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
[2]: <https://lore.kernel.org/git/CAHLx=O=tVhtiZpaRP9TpfiBfOMS2xPe3c3=mC3VNEdBrLOioFg@mail.gmail.com>

Tyler Cipriani (3):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes non-branch advice
  push: --force-if-includes should allow fast-forward

 Documentation/config/advice.adoc |   4 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/push.c                   |  17 +++++
 builtin/send-pack.c              |   5 ++
 remote.c                         |  43 ++++++++++--
 remote.h                         |  10 ++-
 send-pack.c                      |   1 +
 t/t5533-push-cas.sh              | 115 ++++++++++++++++++++++++++++++-
 transport-helper.c               |   5 ++
 transport.c                      |   8 +++
 transport.h                      |   1 +
 12 files changed, 203 insertions(+), 8 deletions(-)

Range-diff against v4:
1:  e7912c3fd0 = 1:  e7912c3fd0 push: check pushed ref for --force-if-includes
2:  2a455d8a76 = 2:  2a455d8a76 push: fix --force-if-includes non-branch advice
-:  ---------- > 3:  1776f8d572 push: --force-if-includes should allow fast-forward
-- 
2.47.3

