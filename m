Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE43644A2
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035226; cv=none; b=oFlsjs97sMFLvFOg1Bj7mrVDPWxUR7ApncLLTQRyWTZMIULR3Hg5slc0stZaTSYrF+6zzk1pETE+33s9fZTreapmobBTbuj7ke16Ujxvodhwlw6CymIAR1ZpydpF6wrQJlCCciqhj4IiaVUyarqVwxNggkq97MVrMiSqMyRwl28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035226; c=relaxed/simple;
	bh=aGz6L376iPPyF75OXKTcSK3yslQTcnjW2A1VJk08g3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=p6ftGouVnDeZCaMgEaPaNVGjsyXhdutnGzyocBiYnbcfOyN+Z18rFNdxcmyPb4fQYkWjGOQgumW/UZs3d1XMsrpbvsqrqW/oAvszc4wy6I5fzZCIp6X5jqvg6SieivJbspoxR+rtf8oZclLfuixoDYMCjm9IPiwgC3RY7M8BTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTGef3Y1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTGef3Y1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43596062728so3336965f8f.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 04:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035223; x=1770640023; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpYcUjoZO1Ypzr8wUFhxXoDIfH2fh10Fkc4GQuLzLIk=;
        b=MTGef3Y14ciLWtkcTzR5rXF2OcSev39Mn2DnbeV9ousbX+DHLzHjNcjVc6MHZxXA33
         qx1Sggv/OP1QZQ1fcACWUIvmtFj7FuVcWlGydlrWpk4xJ7Na0ztSQZqZHxCqla/zEDaH
         z+UzBASu0zAedPe4kuKWuwo6pDknX2X43IwRSwt8gFx/9+mcSMay+0MIgVdCfY2m25tp
         RueFvSoxXQ2PaVxIHieDvawDVcwEzIQC/xmI/o1xioEcsK37A9jBlx/jSKl+YG6gQrOB
         VE6QsQ1FFbxEwwNTE0IvUiEEFG6cowsziT0M+LxNGUp2so+bkXvpE58ikWTJMxDgpjio
         HKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035223; x=1770640023;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpYcUjoZO1Ypzr8wUFhxXoDIfH2fh10Fkc4GQuLzLIk=;
        b=heZfMfdqEqtmqImy+oz7qWEhIP5qPyTPGXa0EsCARlQkcl7gAHItOlnGPfKnxerdNz
         N/rFWqXA0sp/ODNL10MPnMs9gJaoYGOA6cete+tOVA7M95nzhbBEnjJDXe+YdfjnoVr0
         Bv0AZYow7sT7Wwbc9ZplOxHLZxpXnlT7dhS3Tl72EIvcXVhLopbsa/krwXiM/3Gu8xJM
         DmhSzOgwAK00GcWauK0eEjDu58HUtnfMGvadyQPC8cKSB9L2qtQ1/l9aCT2muGqdiwJn
         cjFuktyE+nrCvaKIZ9009jSb9HMOZlpXaBEpvmGSd2bPBy1ehMCxt5XETD6NVTlMUIPp
         WYuA==
X-Gm-Message-State: AOJu0YydoSboGYg/HzFygmbLdnwlxt0t2mArrsg+GWLX0sjxNb5iywIC
	BtI4KN3HE0AjcPWfPa8I/2P9kjdECL0fa6+9AgUW1y5rW1czhIHvs+IW
