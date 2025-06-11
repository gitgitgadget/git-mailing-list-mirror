Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7821B4F1F
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657226; cv=none; b=JsUFNxoGGBBYH6WtgsZouR+Ej4Ow8Oz+H2T0AGdreCkpOcEX7i4je3BDUuUWIgQOtVMSWJJrOfHlRuLnUtniFRKxLp0aUokkznP1ukWBtPD5ETcZHeC8viv/JUMIz065+O3qNfBCsqBpr6aCSmtwRudc09/JkSmu29ZR/g81TDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657226; c=relaxed/simple;
	bh=GVEoPbSch0py/uNLUbj/D+l1PBv/YjJXNS4Z3jqBKJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOoi7PGQ2TBh9g4HrdXDLIZuDhdemnsYGYjSLJOoDHFkORdc+3KYqtVpDqhxsgD7Nea5v1DOCQhArSK1FyAM23jVCJ3Y9wMjCleyeD+8EL0UHMB6rMX72pjRrCDs7yCXshhDD6i7sGtB7Lplpqs7MABaxX0RU9u7lpv2jxC+R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zLE6iYSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7KOf63o; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zLE6iYSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7KOf63o"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 84AD713804B6;
	Wed, 11 Jun 2025 11:53:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Jun 2025 11:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749657222; x=1749743622; bh=6fDmm8WmEw
	I0IqsYU8cc1tkIN9zvlrl8kIvjslE1eoA=; b=zLE6iYSv6EOS0Da3pXjLbwkzcF
	YXxkyGVsGGzSuYBmJuFNesLaMzQwK7Pk45lqTKZppCGASJAtmo8QliT5rVlwSq4s
	bSwg4P3n7g3oVjG4I+aE8iLW1D43wVcj/XTxua1hLZQY709/JqASYHMr5t5lAjIm
	xKasm6ucdgJ9s2K4mSAT1b6ajduNpnN25xqzVWnFCaqHoIC76NFYpKTedahmZTpX
	Vlopkb4EnuBhEjw1cW/MNPG1Up6DweT8NsoBWwIgB8xHWRj7B/L82lBBUesSQuUs
	wlLCOJv90l9lcfcRKXNNiiXP6b86xDUH/poE3YIuEbfZgPaC/DKBZuLSWHeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749657222; x=1749743622; bh=6fDmm8WmEwI0IqsYU8cc1tkIN9zvlrl8kIv
	jslE1eoA=; b=X7KOf63oHunAPnpVdY+8nRGAqAs4bbUr07Mpr9Gxa/3uB5F6ef+
	c1idLrAOqnh34DfQzztP/R4GG0PsaJ9senJkcl45GZ/SZRi8s3buL2fn/iD+jrIl
	Yzg3mMLknOPZkv3iUXkuS40Yhh6psOGYoh6n/z07hODCbGGZ0J2nmOftTeuvq7aJ
	bqT02XsbWsxxcE6fPR1KoeoFFH6k31FkM8ptzAwqRZl7ptG+tE2dTS/zBxE/XB4U
	SvdDCmnD1wTmYninEVT7s5rRijwJ6j8vIc2GWdqiOMAByd1oPe7ReLEQ8UDiCkLX
	6zxqzqCCY7i03LjXwQ0AcmF5egFCv6HlwZg==
X-ME-Sender: <xms:hqZJaG3AU5cqtjPi84e1x74Aofy4lmPqDvnxe2-qlanlMZHU2VCEZQ>
    <xme:hqZJaJH4_N_G97_KnmdyQEN2nXet4hQ9J6vJxgRI4dLmhqDlC5KojDM2eaFuFWzTz
    PFSSVgXpfqrlaLt6Q>
X-ME-Received: <xmr:hqZJaO5zFIEFRAa_PH3TfvcaDt2Rc8C4WBd80WwVYpnxSq8_6-GTD7J6yj9GjySexrSV59_94REcGh3kON-_fSS2jjHCuVcjnZCy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hvihgrkhhlihhushhhihhnsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehjohhhnhgt
    rghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:hqZJaH2cKN6u1Ed4Mllik-xoGsXvQ5bS_qfcEax92RIRChV-Txl62Q>
    <xmx:hqZJaJGzYvla71VD2UnRLIGbOD-5rZPEKxyvSJCc1zfsALrAoYc9Bw>
    <xmx:hqZJaA9X7aTgk-lki52-re1LbAh9cX14mGf7zwqE3F6o3wdchwnnsw>
    <xmx:hqZJaOkctyt4Q6Tqdc0DLO411m2ATuVxfbm2yTJQ2O2HbpaaSNXO_w>
    <xmx:hqZJaNPtFyFY85iLKAXdBUCDBroKwajpXGWTE757kl0b-LkGDRvcoO6r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 11:53:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: siddharthasthana31@gmail.com
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  viakliushin@gitlab.com,  johncai86@gmail.com
Subject: Re: [PATCH] cat-file: fix mailmap application for different author
 and committer
In-Reply-To: <20250611062643.8639-1-siddharthasthana31@gmail.com>
	(siddharthasthana's message of "Wed, 11 Jun 2025 11:56:43 +0530")
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
Date: Wed, 11 Jun 2025 08:53:40 -0700
Message-ID: <xmqqy0tyi8aj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

siddharthasthana31@gmail.com writes:

> From: Siddharth Asthana <siddharthasthana31@gmail.com>
>
> The git cat-file command with --mailmap option fails to apply mailmap
> transformations to the committer field when the author and committer
> identities are different. This occurs due to a missing newline handling
> in apply_mailmap_to_header() after processing each identity line.
> ...
> This ensures that all identity headers in commit and tag objects are
> consistently processed regardless of whether the author and committer
> are the same person.

Nicely described.

While the above explains what is wrong in the current code, it does
not tell if that was buggy from the beginning or we unintentionally
broke it.  It seems that this logic came from e9c1b0e3 (revision:
improve commit_rewrite_person(), 2022-07-19) when a much simpler
version of commit_rewrite_person() that worked on one "person
header" at a time (as there are only two, author and committer,
anyway) was rewritten to use this function, and it was broken during
the rewrite?

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 4a6242ff99..98dd0ae12f 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -1133,4 +1133,37 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git cat-file --mailmap works with different author and committer' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	Mailmapped User <mailmapped-user@gitlab.com> C O Mitter <committer@example.com>
> +	EOF
> +	git commit --allow-empty -m "different author/committer" \
> +		--author="Different Author <different@example.com>" &&
> +	cat >expect <<-\EOF &&
> +	author Different Author <different@example.com>
> +	committer Mailmapped User <mailmapped-user@gitlab.com>
> +	EOF
> +	git cat-file --mailmap commit HEAD >log &&
> +	sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&

Perhaps just a  matter of taste, but

	sed -n -e "/^author /s/>.*/>/p" -e "/^committer /s/>.*/>/p"

may be easier to read and more portable (as some implementation of
sed is picky about semicolon concatenated multiple commands).

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --mailmap maps both author and committer when both need mapping' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	Mapped Author <mapped-author@example.com> <different@example.com>
> +	Mapped Committer <mapped-committer@example.com> C O Mitter <committer@example.com>
> +	EOF
> +	git commit --allow-empty -m "both author and committer mapped" \
> +		--author="Different Author <different@example.com>" &&
> +	cat >expect <<-\EOF &&
> +	author Mapped Author <mapped-author@example.com>
> +	committer Mapped Committer <mapped-committer@example.com>
> +	EOF
> +	git cat-file --mailmap commit HEAD >log &&
> +	sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
