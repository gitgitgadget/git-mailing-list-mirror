Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA132E541E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348122; cv=none; b=UzgXPB1hO1flvV8mX49WeC9QUI22IKIqx2JRb/pIIeXpju6y/kE4ZgsuNyHSGNn54VNlRWItUkRlRIjDz+IeWz07WWxjTTP+3XqgkF2pDBjXkRRJnQ6ZoWRi8RmMIATZcPf3oHd/ucY8eiw1ZmD4Yt0T6CRMnT8Y5DAZoddEo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348122; c=relaxed/simple;
	bh=Hwj7XF40a2zRd0KuXKfg3qYi8O4N2pm6/N7fbs1RPOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQCBSBZMkjNUAqrsUPQMQIcNS9RNlyr9krAE/5mAjnKFYO1YOU6g6waPd266CRRCoysLfazS+Kw+taaOKws6oeu/8DdaY4Orkl9wzbehL8giD0pCZ3BL6jDb7n6Ugc9c06ptjxs+AfYSzFjtaBytuLXSnrZb+YFSkMAj5ijc8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sCYj1PXL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMvqC/Yd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sCYj1PXL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMvqC/Yd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 592B61D001CE;
	Wed, 10 Dec 2025 01:28:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 01:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765348119; x=1765434519; bh=Fmhw67CTPv
	vTMIUMLjC8agNREhbqWq9US3pTsklvluo=; b=sCYj1PXL2N3Jh/TldTnAidVkPk
	HUkeu2iGkWgQvgOzSiDv/huy7lgV6GRztg1BJOWp8P2MA0rtiS1H/A7wZHLQEOuR
	GEQcPB7MWr0ekTDVDdI+uQgupuu6/p6t6eN8w3tHKR03CJW1yuvMBuZHunY/o3K6
	xSYYaA+TiXqxKhVFe7PPzoeoi2FmKFMJ7G2mxhhpkejN3jpjPSWugV7w3pi48Dm9
	8lGNoOWSZHd6tMvwtj2IwJoUXLJt4KS4tPUWOD58oga+2kxVuoRjKh7pb8EaV2QU
	2WDZNARzKhkcvDoa3JsNlizu6FtbaX10S5R9vtosqS2eRwCRdb4Hyr8zdaOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765348119; x=1765434519; bh=Fmhw67CTPvvTMIUMLjC8agNREhbqWq9US3p
	Tsklvluo=; b=mMvqC/YdheUUkzAaYuJBZBvqCUhBuh8OAAzBDaFY4UIwjtdtDk/
	zcfQjr74gPVLz3UcYSiuDeqGuuH+vhuMV2zrLzs/da55pu665sJGEH5Pdl1gF2MF
	1uNqVD8EXuYaq5VxRLcP7tsz4Gh8beOxtZoME88rmAAbMszoeIZQQt0vBY2k7pSL
	LRC3VWLVxhDMOXAmHPIdFOjFURrQE8iHgMXwwyIontWw02c4YKacwkFLCONzRSf5
	TTTIkch5U4LsQ+dw6DRcXHbIOSczo+13RSil7n2VUdsexYLPw/gSeJneGOmcsS6F
	5KkF2+e1XG+4Shidkq9wFVYvPT5dT1vKSbQ==
X-ME-Sender: <xms:FxM5aauaxiIIBvCFIuJfrdc4CYk2XhC3aTAUtMBIcWPlzzaroLsrTw>
    <xme:FxM5aVccvfVOshwxLm989IGCEw32VLqSMsdwfdAm3SmpzPnYgdjBs35PTdyZc7MTP
    qwX8XBFnnYZmHauRCh_QDRKeE8VqGNpHsjm9ythftuMNGEFYdfPkdU>
X-ME-Received: <xmr:FxM5aTYxeE_wgBG-vpPUZwittuO-doTcldnqa2cvhXNEngJskv3ch5EblFNyUOxIiBy1-hDDIOkUzp8qDG6XiZcN-NOeToHB5poXeut6G8tR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FxM5aQXBBSxQT3SlHVAvX9fu-jf2GA9zZYfHvb8JtLxeUMDsrmxPnA>
    <xmx:FxM5adgqQBoAXvSw1dsoOQgLWZvTt1IQwfJR-oQjIbR6I1GY43dEaQ>
    <xmx:FxM5aWU5iEA3CBSOYdYw9SAvIZv0Y92_zC84RUFTOwWlQ_azTlGYMQ>
    <xmx:FxM5acPgQTi3EiGm-3i-86TXuioWEiXEmkIuiXTiSJuxNEDxsbdWlA>
    <xmx:FxM5aVcISgojUUUHvjVVs5MgK_E61abN_sykbPfafmtfUD8ppqrhzQs5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 01:28:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5a43fce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 06:28:37 +0000 (UTC)
