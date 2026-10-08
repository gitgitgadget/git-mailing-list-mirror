Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE14FECF5
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487674; cv=none; b=sF+bT5QbQn+DbY22NZt+z7weMBrxvB7vcbZ8YWKEDr0QmEZrU62PH/CiS1lcKL2GmV4KTiSTJYPUe3zw84Qcavw874GbMCa94kxYCm6PZ8HNst4CaykOUBlLKqniSyp/A+M08uH3uLu4EY+Xw7KTdBjbFUTT+9wI1+YlYEKwQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487674; c=relaxed/simple;
	bh=17RyMVodp3vVB0UzGRjhYbvPy891nmbR4z7EoLCnlMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nievihn7beuV9uxFWNtuwEry/qr2esIi4Jwt5/aC43esZpuYfN0XBxtXGijuhTbOvu2IW9xeYk+XytIkOaVh0cM5XTzhL8JATK/TqNVmKDrLuF6RkTooGXS/XVScF51CRWhsQQiMPzBjEADJ79KW8fiAXBRsI4Dmxjh3lFOF2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qKIb2K0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbGwVKT4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qKIb2K0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbGwVKT4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 411BEEC031C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:27:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 08 Oct 2026 15:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791487670;
	 x=1791574070; bh=/lUBYNaUls3tWpeDeU6rEKETmvsfuUmzdppA2xjoR4I=; b=
	qKIb2K0exND2tvG+lEiB6cx+EhcxxJ0VK+GfK7wmcvtVfYY/KjSlS/z0mXRJ8qEw
	8NKeaMjBRvQGlp8bSkwG2DSRiwnOf0KbV3626WXtiJ/CynVKaJaypNcc91t/Yrqj
	GnT6Sr4Yul+51cX805bbu/Ax2RdT7cn8fgsAhwiIYhKp0ovDWyAZy0vlgeNbo/yT
	Dwi/pSsLbShx2gwAHpm2zJLyEarIYyxLmnurBXyP0tk+znu9XFwCLGvvs4j3ecJj
	DiUuOtVoCLlUQVtfWZJa9ATYJtbh5ldpqL0TZ2ZCduz5/pzM3GBl99WsVrgHR5GZ
	wZUuzX507S1tJYvombHyow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791487670; x=
	1791574070; bh=/lUBYNaUls3tWpeDeU6rEKETmvsfuUmzdppA2xjoR4I=; b=R
	bGwVKT4EXhj5oXTvjCTOunFBuqWru0kgUuW7WCQk7biZTS9R3wmwZN8bLsuQGR4/
	a1GAWi7IT9rOvwrWRJkWkWizaQGeklV1TKl596OpYUvj2wp/uqMMlRT+2cYCrcU9
	Cohti+FoUlhJHSzB89NY6TvLBSCga9wCkMwYrnVkEj1982t2BvwBTlCzdN2sTYC/
	3D20M/NDF3gsYGZyfVrS7w6Dco0Yio8g3yoc4SgTgUb2QojAoheKid0gKHDLU0jP
	fhnx5IxjWyqVNrTwDlg6IOmviZGwOhZCRuCntACygNh41WdG+QwGDHh/WTfTe3Hr
	gg/kQQKQfcs0z2hGr2jXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487670; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PSQ2JbHaYtY1MMW5RTMr6MDe7Q54FWVdRX28ludqRYM04Zn
	6IawWP3LxmUZ4aAs5dZN9ensK8WvlwmL+ClAdEtaE5/24pJzDD0sZhuTtLeEwlfa
	KD53iHhNbdgjumFYJsot2LDjwYKJZeMK9EfysueLZ456GTmyHi+OzWEqXNkrdA6I
	DM00krahFC2sHrAQ1TcLdOli8UNa23au5zv7J/VWhgr+qfLCPcCYP5IpaH1/h/QE
	wI/Wied70cbCyZBhgfnnGeidmylS1xukDY15rwyN67KLy38E5AXLZUKmPPkxNWLl
	ncAxI85oX41CNsoI0IZTxrlEBfujnKQN1fWq+rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:t+gsbLgDz6mpXbtmkIAuDBefT1fzsfwiqv7QHzUCA0g=:17RyMVodp3vVB0UzGRjhYbvPy891nmbR4z7EoLCnlMY=;
X-ME-Sender: <xms:tu7HakoJ4eM2199e8ErZpfe3U3wx06O_QdtcXlmoupwmTmt4vjiikDM>
    <xme:tu7HahoxkFTqwQ_m-e-eokOnVOlpVoc4Kxc9p_hmVYEfB_AQp2ffKoy8tzuv_5DQo
    nCApQLoLAFoCC2fASpPAVb6e0bS81qasu3alO0u_MRxiik1QK_DbTU>
