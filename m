Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834A1DF75B
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488873; cv=none; b=ceVPeCO7cPthCp4bdfMm+0fmo6rCC5RllgMIB6gOpEYfbdXhDmIAccb8KdDG4cPCFsec40V2X5iMT1Hf6rbHiTk3z72ckZszoydyd2aVZcyapWdJ222wrcQb6ZAo/IrJgXERpoK+QqGUeA0I/34sBszSnUwozBtG5L2XiHzB0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488873; c=relaxed/simple;
	bh=00ofKhb4XXpI79PgThD0mMBGvFlEG5ndoNC0ZJlUTpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1jtmHfe8ohNJ2pAGwYTk33T0wMGs3dIP3kk7MoiBJGxA+9vKEwSmJ42e9KcaOFWYNhTVfS6+oEoz+ausJNO+arLeL3CKC76gdkT6Jjb8G68CsF+ouSUo7+Xvl6Wxiz+ri7canTG9GM4/wSxeaDiq1MM99b9OXpgtMczfFrqF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T3GTP3Yd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z2V2hvgu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T3GTP3Yd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2V2hvgu"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B436EC016F;
	Fri, 31 Jul 2026 05:07:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 31 Jul 2026 05:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785488871; x=
	1785575271; bh=rCKRs1Bgt9hWpxARAxWStMSXlqZeoxGduzQViNc12Qw=; b=T
	3GTP3YdLGb+H870qx7FiLUjuowlqnsxayEsCpztGcs63dbhwP0TCL9Ge5jg8sbPO
	FkmpFwb1iXaLRK5+fUZtEsOQipCZ0NvqeKCiZJgzmk+PbBykOqEBsHtz12jwK8Qr
	/K/sV6njKez4TSf4PEBYLxmhR2NGvk83qY8BrRl0++6NSbhkhXsiQNmXmtSHGNNS
	/3TGFy9I3qYCcf/hW+Yl+Ij53jdd2/8s8Ly2y9h9WEQsOJp2+D4ZFOWA/UmSTydR
	hTQwc/aRm3DrxLpTTmVDvD/J+4PPpaTVFQfo9vtZOu5NzsYamqL/OFSe5ppJ/Qmq
	cKfPX7Nw4B+7qKW5kIneg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785488871; x=1785575271; bh=r
	CKRs1Bgt9hWpxARAxWStMSXlqZeoxGduzQViNc12Qw=; b=Z2V2hvgushB51PSML
	0oWz1s1B7FtRIoZNQB4YCVnRlvENaLjC57UNffh0o25JH04sa73m9RH1doMTXAj/
	zqeo6Nuubq9QPt40bNwg2uN2lUVprjUv40GF2P1jjwLGyNMf5wjJPtLBfhYmsRxP
	l+lykA6LGmz+/PF1ihy1Rdr41QcSox3A/AS+J/tZ92gvapI+Cum3cVZmchHUuii8
	eYUnAzOEMt1QzoY/pN2+WW+1Rux5M2WDuQpjZKyn30lNfSZU3Z7qRM/BRYr76vIy
	VlvAWjUmQd1YRaeVNmAvhItfLzkEo8l7JberSxmheZO7dUTkPIQ9megMmorfmBjw
	A0QqQ==
X-ME-Sender: <xms:52VsasKziKNJdDQwG8n74D_FS_-paQOOIsMWPc09H7GnKtQtsv0yGdk>
    <xme:52VsajKWu8i-BxNI2B_4TeEOmfIDAPS6psj4a2TYR9T36znRr7xKoAe1_w4fD8HU9
    0kyZCDjNadlsUJmJmsjywOu2nRWz8M9JeuuhzxkBiH1Pn98c7wlVA>
X-ME-Received: <xmr:52Vsahvt0UBO5E0OAXE3pXYY6fhLWEs8R41tJvfjScD5iEvXroRWsQVtFEAZDlPDrMbgfgGfVi_J_r98EVfn26Ukett7sknJFSlFxhGbQcr0xFHNIu_Eq50>
X-ME-Proxy-Cause: dmFkZTEBaRpBuQnM40z3wTXY3q6S3+vdrSyPuJvqqYUgta/0Ry+B1iMKnFkGKgid5c7SeA
    /MMKcHe4S7LJzU/7AyBsSs3UQBbZ3cNbksI7+D//yKg8c87WlckoF6SYX4AOd2eyhtTTzJ
    MCxlH5d5WpU1Y10+ASbwyF30J3svFq2G8WGdOCynFQ22b03ZU4rYAXvEyh2VSxYzWDbmgD
    i6v+/x5k3bK5CQQXk1Kxcdw1Ojxaf1cn8n5ku8J700hlR7SyS7rcP0Nsj4P25h/jpf5TrP
    Kr5jPjpdimnJfETb6zZrTgcAMNb9JADLCMxh8qafPeX67inKSlqvbxH4CZS+3qtfiUFpIs
    1ILU0bWA3nwnD1aDa8yXcjprBOZZR5OM7Hop2smw1LBjaUZTzewuW69nfS0PTL1QmualEK
    7qJ06yDygX06JQnfp9KHZgDgWKKc4SAZegrEj5iXvUp1cbyZ6zV43N2YUcdx0h4eiPUgjM
    T4t2oMRh+nn9mYCLGBJzsZ0VzQiCn7U5H1DHqUszBgftxAhF4lF20ZD8CpfKdY/ZOWtm7Y
    aTQ0opYcB2gJJl15I9zJMHDpPmynJWaWIabZDFErKNhJGxxUK5AlFoUvqel+0HtM4UZneg
    CQyC854bnrmZ3WC3G+cEp+/8GHYRxfxLGDj7OfdC18jlJBYW8AZC90xNeD0A
X-ME-Proxy: <xmx:52VsaoREbAxzrE7zt93o6TOdPoKL71qpxgUseH2ZNKHGixm8Q933pA>
    <xmx:52VsavP5mN6L4rLylYFkrBZiEgepPdOpKzbULq_AthtZ_ZwtnB4S6Q>
    <xmx:52VsalYMTawl9suVxziBfX_WVuxSMyd1dgI7ezSGEoLYPKbaA5a3vA>
    <xmx:52VsahyYFhEBbgSaywVqvIV6aMCu04xLAzdXrnXboGKaVhiVR--j6A>
    <xmx:52VsahNjO6inWRMv0C0tJXpcjAu5uNIK7kxyVliUXi9GDpkfxhGt4Lt1>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 05:07:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] doc: refs: linkgit to git-maintenance(1)
Date: Fri, 31 Jul 2026 11:07:03 +0200
Message-ID: <linkgit_maintenance.b0b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_git_ref_migration_warning.b09@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-refs.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 98828041c23..1ec26be0b4f 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -46,7 +46,7 @@ The ref format migration has several known limitations in its current form:
   ongoing migration. Concurrent writes can lead to an inconsistent migrated
   state. Users are expected to block writes on a higher level. If your
   repository is registered for scheduled maintenance, it is recommended to
-  unregister it first with git-maintenance(1).
+  unregister it first with linkgit:git-maintenance[1].
 
 These limitations may eventually be lifted.
 --
-- 
2.54.0.22.g9e26862b904

