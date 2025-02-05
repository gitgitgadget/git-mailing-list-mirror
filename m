Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887D21421D
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738741639; cv=none; b=G8M+loZz6VA/OioTu0UP1CX9O8S88w6PfH73xEnBwz9DM/+7AA9padaZxnhVAT9fNpr/dZbvBzBubfCDtLEipgAmfp9soYWdHutc4yMiOuIQRFXO/CGU87ekdRIHlOsIcbD0F/oxylsfJ0UMqJ0pnTDG50rfW7NN6pj3cW0pMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738741639; c=relaxed/simple;
	bh=06N0D8AKpaG9LvFEfMo++K5WuQaWByANTVf8xRY6fFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZefFW79VyjP7LZwI65JUW8a+tPIVcMlIjF9OshhjO96Q6GwBPVlTxhfx/QgJ8g7wo8L083qkTxzoyyEkdRj2XJ0sLXsjRjyLIgQAXNFdziG2ZebdQPbgzkVmn4lguCokr6vzaFBRzIBqBywHCs+O1bzfyAExRdFC/IELXujcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UkjCMW5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kL2zCrmj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UkjCMW5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kL2zCrmj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A46B11400EF;
	Wed,  5 Feb 2025 02:47:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Feb 2025 02:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738741635; x=1738828035; bh=32c90tDNtO
	6DWNiSY7q0VoGGCHuKFuoGhAUXmPPfNyQ=; b=UkjCMW5yG/rg1F/32rKg/y7ZjT
	JKLB9mHXWMXUkfhBkqUDrvL/SsUZ17OlnCMQ+EeioQsZ7Jo7tQRqxDGQHv8VSiGg
	5qU7NDJsJO7BesVe9se1eTlRRM2Zr0XPvusQe1C2CKimZnpnynnpqxjmdLh6Bkyl
	dwrW6/Yx4dXO4CJnWb8KHnk7WHqGvIOBaHwqa4+QO9LYtUXsj2qR/pwf2F3nSOQ9
	RaeV1UPAft6POXdpoLTSeVgny8x75XSSS7zbpwOv5QHXW8iuUkM5EaG4DimClSGL
	M0gE4meeEnUlQCKIqYX9oRDCMA6PIZ+0i0zCxKlGgzWnJ1Yrf/QyFy47AE3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738741635; x=1738828035; bh=32c90tDNtO6DWNiSY7q0VoGGCHuKFuoGhAU
	XmPPfNyQ=; b=kL2zCrmjBvw3Y0nzDuvXpVNitVFF7nvTbNu8wmh1T/Jmchs4g48
	80MmcRRiB+1NG+J8Z58nKcVlgmxV6qScs7sI2164/bC+/ZropkBq7XfxSjr6oAxj
	0z1S495lM3XgiBlQaT7gGsDPScfNR2okiIrqRlvK0czIVDyHRIvmjYcc2FCZOocs
	I6F/8D05PkFgqpmYegViy0CxL14DcJPDgdFQFuCENb5/5qx1aggF5fWLkKQKMmE+
	TAtJ3Zydcfo71wDZtXg6X3yZ+rCVKeG/BlgMD9ynTtTIX/cj3lfqaX0M8GYoLV6S
	vzLRyeM7q0Fwpf1GX8Yf6KiRXTcsKG56INg==
X-ME-Sender: <xms:gxejZzCjpo644UQoHte9xA7Jw8BU45S8JyAOfQagdqSwlM7Dt35aIw>
    <xme:gxejZ5i3xsvvAhvMJVgQhNj-sbJ85Po1a_UQ0lMS4Dv5T4Uv0dEjNtrRi3PQQkZKI
    PhwQsY11Wfea7q5bQ>
X-ME-Received: <xmr:gxejZ-kTD1QbcUrc65tkS5PqpzlIpfjwVHSkS765BmFzFGEeZ7fS5snuAvdRNJDRSrZDfmxOUTo2TYtKvfnijZDqqz_6fDWJqVkoo66g5oNpdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjvghllhihrdiihhgrohdrgedvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gxejZ1w8_gM-kcK_XRKyjXKbNLojBmFsKE_fjb5vYHlugBhzswuKBg>
    <xmx:gxejZ4QfjsYR_0pZZWHzzeuL6qYRjw8t-PLtzaos-DfOV6Mf7g5qnQ>
    <xmx:gxejZ4afakGCXCM_OvOxN_5Ka4wytvrUAJqzCmupP0Shb23d-ZeNDA>
    <xmx:gxejZ5Th3Vtb35wrUpYlh3UyjzOssyikKiqSLXd1u75IaSiSBUHs3w>
    <xmx:gxejZ-OOCoILN-TaPdOByNAkjdmChWbc59f_RXq70eNQAMODRRE1X43S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 02:47:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e88829f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 07:47:11 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:47:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Message-ID: <Z6MXevArKhRLacAb@pks.im>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205014055.737190-1-jelly.zhao.42@gmail.com>

On Wed, Feb 05, 2025 at 01:40:55AM +0000, Zejun Zhao wrote:
> There are several -Wsign-comparison warnings in "apply.c", which can be
> classified into the following three types:
> 
>   1. comparing a `length` of `size_t` type with a result of pointer
>   arithmetic of `int` type
> 
>   2. comparing a `length` of `size_t` type with a `length` of `int` type
> 
>   3. comparing a loop count `i` of `int` type with an unsigned loop
>   bound
> 
> Fix these warnings following one basic principle: do not touch the
> relevant logics and keep the behaviors of the code. Adopt three
> different strategies for each of the above three types:
> 
>   1. cast the result of pointer arithmetic to `size_t` type
> 
>   2. try to change the type of the `length` to `size_t` (may fall back
>   to Strategy 1 if the variable is not guaranteed to be unsigned)
> 
>   3. use a loop count `i` of `size_t` type

