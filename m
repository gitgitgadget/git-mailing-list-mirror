Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CE4E06FB
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546778; cv=none; b=Qd2jCeD9tG+tAtbEmHEM2fTJD0INf6BcicCuRCib4odYb3Z9WPVgZ3v/cLrUqlLREzswMfFK6DV1+n7aVbZiGGFqNSZR8Khh407iiZi7BbypQ12vPRddm8M82p/hcTR7fF0yoSkhnATTW/X4BZ7+puek/sCWYSc/GnR/DUFLCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546778; c=relaxed/simple;
	bh=yBbnY4UNf+j56JOHFP0GWBkyAc+Oq1L7QqenPuWGMUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSA5iAbr3/gqPnERoPQe3xbpURt3qHY+HNoX8FRMnZZAg60vOF9EYqJ+04umwMxxX5g/SRpgE4wdO1fxzTL/paQ4gykJi0roNMOdwH9/62bGpNCXNYqblybZQgLWypBJ4BhTfTwA8i5leLypisD+7v/anW8fqeFYf8MintDCuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AF51btcE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yM1MXA1e; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AF51btcE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yM1MXA1e"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F157EC0143
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:52:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Oct 2026 07:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791546767; x=1791633167; bh=gtrxWCfPc6
	BB08UQCuN0xYcsPRi0t3/p3E0mJtJDjJY=; b=AF51btcEXUzdrM0MDSmdiEH9xl
	IHJ+zMd4sjvEILCUdsGf+WNkZJCNh1pfwEN1qhAOMHy5UitkLsG721WU1SDccpOY
	u/haNvjPSZ5HigQBLqD/iSt1V//a9UmjmAf+Xvqd3Xq7kY2t88SzNNNz26Z5zb8S
	8t44098HYpUbvkeFt2mPebT59l8GTteSi8giGXS89jCr2HQc/zma6+VRQI4Su8CJ
	OyXB53m/J0RBgDOqtHVpDiAbLmtVLvTeESlV0w2qjwxUWZrn/zafqhtYLdahxrsk
	V4UXQyaxnJr2/60jMh4CCIYzCLRV2y700EW2JghB3PIZTN0iYSiMwsRPJo5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791546767; x=1791633167; bh=gtrxWCfPc6BB08UQCuN0xYcsPRi0t3/p3E0
	mJtJDjJY=; b=yM1MXA1e2fyXPHfsBkMNePi9cxb4e7mHO8x8fhXBtinUd2BRGIO
	1nnKdys9yVcBVnZicrfxn7ol0nTB40q7uaWBNfKsRLIBKL951p28o1pD4UQWn7IA
	K8nhHbZD+fuJekkfsGZ3RVieS4sqX3GhCdM41iz3p7iRMHXorXpWZu87MXog8msR
	nAVBa+oI8g8ZZ+FaGLfEMVtdUrYYuccb086CUS41ju2jblQrCowUuTmIlXOb1jxR
	XnEMZedrtYon60scYnmpCBtuR+Nqv3JHQYSovva88ZADNeqoQfggYlnsLz0eaIk+
	fgFTufv7qD7TLJDPqDC4UdvTtPBUigktsxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791546767; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rsAm7YHa6ZCO029Renz4K32IRzqdO41+xk1maH7YkVENB1K
	V/fE6aadZKWmAmvJx2OVqxLkgEupGrqIKfA+rzY9fMuqbE8JNxCGUBTzA7PGeD92
	6cmTsxqBaoY21JFbgL3wEAYnvEkxncSnH7ZHstGFC3syt/rMR6hI3zd3PiPw6PoR
	wwoDRdkVXA5Q5uEo1ff+HfJaC/ryGfw8zq5GZA5W7/RnVkWUihEnmObuIXkN4Tdn
	htOgoGo6GRssWMXAWEAukDz1cZWs0u1kGoi00M08mAbO1kwpVD8KUbHH1p5xJE4Q
	QL/srf+n9fn4AwbuiZQfjicP0zDkSJpaJXQELaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:69+CohVjsbDO+eIz3PvED9VgByzCXq8/R43MWJsuwQg=:yBbnY4UNf+j56JOHFP0GWBkyAc+Oq1L7QqenPuWGMUY=;
X-ME-Sender: <xms:j9XIas7_77EaECWEX6kiZ0Q5O95tYqCCflDij6CJn-ZS3GggLqgE0Q>
    <xme:j9XIaj6efrHmYQOTVZZ7oIAHKptO3Bqqys5s5X9K5HqqeQH7POuXb4H0t4A2vNat_
    TzaDnpJsJ6kIP-p1qpWBjxZYIpQAFZVGmVb5wbf-q7s3PcNcKW7TmQ>
