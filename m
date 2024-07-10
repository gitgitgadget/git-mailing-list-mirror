Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117673BBED
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583948; cv=none; b=g3Hs/T6oKXUIZ7WayyNizrOIjke5uEOj7ThQ5p4STUQP9+R52NwwD/VorZg/ry79zl6A4D8otJWdOuSpxUAgP48MF/c0dzqmagEHC3lXIkxmi35um8K3tvam1+9RlVQD26Z1xc7y5htDJSX8LP+DuXCo7/W6BxXA7ytitOSdj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583948; c=relaxed/simple;
	bh=0jw8GC0PMEiW6oJtxowyBVDDtOTvSJNe4h01ExnDl7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oC2olTSsFLXOlGLY9EQ2z5V5jcBREXjYtNYJB5kQP6nU6+wC0WkLqjxq9DU6xOYAQyZD3g+rz8d+bOk+MO2VUQO3DEf2WWJ73X6cFObHniHs1guAINS27wygUp21o5cExB1iK0dWBQOARFj898fUQBVMInfckt5xpjVYwLP9W0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OEfz0TfZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OEfz0TfZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 52A652FA3A;
	Tue,  9 Jul 2024 23:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0jw8GC0PMEiW
	6oJtxowyBVDDtOTvSJNe4h01ExnDl7o=; b=OEfz0TfZaskLtpRs7U2XE+DgMz5E
	M35E5aS7Q4NATLhLnDdUBEI2uRDFof8dd4/HY+tEVAa3PlfOQBdkl4ncsBhaWbUV
	CX1/xZpQBj1jN9UFcs85ve7LuakGkLeq8u1PCAN1BcxT5Gy6hXar3BSiA/yN0S3w
	8jio0G9gU9J4fwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49E2E2FA39;
	Tue,  9 Jul 2024 23:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 947F02FA38;
	Tue,  9 Jul 2024 23:58:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
In-Reply-To: <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 10 Jul 2024 11:30:13 +0900")
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
	<d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
Date: Tue, 09 Jul 2024 20:58:56 -0700
Message-ID: <xmqq4j8xaoe7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BB978AAA-3E70-11EF-B7D9-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> As we currently describe in t/README, it can happen that:
>
>     Some tests run "git" (or "test-tool" etc.) without properly checkin=
g
>     the exit code, or git will invoke itself and fail to ferry the
>     abort() exit code to the original caller.
>
> Therefore, GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue is needed to be set to
> capture all memory leaks triggered by our tests.
>
> It seems unnecessary to force users to remember this option, as
> forgetting it could lead to missed memory leaks.
>
> We could solve the problem by setting GIT_TEST_SANITIZE_LEAK_LOG to
> "true" by default, but that might suggest we think "false" makes sense,
> which isn't the case.
>
> Therefore, the best approach is to remove the option entirely while
> maintaining the capability to detect memory leaks in blind spots of our
> tests.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>
> @Peff: I thought your preference was to keep the option.  I agree to
> remove it completely.  This, v2, address that.
>
> I'm traveling, and while I think the change doesn't break anything, I'd
> appreciate a double check ;-)
>
> By the way, I used, more or less, the text for the message that Junio
> suggested.

Hmph, the above doesn't look like any, but as a standalone patch it
is very much readable.

>  ci/lib.sh     |  1 -
>  t/README      | 24 ------------------------
>  t/test-lib.sh | 41 +++++++++++++++++++----------------------
>  3 files changed, 19 insertions(+), 47 deletions(-)

I won't be able to apply this to my tree, with

    warning: Patch sent with format=3Dflowed; space at the end of lines m=
ight be lost.
    error: corrupt patch at line 22

until these get fixed, but is this meant to apply on top of 47c6d4da
(test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG, 2024-06-30) which is
cooking in 'next'?


Thanks.


