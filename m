Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40F309DC1
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491753; cv=none; b=T1EuU2QkcScEJWvjbfmrYRvZmc+van+F9d9njyU34Y91Vty7uwOvVgAx+86Z4fkhiFbk9EvyVdq1/eWwuoY4UySbZOjc5xgK3EzkIj0wtxCCuTtgeyrzwgYfzsPM6drceOOACBpIFVCioITH2my5OJ9rJkchZbCGZFVmte9jAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491753; c=relaxed/simple;
	bh=LShZPVAdGnxl1M1EGgPVZzxfaurbf0Gjw8zPl4pG638=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRSnVnkL/Qv4HrvoXC/xIQOI9ZddmJhVBQkFtUnfREvLxhA9OJQQYDE+0Rro048WJloxYA8/JSM1JKkdO/1y8qGtz+t91UAS9h5GAmLfRf0CJNT+n4QVTKM7SHYdi2RBGH4CQuYewB0l7TjRnZkL4Xu+uDoltqxAlDeHKjKDnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVJgGlJY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVJgGlJY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9853e630so59058515e9.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757491749; x=1758096549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGxHTDxdcl7XCDViWZpPBPf4QZMfOTOYXPRG8fGmeJ8=;
        b=aVJgGlJYrS5rpI7I/vZ7k06Zvs1CcmpGKCbb/MgtcNUrJbY8PzJ63JSYBdLHalBv7F
         D+f6UFTaPXcmZ+Q34DdgHR36xn2OY9/6wam3bIYO0xNtPVPgtm2TPltlBtjKV20lq0re
         MvxA1ThcQe1PXAhl3h5Eue3zW4YLI1GaDREQXkWM+XfXmcbgZHbJ+XQHlHq0/t1w0YDQ
         cbZfd1Q+RL1FicmYeieIB6Pn9F8egRud2pQgJmZj5aDFNfzKUa9/1r1W+oUfLQ6CcvvN
         7nQQa2DocEwef+dcdf3BL9ovBb2SmylKsjIM019XukL1UWBwbEugUaAOUTnk6xR8/Hnj
         D8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491749; x=1758096549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGxHTDxdcl7XCDViWZpPBPf4QZMfOTOYXPRG8fGmeJ8=;
        b=ZddHOFs7ezcoPiQuGxgAfjqRabxduYAaBBzXUF6JAFXAvUOWSc3Sr8/JAGObbbneA5
         sRbw+KZOjftU4UIBObOBydKHsSkIbZjfn//165M/f/VugQHzEv2ei085E3ngmaAwRszH
         bX18pNh/yXTcOjHHHl93lqlrweJpV8rv8NVSSvI0xE0u2L15At+Cn86iE5VW37Kj8TSO
         tstefMSbMNCqDpXEengpdJlXZxbgLlFO78Xy1CogpB5+UOjwNBYiyPLeBdjszb66Yg/g
         JqTbK1ls3Lln+rEJyYJMDh+wSCjlbdlQYuhW2gm1HOq4jop1OCDVNSitTKziE+8yE64y
         b7tA==
X-Gm-Message-State: AOJu0Yx9vwYN98puLjZTs/nxsYAWj0IxhOugbFBf5vvRQx0GcU02uv0E
	OIZKBPw2h2TjTAhvKhCwQVBuPZj403MDd6AVZnYf+blxaHh5867rhi8J9huLGw==
X-Gm-Gg: ASbGncuO/wu6kaqeC5O83aQ7WFs81dNYAtx/QYFztFBHbe15BHaZSSSENMw/R5HQzaW
	WG5+rOHG6ClpAJpe4o83V15xStxIKca/rq0ANToQ6uCeYUq2IBfSE3Bu6IcfaRd14vfdgLhxYSs
	a+w/IoLCvSVNbnWiHPAqD+O1HZdN3bvZ9MhRYiFfCIZNoNj+OiWyP8Fx1NcuEZLK7W1wWemKpWi
	tuM9cj8uGz02dsomMwJ6xrZTKHxrm96aXtHy0xtU94ByzvvOFueNwWYtbNKdZYL1Lcme5WcXAA1
	CWII9pqhbk8+GG1cu2MdtQ8WapagBYAS6KYuiu8Mwm/saYIQ6AmUNK1drPitLjEdu7TKsdNosZr
	6r5+/jNqt/lESemSMZfY4QAUgHre2kIWlEiLr8ZSx1D5iWQ9pYbgcf2nyxME+Z838QrZQSJABPI
	aFolvi
X-Google-Smtp-Source: AGHT+IGwh5iJpbU9B5No6h/inx14kUyTYqGGjtgNC8BdcuI4Ibg4Ry7ygFNwY1biAHfuXvtAKdjfBw==
X-Received: by 2002:a05:600c:1e87:b0:45d:d1fe:804d with SMTP id 5b1f17b1804b1-45dddee606bmr119714175e9.35.1757491748930;
        Wed, 10 Sep 2025 01:09:08 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df820d686sm17965735e9.10.2025.09.10.01.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:09:08 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/2] fast-import: start controlling how commit signatures are handled
Date: Wed, 10 Sep 2025 10:08:37 +0200
Message-ID: <20250910080839.2142651-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.g61112aeac3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tools like `git-filter-repo` should be able to control how commit
signatures are handled when regenerating repository content after it
has been filtered (see
https://github.com/newren/git-filter-repo/issues/139). For this
purpose, they need a way for `git fast-import` to control how commit
signatures are handled.

This small patch series starts to implement such a way by adding a new
`--signed-commits=<mode>` option to `git fast-import`.

For now this new option behaves in a very similar way as the option
with the same name that already exists in `git fast-export`.
Especially it supports exactly the same <mode>s and the same aliases
for these modes. For example "ignore" is a synonym for "verbatim".

In the future I want to implement new <mode>s like "strip-if-invalid",
"re-sign", "re-sign-if-invalid" that might be a bit more complex for
this option. But for now I prefer to start with the simple modes to
validate the general design of the new option.

In particular, I am interested in feedback about the following:

  - Should we keep "ignore" as a synonym for "verbatim" and "warn" as
    a synonym for "warn-verbatim"? My opinion is that they might be
    confusing, so we might want to remove them for `git fast-import`
    even if we keep them for `git fast-export`. The parsing code might
    be a bit more complex if we do that though, so for now I have kept
    the synonyms.

  - Are we still fine with most <mode>s having a "warn-*" variant
    (like the "warn-strip" variant of "strip" for example)? Or should
    we have a separate `--verbose` or maybe `--signed-commits-verbose`
    option dedicated to switching warnings on/off? I think it's good
    to decide about this before the number of <mode>s increases a lot
    with new <mode>s like "strip-if-invalid", "re-sign",
    "re-sign-if-invalid" and possibly others.

CI tests:

They have all passed. See:

https://github.com/chriscool/git/actions/runs/17606244845/job/50017575843


Christian Couder (2):
  gpg-interface: refactor 'enum sign_mode' parsing
  fast-import: add '--signed-commits=<mode>' option

 Documentation/git-fast-import.adoc |   5 ++
 builtin/fast-export.c              |  23 ++----
 builtin/fast-import.c              |  55 +++++++++++----
 gpg-interface.c                    |  17 +++++
 gpg-interface.h                    |  15 ++++
 t/meson.build                      |   1 +
 t/t9305-fast-import-signatures.sh  | 108 +++++++++++++++++++++++++++++
 7 files changed, 196 insertions(+), 28 deletions(-)
 create mode 100755 t/t9305-fast-import-signatures.sh

-- 
2.51.0.195.g61112aeac3

