Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A73F787C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411392; cv=none; b=tsDxpnm2IEIboVqNMqR8WuyycLmi8fkVoq4E8WkOf+3Rm9surh8jD7SktFBXIO0B7yMYAbFBKSEhlBnjtdI/Krw300huIpP12gfRBAslaBzytH5GRM1T+gvONqUzB3338g9SwNQ6jpDIs8JWWmTeUgi9pCu72tlB/gMcPBWj73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411392; c=relaxed/simple;
	bh=Ugbnu4T6Wy8GGmz1qVhJq3hMxuri1bZx4pBFgoQa6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuwMaHlPcsZXNGuozvbU76ohZorfIOBskQGr6G46o+c1FGK2Sr2Cj1HIX891b1qbCZrUSHd61QitaN6y89HGp7Jr2x1AAVDAXHU+NGKoLh4/Z9DOADwSehXi2uS6Q7cljLi7QG/c5GnsoqdqlvzNedi+9K2Facip2e3hGTURC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PKVjBYyC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJCHqxCT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PKVjBYyC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJCHqxCT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 260AE7A0189;
	Tue,  2 Jun 2026 10:43:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 10:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780411390; x=
	1780497790; bh=mMRjxBcRym6NetjF72RaobcxCO8IWR0xPQtC0Cgvpio=; b=P
	KVjBYyCJiWkvG+0ZLb1Jcj6PqdClIz7aTVTmktHMlulaIB8jf/sYTjcJ8ssQPpUF
	llpttRYHdtcxdxZ7kR9ZZWklIEk35TipNAoh6ym2OkpE0p8dPnRN/+h+jFk1X+eP
	E5+S8uLIxLi+IvscUaLforRvEZAVlTdHSz2h2HeEnAoDvCFORNafKfnkUTRLGyJf
	JHYsn0ZxNRuibKzLTVCfP12UNBPEd941r6O4eT8WeYYxybXzLC9eijhLOSjRwBKQ
	FUxfej+r2WFzkYGRaa7UX4l3tUmkkJKJ+/14eTbUmP6ch0/FutspxnD34CAy+PM8
	cS8qsyMWPiz+sN/gouqAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780411390; x=1780497790; bh=m
	MRjxBcRym6NetjF72RaobcxCO8IWR0xPQtC0Cgvpio=; b=NJCHqxCTCw+rdnxpV
	X1bfTHjSvmf0r4wLuqpXh4MEGoop9VV7rUjPoP+sb+0lkS9VrEJcW/i+DrjsS6O2
	e2dzTHFms5/N4QH8hnS7qwkPpbd4wz6nuOYXS570TMHicE+G1yR1g4bSm9hYRGnM
	er6GdP4/8ws7erivHOwHykDcZO6MOuhsJ71Fy9S6iLuNBfO/gNZOW1fFu0zd5hBG
	K/bUdiZ1pkf7ppn46GwnH3ZGjShPPMrirlJoFSRzimlGNtTWfXQwQOAJZJatU+Ra
	JcA1c1NlQih6Kx7q/kTr/ViBSeqSACGwcESN1JFcPaJiv2vyuLCUVVbAzI3+qZpl
	dpQXQ==
X-ME-Sender: <xms:_eseani_vaRGaGq7NiDlhvdp0tcMEzSYIsU-eO6w8VMczTV6A0jLsA>
    <xme:_esearAWn5Tw_LS_gaq5hxXaQBc3nIdXi4C-VVlpEuRpDaK4NaEXePV_KPaK2O6tW
    1QWqq73Tm3HHtoNhrfxE031bFJs5viMbIBg60KqFtYgvtnBv7pIEA>
