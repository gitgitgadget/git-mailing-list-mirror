Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BD36E47F
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151449; cv=none; b=Z405465IMuCitmTKohrXs0p0mgsL1qW+2uE1+yujvsudhLpq/usuY+7KzJ6S3TeDgeAgkhNgcHwLeLTkpL3+gek9X/zPIK5qYR0hpoEIapwlUEN4CMfJN6EatOxez2hxtd0tclrW2I1wUIkPVG3ToDmATvMuKIL0QL/17InsNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151449; c=relaxed/simple;
	bh=ySOxFHU/k5P5aIyoH60jWovJfbEz+lRAQoGPtHgbFDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr9mfkDVpeyDBYK2pxup01vbpvUo/R+V3yj1ihbcKKdR7A23wZx3MRFkXhzatWOJ1+ovHomsziH80S/pFyS+SZO0YYZch4eJ5x5aJYlN2e7NR+j0naewbcSSrKC/Gf9ugbe/r27HPGzusUy3MxD2SWnMgoDa9oDPrVAGk5Z0+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vb+2QvU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeGdysoT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vb+2QvU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeGdysoT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C3021D00129;
	Tue, 14 Apr 2026 03:24:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 03:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776151447;
	 x=1776237847; bh=fx8WZpTaas95YHDkqVSdOo1phbtmjYojBvqR6T2e7SM=; b=
	Vb+2QvU13tESXMGjP8Zf1pjCPUGIGwk0keGTbPJIRckyl984utkp1YYuKSGItVxJ
	kUOBSPtbNE047Fcm2YsmWugDa/adzmsN9NS2hYveSDPrDmjZ7hQr6HBXMhTQUxIp
	fAP8JXoFt/fopMVhjMMtiPSM0C9vfigiNHcsJ6M7a+3ZpIAayV0lgoXK0HrFkQum
	rBSvu8d0A3Nrj/t2R+ql/pYj9ZeqoqW8X7cdoqz/PPodlzldNio9JCXHcqMMD92P
	B6jL76nPs2l1LhTa7lrHSTvYN2zDC8VwKW8TcAHKrQ3WbUKzkL59l3ATDHmd2CpA
	4xk8/kuBxDcfhZc6c8KKIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776151447; x=
	1776237847; bh=fx8WZpTaas95YHDkqVSdOo1phbtmjYojBvqR6T2e7SM=; b=F
	eGdysoTRFoWXOHFRxjg/VoYwoGHSKJtKZscHKua0YskSbcay6jZBy0+xpjRm7RgT
	QOuaf5pIQKRwAdJWgLsc7CaE8juLQlcfQ+Z4AQ/Ir/qoWfXaFPp6cvqrf5fXKxud
	038mIhqjbPux7BunoSj9fNzPb2Rtc6uBNDYPxA8bh09TlQ/qY7V8wot6PqFm9ak8
	i3c+WJwJlVy+ZjCBrMXmOQ+pPjl362jcMCYp99S2bM5aRaHwUYxJIDMUCeGBSspo
	19vj/5aMwXHrAFubdr31LUFZSI9SasS+Lt4RNA/ewGcSZ8qQ3v/r6Bx+WHZWm1gy
	6XFZkxEBXD48E11F5Wphw==
X-ME-Sender: <xms:l-vdaeXbkwCmBpc00r1FVlVqRE8nN2NWEhtoa_igOsYZX6SenYiqDQ>
    <xme:l-vdaQn-MzwENS0wlppJIuWLRdlwLuvnZIgOhtFx2Aypf8MnBvHvWZ_guJaqjbYfR
    Dlo2Eug4E5FiklXnbxUYMR_ZNP25y4idY9fa91pbSS2Um9OjuA>
X-ME-Received: <xmr:l-vdaQA29Ip2ogDPpSxWOatoENC4yRyQGmCffQ22-VYKgfsrc-a7Jjoeq9fF4NMFWBzVorAJZaLdv0TwL9iSR3sRgRceUYcpEk-4_1m1Z2v9hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l-vdaQdHWYJqU5rgy997h2qMSkeTPVHX-LVfSsgLCCrmfus4adCFPA>
    <xmx:l-vdabIFDiwYiDtPw4Exo7hkoi-BL-FuePlUFwMlYgzxMBetSXYNvg>
    <xmx:l-vdaTdExpSlrnFypzceHwDkQw_pyHQfsQcbgJe-WnXeCXcorx7e2g>
    <xmx:l-vdaS0o_ekUiq8Vba3QuGA_60N-MohicswzqZIZHJFM7hmfB8OPCw>
    <xmx:l-vdaZvABcPL_ZB1nmzm9XtAgpeHz28nrgMqjqf9rtpmFQEGn6FkLjS->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:24:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 031a84d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:24:06 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:24:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/12] t: prepare `test_when_finished ()`/`test_atexit()`
 for `set -e`
