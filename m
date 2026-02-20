Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA52E0938
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605324; cv=none; b=Ksvwkl8XWjhrYI9TRyaYPb8RHquOE0WQM8XQ3Tber5bfaOQ2H2+3egZ6Wk3NOVvKzlZ27zdhfeLCE0C7N8iOr3+9ke1tz+xlWEy03WPGFHJrB2+u/P0KdYQ1pgwXANv7lKxmISXmPBxBMs4RlSdh3WALo9b/QtXXWEf5Qu6WHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605324; c=relaxed/simple;
	bh=DJit5LTgU1sCpNnln/K/2M0o6NovYB+LmplafT+Tzfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgJTg1Lk9L4w9vi3XFLKsf2r+Me7f69T5Gj0TzHr1OZ2S7IhFiY+6XlPzGiFYrkDCvTAe5kYTKo1XXDjQilVlBySsv+F4As8vAKYyu+cGHn5MUlk9wSwNW0ONk5QXBNXvXyk2P4tclquMwgV1lf2UD8Jgio1icfRyf8RWUC77eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PPvi436y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQm+iVez; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PPvi436y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQm+iVez"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 38279EC03A2;
	Fri, 20 Feb 2026 11:35:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 11:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771605322; x=1771691722; bh=4Ba/1STJ+l
	ctD1cul2786t2IxldfKWDMfAJuwso34tc=; b=PPvi436yccRUf+XB/a8YRYLaiX
	viz4m5p3BLWIRGUA2gMkV1W5sdELz7t7mfGPxMhCmKCFZ/OW6Lvc8s3KkDsQGWmI
	N7I1u8BmKVlC6YoL4updHxf/o8yRYYKYZjKgKIKi3Fin6O5at//T2GFkhGy4rnQr
	UiTEXULzl8MoVn9l8Rcaw1K7gzFKYpevAjRBmBf61UAw6Q8fBGeRC4pSxdsTjRPw
	S9xkBFglydXqW28T9nCE3058v2eH7pjeZu5rn1+64yO7MVjJ+NeMqqvmCXD4mfYX
	XyEe3DDRaoqGKkD0ii2O5lFmzC9A6NHC4NqVk8QACs7+j5rIduXSnwyV4TRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771605322; x=1771691722; bh=4Ba/1STJ+lctD1cul2786t2IxldfKWDMfAJ
	uwso34tc=; b=XQm+iVezqE3NbeQ07pJXdNuaW4enw7HjJItJPVF376xn94BDvz6
	LX/YLL8E304PYkQldZxbcMSmXfiQibSt5kmNHqQxDRijGZ6NeePd3rwvjI9GItHV
	q7dG2F8u2WFr5qARNIfBvoIy79q94/ZiF6KT0KStdo2r99O9IHd1vfiJrTPbphAZ
	WIeCNgYIPu5VeW6QmbZ0X4DuOA3B+9EmT1LYEL0DpdZ1wxLhtbMfKghVPWRGVXjK
	3vBMlVmnvWnkvEnurIbrj5EPD7tgaBCKduOF6rPadI+NzNaeZETFkzuN0myUiIJD
	oI95WjBtuJ4ZhrOuF3z3LTyk31POVPi1lrQ==
X-ME-Sender: <xms:So2YacDe2r60hLOmyWK5kUCvyhUXLadS6E6nsYF51AKhyoVc6oTCVA>
    <xme:So2YaWTbG6m4b9QDSPczfRxiwZVPF-1qSFJdkZUVHuAM1B4hDI6OW0TIrB4pHUhKi
    TQEhQOzyY608kfyFaiGhgWOuOZMmtYXDrR6DeDxE1w_I5Xi19bvTA>
X-ME-Received: <xmr:So2YaSq9iWpWxg-u6yB5fHsI5gXhIERVo1OSZ1wz1ZosrdXPbVPVo6m0KZCNTYoi_J7C1a9mpT-bBdBbWOTJFajKvCGuThGT4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekvdeuffehuddtjeeuudejieelve
    egvdejieegveekueduieevgfduvdegjeehgeenucffohhmrghinhepmhgvthgrtghprghn
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepugigughtseguvghvrdhsnhgrrhhtrdhmvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:So2YaQzI4vWHYbXkI5BoA6LoUycRrHXcvtmknzGoD3hFstVY7j4H9w>
    <xmx:So2YafL-LLIaJCCPtG-V3rMUZRFqxgPF8v1YqVYwSJafIaYtHf38rg>
    <xmx:So2YaaK5fJBHLeoU13pFBdF6pCTD4fO4NDz8LcT-a6ltHtwxvCb1Sg>
    <xmx:So2YacujJJ_P1P8sq6qPfgkrMhfH7es07OfUQczQBgH1IY8ggCzdRg>
    <xmx:So2Yad7EpRZzHYXX35Brr9hKUHbfzsTJ-c2f_EXV9KPpGZpKrMf-NWXb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 11:35:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Timber <dxdt@dev.snart.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] send-mail: add client certificate options
