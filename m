Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D92289831
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426717; cv=none; b=eWlZjlBISOQiy9/i5FyYJH6T3fxO/taj89343ue+paE4lvO94co7D7r/dl4I3yl/p/wqrUxK1NEWd4+r+J257o353/AP8a4jCxa3IFRCFbqLIca7mrSDIbKr8oqds/w4+hHshjpfewCoVZSIAgURW2axJX97AjgZhgHcLfdO0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426717; c=relaxed/simple;
	bh=YyLXJE1EtzeBpkrMJmsh0JfBu8sb3bSJuuB+2peIMfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9KQVy/7NQEtYrwufVBomBhkJTMxjpPZeaRTcBRlC4NsZbhPwBwbP/w0I1Y3KbRRcHYJ6XSyVBxjMvuufqhdMo4vweR5jWUsDuhBo55JI7iK/ykI/CAederRRt04ldUW0ooLaKDbi2JGsnAArbtUfwH3033E9QD2oR1zLdWOEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YUiMgDkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJ515Cg+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YUiMgDkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJ515Cg+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DD69140012B;
	Fri, 25 Jul 2025 02:58:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 25 Jul 2025 02:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426714;
	 x=1753513114; bh=64uJnVpjZWVrQbfgTH0fE5vvBdx7dQQl+EziDGBOUzk=; b=
	YUiMgDkp0BcXoRUrMHW2RIias4OtMtEP9CJofxKvPT80NEl6f+k8FtHvAVB83HQa
	tfCXRIzsL90AFOicZHdBO+f+lYtCya0xcjwXdstO6wH8yedcDjvzNtXhIPfjRLEP
	6I/asyORWcTdETvTx/e0s4v//UD4lCbqAZUeg0bGorMzf0l85gvt9mYe0isV4U/P
	s72QNAojaim8a4SmKQSwy4vSRofbFjzoyna/Y19busN6XHF2JPmGU8y8gjQlZ7/m
	a5ri155iOmHvwhg6faxg3Akopl/dahVE9NwPEueteEKCc+orJRv0T8Ehpn14Kgfd
	/7pH8s4bNfmlFKTg6bVN7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426714; x=
	1753513114; bh=64uJnVpjZWVrQbfgTH0fE5vvBdx7dQQl+EziDGBOUzk=; b=R
	J515Cg+mYAWwsvO0N1Px41PCQdiJKv0nYdxEKuEY4dCXO1IqocpcOJ2GwBCTgKeA
	fn+jEtMjAxF99e97TbuQyju9l44Aeubqky5AV64GUaOSPfPpC1LovqKV3TyTanX1
	+m7cVQompDwVD466kFy4AwNC7AgX5+L65JjXDfBmX+ktiwQWW8iPZjR+BStWvUPM
	Bm3eR0D0X99DWBnSilIFxrb0B499ZW7Fh1CTnBhkC/TpEUtVTLLYoWGp2ypPRkyg
	ZfnJ1P8ivaeCfjOzZEX12/PM67rLsnDPc0zwBacdSITBzvFBvznJey6QMKXEenCC
	o5mtj3eoE2McUm2md64kg==
X-ME-Sender: <xms:GSuDaNZGh8w2U70-fyMtbl0XyX3d-4pEXXQEzrery4ObtGs6wHvn4g>
    <xme:GSuDaM3HSMmqu3LCNiQ3UR6K_BIcbsvYx6nfWYk-uYAxSIO3Q5PPF1cIxQLpNbYZJ
    EDxczb_8EB94wCZOA>
X-ME-Received: <xmr:GSuDaAawaPLSEs3gnqy77ANOVO1GKsq8RheNdrMSIRTUPTUIs35t72vqUkimhjLqLZ5avX4rYkhrIJRp5tpBa02FppmCdEfJznmsjxW-i_IZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GSuDaMIltiRk_WyojPvR9HUGK5oPnk12uQb3tYBBG2KxiBsjkffbvw>
    <xmx:GSuDaHF-guF-M44uNzqxLDkWj4fkWyb0S1GzJDT_4MuXTS_dI_6gmQ>
    <xmx:GSuDaLvSXd5PITIfsFtEgkLCBkF5G9_sj-8nE0pOogvbYavSBU3HXg>
    <xmx:GSuDaOu_eGZbj4dGv85F4ZzKeL-ol5t3Qfqj11lo4xs_nR8MMTOi8g>
    <xmx:GiuDaN60fF4QRsVFA_qp-5y3fY3VjFNtuMPq8jo1Ax_SxaP9m_S0zSTV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5781242 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Jul 2025 08:58:23 +0200
Subject: [PATCH v2 1/8] Documentation/git-reflog: convert to use synopsis
 type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-pks-reflog-append-v2-1-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
In-Reply-To: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
have introduced a new synopsis type that simplifies the rules for
typesetting a command's synopsis. Convert the git-reflog(1)
documentation to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 412f06b8fec..707a9b39edb 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -8,16 +8,16 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' [show] [<log-options>] [<ref>]
-'git reflog list'
-'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
+[synopsis]
+git reflog [show] [<log-options>] [<ref>]
+git reflog list
+git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
-'git reflog delete' [--rewrite] [--updateref]
+git reflog delete [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
-'git reflog drop' [--all [--single-worktree] | <refs>...]
-'git reflog exists' <ref>
+git reflog drop [--all [--single-worktree] | <refs>...]
+git reflog exists <ref>
 
 DESCRIPTION
 -----------

-- 
2.50.1.565.gc32cd1483b.dirty

