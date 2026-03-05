Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AB28C869
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746541; cv=none; b=RL2cRusrm2czclm7POgdTgMMB6CEuW83cq1S3haGkZcgBRMBBjLWbLWF0xDgUbbvyXhtzqsRax9JhrhISkKeBo3m1c9iqx2QaFfQQcifHd4OHe37kFl2WH8JAx/d6enPQOMrzZ2bks9f64pflUT8dkRfl+Gs2MsiJGycSfuxYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746541; c=relaxed/simple;
	bh=oGGjv6TlSqF6OvDE+4Lo0jhrWCQgJ0AMu6BvXghmDu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ssCfiQah+frPyfeD0F0ICTrbjV1O2dE6YfVFuSMDR3In6wiB1hOaC0uUdx46qEzqai5otvF1GPAgGqnA8oTclRpIAU7NQg9KrhtQDvgXeNlNo1aTcNN0aJ8z/9nwrtzlWRwCVrjctRtdDX4kK/MdwzV0CnxtAE0wkuYXD0O8Up4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cdcOUgsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4bgFtvkj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cdcOUgsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4bgFtvkj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 056DEEC0582;
	Thu,  5 Mar 2026 16:35:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 16:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772746536; x=1772832936; bh=KvYM89Kujq
	606Ru0nxmEPxso2tHGRrLP/PBkgJPf0bw=; b=cdcOUgsPv4Li9MCDG9bDTvrnl0
	aVeCVmNADM5fMsYoEn3Ifc9VQZ7P4i0LUMSGlXTjulnTHEQQWvU1tt9PPkDhLhEa
	u4G5COSxu5v6gwJ3m1/ESRiKX+X6R0OZImq9cp/G5BwGeVqaOFpW6gTtMDCP8tWH
	/pQCaSt0YfkLF5w7SIiyjV8bS0eKIp7RHSsRPmhjMiW0yJOwNEsNzK/4buupA2Dk
	M0wIWhXe+l6NfLH5lhwQYMjwIJ7nfSk/dCtQu/TxjWiwVPsOzdUQHPmoCzz8w/Mp
	bR18nsK9TmkBsQ3enqnbTqO/23abipMMy9IwW71WBh6Za+IgKNC//+COObjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772746536; x=1772832936; bh=KvYM89Kujq606Ru0nxmEPxso2tHGRrLP/PB
	kgJPf0bw=; b=4bgFtvkjQNpmHYhdyN1si1YiSKdHSKGP9aINU8aQ0nAQSDnJvhs
	NBuCE8+mZhl2njkysGeZKMBAOJ4tF00Eu+qjZrKjs4Qz19zvv2YMGV1DoIbShxQ+
	KBr1PYlXpcfJ3DnzJ9z+1e5ptTNpaVC4AZSPREHiVMjrZ6d4s7oCE7Xj/R/iD6ZB
	5Sgih2F+NFuxmJummaQoHTzEdB3VsczD2O1te1el+qJ7Ak/KDT3btqef/NyBLuxx
	K0QLi4H7ksvYmdUeQsSPJ6moOUKbQhUuHOVYpiq7OF0pqwyb0SGZamIiAbswpQcf
	6t03+Ip5CSmJgmV/a8kHsT6mBsWhG7JnuQg==
X-ME-Sender: <xms:J_epacvmyOYnBtj997tlFyoBjCgRrQfPlmvDDopvX38cXvmcw-fZtw>
    <xme:J_epaQdnN_PjO0n7LB4ZVfcU1DgCUM0NqExautKOYxoOj12A_o63kHv1AitUJDmm4
    NxuCQ9Kr6AWpNgOPRp6D9BcOevR2X5i8nfgrWCeEaXIetf_ZGH8nHI>
X-ME-Received: <xmr:J_epacw1hc_jkHwLxqWwU9tzB05YaEicV6rEqu6kmpFwzW4m1b6ij-jJqLHs9UIpZXhqLJbq0FDumwhme3My1i2beRF8ckyiVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J_epaeE9PWOuy8TnZUU2sBqJQ8OvEFQCdgju1fomnEhOfM-N3LPShw>
    <xmx:J_epaYy0WB3zxMDX7JfFMjB5xPM4z_PynZhoROQcIFcfHjUf8XL2hQ>
    <xmx:J_epaXv1oFguoLJMXfEBYdEmxoaJKVqdnzlRHExYbVI-1xQzHzVm1A>
    <xmx:J_epad0aZNhKgFmv6bc3xGTnE0AgmunSESAjtk1vKNVxFundwLGAFw>
    <xmx:KPepaQQTTePSnCDhMRQ_h1wY9MKlP8LjQwSls45UPYm7H5ZLb5YuSn-H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 16:35:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
In-Reply-To: <aan0FUBE1LwrFc4y@denethor> (Justin Tobler's message of "Thu, 5
	Mar 2026 15:27:34 -0600")
References: <20260305193836.973122-1-jltobler@gmail.com>
	<xmqqikba2evz.fsf@gitster.g> <aan0FUBE1LwrFc4y@denethor>
Date: Thu, 05 Mar 2026 13:35:33 -0800
Message-ID: <xmqqzf4m0xju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Ah yes apologies. The first addition to start with a line prefixed with
> '+' intead of a blank line. I do believe it does already end with a
> blank line though. I'll correct in the next version.

I have the following queued on top.  If there is nothing else, I
can just squash it in.

Subject: [PATCH] SQUASH??? mark-up fix

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5acd692ad7..359f5fb74e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -37,7 +37,7 @@ most likely to be knowledgeable enough to help you, but
 they have no obligation to help you (i.e. you ask them for help,
 you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
 help you find out who they are.
-
++
 It is also a good idea to check whether your topic has been discussed
 previously on the mailing list, or whether similar work is already in
 progress.  Prior discussions may contain useful context, design
-- 
2.53.0-621-g5d45fffb26

