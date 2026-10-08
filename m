Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E84FC8FA
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488449; cv=none; b=E/0x/rvpMHZAwBaFjWLtflVctLz9zxyu210XWNwEsrKIJjeHe3QmQNUvzpDNfstJKRU3QOnyDPLKiI3q0pqQyUsZ62ARH+Kfle+EvY0fGJkrmkAi48slVcVZQENi4kC/7yCvKurEC7Gfx/AQlIn6AmBiUzjEEbJMW+jpTOBA3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488449; c=relaxed/simple;
	bh=9a5XJsvtKYiyekOhp6d3HOphkb8SI6RMsbgLmp3wnMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldegH07vrWoZe+MH2AdYw+40lAqZbv2/B51fJrAf1vtWE4zYIIcOaCRUKCrqhbU5Y3Z+SdEHxIxOPM9FM36Ow70CI7klxwv8QLZvk9rkOzOXnuK8q7KlvDj4lFnBtmhlg1WxzotUvxzrMAaFGMtqEIAMDKlOVCgmHzvuXd1F4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jiC3viSl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZvvpXkR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jiC3viSl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZvvpXkR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ACD37A00E8
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:40:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 15:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791488445; x=1791574845; bh=IW4e1N7Ru/
	JT0qaERgxE4VgBbYDhE0hv2CSV7cmCfhU=; b=jiC3viSlvDfFuRa3TFx3Udmgjh
	h7ZKnfKLzIV/C0ysS2aBR+cnsbkC2EpNh58lu6YRbPZ9F5i45E4NEewzcd27DKVE
	/jzfLGWtnx2c+vnyueejku1/rODn0jZQ9pk402XsdFQwK+UOP3I8h/9taroQx1Th
	PZfkKlhbtfOvkWiLVOlPHTf+UxxlGbqSlibSoklL/qGYutMtnIu/Pbi9h45TRIAT
	rsGMKzOdwJsVWHfXZPHY/MF/dB/rhXs7AENhwQYrbLa/5AruQbmOwXrBlN8UreZ8
	lCDihNND7kDd1X6XP4vPZfOGkIQ5icguYIxrbx0RXzhgCQFfkG83qDLxBhlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791488445; x=1791574845; bh=IW4e1N7Ru/JT0qaERgxE4VgBbYDhE0hv2CS
	V7cmCfhU=; b=BZvvpXkReTgL4kjceffEY+BM8LH0desPugy2GLjgxMgg2fL2Yt4
	9KSJiKkS7hXLMS3lbdsN2SYLuwn7+XD9NN3+St9vI+z5STP5aNKzgiYn8aWmEd4X
	wp1BWMllA1FUMO35BMKKmkwo88V25Oz5seQ6Ac+RSAk6mGpw6nNDcCw02OqRYXe9
	CL9bCWSPOOi0txrZ+S7z9bMG2hf7rOJp7pXl+x8Vjto8Pfxx55wHffttrp5tRbLj
	azpjcn5BO2jX/5yMXhprzFGN0s/rjJDIdpCAfoRMUL56YX1IalYHSklkov96QNL5
	GBoTKfkI4Q3Otrxcmtka4bEavkq4ChiXzTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791488445; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZkmnGmcXBLgD5Wwl70AG60iXktA+iB+qlrN4NC7WMpG5WTQ
	hRFSFbXjH9qa/qc2x7xOwBQy1tCJeIxwRgBnCZp6/+fD59Ngbd8+GdBCo9K7Jrdm
	eyemj82dRals1zfPRasEE74bc4AJApneGXxao2n2LcPJjpX2A69QQM846/+smuXf
	23T9+Fol/GSYK1n/hG/ttAyhfKmRbc8766KlVrB549zwphgGh8+lwCkHRYCEgDd3
	Q+GwkTVXrz9OHpEBiD4FOlI0q760VbaRapbaVqVH8AvyHuDKai0o2OwxFgbQGIi4
	wUaLlxDgbFP1lAOny8nzeQerMkd0Y1ylmk8Tmnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eqH3A42S+2b0DCjjlmUMqfsQ8kFparx0QLNjs5U10O8=:9a5XJsvtKYiyekOhp6d3HOphkb8SI6RMsbgLmp3wnMI=;
X-ME-Sender: <xms:vfHHakaeT3IkO5wbK1yWlGND12NKEs4JhSX9qWsA0jiADCyH3WDyLg>
    <xme:vfHHamYI0DOnVRLqIcnj6RQZx1VNNloi7pD9ShS5GAqZGNLj6xO_M9JBG-0bYy-wz
    sAPiJcPI-_IquHxo3n2R31s0rzqAZE_vSe76vc9cZOWeMq3O6rrCA>
