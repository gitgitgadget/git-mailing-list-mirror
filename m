Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF12281525
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779334; cv=none; b=rRHJ9+FbNkRkPKsFlxBWCOqDZRLCQUcVojG1pQ2q4ftKKXENtpjIL6ha3nnqlBtvBjSBb1cCNZ8gwRdkPxb1QFAEcsXOqjsMHXkAENN4y7EJJiku6Y9xKym2rPtgW7Co6AjBJBLzja6DkYlazq9JRCA9gojNiIvZLL2shki2+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779334; c=relaxed/simple;
	bh=UOevxosB7FYM/2p3KVNAc3dCU27ymCmNwVGobZdbAII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AL5JMSJ6AHIHhik+OqD48NnGFVmbTCirYAcuEtocJAsldDcUlS/covHHUf3BE+F2ekL1xute+ZN7VWlyNb/Aof/J3a2DNCEXoISdW2UUpPlLfrrr3MTvQxP3mvAHQ3qHuGMyuvOyO/KDV8YjBNfRVs4pDyzFaxIMRkpwsonuc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e0+e9ou0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyuK00Y4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e0+e9ou0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyuK00Y4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 770F71D00455;
	Tue, 29 Jul 2025 04:55:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Jul 2025 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779331;
	 x=1753865731; bh=k+kLS1dTtiql5+f3Cdd++qsjBMIvGJkJZkgybH4Ccqo=; b=
	e0+e9ou0G7VAgLmY06a61cIIIPwSVoCDwYfjwS1xEtWLT7mOkQOaRGswphUHIGil
	JMGyCY61hRo8mpYFSkV2dQ/LtomsXsQw/kHnfkn+OUdQcZZeqdau5odwZScN3E0C
	AbSzcn4xx20pee0wxNqy7dnYXXcKuYofwjueQ4qNMNi075FHLf5d1mAlBsIs5IE1
	Uvhso67CvhQIUvdfO3nxDz3G/bRzgHVRIN9lPPb6LBrIKtFgZq1C0AXvMXaGZebr
	LbbVTfSgu6xZxzHp5a2Mu7b3GAqF1BISv53KNZ5WVp+aMcQUGE40XXkIkE+v7wix
	t643FMAJo/OxUP223DhTLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779331; x=
	1753865731; bh=k+kLS1dTtiql5+f3Cdd++qsjBMIvGJkJZkgybH4Ccqo=; b=n
	yuK00Y41hgniL3Z2F00JNxvoVFQsTYEi4nr6bT3fBO64oDgjT/Z9cnTxPCWwFkLy
	W+XlUEncgOsdXdhnZwX3Rg1XpB2TpeDgKJ7REcsvHkygSOtE6PngEtXzSbNk016f
	6KGF+Z//dqZC6IcVcZGFKUAq9iD5OiyxXIaJS6w+buuMxWRYuWFdTZcJecMeg3IP
	eHtRRnxR63gzAItbLwergh7vNKEXUypJmVJA7hTTQP7r6ffYcGxH+oBLIvYu6wZ9
	cayZyrRLD1x/mDMkV1HNLrBRev6lAHfGkKjgVveYz65fP/i4bGPbtqtpHzWZ6D2u
	JlpMSh9K5f36yXqAC4xAQ==
X-ME-Sender: <xms:g4yIaHZ5ty8Xq3ibcS-29qR4Ny3yXYMarL962n9VuTVv5zYJrjvd3w>
    <xme:g4yIaDSQJPwx-0sk4Amgh3ETfm1Jw80QcQYmcSPAebd9jOli-zgQSnpO29sPqYkGs
    GD-aJCNFyEtTw7CrQ>
X-ME-Received: <xmr:g4yIaJvTnErS1125q-oOlZ6YYI8O0j_Y78fl9oyhg3RZ9tHX9K4mxNLWDgXzBH0Wzj8_mKAc25z1NQFo4QUmAIHBzkJ9DTaJdcfTnWIr9NI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:g4yIaNGKR6nYUZcJjKOEdmDLhT-NsQGbzc2bUNec_ESjjoZTnhJ2yQ>
    <xmx:g4yIaCyXe6IDAO6RhSWWycGivfU2FJclfze0cd3e0JVCU5vXGyfnJw>
    <xmx:g4yIaP3hB4Y6XcAvBdoqVFKL_dJgoJPFAJ68olW6fniCkNrhAtV-mw>
    <xmx:g4yIaKptbFlrFdVtokgF3DA-bWy91UXx4aaPW0mVLlC1hFb29krpFg>
    <xmx:g4yIaIOPpd7oEVhbfPqj68MGn8rdDGBip-M8AYyWGuHbCYZ4Cya4PUNI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b6e867c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:19 +0200
Subject: [PATCH v3 1/9] Documentation/git-reflog: convert to use synopsis
 type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-1-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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
2.50.1.619.g074bbf1d35.dirty

