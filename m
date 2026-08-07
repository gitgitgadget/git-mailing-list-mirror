Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A82EEE90
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140976; cv=none; b=mBZdqTqNrQhlmXhfR58o/XeNNFlm3fUp1At3ZDAmXcnxFGNtfE+uV1ZxpPXd7ziVZ5N6f3Ez2OywBx1Kna2VE2een0KbCKaqo8DHs7c2vZAmfd9tQ0Pl377T5hG8k5T/KXaxep/VPHvHmiyWCQil9LBRMga8mwCzwj3qhLDedQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140976; c=relaxed/simple;
	bh=qNPYD7d8uSph+ad829QHD19J1juqWzynUpmZwGolTOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a/nWRmdIPPdPGATqGTNYD91Fryjd9JDHkrYMUHIJF94ZHgO0k6vNclwPV2GTUtacPhQrVpklO7U0gyYfSlNI6vQA83oAKS3cwYBWzjWGr8+hELJuzoPkGh7L7ydjR6pKIwynOJVpbSdadUnCvIRBa8Zdmb1iiMQHQzNxIvj9wnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GmcbJSJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvMWMeMW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GmcbJSJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvMWMeMW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA1577A0166;
	Fri,  7 Aug 2026 18:16:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786140970; x=1786227370; bh=XW2PVCLWaY
	gb8nBb6at+ifZtd7Rmuv8bsOxGB6p3Cb0=; b=GmcbJSJhIyoRnwMpTJOynVY+5O
	tIvKrznIWTtaXBUZUNnH8RAKCk7R7e6QqIZNEG8ydxM0cqunP2D1WsfB5mIcfCuD
	rztsXfHEkJ/L1xpVZb1zam2sxoEAIajUAnWP6vfuroqgL6JVzNynLbx0O3uSMrwO
	VZWJm7ltzeKoDkbFN4YSA3gNyZy7EBYI8rv4VprtTzaQwQ+A3IVAGwnJrfqYS81f
	wbpa+xPlfl4cbKIsWHiBHwNfIpZZqSXF4OiPt6XVzuxjWaI+IPJ7+eFoTURIHcc9
	BkZT9d4UdMRf+hk5FYlaQQx8zDe4q9jduxtJGLYydiP4e9xBoeAUw6u/3w3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786140970; x=1786227370; bh=XW2PVCLWaYgb8nBb6at+ifZtd7Rmuv8bsOx
	GB6p3Cb0=; b=jvMWMeMWRf9ZXujNMwntIhuqvfla6ttYAjP3b0xgTv5qinoW6Cj
	oMtgSlUovpyI2vbSd2wu6NxkCiW2q0pRi7nf56cbqttuixbJNVh1MS/7YN4ijfxn
	zss9B4G2EaOCfdVlIQNyAdfHElSFlGlKwhhhsOYvr22T8NIZJbaZnIbyZFYNURcq
	nHx3pAwptBBuDLCWhuXV71g3m2RSzQgv2YoNW0grOajnP0BdbnR/uUpaHeEFyJSU
	1Bo7XaQMGf3oQwFHdB9jDSA25Ey5Ykp+FtEq8IOGodT+a1bq8++943RLN+3WSsDg
	m48HosQv2qrfJLWv4Pqxq8IBJ7lMg974Q0Q==
X-ME-Sender: <xms:Kll2avq3YYha_zXJJUbgCf6znp_3WA6n8CCEAbzdT3X_0XQA9qc5HQ>
    <xme:Kll2agqyjKaF-LgqrtID7BBcWvtNBNW1E-eR7NZ3XkPwfGEXfV3Mqt8SotNM0xV1p
    Z20A5Nx2bZcoz8EupvpfKsNLtueCbnUgxulXpt0_GTnDhvmZzwUag>