X-ME-Received: <xmr:vfHHaj9FEZd_t3wZPtoBqtGnaYPoaxXnijUUwvli8a_vZS4BZvXlha5owR-5EyE8WKUXjjIFa63gF4TQCsyxB-MAtAlVqTN0vfMa>
X-ME-Proxy-Cause: dmFkZTEfqvFAsrm71SJQ88OoqPsVzVfhzTiyvTNiKazGdeTV9322khQ+jCXA7He1o5p4OV
    MZ6C0E54Hu1I5Hn3H7c2hrxb6yTbJHo4iNOha5XCQda+nXvowR+Cnw3Ua2Bbf1E8jjW4k5
    MTTmZOGyaIpyJZUQRjzFJQiCzTDBvUiQEZpudJgp1STU6D5M/nFBq4DqeT7/+63WjOQyv6
    6CP6aSj0/FA3chUpRRUluLCHI7hbLMt03VBj1kfYSbh2X5XC15+WrWnGXsW/LCJbmQcH95
    Nfwf+uUSDfL6Dgi67ybuCZGXJMYdQY+nt2WsytOm2TgTzDHeYeExgHIEPaoIrOhoqj8Rdm
    xmOq5KsZZ3lELRDkVtR7fPOuEObpOigxKu1Ue79azhmzVNups8hvW9PPZheopXYCaDnOdW
    hatuMe29ykFTMGZpaB/jSXnmrq2kgvKHkNJREGqqq4ODlktAo40NABS+DbrUTqCi4EKxMC
    P6kCKqG34mBnBZ428OvrFOmFU2whVkLu6rm0SyQDjJdTE0ywptTdUUJzPohL3pWVXNvMV6
    2a1Ml+O7mJaIIVAu7XkUpO2CBCTEKQ5bDA+6PSe8zv8JN6Bgsv1Ey29Pdk74fNNtl0BroP
    UPTpQm2s9Xj4hto/1Gg+rDNQocALNOT9bqIbeXIKlT8+YqwYvmETIeNUB80Q
X-ME-Proxy: <xmx:vfHHatgjxSf8lZxENbCQZX6EdA_dEDT0PvwLPAAorND3H8aUbMUFnQ>
    <xmx:vfHHareIhRWJn04GN_jwovjd4_gq2oG0TWl2hDBPDaJsO4RShuvEmg>
    <xmx:vfHHasrt-Su4nQONlQS--p2rAkKR4HPPGbVzDfodjjffXTXtw7dR2w>
    <xmx:vfHHaoDOMC9RemL5Y-sAVSnVBUt4g-uMCweeWbtoua1zTwa7Jdxwmg>
    <xmx:vfHHajfQaE-0CfjJwJldwtgylA42FT91NtqUMWOQb3Ln53xAsoqECcL0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:40:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] t7004: check a missing key without deleting gpghome
In-Reply-To: <pull.2443.git.git.1791450465178.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 08 Oct 2026 09:07:45
	+0000")
References: <pull.2443.git.git.1791450465178.gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 12:40:43 -0700
Message-ID: <xmqqpkxkyo90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> The "verify signed tag fails when public key is not present" test
> deletes gpghome to lose the key, and this sometimes fails on Alpine
> with
>
>     rm: can't remove 'gpghome/S.gpg-agent.extra': No such file or directory
>
> Point GNUPGHOME at an unused directory for the verification, which is
> how t7510 checks a signature whose key is unknown.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

Interesting.  It is curious why removal "sometimes" fails but it
is coming from clean-up the gpg-agent tries to do, probably.

In any case, it is a very good idea to borrow solution from an
existing test.  Nicely done.

Will queue.  Thanks.

>     t7004: check a missing key without deleting gpghome
>     
>     Fix flaky test by checking missing key without deleting gpghome.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2443%2FHaraldNordgren%2Fflaky-gpg-http2-tests-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2443/HaraldNordgren/flaky-gpg-http2-tests-v1
> Pull-Request: https://github.com/git/git/pull/2443
>
>  t/t7004-tag.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 8c795d7218..a0c2c9a3a1 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -11,6 +11,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +GNUPGHOME_NOT_USED=$GNUPGHOME
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
> @@ -1525,8 +1526,7 @@ test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad signa
>  # try to verify without gpg:
>  
>  test_expect_success GPG 'verify signed tag fails when public key is not present' '
> -	rm -rf gpghome &&
> -	test_must_fail git tag -v signed-tag
> +	test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git tag -v signed-tag
>  '
>  
>  test_expect_success 'git tag -a fails if tag annotation is empty' '
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
