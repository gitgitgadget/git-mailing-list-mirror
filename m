Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC61499F0C
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715456; cv=none; b=q2NGaw0/QSURzsN4Av3t41eYTm+g5RE9+rUQYNI4XIiSFc7j+jB53w6N5g/xOEMWsiGz+6+syDet3zGu0Ng/zOgZfRia0fq9xXjG7enHZfW+KhIWKFKy3N7ZJLxMSgBmd4L2QY0sIcypvpn0KrcCuddob/at/v8hfSY6hpJoZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715456; c=relaxed/simple;
	bh=jEGV3S2ABETHabUquNTgpWV8r2g6i9eeWNCai6n3DyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQlczBIZvmlHvU8qpo51Km15b9aqNpUrzRc76+3X/YYEn84XOzdzPFJRbvyKgus4Xt5BMy7J/6KYuDhth/KffEQf6gKw9UaHoCNa1Ht/Judw3rMBYwZsNc6SOM3fakmWVz9wwvsh52DRwgyxabphRs4Rb5NjxWAV1hK5Yn/lV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jHZcy6Ad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoHtFeMx; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHZcy6Ad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoHtFeMx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ED3B91D000F9;
	Fri, 18 Sep 2026 03:10:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 18 Sep 2026 03:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789715453; x=1789801853; bh=umBOYXgtpk
	lWnykj6UWTWLXmkrYaFaqiff3D0Q1dczA=; b=jHZcy6AdHYhPsjoccivgQfGapN
	AzotCouzVw61X37iurS4/At5qQtJVTJMd65nB8CTCbJd0t2Q+sr4JPHVF318fKAE
	eLMmjqGCrdoFcYsjT4ql7By0zdCHr3tXTOsxs8PZ4CUNbNV1+pgPoRnyYS9gcVMs
	ywuqt+Rm7WB6DsHrxMIRv2ziF+J4Ye3E/qKoRP2D7X4fOZi0GOzNbdp2OGlxfyJd
	WLc+SxsEbQfOFjnMsRgoakfprsrm9HcMwOW813EHE82oCnnzUwHqH27msXZQd9Su
	fypRRnQdJp/SoMzpaVeojom8WB6IrX9ZED5OKdye5OKl32LHwbPSO+8XL3oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789715453; x=1789801853; bh=umBOYXgtpklWnykj6UWTWLXmkrYaFaqiff3
	D0Q1dczA=; b=NoHtFeMxgXEGnA0ZZvNYEwNUvbtavPqzXtyHhM2KepSpZQ5l9bY
	T4fHD1AvDoIQuqMPkdyLNfstDyYuyvMqckteRRIiykHZGazRFFosFM315U8XsDtG
	hFmzP50maJsXq9uYWkBlCgt4Ktx9q0Sr2bRrIpfeMCaNwVcLr/IhP+fMu957XRfO
	ce7KsCp3xCW3CHG+RxBQBEXP6044iban7Ms1jVXo7BJeOHM4Zr0mUedvLoswP4gK
	RyTSHjk4jHg115bBE45i2CCd17nZ20taODKnGvNJB/URHF8N2mJ6bwUYRsEVDGa1
	J/jZ2qwqel925riNC2QowE7JjwXIeC/5vng==
X-ME-Sender: <xms:_eOsajt8QZaoqGwPn9gZHn44BkDbpL2BIb3v7lp4wrvd0wEW4TVj-g>
    <xme:_eOsar7etDEPtCrtzxQM3lrJm6cGvhheMksgGY3if2ljlRTtip6c466vc6zNY3PFV
    kAj1QEfTrV5Y1fZWGpYYJZBAZDkAmb-5Jhg88c2f14RCf90gUPiFY-n>
X-ME-Received: <xmr:_eOsakKTx_m60n8fIb1I1QxTGl2IWiFb9PzCjnY8r3vBMNAtQ8NH5mTGFgghBG2ZtJN0Ym53eNc3-SKdhpbTSpWbX9RhPASPBRPA>
X-ME-Proxy-Cause: dmFkZTGWP19DGmzQI1VRFahHLp5bBSxSUY/+89ogXF2YKm/J7WKGxO5qqmqpx8iGmZWxwL
    9O3a1E4AlQj7Svth4AVTDD3HLI5i50bT/XLQm9a+CCODMizkqSHzCoiEqlj1Eo0hh1+PWo
    4Numnn+F+fUBsonXc4L3oUzTa9GNx+SsZ3SXEaVjGKZeqffbXAXkGnqNHht/hq3WRaNr95
    ADrcCxqGm6qpQ7hKdj2p+ppVrmFQoUOWFGrR30CFdB35CDmoEPttTyb852Vvb12Qhn/T4l
    tX69ASUOUUisE4muKa9wMB1eykanB5jZELl1keBxO8zefYPVYBwYH0wvwYB16DUcJi26Vk
    joplKP+ulxg/3cEqQQwLUdaPNXnYQj/007513Wu80u1toXBGmTPplzKCXATiKLhcxquHKH
    nQa2jVrPIQ3j/cddz/ORUaL+gofVCopD0i4qzDEcJidcsVpSUQNA5zOYaechLm6l3zRJ0M
    5WiDeBAhCer24L1wT+G/rpA9DKhKHvSauyvNQeRKeRojedXlhZQ62XiTw3c9XZCwui/E8U
    IAYMvLPd9R+rsQfteIYWTJQQLRdjGO7XDVzg8hH100yLLuSQzGgigLbT7MZ6BSGT40xt7N
    MM1v7OsWsPw31YcQ51Se31bpghw6iPDCadwhGVkeLbt1mp+xtxqBZ7WxSYVQ
