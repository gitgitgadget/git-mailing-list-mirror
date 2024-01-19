Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A25380F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674432; cv=none; b=GU69SkOS+NNdxysQ8QqSflpjWidIAqxHR462N/9zZENMtoPYfYFjbQaffuP+HPEEgj0QmJajvVTN5pxM11ra96MAu3d/TM4UZvyFHzC2bxYWeUBmOY6JP2Zm00N1Hwkfi4UIXAx7gVVCNxz1N5LxPeNbaBZW/Nn9eNnw+hiKaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674432; c=relaxed/simple;
	bh=5vi7/eYTh24zvekr8QYLsCQuELyxlwWn4oTWAk63sFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syziLjcWiyGJB/TLBkWd4c2SNJ6hgOTOroyIg2CLvM2i7Jh6iejzErc+uxhyfMLEJFujRyiY6C/SEflrvF7jz3z1FKeJKx9/aXXfgfw5NEkxZ0jXH8/J6m0VT2dymNhJhwEZXtGBAUqdUTrBH0xGhnyDKAnpFRRSnJhHnq2puk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUHdhQIG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUHdhQIG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2dd05e02ffso78451766b.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705674428; x=1706279228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDinG3JNnmEpquLFyIo3XqSWzFd8AN4mHrtz/4QDb70=;
        b=ZUHdhQIGHYwY0OIjyeCRGlMr79OWM89AIyZDBQPVJPMuKGyPfSqAHtfdNKIKTDX1Zt
         6UXBoUHUObtcJf4CLKBYiMTw6QdwExHsgughj5DFB5L4fom1mveT15sl2Aeph9JSPr/3
         2ZpD+4LFPz6d5z3NIOZxzR5eP3H8iljE5/qS2iEfl0GvrjsfJEb47EmACH7IEVjy5ZXA
         Iu/adiWl2fVWXfGZuY2R14qIxb7/AsIm+ozoB0a0D2D3Cr/cPVMH5KBj17Fiwo9/smGS
         WIcabPfkUTLr2OptqBlR+YRaR1wnznv/ALY6WBqsManEKP66V8Ldjksl7hnB3XEG07EF
         Gaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674428; x=1706279228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDinG3JNnmEpquLFyIo3XqSWzFd8AN4mHrtz/4QDb70=;
        b=FKIJEzbyKWdoVgIWeeHM47xvXv83J4AtqyxzUTYKcdLOag+Plil5GHEsA4RkajkxbI
         wUmqchwhpk15QNADn93SCKNAEwjwaM1luuCGDDbqI2XDzFW89k9AbD6q0z/IlOecbRwQ
         p4vFxQScRyzz/72u/uD/nsbzCTns+aLza3/SmLAMF+ei9lxXTqPlRE8DRJq+lI6uMK3K
         eRv+kPuwkyJDZCSLT2rqop0g3Sjj6BWc8F1gvjEnQiJrFur0pIBr0RTklHhLLse4JwOd
         FxkCpc7m2hrOOUPEjXKNzwbzXZKsTfpIgVUaJKa50MMbjiEwIhZbU6nM3CL62Rpt2bjZ
         j40w==
X-Gm-Message-State: AOJu0YwlR7E5D6r8CCN4neaI9BMRPSE6KpmMuZx1Zt7JbbCw7LARrlJb
	5flZczTVUpVT+xR+jV8mDbvwMM6m7BRqclyhCZLMfMl9WyPwOB4UmneWMbUo
X-Google-Smtp-Source: AGHT+IHIHEuVEA5KKg3U3UHHx4kvlUCvlMcoy0pgNIzMFmn5Ut1TINg+ZxsSQii7AEk6Og9qp68QWA==
X-Received: by 2002:a17:906:6807:b0:a28:fb5a:8672 with SMTP id k7-20020a170906680700b00a28fb5a8672mr1133203ejr.56.1705674428192;
        Fri, 19 Jan 2024 06:27:08 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm3843494ejd.112.2024.01.19.06.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 06:27:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/5] for-each-ref: print all refs on empty string pattern
Date: Fri, 19 Jan 2024 15:27:00 +0100
Message-ID: <20240119142705.139374-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the upcoming introduction of the reftable backend, it becomes ever
so important to provide the necessary tooling for printing all refs
associated with a repository.

While regular refs stored within the "refs/" namespace are currently
supported by multiple commands like git-for-each-ref(1),
git-show-ref(1). Neither support printing all the operational refs
within the repository.

This is crucial because with the reftable backend, all these refs will
also move to reftable. It would be necessary to identify all the refs
that are stored within the reftable since there is no easy way to do so
otherwise. This is because the reftable itself is a binary format and
all access will be via git. Unlike the filesystem backend, which allows
access directly via the filesystem.

This patch series is a follow up to the RFC/discussion we had earlier on
the list [1].

The first 4 commits add the required functionality to ensure we can print
all refs (regular, pseudo, HEAD). The 5th commit modifies the 
git-for-each-ref(1) command to print all refs when an empty string pattern
is used. This is a deviation from the current situation wherein the empty
string pattern currently matches and prints no refs.

[1]: https://lore.kernel.org/git/20231221170715.110565-1-karthik.188@gmail.com/#t

Karthik Nayak (5):
  refs: expose `is_pseudoref_syntax()`
  refs: make `is_pseudoref_syntax()` stricter
  refs: extract out `loose_fill_ref_dir_regular_file()`
  refs: introduce `refs_for_each_all_refs()`
  for-each-ref: avoid filtering on empty pattern

 Documentation/git-for-each-ref.txt |   3 +-
 builtin/for-each-ref.c             |  21 ++++-
 ref-filter.c                       |  13 ++-
 ref-filter.h                       |   4 +-
 refs.c                             |  32 ++++++--
 refs.h                             |  12 +++
 refs/files-backend.c               | 126 +++++++++++++++++++++--------
 refs/refs-internal.h               |   7 ++
 t/t1407-worktree-ref-store.sh      |  12 +--
 t/t6302-for-each-ref-filter.sh     |  34 ++++++++
 10 files changed, 214 insertions(+), 50 deletions(-)

-- 
2.43.GIT

