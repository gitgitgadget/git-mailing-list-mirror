Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261155D86C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996954; cv=none; b=Vh6dp7IAxAOrub2OACgoMLE8yl9K+cdg1yoC8ZOZ70fKp+fk2B6UDPdxW1/iSoVq9hiRsHuvrISbTIZ5VJbhS40phFPJh6vQ7/r8wQ2B+KYQ5H76ANZhhHgqjjd0KTKYcIyjwl1CVclmrNiO+V8TJItWDyeWO4wncvJfL1y+gx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996954; c=relaxed/simple;
	bh=oPE7jsn9Lt+qQB9anwKBugwdOw0VG1wC+WLoMJkAbxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DAvBBIK6KJDaHLXbaagZ2TZP38es779gCP8hTQhum0qcZOv5RyOy22YYAny9g02Yy9uHTNsqQGaZNKS5VsYwVJeiL8ylHTQ1OhJdvFtYzyVLe+x37DUYLJJOQYTsW/SSo2VpN9z8zQ6RVJfWHFNyd81P4PEZTPohzei9KPxMuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZzXMCzfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYwu+cM4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZzXMCzfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYwu+cM4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D45AEC0363
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 12:55:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 12:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791996951; x=1792083351; bh=nQfYU/FvhH
	mEYXCTVY1XttDAdOFlZAawwN2nKNd0cQM=; b=ZzXMCzfukKwnAqbfIOBx7EuWVc
	dwxECeb8hjEk5ypy8geCEBmp0sumjzWwdiv78MoHV25gqR2HB+Uv3slRvGz3it44
	W6tUtzo6zr9tIAPXKA7XDvGHWoZ5V368Gz9TI08+3EmhbUnGVbahP0dD1y4IPjuI
	VSL/aZYvTUh1p0YOXmZ99U0K9S0yOcozcCAUHY/RoKaXsiPmOWpwGeckMuo7nia/
	dZ3XnvaxLDUnOWLj0M1tN7wHIBZ20VXCMv9d0LHNlNOwvfdsX0lZDH2v5P6ZqGDT
	6sI2qVD5gDBJIHwsw5L06MMx3axI5luxHCT+CzO/PFuYdNmb4Wfff0H35mRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791996951; x=1792083351; bh=nQfYU/FvhHmEYXCTVY1XttDAdOFlZAawwN2
	nKNd0cQM=; b=BYwu+cM4e1jqoy/UFqFfcC+njVRi19fGENtmh+8AP1bNCIlNeeZ
	VlA2uY1K6yd7oOMmre1BO6fCJQUkQXxR4JGUkP5v0RnR/NSzLr90BV6iqwuYFiKq
	uBWvtLOcJqGxjpq+nMZ9FLFOS8m1pvYoyVQtqLK/vOd8rN2Ts8HAlp2nD5yTmdHp
	1v6LQzKx7eRj7YwipJpRBQK9JYClW0Oaw1lCd96qqox0efwwyYEP8h+c1yl9cD0b
	rEeR0ttYuS9NxfhKbaxa67qzRDLfkoNzHRw7XE7jvK6xuHIzcyDp82u+zzn0N6fz
	7bOboekxf0BFhMKaedjeAaBzYiSYxqBMwcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791996951; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TXmcn7Ge9AtNR0yv69tzGiQ79S8iObGxGM/4lUNOBD+cEYQ
	dr1lb8HGzUqonqu6+OzJAxHaudKH8g5KAyqB/0m2+imKLpXbMgyCAh5xywePVcI7
	7zaPkYHR3bXxGjfJBkVQ4aXY2PNR5M2UdltCHlITnG9kQrZZkFyEFrWiSJk2HDpa
	GR97tPgGPd8fGSONfsZaSEFKNiakr7LrXK48R3fEqliZzWwy1R1Qa3clkuzxxNPE
	YYTNAQkD66rouSxM/0+yX8PbthmMmL/SMiYG3YaYS2ZUdDTxrzFDQlIk95buvCXf
	0bkgSiNX0yXKamvykbDtyjAJnVnIxMcqnL5IBxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Etbdn4/yBgHczGD/UnfuUXidPITyywOmwS8t4ZeQx60=:oPE7jsn9Lt+qQB9anwKBugwdOw0VG1wC+WLoMJkAbxs=;
X-ME-Sender: <xms:F7TPaiXOfCodTa6qN7LrChtnfof0mUe6Pk8dYcfja8BdBdRBh9kAfg>
    <xme:F7TPalfqoXOpJibi-117eVXkkfx6R4q-2NsMQPWa8AZnxwt2YrptDO_jGNLagqH1w
    oohHmfgvnVnmxDFkl1_rKydvhMyF65q6e5HS7aFI80AunJBXDJ-0eP9>
