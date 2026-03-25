Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CFDDCD
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419679; cv=none; b=REJOaIh6NFbTYwgYvZ8SayaANM/lEcg3+/7Sk93Ll3Aji4caX5LuWyqJR0yqd28ywTRyLrCFThfovKMDEkBGxh11iz5ZQXErVbm9mC7IeUg1qWrfSOR4ajekUVl0GKAohym1NqCT8TWpOs9wrlPR4IfY6w1q3fkT3U7nO7ccGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419679; c=relaxed/simple;
	bh=83wwocd6eQwPcuKUeTTsE2vt7DOxhg5r6+tzLayy3ic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=deYu+ggsQust+4o6aOhh7dwDBwHAu9+CxmS75wp7p7rIOz9ewL3G56DLzYNb6OBtibS9d4xrEckXPNe+hby4Y6xqBJmFktWteLsjDJt99PL/NSs/VHrrwxRcrkIZ2S4Q7E4JLths1XGQYIMH1SDud6X/19/Sg8joS4eVu+UjNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DPNcMV5P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qfg6rdoK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DPNcMV5P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qfg6rdoK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BB681D001BD;
	Wed, 25 Mar 2026 02:21:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 02:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1774419676; x=1774506076; bh=CVs8zfNUEWnzTxzDmku2C
	BR2ZMAReUhF6C8125B+bBU=; b=DPNcMV5PJuAR4Pikckrw9iCUdZbMqBKX9SZvK
	Y2BOwdMOP0SaJXA5yWIxqxoGIAgNFGli5Vd5ZmpoNdWqLuI9YQtPOVFrrclq/iHr
	o6y9vWnOQIm7Pgq7/wRoIKnOUu4d7lB75cieTZCRWXHt54/nVhzWeiRyp3ZGKQ7S
	8HIX4ytdjaJOM+gYNsf05fe4U+qEA/+Csw0BgdCtg5tRbBMoL7TNgnbcAEwuqM2V
	1Cdn0CRISqG3/uDcpiH0slLdf8cZmt2bwoOgsO2mpgM1e6cdiLrf562bI2a9yD1v
	WY2cSDTRfbAgZO0VChPdlxnx53ZfCiNZ/Guuq/7rcFX/avH2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774419676; x=1774506076; bh=CVs8zfNUEWnzTxzDmku2CBR2ZMAReUhF6C8
	125B+bBU=; b=Qfg6rdoKmCwAlhK77NWpM2eAZpSC7eJpYDE7TgaXIYLoGOmzb2l
	jhju/Z7cEZBJQMHevfKweV48ueXH0in8OayXpPCgxBIvGcZHssqvPh2rCG4YB9IF
	p6gfXO/kS46mf3ybMpO6ijP1fYlkf2gOEX1kx/pSdYqZL8zdsQd6JKN12UwOwP+z
	IooNvg9UgFK77TnIoLSLw5zN0PNuFl8HWEzbckEXT3+3WJ1nM/3mLvRogPKorgz4
	K07MPegiGGKlR1uY7eMl7tftL5PwaZEib+FT7opdg2XxXd4EE/yxtPtWvo/Kxqf4
	Ep8W05GQYsPV6Muk1Rbtr91z6WdP95fJ8TQ==
X-ME-Sender: <xms:3H7DaWcI-LjfnsTSdNRkNIXR5gCHDFuibWbXM11rg1arvE9hcKXxvw>
    <xme:3H7DaWO9r4ILT8GbJyxfXJkpPyjCTjK_g8_3OqxQmcXu0JdrXPo6WMshOTBG5XUpr
    ywWjJkEYrzhCXbPkwWFXXYiig9FLc7i6VZypjVFBaiCEUs6oOIkBQ>
X-ME-Received: <xmr:3H7DaVKLhy5kS6suH2tD3BHDRsBIZw1qizOc_NjVFugezNnmwfEAtHTWHamO_r_e0vEKSWmiBJSWtjiFl7A0O6q6mNXY3fT3DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeelveduffeltdejgfdvueevgefgveelud
    ehtddujeetgeffieeljeeuieethffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:3H7DafFGVEo87xYksj6Nb__AiCjnYiWDgnYK5hhWMdsJM7GMJjdk5A>
    <xmx:3H7DaVQ4kaumFmsvrgXhTa4dwcoYIBLhovPf9F8E7pv4KFB7bUEXgQ>
    <xmx:3H7DaTFfeOh1H2VKudAjOqQWNVmskyt2dacJua9TXpSp-g8Pwad6xQ>
    <xmx:3H7DaZ9AhztcVrxtJogIHHSXBIgSobydn_bAIk8kT42XGohzk8Cqaw>
    <xmx:3H7DaR1WVEm-KnGNjMz9PkBxwZpCLhMRIUK48-NCpTWCuVXojCY2eqbH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 00/11] detect misspelt test_expect_success and friends
Date: Tue, 24 Mar 2026 23:21:03 -0700
Message-ID: <20260325062114.2067946-1-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently we saw an unusual typo in a test that misspelt
"test_expect_success", but this was not noticed for a while
primarily because the test script itself did not fail due to this
typo.  The shell and the test framework did say

    tXXXX-xxx.sh: line 22: test_expect_successo: command not found

but otherwise kept going.

One way to help us detect such an error is to run our test under
"set -e", which will abort execution after any command exits with
non-zero status.

However, there are a handful of places in our existing tests and the
test framework itself that depends on the current behaviour of
silently ignoring a failing command.  Here is an attempt to fix them.

The first step turns "set -e" on very early in the test framework,
and fixes one place in the framework that assumed that a failing
command is OK.

The remainder of the series fix one test script per one patch, and
at the end of the series, the whole test suite pass for me, even
when merged to the tip of 'seen'.

Note that I let cvs, svn, and p4 tests run only up to the point that
they decide to punt due to lack of external tools and language
bindings they require, so for those of you who do have the necessary
bindings, the scripts may still fail due to construct that are not
"set -e" clean after they call "test_done" for me.

 01/11: test-lib: catch misspelt 'test_expect_successo'
 02/11: t0008: make test "set -e" clean
 03/11: t6002: make test "set -e" clean
 04/11: t4032: make test "set -e" clean
 05/11: t7450: make test "set -e" clean
 06/11: tests: make svn test "set -e" clean
 07/11: t7508: make test "set -e" clean
 08/11: t9200: make test "set -e" clean
 09/11: t940?: make test "set -e" clean
 10/11: t5570: make test "set -e" clean
 11/11: t9902: make test "set -e" clean

 t/lib-git-daemon.sh                | 6 +++---
 t/lib-git-svn.sh                   | 7 +++----
 t/t0008-ignores.sh                 | 2 +-
 t/t4032-diff-inter-hunk-context.sh | 4 ++--
 t/t6002-rev-list-bisect.sh         | 4 ++--
 t/t7450-bad-git-dotfiles.sh        | 2 +-
 t/t7508-status.sh                  | 4 ++--
 t/t9200-git-cvsexportcommit.sh     | 4 ++--
 t/t9400-git-cvsserver-server.sh    | 4 ++--
 t/t9401-git-cvsserver-crlf.sh      | 4 ++--
 t/t9402-git-cvsserver-refs.sh      | 4 ++--
 t/t9902-completion.sh              | 2 +-
 t/test-lib.sh                      | 7 +++++--
 13 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.53.0-886-g529cbd14ff

