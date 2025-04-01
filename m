Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6920E70C
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743534293; cv=none; b=WBVFQGc0J8H904wuHoo7Ndi8LH/PLkhndKzCD/5Zq2A/aEFPwzCxkPr8Sr4fIHMdkt+7OurXoyzoAHOaIZoGj0i27WLI734Ya0NYZlOBC5V7KiYN0mfU9J/LuxwlWPy9EF7UBHY8J364sgMV+xjn75oxJ+CPFu1Ejb0kJlcOFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743534293; c=relaxed/simple;
	bh=FWrabmpkxlqnljI5gvSiBYxzomujeWUGCKz6xykWmg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k9bOWNQlY4QDIVZN3WaF4SPrZO18E8wkDKvD/sgda0Ja/26aEtOWKLF9CcC3Q5mwG4ZRqMyk4zeTL2++Tw6riECco+V/wGufhLer3VjGOvANvVNXlCDdSAzdkuCwxL2rtkmf30aIP7ciwLqHBGGaX1nZnDGtXkYBGKxHtjzF45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=otNmcyXZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="otNmcyXZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743534284; x=1744139084;
	i=johannes.schindelin@gmx.de;
	bh=ztcnDUrJ9pr+k3xjv3Su17Qqiba08ikRSftvgognhCw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=otNmcyXZ3aC6cnn62jvCHk4yfWKAVBhU80CJQMM22Ab3R7XRLkjq1IdwYyTvLR92
	 ceQFU7MZHzzaQmyA1PsBSK77QZHxFz5/hTCsXrgMOzCMrK2dzO+STT5uw61mj2tzk
	 rBfM3qy28Wz1+bgObZ/7zuzPgN85FpVHLaw7wn3l6nSw0/Y5zh3yDseTqV5fLrQHB
	 4i+D5yxEoUbkrAYgMTBqQyk5ahd6GReEkNPyhKc5eKHTWIAAari3bI7T/mshRav8M
	 UCEZQsji/RlWuo43FAW0LZAeDrOrPJlGxzzZOxOJI28uZ9oTg1b4QJ2yElHZe+kHM
	 ioxYbK2AqmO3WBnLMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1tVHyv2x73-00pI50; Tue, 01
 Apr 2025 21:04:44 +0200
Date: Tue, 1 Apr 2025 21:04:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 17/20] t0021: refactor `generate_random_characters()`
 to not depend on Perl
