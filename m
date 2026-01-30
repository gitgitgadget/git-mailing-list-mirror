Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48442D061B
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790438; cv=none; b=JKy0uLwmQuuh02vD8ohbRbb3kiBhBoJOPN/k3EUSQIfEDkAl/FEcTJPHSz9UTm9n58Zcg//C9olJaY3vCBvoTnJRFwKH2clRcl5Bj6wfBhw7tQJRVKI57PeapjG9DkMv18YBfUGE+CE25CFpxBARYMAtfKt/hu/jUKh78+rpxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790438; c=relaxed/simple;
	bh=c//KUv4fGHv8gp2kSnAkG6sMSt2dx8Wf7i2slE9Plh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mtqOwTlSpBIA92U3liACT47Svjlt68Z2fJJW6VusCeAIPCYoKkeuMdNZE3SC+gvX/IYShQ7Jxd5cBDEgARvRoGARS2O2qEhA7XFCYMh/vnGHUq346a6eAcbx2EuYCtpLqra8KXmma7LlAdNeoNLY6CeeOWFRcIugacyGiQfi9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ChjL7nLx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrMehpdp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ChjL7nLx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrMehpdp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 351A21D000C7;
	Fri, 30 Jan 2026 11:27:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 11:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769790436; x=1769876836; bh=0E+KXSfHuw
	MHaaKOX7Yc9YiDeqqfFMXPhE5PFA+XzbM=; b=ChjL7nLxA2HmcHyEET2HrzEOhY
	TMsy5/kduK0fDr0eI/ReAx3m41GjgHvi17ojz+8F3mHKbU3yT/I9oF5tv80Q8xGU
	639Dj7H9eMTQZvExnUKzILZ/2ci/uB1iAo4oW2SWMRQpWNeqT9Wm22gNmpFg8o6e
	7hWZjoJ0ygbYsaHnHeZUPyfXDJDcWxa0KmSGHXZf4noU+L4ogcsMKFb+7pPLqn13
	ag4imBS/INEY0vq6T76kaWHLYJT23QQnwSz8Cw34s8rZHSvLQ8ayIV70WfhOCDrw
	r5v60X9rZHG0ux0hjX9Hcz1SF3Hm/K3Fo+VgWTA43Ar6+DZUbQeb5yu5IaMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769790436; x=1769876836; bh=0E+KXSfHuwMHaaKOX7Yc9YiDeqqfFMXPhE5
	PFA+XzbM=; b=qrMehpdpWCd+v1+NMXdJYI3CeR602UEjN95GLqTsMQD1On0Uozv
	GUdzJGw3sn+mRYOwBJ87uBEcf4W3qrjjZaH8bOdGxafE315W7ZOcIK40fJEZoHSI
	kUYwHCpcqr3lrR9HkT26NnckBgXYMzcQ4KeAGK++8oorGe+4JZABZuMWoTHkLGXE
	EQ076qfYhHE+DwYf/yzZTtUHHfAG4ooC9u2q//FWh28TCWhHW7IgU1wvjXRwfLzB
	1ngZNxGR9ydkRsy2RK8QW9yvKPJAsJPd+DHQt2M1EOWqjRXKvxdyrNXaYGP+5/Xa
	PNsRr9TIuCDCHjIL3xdr8ADwQfBsVGpfxzw==
X-ME-Sender: <xms:49t8aW31USK-6hOMepwfqv5U1ZMfN5uIRebLL7jVou0xrzTsG-L0bw>
    <xme:49t8aQEuEGnyZDyeARvfY6kmfP5iKW6xldkWpoXvONlSyJ4ae04suhWHoCnJM6FKx
    7_7_cFvOehk-Ol0if19KsUKdEWNUhhtG2mLJWfKdibMwIZt80nPrw>
X-ME-Received: <xmr:49t8aT6KDvo2AWS52ryiOv6GtS0hC5W33tzLiQbxbHpZ4JBXppL9zNC1zFNyntHse1hsWofuAUWqpsFHsRjYsEjzO0chYhM_PVCWihc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehk
    uggsghdrohhrghdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:49t8aWuerJYRLKmu2P_c3C11Mz9vAp_qrhlT7V6RJ10n9kbBhv8SSw>
    <xmx:49t8aU7LuL-UmTD58pjlJ4Ll7enoYg5_ag-_ftlufeFZsZNRRo1czg>
    <xmx:49t8aRXy1AYhkF47cj8J87jwEJf_WKiPgUdKKNFq8zfubpYfRWolXQ>
    <xmx:49t8aW8EcSPircgy22Rac7wSWvrJTMm0ApSsRYz50lpGWDsvr9ueEA>
    <xmx:5Nt8aRXXwSxB7uiL8bTFIreY8V58pT1GuReYGog-Vdy2IyRZUn2dh8xq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:27:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Tian Yuchen <a3205153416@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] t/perf/p3400: speed up setup using fast-import
In-Reply-To: <04005f67-3ec5-4fa7-9fd7-37ef9034286a@kdbg.org> (Johannes Sixt's
	message of "Fri, 30 Jan 2026 07:41:34 +0100")
References: <20260126165618.596944-1-a3205153416@gmail.com>
	<20260128160717.611391-1-a3205153416@gmail.com>
	<04005f67-3ec5-4fa7-9fd7-37ef9034286a@kdbg.org>
Date: Fri, 30 Jan 2026 08:27:14 -0800
Message-ID: <xmqqcy2r83rx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 28.01.26 um 17:07 schrieb Tian Yuchen:
>> +	test_seq 1000 >content_fwd &&
>> +	test_seq 1000 | sort -nr >content_rev &&
>
> Remove another pipe with
>
> 	sort -nr content_fwd >content_rev &&

I agree with the outcome (i.e., we do not run test_seq twice) but
not necessarily with the motivation (i.e., we do not assume test_seq
may fail and care about its failure code, so no need to avoid pipes
for the sake of avoiding pipes).

>> +	(
>> +		for i in $(test_seq 100)
>> +		do
>> +			...
>> +			cat content_rev &&
>> +			echo "EOF" || return 1
>
> This is an incorrect use of `return` outside a function. This must be
> `|| exit 1` (or just `|| exit`) to actually break out of the loop.

Good.

> Of course, the error code is ignored, because it is in the upstream of a
> pipe, so in order to fail the complete command, it would be necessary
> that the original error left an incorrect fast-import stream such that
> the down-stream `git fast-import` fails. Otherwise, the entire command
> can complete successfully in an unexpected way.
>
> Maybe instead of a pipe, dump the stream into a temporary file, so that
> the loop's exit code can be captured?

I like this suggestion.  A temporary file, unless it is excessively
large, has an additional advantage that it allows you to inspect
after "git fast-import" dies on it.

>> +		done
>> +	) | git fast-import &&
> -- Hannes
