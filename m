Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCE2AD00
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586685; cv=none; b=PYVXf9jbensR7EBp2TTT9Lp+eVPTSk30g6D9LsbdmLoY7R1v5jNWykLs0Upf1aF20oxC5VNdcGTJVx9txaX3D8sP5lyHPjCoiqYXWxoJfGcX98+Xwf1+oIwYSPmuggHP5/r2l3hrUjxdgu2e8gDh/rR6i8dPJ02mej8ndQ+yfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586685; c=relaxed/simple;
	bh=bdjFTPK5g/O0cXkjjJN+tSLsrbO+nmaDwAMmTJeNBK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQq79KOl2ZraxZXRPbx30gZvpDg0lMZGNNy8xFVCHS2a2xGIVQXEE7a2ZOnDidHaSAgHJSHGJhcxjDyzvboWl41fuiNor3Ph13k0Lt4+1ENlF8U73wDQ/dtfa/I+csRpgPAf5hXjZsU3RGt8HYzIdksZ7RDVDAo3BKYOLSkye7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=E2VvsrfQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="E2VvsrfQ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-907ae87ebfcso347316d6.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784586683; x=1785191483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEU4sFVB55zstEoTdn1EDIgs82vBe3a/ZY1lxPovKD4=;
        b=E2VvsrfQf5AxklNBC6cUwCqL/4q2ce0amma8mtmdSpnmPhalZO00SKf6M0avSUGxxG
         UMYz9SmJftlcVyU4y4SX3fAgydcHtNMRVyGqcmJZjmAut7bzLtlgAEcFY5dBp6PAZvy0
         d0l2ORilNGF70Xn49Qg3L75vGn5RGA2Zh/xiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586683; x=1785191483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEU4sFVB55zstEoTdn1EDIgs82vBe3a/ZY1lxPovKD4=;
        b=RH0PaKmW0kJflL71ZInPxnWsXzo18lqGn9rEHkbcAhbTnRL+qlE+g8BH+QqKoPk7Uj
         kN9BDAe90r8TFbLjgf1p1iifBv8YNdqQbqBei+9pYB0gAYqVUndm34lSoHEKebrWRDGy
         4D/7aMyb11D6laUGOL1Bilm2CX+wLEgirCC4Tf79HcTRR5SOzttpTuvIb4+Wg9fXqhoV
         tiE9fcoQvIEg0z+DFlIx1QY+2kfET6ONhG95RVaukdEaHE+cGbT98DMq0yoX/vOLX6xz
         80KbKkLEIYKsMb6P3u5LhhqDlOxAJAR2Vnnwxo85AclM4oMua6YyjXKoBNUYGI8IZ0N1
         X6eQ==
X-Gm-Message-State: AOJu0YwRQvhDE2/Pz/U+n6eg6XOJ1++ki/o1/k+gmSF6miRxqaWIO+P0
	C9Mc1bCoVI2JK+XFsG5cVp4iD30aUS8/uprw9zl56eCxDUJDNQnQeVLv4PKTQmfpP/Hm2iH7nQS
	6Zljl
X-Gm-Gg: AfdE7cnR0UhqG4NH284xoO5ToDmp/d9QGXCURFMQUc/QFyOnl7I6m8FIvnSh9Eon+Mf
	vjpoxGa1VDNhA4DYVTn3i5e9QsDDidN3LEBEgFPRlY3CdOhzoezSqsa1yh6foaOrH5yL2Pz01jm
	/G3AnmqVd6VmquZcHfWTcpDCuVywtXhDUKa7LA/3psBCXe6+Jd1+l/R6oZuEdDTytLfM82iffFD
	IksYTunhp+ePdo/DBHRsrAB9H0eMlmLKoPlejvRG38w/Uoep3/R0sTgiOwwdazB9EfZTnGLoDhH
	4yJMdLeOg7noxk1/cdfoSYwQ1XYRfKVYpD6V2jqNptF3jQaUWCn+pFDNz4189hsslrYqasN+NDv
	T3OYNUSd1HMgSCXOSkHZY+4w4d77Qks4YghJtGXsD8WpKP9Nv0LHIkRmw9SOe7kdGjwYVZJDnCr
	zBaRoGXQzw5riDYq4IMrQSdqHqevhL1mqg34FjL+yWlZY9/WA3t8Uq1Wt4rdbfmgfZebVw8mD77
	t34e/Y=
X-Received: by 2002:ac8:5852:0:b0:51a:8d32:f796 with SMTP id d75a77b69052e-5266f81609fmr7452411cf.0.1784586682958;
        Mon, 20 Jul 2026 15:31:22 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214d095ed4sm81232211cf.10.2026.07.20.15.31.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 15:31:21 -0700 (PDT)
From: tnyman@openai.com
To: git@vger.kernel.org
Cc: Ted Nyman <tnyman@openai.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH 0/2] stash: avoid sparse-index expansion for in-cone paths
Date: Mon, 20 Jul 2026 15:31:19 -0700
Message-ID: <20260720223118.62821-4-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ted Nyman <tnyman@openai.com>

`git stash push -- <pathspec>` expands a sparse index before checking
whether the pathspec matches a tracked path. A pathspec wholly inside
the sparse-checkout cone cannot match part of a sparse-directory entry,
so that expansion needlessly makes the command proportional to the full
index size.

The first patch fixes the pathspec helper to use the parsed, prefixed
path consistently. The existing code can read past the end of the
unprefixed path for a wildcard passed to `git rm` or `git reset` from a
subdirectory; AddressSanitizer reports a heap-buffer-overflow in that
case.

The second patch uses the helper in `git stash push`, following the same
approach as bcf96cfca6 ("rm: expand the index only when necessary",
2022-08-07). It adds compatibility coverage for the supported pathspec
forms and a path-limited stash case to p2000.

On a cone-mode repository with 349,525 tracked paths and 49 sparse-index
entries, the best of three runs was:

  before: 18.87s (2.93s user + 15.62s system), 4 expansions
  after:   0.06s (0.01s user +  0.02s system), 0 expansions

A full-index control was unchanged (1.62s before, 1.65s after).

The series is based on 48bbf81c29 ("The 5th batch", 2026-07-19), the
current master. Focused sparse-index, stash, pathspec, rm, reset,
SHA-256, and unit-test coverage passes. Clang, GCC, and sanitizer
builds also pass.

Ted Nyman (2):
  pathspec: use match for sparse-index expansion checks
  stash: avoid sparse-index expansion for in-cone paths

 builtin/stash.c                          |  4 +-
 pathspec.c                               | 12 ++---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 62 ++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 8 deletions(-)


base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
