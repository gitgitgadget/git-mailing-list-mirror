Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383769;
	b=RSqgdZVye9m+DYKEy2iIvx67S5SxR9L7mWfymj7e4++F0PJXoBLxHAA0iDerxX1uO/GT
	 +AReBZiOLvC7+jB2/wzSpYfB36P6SLLhJomgs7LUv6X4+GApqnDn1F9Nwq2t3EZKKmHFe
	 Pd/3RcuTrHqyNv59n5pK5VoX6DfAeNDeUzsbhjhzInkT+UzFMI1C89Ng9j5X8Dvc/or24
	 iFW2Y8k/dtukfEvoG/ZHaScVxabCu82w1M/AwGXpIk4mAGuqzD7iv72FEEICIb7NyYzDo
	 gl5u5dWAhWn56NaLuVgFHieQzk2HqkVrPQ6pysnCjQ3T3IGQ5uwzJ8qDw5SrtTkEZJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383769;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Tf9LS5Lc7wb7GsZs4nSB8fMkO/Abiyy1O+dOvWrPfug=;
	b=1aqr2nwGWlmlDmGGrpucWCNyAqMXCi5gyVz897YoM1Cm2YEUSdfiZJX4Nf/xKA13pbnZ
	 1KRRWd1kEe5zBtvZ/9v/18GeTCxL5zwObuHtXcAG5Ny4YaRctvQShPQS07wV9xlE0oWEo
	 3fLaLpQ3jWz6gh+QOgV5SWdHqRiJR+t+3dSKDfS7ysOR0MFIsNXTFhQk8IkAbp33HfzK6
	 5Q2qtKn6/5OR99cROTcnrwk2tTRDWWrLevICb7EPmyFhjLb5bUf2LFE/lyD2lch29R7TV
	 rtu9KwYVEksw1huPTmxb0OCpqFXt1KR07BnUp2jgWkCx7DUBCBaW1jstSrXf2jSz7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=j5ss+Pzi;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC26606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC26606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=j5ss+Pzi
Received: from localhost (198-27-206-187.fiber.dynamic.sonic.net [198.27.206.187])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AB7u2oG022762
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 02:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794383764; bh=Tf9LS5Lc7wb7GsZs4nSB8fMkO/Abiyy1O+dOvWrPfug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id;
	b=j5ss+PziPvjryCU6qWIssqFlgo33ecOKvElJ8LlnEw0+nnjtVogBxsr1xfzTYKNEq
	 fbDXR0Dt9XNaKBk1/owerX+Us7YQEmixNoOKdSQk7qTaaz9zPMKvtNmPWTBQ2C3TGT
	 OTygV87BWgYTyupcaLmCNSxXfcZINl0W0f18ViLV6rrCPdhagZ9EnSn6AATttAeMyh
	 e7mnd4E/UdSQY2a3UitUxdXdQsdlFdFGPBPXo8DpEpIo6b80XC/0VRAg7K5O0D+ahe
	 C4/UCXVXiRzsHI+6xCGPrOxGPMyP2/SyrxbleRZqP4PF19nRgn+V2kLJ0tqQuEBuNd
	 +Q+vSXg1g4B3A==
From: "Anders Kaseorg" <andersk@mit.edu>
Date: Tue, 10 Nov 2026 23:55:58 -0800
Subject: [PATCH] t2401: fix misfiring substitution when path contains w2
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-t2401-substitution-v1-1-32f3524f2b92@mit.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQAwAvyI5d2GzK2L7ldLDqlHjwZZNFEH8u
 7EeB2ZmB6HMJPAqdsi0svB3NsBHAe2Y5oEcd8YQfKgQ0TsNpUcnSyPKuqjpLqamrPFZx5gQLPx
 l6nn7T9+fm82fqNXrBMdxAtEogTh2AAAA
X-Change-ID: 20261110-t2401-substitution-3ab4819833a1
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=andersk@mit.edu;
 h=from:subject:message-id; bh=/rQ60EaajW80mnZDzcIdjSrGCxaugnQCZdFZ7SXzYRA=;
 b=owEB7QES/pANAwAKAd/zqzdPFvc6AcsmYgBq9B+S1WQYm3269remzBWhX4CYDeD/LpGyFEjXO
 Znu4iDlvjOJAbMEAAEKAB0WIQRqPGfX8BGQDMU5JIvf86s3Txb3OgUCavQfkgAKCRDf86s3Txb3
 Oq5+DACBKCTo3cAhLRF7BVm2BO1yMFrtcB93AQ7WYaejwD6X3gFtFod+bYCTGJf7ZqibVe+eLeN
 GNr5u0hpKzRk66GNgHkr1lqitnwP+Rmi2Xy8TmcxJemFmsxD5XpWkOjijoxagUzby+OuQ09FxV9
 BEQK+GlneyednapD/RXXT8788NK1fWILbf6PaOK9dNC942t359bQfJT0OeTJgtghtpgEHHhrNn2
 nla16/d/9XP4sGlOpve+Tqmq18OJCM0YLwP1i6qkzT8aEemwCxPIRgp/MwjPp80BM8FXQigBaXo
 WEkkDPehjal/kA/YRmCjDtb0jcbpBqaNjAchykFsKbJs2+qklOa7D+PKuq/HH494C5rfaOKWxqS
 AwdhprUqVikVslM1w28aJ+OZmjYu5PlS5y7XdqU+zuk2yTFcJHkVyBL0Nec2Gy8zdSIz1vc5i+U
 hugfg1C6ygWnoiXwBWva5BYYvKoUx3FNvn/8ZFPBDtofUQaRZ1JZdDPJ4GjbWg7RBH7nQ=
X-Developer-Key: i=andersk@mit.edu; a=openpgp;
 fpr=6A3C67D7F011900CC539248BDFF3AB374F16F73A

Fixes a test failure when running inside a trash directory that
already contains w2 as a substring, as can be reproduced with

  ./t2401-worktree-prune.sh --root=/tmp/foow2bar

Fixes: 4a3ce479ce7c ("worktree: prune duplicate entries referencing same worktree path")
Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 t/t2401-worktree-prune.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 3d28c7f06b..5a2c998513 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -99,8 +99,7 @@ test_expect_success 'prune duplicate (linked/linked)' '
 	test_when_finished rm -fr .git/worktrees w1 w2 &&
 	git worktree add --detach w1 &&
 	git worktree add --detach w2 &&
-	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
-	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
+	cp .git/worktrees/w1/gitdir .git/worktrees/w2/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_i18ngrep "duplicate entry" actual &&
 	test -d .git/worktrees/w1 &&

---
base-commit: da8fb6be5594b4a06ef2cc2ff7a5363a6fac2b5a
change-id: 20261110-t2401-substitution-3ab4819833a1

Best regards,
--  
Anders Kaseorg <andersk@mit.edu>

