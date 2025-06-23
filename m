Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FF1684A4
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701809; cv=none; b=hlhrds4/oRqorZd55/EbhNYPHc8IEKRXK9tZuqRD+GJBWfWmXcb05wkS81kvbwiiNoHzGqASWvOmKEWTT/0gKcNNt9Nw7wDg5bZOl1RzTFnXlYsJwCyi9SNscwln+hsL6yB9/nW2srdOmUwCKgc4X31/e4knmB/65BtxPXx/soE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701809; c=relaxed/simple;
	bh=NO2aagszONwWoaqQzIGdqExdV9O18uUXaRpF+VmFXXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gi24xVKAW9tef8FT2w26v/O5/pHfC8jiScZTv8L6SGKJCRtXNZ3ozkLmG1FaQZi4IopgmILDWE0XJDzZ8I8+lJtB4lxyxN2zpAtGVI+22MZi6MJcGwBg2iccmSFbFK46KUVi6Toxe67P5HptcOHhnEJ2BhUZpwXxdcWXbLEUz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xB+FYC2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lyhHLZR7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xB+FYC2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyhHLZR7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D25A813807CA;
	Mon, 23 Jun 2025 14:03:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 23 Jun 2025 14:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750701805; x=1750788205; bh=jwL0c67c9m
	UAa3vtQ2M+hYiAeFDAAlPrGGIb5FFBWX4=; b=xB+FYC2Fp2TvHmzbEWae+ITayk
	+7YORsr9friS4WhIWDyEj1YSRwVb0J+0ZBjHtu+gbzqpUOf/tKF6b00auQ0t+E5N
	B6IjnLPiz4nz7cWg2Ltl2diyPDsCjO08QifpMkFy2xrdYLq1lJ2gcog9MHy+/ybC
	+FKqMl1w7I10IPa68IecoUvt597a1de+7a5CdsadvhPQee2i1tivlK9xqLwmkWEz
	tvC3CqTfi4lM5VaBHlDncYVHZFnt0NJkMseOnYHZWYL2KDO6V493sD8QpZZqvLgs
	qxhmPNvUlgUb7HfCAb/1H3accgBtik1o4kQLpxDEXZVSIh/2sttEbFVz1VVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750701805; x=1750788205; bh=jwL0c67c9mUAa3vtQ2M+hYiAeFDAAlPrGGI
	b5FFBWX4=; b=lyhHLZR7CcvwAEFIZEESDCeBDxJCDKXCmOdrIcLBVjnNMHsCE/6
	m8l+RMQrsvCHsInYGM8fwnm9BDz3YWkixbG1C1zfBy/3p4t+uq0pj0miiLEZWDxl
	hsdmHRirKhV3Xwv+N0B2tXPazjL0X371Mj0T4P3u41fT7SK7ziSGhpqDyAzlIn+O
	SF5vqwRa0UZ3FlHDbzqSWa2N+n5TsB02ZN6Rkm48O6pMbOO538GJkCjOo6u7EDKN
	H2kZyWUbWRpQRTNRfgQW7RgN3pU427DxYILRl+YSRnUg/DovvqZzZxzpBDIgPl44
	s2laYYU35XaemiiNlsZuMRQimVhLjOT389Q==
X-ME-Sender: <xms:7ZZZaJYi1iM65aL_p_BlsUIRpKMoNSJJF2PCJ2pGXhhiVq0Q_F7K-Q>
    <xme:7ZZZaAaafeMZDcOOQ6QnKURVfb5d4cCAaP2Oe1JS6zYc0AcK6RFvAZBEPfDVtbLpq
    _aKJHwVC91avsFwjQ>
X-ME-Received: <xmr:7ZZZaL9QxN0RNbILYHrg0LIPL1DK70J6dNzOSJM5hLcOSyksRqmLRrqLtgZxYpwRq2TzU_LKp3QGUxXLtqIxlTxe46vXOjfKNitd9n0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrgigihhmsehguhhigihothhitgdrtghoohhppdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7ZZZaHpnGSRavEKHDxz_XA4KLxxoUtp5pP73uJbc-CzDCnuZczxliA>
    <xmx:7ZZZaEpvhJ6LAKVNOzJYcyoytkxgz-8YJBwPjphEVZvJnZYck3-anA>
    <xmx:7ZZZaNR6fr-wBQZE3RT_jyiIjYS9nlItMnM5IxhnmvwxUmssDuILiQ>
    <xmx:7ZZZaMpVQrGocqnVa-KI_CkS2KhlWPv8Ar2pOCEqdIpRHptojXvHiw>
    <xmx:7ZZZaABwOzC0IzlY20233KBAigBbpX6q7btiZecDh_MrKngtIpSYSZqu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 14:03:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] contrib: better support symbolic port names in
 git-credential-netrc
