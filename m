Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F341F2B88
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895936; cv=none; b=TcxuBH2IB1Hvq3pFQEzGJHMNMUgYDCphk5jClgZu6UV6UF3eo2sgBRvuPz7OSq4bHpHI1uOeBDRH2XCT3Cgo6W25NebG4K5Qu8k6yxRjeluUPxYat53tE+S6JcFE4yz9z9gaw+D3X7nqymSAOpU50VzDKlY+i4qusChIUomscv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895936; c=relaxed/simple;
	bh=DQMtZebp/Su20CpBOVVbK8X1v8DVX0uGVr0MCgtj5Ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FepnATh8giDJc1PiP8r/oRUCDpUZxhtrLf8WwM5ZbcQ+3xmUdZ4Jlfso8S8mMDsXdOs+MCDNbOcG+2TaLqj17PVgnQLE7Up9Jo25h6AFeWlu5SoxRfVmtXK7J9Jo8rw/1USo10rBLxAuzASU9oZBbA5Ha20xzdPlGNus6sglxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I41HQzmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAoG/1uz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I41HQzmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAoG/1uz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D62C11401C0;
	Thu, 13 Mar 2025 15:58:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Mar 2025 15:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741895933; x=1741982333; bh=T/iQTqfv9/
	d48h56Sq3Rp2G0v1MD/PQs4XRBzZ6D2ok=; b=I41HQzmU4LiWnuhH5fR1iauzTh
	RCdUAzs3i8hExVBIPHc+Xrrf0El3sKcTpHqBwlTC1Whz3G/L5cAk9n+3idpnA14l
	kGCzTRI0Y+6zXs5DS4POzOKYhXIYyMVAu/eGN4zPvuHcUKjnUtHDzX4Xh5jVBYd9
	k3wTSglc5gY64U/CvosiGO3MKKmahxu3g5TwW7fxSWdPkVVBbsfX+ShOr9Nv0ovw
	d7WVgk5VAAsGXN2vgpPwXSd1KOcDO5egAQKRt8ikf1nrxZI22zKPOceWUigFC1iR
	rzdeUTKRnz6Fxh0/P1k3eOhOugXNCq1rJqWih3y+wlmgqF0AzMYUty5mcWWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741895933; x=1741982333; bh=T/iQTqfv9/d48h56Sq3Rp2G0v1MD/PQs4XR
	BzZ6D2ok=; b=OAoG/1uzieLk+GGcQE098RXvqubgWBtpqJQxSRlnqaGPqxOGJGg
	iT9W9LYrQepPqSqb5WM6sP8APs7tQ71z0y35coW7UJyGqUJ3DJ9+oFzfhM/9gk87
	2br9zwiZlzqshAsBqOJSMQFUFDWtZ7xijM4ZMs1+pf1aD2kkLfI5f5t/4tFwtPoA
	1KtI1iIRyDrF23Tfm763hN59GzlnXEbs9+YiwM/fX+1hWN9gVw/EUsoX8kbIJPB3
	a3XBBezoi0d1KpjyP/o/UwRfUHfkiOMeNwJrq7nnjtb9HCtUdVtBb7s4VXnzB4rs
	Nzy0qZ/roogzQrt7b9RPabmB/JjHa8VHvtg==
X-ME-Sender: <xms:_TjTZ5skEAybbrf1AGPuOM3BjDzVT4PdMXANe6lNulZVbIfiBn9BoQ>
    <xme:_TjTZyf0nBRqADChoVon-EqSEQIISAmBhBt5QQdXkypqct-fN1UVfnuIsicpiCPT0
    ql3GdD59CGPb5PaFg>
X-ME-Received: <xmr:_TjTZ8xWg6eCMxv5F4N6AK1RTG7I4oDHFmGBdntOH0gs350Uev46L7nkbpP-YDJFN4g1lodSZws4uDRZ_unzdeC5Yx6bqpOO2HxLp3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dviedvffelffehvdeghfeihfeggfegveeufeeufeeugfegvddtudefheehheetfeenucff
    ohhmrghinheprhhftgdqvgguihhtohhrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptdehii
    ihtheftdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_TjTZwOp2oMmMsqT6Ja5ChctWSv0s52TkSWK-FMY6K6QJ8Q0T2iiaw>
    <xmx:_TjTZ59s-jxgrFZMb8PejkCNwFTlDVQirDvnBIqZkjVG84rnPV_QRQ>
    <xmx:_TjTZwW2sXn9JbuBv67ubl86SgvBvpIzf33fRKZcob_E2udKKzA7dw>
    <xmx:_TjTZ6ePbA9Jzats3enx5xeRB8iD9d9PIJPPZIAYZl6VMgrdE2JIbA>
    <xmx:_TjTZ0b3Vl-QNamtS23fK6h_hi27Gj3uH-KBzbkk7gucZRNGpiNYtOWL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 15:58:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v3 1/1] Unify SMTP auth error handling
