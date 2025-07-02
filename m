Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7AC13D
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418491; cv=none; b=swcdtK2vQ6ie0omfaV4K26xmxjTwsLygFbf/ftsfMoGzqy1Ei8ixeqgV3KEXaPLqSSSxJX3D2ttso2bklklsPdDJ9aLjB6Rl9hV/9xcrwdhVYwOpzsKoN/c4+x1xtQ6bsewAG9au4QcQzQXiEgH3hFr+Am2S0BG8Kz0pB3lpkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418491; c=relaxed/simple;
	bh=jqVltbjmWBuakC/wVfiyVOmaADrQqOjpj7lBFbDVO/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPuIm1iemIz+Q0qLRQK5uNDZ5nYOafQhqstgToDVj3THWUOPhHs/aAm1I27nnmzm8/K2rbTJYjoMwysY0rGeLYA/u+w9OAulQnPqWu95jsE4nGWgLWfvWLZ7NtjN3cFqKzKioijXZHavxGYeX+JnTf+HfA+9GKG94cSsAvrSmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmuyKaVs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmuyKaVs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d3261631so45374355ad.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418490; x=1752023290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nv4OGfM9tl1QJCeQ737/hind62JfSMrSDr+dKD2omuM=;
        b=PmuyKaVsXIMfSJXlT00q4x26eg+3UDzSWtM2k9Og2mkag3AyKlCx8NnpwEZN0MCwj/
         uFGxhH4TU/890tc4Jj9fBaD8Y61MKWjNs0o6jcLwpE3R+on3o/diXNQoU8rEIq1Q8UcU
         no/v/UQkQ6P676+PMcM5WVNxrp6AtlLYG6yvf6Tg24jcAosJelYBG8Jkf0xUgKWk+CwA
         LdyfPruiEV3WS9RThCi6l/a+kVCVje/LJICcJZi7qbxkmSupCRRYIbQo2Nr2FL9iRBFL
         q0XELC+2ny2UGRZsryrwX7r/y2MgwVYSlN7rULGBO2tUFQegiopE24LHMIbkqOSPUpE2
         vbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418490; x=1752023290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nv4OGfM9tl1QJCeQ737/hind62JfSMrSDr+dKD2omuM=;
        b=un1bWlO30j03jwqqzTHyZgtQoihj8MMMSxxvt2bEjLIxVLOzDT0xgGJttbQIhg8Ra3
         5nKZm8SyYoNDDtYn9yk4vr0vRomL25anz1V8NNvt/iCMWdHYVtK5spZuURYJ9MbVK06E
         V3Xw+DchkYHjOhXTlzvgrk6a4vd9N/eEe8V4N46EQ+iKz+vyJxlL34PRB+zZZrcvTcLW
         QdxiOiwQFsV22tYdqkVy718eMLHmgAIe3r6uudJ7pfDtl/892LQAlc+cTGcxWlVXaAx/
         NFNZCcIEeGhzd+GBA1iTs3eAKdsY4uWWadxTt8Ixbm9XGxxfmenRdM1zSELSRd9puHcw
         CLdA==
X-Forwarded-Encrypted: i=1; AJvYcCX0mmqRXzKZEJH/tEVf4Tiaeey7X0HMj4dTwVyxCrdjOlH7CunJVJv/m6WuteWA4OR+YlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj33OOhNeDWfLdNdv/VNw8WQHVoEMEktSR/12ii2DOYmjK1GSy
	Vweu2UV64KTvYZRxMhJ25lE4kxrGpgC+Ma0jwEFWGR+v8BVytRYpFoyS
X-Gm-Gg: ASbGncs6bQ6ksqyA0J3RlCdgce/baozJFjtNqWgNTunIIjuswCfx04aF2ycvLutc60Q
	azG/XLsHBY77KRu1Hhie0fGs9YeJP3EOvWJiTM7LS45WO+PKDGvuHHKuMaU4Yp0veijPjVc3Ba/
	zEhWuiElXXpnL8+M3DvsrV6oiOIXED2EXRxxAV50m5nguauEFQ8Du0epcf0EmYtINg083dONO3w
	ujKDLb6N9fx5oIpVG6ZIkTx9kd3ilovJcQlKd5C4oJfnGZJ6+PVwI0hculKdR9A7nunYpD1nUkO
	2/jOPdAJRgTIpn/v1ACxL82Vfo9/CdKbXKpv0HhI4xMTd3I7hpvLbg2+YrE=
X-Google-Smtp-Source: AGHT+IG9u5JiTnM3dxM60MSOiggnFiZVPIycb7VtNsoVAb9ZdoYv5RvcXyqsmfR+px0zeIf81vL7pg==
X-Received: by 2002:a17:903:1b63:b0:237:cc75:77a4 with SMTP id d9443c01a7336-23c6e6138edmr10213295ad.42.1751418489599;
        Tue, 01 Jul 2025 18:08:09 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e258csm124433705ad.38.2025.07.01.18.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:08:09 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v3 0/2] fetch --prune performance problem
Date: Tue,  1 Jul 2025 17:58:36 -0700
Message-ID: <20250702005837.2813893-2-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.149.g2f19833911.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

`git fetch --prune` runs in O(N^2) time normally. This happens because the code
iterates over each ref to be pruned to display its status. In a repo with
174,000 refs, where I was pruning 15,000 refs, the current code made 2.6 billion
calls to strcmp and consumed 470 seconds of CPU. After this change, the same
operation completes in under 1 second.

The loop looks like this:

    for p in prune_refs { for ref in all_refs { if p == ref { ... }}}

That loop runs only to check for and report newly dangling refs. A workaround to
avoid this slowness is to run with `-q` to bypass this check.

There is similar check/report functionality in `git remote prune`, but it uses a
more efficient method to check for dangling refs. prune_refs is first sorted, so
it can be searched in O(logN), so this loop is O(N*logN).

    for ref in all_refs { if ref in prune_refs { ... }}

We can use that function instead, with some minor cleanup to the output to deal
with the ordering being changed.

This patch version only adds the deleted branch name to the output of the dangling
sym refs since the ordering has changed. This is only a minor cleanup and was
not actually needed since, for example, `git origin prune` already did not
mind losing track of this information in its output. But now it is improved
to be more explicit.

This version (V3) has three changes from V2:
 - Removes a header declaration I forgot to move previously
 - Cleans up the refs_warn_dangling_symrefs API to be more sane
 - Drops the ref shortening that seems ill-advised in retrospect

Phil Hord (2):
  refs: remove old refs_warn_dangling_symref
  clean up interface for refs_warn_dangling_symrefs

 builtin/fetch.c  |  5 +----
 builtin/remote.c |  5 +----
 refs.c           | 34 ++++++++++++----------------------
 refs.h           |  5 ++---
 4 files changed, 16 insertions(+), 33 deletions(-)

-- 
2.50.0.149.g2f19833911.dirty