X-Gm-Gg: AZuq6aJLpdpoG4QdMCrLCP87XcjCeNBHRLO58j/O9Hn5HH9o/aHo/LeSxerSKpssQBc
	y4HnQjfVfT2kcYQqIML64POoDkru22ZBX1spv/ApdIcvb40nUObWq0czZzQEQ0ZiSQRlObo6vtX
	/bqsAsN5DwlSAm2ySWRs3/beqF9CCs9xupwlb/7d1xnfqyIIDywxW86W9MWy766MRkcpT3zGZbM
	vUmObdH2HaiPDvX2MAiHTsMw7pTFAIOzE6hPRurUJMwIC1/blLKDszF+/HG6F8MZJKzmiWvKB7u
	wBJ8Jrl41YmvSYz1wnoev7RhWn2D/z34y8oLU4sv7CHlZnFgqHnXlNw7oa4g7iNtoACf/iSxZWq
	jOpykTtLeK1bpFxpijBuNgFqPV8kHdICBZYq2+OjSEUImuPxHbkt3QZ8EtqytopAj4VdYlTJm8a
	eYlif/FexNubh9qVBwknM=
X-Received: by 2002:a05:6000:2088:b0:435:db93:72e7 with SMTP id ffacd0b85a97d-435f428ae29mr16412196f8f.3.1770035222436;
        Mon, 02 Feb 2026 04:27:02 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:4339:aac1:fb26:43f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm45245735f8f.5.2026.02.02.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:27:01 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/4] refs: allow setting the reference directory
Date: Mon, 02 Feb 2026 13:26:29 +0100
Message-Id: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPWXgGkC/3XNwQ6CMAyA4VchOzuzbgPBk+9hPIzRwSIMM8iiI
 by7g5hIjBz/Nv06kQG9xYGck4l4DHawvYshDwnRjXI1UlvFJpzxFICl9O6oakf0To1IPRpaWU8
 FpieOua4YGhJPH3Fhnyt7vcVu7DD2/rV+CbBMPyAU/8EAlFGpjVSF1HmJ1aXulG2Puu/IAga+Q
 Xi2g/CI5GVhMgO5yUT6i4gvwhnsICIiGqAsZFZqbtQWmef5Dd5rhuFCAQAA
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5903; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aGz6L376iPPyF75OXKTcSK3yslQTcnjW2A1VJk08g3M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmAmA6IEWTKyBPfrSP4qCauIDmL6Muw55Vgx
 VUdZruhXtUr9IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpgJgOAAoJED7VnySO
 Rox/1EoMAKQVTmUc6TVErC/fUZ6LAvn2L+dHaajf2IMsFpy61wKeXWqe2XyuPvsSFqUpAMje8H7
 aNhMq9yTAQG2DXNPnRycsUiMj/3Zpwc2Xh28WoJdSV3fJkUmVOnF6HuQod2bGqQTRZ83tnq2/15
 7x+Ua3+vNEVF6aFsrdyIH/21mjuXNCXxWo1RG3fuYvu7b+ggJmkl9WHdiSFmmC8AhyZvnLzrhdZ
 fVU0xunHY+BN2MFxedK5qi2jTz/5lTu9eqql8GR0GIbv7r9Nr6+TjqDuQnJzWJNBQi3CreSBqKP
 wqGlNGIEXlZoYGhrM6ZO57zY15nZw9xObUc2wlxkCoGaA4TWUJAHApp8fS2o3e9naS2854+s1wV
 y1VIwBqBEARpu85FtuCoOGhjQcUKQfRw8kYfOnmeyMGaRWcqZT0dkQEsQgIr/in9WHp8SgyyZUZ
 JzBpjL69rkpG2EpiLAu3hK1/5dkBOtz0cvqk3c6T2sFqHXA2C205fjtSm1FiZVgLTLjb6gzMRR7
 BY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch extends the config 'extensions.refStorage' to take in
