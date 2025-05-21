Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408B2367C5
	for <git@vger.kernel.org>; Wed, 21 May 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816531; cv=none; b=BG3dG835NDRG/dpdJb/cv6VDOcR7oPNlsii0uZdJyA5JwWg5FL5ufDaEbWYmVCSm0kknO1O5pfbYj8bfSI6rVGdmKhbHpsg1uscU5x38YHhcW43XHZNhUyv18QVnZK/7/WgooZESzVuMVtR5ZL3pJYC8oY5AnfHkIaJBcfSNNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816531; c=relaxed/simple;
	bh=HFOfLSZOFxk5j9KZsIPG7ejfQiYEJBqYOoqFghlsJ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcICzJY9XpBW1XwmVb8+CiBLqfkXjofyJ/Dm9E5MqBzwOBTMfMextThuCK4ODz7s0N6LoFCktecFZKmVwfeoLcy7YAQaFQqFWO1hTUUuDik7GpGDSagEPbMTSvz4DSUMWfqSnMUjJA+edObPq3ulyLkBQnQlS8guI4M/FXi8YVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hK2IlJss; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hK2IlJss"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2322f8afe02so28974655ad.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747816529; x=1748421329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pObvjQwuIlajQilJOaHL3cUv9C2oBN4jHKNHVTu/Qlw=;
        b=hK2IlJsswebZWPfa/5JovhwAuthRGLsgIN6GlatN0L9xgyvW2S5hOBl+1CitK9MloK
         +sDjLe8EPhjKls3D/LuluI5l5MMCcGEuDVOm+j6ihJsqt2MIwXgr0nsCiOrQGzH0u6RW
         8I69ipwhDejN8lqCYbb4KNFE681hQUmZOeDdqOPwOPWjtJoOaQp+dADjlPifWlyTkHER
         rCd0jGhbPUjZlbM43SRZAZ46IpA6j0LxYD1GfgzAr+ST6WBdhuVr0b+bkRP73YbhIMKK
         ZLAgDgiu5PrJpuHHD/CCxShxiKAlFOQKm6v2lmG2LoeQXviKyW/bu/LO1EsmpgeMenXF
         OBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747816529; x=1748421329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pObvjQwuIlajQilJOaHL3cUv9C2oBN4jHKNHVTu/Qlw=;
        b=se/eBndlIi1f0iHGSIE1cX1oaHer7j88q8chSCfTshvTrCasUZzP79MBiD+LzsOsvN
         4wRCUscW6cALIJ27hlXOyjx9tWBbGnILodUbOGDkpMAcT/4Pq9LoKSYc1pAyWI7Z/5PY
         b6ksSvClszFMB08tddvtlip/gK7PDaqnB8BGmcdTT5IYFjLXjcDLO+FEEObjGgs1kb5l
         MnqdEiYV6069LqjxDUlHmvLW80MqZBhcbRGILUzfrl+9m8NHh3eMHm9BvwQO86V/uT8m
         FDRMVlQZGQR9kqFC9KG84+rIl6SdX/5JR2U4Gg9oU4U7thMrAhEIE1pPqvFyOSSm8E9E
         J1oA==
X-Gm-Message-State: AOJu0Yys2E5oDrNp5c/AZofxRgrOj23FIgUgrqoaaFdxRog0dUxACqIJ
	Z5wR9tXUvsoK9UqGT8Z9z1oz7be75EFG6Jn0X8nZwmNyifQuchzTkGoH8DxIRsL03mTIB6mzMun
	zeDbm
X-Gm-Gg: ASbGncsuh8hl0iEuJAkqKsgnd98AZDaVBs5dN1zRLR40ANt+D7FLKBjHXZLuNSApLuh
	rmvskO4P/4b2e+FX3tya0u4lGTaaIgYzAIIqAa+WCmYGtNzrBZHX4SiWEOYDJha16GIXk9z+TEK
	2czDl5AefNBG5zvNzYHQsltGzI3lKaGjf/ZkkuLoEP48IqFn9aRBC35V9uNnsqYaNjOq+cGWrPN
	TQEw2qlHYqYZrdIzQOYUbv8miJoms4YZpZbXNJ/iSoS/CKlDrdwXlMvgMxC1j5pH+6guhA0+P1D
	iX+gIadD/VDyVmwckujSVLJfSNUrs69arxl5XtbhO0uUXuM65f03897Q8jmIJtBJkLrKJ3N9ibN
	6RMe0mJBO
X-Google-Smtp-Source: AGHT+IEJUikpOMxEK8yOfRWI7c7lqCZVWxLBjAkrKoYAlmRiQVDt6HiJNWO+lmWYS66yBxHICzQWJg==
X-Received: by 2002:a17:902:da82:b0:22f:a48f:7a99 with SMTP id d9443c01a7336-231d4520564mr264895825ad.26.1747816528616;
        Wed, 21 May 2025 01:35:28 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231f04e75bdsm78308495ad.216.2025.05.21.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:35:28 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/2] report lock error in write_index
Date: Wed, 21 May 2025 16:35:19 +0800
Message-ID: <20250521083521.6552-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the repo_refresh_and_write_index of read-cache.c, we return -1 to
indicate that writing the index to disk failed.
However, callers do not use this information. Commands such as stash print
  "could not write index"
and then exit, which does not help to discover the exact problem.

We can let repo_hold_locked_index print the error message if the locking
failed.

The second commit is to provide a more consistent error message in various
commands when writing index failed. Currently, there are 10 uses of
"could not write index", two uses of "unable to write index file" and
"Unable to write index.". Change them to the most used "could not write index".

Han Young (2):
  read-cache: report lock error when refreshing index
  read-cache: unify write index error message

 builtin/am.c         | 2 +-
 builtin/commit.c     | 2 +-
 builtin/merge.c      | 2 +-
 merge-ort-wrappers.c | 2 +-
 read-cache.c         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.48.1

