Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146E3E024D
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430587; cv=none; b=M2lSjJ8vaGdDEodkgj5fByUlu4T8VxINn34lQwQEW9XXtl0h/bVC16jyHbArgfB8NQ9Tlo6P0RkEWAyqo0wmq2/f2qZzpFzzl4h82HBfBh3LdGRYD9NBXDTzzoTfpVX2+7Z2UeiGX6+iiF4tiz5RIzlPrPnG7Ekv21dhuMuiw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430587; c=relaxed/simple;
	bh=kFqc9LX5KfzzDp7zZRjETPKHtu4SgdVEkUgbNHwIsS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dx3DGf+8ogcmih3jKyhPemJzb/sQnjJGO59cNWCPqNtnbbLt3e3u2fN5SbTH8vJYCflBRVMTel8qK2QU1JyczYuKDOAfBF2z3RoXre3uKlLnv122Orp6FKty9Y4RfgjJeRLSSNPEajVcVVK36Et+3x6q3cVdy4KdXcJaNXGm4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmVbWrTH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmVbWrTH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd80bea5f3so160398885a.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773430578; x=1774035378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SMNS6AGaAmgJEbtDsoIR2HHRh/neSAzvioDm4CZdMZ4=;
        b=NmVbWrTHIzopqvA7Iw8tiXKoPnGF3eRzpoYfaJDy7WsVL0lbVYgodEN9drPnP6WMZa
         fm2lBAi2b1U8WymzCytC4XE7DzI23rlazUmRmdja7X2zYtLIPSBlvBfAGbnIEsnjmZrj
         oi4SMqvJ2VanO+gYJCRzmu6Qb8ireRhzzw5hMEm1+V5Wguy8touGmSGN+/E8e/W9J7pp
         7UYvBfHL4EhScvghjWwF4pIu8tZ1PK5iAoFBPadWVQqRzlxjf2/yqgKK0t/0aKlW86be
         eQzfHhMcnXLYph9HVoyO8QKTNs1HTJ5XXrh3AAM4DLon98gCTdb6beZ4iw/3udJFKXpB
         OG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430578; x=1774035378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMNS6AGaAmgJEbtDsoIR2HHRh/neSAzvioDm4CZdMZ4=;
        b=b+CN9z8htFzLUzWFlo+3q1/vEIaoJycW6thLg2oLkCAUdpZBaIU+0Qg5EoGZNN18Hh
         GEfMfj8yVrzktE/z+sgKDf1kaMHTOimYCGkmpsS1bDx4hb370QHh5RIpFNo59zetEBAc
         avm4OBzTV/RCwQ2UQqOy0GilZcHXL2QhXCnVaQQc/IfJofWdwHFpeq6Hf7fWwKpldt9f
         RNe7BnSyf/wmz4nzLj9XpXNxcsbRPLKtG2i1LCiNj5QnTGTbK2MMCZbUWgqAy+Wg5Vrl
         vbbNeqf7DyLcmwMrY9Vz7YW9IjD1ExSKKNpTebEI830FmftUo4PFqhoImz+PuvkQlzz3
         lL4A==
X-Gm-Message-State: AOJu0YyMyCD4RmwcBwADkqD+VZON/8vIjEwE1lLY8Gp4ag35zKw4o+mX
	/n/J46BQUTRLFzxlIi67zywhxUhbMyqSkppJJaLVdnEuSDztBffvtYoHYKeoFw==
X-Gm-Gg: ATEYQzxAETfSw0u5SiT+K+U9//sM0V/jbq3IbKba+2QY896v34BJcd7/v6h6hSO93KD
	kt7rm1PIQU6fR7nMwTr6T1UAIU/EnmEqzhcLw2+bjUVTMY6m1V9kjh+cY9qOoDE7FPknGqW0jTC
	jm0vFFsEeuu3b2MPS5Q0LYcV9MR0j0Wt0UWg0/hWVlaqmNEjlRdeMKp+eYmIpnUTEhQAqWGleeY
	1URyvaGPDAYTiOuAujpakWLu7EMtgV9nTgOk3iO7qrNpXvuisxLNM045NRW52HF6VLV/0QnPv/X
	bNqzD+ba1asDrTWOg1kicWYaY6/jZ+h+Uil+/B3fwej2A9Z6OxcgDxwUUcL53n1bxJfJDOnztyf
	qhIyt9OPJFJfe6ec/prBjl5ehxz0hZHAswxvUtr1HGtkRBurb0NI3UF2SgQHY8lAVkpPZMftuJZ
	GjH2ap1CxG8DUvI+D8GZuCQlF/YSNyTPruUimU59yCAzue4UOUYQ0NyZhNuQRV
X-Received: by 2002:a05:620a:2802:b0:8c7:a84:d0e4 with SMTP id af79cd13be357-8cdb5a4c395mr627581485a.24.1773430577685;
        Fri, 13 Mar 2026 12:36:17 -0700 (PDT)
Received: from eju--20230906-5R2TJ ([74.15.89.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210daa1sm633711285a.26.2026.03.13.12.36.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Mar 2026 12:36:17 -0700 (PDT)
From: eric.peijian@gmail.com
To: git@vger.kernel.org
Cc: ps@pks.im,
	jltobler@gmail.com,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 0/1] Add "preparing" phase to reference-transaction hook
Date: Fri, 13 Mar 2026 15:35:35 -0400
Message-ID: <20260313193537.62827-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

The "reference-transaction" hook currently exposes three phases to callers:
"prepared", "committed", and "aborted". The earliest of these, "prepared",
fires after Git has already acquired exclusive locks on every affected
reference. This is well-suited for last-chance validation, but it arrives
too late for any use case that requires coordination before locking, such
as serializing concurrent transactions across distributed storage nodes.

This series introduces a new "preparing" phase that fires before
refs->be->transaction_prepare() is called, that is, before Git takes any
reference lock on disk. Hook scripts that handle this phase receive the full
list of proposed updates and may reject the transaction by returning a
non-zero exit status, causing Git to abort cleanly before any locks are
acquired.

The motivating use case is Gitaly/Praefect, GitLab's distributed Git storage
layer. Praefect must serialize concurrent writes that target the same
references across replicas. With only the "prepared" phase available, by the
time Praefect can observe a transaction the locks are already held, making
reordering impossible. The "preparing" phase provides the necessary
pre-lock window.

Compatibility note: this change is not strictly backwards compatible. Hook
scripts that do not expect unknown phase strings may return an error when
they encounter "preparing". We consider this acceptable for the same reasons
cited when symref support was added to the hook in a8ae923f85 (refs: support
symrefs in 'reference-transaction' hook, 2024-05-07): the hook is documented
as exposing internal implementation details, and its semantics have been
adjusted before. An alternative of introducing a "reference-transaction-v2"
hook was considered but rejected as unnecessarily heavyweight.

Eric Ju (1):
  Add preparing state to reference-transaction hook

 Documentation/githooks.adoc      | 19 ++++++++++++-------
 refs.c                           |  9 ++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++++++++++++++++++----
 t/t5510-fetch.sh                 |  7 ++++++-
 4 files changed, 52 insertions(+), 13 deletions(-)

-- 
2.51.0