In-Reply-To: <20250327-b4-pks-t-perlless-v3-17-b436de9da1b8@pks.im>
Message-ID: <92fd1e8b-4790-0c81-409a-be81aed9f290@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-17-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W5gZFHMvyRHJG4cHfOp9QTjsdiM2SltlcCkqxBpx9SJ+G5cZHOh
 +GlmzZZc6jGGQE1C0YYack+JaTPvfQVy4H1oFIOHXZrXbehTWLBLUasqIwLAjImEAb84TWQ
 R4AxSL1MPPT3fd23dVITaBBeprHj9Aq/wmgRs2e5cgYb2TvFKJ4z47JQd47lEt/DNU4ggwW
 fCbNOpGIe51BsXOhBOZ9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PZ8/v2M/OEs=;v3XDKDQyj4vjqF3hUzDHfnNdK36
 jYTZkxOgUrUvSU6Qt5u0BtR7eyDtwsTqKuyFoIwGcR/eoJyovIe9EdrGXTMB9VC5aTWdtgyoa
 ZY2frEcre3Z2uVq079LQiky7V8tk3DW0pP1S1cVylqgf8HAGlQD6yVKSsSPRapSCdS7XD3K5P
 +wmAHPVxpkMiPMwNA9k1Dx39tCjfI/kShto656HHmbNV7zHf7qtyJNbZjwGCDbDC9L4WTgQV8
 a9Li9PDbmLAuDg6mxidlD+A+KV9yvqHZeXvpP9uuzTfahpqs/fO+Z9dtcYs73Uoo/eyAjB9QL
 PrGoMSj4TNAdUw0ELU8MwJwj10kxh7tV3iJ5u32+UUcIRir5afBO5qXIDY1jS7hDgKS49cSCL
 wepUvfTN1lOmchP4Bd2ow/2pPONUPmGYsc+JUyEfawD9lba1gj/iInUFx5QpVLGcqgh2hA3xO
 K777nnsfgIgInsxX00tFxkzCmhtW0mOiHudbiQTQW7jZP0nN/eIPLT5PTGn7KoQ4U5cPrG9Em
 o2cbWXIGXXBhxb96D0PLkJDrJ12jm6YHQFy4hGuS/l2/7dCi5UToiGCOfKmXctTC0l4ZNHVzl
 2F439frnn+PseDVUfcEBSdL395fI+o3NeL/LX/rXMNdvwjw411s+Ot8LCX8c6Z7EuL+LY2NXr
 +g69jmrYVVrPyEKRHP/Vcs7VU5p35X+6pG/ouWWJ4EOGSJPmR66ysx6MQk8ZynqF/cbA68uED
 6eBcsRQo3sZICSBwgLQvEKWkmcsMEEPVJUgqE/VmubmgdlDb4Q979b6ETdogHSc7j7YZq2Fyh
 Ew7M9d1hVN5DWalBKcfHCX+3MSZu9J1tXwgEmQMGvhy/njfORrzDJA9F+EtUVSECVLlPfpD2C
 4IZWeXme3QAAzo0V7WGOU8z2Dt+PnXtLkpNA4UZoeQSnBl8Fp8I5EA1rjxkFGrqgylMJYVNI7
 IRbSMO1EH8dkiKyvTOVNAfRNghRTjjUDbDmQQin+0bnwdWU00drDuhgowB0wTFMujdx0K396a
 G1zZnllb0H3NnOz5mz3K0txIRdlTXFDh9HPOwjsOMJVQToGaVTJ5CgoVvI8TZ89p5+RYf7KjD
 48pdxQTCbEBfEANnNpUM4Z0XJ1PwDZS7f0h01NDUxwicSJgo5GkpWqnPtwucOocjtHjuOV1WI
 qsujhCGH7c3Ff6IcdrfE9K8T3ueisP2K11PmlqGwK4QHHvw6NgG1tHn0rw1hW3SaN429yXYbl
 DLotIKfaoNOHmPqmPciugjdsTJNF6S8i0Gh7LSP+MJdgMmE+on6azwDFcYOECB55/irAdhgl4
 c0mGw2juvc1WdY94BQ1U5FBlDCf+dI9L+Ukm6A0/ZDoV+rzN0+9+ve79TYzfspDswKCvG8DKn
 j/rV1GQF5dmJ/pv0UPBx0H3OlOI/dFdoJjQ2jdxCuQ3b1gkk6c9OGuS8626TssAA3FTk3NZdA
 kRCNcWw9enuLfdnd2kumqjQSRgXUItk2KeiLTJWivSh47+7nF
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> The `generate_random_characters()` helper function generates N
> random characters in the range 'a-z' and writes them into a file. The
> logic currently uses Perl, but it can be adapted rather easily by:
>
>   - Making `test-tool genrandom` generate an infinite stream.
>
>   - Using `tr -dc` to strip all characters which aren't in the range of
>     'a-z'.
>
>   - Using `test_copy_bytes()` to copy the first N bytes.

It would be conceptually more elegant to teach `genrandom` to optionally
output only lower-case letters. But that would be admittedly result in a
larger patch, therefore I am okay with keeping the patch as-is.

Ciao,
Johannes

>
> This allows us to drop the PERL_TEST_HELPERS prerequisite.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0021-conversion.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 4a892a91780..bf10d253ec4 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -20,8 +20,7 @@ EOF
>  generate_random_characters () {
>  	LEN=3D$1
>  	NAME=3D$2
> -	test-tool genrandom some-seed $LEN |
> -		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
> +	test-tool genrandom some-seed | tr -dc 'a-z' | test_copy_bytes "$LEN" =
>"$TEST_ROOT/$NAME"
>  }
>
>  filter_git () {
> @@ -619,7 +618,7 @@ test_expect_success 'required process filter should =
be used only for "clean" ope
>  	)
>  '
>
> -test_expect_success PERL_TEST_HELPERS 'required process filter should p=
rocess multiple packets' '
> +test_expect_success 'required process filter should process multiple pa=
ckets' '
>  	test_config_global filter.protocol.process "test-tool rot13-filter --l=
og=3Ddebug.log clean smudge" &&
>  	test_config_global filter.protocol.required true &&
>
> @@ -684,7 +683,7 @@ test_expect_success PERL_TEST_HELPERS 'required proc=
ess filter should process mu
>  	)
>  '
>
> -test_expect_success PERL_TEST_HELPERS 'required process filter with cle=
an error should fail' '
> +test_expect_success 'required process filter with clean error should fa=
il' '
>  	test_config_global filter.protocol.process "test-tool rot13-filter --l=
og=3Ddebug.log clean smudge" &&
>  	test_config_global filter.protocol.required true &&
>  	rm -rf repo &&
>
> --
> 2.49.0.472.ge94155a9ec.dirty
>
>