> diff --git a/ci/lib.sh b/ci/lib.sh
> index 814578ffc6..51f8f59a29 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -370,7 +370,6 @@ linux-musl)
>  linux-leaks|linux-reftable-leaks)
>  	export SANITIZE=3Dleak
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
> -	export GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue
>  	;;
>  linux-asan-ubsan)
>  	export SANITIZE=3Daddress,undefined
> diff --git a/t/README b/t/README
> index d9e0e07506..c2a732d59e 100644
> --- a/t/README
> +++ b/t/README
> @@ -382,33 +382,9 @@ mapping between "TEST_PASSES_SANITIZE_LEAK=3Dtrue"
> and those tests that
>  pass under "SANITIZE=3Dleak". This is especially useful when testing a
>  series that fixes various memory leaks with "git rebase -x".
>
> -GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue will log memory leaks to
> -"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
> -"dedup_token" (see +"ASAN_OPTIONS=3Dhelp=3D1 ./git") and other options=
 to
> -make logs +machine-readable.
> -
> -With GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue we'll look at the leak logs
> -before exiting and exit on failure if the logs showed that we had a
> -memory leak, even if the test itself would have otherwise passed. This
> -allows us to catch e.g. missing &&-chaining. This is especially useful
> -when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
> -
>  GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck when combined with "--immediate=
"
>  will run to completion faster, and result in the same failing
>  tests. The only practical reason to run
> -GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck without "--immediate" is to
> -combine it with "GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue". If we stop at the
> -first failing test case our leak logs won't show subsequent leaks we
> -might have run into.
> -
> -GIT_TEST_PASSING_SANITIZE_LEAK=3D(true|check) will not catch all memor=
y
> -leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue. Some tes=
ts
> -run "git" (or "test-tool" etc.) without properly checking the exit
> -code, or git will invoke itself and fail to ferry the abort() exit
> -code to the original caller. When the two modes are combined we'll
> -look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
> -the test run to see if had memory leaks which the test itself didn't
> -catch.
>
>  GIT_TEST_PROTOCOL_VERSION=3D<n>, when set, makes 'protocol.version'
>  default to n.
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 79d3e0e7d9..942828c55d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1270,8 +1270,8 @@ check_test_results_san_file_ () {
>  		say "As TEST_PASSES_SANITIZE_LEAK=3Dtrue isn't set the
>  		above leak is 'ok' with
> 		GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck" &&
>  		invert_exit_code=3Dt
>  	else
> -		say "With GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue our logs
>                  revealed a memory leak, exit non-zero!" &&
> -		invert_exit_code=3Dt
> +		say "Our logs revealed a leak!" &&
> +		test "$test_failure" !=3D 0 || invert_exit_code=3Dt
>  	fi
>  }
>
> @@ -1555,28 +1555,28 @@ then
>  		passes_sanitize_leak=3Dt
>  	fi
>
> -	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" =3D "check"
> +	if test -z "$passes_sanitize_leak" &&
> +	   ! test "$GIT_TEST_PASSING_SANITIZE_LEAK" =3D "check" &&
> +	   test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
>  	then
> -		sanitize_leak_check=3Dt
> -		if test -n "$invert_exit_code"
> +		skip_all=3D"skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=
=3Dtrue"
> +		test_done
> +	else
> +		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" =3D "check"
>  		then
> -			BAIL_OUT "cannot use --invert-exit-code under
>                          GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck"
> -		fi
> +			sanitize_leak_check=3Dt
> +			if test -n "$invert_exit_code"
> +			then
> +				BAIL_OUT "cannot use
> --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck"
> +			fi
>
> -		if test -z "$passes_sanitize_leak"
> -		then
> -			say "in GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck
>                          mode, setting --invert-exit-code for
>                         TEST_PASSES_SANITIZE_LEAK !=3D true"
> -			invert_exit_code=3Dt
> +			if test -z "$passes_sanitize_leak"
> +			then
> +				say "in
> GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck mode, setting --invert-exit-code
> for TEST_PASSES_SANITIZE_LEAK !=3D true"
> +				invert_exit_code=3Dt
> +			fi
>  		fi
> -	elif test -z "$passes_sanitize_leak" &&
> -	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> -	then
> -		skip_all=3D"skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=
=3Dtrue"
> -		test_done
> -	fi
>
> -	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> -	then
>  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
>  		then
>  			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
> @@ -1599,9 +1599,6 @@ elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" =3D
> "check" ||
>       test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
>  then
>  	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=3Dtr=
ue"
> -elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> -then
> -	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue"
>  fi
>
>  if test "${GIT_TEST_CHAIN_LINT:-1}" !=3D 0 &&
