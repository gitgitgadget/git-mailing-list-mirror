Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5530C37E
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357611; cv=none; b=sM+L1d82IdBl2bjEro1TDDyyHwzxuIHkFS1ATcKqp2583jGFzp307Y9n41guAFl62sJxQPGr1DW/WXKm7pybj3c8NfbAydiUKGuce5/3tA68m1+kWlGo6jG9+ZGQxp+1yPdr59Otq4aAnx/QO/XOQCMWvBXTm3JpO37alDIsNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357611; c=relaxed/simple;
	bh=ld030ubdbbqJBBIf7wqC2SEpuexqqlypBpbDy31om3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqJeuOxeyo6sJDHuvisX1/EuSIRzYAK7EusuYKAP7mnO3xtVvC+nzyapOoBZjVIh3oSldN7CT242/7SLlUzJdSLJ6yQlTNRe2Yre3AHBYIpPRmlwBmvC1AUFneczmwrPwKRwmOMXaxPDu24T0f6BLXOI984IFcdEVtQvf/YDR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rMiCecHD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXGnpge6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rMiCecHD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXGnpge6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1502C1D0023E;
	Thu, 16 Apr 2026 12:40:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 16 Apr 2026 12:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776357608; x=1776444008; bh=tO2bIP5ND9
	EjWJsrPWXXvW+nSRaTpWW+4rmohM9l+bw=; b=rMiCecHD7pzDo/AX55yVe4DJQU
	Mb56YZIk7xbamhgQKlkIrYRG50OHBK3rlak16YdftV6K44tBpzHgzsosq6JIV4fy
	2yC94nYNpjtR5v7j+tsWUHcuzV5vciQT387M5VbSdjzDaXzwMyQQLsdNlVjOMvoO
	2B6myCtdS5MEzhfm5UGvC/2RipZaubT9KmZ03d+gfmQg2/wpduRcpLr6fbBWzAaL
	B/LT54ziDGNLf56ftszk5Y/Ea93z/+OOOs064bbRdstIVNWANDychOZSHPi8GAZc
	2Bfywnr2+vrTFExmHYh5E4F70o9IinP3/SHHlCkk2Ww7NqJ2dVzuXk5MRO3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776357608; x=1776444008; bh=tO2bIP5ND9EjWJsrPWXXvW+nSRaTpWW+4rm
	ohM9l+bw=; b=uXGnpge60yIhd6n5rtBYAV1IHySxlY87AFgYODCMq+0o13fSNao
	nq/ZkXshN1CqalxA/zsP/ooPUshZBF5nCk0zy5HjOKX9IlyZnfaZ1LwJhm7Yr3+W
	omD23T8e1Kc1raTpsIts57K/nmGQfhHlsjMjhAdRI8yRagVe79nJCPXvOpobSEgX
	d4T+nEzeTJiq2EOzgzxlcjJX5/hJ05qNtWLnqSITdv/Z27PuDxjCxMQ7Y0kKzXQJ
	DfSDEwtjoGwemw9U+rkoWCl14hTAuLq91q9InCPosblDnQ48v5oYtPbJAMmcEe+C
	9hvt/BWNAGdVt265PtHTdNm5rp32WwAP2Rg==
X-ME-Sender: <xms:6BDhaT7KMA4iWEPcBGqkgKLdQ_fRuyhV4hnXEOh8pXdSRPoDofLEYA>
    <xme:6BDhafy2zjCRCEknEE-gW5J_aonnvLC-fRddLchF6_rH0-uLzAI2xWEHwX6qdwonF
    -KhzE1Zmb3CgXlbjwf8emB1vHlkBcjpURzhN4yW4qFm2QR0LCXM>
X-ME-Received: <xmr:6BDhaSzkzFtPlVkZxaqqgxTMHM66eB8hW0jovjYkRdWo0nFDUCZVABdqnPHWsGsiWn2ur6WlWzQxrG4kMKZqsWHmq9DFSB5WYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeljeehffefgfejgedvvdejfefhieelvddvvefgtefghfefieekffekteeludfg
    hfenucffohhmrghinhepvghmphhthigruhhthhhishhhohhrrhhisghlvgdrihhtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmjhgthhgv
    vghthhgrmhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:6BDhafzYbTHsRhCZz2bdCgRXQw5-3vONsuvrd_LWUwuuaoaWbCwUrQ>
    <xmx:6BDhaUaIHYKWtzONU2oH2A5mbmqBKvQDCbkUpUQ8JdBb1fILMAhMPA>
    <xmx:6BDhaYVDhkcxwmYsAruSAtGrPBdvQ0KDyQf9NMahc6wcWFjZIwmlDg>
    <xmx:6BDhaaiFqf_wNFJOC3sxIIej-h5pYMiXwkwAi3wOlYnPqIdluCY6lg>
    <xmx:6BDhaTKRgp1pHgF2T1zCYWXtLW755fz7_atNGHHBVX_QIk42A_XNFR0u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 12:40:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Matthew John Cheetham
 <mjcheetham@outlook.com>