In-Reply-To: <20260220081717.555185-2-dxdt@dev.snart.me> (David Timber's
	message of "Fri, 20 Feb 2026 17:17:13 +0900")
References: <20260220081717.555185-1-dxdt@dev.snart.me>
	<20260220081717.555185-2-dxdt@dev.snart.me>
Date: Fri, 20 Feb 2026 08:35:20 -0800
Message-ID: <xmqqh5rbz83b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> +sendemail.smtpSSLClientCert::
> +	Path to a client certificate file to present to the SMTP server.
> +
> +sendemail.smtpSSLClientKey::
> +	Path to the client private key file.

Do we want to add "that corresponds to the smtpSSLClientCert" at the
end, perhaps?

> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index ebe8853e9f..51177508c1 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -290,6 +290,23 @@ must be used for each option.
>  	variable, if set, or the backing SSL library's compiled-in default
>  	otherwise (which should be the best choice on most platforms).
>  
> +--smtp-ssl-client-cert <path>::
> +	Path to a client certificate file to present to the SMTP server. This option
> +	can be used when the server verifies the certificate from the client. The

Shouldn't there be a word "require" somewhere in the above to
clarify why a user may want to use this option?  A server may
optionally verify a certificate only when it is given one, but if it
lets us do what we want without such verification, we do not have
much incentive to give them a certificate.

> +	format could be in either PKCS12 or PEM. In the latter case, the private key
> +	can be specified using `--smtp-ssl-client-key` option. More more

Is that "can be specified" or "should be specified"?
"More more" -> "For more".

> +	detail, see
> +	https://metacpan.org/pod/IO::Socket::SSL#SSL_cert_file-|-SSL_cert-|-SSL_key_file-|-SSL_key
> +	Defaults to the value of the `sendemail.smtpSSLClientCert` configuration
> +	variable, if set.
> +
> +--smtp-ssl-client-key <path>::
> +	Optional path to the client private key file. If this is not given and a
> +	PKCS12 certificate file is used, the private key from the PKCS12 certificate
> +	will be used(see `--smtp-ssl-client-cert`). Defaults to the value of the
> +	`sendemail.smtpSSLClientKey` configuration variable, if set.
> +

"will be used(see" -> "will be used (see".

This makes me wonder what the use case is for giving separate key
file with a certificate file with its own private key in it.  The
documentation above clearly describes what happens (i.e., the
separate key file makes the key embedded in the certificate file
ignored), but I cannot quite think of a reason why anybody would
want to do so.  The key in the separate file is still something that
corresponds to the public part in the certificate, no?  The certificate
can say "The subject of the certificate may use a private key that
corresponds to any of these three public keys", and the certificate
file may only have one or two but not all of these three public
keys, or something?

> +	if (defined $smtp_ssl_client_cert) {
> +		# The cert could be in PKCS12 format, which can store both cert and key

The comment confused me initially.  Yes, the cert could be PKCS12
with key.  But the mention of the fact supports what design
decision?  Not requiring $smtp_ssl_client_key here (unlike the next
if block that requires cert when key is used)?  If so, perhaps we
would want to spell that out?

		# We do not check and die when client_key is not
                # given, as a separate key file is unneeded for
                # PKCS12 certs.

or something?

> +		$ret{SSL_cert_file} = $smtp_ssl_client_cert;
> +		$ret{SSL_use_cert} = 1;
>  	}
> +	if (defined $smtp_ssl_client_key) {
> +		if (!defined $smtp_ssl_client_cert) {
> +			# doesn't make sense to use a client key only
> +			die sprintf(__("Only client key \"%s\" specified"), $smtp_ssl_client_key);

Can you wrap this overly long line?

			die sprintf(__("Only client key \"%s\" specified"),
					$smtp_ssl_client_key);

Thanks.
