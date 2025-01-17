Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EC1F8ADA
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116976; cv=none; b=Fgu2ecL26A69IW1J19EzWJq94HuUGoOdqOqV4pYC5wmzbYT+A5Zl6/Rq8zXf26pRfPExWgwXoRrUiwyMKJmGzQIoSB3Gn13gh0lQ1QlSZwT4t8u1JfXXOpD8pMxevCTTfLSuOHoj1FA8Xn9/EGoxYxCdylJyrnUF/ezVuyw+h9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116976; c=relaxed/simple;
	bh=lynPQxdt9rZNuaOuFXWCIBQo5A03xQL36+/vhHTMLQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU5KSW2ZbxW+emTytZ5NExEb7VAesshxiVWuW+MsXAdtVavPgHIcWVKCSDVyo8Cbkh1lor0HcDNWjbmqTazcoqBL1zkIPlqe67Dzw9n5mUCtfCYZ3gTnj/Gd2IuMN2/S0nViY/QJ8sKN7TPX0WcTpN89xXoMDDhXkj0H9N4GH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcfkrSP6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcfkrSP6"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso359974866b.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737116973; x=1737721773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b26OeTYqJjaWX4OYZulLLYi2DRJ+J+Pn8YqqMMF8y4w=;
        b=jcfkrSP6N4hvuOHBywofwPl1J75X2FvtlfukVBsuhB2eBnmSs5PAHAsP7NMAtpKicM
         XdfaZL95DmVv5v8qjRIHb9da2Ln0iHS6Owep/3wvbGfkApXXMRC7y9HyI6oFrTT6zdip
         lZQ3u3TaUeZNnLzlGgZSsu9l7daa+kCzAWJ/Av8aSp9kvpPGM18m5SHfwv1HnyiT5PNJ
         t5JaWpZJrJSQCzNtHJiy6hFZtoSbru+EUvUkA08A830tJjAxa1HbIvjfZeLKvoNUi4CP
         WfmWLY3vRqiDvP7JQhUI/ehixTQfKi+qRENarjJyenOiNNxzCEj87I0Ll/DMCguht8Yn
         xh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116973; x=1737721773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b26OeTYqJjaWX4OYZulLLYi2DRJ+J+Pn8YqqMMF8y4w=;
        b=q9wVzqlX2IubcFTycwm/+xPrlclBwcrHbjsuY/oy4kkDbpCmIKVIDbMVg0EU73buzS
         LAW/sPWHuj3VvxNq5TwukGDaAQ7AoZ6Vz4Nf6gd7SoRp3Si9YgRKrlMCm/+36hP3+LBp
         i7ZCWf/iy/ARndIbmtZF+OOGCku7sfHa9lSxA9ssKFVdcUB3oa9EYMq1t3V7N7OPtgIB
         L1ColVp6gWZmuWsVPdhwJ4MRGCvLkfdFPxSwA2IMQSV88igHbU5Hkk4bAfY178ykQTaO
         D4Szvv35aTjDsNEQPMe/LJNqwdY4RwMVt/G+aVkK+2sJIapNbBcJ3oIDOpyxPElRb4lS
         dOKA==
X-Gm-Message-State: AOJu0YzSIUFKnzBZj2h29yPXDPMs3dTXUKzARHJVSaQJylZtOrUfnIkx
	OBWHjFQqv1s9gVKMAYFY7Iqis/0A5cYr3AYQi1qURgcP4T1dUAQkbXfqyOVN6rXsmQ==
X-Gm-Gg: ASbGncukAdd7PpOsGFEhqZA5a3e5orGrZ2iZQ2sCoiFK3a47u4KnAN+ti1s6xito6UB
	HuRC5dizmwZ1WIa1Y3iVjwxKD1LRI25WAL28Ukd6/R+U6AUGNG/B+oZIx15PLR/QoTTLZfO2OZK
	iOteTTBScvtRXdOR9eH/Xsag4jgeZGA4XdYfRoxEZLfOAa70QC26Axc3sSn3H4oo72p6SwFQezW
	Gn8yBSIavr+3GHvEzUE7W9ErU9hhoRwYEQ34GVW2JycHLTAgW29Iq6cM/OXJ0d9SY7Ccw==