X-ME-Proxy: <xmx:_eOsar6C6Y0nFzuCcRGuu6hh_3tJPL4vmUbta-pJk_IjvywpEv1HAw>
    <xmx:_eOsanzabO2AApiovRYohAJGUx4OtWzvwXGyEgwD3bz_QNqPZvOSLA>
    <xmx:_eOsavbvheAvqtScDrarsENDquCc2epdO2aa6S6LjpkeDrDVTN60pg>
    <xmx:_eOsapQ5OedriJa1hGYXWemkgfctMZEv4-tPLMmm3gqyPWvbfNVEsQ>
    <xmx:_eOsasCDrPM3rB1IMXVm55fTVjJrfnS0kvhbVIoUkAJnRcD55MA3JPt6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 03:10:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Update t/t4001-diff-rename.sh to modern style.
In-Reply-To: <20260917195436.1102981-2-markchucarroll@fastmail.com> (Mark
	C. Chu-Carroll's message of "Thu, 17 Sep 2026 15:54:34 -0400")
References: <20260917195436.1102981-1-markchucarroll@fastmail.com>
	<20260917195436.1102981-2-markchucarroll@fastmail.com>
Date: Fri, 18 Sep 2026 00:10:51 -0700
Message-ID: <xmqqjyojowzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> Subject: Re: [PATCH v3 1/3] Update t/t4001-diff-rename.sh to modern style.

Documentation/SubmittingPatches::[[summary-section]]

Perhaps

    Subject: [PATCH v3 1/3] t4001: modernize

> Old tests were written in a different style than modern
> ones; for better readability and test error messages,
> update t4001 to the modern style.

That is a laudable goal, but enumerate the rules you followed to
achieve that goal.  For example, a few of them may have been

 * Run everything inside test_expect_success block.

 * Write the title on the same line as test_expect_success and end
   that line with a singul quote that opens the body of the test; a
   line with a sole single quote then closes the body.


> Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
> ---

> -test_expect_success 'setup' '
> +initial_setup () {

Why a shell function that is called only once by a test titled "Diff
shows path0 ..." below?  It is customary to perform the setup in the
very first test_expect_success whose title is 'setup'.  I doubt it
would contribute to better readability to change that.

> -test_expect_success 'test diff.renames=true' '
> +test_expect_success 'With diff.renames=true, patch includes rename of path0 to path1' '
> -test_expect_success 'test diff.renames=false' '
> +test_expect_success 'With diff.renames=false, patch does not include rename' '
> ...
>  
> -test_expect_success 'favour same basenames even with minor differences' '
> +test_expect_success 'rename logic favours same basenames even with minor differences' '

Here you are failing to follow your own renaming rules to start test
titles in uppercase letters.  I personally wouldn't have chosen to
upcase many of them; rather, the majority of tests in this file seem
to be named in lowercase so I would have instead made sure I'd start
them in lowercase as well.  In any case, please be consistent.

> -test_expect_success 'setup for many rename source candidates' '
> +test_expect_success 'rename with many candidates' '
>  	git reset --hard &&
>  	for i in 0 1 2 3 4 5 6 7 8 9;
>  	do
> @@ -177,14 +166,14 @@ test_expect_success 'setup for many rename source candidates' '
>  		done
>  	done &&
>  	git add "path??" &&
> -	test_tick &&
> +	test_tick  &&

Good eyes ;-).

> -test_expect_success 'rename pretty print with common prefix' '
> +test_expect_success 'rename pretty prints paths with common prefix' '

Meh.

Neither way, it is grammatical at all 'rename' may not be plural, so
the verb 'print' may want 's' for third-person-singular, but it does
not make sense to use 'rename' as the subject for "pretty-print"
anyway.  It is not that 'rename' is the one that prints something.