Date: Wed, 10 Dec 2025 07:28:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/repo: add inflated object info to structure
 table
Message-ID: <aTkTEselZ4yL11qd@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209225820.2861276-5-jltobler@gmail.com>

On Tue, Dec 09, 2025 at 04:58:18PM -0600, Justin Tobler wrote:
> Update the table output format for the git-repo(1) structure command to
> begin printing the total inflated object size info by object type. To be
> more human-friendly, larger values are scaled down and displayed with
> the appropriate unit prefix. Output for the keyvalue and nul formats
> remains unchanged.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  builtin/repo.c            | 57 +++++++++++++++++++++++++++++++++--
>  t/t1901-repo-structure.sh | 62 +++++++++++++++++++++++----------------
>  2 files changed, 90 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/repo.c b/builtin/repo.c
> index a67215ae31..5c37f4116f 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -315,6 +315,44 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
>  	va_end(ap);
>  }
>  
> +static const char *unit_B = "B";
> +static const char *unit_KiB = "KiB";
> +static const char *unit_MiB = "MiB";
> +static const char *unit_GiB = "GiB";

Okay, nice, you already use KiB et al as I suggested in an earlier
comment. But I guess these should also be marked as translatable.

> +static void stats_table_size_addf(struct stats_table *table, size_t value,
> +				  const char *format, ...)
> +{
> +	struct stats_table_entry *entry;
> +	va_list ap;
> +
> +	CALLOC_ARRAY(entry, 1);
> +
> +	if (value > 1 << 30) {
> +		uintmax_t x = (uintmax_t)value + 5368709;
> +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 30,
> +				       ((x & ((1 << 30) - 1)) * 100) >> 30);
> +		entry->unit = unit_GiB;
> +	} else if (value > 1 << 20) {
> +		uintmax_t x = (uintmax_t)value + 5243;
> +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 20,
> +				       ((x & ((1 << 20) - 1)) * 100) >> 20);
> +		entry->unit = unit_MiB;
> +	} else if (value > 1 << 10) {
> +		uintmax_t x = (uintmax_t)value + 5;
> +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 10,
> +				       ((x & ((1 << 10) - 1)) * 100) >> 10);
> +		entry->unit = unit_KiB;
> +	} else {
> +		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> +		entry->unit = unit_B;
> +	}

Euh. What kind of black magic is this? This block at least warrants a
comment how you came up with these incantations.

Also, git-rev-list(1) already has logic to output human-formatted disk
sizes via `git rev-list --disk-usage=human`. Can we share the logic?

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index cf5e252f10..0ae96e6bbf 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -49,21 +54,26 @@ test_expect_success 'repository with references and objects' '
>  		git notes add -m foo &&
>  
>  		cat >expect <<-\EOF &&
> -		| Repository structure | Value  |
> -		| -------------------- | ------ |
> -		| * References         |        |
> -		|   * Count            |    4   |
> -		|     * Branches       |    1   |
> -		|     * Tags           |    1   |
> -		|     * Remotes        |    1   |
> -		|     * Others         |    1   |
> -		|                      |        |
> -		| * Reachable objects  |        |
> -		|   * Count            | 3.02 k |
> -		|     * Commits        | 1.01 k |
> -		|     * Trees          | 1.01 k |
> -		|     * Blobs          | 1.01 k |
> -		|     * Tags           |    1   |
> +		| Repository structure | Value      |
> +		| -------------------- | ---------- |
> +		| * References         |            |
> +		|   * Count            |      4     |
> +		|     * Branches       |      1     |
> +		|     * Tags           |      1     |
> +		|     * Remotes        |      1     |
> +		|     * Others         |      1     |
> +		|                      |            |
> +		| * Reachable objects  |            |
> +		|   * Count            |   3.02 k   |
> +		|     * Commits        |   1.01 k   |
> +		|     * Trees          |   1.01 k   |
> +		|     * Blobs          |   1.01 k   |
> +		|     * Tags           |      1     |
> +		|   * Inflated size    |  16.03 MiB |
> +		|     * Commits        | 217.92 KiB |
> +		|     * Trees          |  15.81 MiB |
> +		|     * Blobs          |  11.68 KiB |
> +		|     * Tags           |    132 B   |
>  		EOF

Nice, I like the end result.

Patrick
