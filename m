Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F151F9428
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905960; cv=none; b=REBjoBvPnc2MlXwV52LsmZ7p2qSEjgbuwJlFtlZ/CwcspmFke9+kWRRAaY6TSQYyCICpZn9xIYUf5ymPAmz88T2A8/Eh9NJdSY+qgIibHv5+1HH6NoryGiy4HPaqr9Tu0xbrIXoT7m315MLm+JBRGlpr67ZqelkQ33OaKWpR1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905960; c=relaxed/simple;
	bh=pSkKSo6EP/WtmhZUwxnQ4Ru1gR/XbWHp4K7Q7gCIuiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izk5viBHACVnPmJa++FEFYD+fTJMoZfWT/ldr9eVCOWKxaTCizVRnI7/z9z4zntwa9AMovDfL8eF3Qx8RQ0qqjok77/qWzXPEYJTi4u5Jf60zgYbwHO1YGYLNCufWlPFgU3hI4naa9IHpz67yjjqwjEI4MovRfu03LQuLBc6mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ocud/3Oz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jG1lGJQd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ocud/3Oz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jG1lGJQd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C56613801CA;
	Fri,  3 Jan 2025 07:05:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 07:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735905957; x=1735992357; bh=gVDmTFyfRz
	dfmEbLjCnCpwYcu2Zj4F26aDOk1cU4A/k=; b=Ocud/3Oz5zvY8XUtHHWVpi5L/I
	9F2WRhiwt42mA/ZSDDLU314HsH7HT2u0ud3oIDtynSP56BrOUmjVv4ao9YIytc1T
	vZrQGIIp7P41NdzWzXzW4ZO3J+j52dnvClLbV5wXoeeNqpzEFjb2rhag50KDzSmV
	Q9XbG4KsqlRtUUWj76dtd39P/nJtebQ+DmidLAITjeKN6q5o88lhIBruZDsDpf2f
	U60x0MQ8Mz8OXYasDld3KbZ3fJlNdst+WBP1UOCT5bE5gS+bPVMUV1LirlDsl8PJ
	cyF2PaykzidvonzsUyKZUFtyeclCf25GkaqRH/tZOWXW3vqyiw7rmw5lqwng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735905957; x=1735992357; bh=gVDmTFyfRzdfmEbLjCnCpwYcu2Zj4F26aDO
	k1cU4A/k=; b=jG1lGJQdqQCJJ1/3q/ppgLqpPCjbEci6VtHsa5yVAKizH8jUnBX
	1FqJnxnkqDJIUuYVNAtJC9d/HzSUlBXISiTV8pDZhyYzitEH0VySxKIIzovtFsa8
	QNsTamPb9vYElLdizYEqYc41NkqPLRzMwxGMSpOniZLHAanNnnl5HbHCWMhVNN2a
	kT5naAejCob+I/ivIixXrNW6WKaarFnBi+FlWX/XQbTpuOcXvfal7ZmEsX5Rh2nS
	2Sh2qzOprnY4XfB6jIMqmezW59JCQ3LWwgKGS+YocBavnn+2gmaN9obziMXiXUuE
	umky02aHEqdehC0X2R1iuzMs5cO9akOGEAQ==
X-ME-Sender: <xms:pNJ3Z0tpj4xTzdoakxZCVVcE2ObUNSZj-GaoqlyXJl256HWYj2s5gA>
    <xme:pNJ3ZxdTwxSgeovDdKYqGqZ0OV09lr8ZQ1Tn1XxL4rVSbtVWJHCL_-2DchIKdCaZQ
    43mMJqwY2KSvbB6Jg>
X-ME-Received: <xmr:pNJ3Z_xiZdZdMTJzztYjJcIuHiwpv7jr_d6T4X_ipFpzqTeaxxTBI9o2Zg8ljQTXLew1VW_JxB0v5wGZMPdFE0bD7Gbag4qnRTDQiwiz2CwyIX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:pNJ3Z3P5TG0dt9EGFkfK1hVRyCbMKJlIlydzA2AA8h716PzWmRIghQ>
    <xmx:pNJ3Z09MK57ddMRl4IvW_T7y7qGZT0if_14aRMV5RlRFKThbia-E7Q>
    <xmx:pNJ3Z_UTuZqh1QTYytTH-Lav6L9Udd-KA9pJdGRsfJenFkR52Axe2w>
    <xmx:pNJ3Z9cuNXdyXwncRTpouOkQtSYmeidvlxhi9L9H-tyGSdO_BEc_xQ>
    <xmx:pdJ3ZzYjUthFxprNwDuz_5KlAAAaSZ8nPh5kTC3aqeTZ4Of7p0n4OQ_p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 07:05:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25328fe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 12:05:49 +0000 (UTC)
Date: Fri, 3 Jan 2025 13:05:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] test-lib: ignore leaks in the sanitizer's thread code
Message-ID: <Z3fSnK21nRBrjyfM@pks.im>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101202124.GF3305462@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101202124.GF3305462@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 03:21:24PM -0500, Jeff King wrote:
> One small downside here is that this just suppresses the "were there any
> leaks" check. If there's a real leak _and_ the race was triggered, then
> you'd see the racy false positive in the output. I don't think that's a
> big deal, since both the race and real leaks should be rare-ish, and
> you'd have to encounter both in the same run of a given test script.

Yeah, I think that's fine. You'd have to both be unlucky and trigger the
leak _and_ you'd have to be debugging a testcase that hits the race in
the first place. Which together feels unlikely enough to really matter.

>  t/test-lib.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c9487d0805..d1f62adbf8 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1177,7 +1177,8 @@ check_test_results_san_file_empty_ () {
>  	! find "$TEST_RESULTS_SAN_DIR" \
>  		-type f \
>  		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> -	xargs grep -q ^DEDUP_TOKEN
> +	xargs grep ^DEDUP_TOKEN |
> +	grep -qv sanitizer::GetThreadStackTopAndBottom
>  }

It would be nice to provide some more context here in the form of a
comment so that one doesn't have to blame the commit.

Patrick
