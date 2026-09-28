Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C74C10C3
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606292; cv=none; b=TLZVTs6tbaVvTuxv+FHTPFs6Vyx1nSuk6bbsvkkJt+r0avDva9cGowQI/nrP8zsjiMReST26HJzKR5bsebUh6wuSTL4PPAXGUzK78ZyQn6WtLRrIZgKRuEH21hUDnqAkehU9Wk+T9qRjAVoXHtGIWYaHhgq+Lc/OTAhyunaWTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606292; c=relaxed/simple;
	bh=dWUk0yNY/yBIs9Bmf8djyH+n/laEhtkEp8mrBBzzAus=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NFvcU/WUCjk5xJ7cipsqCrGt22GVlp179KhAVeyAUJvN1cWqwQPqLtqSUr+oulky3ElavRvaV7iyzz31SbOs5clY67rm+W2vwz3QWVHVoF0DECiQTAtdY88O5+XGSOg4hbuKvmb6SutcDuW6/22fh6ySnUCfAVzzNgjMXcztbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2hiZlfh; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2hiZlfh"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88098db8dcdso1165691b3a.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790606284; x=1791211084; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vqHPphlwqZKAfs2vm2Wl4ltPaI4BLXPvpaSySqssU5c=;
        b=k2hiZlfho1JzJrBzeWX2A76hivg535vQZRzGhIBivsJz3TR/uYuCTksn4NX4ESdtOK
         S7KLF+YgHy7MCG0ilwT42MdmL9FUHNCqoS4Mm0VIBEwmht1Fw0YP5tH85WDyjQ+VIcZS
         U2dOIZoZvzSq8MiKVVwBhox9YOYrwPVXyFycnqZmx9W9PCKX3NTQmwuu+CDajqK4YtGV
         vkvMcK5kx4MFNhAoJsYAdHTitS43N5wi2HEPRmLJ3lMA4fTAn5CLKLlia0FM/RJj9eck
         KiKGpPNpn5rVBp9+CHACoXss8OzOBBA/ygCtJIPDm79NqUl/zrF+92xyZ/qY/mE3AfhE
         QAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606284; x=1791211084;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqHPphlwqZKAfs2vm2Wl4ltPaI4BLXPvpaSySqssU5c=;
        b=QLyxPgYaxJde6gIcXAj63rqetD2ujJ1i5ba9KxbR6+2967wOf3Wu00n/4B+CkCPZg9
         1haUwRBT+rik/1J31Sn2AXWph9XFEQQ0I1Zwfabl4zUz8dpvFDCDh+Q5ylm4Z3bmXZb/
         ZDiy1Yxn/a+LYzI9m0Nhk9iPxCktz2JnhfI80HdXCmPd0xqE4zvw81jI2rSCGlw2IQMt
         6tbl4G9YdPzLbBThDWPCLPBlIHFda7k7Bpw934ShmZq6FX2MC+TITCtHwBdholJBcrBd
         b3rIHIiB2Z2XslofxHBOy6JN942VmBd5EtmU7Va7Qi4rVJ4Em70FGdRY7gXYZA5AEbPn
         pmDg==
X-Gm-Message-State: AFuF++nmT718103aEHO0Ayu5aIzWuboAQPs20iRExKXI5wvbXlzsV2ZP
	9PDQmGFhvI/bXJeqxK8MSB977+Nx7Zr1B6EWRvQylbgH/63KglgI4VS5y0wO3Q==
X-Gm-Gg: AYBFou2+2hUgxHKqsSUFcwPnQBWYvlbp0jVr34Q+oDc1Pxtaltmd+Zs2Bukx5Id51VR
	TD6BSQzXM+C1FhnrUXW29RSShyWD5INE8+Cn20rmdSc6WW4Es2J9YPgs8VD8iYvtXdmgU7dGz3T
	dLXYgrGDSzBOU0a/iu6C8pQejBcI7LbpDyDRAcruiyRLJwLVmxEJDEAQk2IadPF9Ixyh5KFXt0f
	dVHAbiOR7RmHDD54lQeb3dMfF/6wqIzv8ssgDCx+vLq1DmJBzR2NTOv5p6Qupa5B/At9z80Pol+
	Jn0SrVTt8kW4gukQCX+SEk5ivy1o1S7FB3CsPVwDpCuWALpJZ4qvHbmdr1stPn1dkA5bHTh+PI4
	ird/qJ3tn1wGZJD3vUs50xvBhQYA0fBl83u36TRz/znPZUEr+FR705PF3twL1ns1x0qptaqmJS5
	gt8yLhVZuB2qIRruQCgTKYNa+SMlvyuxycsMDiGXQaU+P1mk7K3vXInff6hZ6czI7nw080B6gAo
	A==
X-Received: by 2002:a05:6a00:1790:b0:881:e626:74a9 with SMTP id d2e1a72fcca58-881e6268a10mr6319699b3a.26.1790606284480;
        Mon, 28 Sep 2026 07:38:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea19800esm4252294b3a.10.2026.09.28.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:38:03 -0700 (PDT)
Message-Id: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 14:38:02 +0000
Subject: [PATCH] t5520: don't expire reflogs where it matters
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The "--rebase -f with rebased upstream" test computes its fork point
from the reflog of refs/remotes/me/copy, and the entry it needs is
the one that the fetch of the test before it wrote. Like every reflog
entry the suite writes after test_tick, it is dated 2005, so the
first "git reflog expire --all" after that fetch removes it. Pull
then finds no fork point and rebases onto the merge head with the
merge head as the upstream, and the rewound commits come back as a
conflict.

Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
default, 2026-02-24) auto maintenance runs that expiry once the reflog
of HEAD holds a hundred entries it would remove, the default of
maintenance.reflog-expire.auto. Which run crosses the threshold
depends on the entries and maintenance runs before it, so the script
passed by chance: a stash topic that no longer runs "git reset" from
"stash apply --index" and a rebase topic that runs auto maintenance
at the end of "git rebase" together move the expiry between the two
tests.

Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
as well, which expires reflogs on its own, where turning off the auto
trigger of the reflog-expire task alone would not.

Reported-by: Junio C Hamano <gitster@pobox.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    t5520: don't expire reflogs where it matters
    
    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
    bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Fthomasbachem%2Ft5520-reflog-expire-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomasbachem/t5520-reflog-expire-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2243

 t/t5520-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 27f38ab3c8..bc818605a5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -35,6 +35,12 @@ test_pull_autostash_fail () {
 }
 
 test_expect_success setup '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	echo file >file &&
 	git add file &&
 	git commit -a -m original

base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
-- 
gitgitgadget