You should split up this patch into a series, as it is really hard to
follow what's going on. There are a couple of things happening:

  - You change types in `struct apply_state`, which bubbles up.

  - You adapt `git_hdr_len()` to receive different inputs, which bubbles
    up.

  - You perform small fixes in several places.

It might also be a good idea to split out the loop counters into a
separate commit, as those are trivially correct.

> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
> ---
>  apply.c | 73 +++++++++++++++++++++++++++------------------------------
>  apply.h |  6 ++---
>  2 files changed, 38 insertions(+), 41 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 4a7b6120ac..0c7b89dc3a 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -8,7 +8,6 @@
>   */
>  
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
>  #include "abspath.h"
> @@ -540,7 +539,7 @@ static size_t date_len(const char *line, size_t len)
>  	    !isdigit(*p++) || !isdigit(*p++))	/* Not a date. */
>  		return 0;
>  
> -	if (date - line >= strlen("19") &&
> +	if ((size_t) (date - line) >= strlen("19") &&

We know that `date` is always bigger than or equal to `line`, so this is
correct.

> @@ -1087,11 +1086,11 @@ static int gitdiff_index(struct gitdiff_data *state,
>  	 * and optional space with octal mode.
>  	 */
>  	const char *ptr, *eol;
> -	int len;
> -	const unsigned hexsz = the_hash_algo->hexsz;
> +	size_t len;
> +	const size_t hexsz = the_hash_algo->hexsz;

The change to `hexsz` shouldn't be needed, even if it makes us match the
type of `hexsz` as declared in `git_hash_algo`.

>  	ptr = strchr(line, '.');
> -	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
> +	if (!ptr || ptr[1] != '.' || hexsz < (size_t) (ptr - line))

`ptr` is the reline of `strrchr(line)`, so it must be either `NULL` or
greater than or equal to `line`, so this cast is fine.

> @@ -1158,7 +1157,7 @@ static const char *skip_tree_prefix(int p_value,
>   */
>  static char *git_header_name(int p_value,
>  			     const char *line,
> -			     int llen)
> +			     size_t llen)
>  {
>  	const char *name;
>  	const char *second = NULL;

It would make sense to split this change out into a separate commit, as
it bubbles up into calling functions, as well.

> @@ -1207,7 +1206,7 @@ static char *git_header_name(int p_value,
>  		cp = skip_tree_prefix(p_value, second, line + llen - second);
>  		if (!cp)
>  			goto free_and_fail1;
> -		if (line + llen - cp != first.len ||
> +		if ((size_t) (line + llen - cp) != first.len ||
>  		    memcmp(first.buf, cp, first.len))
>  			goto free_and_fail1;
>  		return strbuf_detach(&first, NULL);

This cast should be fine, too.

> @@ -1240,7 +1239,7 @@ static char *git_header_name(int p_value,
>  				goto free_and_fail2;
>  
>  			len = sp.buf + sp.len - np;
> -			if (len < second - name &&
> +			if (len < (size_t) (second - name) &&
>  			    !strncmp(np, name, len) &&
>  			    isspace(name[len])) {
>  				/* Good */

This one, too. `second` is iterating through `name`, so it's always
greater or equal to `name`.

> @@ -1371,14 +1370,13 @@ int parse_git_diff_header(struct strbuf *root,
>  			{ "index ", gitdiff_index },
>  			{ "", gitdiff_unrecognized },
>  		};
> -		int i;
>  
>  		len = linelen(line, size);
>  		if (!len || line[len-1] != '\n')
>  			break;
> -		for (i = 0; i < ARRAY_SIZE(optable); i++) {
> +		for (size_t i = 0; i < ARRAY_SIZE(optable); i++) {
>  			const struct opentry *p = optable + i;
> -			int oplen = strlen(p->str);
> +			size_t oplen = strlen(p->str);
>  			int res;
>  			if (len < oplen || memcmp(p->str, line, oplen))
>  				continue;

Makes sense.

> @@ -1592,7 +1590,7 @@ static int find_header(struct apply_state *state,
>  								size, patch);
>  			if (git_hdr_len < 0)
>  				return -128;
> -			if (git_hdr_len <= len)
> +			if ((size_t) git_hdr_len <= len)
>  				continue;
>  			*hdrsize = git_hdr_len;
>  			return offset;

We've asserted that `git_hdr_len` isn't negative, so the cast is fine.

> @@ -2185,7 +2182,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>  			};
>  			int i;

This may arguably be `size_t`, as well.

> @@ -2257,12 +2255,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
>  	}
>  
>  	if (patch->is_binary) {
> -		printf(" %-*s |  Bin\n", max, qname.buf);
> +		printf(" %-*s |  Bin\n", (int) max, qname.buf);
>  		strbuf_release(&qname);
>  		return;
>  	}
>  
> -	printf(" %-*s |", max, qname.buf);
> +	printf(" %-*s |", (int) max, qname.buf);
>  	strbuf_release(&qname);
>  
>  	/*

Do we _know_ that `max` fits into an `int`?

Patrick
