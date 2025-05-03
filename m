Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C537D528
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233899; cv=none; b=tznYhrAxnswe9pRIppVNLD2kZR1AOkmBWR3u4J6MsHikGsEjww4R5VMKd3CTIUPrE4ZYYVQalQ8Me3sl3OmyBG0Pf7lJg0m8fP2ZeEB2oXM6SPh/NRbXP1WjVxQFxoHc3XJNV1m0hceWZtqDZRwhNXancRtNHpLNBSqWpuorWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233899; c=relaxed/simple;
	bh=i6ceWn692LWMR5hpHAXB14Tvf/PcUxHcrxztYWvd6Zk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SULb6Xkp8G6OpbwT992QTpBB5rGIP4fS43e7NnhSHHYfT3XYq2Yf3G8oUmH+/ioOV9V2RLF6TDmt1xrFeobHk2aliWFLTOd5GDnxWoleSEjg2KCBJNt02ikMCYppuu7aDKc9w+uyhoSAIStWMqp0jGR74i2oZxmfD7eJeSnLHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BN9MeeIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uNdnJ9Gq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BN9MeeIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uNdnJ9Gq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E87E1380517;
	Fri,  2 May 2025 20:58:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 May 2025 20:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233896; x=
	1746320296; bh=HO/SNRSj5F/yUZqcLYPQpgkwdXkq0eztAJWugRZMtGA=; b=B
	N9MeeIG2GkZ1u8uOdDKc4gpX0Xq95V4oh6QKded8+Sk6O3nRmpmUhSASvQba6O8m
	mZ+Vt1R947Gp+q0RawCDAtXYNo3K0cbIPIVZDepYMFFP1rTc6NQynP5dDVMeQzr+
	sZvc5DZIM6qInk1KmCTSgzW5Wt98EmYWjxFStwzll026x/jqoI07dJTvRjZ6+ma8
	0y9GAu9pcd57Row/qzn0bdEzvqU0ttr99I1yZya7Ku1vGy1x3ExX1WVige3+JShe
	73F/R2ElA7bu5H1dtrbVYagLgHAC75GqyRnWMq5sc0iyUm/vyAfKetHD1Ttf4Eli
	WXSjYlLDLG+jO0gflGSdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233896; x=1746320296; bh=HO/SNRSj5F/yUZqcLYPQpgkwdXkq
	0eztAJWugRZMtGA=; b=uNdnJ9GqGZeCPSQPqM9yoA5gvadERbdJ3yphNOYW4eoe
	D41eMiHJm+HJE9wJYdyNZ/afAWwebasAoYr9kaxTHFAVjL0D+rfHj6ZlG0PbotkG
	Sd4mSX7ro/Jx6HiUz0zfxKNbTKla4Lk9CHgBNA/5XwHexj/nzcGZZH2D2mSCsIZT
	gx2iIAtAitB9l8WP23ezaw1g4zfr6Rv/a7R6WJuerbO1gD1CngNQJiLwsLQaJmO2
	IZTdHXHQgAUeQ5hgiGmTkqhzg3ogm11C3+clGrYNrSg4WKji1gruUvD19TLKY/Pl
	2aQurNJek4meQqg4Tz5QkbxQV+9T2OYiVXbzuPCkZQ==
X-ME-Sender: <xms:KGoVaMltlsl0oVwKyW9FRf_H8aLwjE_3sk3fVgMGMbFUqvRdWqUOnA>
    <xme:KGoVaL1w8cZcRSJaJOFIlnC4bn1I43rBS20Ni7eSDyaWsZfLPjnoUTQB_-K74wXXq
    IkyFyC2Zyqnc4q41g>
X-ME-Received: <xmr:KGoVaKoms2vHK1IWPsTkVbbZ5hspXtKeeZyPFwidb3NTJHRVkZyvyqvWuZLCBT1v8cRU3-26_EUTyL5hd0H_HLPJeC_w6PZfm1iI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KGoVaImenyXqI3KPRJkr7CBWN6P6urqwiHs6sWFedXVA9MZwh8fErg>
    <xmx:KGoVaK1a9Z3nIaHHANmnkEKASTXoHnHeDPvtPb-D3jKdIlEGMSdriQ>
    <xmx:KGoVaPulUc9DEH--1PhvprCYlFJos4HcDwWiJR_auMx-6wxBW-1PaA>
    <xmx:KGoVaGW_5MD1x9OEgRPzq_AXJCQWc6iNHoToiQr9ReFO1Ho7zyJ9Gw>
    <xmx:KGoVaIkgax76l0awnm264KFW1hHYexbLnh8ttlUx78KUHLlnuL1pbGsC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 0/6] Nominating "whatchanged" for removal
Date: Fri,  2 May 2025 17:58:08 -0700
Message-ID: <20250503005814.3030099-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250501225958.2947677-1-gitster@pobox.com>
References: <20250501225958.2947677-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git whatchanged" has outlived its usefulness when "git log" with
various diff-related options more than 10 years ago.  It is not even
shorter to type than its rough equivalent "git log --raw".  It is
high time to start seeing if it is still being used, declare its
official deprecation, and announce its removal in the future.

This iteration is more complete than the previous two iterations:

 * The first step is to refactor the mechanism to show the message
   to ask users to contact git@vger that they still use the command,
   out of "git pack-redundant" implementation.  This message is
   shown when the "--i-still-use-this" option is not passed to a
   command that requires it.

 * The second and the third step are to remove unnecessary mentions
   of "whatchanged" from our documentation and tests.  With these,
   we have fewer places that we need to adjust when the command gets
   truly removed.

 * Then we start to require that the "--i-still-use-this" option is
   passed from the command line.  This requires adjustment for tests
   that protect the behaviour of the command, as they must now pass
   the required option just like end-users.

 * The last two steps are for a future.  In order to make sure that
   we can cleanly ditch the feature at some future date by removing
   it from the build, test, and documentation when Git is built with
   WITH_BREAKING_CHANGES.  And finally we add "whatchanged" to the
   list of features to be removed in the BreakingChanges document.

Junio C Hamano (6):
  you-still-use-that??: help deprecating commands for removal
  doc: prepare for a world without whatchanged
  tests: prepare for a world without whatchanged
  whatchanged: require --i-still-use-this
  whatchanged: remove when built with WITH_BREAKING_CHANGES
  whatschanged: list it in BreakingChanges document

 Documentation/BreakingChanges.adoc           |  9 ++++++
 Documentation/MyFirstObjectWalk.adoc         |  4 +--
 Documentation/config/format.adoc             |  6 ++++
 Documentation/config/log.adoc                | 11 +++++--
 Documentation/git-whatchanged.adoc           | 10 ++++--
 Documentation/pretty-options.adoc            |  5 +++
 Documentation/rev-list-options.adoc          |  9 ++++--
 Documentation/technical/sparse-checkout.adoc |  2 +-
 Documentation/user-manual.adoc               |  2 +-
 builtin/log.c                                | 19 +++++++++++
 builtin/pack-redundant.c                     | 10 ++----
 git-compat-util.h                            |  2 ++
 git.c                                        |  2 ++
 t/t4013-diff-various.sh                      | 27 ++++++++++++++--
 t/t4202-log.sh                               | 34 ++++++++++++++------
 t/t5323-pack-redundant.sh                    |  5 +++
 t/t9300-fast-import.sh                       | 12 +++----
 t/t9301-fast-import-notes.sh                 |  2 +-
 usage.c                                      | 12 +++++++
 19 files changed, 146 insertions(+), 37 deletions(-)

-- 
2.49.0-601-ga5925c3955

