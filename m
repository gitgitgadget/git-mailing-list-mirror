Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA873335072
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101023; cv=none; b=NIc0P+0hIJBmFgFO2hCR839Y+dB4F4Mth8nOtpI8gLSWqowh4PQShmQiI2SeGIKRpJKxIfsSasBtUPFQctEur3mDEpChq8rjZeRRKH/WsQAl4WnYsWVTh4PEUDgNkX3BJdm3tNdf+5lDmPhyRRQH29/Eq8AYUnF1ugnxcGLxhuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101023; c=relaxed/simple;
	bh=b0q9h3B/ghQwsdHHo2nOTHsBSSzdT1sYCtXXRKRDvuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Awn+RRTBMWojO4OUPo2Rq2/qB/V6ib9rSOFeXmGG0lxkTpTJ4ETP2pAV6fYpV54mYfSAdpboxdupTQEFJ5qw+WzlRWZQNaUNkQwMe8dhg67uprQdH9A577jHPBe4x0v9exxflhkhnMnglkRungcCTbyJ4ZQbtG3Wfn3ByczeN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K4ltqkDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=scJhS09G; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K4ltqkDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="scJhS09G"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 44BA51D00237;
	Mon, 13 Apr 2026 13:23:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 13:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776101020;
	 x=1776187420; bh=dHirngFdj8Lt1vvp/1+pgq4wh7dtCPhBSv9aEBSIn9I=; b=
	K4ltqkDI0yWP5zMBp6jeVjHyWnHDDwbC+FG0o93UNF+ANyewV2Q8diM3Dd/DGJRp
	/n+qTcVIrsL1/WbT5PNJserXAeKavnkyk5tMUeRooXRPbGFN39MW8Rijx0LhOgWK
	MgMH2+IcBbrommtErEN58S2j/GqfGYbJFYdPkFZaE51A05VZtLc7xUJobWCw+YDr
	rbzfcTCxugs+DBo9bJ9h+W8RtvtDD8UW6vZPmc66hL2dyzQs1jr225GO9B6NlsDX
	juYLllfySRGXiUXfQ8W74XhYLgttJPdwmW+/y13PVKsYuR9q4sSe/0NVDfQFgYXD
	mjN7YE4qphn2Z21wR21ntw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776101020; x=
	1776187420; bh=dHirngFdj8Lt1vvp/1+pgq4wh7dtCPhBSv9aEBSIn9I=; b=s
	cJhS09G6bw8nPPfq79iAcsiwHuZDSNz+chjOE/l7C0JGeWJPXMltGDS0iDhm+Qfb
	nbK4l9oKitH5ntMxYjtvON6ztdJWR4wFDMVncjgMA4DY4PzvhmXUDpU1zLDNHTFV
	zruXbpNNiG64z84LPZDwkOK+Zmn0CZPDCZ/vuXIb09Yh72LynJGQtTKkV51cnjh/
	JLe54Tl19TJdkopX3cbggmRuygJh+Ak6tW5/nXC7ExNTmPd9wivOyFiAuOwOygXB
	tHGfe00QYbqZ1uoqEq6BY9KeBaHCsEzeheSJhJa93piaS5Rmn5g6ljTJvanh2lrc
	Q77DNqYWHfsiIc6NF/L3w==
X-ME-Sender: <xms:mybdaU8j89zIymTmlkhFf6IxBsbeJGepT_rWK3CeMiN5nz02bkLH5Q>
    <xme:mybdaUL65EXI2VUXahkQm-1qIRpCPRHQKSN63K2HEbFS3STSWEpUxiw4qHCH08WMP
    Pw_gcTzjvYC9fgh4ELa6yi2YB90rplgdMUh45wvms-OpphbZKd0>
X-ME-Received: <xmr:mybdaXbiq6BoPEzoxu75m2OQxbW2H7NCKuAN8PKL2YFKPC4yq6_vJVjjI_HiCDcKDDc5wgBCgRbik7jkV9Ca2ljd0hRchmzOdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:mybdaeLzN9jOdgxbzzMyJUtksiRjx3hGa24IsGc1rADv-GNSgMF5cA>
    <xmx:nCbdadBeqY9cj2sy_ebdOstrhoxE112TzQXezlmlrgi1vD2b9gGmcA>
    <xmx:nCbdabq_nSgN-GoScg3q3qMLQX4-MhjXFagfgL5xFe25vAKnHTyO0A>
    <xmx:nCbdaQjItn4PfZmiZ-8X8s35sW6aLjTJ2Uor7L5V3Pt4SzG2MiFA5w>
    <xmx:nCbdaUSxRIMZaFGtZAlvcpcegptnUuIIyjaK9gpQaZ_UA4PQRRcoCEzS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:23:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/12] t: prepare `test_when_finished
 ()`/`test_atexit()` for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-7-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:28 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-7-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 10:23:37 -0700
