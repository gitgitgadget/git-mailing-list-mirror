Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D2200112
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459669; cv=none; b=Kzfx7GFggShieRC6pM4nKLJbqVWoLKB6rwnSztcunJxGb6V/dlTvkPyPdvdQYMS1wJ/02qTgvWYM9882FuWs8YvebhxWYMoNBnq/hUvVMWoEpSkQPPuH4XuuwIZig0PtyXbEEIMqbkpnwPVH9VMLO+/Op1uwKEagaZG2dyYe3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459669; c=relaxed/simple;
	bh=qSPynNG3eXzQuykSutC2xZ8Pcrz8F0O2ym09IfhPWBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGFQBaJWxOeSIzFeP9D7zKR4VP8x8hjfhqu+VxYc5rvRLjOBRV0NsI0JCSXGdJXL9vCIz5OB4UJsuERNMojWlbUGJL1mpQzW+hzWktgfz7ChudUnrMS0Shf+f9XDlaVq8JtTl7a1QNwr6v2GgSHufn0qg2IuHm+CTPbJiDJUO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qbr5e54/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/I1j7Xc; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qbr5e54/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/I1j7Xc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70B537A00BD;
	Wed,  6 Aug 2025 01:54:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 01:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459666;
	 x=1754546066; bh=M3wXVp8JCRzXTxR6twwovMDHhJqEYH/VdGsrbXwZ/lo=; b=
	Qbr5e54/AnFDoNJ0kq60pflQTHNBnJKPXoY5SaLDexJEcxfFHwvQGzYlvpzCpxSZ
	brnuc38EVJ8aVxv2MwwIM2Tf+c6MktniLVJMy1F0FLA+YAOmGs43J+2pgg+aZeGk
	vPew/XeY7ZADHBO+QkYL0m6Oz9zQp0go3t03PF2onRfvaxprRtN8PJHrajEdbQZ+
	jyE5rHqlV2d1wxS/jfLrn/g0NI/nnrhUNoz2MczJGvZaDud+mBSBv2jOtvlWG3kz
	OrgRLC/CM8DN2olLMTfgKX1wh32pTMyYsnlXIJCanDytqYMO0emHEDCBbuDRBZ4G
	X9ZkBxQJjWN5VP2KM9iq/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459666; x=
	1754546066; bh=M3wXVp8JCRzXTxR6twwovMDHhJqEYH/VdGsrbXwZ/lo=; b=J
	/I1j7XcmjzP3JmAtTLHUhpml+Wait2Z5xZKRCjKvxLNPNI1Fr0C9L/KRYViXtTQf
	1piWO+ITOoYib1bvlADO+GoKFEWI5tconlKUSLEfAlPs6C6akN82gX2WvaIwKxee
	lxZGlQO+L6ws6Q484OBLvJmiLzDarVm5KAajnJUr/aeBA5aRiAD4p9el8azxqxCZ
	9sKzb8QQVJCezXZJMhrMOBDwd9Qnl+zuDD0j9hhTV5czyN8hhdKvpfHKl7E0TcoG
	y4UrDoc4cgAxnH2dQiEUAQpPjtaUaLA63a8XDtHGjw9kB6FxIfSSn2rE8OaZiF7h
	TNhyYqldEI4lLPE+z30cw==
X-ME-Sender: <xms:Eu6SaM78qSnK02UA6VxCIlmBOysd2J3wlc3A6fMrZfDopnEEKYqMdg>
    <xme:Eu6SaJnwD5yXBw5vFfLTMtGvQLPa1J5mIOqnBrR6334VybxuRlc6RD1jUI68PkP67
    6moekVO7ANWBQx36A>