X-ME-Received: <xmr:tu7HauNRZMsthHGB-QSM54bZLmHRHsv6f8ic-76nLP22zbLkYH4LVzzNPWBv2UxfP-GUetR_s7hA63tLCV4uNQfLDBiWXOGxh5qCXZ2DFv_qlOvkBr8WLgM>
X-ME-Proxy-Cause: dmFkZTEvv38PtZZ9Fxa2WReRxaNM2gsaYiKb3sw13lpp0+vazwRIBHekVHur5/7bKfX7MR
    6mSunsuBOUyCnIm3PpWxjczHBptzu49b8l8FE6nl+ZKGD0ajL92coWo25wR2rAFDYKOoZe
    PdJYuuMEc0dxb4hYl1d8+U0hgJSja6mj3AAFt/hkTY8OYuI+QeyzM81lL2y3jJwo1oGHT/
    8C5KhPqc046snbV6nWZlxrFxQWXfm2R0K5JhqZq/c8GWNRkaU7kKR61icoQe5T9YR5Qf2F
    7SRIYz3AbUtgPaQvCOYGBmVD5sYMXYYaQBE9JAmAPfuT99VZZox9BzkG/0wz55twgSUKQp
    sD6XcxItwcXe4YgnjZM6enUZFHv1DQ1UCL2NcGnd6i9D3Z9KH2B9bM4+meWxIsLtKWGyKo
    3VRULsEFrbvLh0Z0nFcVG1CegDsfykzp2IY0JCHkmdBVaFFj0uKpR9uVT7HgslePE611mH
    qc9Jm56Nl9vwaUQbWlA6Qpn+myLLr2ivKrhwiSCcxRo5hfxIr94bKvnV2CY1/wjcXVZPyK
    oVTuQerc47LbIXkHz7qKqGef+yExB06Zi8R8W1A+ZrwiRcX9a5QuvqUd4ca5bo0QnmKBUi
    r7eZWM1ICGQAbACpMGY1dXp2ZkW6++xuVXv2w5BQYbnNF2Sozmgu77ynkMBA
X-ME-Proxy: <xmx:tu7HaqzdrOv_19Xreqwr6RdAk_-046cevVzvaZiYBYpjFxG7Jh57OA>
    <xmx:tu7HavsflNftR03_XE7VaQIr3CZxB8krh8rEC6yYp2IpwF-YTan4vA>
    <xmx:tu7Har5tx1IH36VVy0jit3HMgryh2a_HGjWbDw49YizSXHtfIiRVNQ>
    <xmx:tu7HamSBleLhW_UWKiLxBDIz05il2LKoAVkEJgfcA3BOAx7vrAVCvw>
    <xmx:tu7Has1z996SlADGSinxghuA7-LJtPxkl_HBCeuGrN41QDwIs0VQtlJ5>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:27:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/5] doc: BreakingChanges: transform to a manpage
Date: Thu,  8 Oct 2026 21:27:16 +0200
Message-ID: <V2_BrCh_become_manpage.dc5@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The breaking changes document is not a regular Git documentation page.
That means that you cannot navigate to the doc with git(1), i.e. with:

    git help BreakingChanges

You instead have to download the Git project source. Or go to
git-scm.com.[1] Then you get this disclaimer:[2]

    This information is specific to the Git project

    Please note that this information is only relevant to you if you
    plan on contributing to the Git project itself. It is in no shape or
    form required reading for regular Git users.

But this document is relevant to *all* Git users. Everyone should have
as easy access to it as the other doc and guide pages.

To that end, let’s move the text to a new manpage
gitbreaking-changes(7) in two steps:

1. Transform this document without renaming it (this step)
2. Rename it to gitbreaking-changes(7). But resurrect BreakingChanges in
   order to add a line linking to the new manpage (We wouldn’t want to
   break any readers)

Just do the minimal changes for the new format. Also demote the first
section to the second level, i.e. make “Introduction” the same level
as “Procedure’.

Step two is for the next commit.

† 1: https://git-scm.com/docs/BreakingChanges.html
† 2: Which I first mentioned in 098230f7 (you-still-use-that??: help the
     user help themselves, 2025-09-17), footnote #1.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/BreakingChanges.adoc | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359c..c6b974b6d8c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -1,4 +1,19 @@
-= Upcoming breaking changes
+gitbreaking-changes(7)
+======================
+
+NAME
+----
+gitbreaking-changes - Breaking changes for upcoming Git 3.0
+
+SYNOPSIS
+--------
+*
+
+DESCRIPTION
+-----------
+*
+
+== Introduction: Upcoming breaking changes
 
 The Git project aims to ensure backwards compatibility to the best extent
 possible. Minor releases will not break backwards compatibility unless there is
@@ -357,3 +372,7 @@ almost no users of any of the commands anymore.
 Cf. <xmqqttjazwwa.fsf@gitster.g>,
 <xmqqleeubork.fsf@gitster.g>,
 <112b6568912a6de6672bf5592c3a718e@manjaro.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.55.0.793.gc667de3f2c5