Subject: Re: [PATCH 2/3] http: attempt Negotiate auth in http.emptyAuth=auto
 mode
In-Reply-To: <f175294459c9370ed79c8338d6008b69c2028f99.1776331259.git.gitgitgadget@gmail.com>
	(Matthew John Cheetham via GitGitGadget's message of "Thu, 16 Apr 2026
	09:20:58 +0000")
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
	<f175294459c9370ed79c8338d6008b69c2028f99.1776331259.git.gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 09:40:06 -0700
Message-ID: <xmqq7bq63lll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> When a server advertises Negotiate (SPNEGO) authentication, the
> "auto" mode of http.emptyAuth should detect this as an "exotic"
> method and proactively send empty credentials, allowing libcurl to
> use the system Kerberos ticket without prompting the user.
>
> However, two features interact to prevent this from working:
>
> The Negotiate-stripping logic, introduced in 4dbe66464b
> (remote-curl: fall back to Basic auth if Negotiate fails,
> 2015-01-08), removes CURLAUTH_GSSNEGOTIATE from the allowed
> methods on the first 401 response. The empty-auth auto-detection,
> introduced in 40a18fc77c (http: add an "auto" mode for
> http.emptyauth, 2017-02-25), then checks the remaining methods
> for anything "exotic" -- but Negotiate has already been removed,
> so auto mode never activates for servers whose only non-Basic/Digest
> method is Negotiate (e.g., Apache with mod_auth_kerb offering
> Basic + Negotiate).

Well explained.

> Fix this by delaying the Negotiate stripping in auto mode: on the
> first 401, keep Negotiate in the allowed methods so that auto mode
> can detect it and retry with empty credentials. If that attempt
> fails (no valid Kerberos ticket), strip Negotiate on the second 401
> and fall through to credential_fill() as usual.

OK, succeeding after two attempts is much better than failing after
only one attempt.

> To support this, also teach http_reauth_prepare() to skip
> credential_fill() when empty auth is about to be attempted, since
> filling real credentials would bypass the empty-auth mechanism.

And that is why the previous step shines.  Very neat.

> The true and false modes are unchanged: true sends empty credentials
> on the very first request (before any 401), and false never sends
> them.

OK.  This is a tangent, but "git config --help" on "http.emptyAuth"
is horrible.  It does not say what the allowed values are, so I had
to first write "There are million other things in the system that
this patch does not modify, so what's the point of singling out
these two settings and saying that this patch does not change
them?", before realizing that 'auto' the patch (and the explanation
of the "empty-autho auto-detction" above) is about the third
possiblity of the same variable and take it back.

> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  http.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index f208e0ad82..1c7ea32ef2 100644
> --- a/http.c
> +++ b/http.c
> @@ -138,6 +138,7 @@ static unsigned long empty_auth_useless =
>  	CURLAUTH_BASIC
>  	| CURLAUTH_DIGEST_IE
>  	| CURLAUTH_DIGEST;
> +static int empty_auth_try_negotiate;
>  
>  static struct curl_slist *pragma_header;
>  static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;

I guess the existing code already assumes that we connect to a
single destination, run a single "session", and then die, so it is
in line with the existing design to have a file-scope global keep
track of our "state".  In the longer run we may want to move these
things to a struct so that we can run multiple sessions without
having to kill ourselves and restart, but that is totally outside
the topic of these patches to fix the negotiate auth.

> @@ -667,6 +668,17 @@ static void init_curl_http_auth(CURL *result)
>  
>  void http_reauth_prepare(int all_capabilities)
>  {
> +	/*
> +	 * If we deferred stripping Negotiate to give empty auth a
> +	 * chance (auto mode), skip credential_fill on this retry so
> +	 * that init_curl_http_auth() sends empty credentials and
> +	 * libcurl can attempt Negotiate with the system ticket cache.
> +	 */
> +	if (empty_auth_try_negotiate &&
> +	    !http_auth.password && !http_auth.credential &&
> +	    (http_auth_methods & CURLAUTH_GSSNEGOTIATE))
> +		return;
> +
>  	credential_fill(the_repository, &http_auth, all_capabilities);
>  }
>  
> @@ -1895,7 +1907,18 @@ static int handle_curl_result(struct slot_results *results)
>  				http_proactive_auth = PROACTIVE_AUTH_NONE;
>  			return HTTP_NOAUTH;
>  		} else {
> -			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
> +			if (curl_empty_auth == -1 &&
> +			    !empty_auth_try_negotiate &&
> +			    (results->auth_avail & CURLAUTH_GSSNEGOTIATE)) {
> +				/*
> +				 * In auto mode, give Negotiate a chance via
> +				 * empty auth before stripping it. If it fails,
> +				 * we will strip it on the next 401.
> +				 */
> +				empty_auth_try_negotiate = 1;
> +			} else {
> +				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
> +			}
>  			if (results->auth_avail) {
>  				http_auth_methods &= results->auth_avail;
>  				http_auth_methods_restricted = 1;
