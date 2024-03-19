Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8425548F9
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841945; cv=none; b=nsj7LECvbxdvwg8nNsOcblq40pjXF4CZwvv6wsRfHwMJMkJCHH8Dk2H7ixxmGLuGNQoOSIuDB7PTtmEikWRTgtOTDnRmjYyIlagL/TY6FDzWUmmMNETvokdevaZAo+abYDDHf2f81hN999rwbw4bHiczQajEqWwtOIwjsVPsQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841945; c=relaxed/simple;
	bh=MjGgr0Z0xzGgDNFgv7lPKWXrOnPVXKte0v4BB6LCOqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TH0TRYrH0OnRzTZb9l1sYCj5jauUabBRhgHorK8v00h/hW2A18efKAUzYTROUXZjovaPjOjxDLaLkXAQUr6vRJdRmhnHqScn2PBPrfPnR1hc2Yz+DDn/wA0ezNeqIfE79X8VlqEj9lyJBWch3/Oxr1XX2TKK7gJdIuDAIRuvcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AAIeQ2a5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AAIeQ2a5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0511a4383so336165ad.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710841942; x=1711446742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgtF/oNBv26h/FPM/bBKSL/4oGxCmOq4dRc0AZWknSY=;
        b=AAIeQ2a5ZbPL348SkmGhA/thE+5wpaczkSLltQCbuXoD63Sdvm0bIu6mp+4lVzp1uu
         EvWfECI/AySTF6pSewrLUULynoW7sIppfDHH+v1vkXJ8S8AW3dAeBeuVlNSSuoWf9Yoa
         wtZtpf40BHOWpDPAporahG9HpnO+YFBFpLn+bKMdDLv8ERN7x1fgFMWZG8Nhoz2oofY+
         FQzDZ1PrgT2AQHIhTzdMmjvPCM0j1NILtVEAQ+/077CxtZsA5yWfV1vYt8KkhkgWv7rg
         wMPmTIC8OPns3hcbbjstjLP77xoiK1g/xlAQKa69EtamDUH6TNuWV/HojJIYx+APuc1Z
         BPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841942; x=1711446742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgtF/oNBv26h/FPM/bBKSL/4oGxCmOq4dRc0AZWknSY=;
        b=Q1FHI3/AQKZzT/aTCzTFLWM+8hi55ur63iGr42luE2k5ZN3G68Rcfl6lj/M/MKJqq1
         6XOQVols2XlAyjrNoMfv3JnC8TEW2FP4QK10CmSE0NHW0Fnf1N6K/U44OdIsRkN9vbb2
         /eHFb78GrouDQw7tcUfung3fF7wqYQsfKp13uZ0Ya1Wb1FxaUdizSCOoEztG0oRPR2kc
         ZnmznDebs1zxqKk6+3BVlF32uvSd9pIR2O3qaTi0Prq2JX1d2xi6MKrSrdDJFvzddyYJ
         gAPNwaL9HLvnJjX15B7OwFizHUmfvlQAgu5Bv6/TPXXtO8oeUXg1yPhQjyk0FxEAbdEc
         +T/g==
X-Gm-Message-State: AOJu0Yxya+J2E0EvE4sWpD/44md64d+tRH62mKX65dPJ/1JPTA7OUfnH
	4Y8MEHYGQSpXOpvF0OtT+Kv2JT0GGALn0DOAWAc9N9j6+WMV3QjHn3us4scNilImG3N4E2xBrLl
	/
X-Google-Smtp-Source: AGHT+IGWxYtHxrW9X9dxQtH6sNg0mLOo6o4Nx1MTInUr9hX66QpmQGlJ6Eej0ygeYH2ay/gcfonNNQ==
X-Received: by 2002:a17:902:ccd2:b0:1df:ff0a:70fe with SMTP id z18-20020a170902ccd200b001dfff0a70femr12046349ple.9.1710841942176;
        Tue, 19 Mar 2024 02:52:22 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.152])
        by smtp.gmail.com with ESMTPSA id kt7-20020a170903088700b001d9b537ad0bsm10958653plb.275.2024.03.19.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:52:21 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/1] quote: quote space
Date: Tue, 19 Mar 2024 17:52:11 +0800
Message-ID: <20240319095212.42332-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're using 'git format-patch' and 'git am' workflow to sync changes between two repositories. This works great but I've found an edge case in apply.c

If one commit creates a file whose path has a directory segment ending with space will cause the generated patch unappliable. Here is a script to reproduce the edge case:

  mkdir tmp && cd tmp
  git init
  git commit --allow-empty -m empty
  mkdir 'foo '
  touch 'foo /bar'
  git add -A
  git commit -m foo
  git format-patch HEAD~1
  git reset --hard HEAD~1
  git am 0001-foo.patch

Git complains 'error: git diff header lacks filename information when removing 1 leading pathname component (line 9)'. Turns out `git_header_name()` uses the 'wrong' space as separator, and `skip_tree_prefix()` thinks the pathname as an absolute path. In theory, we could quote the pathname for this edge case. But that would require many changes to quote.c, simply quote all pathnames with space also fix the issue. 

Han Young (1):
  quote: quote space

 quote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.44.0

