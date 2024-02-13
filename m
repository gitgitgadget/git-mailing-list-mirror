Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5D60BA4
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857546; cv=none; b=PJ11jLNlAQNvxu2HajRpQyjHfJanB1+D/ck3FvKajwNiWYiZDXnKPKVYV8bHcRL+r7ScHE6fow/tYgXdbOgUk4GftFsB2W5A5GCABs+8Nr5+AfyULOchIMc7LL9VkBSQQL8fFPLRSzsvUBLjBcwH7JnXFMgL74sDkW5EY4nf0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857546; c=relaxed/simple;
	bh=JKLoLyJE1GSw5pCx5WZ8A0MsZJh5jA9Y1CRdrc1Ac1g=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fGDSPg7LZ5SP6MmzeHf88bp5uGL2UnW+CTEA1DBZINNuRh3ifxOBqcrGG3sFESHs5rP+6nBTE/j27RDhdC6QiqKGmHKZoQWVj3RlnTQlBFMquIPtJw1DtehzyO9Dh57+RGNF7Z51VQ/WKnoJoyFaXZcScXknkpiH28a4Ir1ElCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWvX5sL4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWvX5sL4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so3377990f8f.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857543; x=1708462343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f4Vf19coUtLABHh8LGk4CqKonpqpnUHKJNHgo4ueToY=;
        b=QWvX5sL4CdLZiWQwMpaI+MvC3Oo3nhUL9smJwXYXYXEgcVWhnElHGI1Y5bNDcV61hi
         6lc2g0IXSiNpaKKwipsqRThoh7jC4WOAwNzKEyFtABxlCZ2hjHP5txX+oxZrz9aN+B8A
         L6+/YWWCNQcM8hqPL4N49cmDg+n1d2dgJgAViAdFC16dmqg56RIDyIRPN90N1o8QNiDw
         3N6mY8Rn1v9Kg2ygs81Sge5a5U/UNkRgQ0qLSbs21L4h11T6wWsphl4BokpiWSn27ICf
         4ntDZ4oqRoh2MxAn6ZhpIz2zvW0K7KcPOL6qnu5lwkT3CcPl6YiE2JyXfRJkIyEz9tCI
         +mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857543; x=1708462343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4Vf19coUtLABHh8LGk4CqKonpqpnUHKJNHgo4ueToY=;
        b=TEVclsF7ThgSUjypjZr0V5gxbFKJ3iHkOTeTK2y/Bh14lqNu36QM7/B5IYfOA2zaH9
         nyFYD49bglXA35MPf+4OxJP7P2YMJ5mhJQdnuGImYJ86ME/VFYFWrAPX59nT+PgPbABx
         L5wk0qSLsDlymtJkrjtToVh/cJ7AWYVIyl54BRr3J/gzzypeZiktJxBPNySgc3iePtZF
         MV3Q4nZNgjuAYpPhNyrvXDgcRH0Pd9mdl7teYrNv5btFaP6s+Lx0q3ayQLiG/slqWKhk
         8hp6NSiewg4nyqqnoaoQbnuUWnk6XcJO0kLLzR77hus7+r1tKVYaeD1zXgBl9M6g2aeU
         xX2g==
X-Gm-Message-State: AOJu0YxEa/PBuLB7FkV5GNH/2N/o5yANLzsmZxv4LDKyu0lTmtphXqmG
	E8CRFfoTcHjPFDrk7Fug6XfpFikm1qKk9u26BJXeXIEFl1z4WZSvkrnoKmGd
X-Google-Smtp-Source: AGHT+IHll/FPeLf3xmNjsKXYf7acTE/GF0f0Nr87dIRrCba3NtwRg9kmVQ83Ti9ad6zrGC2OKBEuuQ==
X-Received: by 2002:a5d:58cd:0:b0:33c:e1d4:5f4c with SMTP id o13-20020a5d58cd000000b0033ce1d45f4cmr299680wrf.54.1707857542663;
        Tue, 13 Feb 2024 12:52:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c4fc100b0040ff583e17csm12896302wmq.9.2024.02.13.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:22 -0800 (PST)
Message-ID: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:09 +0000
Subject: [PATCH 00/12] FSMonitor edge cases on case-insensitive file systems
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff Hostetler <jeffhostetler@github.com>

Fix FSMonitor client code to detect case-incorrect FSEvents and map them to
the canonical case expected by the index.

FSEvents are delivered to the FSMonitor daemon using the observed case which
may or may not match the expected case stored in the index for tracked files
and/or directories. This caused index_name_pos() to report a negative index
position (defined as the suggested insertion point). Since the value was
negative, the FSMonitor refresh lookup would not invalidate the
CE_FSMONITOR_VALID bit on the "expected" (case-insensitive-equivalent)
cache-entries. Therefore, git status would not report them as modified.

This was a fairly obscure problem and only happened when the case of a
sub-directory or a file was artificially changed.

This first runs the original lookup using the observed case. If that fails,
it assumes that the observed pathname refers to a file and uses the
case-insensitive name-hash hashmap to find an equivalent path (cache-entry)
in the index. If that fails, it assumes the pathname refers to a directory
and uses the case-insensitive dir-name-hash to find the equivalent directory
and then repeats the index_name_pos() lookup to find a directory or
suggested insertion point with the expected case.

Two new test cases were added to t7527 to demonstrate this.

Since this was rather obscure, I also added some additional tracing under
the GIT_TRACE_FSMONITOR key.

I also did considerable refactoring of the original code before adding the
new lookups.

Finally, I made more explicit the relationship between the FSEvents and the
(new) sparse-index directory cache-entries, since sparse-index was added
slightly after the FSMonitor feature.

Jeff Hostetler (12):
  sparse-index: pass string length to index_file_exists()
  name-hash: add index_dir_exists2()
  t7527: add case-insensitve test for FSMonitor
  fsmonitor: refactor refresh callback on directory events
  fsmonitor: refactor refresh callback for non-directory events
  fsmonitor: clarify handling of directory events in callback
  fsmonitor: refactor untracked-cache invalidation
  fsmonitor: support case-insensitive directory events
  fsmonitor: refactor non-directory callback
  fsmonitor: support case-insensitive non-directory events
  fsmonitor: refactor bit invalidation in refresh callback
  t7527: update case-insenstive fsmonitor test

 fsmonitor.c                  | 338 +++++++++++++++++++++++++++++------
 name-hash.c                  |  16 ++
 name-hash.h                  |   2 +
 sparse-index.c               |   4 +-
 t/t7527-builtin-fsmonitor.sh | 220 +++++++++++++++++++++++
 5 files changed, 522 insertions(+), 58 deletions(-)


base-commit: 3526e67d917bcd03f317a058208fa02737654637
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1662%2Fjeffhostetler%2Ffsmonitor-ignore-case-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1662/jeffhostetler/fsmonitor-ignore-case-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1662
-- 
gitgitgadget
