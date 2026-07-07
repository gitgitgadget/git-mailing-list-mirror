Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9D348C7C
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391421; cv=none; b=IPLKTQruyE3U+06oEHrWBO1YBgSky9XbkKny+y/gGW2vTNdxBLeHjZ7dioK+Ut46anV1je6m7JnaLtp+N033bs1S6g3wq2aUykS3/OESg0qDufH9eSgubNPZ4IbGD+3Gav6j7FSNrTYfLRcKux4PE001feY7eYq4jDBla+t5gY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391421; c=relaxed/simple;
	bh=4ttBg5wE8Epaqxf6we7hx8kp16Ynpb6H6ZsCClQ1e1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=el8jPuoTQ0aebNQt5gKNOjiEWPbb8ykc6h7f0QivWg1W+SIM/ANkOcDdvhRVn3vYtMQi9cczVtbWgx1pdsvgTAWEaGxQvyosQqnXZSaNLX0ViwjqkLTy91pFMhSX0Ip2+NqjqkTSJd/8588v+2cgvzhSvI8iGc5BqdR06QRCjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LU4CLG3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jXHnHvBv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LU4CLG3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jXHnHvBv"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D10FEC003B;
	Mon,  6 Jul 2026 22:30:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 06 Jul 2026 22:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783391415; x=1783477815; bh=B8+K0qJRYt
	JBNjpe6O4EK80AUcAmP+xSzdafm1JAa7U=; b=LU4CLG3e1BheRqQ2trv5b/7psD
	ZeD+yDX30r+Y0MBbJlvzqM9Yuoh4j8KIdcwBRoKboaP713kEaufu4dIVGonl7M/b
	j3Mr/V+VheEmVoAdyZeDluQXAdBGHXBAZTloxwcSy9Sv/OsAbsiS32GMfBVjiSaw
	rLRSOjy2G1o4VhP/50S7LPizqHxCVnRfxPvCJqqRbTKgSUIYdaktu4LW2fHVVRLc
	mlhnB7ELLux/0gjIrV9iWz9ff5UbojEsVIkbRSHuzor/ihuzVnW9+sPM0HmoZ0pn
	9Wff4/VUaCy49ZurPUMk6E/Jj+PbZGvqFlKV3oIREqUykhmEL7iI+94DVCMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783391415; x=1783477815; bh=B8+K0qJRYtJBNjpe6O4EK80AUcAmP+xSzda
	fm1JAa7U=; b=jXHnHvBva2zjvBBHqywjduOCu/8JtO6BStsrjg1YTXENUVO2grY
	zcL0k2ouiRop3+Q7Dalqwxn+/tsBd4doT5joxqLMetBxYQpTMWISMp9sj/N3m0TH
	e4xXKKAPhVqwxwpedvDkNzN081TjZbqUeUIEO6KaSBDz4fglyk37EElNM7OEnEsx
	N0EyrpDZywAX+WYyOR45glIg7NxGmZKSSNuAiiIRnlblQn+KXgrnFkK8DItNFT3o
	IytqV0DN5WstH+zAgePUXYzGb/qUwVlbmItC7TXJOGFJ/JAkJNSMqoEK6C1/2U4i
	6cIEOk6voanmEB36Gwla8QsMX527MiboRDQ==
X-ME-Sender: <xms:tmRMahflLlGuRExgClDmeso5NUA6e0dUN0J_Oit2j45495H_xGNwTA>
    <xme:tmRMamP1LDn4ZGk9iDiUamdHaWlTYo6pfIjLC2myoksJQGVTwegTeoO5qV9yQ4xYR
    2UVKJf_6zIbJNyLhLNKTQYZKc6vCgtN8tGOAme9INEuz4xHuRHo-Q>