multiple forms of inputs:

   - A format name alone (e.g., `reftable` or `files`) which uses the
     default location (the repository's common directory).

   - A URI format `<format>://<location>` which explicitly specifies
     both the format and location (e.g., `reftable:///foo/bar`).

We also add in a new ENV variable GIT_REFERENCE_BACKEND which can be
used to override the config.

One use case for this is migration between different backends. On the
server side, migrating from the files backend to the newly introduced
reftable backend can be achieved by running 'git refs migrate'. However,
for large repositories with millions of references, this migration can
take from seconds to minutes.

For some background, at GitLab, the criteria for our migration was to
reduce the downtime of the migrate ideally to zero. So running 'git refs
migrate --ref-format=reftable' by itself wouldn't work, since it scales
with the number of references and we have repos with millions of
references, so we need to migrate without loosing any information. We
came up with the following plan:

  1. Run git-pack-refs(1) and note timestamp of the generated packed-refs
     file.
  2. Run git refs migrate –dry-run.
  3. If there are no ongoing reference requests (read/write)
     a. Lock the repository by blocking incoming requests (done on a
        layer above git, in Gitaly [1]).
     b. If the timestamp of the packed-refs file has changed, unlock
        the repo and repeat from step 1.
     c. Apply all the loose refs to the dry-run reftable folder (this
        requires support in Git to write refs to arbitrary folder).
     d. Move the reftable dry-run folder into the GIT_DIR.
     e. Swap the repo config
     f. Unlock repo access

Using such a route, scales much better since we only have to worry about
blocking the repository by O(ref written between #1 and #3a) and not
O(refs in repo). But for doing so, we need to be able to write to a
arbitrary reference backend + path. This is to add the missing
references to the dry-run reftable folder. This series, achieves that.

Since there was a long gap between v3 <> v4, the version 4 onward is
based on top of 2258446484 (RelNotes: correct "fast-import" option name,
2026-01-30).

[1]: https://gitlab.com/gitlab-org/gitaly

---
Changes in v4:
- Mostly re-wrote the code to also support worktree. Now, the existing
  backends will store worktree references in 'ref_dir/worktrees/wt_id'
  and add corresponding stubs in 'git_dir/worktrees/wt_id'.
- We also support relative paths in the reference directories. These
  relative paths are resolved relative to the GIT_DIR.
- Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com

Changes in v3:
- Cleanup some stale code which wasn't removed.
- Localize strings which will be output to the user.
- Remove additional defensive checks which are not needed.
- Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com

Changes in v2:
- Added more clarification and proper intent in the cover message.
- Changed the format from '<ref_backend>://<path>' to
  `<ref_backend>://<URI-for-resource>` as it much clearer.
- Added logic to check for the '//' in the provided URI and a test for
  the same.
- In the tests:
  - Use test_must_fail() instead of ! git
  - Fix looped tests not using the variables correctly and ensure that
    the test description is correct.
- Link to v1: https://patch.msgid.link/20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com

---
 Documentation/config/extensions.adoc |  16 ++-
 Documentation/git.adoc               |   5 +
 builtin/clone.c                      |  10 +-
 builtin/worktree.c                   |  35 +++++++
 environment.h                        |   1 +
 refs.c                               |  61 +++++++++++-
 refs.h                               |  13 +++
 refs/files-backend.c                 |  18 +++-
 refs/packed-backend.c                |   1 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  15 +++
 refs/reftable-backend.c              |  38 +++----
 repository.c                         |   9 +-
 repository.h                         |   5 +-
 setup.c                              |  59 ++++++++++-
 setup.h                              |   2 +
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 187 +++++++++++++++++++++++++++++++++++
 18 files changed, 433 insertions(+), 44 deletions(-)

Karthik Nayak (4):
      refs: allow reference location in refstorage config
      refs: extract out `refs_create_refdir_stubs()`
      refs: parse and use the reference storage payload
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Range-diff versus v3:

1:  a91a4d5ba3 < -:  ---------- refs: support obtaining ref_store for given dir
2:  a9f126d724 < -:  ---------- refs: add GIT_REF_URI to specify reference backend and directory
-:  ---------- > 1:  c8ddb8ec8d refs: allow reference location in refstorage config
-:  ---------- > 2:  02acdc16b4 refs: extract out `refs_create_refdir_stubs()`
-:  ---------- > 3:  1b0e17e705 refs: parse and use the reference storage payload
-:  ---------- > 4:  8ca379edd6 refs: add GIT_REFERENCE_BACKEND to specify reference backend


base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik

