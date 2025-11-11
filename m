Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3A28152A
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886486; cv=none; b=fsSzICzl+bze466mjx+yD5nPIPanflwN5vVI1zHVICB0gvZO27lnE6IvfS+dOtYXXVLbFum0bsKezWd+PMb05gGvCkilBOIgLgP1apuQlJz1IU3A2t0Hjjko6xpGsKeMXITr/jdnPutLcqsU6FlkmlggHC51ELO5upDj+1QJV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886486; c=relaxed/simple;
	bh=RYrvEp99U6+fl4b3Y7BBz54batOfCHW87N36u++ud8c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mwMeiDqZqFlxritFvnuCppxNxhQkmtEiESqVZGyulBtvVaBb7lLwpl3HPjL7rLptN+1k7NFzQA96gqMb/4T2yxYdgUF3Pfzj34tR52N7SQlPKLbDdYYKoOYfMql3XRILnv0EO2yZ+Oph9VJgkZJYPfNiNTZC0KBf/HJjUnleGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OX7BEv1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N98kEenZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OX7BEv1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N98kEenZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 13BA91D00094;
	Tue, 11 Nov 2025 13:41:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 13:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1762886481; x=1762972881; bh=8Y4xY1oxj6Nw2YahbkYLkgce0PlBzc2B
	C0OYelO4j4g=; b=OX7BEv1mjFeQb1C1kK2iUhvf1s/3Ixw/5xan85kinvt4tGtp
	DeJfPr/ReHw9G6CQO+2LbiA92IxylqCGnTmXiRzYNNSyob6nHyozKy603oJmUHFK
	6Mh5Yh78UIpuLI20GussjS/Vj5Wuj/TYY5SlVmTSitbSaEuafZEecZYo7CNtIY3X
	5/PZ7EayN6NbXDdK1e07wg0xeM0mc6bn+f5XqThxrAO6Oh3zUmhL59l+yHuDCeO6
	LG0iAZHMgBF6dwYhrtNb/3nhc1nG2OAVXEPRVpH7C9xgWEEYLuRcIp8Ebgj6cqsY
	Y+xtFZw87znBOY21B2ASaorXAd8jzC4EUQZ2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762886481; x=
	1762972881; bh=8Y4xY1oxj6Nw2YahbkYLkgce0PlBzc2BC0OYelO4j4g=; b=N
	98kEenZlBSn1h9abUoFI9gNK1wPpjp/xS5ZxwlFQ/N6FeCzwpTCoLXMYRTf3DMFe
	7puhoX5Yz2ZOuDGoUbzpR8opiBCWPf+eQ0Bi+eFqL6qTdNFqok9+CphRB52zU+LY
	cdR1ITD8pZYujkY3lcBiavKJouXsBTWjOWaC8e9qQAXStm4sh66XjROXvGWHFIJI
	Zh/w2zTvIU1KHNsYEeCl11PQ14a+BHqneuSkuJCyC7RKz1h0+yK4vczb9CzNfsCA
	F2+SxEH3I1PFL3gmVynkQCyilfvVeKLGY7+y+6KCQFjLNlggWntVdukyD0U6n7U6
	XF9iTBgUV4t1eiNL2Ct9w==
X-ME-Sender: <xms:UYMTaZtdsT_I38oyIk4yvoI6z93w-DiMfxsi0DhlmFpvrxEeT23SUg>
    <xme:UYMTaYe8FQZRzvsLaV6ji5_4VwbaV-OAnf8Ef3s-1SQ0f3PjcYUjqtZ6v-6GHOwdu
    AvljL2oK_ZJKayKvuBatPWyDjCdnRcK2y6Z622D7b5HgHXi4Nvq9g>
X-ME-Received: <xmr:UYMTaaaFXzFGnrpPt5idoNlNOp_fsYb9AYDE2Sx1el4cBsalXjlnQPiEJrg3IMzC1cIaAuFblGKoxqKdYZ0cY3yuFmwKClXwHEd_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:UYMTabVUoSia02PabKwG9dT2k1DWG4lqJ338Qau-82KNkSq-ghenTA>
    <xmx:UYMTacgsbjUpeuB0WrqsiUpiZhF6EgLCxLgTk8S2tV5VZJNAIKLv1w>
    <xmx:UYMTaZWsHBLerFCCKvIxRelmLQYEgKSX2bhbl40q5rz0y5f4yU5iJA>
    <xmx:UYMTaTMMNKRyqIKcILkA4akW0ROwIrgviQZagQPCuAh2F8E8iaYOLA>
    <xmx:UYMTaVFVhJBhhcAgahael5fLX_z7GJ-UPEdRgtRG44vY_AjOnCxdoFwu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 13:41:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] .gitattributes: remove misspelled no-op whitespace attribute
Date: Tue, 11 Nov 2025 10:41:20 -0800
Message-ID: <xmqqv7jgwgxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ever since 14f9e128 (Define the project whitespace policy,
2008-02-10) added the whitespace rules to .gitattributes, we spelled
the most general rule like so:

    * whitespace=!indent,trail,space

in the top-level .gitattributes file.  The intent of this line was
described in the commit log message:

     - Unless otherwise specified, indent with SP that could be
       replaced with HT are not "bad".  But SP before HT in the
       indent is "bad", and trailing whitespaces are "bad".

It clearly wanted to disable indent-with-non-tab, so !indent is most
likely a misspelt form of '-indent'.  Because indent-with-non-tab
has never been enabled by default, by luck this was not causing any
ill effect.

We could either remove "!indent", or spell it "-indent".  The
immediate effect would be the same.  It would only start to make a
difference when/if we enable indent-with-non-tab by default in
future versions of Git.

Let's take the former option to remove "!indent" from the list.  We
would feel the effect first-hand ourselves before anybody else if we
ever decide to change the built-in default whitespace rules, which
would be hidden from us if we decide to rewrite it to "-indent"
instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * There is another one in git-gui/.gitattributes that probably was
   copied from here, which may want to get fixed.

 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 158c3d45c4..2a50ebaf2e 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,4 +1,4 @@
-* whitespace=!indent,trail,space
+* whitespace=trail,space
 *.[ch] whitespace=indent,trail,space diff=cpp
 *.sh whitespace=indent,trail,space text eol=lf
 *.perl text eol=lf diff=perl
-- 
2.52.0-rc1-455-g30608eb744

