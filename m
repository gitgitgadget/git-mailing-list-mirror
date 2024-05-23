Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD63C00
	for <git@vger.kernel.org>; Fri, 24 May 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508827; cv=none; b=OlXfZwaaLP19idRM0K5palm4YsQTtbPCMH5DI5wNgqt+HlPDkwlpEqYX010m/q9U+qhaNgro7r0PduOgs/lpnMcdr11BZI/7txoAcN4aQV5EY2KK1yzCIPK8kMIu//A9/T1RUlUKptdXEVUZMB/AvPWxOHFVaUpH0AxdrPbHWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508827; c=relaxed/simple;
	bh=R2KuueAr20avy83oSfEq1jg0V2KJXqXAI1ccfYVRw7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6eyQwxVuRzvlL8dSCVzZkTBLGE5N+mUB/1Uv43U4v+k6eldsjQggXz1nRkCpRTI/8akg1VFjweKgLqVUe3MdjlCK/UDBJT8GUcGtqkMR+IDXVxPLHXfZ+7ZgdhfPGMeQW0lTjdJsohRoLPvYgbtUWm6+ldNNNutxyQhyl15GZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTMGUEds; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTMGUEds"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-681907af6a8so265530a12.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716508824; x=1717113624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MedhlkRv6eeQv2xoPrJLj+9s3jDgR/YuQQHqzzOd15U=;
        b=dTMGUEdsN3+1MmH5KzzAmtS9/nUcHw8WdRqVrgwUzk9p1DGr33B1QnZSnEjzTyMyPO
         zD5XxFUpSAJvzAs/+r3K2ZpnSaTX3ypD3C+Xk2RiC4hsW73nARkrOp+egONpukKLeAD+
         SYnhdWsf889Gt9uMF8M9Qkg/EMzLprmu9BxjtIEbkon1rT80TVugP4URvnnUCtFoiP1I
         h1VJeGfoD0ecb8fXe3oRZktYM+ShC9fmuYQjujRbj8Yz4DYRCEhUR7gLvvdIlNTIiOT2
         JTV874LUIuYgIpar1q0wALCUUe8nXkLCpeCCQ4i/C60emKjPZvYMt8ZEDEMsvq6K42Lr
         /DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716508824; x=1717113624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MedhlkRv6eeQv2xoPrJLj+9s3jDgR/YuQQHqzzOd15U=;
        b=rI43dq98n8TbmPBxndWLdUYweoE+2j/sJQZl20mnNC2sTRIEvTKaiNLDBfp7bVGmgf
         PeZ2FpzVkDaK/D9QUAw0DKUipiziM94Ar1hnwoCQFqNtxW7jt6/4yBc4Orey/LpSjmOx
         f1YQxxyTPT9/r0tmFNaANciJjfqIzgm7iaXj/a6CNsLASIgWFDcw0tvEClF7gJVD6zsA
         7qDXOpMsBD24cIRQa0C6gaNUdX7JIt0JqFJ77eI7KFipaPaQ+jpNFAKqLD/Hy8gukxlc
         JjzH3GlGzzzp+87KXE8iQfgay/bXMpIBY9i8ItgGDdx7/MnjeEcMAKGzKV/5WqWf8QyH
         s4pw==
X-Forwarded-Encrypted: i=1; AJvYcCXpZllYY64rqRW9GhX8M+LPcGGdqBrUkHEh1mL8VakFMPbVXiNm8pO54b4juBSY5W2c1t2dplpsVtS7/gGYZY5DVuYT
X-Gm-Message-State: AOJu0YzUy+5JE0KxkKkvgNpjT8qmPEiV0cOXV0R/qRpU4IBIiDHrSD1A
	bkCiWuVwvYoVeyUSD0bB21gNWqCUW4fKdcMHvkjByE5S1LEFEmM1
X-Google-Smtp-Source: AGHT+IGWgLyGl4u5Yy6IJadU+3IxewCzItXmu4/HJHJNzBsi6/Xgut0eZTBckmfp+qc44fJ+nuUYiQ==
X-Received: by 2002:a05:6a20:96d3:b0:1af:fbab:cfba with SMTP id adf61e73a8af0-1b212d48965mr988532637.27.1716508822463;
        Thu, 23 May 2024 17:00:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05ab4asm165454b3a.59.2024.05.23.17.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:00:21 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: ach.lumap@gmail.com
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v3 0/3] Port t0015-hash to the unit testing framework
Date: Fri, 24 May 2024 05:29:42 +0530
Message-ID: <20240523235945.26833-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240229054004.3807-1-ach.lumap@gmail.com>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- use st_mult() instead of unsigned_mult_overflows(), as suggested by
  Junio.
- split migration of SHA-1 and SHA-256 in different patches, as
  suggested by Patrick.
- Revert removal of 'sha256' subcommand of test-tool due to existing
  dependencies on it.
- Fix some formatting

CI for v3: https://github.com/spectre10/git/actions/runs/9216124753

Ghanshyam Thakkar (3):
  strbuf: introduce strbuf_addstrings() to repeatedly add a string
  t/: port helper/test-sha1.c to unit-tests/t-hash.c
  t/: port helper/test-sha256.c to unit-tests/t-hash.c

 Makefile                    |  1 +
 builtin/submodule--helper.c |  4 +-
 json-writer.c               |  5 +--
 strbuf.c                    |  9 +++++
 strbuf.h                    |  5 +++
 t/t0015-hash.sh             | 56 --------------------------
 t/unit-tests/t-hash.c       | 79 +++++++++++++++++++++++++++++++++++++
 7 files changed, 96 insertions(+), 63 deletions(-)
 delete mode 100755 t/t0015-hash.sh
 create mode 100644 t/unit-tests/t-hash.c

Range-diff against v2:
1:  b8c4ab31c6 ! 1:  cd831fabf5 strbuf: introduce strbuf_addstrings() to repeatedly add a string
    @@
      ## Metadata ##
    -Author: Achu Luma <ach.lumap@gmail.com>
    +Author: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
     
      ## Commit message ##
         strbuf: introduce strbuf_addstrings() to repeatedly add a string
    @@ Commit message
         strbuf_addstrings() would be similar for strings as strbuf_addch() and
         strbuf_addchars() for characters.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    +    Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Co-authored-by: Achu Luma <ach.lumap@gmail.com>
         Signed-off-by: Achu Luma <ach.lumap@gmail.com>
    +    Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static void module_list_active(struct module_list *list)
    @@ strbuf.c: void strbuf_add(struct strbuf *sb, const void *data, size_t len)
      
     +void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
     +{
    -+       size_t len = strlen(s);
    -+       if (unsigned_mult_overflows(len, n))
    -+               die("you want to use way too much memory");
    -+       strbuf_grow(sb, len * n);
    -+       for (size_t i = 0; i < n; i++)
    -+               strbuf_add(sb, s, len);
    ++	size_t len = strlen(s);
    ++
    ++	strbuf_grow(sb, st_mult(len, n));
    ++	for (size_t i = 0; i < n; i++)
    ++		strbuf_add(sb, s, len);
     +}
     +
      void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
2:  20a7ff8e24 < -:  ---------- Port helper/test-sha256.c and helper/test-sha1.c to unit-tests/t-hash.c
-:  ---------- > 2:  2c4471ce37 t/: port helper/test-sha1.c to unit-tests/t-hash.c
-:  ---------- > 3:  68dcf388d8 t/: port helper/test-sha256.c to unit-tests/t-hash.c
-- 
2.45.1

