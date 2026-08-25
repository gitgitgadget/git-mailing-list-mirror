Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537F3E00AA
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693121; cv=none; b=LpibXfjJyNxTzO+RtMrCPICtcVyMIeOj/m+DFzB35LR6phrBRj1+qyH+mRKGnrbBcW/ieY1dSkrndpEc2WwEY0qJmgoQjSi/1p/eJutC4qz8to+2LHi4q4fYjZBgSO10sEbkjYW2FRDvhuuC8+hHc4fskOAHEC3sHP9fgVflZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693121; c=relaxed/simple;
	bh=LyF4Hen6+RnKeAibTlcAyIcWfSw5Ps4opnw3nhaHXg4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tzTkjKmxQGVLVrjy8XJgnOdjB/dQfczgBY2nAyljVCBBH3oZs3Qau+6UK+vWBNH/p7sIXSeYPAk89u8epzqZZG5GXamcL4iVIgWq2//YIDWvPMBROlGQS/C3gF0fWl1wcwJLVQDpr6naWQcrNVQQYzTTimoBqZu+AsIJMdygroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO6GN/s/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO6GN/s/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso179862a12.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787693119; x=1788297919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t6kgLnbPn9gjwgw6qI9HjJObkyfHNIognNsL3/BwxsU=;
        b=lO6GN/s/rHrh6nS90Ha/YsoQMQAlh1vBFzxpDABioIskB1LnxGYIfdBMOgR3hnr6zD
         jpvEvOSudfIzooZ5A9bGWMBCUEl/DsQlFWz5a/xG4EVyItGak7SMmUU5Y1LaE3JpoH4C
         IDzkDx5hnKt0K1O2TnD5kl1KgEJsqJQoy5q1Mlq5fFqFAk5/PHe/Ww8wttpxQsol5ua3
         FPckJ372Pu2YjPYJu8tdaJ4wpwT+/9TYk0l60e8gsKVyf9Fkr3Fa8ULgcU9QfkHhY84j
         G1MvJuEklEuFafpLkr7MlRTIpjx5PlyuqnBzf28GvO73N9CYZaPnvZskQ5yKxe91Mx3P
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787693119; x=1788297919;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t6kgLnbPn9gjwgw6qI9HjJObkyfHNIognNsL3/BwxsU=;
        b=fKyzNtEk476yOGbQzR1+I8JtAifLuVcZstiwM2LAKfBa/M6emhBE1cfxdWObSR2TRL
         rLzz4KQnOR1co7zaa+cqie5H+78uzHXyBt6raLFPSnMkurJx6cEeJhIvXUR5F+NsUXbG
         F0LrTcEINDLMJYBKgLSMHTBe9q13gFQ8jBw+O5tDUyjZvDqkRfSTjb/y1nsfWpT/5fN7
         Vccst9MUXrZok6w4hyvgxmS8DCjUHkzuWDWQXa9zPPfSDKl+iVtLmMiyGhacDBFUHh6i
         3db+4QfmrvZLCdsUKvpanAW7csHj9LClYjUXt5pZ6ZwJcV1CdpNp68zddmAVuLNbyyef
         zWaQ==
X-Gm-Message-State: AFuF++nm0X0ksh3oaIGc4Nr7G1510o1KPMoxfdZ3BrwTckLX5vhtPMQb
	lSlcozKE8jYzbb+TgPo0GRJElQYWv/OeDFqL32IyTVBfuf7NdUDEM16exsdW9A==
X-Gm-Gg: AR+sD129dwAWIOrjpv4bAZH350CaXksuQnImCjTXyIb82gMxZcFdEtShEWdDDNgPyJp
	0JXU6tMbmBy1yJxCDgQP37fH0HQAUEahKUx88No4RaifQ9P+WPbbrBzbXggTPbLsH3DeeZXvR7T
	iE2/M1oa69Y70p+Q7UM9bqX5C2V2HfvnhrIFcO4/2QzPGkKFFVKfWD2x2Cjt5s1DzslwuPYze1r
	UJN92iZDqfbyQdGc9avFlnK0gt9AbNJxJymS5Oo7nqc8u1nQn5RzIkktN6a+X3d0DEvcLWR83AF
	5Y6pz8jVKqOFhTgRDLY+/hx0OAOw137bh4x16jPAx1+BJOVql47FlSKH6BvgI3rKXQJe4v0hFwd
	pWNRIUlRyrvV9mSu3RaHjUoPYKhksxErA62MOq6GF+Ms5VZmjil0LQhE0eLYR9bam78PMHX/ndo
	+cmZbkiQlf0HwTiQvpvMvTfyDkjXdSZEGAlkitTH4SrXkdzO3MekZqz1Mtve450UDrjg==
X-Received: by 2002:a05:6a21:3997:b0:3cc:917f:f302 with SMTP id adf61e73a8af0-3cf83c17569mr3054828637.9.1787693118955;
        Tue, 25 Aug 2026 14:25:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.158.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d9edd8esm1598955eec.27.2026.08.25.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:25:18 -0700 (PDT)
Message-Id: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:25:15 +0000
Subject: [PATCH 0/2] branch: -d protects upstream branches
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Protect local branches from git branch -d when a surviving branch depends on
them through a local upstream chain.

Harald Nordgren (2):
  branch: move stacked branch helpers
  branch: protect local upstreams from -d

 Documentation/git-branch.adoc |   4 +-
 builtin/branch.c              | 142 +++++++++++++++++++++-------------
 t/t1507-rev-parse-upstream.sh |   4 +-
 t/t3200-branch.sh             |  43 ++++++++++
 t/t6040-tracking-info.sh      |   2 +-
 5 files changed, 137 insertions(+), 58 deletions(-)


base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2365%2FHaraldNordgren%2Fbranch-d-protect-stacked-upstreams-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2365/HaraldNordgren/branch-d-protect-stacked-upstreams-v1
Pull-Request: https://github.com/git/git/pull/2365
-- 
gitgitgadget
