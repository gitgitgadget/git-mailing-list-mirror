Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C579F2
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437308; cv=none; b=mGbgpIaO/rx7xqt6Y/U/OA76JXw/GmG628OZvezOpQOY6J+Q4kTPC242xl7Fu9O4ZBzbjov9NW2x0JtX5cZU38f/v4fEakRG8vzbsN6bYNWirwsmM7t9gKSDq9j3HOP7UUthCwEZiv4DS25ikn+i2imHPgjJUWbQvk09Qo8RLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437308; c=relaxed/simple;
	bh=qwxYRw8n/zvtKSQOF5mU3uJpjupq3vdVW4RCUnaytCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDLaLeqVs0fsQAVPHDDTqos6Hx+W1vYTP44ai8Hw9X/xO/zA6TEhQIG6yVDC1malY7Z2206VoeXTwUGEeOmaT4O0UqoM/xa+r5Bbrt5REFoQW4Qrrbms2exgZ8wi2YHjDlFQ8XGWC7LoX0TZgpGyt7aTzBSyvkA9TTxsHRVnQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KW9YgHMw; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW9YgHMw"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601b1132110so115467eaf.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 19:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742437306; x=1743042106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT/47HlV5n5pcVX72x8qw5ZlRBsz5kj+6HHq2XOkYu8=;
        b=KW9YgHMwwLVZ6/nw6iyMgD4F2amBu/TC9Gh8ljHyMUh1gIdb2N3Upi49qI8TQQvwhH
         duwoekZNQRs3Og+7skPffOW8q7lcR7N+EeRIFxtlnB8lGzYyPnPdBy2kM4EptIATQJVe
         z472l8ZHn5wtxbjSClR8uLfYV3ziXkc+Oa4+RzLyoawNKOWgOL/AOFhOzTe7Xtm9NKxb
         iK6cQah/vdUm/fHanrFD9BI/YudkpGeSVWk3Jhl5u0OAy+zpuWJtkixShi/4hjPgRB5c
         Q2kZdbFS76RnXEkZLVelLickYKE4t+po1G8fsfeJhKty8hFLhz+Ri1S6SV9ipV2KZ7Gs
         0j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742437306; x=1743042106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bT/47HlV5n5pcVX72x8qw5ZlRBsz5kj+6HHq2XOkYu8=;
        b=OHofzESWuurkctZ5rloV8E1rIDIndeysd4vLqgOlbMkMjOYj+i5CbxuL4oxvsQS2fd
         qCJXAGjYzMT9mNi46OSjzmP4cPBpiTGwl+gUsxDOp9ByHdnHvvdWJtSTHI/Ar8fcJiEJ
         mNEx6HZuL+ZrrBg08hiz14hqv063vQHP3zovworRxO58mbUxwQKM4C0cZILUaVlvCBIR
         5SHqJXFOPU5h+zZeLjKFru+vEtxL+lVUH5+yV4HMEMBt1wQyovfv1GfVqKYBWDkzcm9x
         XZSVxoWyXHEFR4LdVChsUQh41vBTrgVIuxP/17gaL/sGpamwHWiWNjG1lVocH9gUmX6L
         a8yQ==
X-Gm-Message-State: AOJu0YyOrzlyO2xwgYv0tLfhJxS/hSRmFKrirSCGJ7Zxt9FvlR58zyyd
	Mk54DSZM6xkz1xjemcJ7gJF22E8pKQ8VuUhN7m+Ap1XkMkbCC6d8ue95/Q==
X-Gm-Gg: ASbGncu77Vo15637GbfiJSxwHcESPfLHrPuPlYUkc4EUByeB0EK/hb+/oGYh8OGUQoh
	KxwklyHlem0FIVRm+49er28KILPa7ebDgOzZAu6SHra1hVcwj+/6JZLhL+du72GMWcCz/HzIa/W
	7TCLNSeIXbnhGngsylDxMu/+abgJUo5R3GX9Xxbt4SxuDSXcaeuYgZdwmZFs5oCabv+RR9DoefT
	IvtyodmH7vCFU5gR7WiBstf6x1rVBQnQwQy/ERpJp1dRIIiseNyge6+Z4yMm3Md2WjCnXNc3t9O
	DNetFYizaSPdrTY3PdUVdk8AGJ7wGb47ZaTq4xARHMrMPTgawScP
X-Google-Smtp-Source: AGHT+IHzyChdUX7/w2j+v0M2KdcmeqwYO2+whIMlqD1A7L2cokl9Bwma/CV2S4LQCemX0+5LoNNYNw==
X-Received: by 2002:a05:6820:678a:b0:601:cea7:9b96 with SMTP id 006d021491bc7-6021e4f96f4mr2548022eaf.7.1742437306111;
        Wed, 19 Mar 2025 19:21:46 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601ff46adcdsm1549579eaf.10.2025.03.19.19.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:21:45 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] clone: suppress unexpected advice message during clone
Date: Wed, 19 Mar 2025 20:46:44 -0500
Message-ID: <20250320014646.2899791-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been reported[1] that starting in Git v2.45.0, cloning from a bundle
results in the default branch name advice message always being displayed
when it was previously not. It can be reproduced by the following:

        git init bundle-repo &&
        git -C bundle-repo --allow-empty -m init &&
        git -C bundle-repo bundle create ../repo.bundle --all &&
        git clone bundle.repo bundle-clone

This issue bisects to 199f44cb2ead (builtin/clone: allow remote helpers
to detect repo, 2024-02-27) where the refdb is partially initialized
during clones before remote helpers are executed. This partial
initilization creates the HEAD file and "refs/" directory.

A side-effect of this change is that the location of the first
`git_default_branch_name()` gets deferred to a later point of execution.
This matters because `git_default_branch_name()` only computes the
default branch name once and returns a cached value for subsequent
invocations. After this change, the `git_default_branch_name()` call
site that actually computes the value becomes `guess_remote_head()` and
is configured to always show the advice message.

Also, `guess_remote_head()` only invokes `git_default_branch_name()` in
cases where the transport is unable to figure out the remote HEAD and
must guess. This explains why the advice message gets printed for bundle
clones, but not all clones.

This series addresses the issue by adapting `guess_remote_head()` to
support configuring the underlying `git_default_branch_name()`, which
has since been renamed to `repo_default_branch_name()`, to be quiet and
suppress the advice message.

Thanks,
-Justin

[1]: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>

Justin Tobler (2):
  remote: allow `guess_remote_head()` to suppress advice
  clone: suppress unexpected default branch advice

 builtin/clone.c  | 4 ++--
 builtin/fetch.c  | 2 +-
 builtin/remote.c | 2 +-
 remote.c         | 4 ++--
 remote.h         | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

