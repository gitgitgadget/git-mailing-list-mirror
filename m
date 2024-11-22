Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479A524F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278761; cv=none; b=hcD+Fqrw38xp/hfldt/pfjrCVFPa3Ehyiw8CxkoTeat9lYZ+i2PS7NDVqs2iIlFAIrHYlR8HFr5UiyfjMIhqA7HByW7dhen7kdsXEbUnYSJNAFOck5Qi3BNKjoq+tRHW5g7V8xPgtAnrbHu58Nx+15nXpwJ60awHaQ5yN7bAOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278761; c=relaxed/simple;
	bh=PuebsAVLrHvg+Vw5pYhATqcDI6lutIb3ycySk5pbDD8=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=NbH48UDwh5q7jVc8dvKE9ZQhaVCDF9mi+6NFPf/2HHtp/7Iu8N+8Td4LvLABHTaNh9/RVld8hJZinRHDn6eoL6tW7Fd679MPhA9Blcfz1tBYAvQfVIF+sxe/+OsCNRV3qfjRQUkR6i20Z89DvUem95rLhwTOryFTemdV5s6eIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ieRCXP1O; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ieRCXP1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=RKy1IRNtMiCt+0IUxnEzmDqPBmrunFkA1rXVtPYGSVY=;
 b=ieRCXP1OmMEV4PrA88V+G45GjFw/Gk/8jrvU0jQWv1kVSKrWlwYuq9lItf84xJPKO6DGfingIhHm
   qasKwFzJiMXrhmTI0vNDriTysAZ7jTnnDBG9+Kdyv/eitCqLnXJMOEUaUyIhPRM7zTgq8uJXvpIi
   bSd1wpB+mqpD0SZCa7m1PeKDgFr/015D/dqdjtUomtlBFrw0L9yV/UdKtH/ByP/bYdIQcsoP63ed
   6gtczf4WQqOzeZcQiugL+XPXsc/I9Vdebth2fiIQATngNfYDFt6O5lVRHkGJgw9Uy+E4F4QW9Ara
   jiUSFJ4oaOQdkBpjLe6Np4BYvslmURphay8mpQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00NJNQUDBTC0@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:37 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 01/10] t/t5505-remote: set default branch to main
Date: Fri, 22 Nov 2024 13:28:42 +0100
Message-id: <20241122123138.66960-2-bence@ferdinandy.com>
In-reply-to: <20241122123138.66960-1-bence@ferdinandy.com>
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG/BPE2Gx8pkLvG8hopB4zX7FvKjrqK44Vl5GFUxSCbTi05zQ93/fmccNGAJtv9
 Ul6VMUbN6v80/W7C6h4mX+CTQkZJwKy9KOV1jU7nkPrvFn1RHmRBZnjJmPE29NkG
 CyC+gJtQxGOSNgzJeBUHk/KfDSvDFhMHT96sK5RL2V1qe1gJlKB9qTJ1EAuKsndr
 JGIOReAxZszqb7kh3R50zR20F7oEmWMzxFrQpEbrPLT6dsAEnQHFZaHr7ruDcGwF
 50jS7TEzD46mtJUMPSN9zJr4J/ojRfuCB6lp9CkMGotj2SD+pAyxniB43R5NM9lg
 FnvfNmdowIOyVP5Z/A2TBl1nxe9Z7EGUzRDiu0gOHi4/3NZqahDkx5fJhtI+7224
 hD9X8xz1vJrpmeckDQYXgF0g1HjT/TlumnMCCPMJTKHgzb4GDMNRrZFXvAyDy6zf
 Ho3hhHyD1zyVOdQQo3I2df1KVBBd4g19hDhGVicy4MBYPGjaYu8U/yU=

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
    
    v15: no change

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