X-Google-Smtp-Source: AGHT+IG2pB2IgSUKy1wQM6TITTeJdQIfQ5huo4YVx4pJc0tlOqxqZ6tijaJtpp5dwTKcB/3MUqLDdA==
X-Received: by 2002:a17:907:3d93:b0:ab3:33ad:13c6 with SMTP id a640c23a62f3a-ab38b1665b5mr223563366b.28.1737116972737;
        Fri, 17 Jan 2025 04:29:32 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f23007sm164362166b.96.2025.01.17.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:29:32 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: t/unit-tests: convert unit-tests to use clar
Date: Fri, 17 Jan 2025 13:29:22 +0100
Message-ID: <20250117122926.101749-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116161559.91038-1-kuforiji98@gmail.com>
References: <20250116161559.91038-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions the existing unit test files to the
Clar testing framework. This change is part of our ongoing effort to
standardize our testing approach and enhance maintainability.

changes in v3:
- Some small fixes were made to the commit messages

Thanks
Seyi

Mentored-by: Patrick Steinhardt ps@pks.im
Signed-off-by: Seyi Kuforiji kuforiji98@gmail.com

Seyi Kuforiji (4):
  t/unit-tests: handle dashes in test suite filenames
  t/unit-tests: convert mem-pool test to use clar test framework
  t/unit-tests: adapt priority queue test to use clar test framework
  t/unit-tests: convert reftable tree test to use clar test framework

 Makefile                            |  6 +-
 t/meson.build                       |  6 +-
 t/unit-tests/generate-clar-decls.sh |  1 +
 t/unit-tests/t-mem-pool.c           | 31 ----------
 t/unit-tests/t-prio-queue.c         | 91 ----------------------------
 t/unit-tests/t-reftable-tree.c      | 86 --------------------------
 t/unit-tests/u-mem-pool.c           | 25 ++++++++
 t/unit-tests/u-prio-queue.c         | 94 +++++++++++++++++++++++++++++
 t/unit-tests/u-reftable-tree.c      | 78 ++++++++++++++++++++++++
 9 files changed, 204 insertions(+), 214 deletions(-)
 delete mode 100644 t/unit-tests/t-mem-pool.c
 delete mode 100644 t/unit-tests/t-prio-queue.c
 delete mode 100644 t/unit-tests/t-reftable-tree.c
 create mode 100644 t/unit-tests/u-mem-pool.c
 create mode 100644 t/unit-tests/u-prio-queue.c
 create mode 100644 t/unit-tests/u-reftable-tree.c

Range-diff against v2:
1:  00bb4d2880 ! 1:  f9e163a181 t/unit-tests: handle dashes in test suite filenames
    @@ Metadata
      ## Commit message ##
         t/unit-tests: handle dashes in test suite filenames
     
    -    The script is designed to extract function signatures that match a
    -    specific pattern derived from the unit test file's name.
    -    `generate-clar-decls.sh` does not pick up dashes in filenames, which
    -    prevents the scripts from being run.
    +    "generate-clar-decls.sh" script is designed to extract function
    +    signatures that match a specific pattern derived from the unit test
    +    file's name. The script does not know to massage file names with dashes,
    +    which will make it search for functions that look like, for example,
    +    `test_mem-pool_*`. Having dashes in function names is not allowed
    +    though, so these patterns won't ever match a legal function name.
     
         Adapt script to translate dashes (`-`) in test suite filenames to
         underscores (`_`) to correctly extract the function signatures and run
-:  ---------- > 2:  f46438f53e t/unit-tests: convert mem-pool test to use clar test framework
-:  ---------- > 3:  f5cabebd3a t/unit-tests: adapt priority queue test to use clar test framework
-:  ---------- > 4:  5323873612 t/unit-tests: convert reftable tree test to use clar test framework
-- 
2.34.1

