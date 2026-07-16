Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8032A3EC
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164965; cv=none; b=alL7vXsZhHUCQEms/HghaX89sewv+bE5GSYU0Dyy6uyrN3mTdG2h2hVoRz8e8wvsvHrNHMRxH1w7BmNt//h9AaycXc6a9lz3jMS/Vi4ckL6r2Cax+YvO08e+m1blEXgj+mU0FhkGO/7gV0MfGGsGUfISBGVEQB8jZinoZZtBSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164965; c=relaxed/simple;
	bh=QVlzf0FG34Rar8nogHVdHCGh2gwgPlpUolFRoUT0gyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZZhp56DkfxuNyaRmu0yoIaMUBK8lrfoiUL60Tf9c5N0e9b2ljvqq2hGTgVDt2+RJ2ZbGTmsE+XEZOLecHfrqih1d6zD3m/5G551vH/e+ieIrDSMlYrXHPmBW1M/Y8dP9NcTcd00IiwFq4aNXRQT4eT2XTZ16g5cYAqbGt+kLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzHk1NfY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzHk1NfY"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2986875a91.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784164955; x=1784769755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4poJZyUA2EqcrTwxDUJpNVk18lInmKGYgYz62wNZRA=;
        b=rzHk1NfYVUXmn/r4NTX0zv+Le0MOxOg4mtu8vMhV9RMN20jaB99dOWYn3+Kxx/Wrph
         8pKiK5EoJhqNy8N7KDXU0CZa96rSz7/HMktNrEOLKR36wVXCfecJNoJklA0nSNcORZvM
         B0ZJsjJShYTBGCX66ErFNwYXsp6bnatUiXOMPQ2aTG3E+gjhmdIRHoWlqVDMJqZWA4ud
         L5gbv5GgEGQyc2yYiSCNc5KY/7eZq4BJ91cNQwX5MuLU7hL4vpRDiTQJ3SbQT/z6FUC/
         HGiAty75OKSXMojOGEY/17axyl/Gp+rMuk9y+aPsFC1spl0ARmNWJZ5zTLaemMDSkltL
         l7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784164955; x=1784769755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4poJZyUA2EqcrTwxDUJpNVk18lInmKGYgYz62wNZRA=;
        b=HGOKEgkxaIcdl4/LWQUuR2YpRueb+EcwS4tS0yTt5ZtfhlursJpY5nWnX+lFOZQdmL
         3qeBdUgadWD56gXTdRRlWWYCxALTh8rQUSzfQJW4iznsdHpDtjSENc1//xLyFCAgOZlW
         J8AYuNxTVYtj3+kb6sJaEf7csFAZLXXi4810DRrZzdNn/C6SFAxwfLZybSu2NBpsMhjr
         nSqA2+2oPVZ+V6glpZ/ld+oCkNrisZyo5RlpRtTOFjSAy1iFc/ClEHCxyHzvBN4Cf4dD
         hNqRA91TI3COgHSDjgo+RRJfAiVT5XRKloK91OwgYH0PENQxwMj+7kcLtpAFlptGLp8l
         j1tA==
X-Gm-Message-State: AOJu0Yx4tLy9f+97ZLg3OcAgjAYsz5rUCIDKOtuTfHZ2RZhaj/+WCZok
	HOfS6vn3AOg2gwI9K2yDTB9TxEPFnNfCWB1n53XaUCKNNtjiep8WMNP9+HKDxQ==
X-Gm-Gg: AfdE7clx7+2V+wn4pHKoJ7OYOBt1N/LR9i09fF45udqNo4whDZblxzwe81BdqvfV0B4
	o+PqDUJmIMYyVfopa6RqgweYF8kpUX2mkqnseU7Y2mLZtATCKiR9+0kHWZhQeDuexiztobaJRZT
	rrgbkK5VhOI7AWC09oORtQHmiT8IgEUg0lUBk4z/xcujrvyFU1Fe/eKg34aKTm9wGrWJRKpx+h0
	1kh2AdB7CBDV8CTf15MuyIFOfMdJoqdXPE+/aE8/EWjWozJ9Gv82uYhfQ3cSpsXJoowPrAyZYzc
	7u5y7qUco1zvBwwk39EAwFWUo9f4fsCBUBimMb/Ith7Ou8EW6LqMk1SFDYVlvzPjw+dA30clsRX
	EoluejLZihOgLFf3RhPXmVU9rpAbFmjJ8fwlhT+2xp+J9tEvZ87xsnHqUjOLRGEcqS5Gio6qtT6
	CzNsxXNfiDANSdSnw+ChvtqbAL9GFrsPuKiGNnmuMcuvsCk/mCVzq07/lzOG9qEw77ClggAvLa4
	iWY1XrU8hcv
X-Received: by 2002:a17:90b:4c89:b0:387:e0db:3fb2 with SMTP id 98e67ed59e1d1-38dc779ac27mr18226787a91.43.1784164954635;
        Wed, 15 Jul 2026 18:22:34 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:22:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 0/7] repo: add more path keys to git repo info
Date: Thu, 16 Jul 2026 06:51:31 +0530
Message-ID: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.
Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-working-tree: superproject tree from submodules.
* path.objects: repository objects.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.

Keys support suffixes for format.
Commits contain documentation and tests.

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  repo: add path.superproject-working-tree with absolute and relative
    suffixes
  repo: add path.objects with absolute and relative suffix formatting
  repo: add path.hooks with absolute and relative suffix formatting
  repo: add path.index with absolute and relative suffix formatting
  repo: add path.grafts with absolute and relative suffix formatting
  repo: add path.git-prefix path key validation

 Documentation/git-repo.adoc |  58 +++++++++++++
 builtin/repo.c              | 167 ++++++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 108 +++++++++++++++++++++++
 3 files changed, 333 insertions(+)

-- 
2.55.GIT

