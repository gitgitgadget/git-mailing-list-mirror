Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169720E30B
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378457; cv=none; b=td7PRcma/7lp/kpB5uJ3Q8CjK8ZxdcKIFlweFAx1rjX8Ql9hCrrfwWn53Sft01bquYLLERRAMAipfVjZR+UWJ2EwppP7MifT2Im5aB1dchvLZq5dV11JZ4vVAv9HFwrxnX3W16aCn7DEUPS7x95jp0OJfMfAFjLRTYvV9svVgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378457; c=relaxed/simple;
	bh=lQoluUa3spQ8cjMDxYPKOY9PwPUL1gCxGr57+3ekUUs=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=gyA4cf+QE5oSWVuXqUy4sVfZO0Y/0mK0yiEkueN7W2eeL97MUARgXup4+IDDRIZf3QpnhAx44p73kHXr0t5Y2gpanfMguDvYVR0QmojwUn1HpJjLL2c4n8ZNql08ixVHwrix4f5YzdNt7K1RK8eyI9qXeou17qlxfiG1y+Vzdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=J+2TzckO; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="J+2TzckO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=gxDK0EkjGJAvouRPKNgLauPI1ikjrwNrF2tuYpxZNFY=;
 b=J+2TzckO+n9bc3eO1Ql4QqdhFtnGF9eSZPBqFCq97iO57inOXEh5eUyTtQTYcg0JGXkOblbtp2Ob
   N95mN9PplJkl0qeDCKC8cxCvqGdXUcCblGZlLgR6TsYy8R2cZBxUp7v3l8THqYpw7UYfy9hrv8Zr
   EPxoBz2SXUw+OO95vOOS11wZQtvwX945fArJU81VbX1SvWsktemHWW+tO+wikOrzTicDZYgT+uIS
   xOsbb+Cv1fiCSpZ1bM4gLpl2eCzsZBPdjIjvqn9fQeiqWQibFJFgDndiu7SmIxAgZ3Wf9acL6mhB
   Vm8QBJsSR4uFMxssAfxAvdGpbRWDqPiZVRvd5g==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM002QIKY7V990@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 1/7] t/t5505-remote: set default branch to main
Date: Sun, 20 Oct 2024 00:53:08 +0200
Message-id: <20241019225330.4001477-2-bence@ferdinandy.com>
In-reply-to: <20241019225330.4001477-1-bence@ferdinandy.com>
References: <Zw8IKyPkG0Hr6/5t@nand.local>
 <20241019225330.4001477-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHFb1MxOxZAb3dhaH7XFcSq8YxJFc7aIXeP7+waHOfFkHkx9UZQnVAEHJwh/6c2
 bjYDgUfBMMPvyd0vtroEG4gVSsZtVDNTrrM9a/813BB9qLVMcVnAr3d5+YV1NE7p
 omlMFXm37dBuVVupiJjPDAICuu86UHkqRtYk8FG1Jj6kxhKVLRbrN+jRRgAoex9f
 At0gijLaTDG/zpJjuSy5wq/Ijn3d4CYfZTUAz/J9/P5wczRnEWvy/44lXldNKzdf
 Mvi3QEJDG4g3Q7SmMzdsIMnY65imTdetPPq/7UFNk5BG7D26KdhEbhqd9io4m6Vz
 10X5NCg0w5cKCp9Da83XOrJ0cewh9LQLq606/e9lnsHfv0Qs2hUUCRCNvhKv+lyt
 SAf/jSew/Ue15EyaiTnDGuL3DVPhmX9rTbVb94uDMxgzQDBmcXrh++Ow6o7rg7ZH
 pg47Tp61Xte6njR70Eyqvh3YJo1jEWazaVORG9vHB5I0/LYbHp1a9oqI

Consider the bare repository called "mirror" in the test.  Running `git
remote add --mirror -f origin ../one` will not change HEAD, consequently
if init.defaultBranch is not the same as what HEAD in the remote
("one"), HEAD in "mirror" will be pointing to a non-existent reference.
Hence if "mirror" is used as a remote by yet another repository,
ls-remote will not show HEAD. On the other hand, if init.defaultBranch
happens to match HEAD in "one", then ls-remote will show HEAD.

Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main,
there's a drift between how the test repositories are set up in the CI
and during local testing. This issue does not manifest currently, as the
test does not do any remote HEAD manipulation where this would come up,
but should such things be added, a locally passing test would break the
CI vice-versa.

Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main in the test to be
consistent with the CI.
---

Notes:
    v9: - new patch
        - a bandaid for the CI issue noticed by Taylor (cf:
          https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/), but
          see
          https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/ for the root cause in detail

 t/t5505-remote.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..9b50276646 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,6 +2,9 @@
 
 test_description='git remote porcelain-ish'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-- 
2.47.0.92.g83fdbe24c3.dirty

