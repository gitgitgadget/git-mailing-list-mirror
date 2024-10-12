Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCE145B0F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721206; cv=none; b=GJDHmt0wkV2JQg8xTmNgBq0o/M3kbNB5lK/jr0pYd6fi6qfdsDc2TWMGQvP6q1tLa3YKjutJ+6jxVEZdcy2Q5J6rTiArhi6wgDaM5KAHrDPeOtH2OIzEppNFZrLMfzzmQSS8Tm40qiCCbYPjTBkYnq/jBFXhB8M2uk+laLRe3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721206; c=relaxed/simple;
	bh=t94fmaeFzHYF8cuEsAhqVTpjJXUQ90RQ1F27IrrtzEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj5Qc1ckdj89MIWUhgm7Ie9SpLpqQDIvJ7SOLEDfW+KC+IldDqhtmx1rDWkeYRKmQBtsezMeYwUplqzzCUZL5PhGiOCcMpMqIX22jNFE8rtWZndaGMAXdhxRM/duL1C7YCi76eaEPI6OguUaTlBU31TB4bYXDDAldThz/0c7fXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cjn0xzBu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/6ENtRl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cjn0xzBu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/6ENtRl"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E91411402D2;
	Sat, 12 Oct 2024 04:20:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 12 Oct 2024 04:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728721202;
	 x=1728807602; bh=Ljlh/MsCZ96kbNPmX3R7rkbrxBmfbfhIqI6XXKjjvyI=; b=
	cjn0xzBuBd4j5jDVUk3d8Npn0VKxcx0d/JCeXT+EB3RkerzEJtix4hVjBOLj/Md6
	RO98/EHk48IRNXewqr+Gno66Kj2MpSsRMWdULieqMxRXbN714hxzacTrOJgJjGFe
	QGEg8P8tHeVkcQMuIAHtXiBWPRz8yzakAJ6cszsykGKNpZu9HBLWceR/wSWYm0zn
	AKcP0xiPdTCFQawTOZgHFbRGan9/zNq2nnWy4pfyc+vMOt6/frnTTNPL4tJw+MNX
	t3pL/zvFpNhO/h300o3/XiNqfnfhF1PzIy4xzlt5a/W+qCIpAg2KIMPAMHTVaJ3O
	d9kAc4oPr7fFKO2BYo2IMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728721202; x=
	1728807602; bh=Ljlh/MsCZ96kbNPmX3R7rkbrxBmfbfhIqI6XXKjjvyI=; b=k
	/6ENtRlNO3ykTpuLpEMt1hAYTBvMo5PNePKI4yS8lyAdG3P116IXdnReNSYv0Lkh
	YqAjFbsHi7mLY7BROENxzhCcBPAx8uikCq8wvcGK00B7f+71lmC9XMNxdB+1yyMR
	4/iufKyRGgDh/xmFVp7bDa8fO/c/NmGwGECyKVpGLXVjz0jIRnyI5hEZ+Kh/VLR0
	HjB+hca5KBII5kHfx6QLHI2ofvwUmrcLHAlyluoDhZq4HJcqsizw1VS0JGsmu/nr
	a9ZBQrMF40+6BHAj3ErtEU71Yujeu5CGSnO8bSoe2G2KlOnpYWJdjG5XvVCY+RzU
	T30vnfHjXBOgAJKZiR5DQ==
X-ME-Sender: <xms:MjEKZzstfMkUvXdu1nf3sJGhUotxegcGkLdSpOvHgau6Hs00272Mow>
    <xme:MjEKZ0dg3H5yjIq1qX51jwsuOGTpGxtKVNC9aXZ-gQ--TNjMi73HgqxxW5eceVUxw
    YuWECMbghtjI99tKw>
