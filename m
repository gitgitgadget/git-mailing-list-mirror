Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFF3537E1
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419690; cv=none; b=aVTFNgP7DSzWsr2J24Vh2Yw16GJAAbQHSt4wgKzmTSsDLmsEAJgxEPD4XBq0RhYGTeOh16OGdVsvwcpnMbG4nL+AJbmbaR8/I9YxDy3PsmiW3fa2nd7SBhVTJPsEgMTqj7dk+aJ68Y9z+kSCsl0JYkFmTvFVYHRx4H68eIDnV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419690; c=relaxed/simple;
	bh=ybt2yI++7yoLj5YVRbzWRKjgoxfO08z7DY4qiFyhCdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2Mwr2H3Dbw8h1SWAVD9nnqkzDuPsgKrh4cGg8Z7jhjqlWOrjmKCaFLEXy22RhreOocggUYMorZr522G4ygw+SlZ5mCgidHghftqT8UYw8aPWdHU+ZD3Ys7E8juC8Ci+7fG1heaTTzaMyPvDNHDtLDNjENuHi9ozrZZt95Xwfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eHObm8UL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcPQpflo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eHObm8UL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcPQpflo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C34F1D0017D;
	Wed, 25 Mar 2026 02:21:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 02:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419688; x=
	1774506088; bh=aVLviy0K/WK+/3bh2DikJ/oc9yDNTKG7yUA21kOUM58=; b=e
	HObm8ULuHrhJycFghXaMzN/5fZsSkY1CqYvpkOKhhT7TIxv0PfEPG+K+uOL4aHsL
	J4xN+joXJ7BywE5Pz1+1T09FNwXBjAEaQXe7sg60kowZWkPDAnK5h1a9qH+Lk/aj
	mLl3ke7XgBidBzsjVWNs4yYIRbZie3BE/PoMZI+CLBtATzr6pEEZ+aQ/GBgGvslE
	8ed0sniXvWDtBl6v7MgI2ubBnQI7L1SxMneMt+oiM7n5O8XCrHp94pJNqGgSrEKt
	IG19/HLrKNn4tPrGnCq3YBmyBAU5zf6s8/O7/VyJ2FDgtQiPgQyzj7L+79bTuG5q
	xXoBhQhw0Cyh4GvSHh5jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419688; x=1774506088; bh=aVLviy0K/WK+/3bh2DikJ/oc9yDN
	TKG7yUA21kOUM58=; b=QcPQpflodnuXAC8p70L2AM63e+Pz/fszpJktmaP0lMa6
	ss4IL0YoYADOX2V9iZ3tK1B2IjkeOzLo4cC8BcpFDdyzNDThTIPwuJWHXe506vs0
	rPDcrO2v//Ig4A9ez+8SVcQs5Q98//e5tkGVoWVQ1xNWu1PHBTmTnU8HQin2gGNR
	VdhBW2pZnnei45K0j2nUStiN95LCmcXJh2slNnTtRh2MNSy2WyUcXaR55tKIVyn6
	RBq30KfgCEpaeWBQujHckETI/orffwsoud15WUqNDpyz2jlv78ZGl999jH/Qkln6
	Zd6WihkKzUGyBEdyObRSihWX2aUb6Bmrwb2SS0ixVA==
X-ME-Sender: <xms:6H7Dabhui7GD3Ro__w3xXJOVdjGvOdhj48aw5Vvsy3rHg3zBeNQrHQ>
    <xme:6H7DaeATC1i6NPXlqzURka2c7TDo-r6p7_mmJNu41yc0oOe9XLGdXGI15tLDHLPY9
    rINdyrqVUKs54_dm1ZdFH0Ph2nM5YwsTq-9CR3lqNi3LXh9oThGTQ>
X-ME-Received: <xmr:6H7DaYusWzf-tnqw88YjJs8tgHEg8IHsDZOD4nzS-CxBZXEnVBgDgzP-le15fCkdNMt6pR-1AVXBhtkVy9zGrPenNrgFTQtohA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:6H7DaTaiC7HgRqxxGDpocQ2hKXqBGl-8TaEp42rz5utCJBuideU1Ow>
    <xmx:6H7DabUSPx1_PyiW8qBJfHNcfk5sqqahPhvxSgvWTKk5KaTy9XiT-w>
    <xmx:6H7DaX6AHfGmTbaTJt4tMlfm2dFEpNAX6782d_0mEamUC63GE-ryUg>
    <xmx:6H7DaWicvb4w_CGWOrQHIti5jwo4hgHTSy5zurQBiwK60QGDLYtrBA>
    <xmx:6H7Dae44lrJMz4opgV1Q7vml7mkMI5ORYBV6THhSE-E96O964647yiQC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 07/11] t7508: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:10 -0700
Message-ID: <20260325062114.2067946-8-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

This test tries to unconditionally clear a few configuration
variables, but "git config --unset VAR" fails if VAR is not set.
Work it around by telling the shell that failures from them are OK.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7508-status.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a5e21bf8bf..1167b835a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -773,8 +773,8 @@ test_expect_success TTY 'status --porcelain ignores color.status' '
 '
 
 # recover unconditionally from color tests
-git config --unset color.status
-git config --unset color.ui
+git config --unset color.status || :
+git config --unset color.ui || :
 
 test_expect_success 'status --porcelain respects -b' '
 
-- 
2.53.0-886-g529cbd14ff

