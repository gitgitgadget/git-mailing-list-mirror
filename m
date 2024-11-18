Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591891F5FD
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944031; cv=none; b=VGEyg5tS5MHdagfmpmFq/g/mPydn3QUgAUC0KSWuBhZg2pA0vsH9hlQhwzxLYBMlxut617HPhKBjU/yv6g9PUSzHPWOI51UfrZSubDzGgZ04LTtgLlsEb89snpft4on4Autk8RzIi0H3EeLDkyfLdCUbqSqa55RRHA23J/6ktFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944031; c=relaxed/simple;
	bh=2Iic3iGwWGQczQnUVly+kdlz7AWm/qF9gh6Otekhrq4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=gVp6e7poetLlQypbQXpXzltS0uuM+IAMd55yOKhUND++g/pM/V/d0iest2D2r5+O3Y5D670iBKRnALavfEMtBi4ySJXdfxN/MjSPuVtisRiTxYftJgW95outV9rjuP+7Drl3HxBktsEnCTPt9yRY9AP+x7CTsVb1qg+pd9rFCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=S7fdqJK0; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="S7fdqJK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ByGbqoTV0dtG4t0BMeOKqHHsLMQW50p6XdvIEB23ryU=;
 b=S7fdqJK0M9Xrx6xRBkkPXydZott3+2gixImoOkFSSRPd81WqRfBkoind8FIFRj/5CTAP74D6BTnE
   Dmj4l8SrIUjmSF39t5LWeKkc0E6RSjw8NC20EqZklhooW9C9pFutX8ESdH4yx5QPpF0NRteDtqVr
   7aZ5NiJ6zMR8AJeD24jA/HIIrEU/bEBUzyQIm3mYw7fd4Wl0qLQnxqypgTauNpF4/xIkhzMyhUte
   UT6vjtXjUl7nTC2iA9OzDWqW9ICFfkmCqRfO1SN9So9c3FK9A4wUshTWVlwKGuZmb/kuKw2arrGR
   48Co4dxsxsQYrpf9LPwAmckbvark5M1AM9gm5A==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500N7LKK56H50@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:33:41 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 1/9] t/t5505-remote: set default branch to main
Date: Mon, 18 Nov 2024 16:09:20 +0100
Message-id: <20241118151755.756265-2-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFvTuQ4QnxnNFVnn7+iC2xfXYfLionyixwsJlGteyHBnL0/Z3kkHEL/JVBOjy1C
 YIE7yhfq6ogUbW6gQDn7ARqB5i6nsjAkPr+Cpskyyi/awSJ7uh2jy/vtkzU30FT6
 4hyNp/Yat/x+t/0JUT+sw1a+hjUU4yrBcYTnVWyfhg627/IeW0mlNDFsIzdsla/c
 oJxDl7jFmezhALHSmr6cjtPxX6X6yDFW9rdurCgOLkFbWLOyWAOnjJFJVjIl7myQ
 AaDn3wrXQA17vv+2BBYGSSnKgs63KAGxvzbaZUONrf+OUviBFoDUSMLDTgkKxnfK
 AZeI1SdU+6RRi4vhGqaaDN4RyD+2Aeu5Cy1CBvrd+e7oSN1CD1t+xTirrdSVT6cX
 XFov6JRun/fq0dS90cIoe2wigy3L0fBR7lKUNKQwe72x8Ff6yMpOWyJoix6ocfvZ
 +OuWjhM1VtnqBbE8MhGAbEe9vp1zu8/8wBPCJ0PTfbfcGW8dGGp/a2gF

Consider the bare repository called "mirror" in the test. Running `git
remote add --mirror -f origin ../one` will not change HEAD, consequently
if init.defaultBranch is not the same as what HEAD in the remote
("one"), HEAD in "mirror" will be pointing to a non-existent reference.
Hence if "mirror" is used as a remote by yet another repository,
ls-remote will not show HEAD. On the other hand, if init.defaultBranch
happens to match HEAD in "one", then ls-remote will show HEAD.

Since the "ci/run-build-and-tests.sh" script globally exports
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main, there may be a drift in some
tests between how the test repositories are set up in the CI and during
local testing, if the test itself uses "master" as default instead of
"main". In particular, this happens in t5505-remote.sh. This issue does
not manifest currently, as the test does not do any remote HEAD
manipulation where this would come up, but should such things be added,
a locally passing test would break the CI and vice-versa.

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
2.47.0.296.gda1ecfef29.dirty

