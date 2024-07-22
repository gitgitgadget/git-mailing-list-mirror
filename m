Received: from impout008.msg.chrl.nc.charter.net (impout008aa.msg.chrl.nc.charter.net [47.43.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361941BC40
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631693; cv=none; b=CDHsrsHptsfArsPntSRUJG31akQ+DW9MwdAeGJ+VBPXejCOBdBy9nJViV50bVB0ym3nXphWc8m/Cpfpf0i84Z3tUw4CbmafEhs9gJZ9vgKa4Yk9NmB7EZEOQFQtlzqFYytdOM39kpkn0C7fCl1XE5sBpSNtdNiL5iaZvitgD0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631693; c=relaxed/simple;
	bh=d1pv3aeXh26vSksW0l6hTGAQl5h/qMdEM1iIQLLfb4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pli1mxQSADvHp+VDA/b0zqsgIqoXa/g/U0foA1ff/EhJmWBnNBKc8Dgy0gm0WD65yhi5Sf9T6A6DfAm+Mhn9kcdgj9Cfo1SY0KyPTTJ8+9oLO6JxnM6rzt8Ptmxg8tOjXHn5vrd5Ef5vfSchMTKbXuH0oAaZAG1+LNVvKY7RcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=GvgQj/3t; arc=none smtp.client-ip=47.43.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="GvgQj/3t"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Vn1PsPWKO6kyQVn1VsyVih; Mon, 22 Jul 2024 06:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721631594;
	bh=d1pv3aeXh26vSksW0l6hTGAQl5h/qMdEM1iIQLLfb4I=;
	h=From:To:Cc:Subject:Date;
	b=GvgQj/3tX2IiJUnYTxLwUgPV8eYy7g9iC9IBYkCmVFNa5NQYN8o/G0n73Dn6hN7s9
	 OA+XuqNPjKe+eQUeOGPHASd0ZBrWXJJDrlvGsC4zKi73UKtw2pQCa//nHcqFjoQFSv
	 sem+qESS77LRQ+OG+D1g/sXOJGG98072QaFhSu+XFaLeVlBxjjlfdw8mWXJDdbogt0
	 Lb/VArwmtevuI8XQJM4MLOev7aG/VbIgjWZk9vE+qTW4pdo/B+u4EZoePYvpqVJXtm
	 AGQfj5DE0/FwaSq/op9LA1ISXn9dcl48oadCPyudOeeomeERrSHSsy1PyEJ1HbeXAE
	 qM46wVkWzhn3w==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=bKkQIu+Z c=1 sm=1 tr=0 ts=669e036a
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=A8eE4cOsHbpFCe4RO40A:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/4] improve one-shot variable detection with shell function
Date: Mon, 22 Jul 2024 02:59:10 -0400
Message-ID: <20240722065915.80760-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJwrnF6cpF/Rj557ejoMhU3bvAdfl2R/9zhDR144l0NPN+KmCnUzHiSChEn4t0dN53xbwtB/u65B3HDOV00PYLAzWb8E9tD43W89Ckd4FZAmBdjNwvUx
 ZORQyFKFOpNWxtLLd304N6e2JJ+LFu+Xu3vRZRzZi5zuvKEZS5AI72Zzi4HUhDXZVT2ujYDJs2BtZlOGcz9rpl0zre15nwkdsr1uBEbgM3PdLyCULfcPiYl3
 8eQLNqYicB/YKdMcOOVl6Q2bsksSJbCoNtY69GcgEtvuDAqNDYFMsvltMgiAwDTT

From: Eric Sunshine <sunshine@sunshineco.com>

This series addresses a blind-spot of check-non-portable-shell's
detection of one-shot environment variable assignment with shell
functions. In particular, although it correctly detects:

    VAR=val shell-func

it will miss invocations such as:

    echo X | VAR=val shell-func

References:
https://lore.kernel.org/git/CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com/
https://lore.kernel.org/git/bc1b9cce-d04d-4a79-8fab-55ec3c8bae30@gmail.com/

Eric Sunshine (4):
  t3430: modernize one-shot "VAR=val shell-func" invocation
  t4034: fix use of one-shot variable assignment with shell function
  check-non-portable-shell: improve `VAR=val shell-func` detection
  check-non-portable-shell: suggest alternative for `VAR=val shell-func`

 t/check-non-portable-shell.pl | 4 ++--
 t/t3430-rebase-merges.sh      | 4 ++--
 t/t4034-diff-words.sh         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.45.2