X-ME-Received: <xmr:Kll2ahPY_ozmU5K73d1Mwmsd0vCCTCgy42iZC2of0mhpCknFCX5nLrban3E8JNirOEie5h81gJ8AazgkFZXMuucLPSEbvTIj-A>
X-ME-Proxy-Cause: dmFkZTGJ/tLSGOW2qpOZksQnToJQc5JGasp1Zg1U+5uocC+v4BTMhOYbB8xnhzfHOl4AiW
    k4cJJlqZV1Did2wGqSZhoC0tIWcOhUl9Sv7P/EAbN/iSw/eDAEPY6v5p7Ho9aAq26djLzi
    3HA7aUqIWgf9iIOyLRXaidGzF3B5ildYyQFZvwU7HkgY9znlL779GUS9ubUXyWfgYLj1ve
    8suDmn0VIzMimPcUhMpzV3RbkzOKTaBhktf5U9zkPNoimL1abVSpe71nrYsYxmLWbKs6ln
    7Szd7bjaIvBrl3MBrdPDTmW3RHyZcDGZsCiMAfyYUvsEkuz7XuyUCqFn0YFZ0X4Ddk/MX0
    xOdpigtzGJsyFBdAqUrnBtXpd9RqpjzehgPinoFhYb5D8+zWzo6zhDpW4L4YA1rHkLA+Pl
    wKSpEi8b0M6U6d3pImsT6c+DEhCODSL+yepSC81HXRdA5S+gbK5oKB5Icj2l21wQzaomrw
    ky6nS3Ned/6PJFfpGQ9UG/afyHfeSJB2wcXXoBK83QAGyrrqzU7PKcAo6uxxWTwOTn3FTw
    Pxw7tenClk+HZq73PshwVpEX8onkhk/XwgwKyRVqSz3kRdXWgzGYt2f1s+7cP8A+PS6roX
    2qJJTg/M42Nx1QPHs/MrawxjkCsoimaJ8a5aYpO6felaFAA84pzzJzpxG7gQ
X-ME-Proxy: <xmx:Kll2ahwgR4NIY66DF0jmy9ilc0Hgf0v_dCOZQL50HMPqTYPQEsI4mg>
    <xmx:Kll2aqsJM1vdGuRAmMhrYANRHiClDjOjb-lRqzK3M2P4EWNtY5L3gA>
    <xmx:Kll2aq4NpTF-UEjb8sYSemwbeEBayn-XO6Eh-BQVCSAWiL65M1FSrA>
    <xmx:Kll2apQ65HW_J4QDHzW0mRvsSmcvZK5YrXGDEfmbFUAeFnPpcHHG2A>
    <xmx:Kll2amlngFcvEnXWzSfAY7oHA-Fcpuw_FyDWslKaqRB9HxnmayWnC1Es>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 18:16:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Tim Wiederhake via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tim Wiederhake <twied@gmx.net>
Subject: Re: [PATCH] gitk: add user-defined custom commands
In-Reply-To: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com> (Tim
	Wiederhake via GitGitGadget's message of "Tue, 04 Aug 2026 21:43:59
	+0000")
References: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 15:16:09 -0700
Message-ID: <xmqq7bm1d1au.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tim Wiederhake via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +    set len [string length $cmd_template]
> +    for {set i 0} {$i < $len} {incr i} {
> +        if {[string index $cmd_template $i] eq "%" && $i + 1 < $len} {
> +            set next [string index $cmd_template [expr {$i + 1}]]
> +            if {!$blame_computed && ($next eq "b" || $next eq "l")} {
> +                set blame [get_blame_origin]
> +                set blame_id [lindex $blame 0]
> +                set blame_line [lindex $blame 1]
> +                set blame_computed 1
> +            }
> +            switch -- $next {
> +                "%" { append cmd "%" }
> +                "i" { append cmd $id }
> +                "t" { append cmd [lindex $commitinfo($id) 0] }
> +                "a" { append cmd [lindex $commitinfo($id) 1] }
> +                "d" { append cmd [lindex $commitinfo($id) 2] }
> +                "c" { append cmd [lindex $commitinfo($id) 3] }
> +                "D" { append cmd [lindex $commitinfo($id) 4] }
> +                "m" { append cmd [lindex $commitinfo($id) 5] }
> +                "M" { if {[info exists markedid]} { append cmd $markedid } }
> +                "b" { append cmd $blame_id }
> +                "f" { append cmd [get_diff_file] }
> +                "l" { append cmd $blame_line }
> +                default { append cmd "%" $next }
> +            }
> +            incr i
> +        } else {
> +            append cmd [string index $cmd_template $i]
> +        }
> +    }
> +
> +    if {[catch {exec sh -c $cmd 2>@1} output]} {

What do various members of $commitinfo field have?  I presume that
title and message are pretty much free text under control of anybody
who can write to the repository and entice you to run this command,
so running with "sh -c $cmd" would require $cmd to be quoting the
payload properly, or you'd be opening yourself to be an arbitrary
command execution, no?  With template "echo '%t'" you thought you
are just printing the title but if the title has "title?'; echo no'" in
it, wouldn't cmd end up being 

	echo 'title?'; echo no''

and a more creative type can use something other than "echo no", to
have a process run under your name and do more interesting things,
right?

Note that I no longer speak Tcl (even though I admit I used to), so
if there is some "magic" that makes use of $cmd in {exec sh -c $cmd}
safe, the above may be missing the mark by a mile.
