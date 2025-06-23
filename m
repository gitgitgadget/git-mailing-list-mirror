Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE927227EB9
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722239; cv=none; b=Tgtl6YrwohXt7qRPy3bndAt7Le/oVb4fLry/22OleEHiBU3NBhrX0SvyieuE1rWhwKQ/B0C/Vu8mdkLOQL2SXFLH4S13DjQx8qzowFB2sUa2QkN4gkxCfCFyYSw8XFbtCjTmOF71tcFTIeci7pfjelAvg0uG1/M84KhXNhBfsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722239; c=relaxed/simple;
	bh=vBX0yrvL97QAz4NyKpVOcHHI+kogsOY/sOkFjbczXgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmCUaosVLBvB8kzaxlubnrkFzrz/ZzbLwBMDUpKLZchC1OM8izLg24sWUXUuIIE9ZfGMghoGH+07v9zuLQUMjYlzJ8tXOb2zFWsgCg5d9CnuvvXAvKUURKUx35I257R6nmXzeWkfAETV3e14F3dwZ6rCKkk2OmvOy0kK0Dg+fLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMQABEtK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMQABEtK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7481600130eso5960291b3a.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750722237; x=1751327037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtwpS7G+ANQyYJE1Ra3qwX6yO9HfPRnIivuxAH9m578=;
        b=KMQABEtKYMeLukYO/RYI6DnswDuJteI3hxF6ETIuN3/ZWafk1nC+Zj3YyicVsTNmpJ
         l4RuGYT2U/JXCT3mrtYW0z+Q8mvkzJCqnHmtS3M5j8JHKeaT6J4GSqoTIbuvYrmY0RMq
         r3ghv1KIsMVwoMAwrby+vGSlUy48jBb2k51pN01HgeE6FyNPJs1qbFFWOJzgEdY7MRWZ
         BxDHQpK3+KqTAiUsrHTu8JP3cdMJK10FzUPXTewC8TjciecmTvz/a07viL+3lhtRk796
         gpPpeLbgpcebqqH/0rR8BtcyHn9kZHKRzrkp/waPMVj03LHsAov7/WJEXL3d9zXdm/o+
         3Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750722237; x=1751327037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtwpS7G+ANQyYJE1Ra3qwX6yO9HfPRnIivuxAH9m578=;
        b=ogstLyPquSFC6l6LoSJmRYPQxSvn5Q9xA3uFk+uGx7CwRT3eoGgr1J6z/D5ABT3ViZ
         JYHP2uKdscmxPqNQrToB9D4HHBmPeLS1vmFJplIGt4KHMNsuWo5n0El6ZwnBnfjiDgdv
         l+Sf6g+MoEd37LnLXkIszH71bDz7PHXvkZAVZHk2RfKLgSJ+CzPNJsRRI7CfrmCWwx/7
         BzaWobdrurWLf3dKWWhc43U3s+J30oOuFi2wlUppiTwMW7SkMV/ZNchEUNU5OsZrUhob
         D2NOZWKVhgnsNp9M71ycFqHWtwy1yCa8yCid4D77BuSHExvrLDbwXTCqBSDuEsfsymCh
         lF+g==
X-Forwarded-Encrypted: i=1; AJvYcCV+58Yr0/KtS+5bxTdnkzo4l6ptzyqzKEBkBYNRA53XoTBRQkkfD3VDhcq74hGjAnoGlZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywle4v1qx7Xs8ZS4qEEEmwP0orua0OAjuD5I9bFJ/rYFBMEmbWn
	R72C2wp9pD8dpAPWrSDrmt4t29E5D/a0flNnQIK1xeMg6n2C+ztCHN/U
X-Gm-Gg: ASbGncsKDYqXXfE0eGlvnDGiINFT3RGWDvlvSpxlXHw2yRya34wC6yYiyWPJ7yMbGeC
	HoJpKsV5I16xFrzx69ziMCuyMUINsrxB1J0jmQ+cGvCPoXd9aUxBZhIQHP4wbqbyfyEbKMQAnaw
	eW4Lfkp5dIaqmM/i7hoe4TLHxRsxgjiSehwCGYzq/vPpb16QkMJoUZFIbJ5uXSzMEQeNHM6nmb4
	49xFKkZXsjhUy2/5xkd40h8Nd1NO8oLCYXs7Uq/IkCfeyGSm+bztusqtnym18lJ1gEKkZN/mVsS
	rU9cYE4c+qOUN224SjLQX/Fs0/AR13Ha2eGZoTDlvDsMWhFD+8gx3IZZw6s=
X-Google-Smtp-Source: AGHT+IGR/yzqV1mmGiYfO6lmak5g6F9cglWWN9BexbqPcFSAcTiBefX1zAypXTtnQDNjOt9U/jMwfg==
X-Received: by 2002:a05:6a00:2441:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-7490d66362cmr17473204b3a.1.1750722236851;
        Mon, 23 Jun 2025 16:43:56 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cc92sm252856b3a.82.2025.06.23.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:43:56 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v2 0/2] fetch --prune performance problem
Date: Mon, 23 Jun 2025 16:43:25 -0700
Message-ID: <20250623234327.335490-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.84.g5d85fe910b.dirty
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

Phil Hord (2):
  fetch-prune: optimize dangling-ref reporting
  refs: remove old refs_warn_dangling_symref

 builtin/fetch.c  | 20 ++++++++++----------
 builtin/remote.c |  4 ++--
 refs.c           | 21 ++++-----------------
 3 files changed, 16 insertions(+), 29 deletions(-)

-- 
2.50.0.84.g5d85fe910b.dirty