Message-ID: <ad3rkmf2227AWrVD@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-7-5b83763a0e84@pks.im>
 <xmqqpl42ixk6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpl42ixk6.fsf@gitster.g>

On Mon, Apr 13, 2026 at 10:23:37AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Both `test_when_finished ()` and `test_atexit ()` build up a chain of
> > cleanup commands by prepending each new command to the existing cleanup
> > string. To preserve the exit code of the test body across cleanup
> > execution, we append the following logic:
> >
> >     } && (exit "$eval_ret"); eval_ret=$?; ...
> >
> > The intent of this is to run the cleanup block and then unconditionally
> > restore `eval_ret`. The original behaviour of this is is:
> >
> >    +------------------+---------+------------------------------------+
> >    |test body         │ cleanup │ old behaviour                      │
> >    +------------------+---------+------------------------------------+
> >    │pass (eval_ret=0) | pass    │ && taken -> (exit 0) -> eval_ret=0 |
> >    +------------------+---------+------------------------------------+
> >    │pass (eval_ret=0) | fail    │ && not taken -> eval_ret=$?        |
> >    +------------------+---------+------------------------------------+
> >    │fail (eval_ret=1) | pass    │ && taken -> (exit 1) -> eval_ret=1 |
> >    +------------------+---------+------------------------------------+
> >    │fail (eval_ret=1) | fail    | && not taken -> eval_ret=$?        |
> >    +------------------+---------+------------------------------------+
> >
> > This logic will start to fail once we enable `set -e`. When `$eval_ret`
> > is non-zero, the subshell we create will fail, and with `set -e` we'll
> > thus bail out without evaluating the logic after the semicolon.
> >
> > Fix this issue by instead using `|| eval_ret=\$?; ...`. Besides being
> > a bit simpler, it also retains the original behaviour:
> >
> >    +------------------+---------+------------------------------------+
> >    |test body         │ cleanup │ old behaviour                      │
> >    +------------------+---------+------------------------------------+
> >    │pass (eval_ret=0) | pass    │ || not taken -> eval_ret unchanged |
> >    +------------------+---------+------------------------------------+
> >    │pass (eval_ret=0) | fail    │ || taken -> eval_ret=$?            |
> >    +------------------+---------+------------------------------------+
> >    │fail (eval_ret=1) | pass    │ || not taken -> eval_ret unchanged |
> >    +------------------+---------+------------------------------------+
> >    │fail (eval_ret=1) | fail    | || taken -> eval_ret=$?            |
> >    +------------------+---------+------------------------------------+
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/test-lib-functions.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index f8bc77619b..0eac676109 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1516,7 +1516,7 @@ test_when_finished () {
> >  	test "${BASH_SUBSHELL-0}" = 0 ||
> >  	BUG "test_when_finished does nothing in a subshell"
> >  	test_cleanup="{ $*
> > -		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
> > +		} || eval_ret=\$?; $test_cleanup"
> 
> Hmph, it seems this "&& (exit $eval_ret)" pattern has been with us
> forever since it was introduced at 3bf78867 (test-lib: Let tests
> specify commands to be run at end of test, 2010-05-02), and survived
> a slight modification to work around issues on FreeBSD done in
> b6b0afdc (test-lib: some shells do not let $? propagate into an
> eval, 2010-05-06).  When a major part of test-lib.sh was split into
> test-lib-functions.s at 12a29b1a (Move the user-facing test library
> to test-lib-functions.sh, 2012-02-17), this part was copied intact.
> 
> Does this interact well with the glitch b6b0afdc (test-lib: some
> shells do not let $? propagate into an eval, 2010-05-06) tried to
> work around, by the way?
> 
> Thanks.

Ah, that's a very good question. I'll spin up a FreeBSD VM to give this
a test, thanks!

Patrick