In-Reply-To: <20250312064639.668875-2-05ZYT30@gmail.com> (Zheng Yuting's
	message of "Wed, 12 Mar 2025 14:46:36 +0800")
References: <20250312064639.668875-1-05ZYT30@gmail.com>
	<20250312064639.668875-2-05ZYT30@gmail.com>
Date: Thu, 13 Mar 2025 12:58:51 -0700
Message-ID: <xmqqsengn1ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zheng Yuting <05zyt30@gmail.com> writes:

> Refactored SMTP authentication to use a unified error capture block for
> both SASL and plain methods. Errors are now handled by parsing SMTP status
> codes (4yz for transient, 5yz for permanent) instead of relying on regex
> matching. This change improves clarity .

"improves clarity ." is (not well formatted and) a bit subjective
and does not apply to all three changes the patch is making here,
does it?

> Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
> ---
>  git-send-email.perl | 72 +++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a012d61abb..532dda264c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1411,7 +1411,7 @@ sub smtp_auth_maybe {
>  	eval {
>  		require Authen::SASL;
>  		Authen::SASL->import(qw(Perl));
> -	};
> +	}

Hmph, the interpreter may tolerate the new block-eval "eval {}"
simple statement that lacks terminating ';' but is this an
improvement?  The original look more kosher from syntactic point of
view.  It seems to be totally unrelated change from the rest of the
patch.

> @@ -1426,42 +1426,56 @@ sub smtp_auth_maybe {
>  		'protocol' => 'smtp',
>  		'host' => smtp_host_string(),
>  		'username' => $smtp_authuser,
> +		# if there's no password, "git credential fill" will
> +		# give us one, otherwise it'll just pass this one.
>  		'password' => $smtp_authpass
> -

We seem to already have the comment added by this hunk, since
4d31a44a (git-send-email: use git credential to obtain password,
2013-02-12).  Am I looking at a wrong version of the source (or a
wrong version of the patch)?

>  	}, sub {
>  		my $cred = shift;
>  		my $result;
>  		my $error;
> -		if ($smtp_auth) {
> -			my $sasl = Authen::SASL->new(
> -				mechanism => $smtp_auth,
> -				callback => {
> -					user => $cred->{'username'},
> -					pass => $cred->{'password'},
> -					authname => $cred->{'username'},
> -				}
> -			);
> -			return !!$smtp->auth($sasl);
> -		} else {
> -			# Handle plain authentication errors
> -			eval {

And curiously we do not seem to have this else clause with the
comment that is getting removed.

> +		# catch all SMTP auth error
> +		eval {
> +			if ($smtp_auth) {
> +				my $sasl = Authen::SASL->new(
> +					mechanism => $smtp_auth,
> +					callback => {
> +						user => $cred->{'username'},
> +						pass => $cred->{'password'},
> +						authname => $cred->{'username'},
> +					}
> +				);
> +				$result = $smtp->auth($sasl);
> +			} else {
>  				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
> -				1; # Ensure true value is returned
> -			} or do {
> -				$error = $@ || 'Unknown error';
> -			};
> -		}
> -		# Unified error handling logic
> +			}
> +			1; # Ensure true value is returned if no exception is thrown.
> +		} or do {
> +			$error = $@ || 'Unknown error';
> +		};
> +
> +		#check if an error was captured

As I do not see two evals in our copy of git-send-email.perl source,
it may be moot at this point to comment on this patch, but if we did
have a eval block each of the if/else arms, moving the control
structure around and turning "if eval {} else eval {}" into "eval {
if ... else ...}" may make it cleaner to see what is going on,
especially if we plan to extend the choices and add elsif to the
chain later.

>  		if ($error) {
> -			# Match temporary errors
> -			if ($error =~ /timeout|temporary|greylist|throttled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\s+error/i) {
> -				warn "SMTP temporary error: $error";
> -				return 1;
> +			#Parse SMTP status code from error message in:
> +			#https://www.rfc-editor.org/rfc/rfc5321.html

Have a SP between "#" and the comment body.

Using the numeric error codes allows us to give more precise errors,
which should be a good change that can be done regardless of the
eval change.  IOW, this part should be in a separate patch on its
own, either before or after the if-eval-else-eval change. 

I'll stop here, as the patch does not seem to be designed to apply
to our source tree.

