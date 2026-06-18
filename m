Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABC146A66
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764060; cv=none; b=b7KnWmV3uU72RyzTh1oL8lg7M91Zr54UVQO3yq00xgN6ob3+yP0qMmTlTN+x7lRmP210aK6m6t6olgtsLRphgD6NcZLR7080UJmT27AIdvWYjXvJ+6sYQ+zqY2I4AZI5XscsO7t17uDihVJZ8s9yWVAQoSTlSnkLKZg6HA/FpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764060; c=relaxed/simple;
	bh=TJ1ADGK+zjvGxzDOyYhE6SI10RmF13RUlz21unvAjI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvX+7wnZBWPmfGsjPNq9JcCUZQzZhSmLCs2PMonxx4LV4icvQHA/rH2LyXftkt6yWr3qnS06xwObbpTXBOsYG9Q43b5Vxkh6tAupdUOeI4pNUsIvOXtYNKCuE/5JSDcAYza+XB6oNHibNUnU+9ut1/7tSF7JdCau3JMm2U4vMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FgujdY2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3ol3gdU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FgujdY2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3ol3gdU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 449461D000B3;
	Thu, 18 Jun 2026 02:27:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Jun 2026 02:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781764058; x=1781850458; bh=y4TckgnLyv
	J9Vn/xSAgFHraKD0WhKxoDF5TOzLet5zI=; b=FgujdY2NV9yK3AopylWf1gz1qE
	IwONcKHCLFqS7wSkivW5kbxK5vW1V9C+bzZH2J74bln/A8tbUFR/TC6LChLxNTBG
	RUt4hMAWgh4rkCf4skSUOknnOPx6A6ThpojcVuLPwUz5uREVCvRkVkiQeiDD5LXv
	WcliQEemIfIN8pyFp+NVq9hXB+ft5NZzPJiCHjJWY7jRunp4gcC63+CSFrfbH2Au
	yBxo2zRfW+cfN9FcbQqyhHAZ4x40qxVhc0+5FskcaoOgb1timnQsakJqr0RVU91T
	dSvVx+mUD4BgGxzaPXWrV4piemUReIciFzZXDju5k6hdu7bR3LWSx414eu2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781764058; x=1781850458; bh=y4TckgnLyvJ9Vn/xSAgFHraKD0WhKxoDF5T
	OzLet5zI=; b=h3ol3gdUuaPeAPt/KwLLnZ3KpVbvYwJHh8C8FozBMrJgmOgmK9d
	Evh7wFnkLuIkZjK2yXqc8eHAclUvZe/2NLKb10+aigiI2yLFJPF6HME0mv9m6ExN
	7eNpLwaHpONcZKwCQuWX/yw7bz7JQZQAC5nGWOLlz6aIrzQwbhCBNGybc4NTJcZv
	9wsyzIGL2tFIYG++My02gzXkNILLtgzC8tLpAiG0W/kZgcS4nc07p6MIQxIURMzr
	cXk1P6lhND7mDvmqYThYRY7X6+H24Y0R46WQZfUz4jwdQ+rhi39lLlU0DvKYzhSa
	DOFzvMje6aLZCJp5N2PPTNhglq2QO+b9s4w==
X-ME-Sender: <xms:2Y8zaqEgrlMmFL1m2K-Dfcx0-jV-dFP3N979yr311bYOfvN1m0G2pA>
    <xme:2Y8zaiyCsnZAUAByrovLanip9iiySadzuJUglstYLCsyeB7TXzpo9mDGkIy19IWbt
    EbGIjeTA5PT1JQdomiO44K7BgjUsgOfmfXTKO0mXFJI54x4dBYl>
X-ME-Received: <xmr:2Y8zahj9AkieOAxVs1RnSuGz_dXpm_d_JLvvBK-HuJhBgIQNbrFaonlbCovWLFJUhjr1Bi421F1bKcsqauO8_CylZXfdGFNkfAdupRLiVQ>
X-ME-Proxy-Cause: dmFkZTFL/pvoUQrk2+2Y+/PWE9ZqIXq10NLo7AmivIPhELjhnTVlrlhnGCK3f4RwxRmUMe
    1+zgaZ2fQ/KzYJYRF77XATSpMTrrN2j6arMp0wso8ur+7rTiWnJOB8ydjKog8uYQrYHaDP
    GldrtA1D+a/9aR3iBOMrUtB57f4hKe0ENFGUACoyhgAjIKewLaE1AHEBR24b9iYaHIOby8
    fppF0Y8Dz9lSTP2msGstd7eoH89fsngMV9umSYP+VAV3BNhuFkQjqqfsHq7rsDZXRfgZqJ
    gN2DJdD1OsglTlHwmKMLx17oBTmbrHJWnLHgqJgdu4S4W2PZIgLtAQGjc69A6+gz/wGKri
    5kd7DgeMJ2VLU/06GsLVtulKstVXoYr9Al81AO8W/4tf1b8vZGlU+woFlBKpiFgVKDJQoP
    L9zx3bjJAp/T2Tvxhun5OuomDhcyug1J8tYJMmskrtrFcdHOGLu5dKjUrbVwoFosFxJKcb
    BVTcFbNtSgNhIwqSYDQNxfYREkTN0inFJlKglXdDLGcgqZQgnw12u7ftNWwAYo2EtRz5aQ
    a1aTwI3x8HVRStcaTrm63hl9joYLwrtJFei3osFoF1QQLYkBBwAwmgeu9uA1klaDQ7XJwx
    A3HrRZqau2EKBV/j/N7vy08K7F4BHvvgBVC3f9s2Rxm41O0pH5G5Jk2hvMBg
