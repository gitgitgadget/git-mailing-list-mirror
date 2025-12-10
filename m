Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E7223339
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348108; cv=none; b=ipdQtQmNuPFcl9ajcgMS4rcbrBeyvSgcUYtD7iMu58bImKfy9H5E3U46gEk8TzqdTrHDZnMYyhvTLBFPKaDmjBKuSqrgFg8jhiXSC+l6Q5qGCpYBY+bsZ7CBdkssB6isn+7HrxzRc7MbLKz4FH28tnXx02Yi6MvcF4qIDgFHlUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348108; c=relaxed/simple;
	bh=pgfAEe9W5nTgYIMzz29fyigpZs6ayogHNmlBI9CZAnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxo5ZxbctCgCfzAsQjZyleoIA7awj1NRhB/HrxYF9qxEl0p8JzLgio1GbD9j6imvBU0rUZMEAzq0iPa7Z15hNd7V/7dcguDqLRHPjIjZ682CZCx62/31EQliVabqRhWst4Ge2uc5sZ9Wp/7AdZG2SF47EgNWNRh3rIyW1Z9ThaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TkLyLugY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EOa0dboJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TkLyLugY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOa0dboJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E0CA01D001B8;
	Wed, 10 Dec 2025 01:28:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 01:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765348104; x=1765434504; bh=ZRRxbAqGuG
	qrtmOu/0tpf7cPxM0yROeisbd6deJxZl0=; b=TkLyLugY0rttu3c/+00Mb7cHfU
	lVMBEs3jnuhsafkRcWAZmyAOpTDv9tKOf/MSgp1y01MgGv1xyqFSZQSEKncrHjLt
	f31kgGgIMjj8arufg6W74C5zAozzUX/qdHQknJei2bFxdLFisEj49R0BFZM9H9ZA
	NXmVuCnIzm344wyuj9W/t2bKazxKUm0mPCTqMfkXVNbGtznSUNvCAqlxzEIy8tgr
	zsSzbUvaCGDthHSLx7SKWfBBcaXgnPllENXQy3T9X/ufg12kjUuhOFy2S28xYd09
	bLifUrrYjKiEkpUZL1jo1w37zVtZqgzKd09lVY5rrMqHtx+u2NBFRq6ADwFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765348104; x=1765434504; bh=ZRRxbAqGuGqrtmOu/0tpf7cPxM0yROeisbd
	6deJxZl0=; b=EOa0dboJXoIN9DLYihvTvXaDxpzH5OnSnBko7PZcSO2bkcrqYW2
	cuMJ715FmhUVtVm1aI6XWQsq1TCVV0r3HrBYOTUZtvVe/D4dWqg1U6gx7R3MoTig
	gx2elNtIMj+DIJatR9b2BS7/aW7FEuTj7/wuYv4AmTAw5wOexl6hrLZ2GViGk7Xw
	wbBzTtPJOhalIrsCpnlFiValPgkXeT6Wo8YnQMbT6E90bqFImTiJpDkJCAeEJwqk
	yuPp0hYouiVvULs4IE13X8e3iSILugZJN/WLtL1blvxn6PwT+qASGSo2NHUxs7GW
	sGtb3RIrvcrko22e8e9RpB9LG5imkuGMTqg==
X-ME-Sender: <xms:CBM5aZ88R3CLNbL9eYyAi-qNtEMYXWfMPWGn5rRtFTVNyx4PpP3xDA>
    <xme:CBM5aTtJ82sULIKjlu2Y-DcAoLa5gh-GUWDNMu-CsqAeKytc9OtH_gpU99IDZR9GH
    4Xoh68SJV1wSDmbrGnv64nYl-5cgk1p9JTh8HRTQhRl-pCH9a6Mpg>
