Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B82F2D
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444492; cv=none; b=DVR85aaaPvYZJRmeK17vekcZIHhw/Rs+hizuVHZmKFirj1Sn2O28ghVceecxX97ZNBv+Un2lw3GwjkAGll/0+wgFhSQqY+X4z9+KaN4IjwHQwIIMP0NQPCiIuXkOb0c/lqLQrSSk7BaoFo5gO2O6lKhfexSbcY6x695TEpoYtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444492; c=relaxed/simple;
	bh=N6GT9X7DUipEf1RGoqO9spfbboLf7JdJg0rfVSqAXUs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=uQ9I/ldbOuvkYYdgNqsWn0k0QjyPNWTfWmCbl1wmbJrcSXyWV31jdYwEE2+W03xmEFaScqHRGe06LCCmTdL428so9cs3RI7x2rPdfkbVTi3WDD6I989kQypOhB5Jk0kVjfmxmxwSItlQBcznLOuMvpjarv5k7C6k7bARGA4FcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYUUwbnw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYUUwbnw"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7811a02316bso1209814b3a.3
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759444489; x=1760049289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OMxtECq2B2C82LNFWBYEnCUmSPeB6ECSM5IrCTS+qN0=;
        b=jYUUwbnwtDr7DQxbiSneAM99QpLtkvFUq4j0XWew4aewcwIuB1OkaLcv9P9KklspPO
         6rltdyZKCwafv9fYwBb4cxp5ZgOord4cBYfyl2ZS+lq2BQuWU5lg8DRDwSInhqyaM/0e
         BtHRcuaZsLkuG/fNAxiKI7pWoWHrabc+NjMj/+/9TL1CXd2CuVSL2XZS0FB2QkBkothz
         UT48MVi0ZCGBIc/a2mqmbnJKyYJcGE/1nwO0/U1LGwZF/lriJXzEIGYUKqEkt/dHNHe8
         LSCm8J6S8b4pGFVFZwMfeFsDJqtuTcJPPuKQxI0K7MD0bYPDx59wncbkLh4tl1DVvoJQ
         v6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759444489; x=1760049289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMxtECq2B2C82LNFWBYEnCUmSPeB6ECSM5IrCTS+qN0=;
        b=fleVQeaUFikBX0fa0Y9eCOoW1l5HcIJnJIWj4yLHT9kRwUw6tjYcSD5d9Z34voLH8k
         WT2tiE2o4/AC/ke0nX3Ctk/prgr1yni/9NTwn5TmFc8ER43BW6NEvdu4eCIj282+UPiS
         IB8y2+WOtDO+HJh2Wik05bB+pcLY3lgg5GBs0y4NZlYaMhKa314YBtpHD8b/PgWUiAks
         ASnpJegGQDr22lE+1NBQQg86ti1w4xJpHJrADxrz/DFO0dYCGx25JMcPN1ivCutdgS0n
         wJm2nGGvOmpJGUq6FnY/Pyqfnh1I5NI1Lk/3jpgNCZqhiVhXCqqjdSOhqfnGjlxfVadx
         wp6A==
X-Gm-Message-State: AOJu0YywCAvyKBa9q8t+yF/YCiF7cbAAt1RE9vsI0Eooa3Fy0DaxqpfJ
	9GNUHOe8lppftMXqT0/JCJarl6q4Aj9ig+0u7tdbG8nkVPwWJ1sJ1WoQB32Svg==
X-Gm-Gg: ASbGncuTuRnpvEgyLq9R0X0ujgHPkueSTjMseyNKadLVyUaNSVLCDGeGoDm3NXgYUvW
	YYvkhIEobiwGknyY+y7GuaNgwEPfGYxDsU6onMhMJOthiwawb+cwB7vhLWaHbnsZWIXVw65Vz9i
	fPqmKg0HEkA3PZjjx/NWGyw5Rg9Dmhc0Yy9ce6TlXKAuaqoCG/KbtDXQkkwBd3W+wVsmMpV7hM4
	w5Qhp9NkSR/9+G8iqfAPIQDUrpdFi24QgVPlWsnSUAolnMQ1ZNKS6sEEpUqK1N98EKGwbvbY5n/
	LLhov+J6v6g0eDp57wB+mkYZiXhUvhAafvlSak5ABgmloI58IYgoMx7gm8TT7JaJCctJAa6q5R3
	DJjpyMzSzQCzvhMLl59EnbfdyxzNikS8UBHOduB5gKKI0GH7i
X-Google-Smtp-Source: AGHT+IHO1byqjjNxBlACHQMKec5sRx/1Pe1wqaKn6o6v5kTBztFtBOoxiLZ5TTVHEsh7UV2cH3IQfg==
X-Received: by 2002:a05:6a00:3d16:b0:781:1784:6dad with SMTP id d2e1a72fcca58-78c98de3bb7mr1396567b3a.24.1759444488546;
        Thu, 02 Oct 2025 15:34:48 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb16e4sm3044535b3a.21.2025.10.02.15.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:34:48 -0700 (PDT)
Message-Id: <pull.1980.git.1759444487406.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Oct 2025 22:34:47 +0000
Subject: [PATCH] Documentation/git-merge-tree.adoc: clarify the --merge-base
 option
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The --merge-base option for merge-tree has a few slightly awkward
constructions or omissions:
  * Split the initial long sentence describing the option into two,
    making the instructions and the limitations clearer for readers.
  * Add context to the final sentence that might be obvious to some
    readers but isn't immediately obvious to all.
  * The discussion about lack of support for multiple merge bases
    simply leave folks wondering why that matters and could help or
    hurt.  Separate it out and add a brief explanation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Documentation/git-merge-tree.adoc: clarify the --merge-base option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1980%2Fnewren%2Fmerge-tree-merge-base-clarifications-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1980/newren/merge-tree-merge-base-clarifications-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1980

 Documentation/git-merge-tree.adoc | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index f824eea61f..4e13ed33d6 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -78,11 +78,17 @@ OPTIONS
 
 --merge-base=<tree-ish>::
 	Instead of finding the merge-bases for <branch1> and <branch2>,
-	specify a merge-base for the merge, and specifying multiple bases is
-	currently not supported. This option is incompatible with `--stdin`.
+	specify a merge-base for the merge.  This option is incompatible with
+	`--stdin`.
 +
-As the merge-base is provided directly, <branch1> and <branch2> do not need
-to specify commits; trees are enough.
+Specifying multiple bases is currently not supported, which means that when
+merging two branches with more than one merge-base, using this option may
+cause merge results to differ from what `git merge` would compute.  This
+can include potentially losing some changes made on one side of the history
+in the resulting merge.
++
+With this option, since the merge-base is provided directly, <branch1> and
+<branch2> do not need to specify commits; trees are enough.
 
 -X<option>::
 --strategy-option=<option>::

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