In-Reply-To: <20250622152535.11837-4-maxim@guixotic.coop> (Maxim Cournoyer's
	message of "Mon, 23 Jun 2025 00:25:35 +0900")
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250622152535.11837-4-maxim@guixotic.coop>
Date: Mon, 23 Jun 2025 11:03:24 -0700
Message-ID: <xmqqh6065o9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Cournoyer <maxim@guixotic.coop> writes:

> diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
> index 09d77b4f69..72d6b6a974 100755
> --- a/contrib/credential/netrc/git-credential-netrc.perl
> +++ b/contrib/credential/netrc/git-credential-netrc.perl
> @@ -268,13 +268,16 @@ sub load_netrc {
>  			next;
>  		}
>  		if (defined $nentry->{port}) {
> -			if ($nentry->{port} =~ m/^\d+$/) {
> -				$num_port = $nentry->{port};
> -				delete $nentry->{port};
> -			} else {
> +			$num_port = Git::is_port($nentry->{port});
> +			unless ($num_port) {
>  				printf(STDERR "ignoring invalid port `%s' " .
>  				       "from netrc file\n", $nentry->{port});
>  			}
> +			# Since we've already validated and converted
> +			# the port to its numerical value, do not
> +			# capture it as the `protocol' value, as used
> +			# to be the case for symbolic port names.
> +			delete $nentry->{port};
>  		}

OK, so we rewrite textual service names into port number, and
normalize the "host" member of the entry read from the file into
"host:port" form.  Earlier we did that only for numeric port
numbers.  Nice.

> diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
> index 67a0ede564..8a7fc2588a 100755
> --- a/contrib/credential/netrc/test.pl
> +++ b/contrib/credential/netrc/test.pl
> @@ -45,7 +45,7 @@ BEGIN
>  diag "Testing with invalid data\n";
>  $cred = run_credential(['-f', $netrc, 'get'],
>  		       "bad data");
> -ok(scalar keys %$cred == 4, "Got first found keys with bad data");
> +ok(scalar keys %$cred == 3, "Got first found keys with bad data");
>  
>  diag "Testing netrc file for a missing corovamilkbar entry\n";
>  $cred = run_credential(['-f', $netrc, 'get'],
> @@ -64,12 +64,12 @@ BEGIN
>  
>  diag "Testing netrc file for a username-specific entry\n";
>  $cred = run_credential(['-f', $netrc, 'get'],
> -		       { host => 'imap', username => 'bob' });
> +		       { host => 'imap:993', username => 'bob' });

Is this rewriting an existing test, instead of adding a new test to
trigger a feature that didn't have a test coverage, while keeping
the old test?  I am wondering if we want to ensure that both
":port"-less case and "host:port" case keep working even after the
change to -netrc credential helper in this patch.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index 6f47d653ab..1fa535e1ad 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1061,6 +1061,21 @@ sub _close_cat_blob {
>  	delete @$self{@vars};
>  }
>  
> +# Predicate to check whether PORT is a valid port number or service
> +# name. The numerical value of PORT is returned, else undef if
> +# invalid.

Hmph.  It _can_ be used to validate a random end-user supplied
string names a port, either by being a port number in the valid
range or by being a valid service name.  But another use case in the
code after this patch applied that is equally if not more important
is to ensure that a valid port specified by the end-user is turned
into a port number.  We should not name such a sub as if its primary
functionality is to serve as a Boolean "is_foo".  Perhaps call it
port_num or something?

> +sub is_port {
> +    my ($port) = @_;
> +
> +    # Port can be either a positive integer within the 16-bit range...
> +    if ($port =~ /^\d+$/ && $port > 0 && $port <= (2**16 - 1)) {
> +        return $port;
> +    }
> +
> +    # ... or a symbolic port (service name).
> +    my $num = getservbyname($port, '');
> +    return defined $num ? $num : undef;

Wouldn't "return $num" work here?  getservbyname() would return
"undef" when the given $port is not a valid service name anyway, no?

Or even "return scalar getservbyname($port, 'tcp')" without an
intermediate variable $num?

> +}
>  
>  =item credential_read( FILEHANDLE )
>  
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 0c1af43f6f..3e749175ab 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -201,6 +201,13 @@ test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
>  	test_cmp expected-cc commandline1
>  '
>  
> +test_expect_failure $PREREQ 'invalid smtp server port value' '
> +	clean_fake_sendmail &&
> +	git send-email -1 --to=recipient@example.com \
> +                --smtp-server-port=bogus-symbolic-name \
> +		--smtp-server="$(pwd)/fake.sendmail"
> +'
> +
>  test_expect_success $PREREQ 'setup expect' "
>  cat >expected-show-all-headers <<\EOF
>  0001-Second.patch