X-ME-Proxy: <xmx:2Y8zatzWk2OI7neAUoziLD6oajYVgHKrsKxUySoPzc14fHFxd2mxpA>
    <xmx:2Y8zakKfLX5Y6CNvDHV1VMTEAsVvBpCMJVCASk2nn4fu3WzdBMjatQ>
    <xmx:2Y8zakSc681Fj0hFMrEGLapAcyAEhJDme-xz7NlItDkTA1LD1FQW8g>
    <xmx:2Y8zasqqOdCtGrw1yL7Z8dxjUFDOZdGl6xkSIWaa7aGv8d1Y02b36Q>
    <xmx:2o8zakfMPFn30jKIO1oDJhJvPgWshgITlWkRbCorQzMuigLTQBip6VPJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:27:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d87c9617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:27:35 +0000 (UTC)
Date: Thu, 18 Jun 2026 08:27:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-2.55.0-rc1 t4216 broken TAP failures on non-x86 arch
Message-ID: <ajOP1IOjA3EYvRfm@pks.im>
References: <20260617220330.n6byiFQr@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617220330.n6byiFQr@teonanacatl.net>

On Wed, Jun 17, 2026 at 06:03:30PM -0400, Todd Zullinger wrote:
> Hi,
> 
> Building git-2.55.0-rc1 today, all non-x86 architectures
> failed with:
> 
>     Test Summary Report
>     -------------------
>     t4216-log-bloom.sh                               (Wstat: 0 Tests: 167 Failed: 0)
>       Parse errors: Unknown TAP token: "--- highbit1/expect 2026-06-17 19:44:07.555797743 +0000"
> 		    Unknown TAP token: "+++ highbit1/actual 2026-06-17 19:44:07.563651478 +0000"
> 		    Unknown TAP token: "@@ -1 +1 @@"
> 		    Unknown TAP token: "-52a9"
> 		    Unknown TAP token: "+c01f"
>     Files=1047, Tests=34680, 1072 wallclock secs ( 7.61 usr  1.61 sys + 395.73 cusr 586.23 csys = 991.18 CPU)
>     Result: FAIL
> 
> The test output is:
> 
>     ok 148 - setup check value of version 1 changed-path
>     --- highbit1/expect     2026-06-17 19:44:07.555797743 +0000
>     +++ highbit1/actual     2026-06-17 19:44:07.563651478 +0000
>     @@ -1 +1 @@
>     -52a9
>     +c01f
>     ok 149 # SKIP check value of version 1 changed-path (missing SIGNED_CHAR_BY_DEFAULT)
> 
> This looks like it comes from the following chunk of code in
> the test:
> 
>     # expect will not match actual if char is unsigned by default. Write the test
>     # in this way, so that a user running this test script can still see if the two
>     # files match. (It will appear as an ordinary success if they match, and a skip
>     # if not.)
>     if test_cmp highbit1/expect highbit1/actual
>     then
> 	    test_set_prereq SIGNED_CHAR_BY_DEFAULT
>     fi
>     test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
> 	    # Only the prereq matters for this test.
> 	    true
>     '
> 
> It seems like we could (and perhaps should) redirect the
> output from test_cmp to a file (or /dev/null).
> 
> But... are we expecting these tests to not pass the test_cmp
> on any non-x86 arch in the first place?  Or is this exposing
> something broken in the test setup (test-tool read-graph
> bloom-filters) or elsewhere?

Hm, this thing is indeed somewhat puzzling to me. I assume the intent is
to give the developer some information that their platform is using
signed characters by default? Other than that it's not really doing
anything, as the prereq is only used by the one test shown above. I hope
that Taylor has some more insight here.

There's two potential fixes:

  - We can just drop this completely, as it ultimately doesn't even end
    up doing anything.

  - We can convert the call to `test_cmp` into a `test_lazy_prereq`,
    like done in the below patch, which retains the current behaviour.

> Looking at some older builds for non-x86 architectures, they
> are indeed failing to set the SIGNED_CHAR_BY_DEFAULT prereq.

Well, I guess that's intended.

Patrick

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 1064990de3..c7478e2513 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -581,10 +581,10 @@ test_expect_success 'setup check value of version 1 changed-path' '
 # in this way, so that a user running this test script can still see if the two
 # files match. (It will appear as an ordinary success if they match, and a skip
 # if not.)
-if test_cmp highbit1/expect highbit1/actual
-then
-	test_set_prereq SIGNED_CHAR_BY_DEFAULT
-fi
+test_lazy_prereq SIGNED_CHAR_BY_DEFAULT '
+	test_cmp highbit1/expect highbit1/actual
+'
+
 test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
 	# Only the prereq matters for this test.
 	true
