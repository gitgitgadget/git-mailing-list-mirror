Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DE81AB6
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626520; cv=none; b=r0DOuBqDhst1HHnBDGAd12gZx5fDPR4UxM9mew3Dv+XMmKNy9aYSVMO7gYqfcTZW5IwtjC8J9UV9k3oH54LTY2W8mAcZw4odOPPwSTnrHtoBACfTTgfSrozQIMV8upGOU7ask0D8/2Le8LJXujJ7XKV3vpvkYM+WUbmh+Wdnaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626520; c=relaxed/simple;
	bh=rvPztX5aQWf2chtjN8De06WmRBbYFEfID8lOD2ibqpQ=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=GdN0mZPIWGqOcYunF+JassXpWC7z/HpaBl1MX8PPxNu+71Aqh+dYNsViJAS4Fp8Rip5pptZ+IC9oz9vjEsn5eNVS5XRGCEmEALBr187u3Uo8bre8CeHnemB2ZLDF0fEgtwGS/IXd20OhrFFE1Nttpsn0rS1tJ6BJ/aGmBljV0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JQnz2vsW; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JQnz2vsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=TXXtbDI74iAl2tPoNVSzGF/3Uco31X4Pq7No/jAywlw=;
 b=JQnz2vsWjR/t0W2VfVxPR3tYOSBhnNHQvf8LF49cBv2riH9pnpqpcc3Y95UbzTcL1WrNdEncYy/4
   5T8uBtvK+a0SyzXf2wrZTT94YOK5TeFDpYI7Im11EmMKqUPCBjuduJt3cH0z4g0fEST9OKhEXqqF
   1Zn1KZd7sbFKXKXN5jjp/RCZqqIXRUTCU4iac7UlJJtMiyuW0iMJzHcYZHQI76shGsLY4LNmdjv+
   ah4lBEFsmf5Y3p+yqK1gvrq8lkResLkmNFParF8p16X9LotCIyO42TSS81gbTtfcMe/EdsaCni5D
   G5anjZdso029maWTTXDEjz2urL37bR0TjFtzng==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00K0RWCXSY00@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:48:33 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 1/8] t/t5505-remote: set default branch to main
Date: Tue, 22 Oct 2024 21:45:38 +0200
Message-id: <20241022194710.3743691-2-bence@ferdinandy.com>
In-reply-to: <20241022194710.3743691-1-bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGHA9QqAs6nny66Lrx6h0046xxLuoR2vVLgBl9cs5sCtwXDGDNe9lEtO3nRGarE
 jTONO6aB3lLZZxuthdVmFUcv6ZVsrs5ix59FZEZPG2UgIo2FjYi0dJAUV2Q5Pv9/
 1A0L3ScRBpv0Nf2OM87/gD2ezDOGzmSQGRaTCETuGWwO8mPELPn9D7PL8qNlwIGO
 ADtoPHMJp85Pr+CZvKNJ6XQYxcHSof2XDFU5Uls6LiG9JNS9NBNiCAjHAfqbVmDB
 e3vOysrtdmzngfPEQBnNYl5Kw1/MdosQUdu/5PFud8j36mvtuGBQUxlnLoiLPU+N
 ZAFoc9FmIMa1lhVvl3ULs0U2CUb/mbk7kkxYgW2QmqfSiR6+83bzyNYSSgKu/hFs
 BMRDs7g2hPM8FikKF9HGZgRPjl8m4IvXcxX/D+arVDm7Dzv0McaWyG/Uy0938ZYZ
 Pmrz9m10+35XJTZ35OgN5s4RpPKUs7l4OfVBzplfUNJL5OJ6WlzM8wU=

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
    
    v10: no change
    
    v11: no change

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
2.47.0.94.gb64850d498

