Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E8DDA6
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925821; cv=none; b=UGR7AlnXQGsG+stvxftwuQDZmqj7wnq8uZbv8f+wzk59p0WC3JOdVB8+F7Hfg8nJcVABK8S0MSoSlUU7x72UpsM6vgmHuc3bikQ8t9gRQg1klJWGdlTFsCvXL5wDAXcKJGiBi0CAMaPUgjPGLrrHqKEKDHAVN68jHyijhDSTn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925821; c=relaxed/simple;
	bh=n/MDD9wbXn2JBeWvXDhMcU3rfXwinbNcvihB2A056Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEGTsKazuqIr7a3UUu9MhGhOyJ5P5ECx5JwBixWzdicx5juIijwWCYt6nHsR//55u9ACyjR/CShyR7kiC0dNPAj9S2nuhS/dB7bE/4nFbCNrhbWvY8D2/QSmDloAb7+l4yvLSxUFAslUarIclmZC8vZaoJgU19gbtjZkQiSRqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mM4+hDuA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwSocbAA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mM4+hDuA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwSocbAA"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2EAE61151BB6;
	Thu, 29 Aug 2024 06:03:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 06:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724925819; x=1725012219; bh=zO+5h/bTa8
	KWZiskOcAkcHOs42un+cqsSt/hrEUrVAc=; b=mM4+hDuAEl2Xzw2E03atmswZmu
	O7PXFMANXycnC4Qw6lOLDPRulI0rxCZ/2CIP2nlJGvBjM9g+ozywSHZsKXKaY1fq
	sWAS7674JNCtvPk3N50EwomAKDyYLzVt8sMqWnjLIvdvv8POQNkWu9RpucmbrUOz
	pv1/LnwBPKC+oAFxo4u4XFVZvxyzSMCQuvlyzMmeVPrtOhmu8PAjXk+MvTOoiW1f
	qPDmBmHjPcLAby6AsiUaC1PAkk9vZQ02c9QEugETfQhW6B6Ch0IRBazyh+69s04F
	HPi8UGTzCgsLC2YQzTubi0N0qLkBBnHSSql+EaB3bVWoxWtNjdXkJLfkdK1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724925819; x=1725012219; bh=zO+5h/bTa8KWZiskOcAkcHOs42un
	+cqsSt/hrEUrVAc=; b=mwSocbAAGgpfgPYDgR7OUna55bpveihJVEP9dvhpKJqT
	Pkhz0ryqdnCcrI1+t2oQFGegnRoaf7DxylOgHoG7a/ij0i5V+ffOv9LfUw4L8vYI
	7ovPN4tbtGTpO0pmMtN/qlDhB+7mclEQHo9PA+BZpyp+/CfDfuFgQcMCQehAex6t
	EFHKKzctDz3L1v9Bs79yH7Ob6AgaMlfZBLhKE+xjbbCRJTviOtj/5Lw+lyJ56yDS
	jDhMdN6BN3sN+tMW2CXoRwG1vN5ngpsPrKCC+cgPhmzdFi6eI3UCs0Id5HAeFY4x
	/64AmD8K9CWWbqNqvQtW4xVVBBw4mwG4wtzi5qYYig==
X-ME-Sender: <xms:ekfQZrStGd1Djz_SGq7FH7xdU2CIk3vBw4u8o-_pe74m6GC57Ax7NA>
    <xme:ekfQZszJ5LfWcRj8pX_aAuCKTDymB7hH534G8qOxBXJOgGNUtQr0I4ydIC8qxQZY4
    SmxOUK-2vFNRn-f7g>
X-ME-Received: <xmr:ekfQZg2MJ8F2OFpxBmN37bSJ9-ad1RIrF3R-3CJ19tmI7C2LPH7u0uGXceFtNjS4NUe-bzS5OaPaENIJsDT51J6RLA-7NDdlQJce0OgHkzbhe_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghrihgtshhunhhshhhinhgvsegthhgrrhhtvghrrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:ekfQZrC7iWzPWGDs_fi4-FOx4MdHrgqOaEEDFUuubvc_x1DtPbJSug>
    <xmx:e0fQZkjOyNfshOKA3LJvbJAhB-YRseMdEbvsFMLjiZv3bAR1S1f58g>
    <xmx:e0fQZvogG2UjX_viDwsLRibXzerSj5_JEBmOw0XgldVSqT7e28mu9w>
    <xmx:e0fQZvg3QxHM2bZLTLRp0QKtMZugH9EC7rRPm_6UYt_YoWt2IkPZXQ>
    <xmx:e0fQZsfNNm0B5SXcGVtOxzGP0lr6ZJ9-3RStFUf2KzGvYCWSuMnPouyK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 06:03:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9002947e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 10:03:26 +0000 (UTC)
