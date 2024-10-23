Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC13A1DA
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697937; cv=none; b=IYY+Z9WWeQJx09RVvgZc8n5yC+X6gxAFTydqIdnL1Sn/wG24vabniL6yfs5RyPSM3MPuLJV8rsiLy16wMVH7oOLhWGOzthQ+F1GMbxeGoT+PMhVAY8x2W2z/I6LFnb2qGF4GXS0SjN2cREyeYXP6FYDHRG6EhBvrEm77lJiChWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697937; c=relaxed/simple;
	bh=mh/MNxb7WFQb7cFGIGyZlMKdWzTyq9SRVIUWmNBSRPM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=t5PHFit4OqgDj9IFtYAfs9jX67wjVv5ERRhWsSca+EC5+Go0WtAlXdorXclRLW9l2+v9wCExEFKJaXiOvBjCiZuLosdBJMIdy9X6vPZVo7kjZk+316CILq6ppM2IbccHWJE4AMd47KswjR4JM7f54RxOh0NFPkok/B8bHl2jauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=erKkwtec; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="erKkwtec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=56VzXfHQs3c9KtWkbQLHbjAmU916vjc/G2TaxdV4b2Q=;
 b=erKkwtecsxrEBM6SFZkvYh9dxVGtl1Zs8CuPzlAVGQQraRBqnQVwIcsHk28avmK6LQcLNxB3Ym1A
   0dctjZYx+DTWgcxhLnH1/POGE8CL+6P2PlJl9voqQdFEzhgoncsRoQdJM9AdoRIk/PU5ixKLDKfC
   oZLmZjJRmoKLyXTN1EOMTd7rPUKdL0PAg4yUAKQMNMasMvlgeZZbmuOuGcJn87p2DjcU6mRgilaO
   t+A/S/wq6XlnPj6gAe1xvMiJ3GzsAUoQe5sk8HIcvWOwEUHMmRlRhNVS21J9K8LSyei/nKns5Ai7
   Wm9HKg057RChKDR5ELrcEDwAE091n5FX9jB3cQ==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00DROFGRYL40@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:38:52 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	ferdinandy.bence@ttk.elte.hu
Subject: [PATCH v12 1/8] t/t5505-remote: set default branch to main
Date: Wed, 23 Oct 2024 17:36:35 +0200
Message-id: <20241023153736.257733-2-bence@ferdinandy.com>
In-reply-to: <20241023153736.257733-1-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAE3E2yj7RcntEa9ZQAgXIrjzU4XcukpfUYogdhY4k8jpoCTBWTGODvDlIz70Xjn
 ssPa+a+P7IAcXylge90VbAyLXr6svSzJuZQ0OHCebkH1XwR/7CQEao3wLgrSo2ZL
 84W1iBAhoDijU+EEi5uJjFoz0rX5zS8snm96EyePHxlNkfOFpYqn9Qji4jEinask
 Wic4/0QAvzu34Guq/Xvfdl0On59zm2892KGsODKJ6CVwfkX1zIRLbsLS0mzOo+HZ
 n/gZXPk/UEpGx/T4nBABDsVoa0BkBvPQTnctLzU3a43U2MJOWMsj/sGnntfQaVE7
 GVqsxVglBE5o+hZoGQjnJFstfh52y2P4NmESKvYK/GTiPQyutZzRxRoQBsz20FWN
 kLUfmozEfJAwefi6bAyJAdmLO5HERq90qoaexvJcHMaQ9XAE42FFEpCzRHh1ZZjm
 kQuEhWSo0RBCiwhvtnzX0UZ+Kh9tKbA2jZhigVsWDo5vrhC0PyagjnU=

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

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v9: - new patch
        - a bandaid for the CI issue noticed by Taylor (cf:
          https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/), but
          see
          https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/ for the root cause in detail
    
    v10: no change
    
    v11: no change
    
    v12: added forgotten sign-off

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
2.47.0.94.g1247fb88fd.dirty