X-ME-Received: <xmr:_eseasHWSC4hUOIBkxkq9Iui0VyHFWL1rEWHN1JWF35BCTE5D3qo0rJHoGFEVtkwaZjloHTqs6fDbJMMiFDxTm-1cBKVreCv9nfg>
X-ME-Proxy-Cause: dmFkZTFCQTx7T5KJLHvVUVUwImJiMQuCGl5MNtE7icRX/SZg1Bj+9HCWvTcznpdadd/Fk9
    Erez+bQ5b2Lyy6tETx3JL+9w3oOEihwjatmnmyRG6/8smVRhsbJ1it3/DvBuN2Sbfnxnk3
    b3SyMF/eS8zVbXcfdBIs8B6KRz4gJeiDhhWWxajsnS7liE1621iyIn41pCPykRdLau5asR
    cg0sao8tR0OsJ8Mg9PkMUb5/9bzzp/5+TY7psVZXCiSucdc6qbIC8fiu9UwSMQNyWuxRC5
    Xwckpz5zu9Rn7Nxk65mY2RglqOMHzY+d1qd5N4t+bO40tFwixzow8257TIcu/hcFq9T3Fz
    eqZquLFibgXEQ/Jqpwbq7W/eRLLRbkEizZrOYt3eT6nU8ZmQg4G7mlZyRtJno/6Ji7oNDz
    3OMBQ13QeHKWH5YKtMpRhB4705ld6kchDCy/zaRka+rjAhzvwnvLsT9E3GgBGaM+uN9LxP
    OjFfq0kqYZUwuZDjVcBrVuuqmNFAu/pHYx7Egvw/Sbfo7l1RFBK4jBcBtfcFWxcfdjZsuo
    lq1BaHd9UCyDAOQ9JmP6WQJydIuMGt9c7Zl/ne3D24nTXdNatFtcWPJgdO5TxNABIt4Fr7
    AYX5cXJT4TZ7GNvl2yk/sZRBvvppaEQNK7UcfbVNV8joLLTboHD11DokOmRg
X-ME-Proxy: <xmx:_eseajLkAFdJWHGK2BTfxZfvNT6dpDI-epx_vzLlcuLv43gNJCwhvA>
    <xmx:_eseaglLvz_TwtrXyBQ7LiyeDH-W6AYufWTnYSSHnrg3_fFsmDE6dg>
    <xmx:_esearRWv0rsc71XzxpGvU62JU-ok0kqRPusGmmU3zZ4monfLLBiqA>
    <xmx:_eseaiK2OEkRDnt18hF9V33kVLU9NmbtAIlIRcTJlACoAT_zscLCrg>
    <xmx:_useajmYcvrt0km97UilXeh6x4wP0SWH4BHkMTHGtCTFPupkWimyZbC9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:43:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 2/2] SubmittingPatches: describe cover letter
Date: Tue,  2 Jun 2026 23:43:04 +0900
Message-ID: <20260602144304.3341000-3-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-591-g9032776dcc
In-Reply-To: <20260602144304.3341000-1-gitster@pobox.com>
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602144304.3341000-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We talk about how a commit log message should look like, but do not
give advice on writing the cover letter to sell a series to the
widest possible audience.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index dec8aea4cb..df9f722bfe 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -472,6 +472,30 @@ highlighted above.
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
+[[cover-letter]]
+=== Cover Letter
+
+The purpose of your cover letter is to sell your changes, explain what
+they are about, and get your target audience interested enough to read
+the patches.
+
+. Every code change comes with risk of regression and maintenance cost.
+  The cover letter should clearly communicate why the value of your
+  proposed change is worth applying. You can also describe how the risk
+  is reduced by the design choices you made while writing the patches.
+
+. Make sure your target audience can understand what the patches are
+  about and why they are needed without prior context.
+
+. For a second or subsequent iteration of the same topic, make sure
+  people who missed the earlier discussion can still understand what
+  the patches are about, so they can judge if the topic is worth their
+  time to read and comment on.
+
+. To help those who are familiar with earlier iterations, give a
+  summary of changes since the previous rounds.
+
+
 [[ai]]
 === Use of Artificial Intelligence (AI)
 
-- 
2.54.0-591-g9032776dcc

