Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8CE18CC1A
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945958; cv=none; b=i93mknXduznRLj9ZgkDENNDU4XgBskTZMgIjz7oSSymcaPQQurSLqPE2lCAAiZE4Z4X5Qn78Fmfg//kcLy6NtnkFOO/0DLSrUFmM4+bOuFHF9WIpaKoiVDFAXvyJ5XNIaNdJBv4Z13V71PFxpKzRQHSVuKQ0U+K30QwDlCdG1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945958; c=relaxed/simple;
	bh=npqGDPM21QdCYDZ9wNCafe2SxZWACgU52jKqJEN3QBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WX58RTfbtCeMVvMONn1THtpOOOfNW57OzeP+rFNXyL6PRva+RtaxHuH47+MMUOntfjvxvXRm7Cp/L2WIZJXvufeMINBO0QBKbx5+34Ta2XAkS8eWyuokeRNSNwRCyzWWu+tZrEA+hyYVBkODvc+LTHGnmO+FPfrE5OoN4pXT9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3nAvtIV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3nAvtIV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54D6831C2F;
	Thu, 29 Aug 2024 11:39:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=npqGDPM21QdCYDZ9wNCafe2SxZWACgU52jKqJE
	N3QBs=; b=k3nAvtIViqLeoI6n/D8n6nM7ZukOoXvd8B28bIcleGnuOE+HJTf7/C
	JGixtG3TuWrFEEr9WAuYok0fU/IUfCr7DD7MWNi3ZhUFd8okjaFVhKlIHkbvl43l
	odVy8ndMTy+sKHUclpwZalYvcW3j+9w9EOkCPhz1N64J31jHSgZjg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A68C31C2E;
	Thu, 29 Aug 2024 11:39:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC56A31C2D;
	Thu, 29 Aug 2024 11:39:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
In-Reply-To: <20240829091625.41297-2-ericsunshine@charter.net> (Eric
	Sunshine's message of "Thu, 29 Aug 2024 05:16:24 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240829091625.41297-2-ericsunshine@charter.net>
Date: Thu, 29 Aug 2024 08:39:13 -0700
Message-ID: <xmqq7cbzxrry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D862B686-661C-11EF-842D-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> "?!LOOP?!" case is particularly serious since it is likely that some
> newcomers are unaware that shell loops do not terminate automatically
> upon error, and it is more difficult for a newcomer to figure out how to
> correct the problem by examining surrounding code since `|| return 1`
> appears in test scrips relatively infrequently (compared, for instance,
> with &&-chaining).

"scrips" -> "scripts"

I'd prefer to see "some newcomes are unaware that" part rewritten
and toned down, as it is not our primary business to help total
newbies to learn shells, it certainly is not what the chain lint
checker should bend over backwards to do.

    ... particularly serious, as it does not convey that returning
    control with "|| return 1" (or "|| exit 1" from a subshell)
    immediately after we detect an error is the canonical way we
    chose in this project to handle errors in a loop.  Because it
    happens relatively infrequently, this norm is harder to figure
    out for a new person on their own than other patterns (like
    &&-chaining).

> Address these shortcomings by emitting human-consumable messages which
> both explain the problem and give a strong hint about how to correct it.

"consumable" -> "readable".

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ...
>  # Input arguments are pathnames of shell scripts containing test definitions,
>  # or globs referencing a collection of scripts. For each problem discovered,
>  # the pathname of the script containing the test is printed along with the test
> -# name and the test body with a `?!FOO?!` annotation at the location of each
> +# name and the test body with a `?!ERR?!` annotation at the location of each
>  # detected problem, where "FOO" is a tag such as "AMP" which indicates a broken

"FOO" -> "ERR"?

> @@ -619,6 +623,15 @@ sub unwrap {
>  	return $s
>  }
>  
> +sub format_problem {
> +	local $_ = shift;
> +	/^AMP$/ && return "missing '&&'";
> +	/^LOOPRETURN$/ && return "missing '|| return 1'";
> +	/^LOOPEXIT$/ && return "missing '|| exit 1'";
> +	/^HEREDOC$/ && return 'unclosed heredoc';
> +	die("unrecognized problem type '$_'\n");
> +}
> +
>  sub check_test {
>  	my $self = shift @_;
>  	my $title = unwrap(shift @_);
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

With the hunks omitted before the above two that let us tell between
RETURN vs EXIT, the above two makes the problems much easier to
read.

All the "examples" (self tests) and changes to them looked sensible.

Thanks.