X-ME-Received: <xmr:MjEKZ2wgKU2a9J7qtXxMbkjmHETpQqhiD4tqHkvFaOFZ2fi-Nzl8cKvj1hdJC6jBcUmLklRzh0mOYvJXb8ny-XF6X2XFColBOpD7Sak5oDgT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffuefhtedvieejjedvgfeljeetkedulefffedtieel
    vdefudeltdevtefggeekkeenucffohhmrghinhepuhhnihigrdgtohhmpdhgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MjEKZyNCF57y14nDD6HpJcHTpJhlaHyN2HpQXeImujPBMKbRWAnmjg>
    <xmx:MjEKZz9f2sNbdjlIhbrLzMlmA7a8oHkdHlLo_s_Xr2fLMALHsIdIUA>
    <xmx:MjEKZyXEh4ZQjSYk-Ab7Jw5tA8I0BN7LrWuLXERPTo9eVHFBwff9eA>
    <xmx:MjEKZ0dTwZz-T8QCtSHqKz9YMak7kUiRPhCpUqMeLtCS6Pn1nTur5g>
    <xmx:MjEKZ2apVORRRml_OhUbYV5eEj4gJwpzYJvcNn3wuO3wl-tCl6ggV_G1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 04:20:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2adcad0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 12 Oct 2024 08:18:48 +0000 (UTC)
Date: Sat, 12 Oct 2024 10:19:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git no longer builds on SunOS 5.10, a report
Message-ID: <ZwoxHYD-e4qo7OyW@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>

On Fri, Oct 11, 2024 at 10:10:26PM -0400, Alejandro R. Sedeño wrote:
> First, clar.suite was generated as broken because clar-decls.h was
> generated as empty. Tweaking the sed one-liner in Makefile that is
> used to generate clar-decls.h fixed that (move the end-of-line marker
> outside of the capture group, `$$\)` -> `\)$$`), which I would submit
> as a patch, but (a) that only fixed part of the problem and (b) I'm
> not entirely sure why it helped. If someone else wants to apply this
> change, which would align the end-of-line marker placement with the
> start-of-line marker placement, have at it.

I'd still appreciate it if you could show me the diff. From thereon I
can handle the rest.

> The next issue was that clar/sandbox.h uses mkdtemp, which I don't
> have here. Git has solved this in compat/mkdtemp.c via
> git-compat-util.h, but clar is not using it. Adding git-compat-util.h
> to clar/sandbox.h feels weird, but does get us further along. That
> change introduced banned.h into clar, which exposed the use of strncpy
> and localtime, both otherwise banned in git.

Yeah, we don't want to pull in that header. The clar is from upstream,
so ideally we shouldn't have to modify it with non-upstreamable bits.

In any case, I've got a similar report yesterday where some functions
weren't available. The root cause is that we don't set `_POSIX_C_SOURCE`
in "clar.c", so with the below patch things started to work. Does that
patch work for you, too? At least I think it should, as [1] mentions
that the function is available on SunOS when those defines exist.

In any case, the patch has already been merged upstream [2], and I'll
send a patch early next week that updates our bundled version of clar.

[1]: https://www.unix.com/man-page/sunos/3/MKDTEMP/
[2]: https://github.com/clar-test/clar/pull/106

[snip]
> Please note that this should not be read as opposition to the new
> unit-testing framework in any way. Building git (and curl, and gmake,
> and zlib, and openssl, and perl, all for git) for SunOS was a hobby
> for me, and not anything I personally need, and besides, it's not like
> my previous builds have disappeared.

Sure. But if the fix is easy enough I don't see a reason why we
shouldn't try to support your platform. It would be great to get earlier
feedback such that we can fix issues like this before we create the
release (see also our Documentation/technical/platform-support.txt,
which we have released recently.). But I'll take what I can get, so
thanks a lot for sending the report in the first place!

Patrick

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index cef0f023c24..76557df3040 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -4,6 +4,10 @@
  * This file is part of clar, distributed under the ISC license.
  * For full terms see the included COPYING file.
  */
+
+#define _DARWIN_C_SOURCE
+#define _POSIX_C_SOURCE 200809L
+
 #include <assert.h>
 #include <setjmp.h>
 #include <stdlib.h>
@@ -271,9 +275,7 @@ static double clar_time_diff(clar_time *start, clar_time *end)
 
 static void clar_time_now(clar_time *out)
 {
-	struct timezone tz;
-
-	gettimeofday(out, &tz);
+	gettimeofday(out, NULL);
 }
 
 static double clar_time_diff(clar_time *start, clar_time *end)
