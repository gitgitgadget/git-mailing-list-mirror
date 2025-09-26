Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303A10FD
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901364; cv=none; b=Qb0ucCTLmkmA7frj+Zde97us6oXzckBuPrsW/GDzLMk3yd6Og4PBxmLgcjKqd+oPxF3o1OsuOSqcZY1CJg3p2/DrRFGalWvK6hgugz2ye8H6zMUSKUQbeBTqovVHmNlGesh9pjg4yd/yek3SvXPyF+60H2d4UdBSqc7ApvpujfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901364; c=relaxed/simple;
	bh=yOdjS2g6p4TsRgpMgX276jDT03go9M41y6byxWqjccc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOsx6ZB5MdkCbqMs1M/svb7mK4Ekss6tf1GsksVqG8B4pskNwAf6VsZ+WIjKtV5ODnfBpxa3sLrSKb2+C6DY41g5bQsUt9/+EVbx5RedKAkMUOg6W+iJm6RS1mZs7/vWRTmurM0gXHiENyRaMafZh2AW8VZggUxERzzHbmRotes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BB0D09wM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZdjAmdK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BB0D09wM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZdjAmdK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADF607A00BA;
	Fri, 26 Sep 2025 11:42:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 26 Sep 2025 11:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758901361; x=1758987761; bh=rvSTeLDfZj
	dYU0n2Yif1OEpTucyhjlksXt9ixHvzJJI=; b=BB0D09wMjKN90hjindIrEAS+V+
	y+NByVA29mX+x/l47kcWMLGIFw7xUJaABpEyNU2gB4POy84qw6ipHV9munNdvT/C
	gPgH5KJQpxmdItIBnLw6t3jUX506ay2A3l9y5BsImklSv80gDlEbj/Jy0U1gforZ
	SesBA0M6VzSht4rSHuZHMHoNgsEuREOduvOoss1cHgZn1ill7g5M+H6ZHYH9hACZ
	BOMeGJUBS933DwYeK3ez7f/Gsf7ka16HDN1q+R1fGxPrph/55pU4clKLPYyd9uw1
	r96K8g+hxIl34WQzpBoan3hpHudHDDubLg2OuOR+UzpG4TebH++BwtSCX5vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758901361; x=1758987761; bh=rvSTeLDfZjdYU0n2Yif1OEpTucyhjlksXt9
	ixHvzJJI=; b=HZdjAmdKBDVsoVXPMH9z3a7662xuGnntXXb+LE/3BjBRtdGFWxF
	tGV7hpBkAYvTBPthS6lelR9iqD2VbClsdwPcMJLfD9ycZrlVoDgYFvhrKkfCxXbf
	SZxikRdOBCsYt6iNuz8NFK/hnzx6hUJ2hB4m280+7CPsvv+Vgb1+8U+13TTxKuZ+
	ziTZlFxloGnMywLT0hkT5QWsBq0VlsOsXi9hbQ7znRcWhivqb1QfeFm3tXQjYO5M
	ZFW+MO379km24MODLx7zlzE9hVcROcBSKw/Z6o6L9qJ0skucVjcIGWXRJIr1e1f7
	c19VbTRWO7trxLXV1W0xMFdh3SSLsVMvPbA==
X-ME-Sender: <xms:cLTWaDmPxQB8SfY725GqhukWEVLGPtq1uCmNzHX2na_PblMxPGdH7w>
    <xme:cLTWaIVb-M7imKHYOpaKxvrJJE7L8_GiC1clO0okFnQLKlPw7L5MRsKK9dcZ-zv73
    WL0_GXni-uV4cBCyzOON3SraZrTyUna_EvmXtldMQMXkdE6ld-F-A>
X-ME-Received: <xmr:cLTWaJsyqisr6NtDkxrp1cepfVBCmG53q1YwtQs21l5do_TCtNru-RRNt8IkCCdyBSlZm4GvJszaiuX37FWJUloKMJreEKYCPFSW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cLTWaLYnz5UfeNu-z185yBZz9jcA_tNFAgtiv9LoyWOPmkSjANjKZw>
    <xmx:cLTWaIW04qz0p_9J18agEHg_1FZn-BrUc59KA_WDKSPuJzWPP92ypw>
    <xmx:cLTWaAScwwLXdZd1B4BVIrj-OZRz0ez93GBOaLK8Ufa_mNwvPW6OXA>
    <xmx:cLTWaGNg6H8Kxtb9QmWLP8dOCtJS1Q8fBArgrsmwRr6MY7UgNGXPUg>
    <xmx:cbTWaKTOEtS73yEXhuTndCNFXotVT6nI4v-zc0_UFWx7_nRMhDmqVvaB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:42:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 2/4] doc: remembering-renames.adoc: fix asciidoc
 warnings
In-Reply-To: <6dc8844c-8554-4c6c-a3bd-5ad2c04ab7a6@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 26 Sep 2025 01:24:22 +0100")
References: <6dc8844c-8554-4c6c-a3bd-5ad2c04ab7a6@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 08:42:39 -0700
Message-ID: <xmqqqzvtcj9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  .../technical/remembering-renames.adoc        | 63 +++++++++----------
>  1 file changed, 31 insertions(+), 32 deletions(-)

I know this is RFC not to be directly applied yet, but can you
describe what warnings are in scope of this fix to help commenting
on the changes?

> diff --git a/Documentation/technical/remembering-renames.adoc b/Documentation/technical/remembering-renames.adoc
> index 73f41761e2..89db8b406d 100644
> --- a/Documentation/technical/remembering-renames.adoc
> +++ b/Documentation/technical/remembering-renames.adoc
> @@ -10,32 +10,32 @@ history as an optimization, assuming all merges are automatic and clean
>  
>  Outline:
>  
> -  0. Assumptions
> +  0 Assumptions
>  
> -  1. How rebasing and cherry-picking work
> +  1 How rebasing and cherry-picking work
> ...  
> -  8. How directory rename detection interacts with the above and why this
> -     optimization is still safe even if merge.directoryRenames is set to
> -     "true".
> +  8 How directory rename detection interacts with the above and why this
> +    optimization is still safe even if merge.directoryRenames is set to
> +    "true".

I always thought that numbered list would have a period "." after
the number, but if doing this produces commonly accepted rendition
of a numbered list without warnings, I can buy it.  I personally may
feel it a bit awkward to read the source text until I get
accustomed, though.

> -=== 0. Assumptions ===
> +== 0. Assumptions ==

This is because these sections are not nested within a group that is
headed with a "== title ==" chapter?  Which makes sense.  I notice
that this one has a period "." after the number (which the warning
mechanism probably did not care---it is just part of the title).

>  Here's an example where that can happen:
> +
>    * E:oldfile had 20 lines
> +
>    * G:newfile added 10 new lines at the beginning of the file
> +
>    * A:oldfile kept the first 3 lines of the file, and deleted all the rest
> +
>  then
> +
>    => A':newfile would have 13 lines, 3 of which matches those in A:oldfile.
> -E:oldfile -> G:newfile would be detected as a rename, but A:oldfile and
> -A':newfile would not be.
> +  E:oldfile -> G:newfile would be detected as a rename, but A:oldfile and
> +  A':newfile would not be.

With blank lines in between I personally find the source text easier
to read, so no complaints ;-)