X-ME-Received: <xmr:F7TPauuDwdHVmGYkEeiVyDMxeSgkLEEFU-2eDWKcOtFVZBrQlkWcvU2Hb0k1bkrRlMUpCv17Gy3NGgZuAeK1Khq-NdEzNW04fp8n>
X-ME-Proxy-Cause: dmFkZTFG/k/DIr1NX4Po4FHrd4SsPG8Yl0gw8nGN2csPmfQve+hXcmocOIPhxR1ur7qLi2
    hLUABZg+tf1IYHEObNZqzjkwFF/k4KpMX5DCJ/ZCRrVrbXunPBTSzHdD5gSSMUYRJbtHcJ
    EjtwPaYeDbVUTmk6S+mK+RuAx1QWwzRlr/GXRITsE9O7fpepBXvOeAer+uzLAvWXvViEg0
    RXWW9cp+PDvkaBnd+mmoFUyiraTG267yaA/dhlX4v706nNHdCIr710brm3kPqtiOykeToD
    GQep6DrMio25Ff+GqrOq2gEdE1kEBYP84YIo8OG2TYU77zPd34CTBVZm66TuCs2XWtiMY0
    3F4eBeIa7ztoSQwMb2LZ1Y4qTcZMv78qTKJah0NcRS671T8jpD4MM35Hd7diEBeejt66Y4
    8FJTeqR1efCXL2Dq4biRRYA9jdfrWt94qoiwqikO4lBb+HR5bbKUQ2uQ+epFcKJ7Z9Hc55
    JKtkFp/xUfalR8gLDdYR52nU2hk7mp9b4sqoZgevLik1mkv8dakyLJublfJzeuRy4vvwpg
    4k26p+nUiOCKb1C1rpF5GNJNikCYqHb4SIOopkFpcGOc44lvw4VeL8/L1D8zAfoc720Pu7
    t0zRe1gG/8jBbdPgETqhCRbwBw3Zqbrzn7v2Z1aT+wuLfWZJVBCXtgst3Qow
X-ME-Proxy: <xmx:F7TPak93LxiO8XcKSuNmNA0f1RBetwD2B8XUeVgUeCTEW2emCvnQ9g>
    <xmx:F7TPap2DUKVMrVs07-hcPWRquPqT37fZcw-Lj2qB3M42Qp_aleWo0A>
    <xmx:F7TPapBxPzghNCJBXHuuqVzwaviYvh1B8Exsc6kJ-WR7mRkxXX8ssQ>
    <xmx:F7TPalcCBNqcw0MWpnjZj5DWNPvtM5li2dFL0Y0clMYiV7K4IXLwmA>
    <xmx:F7TPavecTxwbHVv6z00vudqLbiFKyiLVk6FAdwUMEw76x_GJYDpFWaur>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 12:55:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] connected: do not walk alternate refs in deepening fetches
In-Reply-To: <20261014103507.35317-1-iwiedler@gitlab.com> (Igor Wiedler's
	message of "Wed, 14 Oct 2026 12:35:07 +0200")
References: <20261014103507.35317-1-iwiedler@gitlab.com>
Date: Wed, 14 Oct 2026 09:55:49 -0700
Message-ID: <xmqqcxtcte5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Igor Wiedler <iwiedler@gitlab.com> writes:

> The connectivity check spawned by check_connected() uses
>
>   git rev-list --objects --stdin --not --all --quiet --alternate-refs
>
> where 39b44ba771 (check_everything_connected: assume alternate ref
> tips are valid, 2019-07-01) added "--alternate-refs" so that the walk
> from the fetched tips stops at the refs of any alternate object store,
> on the assumption that the alternate is already fully connected.
>
> That only works because "--alternate-refs" comes after "--not".
> cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
> 2018-07-02) drops "--not --all" for deepening fetches, since those
> need to verify the whole chain up to the new shallow boundary rather
> than stopping at refs we already had. For such fetches we therefore
> run
>
>   git --shallow-file ... rev-list --objects --stdin --quiet --alternate-refs

Ouch!  Thanks for spotting the 8-year-old mistake.  It shows how
rare the deepening fetches together with the use of alternate refs
in real life?

> Move "--alternate-refs" into the non-deepening branch next to "--not
> --all", so that a deepening fetch walks the fetched tips down to the
> new shallow boundary without looking at the alternate's refs at all.

To paraphrase, we cannot trust refs from repositories we are
borrowing the objects from without taking the shallow boundaries of
these repositories into acocunt, so we ignore them.

> Negating them instead would stop the walk at the alternate's tips,
> but the reasoning of cf1e7c0770 applies to them as well: an alternate
> that is itself shallow, or a partial clone, has refs without the
> history behind them. fetch-pack sends the alternate's refs as "have"s
> in that case too, so the server omits everything behind them, and a
> check that stops at those refs does not notice that the objects
> between the alternate's boundary and the new one are missing.

But stepping back a bit, doesn't the same argument apply even when
we are a fully populated repository and making a non-deepening
fetch?  We can trust "--not --all" to make the traversal to stop at
tips of our local refs and can be assured that all history behind
the tips we are fetching will still be connected, but a traversal
that stops at the tip of a shallow repository will break our
repository, and in a worse form than the shallow repository we are
borrowing from, because operations in that repository are guarded by
its shallow boundaries that we usually do not see, but operations in
our repository do not have the same shallow boundaries in effect.

I do agree that for the purpose of "see if this traversal barfs with
missing objects to see if the updated tips have all the objects
behind it", listing the alternate refs behind "--not" is the right
thing to do and it is broken to have "--alternate-refs" without
having "--not" like the current code does.  But I am not convinced
that disabling --alternate-refs only when you are deepening is not
solving the problems of using alternate-refs introduces.  Shouldn't
the fix be more like two (or more) steps, i.e.,

 * [1/2] for check_connected(), use the attached patch instead.

 * [2/2] update odb_for_each_alternate_ref() so that it ignores any
   and all refs from shallow repositories.

Hmm?


 connected.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git i/connected.c w/connected.c
index 7e26976832..f4b60489bf 100644
--- i/connected.c
+++ w/connected.c
@@ -91,8 +91,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args, "--stdin");
 	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
+
+	/* define where the traversal should stop */
+	strvec_push(&rev_list.args, "--not");
 	if (!opt->is_deepening_fetch) {
-		strvec_push(&rev_list.args, "--not");
 		if (opt->exclude_hidden_refs_section)
 			strvec_pushf(&rev_list.args, "--exclude-hidden=%s",
 				     opt->exclude_hidden_refs_section);