X-ME-Received: <xmr:j9XIapEKhi6IJsghTDCDu59PXythKqeDHkwergujBT_mBde0BZ5r-dejB3B5Uhiz47OnJQ>
X-ME-Proxy-Cause: dmFkZTFe5QZUFYKh4K9uCRNZy92yq5pGyLqXA+dE9Nx+H16+ifvXvXJcnfuCCd7oLZinID
    uciXKbx2zt4yGoqbuT6y4Y2iyegDkfpMS4b7jIk0ti/7T4sAWmUhQWdhoC3AkT6l+KMbCr
    1DBlmnKxENy5kfUkE+yJAqkOEogrwbMKSQBvzAeiZGAigrHjSaoWNEfj9T5TjLqphzzqKf
    EmTPwgObgOhwGCDz66ka3qbIjFa6Ce5Dtl7aS9+Jql3PcJ/DV7zQNJs1q8rWYQYOyi4p5R
    1OD/9UBGFPRNQ9coB7EtBIIohUVRM3zNy6gE0thpWgh//mtzSaCtOApy9riPe0Z8LzyMFn
    lIjJuafNSZjI8XqmPDmEgcBsBsTCKuJZyCvzUpP0StDH5+PDCseq/rhn5dhOpUhkjAw2A7
    OecVN11asuuGjeR0sgfH0MWxTentPRrSTKCn4SaSePhrCZzmtnBflHI1Z9j8FmlOQe0732
    isxMnfSpM/uCwPbQ8LEnytlkjCS569QWz4NqV80MQ7irpJr5d2VVsPtTIIyhaN6NyGYYxT
    D1B0N71NAEM7kExw6nMFMiMeBeACwAdKwNJLr0ipfMDrHKgIO3N5/IGl9WXnITHt18kIyw
    3YyvTIz3rBXrp1koajH46XH9ST+4GyawDr4MxifZS4a5Aly3mvsN7ggy4sWg
X-ME-Proxy: <xmx:j9XIasQOF-A65-WPzdM2pb0v7O3T2_PvMoqAKKJuFmByYoS3xwGd8A>
    <xmx:j9XIaivfi58jDoySWTZelmUP1Qlgxl6bpR5X2X0ngOD1sdBBe_Cm0A>
    <xmx:j9XIarySSjxwOdB4K0FWar7X5BJVMzvONtNro52qtEx-rgB2p15jFw>
    <xmx:j9XIas4UetS2-vW0UZr6Ee_a3a-SFkEE3jUZeH0CyASteU4wXuydLg>
    <xmx:j9XIaqrHZcG8r25KElg5KAcdhbWKz3xROfH5yW7NpjlOB6Qd1w6oLWYv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:52:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a990ab8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:52:45 +0000 (UTC)
Date: Fri, 9 Oct 2026 13:52:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mergesort: move sorting tests to the unit-test
 framework
Message-ID: <asjVhlTj3MqHcGm4@pks.im>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com>
 <cover.1791365181.git.dilsheddilu123@gmail.com>
 <0429552774367ddcc3c2fda78e09a83650ccfa02.1791365181.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0429552774367ddcc3c2fda78e09a83650ccfa02.1791365181.git.dilsheddilu123@gmail.com>

On Wed, Oct 07, 2026 at 07:20:24PM +0530, Muhammed Dilshad A wrote:
> The mergesort certification checks exercise C code directly, so they do
> not need a shell test and test-tool command. Move their distributions and
> transformations to Clar, retaining the sorted-value, stability and list
> length checks. Add small cases for both list sort macros and debug hooks.
> 
> Keep node storage available to the cleanup fixture and bound validation
> so a failed assertion can release it without walking a broken list.

Wat...? I have no idea what this means.

I would appreciate it if you would read through the AI generated
messages and ask yourself whether a normal human being would understand
what was being generated. In general, we ask you to fully vet all of the
stuff that is being generated, understand it and convert it into a form
that normal human beings understand.

A commit message is _your_ chance to demonstrate that you understand
what you're contributing. If it's this obviously AI generated it raises
a huge red flag as I will immediately assume that you haven't read any
of the code it wrote.

> diff --git a/t/unit-tests/u-mergesort.c b/t/unit-tests/u-mergesort.c
> new file mode 100644
> index 0000000000..e621c9ec21
> --- /dev/null
> +++ b/t/unit-tests/u-mergesort.c
> @@ -0,0 +1,369 @@
> +#include "unit-test.h"
> +#include "mergesort.h"
> +
> +static uint32_t minstd_rand(uint32_t *state)

All of these distributions are kinda cute. But is it really required to
test the merge sort with half a dozen different distributions? I dunno,
color me sceptical.

That being said, you just retain the old status quo, so okay.

[snip]
> +#define DIST(name) { #name, dist_##name }
> +
> +static struct dist {
> +	const char *name;
> +	void (*fn)(int *arr, int n, int m);
> +} dist[] = {
> +	DIST(sawtooth),
> +	DIST(rand),
> +	DIST(stagger),
> +	DIST(plateau),
> +	DIST(shuffle),
> +};

This also feels quite overengineered now for the unit test infra.

[snip]
> +#define MODE(name) { #name, mode_##name }
> +
> +static struct mode {
> +	const char *name;
> +	void (*fn)(int *arr, int n);
> +} mode[] = {
> +	MODE(copy),
> +	MODE(reverse),
> +	MODE(reverse_1st_half),
> +	MODE(reverse_2nd_half),
> +	MODE(sort),
> +	MODE(dither),
> +	MODE(unriffle),
> +	MODE(unriffle_skewed),
> +};

Same. All of this is way too overengineered. It probably was useful at
one point in time to show performance with these different modes and
distributions. But even with the performance test we don't use those at
all anymore, so it just feels needlessly complex by now.

Patrick