X-ME-Received: <xmr:tmRMavh6yTv-ANDBUNNKu77xhIYAqAh_LAuHqL9fApkgOCL3hJc0d3Mpqz99m9uoifMP206zEGgt1IWCMztDtc0RoOsC0xoWqFkjoIg>
X-ME-Proxy-Cause: dmFkZTGFJ6gjimzutWKyveVIwRrcHnGANlgP2WSv09kRFpMIWROy4NbCjO5Kunkrikqy5s
    k7MHoO01eGaR9LPLkMZ2ZO7Uy7/e1ho2fKPPMuGRW+vM4El26MKp0X2NS8T/UKhpUWX2vQ
    nEWjaelMvdtEZCsUetiQUiGedMZqpKWeqELNmVI3zHHMppqnWkCbNbAycLuto3BqnMH023
    e1x/nG6DWG6KjvCNHvhuYDwNXT7tmRh3cSCUp7J3j6KMy77lm1neKWmpC2POsjBjDdy5yD
    Ym6KvqN5YkSoKvNIA9ipAS1uO03Z3+pNoHaNqlhydl9Z7Xm/e+N+/2cRd5dp/DVd8F0THw
    iH0kLoyReHaJXYzquTqRmioKCI2X/pzHLzCytldgEcvVRHEWPJYE86z2+90ea4wQdfpDQd
    DIatbAQyAAIJdLWbqo4EVdsAyqN0PVrWduNEK8rSoZQkHNT4O3TGieK5T35UYJ6Pr5SSE2
    6JxH+aINPNj+UKPSnth3A+X+3OYQL0ptMUpg97IFaUhuNUBNodGdkryCPGVNjIomiETmUu
    vGPhAKo5tgPY2QK0hFeokXJr4C+avLbH3qEJqbe8nlwiUIX5oaVaBNApLdNpcZoBcQqgIT
    X6BuZyaT5QbmgxYTXWZa8Z1IRnl7Eqw7CNSiXT9WC3HTKHmmTHZp91rFxi8A
X-ME-Proxy: <xmx:tmRMap05BL_ekY-3XQpaSxL4DUQLrSxXtI3JD6hquDOJ59-l-xJ5lw>
    <xmx:tmRMapjLjBCu_FZdTbka7uwxj_1MmsgaUTiliTYiwD4naYOV28t5RA>
    <xmx:tmRMapeNk1kPuu6MGWSWm4qMEYLZFjJYjJZU443EmRos_KJC4sYsog>
    <xmx:tmRMaskGKLaadW8_mav3R_0oAXnoPOdcSJ4TPlH81EJN2chcWect6w>
    <xmx:t2RMajAH_1zDM2stSkFXrodgXfldCOYqOTqYyYMFbNm6vmKB-QqKIbl3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 22:30:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jamie Magee <jamie.magee@gmail.com>
Subject: Re: [PATCH] t0213: skip ancestry tests under user-mode emulation
In-Reply-To: <pull.2168.git.1783359242130.gitgitgadget@gmail.com> (Jamie Magee
	via GitGitGadget's message of "Mon, 06 Jul 2026 17:34:01 +0000")
References: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 19:30:13 -0700
Message-ID: <xmqqa4s38rbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -# Determine if cmd_ancestry is supported on this platform.
> +# Enable these tests only when cmd_ancestry reports real process names.
> +# The procinfo stub emits no event; under user-mode emulation (e.g.
> +# qemu-user) /proc reports the emulator, not the guest. Spawn test-tool
> +# from test-tool and require "test-tool" in the child's ancestry.

T.r.i.c.k.y. ;-)

>  test_expect_success 'detect cmd_ancestry support' '
>  	test_when_finished "rm -f trace.detect" &&
>  	GIT_TRACE2_BRIEF=1 GIT_TRACE2="$(pwd)/trace.detect" \
> -		test-tool trace2 001return 0 &&
> -	if grep -q "^cmd_ancestry" trace.detect
> +		test-tool trace2 004child test-tool trace2 001return 0 &&
> +	if grep -q "^cmd_ancestry.*test-tool" trace.detect

This will be happy even if "test-tool-trash" that happens to have
"test-tool" as its prefix appears on a cmd_ancestry line (for that
matter, things like "cmd_ancestry-not-quite" that has "cmd_ancestry"
as its prefix would be accepted).  I guess that is OK because we are
testing this in a fairly tightly controlled environment (trace keys
are taken from known vocabulary, not arbitrary strings, for example).

Will queue.  Thanks.

>  	then
>  		test_set_prereq TRACE2_ANCESTRY
>  	fi
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
