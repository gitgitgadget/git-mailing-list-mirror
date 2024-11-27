Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EA18E1A
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669194; cv=none; b=D13f9UaBvCSTKfN39Ab+xLYAxFCPCs1jpklsytBMz5uKuMsSx+cfKMLh5w0hKn6HLC2QWraW8PWftHHegkbnRNfFNTlcSZe0EGr2cCMPnJaQlXlzB8b90YlPZwhpvXNyNj4Zx4hqmV8kgbK+keE9fqSRpvCfTf316USI8tZ6cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669194; c=relaxed/simple;
	bh=e19q1swuwA/B1RxPrULDlp1UV3GVYuDG7LWYdRFqrZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwRi9cA/k6VWO3gVjjmSn+nHGaGH1ymUDL0x9TxNPHqrLS13VQbkj9LSTVRLLautyv4NhDXoFwJ+6FhXeK8mTOZSK91fiPr8bDqC5g5AmxtHD2Pkcsim1KFFAzG0OgTrCEL7XjWYSRNWNKzh+UqNfKUiuHNS8oJWPuNMFYtF2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmicKeVi; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmicKeVi"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71d4ff749baso1400656a34.0
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732669191; x=1733273991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnUQFfAFL5jWB1zjcVYfSxDIYaMQAbodTMvKbhd/go4=;
        b=cmicKeViGAlWRXatKFsmmWz4yp0s5wxXwmuWlrOw4Fx2IzbYjfWnfBeobFkiCwSlpj
         xjmvxCUKXt7xNYNROSsT+KP7j1SsESPt4QlbEphVmsriGhjVviG0uUcU1gY+JSV2HYEY
         eC7rZwV9ApPmXJ5h62JTnRaeJdZdbXAXjC81HqDZ3n9tntzZSIIwuVoREqKWbtyrV19f
         W1vlpnJ7au2/Lvhx0RxoprM9CLDGDGAdRYmruhpXViD6F/1KGPCVMD5p+1bcXH6IyHRn
         rYtFJUqBNkM4qIk9dze/m4qvnlOYfdohcXbA6mv4ho8iwXm7YxMRBKHs/PPxhltjMJ0w
         BN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732669191; x=1733273991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnUQFfAFL5jWB1zjcVYfSxDIYaMQAbodTMvKbhd/go4=;
        b=YFVDAZLG86M2WXtMJtCpQsYYOXUApssonzqt7YVPlj6avkdBxljJdgdSGhUXhQJ204
         8IZ0WWWNNFuhou8dOlVK57O1OZD2ZtV9R12JNPRrZlttySdpZCQSp9gBJ0R1vBK0tH6r
         CdbyLYJz0sEL2PId0Y3C+uHdFymBoEGyAlWTlhmUoivCh0YhLpp7RGJLR+Udog7Qs9KJ
         9h5qQ3Le9NtP5jBM2kLYEpOnrDBAcujTc//LVfsSwwPVGCGqrkxT7gGNM6M49fPeJgu5
         rWasBNaqsrDblg0haxXpZ288b4Beh73I2JjU0VQeXgwUqqffXIxptLhSZnLaUmqxiNDy
         8xsQ==
X-Gm-Message-State: AOJu0YwtO+T0KCuks1oj555tqMwfqcrMxfG2hNTHFnjP+aIcMSW8SCB+
	lqQXb2OFeWIF5xdwatGo47AS1KeTGKmAk0k2rmlKfgoiGVGhKvZsIsXZPg==
X-Gm-Gg: ASbGncub1PKwVsUjI79zW2g6XRVb3b5zYIEURlmc8S8lLscBZ1/2DxG7ubrVYiMYtp3
	lAoLdfHrLSwYlVlrlNDRfIUUNbUnMSPbr3QkyMyAKW3zT/MrHIlrxxHtARMa9lVaUd/oNkINfK2
	vPWTrDuxqFGtnpxaJN8xR35bthTVbJFtLUrjuaHA7NJ1BsEdP5trtwW4oW2gUxf19eyOWfOBVOc
	tEJaivpKiT0IiSweBlVcjfTD2OmCwjqGnUoOOTR5kYbsStmI2SSS2YJBQ==
X-Google-Smtp-Source: AGHT+IE5MWZOw7WoR73ghvyYF/kqVOvCHrsUpaUxERDd5D4UqgGaIJz49wl0CPml/4iMvjgZLzUBbg==
X-Received: by 2002:a05:6830:4108:b0:716:1530:fc7e with SMTP id 46e09a7af769-71d65c6f778mr894474a34.1.1732669191440;
        Tue, 26 Nov 2024 16:59:51 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0378d26esm3316643a34.31.2024.11.26.16.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:59:50 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/4] propagate fsck message severity for bundle fetch
Date: Tue, 26 Nov 2024 18:57:03 -0600
Message-ID: <20241127005707.319881-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121204119.1440773-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With 63d903ff52 (unbundle: extend object verification for fetches,
2024-06-19), fsck checks are now performed on fetched bundles depending
on `transfer.fsckObjects` and `fetch.fsckObjects` configuration. This
works, but provides no means to override the default fsck message
severity as is done for other git-fetch(1) operations. This series aims
to propagate fsck message severity configuration to the underlying
git-index-pack(1) process executed on the bundle in a similar manner as
done with git-fetch-pack(1).

  - Patches 1 and 2 adapt the bundle subsystem to support additional
    options when performing `unbundle()`.

  - Patch 3 adapts the fetch-pack subsystem to expose a means to
    generate the message configuration arguments.

  - Patch 4 wires the newly generated fsck configuration options to the
    bundle options used when fetching from a bundle.

Changes in V2:

  - Reverted unnecessary line formatted changes.

  - Simplified fallback logic for default `unbundle()` options.

  - Dropped unncessary shell structure in the third patch to keep the
    patch more straightforward.

  - Instead of exposing `fetch_pack_config_cb()` directly, the fetch
    pack fsck config parsing logic is split and exposed. This also
    addresses the issue of unwanted default Git config parsing occuring.
    Consequently the previous third and fourth patch were condensed into
    a single patch.

  - Improved explainations in the patches, naming, and various style
    fixes.

Due to all rearranging in this version, I opted not to include a
range-diff.

Thanks
-Justin

Justin Tobler (4):
  bundle: add bundle verification options type
  bundle: support fsck message configuration
  fetch-pack: split out fsck config parsing
  transport: propagate fsck configuration during bundle fetch

 builtin/bundle.c        |  2 +-
 bundle-uri.c            |  7 +++++--
 bundle.c                | 13 +++++++++----
 bundle.h                | 17 ++++++++++++++---
 fetch-pack.c            | 24 +++++++++++++++++-------
 fetch-pack.h            |  3 +++
 t/t5607-clone-bundle.sh |  7 +++++++
 transport.c             | 26 ++++++++++++++++++++++++--
 8 files changed, 80 insertions(+), 19 deletions(-)


base-commit: 4083a6f05206077a50af7658bedc17a94c54607d
-- 
2.47.0