Date: Thu, 29 Aug 2024 12:03:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
Message-ID: <ZtBHbftK7vdTEz93@tanuki>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-2-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829091625.41297-2-ericsunshine@charter.net>

On Thu, Aug 29, 2024 at 05:16:24AM -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> The annotations emitted by chainlint to indicate detected problems are
> overly terse, so much so that developers new to the project -- those who
> should most benefit from the linting -- may find them baffling. For
> instance, although the author of chainlint and seasoned Git developers
> may understand that "?!AMP?!" is an abbreviation of "ampersand" and
> indicates a break in the &&-chain, this may not be obvious to newcomers.
> 
> Similarly, although the annotation "?!LOOP?!" is understood by project
> regulars to indicate a missing `|| return 1` (or `|| exit 1` in a
> subshell), newcomers may find it more than a little perplexing. The
> "?!LOOP?!" case is particularly serious since it is likely that some
> newcomers are unaware that shell loops do not terminate automatically
> upon error, and it is more difficult for a newcomer to figure out how to
> correct the problem by examining surrounding code since `|| return 1`
> appears in test scrips relatively infrequently (compared, for instance,
> with &&-chaining).
> 
> Address these shortcomings by emitting human-consumable messages which
> both explain the problem and give a strong hint about how to correct it.

A worthwhile goal indeed. As you say, especially figuring out how to fix
the loop annotations is not exactly straight forward.

[snip]
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index 5361f23b1d..d79f183dfd 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -9,7 +9,7 @@
>  # Input arguments are pathnames of shell scripts containing test definitions,
>  # or globs referencing a collection of scripts. For each problem discovered,
>  # the pathname of the script containing the test is printed along with the test
> -# name and the test body with a `?!FOO?!` annotation at the location of each
> +# name and the test body with a `?!ERR?!` annotation at the location of each
>  # detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
>  # &&-chain. Returns zero if no problems are discovered, otherwise non-zero.
>  
> @@ -181,7 +181,7 @@ sub swallow_heredocs {
>  			$self->{lineno} += () = $body =~ /\n/sg;
>  			next;
>  		}
> -		push(@{$self->{parser}->{problems}}, ['UNCLOSED-HEREDOC', $tag]);
> +		push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
>  		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
>  		my $body = substr($$b, $start, pos($$b) - $start);
>  		$self->{lineno} += () = $body =~ /\n/sg;

I was wondering why this is being changed here, as I found the old name
to be easier to understand. Then I saw further down that you essentially
use those as identifiers for the actual problem.

Is there a specific reason why we now have the separate translation
step? Couldn't we instead push the translated message here, directly?

> @@ -296,8 +297,11 @@ sub parse_group {
>  
>  sub parse_subshell {
>  	my $self = shift @_;
> -	return ($self->parse(qr/^\)$/),
> -		$self->expect(')'));
> +	$self->{insubshell}++;
> +	my @tokens = ($self->parse(qr/^\)$/),
> +		      $self->expect(')'));
> +	$self->{insubshell}--;
> +	return @tokens;
>  }
>  
>  sub parse_case_pattern {

Okay. The subshell recursion level tracking here is required such that
we can discern LOOPEXIT vs LOOPRETURN cases. Makes sense.

> @@ -641,7 +654,8 @@ sub check_test {
>  	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
>  		my ($label, $token) = @$_;
>  		my $pos = $token->[2];
> -		$checked .= substr($body, $start, $pos - $start) . " ?!$label?! ";
> +		my $err = format_problem($label, $token);
> +		$checked .= substr($body, $start, $pos - $start) . " ?!ERR $err?! ";
>  		$start = $pos;
>  	}
>  	$checked .= substr($body, $start);
> diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
> index 338ecd5861..2efd65dcbd 100644
> --- a/t/chainlint/arithmetic-expansion.expect
> +++ b/t/chainlint/arithmetic-expansion.expect
> @@ -4,6 +4,6 @@
>  5 	baz
>  6 ) &&
>  7 (
> -8 	bar=$((42 + 1)) ?!AMP?!
> +8 	bar=$((42 + 1)) ?!ERR missing '&&'?!
>  9 	baz
>  10 )

I find the resulting error messages a bit confusing: to me it reads as
if "ERR" is missing the ampersands. Is it actually useful to have the
ERR prefix in the first place? We do not output anything but errors, so
it feels somewhat redundant.

Patrick
