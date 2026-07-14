Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA33D9525
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031644; cv=none; b=Edux6RAhPHO0tvcC8RHD6lbDsIgpG/OXY1JtFi0r3xNTmLS9cEzy03g5AkSxynfpGJgPeJKfq4rgweiarlkR3Rbp0ZBX9OFxLF0iPy4U5Wuvxsjp5FHovhCkdAxpzDxRjklfw343grJDrwCNrwoBy440b4XSbTEQEVaw81FEKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031644; c=relaxed/simple;
	bh=7rsX3jD2eLlVDAydUd2NEQvp5JPNMBnLzJpZDhpctLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikKqCdDix3272cnkhigQJPj0LMp8zaFRIddTWnH9lbZCw5JdACwLTLgwt67UiG8kuRmHS37BeFcxIzt89feLrhsaPqZEPq+VYMudvRNPnWuFFQKbsIp0QUF3LNT97NiKYvY1sTFIa8HsdRepe8UAR0qO1ghcPnUyr7jLKbRoXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGOCIAAa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGOCIAAa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab973140bso47765995ad.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784031640; x=1784636440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CF33/zrpAgaK6vguTAkTq4eXRL6n9CpHctv/7fg0wI=;
        b=oGOCIAAaqw5VGeXe4O8syIzr34oxf9HCVYMjMKAiGp4K8hAVP7BhiKUX1hUqy4DTh3
         vgud2NBL2JuIBoPQ98fe5mGGeKuIEFwMcQYQFSlGIYI1ZoOvffUhj8bMPY9Xk11uJ+mj
         RAL2+bHF/iozCTRG/4IOvryPZihyc9iEXSt1CGL0Uk6p36DyrK7W1T5fvTsofaoQqw+8
         FJljVui7RfMCpeIBER2lcIiq/ljYk1O42ZN/QWqXGV4ZEB4xWm3NYV2iOKeyCMDlz/0N
         29K8a4T2I6JsYZJ/XOaJMSSp6vTQxNQ/n3XLDXLZraMCrZ8fLwXlreZJ2/vbpdL0TYeE
         nggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031640; x=1784636440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CF33/zrpAgaK6vguTAkTq4eXRL6n9CpHctv/7fg0wI=;
        b=kv1dUtZIlb7K9rFY8ALH4okAC67hZe8fHBgPNkyDSZCeczwdAjBULNBgYWgzsjh5AK
         PU1zd5PXIUvE160OZdv9EfBPOd4Sk/v1jjj5MPdQxAPS5WcdANPp7E7NeUY+d7nWxPeo
         rjerR+F9j5ZwumzhRbISPBl+SgKYg5jnYCnSyyr5qsSIEbf4zSlLbYJoJ6utt2l2RNgs
         69/ScJ60JL/IK5QVsoAELVe1q2JP3+oyFSN+B99x79xqbWsYynT7CoQQ4EF5wSWrJVz9
         22aOmsl+IaUzUcUai5V5toPImM0bD2bEaZGERKL5CvvNoXuyunwJZ1C41P5flsUUSMI1
         vUkw==
X-Gm-Message-State: AOJu0YyH+NeALEICVPY4LdvoEG59Gz1/4GGzJWuDCqmieDuRzQjErcJq
	K5rxhiy9YStuoqUbQnAJMae1v9z+JKwSbUMaWa5YaK+BeWtF3TGYrw3s/4K11K/d
X-Gm-Gg: AfdE7cn1J+ldPRMrgCQTg7TSJA6P1/u1t5OkVcQgtcWEI1vEtGh3163atscRING8B9J
	Ws4HjBlltc9JpS9dN0HzpPek2HPEAwTuriphx3h990dpYZU8DQq07pb+rAyzNvChCr+/hyV+Q/0
	LA/zofH7D7dhi9pKerwSmWZ7eUnKIEHIlEW244/hgbXO0Uce3xPC1dv1R72NnIcY/YYHFmf6fiw
	RROoL9OhCT006zyju9cKyMqyXr+4hjNqQrbXJxurHsuANVi7Yq+IRHFZ10pPKnIB4RwfxtI5yLp
	Oy0IvfpiR9E7JaaY/b9hmuu6JnRGeBYYStOVPLPuJF4u07pehcwFLemFq3T04qy6XjTiYO9p9HV
	BKov17bBkduyN56rbtCWYUBpC2s8ETBfxsSvWfZy316OMll0yaM0JLhKMZN04FEMygeGOVG8J2v
	ccaxhVudo0uBuY46pf1LEWpUHx0b5UpMTxvfYZIgKkOAXwAJD5
X-Received: by 2002:a05:6a21:113:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3c1102894e6mr14749912637.21.1784031640210;
        Tue, 14 Jul 2026 05:20:40 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c0a:50c7:895a:a6b8:b3bb:5640])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm74390182eec.6.2026.07.14.05.20.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:20:39 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v3 0/2] t1100: modernize test script
Date: Tue, 14 Jul 2026 17:50:31 +0530
Message-ID: <20260714122033.61947-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714071633.35446-1-diy2903@gmail.com>
References: <20260714071633.35446-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the microproject cleaning up
t/t1100-commit-tree-options.sh ("Modernize a test script").

Apologies, v2 crossed with Patrick's review of v1. This v3 folds in his
feedback as well.

Changes since v2:
  - Patch 1/2: also drop the extraneous blank line before the "flags
    and then non flags" test, as Patrick suggested.

Changes since v1 (carried over from v2):
  - Patch 2/2: reword the commit message to use the present tense, as
    Junio suggested.

The patches themselves:

  1/2 converts the tests from the old backslash-continued
      test_expect_success style with space-indented bodies to the modern
      quoted-body form indented with tabs, and removes an extraneous
      blank line between two tests.

  2/2 moves the here-doc that creates "expected" out of the script's top
      level and into the existing setup test, so it runs under the
      protection of the test harness.

t1100 continues to pass all 5 tests.

Shlok Kulshreshtha (2):
  t1100: modernize test style
  t1100: move creation of expected output into setup test

 t/t1100-commit-tree-options.sh | 58 ++++++++++++++++------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

Range-diff against v2:
1:  45f590f110 ! 1:  e299f096b9 t1100: modernize test style
    @@ Commit message
                 body
             '
     
    +    While at it, remove an extraneous blank line between two tests.
    +
         This is a style-only change; no test logic is modified.
     
         Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
    @@ t/t1100-commit-tree-options.sh: committer Committer Name <committer@email> 11171
     +	GIT_COMMITTER_DATE="2005-05-26 23:30" \
     +	TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null
     +'
    -+
    + 
     +test_expect_success 'read commit' '
     +	git cat-file commit $(cat commitid) >commit
     +'
    @@ t/t1100-commit-tree-options.sh: committer Committer Name <committer@email> 11171
     +	test_cmp expected commit
     +'
      
    - 
      test_expect_success 'flags and then non flags' '
    + 	test_tick &&
2:  36ea70be9d = 2:  5a54427820 t1100: move creation of expected output into setup test
-- 
2.52.0