Message-ID: <xmqqpl42ixk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> Both `test_when_finished ()` and `test_atexit ()` build up a chain of
> cleanup commands by prepending each new command to the existing cleanup
> string. To preserve the exit code of the test body across cleanup
> execution, we append the following logic:
>
>     } && (exit "$eval_ret"); eval_ret=$?; ...
>
> The intent of this is to run the cleanup block and then unconditionally
> restore `eval_ret`. The original behaviour of this is is:
>
>    +------------------+---------+------------------------------------+
>    |test body         │ cleanup │ old behaviour                      │
>    +------------------+---------+------------------------------------+
>    │pass (eval_ret=0) | pass    │ && taken -> (exit 0) -> eval_ret=0 |
>    +------------------+---------+------------------------------------+
>    │pass (eval_ret=0) | fail    │ && not taken -> eval_ret=$?        |
>    +------------------+---------+------------------------------------+
>    │fail (eval_ret=1) | pass    │ && taken -> (exit 1) -> eval_ret=1 |
>    +------------------+---------+------------------------------------+
>    │fail (eval_ret=1) | fail    | && not taken -> eval_ret=$?        |
>    +------------------+---------+------------------------------------+
>
> This logic will start to fail once we enable `set -e`. When `$eval_ret`
> is non-zero, the subshell we create will fail, and with `set -e` we'll
> thus bail out without evaluating the logic after the semicolon.
>
> Fix this issue by instead using `|| eval_ret=\$?; ...`. Besides being
> a bit simpler, it also retains the original behaviour:
>
>    +------------------+---------+------------------------------------+
>    |test body         │ cleanup │ old behaviour                      │
>    +------------------+---------+------------------------------------+
>    │pass (eval_ret=0) | pass    │ || not taken -> eval_ret unchanged |
>    +------------------+---------+------------------------------------+
>    │pass (eval_ret=0) | fail    │ || taken -> eval_ret=$?            |
>    +------------------+---------+------------------------------------+
>    │fail (eval_ret=1) | pass    │ || not taken -> eval_ret unchanged |
>    +------------------+---------+------------------------------------+
>    │fail (eval_ret=1) | fail    | || taken -> eval_ret=$?            |
>    +------------------+---------+------------------------------------+
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib-functions.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f8bc77619b..0eac676109 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1516,7 +1516,7 @@ test_when_finished () {
>  	test "${BASH_SUBSHELL-0}" = 0 ||
>  	BUG "test_when_finished does nothing in a subshell"
>  	test_cleanup="{ $*
> -		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
> +		} || eval_ret=\$?; $test_cleanup"

Hmph, it seems this "&& (exit $eval_ret)" pattern has been with us
forever since it was introduced at 3bf78867 (test-lib: Let tests
specify commands to be run at end of test, 2010-05-02), and survived
a slight modification to work around issues on FreeBSD done in
b6b0afdc (test-lib: some shells do not let $? propagate into an
eval, 2010-05-06).  When a major part of test-lib.sh was split into
test-lib-functions.s at 12a29b1a (Move the user-facing test library
to test-lib-functions.sh, 2012-02-17), this part was copied intact.

Does this interact well with the glitch b6b0afdc (test-lib: some
shells do not let $? propagate into an eval, 2010-05-06) tried to
work around, by the way?

Thanks.

>  }
>  
>  # This function can be used to schedule some commands to be run
> @@ -1544,7 +1544,7 @@ test_atexit () {
>  	test "${BASH_SUBSHELL-0}" = 0 ||
>  	BUG "test_atexit does nothing in a subshell"
>  	test_atexit_cleanup="{ $*
> -		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
> +		} || eval_ret=\$?; $test_atexit_cleanup"
>  }
>  
>  # Deprecated wrapper for "git init", use "git init" directly instead