X-ME-Received: <xmr:Eu6SaH7oc3AgiyMQWgmApeOQgwSrD3c_p6nhj3xZ_FvDThXdl-lBzDt0-Euv5XRATCebKGNbhGkT9Nm2HptTE5tTHhdTuUJsJZCzwNHrYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:Eu6SaKQJgfgMdE_dyVRTHXUEZcNfruPSWiLwrNUVji-nHLSWevrzTQ>
    <xmx:Eu6SaFzqzLFJepmMIdwgRX_KFIHVYKyE-5djbLhqCsAdqYrIQbsRxg>
    <xmx:Eu6SaCraXjc3ojtWF8w02jMBu3zj-A-OR0amBIMzDa3xKdVHwroWfA>
    <xmx:Eu6SaI2wjhj0Pg2V5WMTOC18Ie8NE7ug8VJvEC9UeQql-z4u5qcdkg>
    <xmx:Eu6SaAnT5o0QkgQmTvNxE214UR6UnIP3bIR02Zw_Lh0KXwd0JZBdM0iQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ef5a045 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:12 +0200
Subject: [PATCH v6 1/9] Documentation/git-reflog: convert to use synopsis
 type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-1-a50839653766@pks.im>
References: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
In-Reply-To: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
X-Mailer: b4 0.14.2

With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
have introduced a new synopsis type that simplifies the rules for
typesetting a command's synopsis. Convert the git-reflog(1)
documentation to use it.

While at it, convert the list of options to use backticks. This is done
to appease an upcoming new linter that mandates the use of backticks
when using the synopsis type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 412f06b8fe..0d6601fdea 100644
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
@@ -74,15 +74,15 @@ Options for `show`
 Options for `expire`
 ~~~~~~~~~~~~~~~~~~~~
 
---all::
+`--all`::
 	Process the reflogs of all references.
 
---single-worktree::
+`--single-worktree`::
 	By default when `--all` is specified, reflogs from all working
 	trees are processed. This option limits the processing to reflogs
 	from the current working tree only.
 
---expire=<time>::
+`--expire=<time>`::
 	Prune entries older than the specified time. If this option is
 	not specified, the expiration time is taken from the
 	configuration setting `gc.reflogExpire`, which in turn
@@ -90,7 +90,7 @@ Options for `expire`
 	of their age; `--expire=never` turns off pruning of reachable
 	entries (but see `--expire-unreachable`).
 
---expire-unreachable=<time>::
+`--expire-unreachable=<time>`::
 	Prune entries older than `<time>` that are not reachable from
 	the current tip of the branch. If this option is not
 	specified, the expiration time is taken from the configuration
@@ -100,17 +100,17 @@ Options for `expire`
 	turns off early pruning of unreachable entries (but see
 	`--expire`).
 
---updateref::
+`--updateref`::
 	Update the reference to the value of the top reflog entry (i.e.
 	<ref>@\{0\}) if the previous top entry was pruned.  (This
 	option is ignored for symbolic references.)
 
---rewrite::
+`--rewrite`::
 	If a reflog entry's predecessor is pruned, adjust its "old"
 	SHA-1 to be equal to the "new" SHA-1 field of the entry that
 	now precedes it.
 
---stale-fix::
+`--stale-fix`::
 	Prune any reflog entries that point to "broken commits". A
 	broken commit is a commit that is not reachable from any of
 	the reference tips and that refers, directly or indirectly, to
@@ -121,12 +121,12 @@ has the same cost as 'git prune'.  It is primarily intended to fix
 corruption caused by garbage collecting using older versions of Git,
 which didn't protect objects referred to by reflogs.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do not actually prune any entries; just show what would have
 	been pruned.
 
---verbose::
+`--verbose`::
 	Print extra information on screen.
 
 
@@ -140,10 +140,10 @@ used with `expire`.
 Options for `drop`
 ~~~~~~~~~~~~~~~~~~
 
---all::
+`--all`::
 	Drop the reflogs of all references from all worktrees.
 
---single-worktree::
+`--single-worktree`::
 	By default when `--all` is specified, reflogs from all working
 	trees are dropped. This option limits the processing to reflogs
 	from the current working tree only.

-- 
2.51.0.rc0.215.g125493bb4a.dirty

