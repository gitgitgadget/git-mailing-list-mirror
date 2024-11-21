Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC11DC05D
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230612; cv=none; b=Y5eXERRQWzSiUJmC4KzbxVuy9raOBjbuboZnOWd9gD9XVtofrAFx6edHgM+L0i1AF+cwYdJcxSIkIsWfZFYycNtdPfhiDzYzUr9pPj8tZw1wsYe3MbmZc/sKh94zcHHC5abN+IQ8+3utqujKOVtwPWSHg9XBdALewonXqTUILRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230612; c=relaxed/simple;
	bh=qvlMS6E7sITCalZqdfDCvzODbuH9u8jtGwo46rfOxVk=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=CRgdg0/Qovlr5fQR8ktXYDlTmhALgFEqRKVtaT/803H9Xgy1YuuXUCNyE8Fo3yUuOGHfmwebBM++eM69dDBsAnCxaxuab425uYMcKJVTGSjYSuoCAyMDO72jNduDLRw5PcwW/mH1STIfC4w5bQWgr9KuzO/l8RKsA+hutyFPqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=foklzxKV; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="foklzxKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=J+abhAqT1UToEyfcyRPGij2qcMY53dSnE4cSdKyMby8=;
 b=foklzxKV+fdC3vP6zwpfR/+T2kemBw2Sk3XGZ4eDhymQTM2eTL4hoaoQetRF77SbwDBuxgaPANTZ
   GbF9UF33uOIN9tC2T/DGWmhMLOsHvjxbDq0X0GugtH35qeXYtmVyHxf3DRktRT5R9/3gjTsYxGDH
   x29M64yeFcvN4q0rfM5QP+zM3ij5hRr6TPh9JM6lnYK2evdYaA13ZGmbhvCWDnoSLN6C/M8OJ1KR
   W5QgMm0/cxxftoj231UdsWU1WceUcpTSJyndSi7Hei00wCBy3xGyQFj3xLr469Ala/413H6zBrRu
   xIIbguzqRIXh5ZQoJD98GQBySjO4yNuJZLZC8Q==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB005L3POQ5Z50@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 01/10] t/t5505-remote: set default branch to main
Date: Thu, 21 Nov 2024 23:55:01 +0100
Message-id: <20241121225757.3877852-2-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHd84Hzpuqkwcc35CxQIH07TVs1gyHKWGJbWSYW9PUVbdWjPAD9MsAm+uD4T00S
 KKfP9LBszRWf7ki3EBJSu86foe85HPzO9kso5K4x0c9jHA7j4ipIExOzP6pOw7Py
 6IedDTkFuK0xGndVepKkE/DStsO7v/HAw43hJ2U9xuZ96yI9zRyRWqNFTd5OP+y2
 P7g5gIxxYhj5Nu6M9QjTCNggeDadu5nKVMtYT8Ua2/EQum5N95bN0vbO7O6MXCCW
 ffDGkTWwdYBVFgu917dFxBaXBJ3xQGFgHsCpoQ8Y/QF1nanIW7UNIdnghVksONze
 FvwMqUljQFBntrcbg45fZ6BTNiifNE0GwRG+7ii7UhR7xHhPEB/xyNi/CQCwMUb0
 WAVQ5EsvhTYFksmpaTd2yTDk/6GOCGAQfDd4r77JivYHrDk8B865ao/nfogUyLG3
 LjqNwroJsvgrXkZyPxfCVACCK7BoF6feKpx7ys2CnjcESC4lcO75LPo=

Consider the bare repository called "mirror" in the test. Running `git
remote add --mirror -f origin ../one` will not change HEAD, consequently
if init.defaultBranch is not the same as what HEAD in the remote
("one"), HEAD in "mirror" will be pointing to a non-existent reference.
Hence if "mirror" is used as a remote by yet another repository,
ls-remote will not show HEAD. On the other hand, if init.defaultBranch
happens to match HEAD in "one", then ls-remote will show HEAD.

Since the "ci/run-build-and-tests.sh" script globally exports
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main for some (but not all) jobs,
there may be a drift in some tests between how the test repositories are
set up in the CI and during local testing, if the test itself uses
"master" as default instead of "main". In particular, this happens in
t5505-remote.sh. This issue does not manifest currently, as the test
does not do any remote HEAD manipulation where this would come up, but
should such things be added, a locally passing test would break the CI
and vice-versa.

Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main in t5505-remote to be
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
    
    v13: commit message udpated to be more precise
    
    v14: made explicit in the commit message that the default branch is only
         set for some CI jobs

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
2.47.0.298.g52a96ec17b