X-ME-Received: <xmr:CBM5aUomDmsvtZTZdisiBLevD7chJ-_ruYqZUsjYVivWX5rg05PA1MQYFfl5lst0ekQIvmEXh6yXFe-iqdRolfyE39tAi1CwZYZRnAHBh2QN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CBM5aYkSf-vegywaA2bhE1YR8WlopfI7N0AaucpJFpTkzbBUaFMT2w>
    <xmx:CBM5aQx41D255FLNLZvf_xNXq9Gbq9ghI4j12Cl5F3UWt3Aiim-Szw>
    <xmx:CBM5aYnQ-ee0cAVLnupIx2xKY2BwZPJdwF3yJl1wwo1qhC6A0LGIPw>
    <xmx:CBM5aReTmR5MZSf9-TNk6zfqOhtbcbV71KpntMh8uBHUEiNJHrfHog>
    <xmx:CBM5aYupIHHziEcRp664daIn50kP5nWNo5JoaGjAJdYvmxrba7e5IOeY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 01:28:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c567327 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 06:28:22 +0000 (UTC)
Date: Wed, 10 Dec 2025 07:28:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/repo: humanise count values in structure
 output
Message-ID: <aTkS_kBlNsnbPyP5@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209225820.2861276-3-jltobler@gmail.com>

On Tue, Dec 09, 2025 at 04:58:16PM -0600, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index a69699857a..8fb728b3a5 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -266,6 +275,10 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
>  	va_end(ap);
>  }
>  
> +static const char *unit_k = "k";
> +static const char *unit_M = "M";
> +static const char *unit_G = "G";
> +
>  static void stats_table_count_addf(struct stats_table *table, size_t value,
>  				   const char *format, ...)
>  {

I would assume that these units should be translatable.

> @@ -273,7 +286,26 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
>  	va_list ap;
>  
>  	CALLOC_ARRAY(entry, 1);
> -	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> +
> +	if (value >= 1000000000) {
> +		uintmax_t x = (uintmax_t)value + 5000000;
> +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
> +				       x / 1000000000,
> +				       x % 1000000000 / 10000000);
> +		entry->unit = unit_G;
> +	} else if (value >= 1000000) {
> +		uintmax_t x = (uintmax_t)value + 5000;
> +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
> +				       x / 1000000, x % 1000000 / 10000);
> +		entry->unit = unit_M;
> +	} else if (value >= 1000) {
> +		uintmax_t x = (uintmax_t)value + 5;
> +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
> +				       x / 1000, x % 1000 / 10);
> +		entry->unit = unit_k;
> +	} else {
> +		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> +	}
>  
>  	va_start(ap, format);
>  	stats_table_vaddf(table, entry, format, ap);

These units are decimal-based (1000), whereas in "parse.c" we have
`get_unit_factor()` that is binary-based (1024). Arguably, it's
"parse.c" that is wrong because "k" is generally decimal-based whereas
"Ki" would be binary-based.

Not quite sure what to do with this. For counts it _could_ be okay if we
continue to use the wrong unit prefix. But as soon as we get to disk
sizes we certainly should use the correct units, which would probably be
KiB.

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 36a71a144e..55fd13ad1b 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -10,21 +10,21 @@ test_expect_success 'empty repository' '
>  	(
>  		cd repo &&
>  		cat >expect <<-\EOF &&
> -		| Repository structure | Value |
> -		| -------------------- | ----- |
> -		| * References         |       |
> -		|   * Count            |     0 |
> -		|     * Branches       |     0 |
> -		|     * Tags           |     0 |
> -		|     * Remotes        |     0 |
> -		|     * Others         |     0 |
> -		|                      |       |
> -		| * Reachable objects  |       |
> -		|   * Count            |     0 |
> -		|     * Commits        |     0 |
> -		|     * Trees          |     0 |
> -		|     * Blobs          |     0 |
> -		|     * Tags           |     0 |
> +		| Repository structure | Value  |
> +		| -------------------- | ------ |
> +		| * References         |        |
> +		|   * Count            |     0  |
> +		|     * Branches       |     0  |
> +		|     * Tags           |     0  |
> +		|     * Remotes        |     0  |
> +		|     * Others         |     0  |
> +		|                      |        |
> +		| * Reachable objects  |        |
> +		|   * Count            |     0  |
> +		|     * Commits        |     0  |
> +		|     * Trees          |     0  |
> +		|     * Blobs          |     0  |
> +		|     * Tags           |     0  |
>  		EOF
>  
>  		git repo structure >out 2>err &&

It's a bit weird that this test here changes even though we don't even
use any units. But I don't mind it too much.

Patrick
