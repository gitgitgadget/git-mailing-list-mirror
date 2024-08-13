Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CE19EEA4
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560303; cv=none; b=E+WQ/hbtNvHMyGzq7truc62tXSIorEuJclxy+8bWJci6DXNTZQtnsFBejE/gMa0qrd1mT5jO0S4uiLrtD/4qWMqN+5nOoTlbCYUoCCUWZCBKizISzjjKknh1WV0O/oxEiOfA2H/fUbZfN8vndo4E3zOqYTVsswlTfKCZ9bssJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560303; c=relaxed/simple;
	bh=Mnzhp2fUN3ozqkS3YiZ1Rg/84MKWwSGRzSUISkqYA+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPcKZozkRLuGp1H/leUrp0GGMC2R8lx6CFObilU4gKNQZd9EX+G8u5ACT1K13r3SeRA6kIbmG2OWkrRIwAyMLnNfytMV11z6NP0Cb673GA8LTDtRHm0fQrDYfb2Ygzss0MUblzgi10HK8x0CqFChKOglAh7wAoHbYH9ELzyBZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCagz4OI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCagz4OI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd90c2fc68so38138745ad.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560301; x=1724165101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaCXCBCz9g9sKRjgPoKg0jjN5TJ/BbhYaAMJE0cOnfk=;
        b=PCagz4OIHnqNbzdmm21UaXVmDvN0o4R+fdG0+vOZ0UgvJsKWJzxY5v2aA4T/AuMPfO
         IrNt8ehiyG/mhH7vMgm4V5CipWZawa+XPrjeh9bAkW1UJ+97noaISX27FEMqmjgMepVw
         0kZ9OxD+b77iR85LQ0RnjbTcPZIByEgxd+zL5n2p8FHtzAxVTrEdXEs7x9pIlS/kwbjK
         bMoumn0Cx0mnY1xalc5s7+rgmKYGcqE34ffhO5WeYFIRbEx+vRhdtQqPU2cm8v94tOob
         8yN0d0C4AMRHetaNne073+zg0126XTyZRhGpX9Xmiy5fkjyVrvoi7DwiwEme/MgkV72J
         rgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560301; x=1724165101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaCXCBCz9g9sKRjgPoKg0jjN5TJ/BbhYaAMJE0cOnfk=;
        b=RVUcjTU0IY1XoV5rlDCPpVC8f1bwdeHIgeAli2ZYDCTf6fibsdQcJF+XEwNeeUGGGB
         n1OAEDGfvYzvO7cPwwO6xazMK7WqDAKm+eiQ6RfiUPr9VghQImfAyaYbZikm23tum6zw
         Yr5jVfAdb8vrnEFWQS7lp0bkREUOjZhVrF1iaFF9xhYIsmEQzcRhFGzAHQFltT6GtCbf
         sKp5Geo5x1BHfU5tOkiiqdr+BBHZKRLtvhwHMs9eOw89EOsPLdaljCHD0tiZGjQaE7dd
         ulk7d1/pRjzO0jUJVJDRhvJkm0IJPx/+NHPtbyVbkAdhPp+tWRZgbz61caQiLj3rLH2Z
         zUQg==
X-Gm-Message-State: AOJu0YzcYVNnyuR/1ginq4x2Mas6KrFYZNJT8NciId2W7PLEUZudIKb5
	w+sbUPtdWu47A4L01fJMrdy/rJcaM5+2CX44VVp0W12dfIQLKHFJNftdzzlUI9A=
X-Google-Smtp-Source: AGHT+IFibaheDxdQB8Cm8I3HnmPy6WiDf8hhZOtTBkIZsGy4FEe/oKGdtQTPSM99TQbXIvEHVFxdAQ==
X-Received: by 2002:a17:903:244b:b0:1fb:389b:1054 with SMTP id d9443c01a7336-201ca1b12f0mr40518255ad.52.1723560300886;
        Tue, 13 Aug 2024 07:45:00 -0700 (PDT)
Received: from Ubuntu.. ([27.61.226.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd14b1c8sm14388805ad.78.2024.08.13.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:45:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 0/4] t: port reftable/readwrite_test.c to the unit testing framework
Date: Tue, 13 Aug 2024 20:04:46 +0530
Message-ID: <20240813144440.4602-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240809111312.4401-1-chandrapratap3519@gmail.com>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/readwrite_test.c to the unit testing framework
and improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v3:
- Order the header files alphabetically in
  t/unit-tests/t-reftable-readwrite.c in patch 1.
- use check_char() and check_int() instead of check() at two
  instances in patch 1.
- #include 'reftable/basics.h' in patch 2 when introducing
  free_names() in the test file.

CI/PR: https://github.com/gitgitgadget/git/pull/1770

Chandra Pratap(4):
t: move reftable/readwrite_test.c to the unit testing framework
t-reftable-readwrite: use free_names() instead of a for loop
t-reftable-readwrite: use 'for' in place of infinite 'while' loops
t-reftable-readwrite: add test for known error

Makefile                                                         |   2 +-
reftable/reftable-tests.h                                        |   1 -
t/helper/test-reftable.c                                         |   1 -
reftable/readwrite_test.c => t/unit-tests/t-reftable-readwrite.c | 441 +++++++++++++++++++++++-----------------
4 files changed, 219 insertions(+), 226 deletions(-)

Range-diff against v2:
1:  0ebe76c331 ! 1:  03b946434e t: move reftable/readwrite_test.c to the unit testing framework
    @@ t/unit-tests/t-reftable-readwrite.c: license that can be found in the LICENSE fi
     -#include "reftable-tests.h"
     -#include "reftable-writer.h"
     +#include "test-lib.h"
    -+#include "reftable/reader.h"
     +#include "reftable/blocksource.h"
    ++#include "reftable/reader.h"
     +#include "reftable/reftable-error.h"
     +#include "reftable/reftable-writer.h"

    @@ t/unit-tests/t-reftable-readwrite.c: static void write_table(char ***names, stru
     -		EXPECT(buf->buf[off] == 'r');
     +		if (!off)
     +			off = header_size((hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
    -+		check(buf->buf[off] == 'r');
    ++		check_char(buf->buf[off], ==, 'r');
      	}

     -	EXPECT(stats->log_stats.blocks > 0);
    -+	check(stats->log_stats.blocks > 0);
    ++	check_int(stats->log_stats.blocks, >, 0);
      	reftable_writer_free(w);
      }

2:  a148702451 ! 2:  e23a515736 t-reftable-readwrite: use free_names() instead of a for loop
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-readwrite.c ##
    +@@ t/unit-tests/t-reftable-readwrite.c: license that can be found in the LICENSE file or at
    + */
    +
    + #include "test-lib.h"
    ++#include "reftable/basics.h"
    + #include "reftable/blocksource.h"
    + #include "reftable/reader.h"
    + #include "reftable/reftable-error.h"
     @@ t/unit-tests/t-reftable-readwrite.c: static void t_table_read_api(void)
      	struct reftable_reader rd = { 0 };
      	struct reftable_block_source source = { 0 };
3:  ee15af6631 = 3:  9194a4055a t-reftable-readwrite: use 'for' in place of infinite 'while' loops
4:  3f571c09e2 = 4:  d34b01fad8 t-reftable-readwrite: add test for known error

