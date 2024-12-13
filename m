Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EC1DFE08
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092692; cv=none; b=tF2xUz1mM/m7hA1Z/wslnTiY0h3B10CQH4oSpTYjxlCkPcSdIQ75lsOAhsWUriyx6A/QTlxgapmc0zraHimU5GaDFDgaf+D4/u/bT4aT+doMwro92JxLInhs6SoSZ4U+N5H8TQH4x3MgISTwLI+PCiwpEOd9cAhHXvlp/Hvm3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092692; c=relaxed/simple;
	bh=YtDV6qFb4Y2FIt2xYuCVJMrtxE3Me9ru3U4V2zZGB/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlPRdiMevw6+yIKOvl3e4FRPi+inRSgSMDmUnNZ0Yj8jj/W88oGA8M+vMBwZhizHVbF82Qqi3ArDNZ1fexlIG7jLI7NQ7fVuxzSM9Ti6jx3R+S6PcYwHsdpsrszoY4miIZWlFvG6AxF6KJcXlxitJyyJrwwYpERPbKkYNAuKLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HzDU+DXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bO8zeX4M; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HzDU+DXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bO8zeX4M"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 37E4E1384060;
	Fri, 13 Dec 2024 07:24:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Dec 2024 07:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734092690; x=1734179090; bh=JBRCXYsfUr
	BKX6W/tkIWj0E0OFfHJJqXEVT10f14u2M=; b=HzDU+DXeehoFwS4shTbeRwWo7u
	u3/tHqxs9fVeceRabhlC4YMegWtjumCjxAKHSHz6uLjI4g9CRsCiLV4Qv+2TPmgZ
	xM2NePqIvNAjXlBXZkjt4S9D48q1m+OmK/aAfnOsLiGs9ByhleM0XOOnRYmfLByh
	Fe7WpRX8qBjLcWWHvcJLbfsv4TwhldNw7kMWYMi5Dllcp0iwD+/xdcA7RufIjSLm
	KS8sFdWWaIaz3e7k0z/xI0yU2PJTbwKdwQIhqBuhwtqhNNjq5nEJI7DQxW+pO5be
	uFq+02mU+HADlYiW8kkTphRmfniCscmLezf5MiJjLn5LUWf7NuXAq0AM1Esw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734092690; x=1734179090; bh=JBRCXYsfUrBKX6W/tkIWj0E0OFfHJJqXEVT
	10f14u2M=; b=bO8zeX4M7eIVGZAUe6V608u6afgoUIC5zXjb/9SoXG1TY23Aq/M
	Q6yekMa5qj4mw4Spm1dRUtKSwfPyyCDbnbsY5tB+SUlfaNVW/lIlxN+igqy0nhyU
	rnh+sQsC+OiaZISaLPjKVbrhqupbFwWZovMvd2MYqQuVrlpnhlzIhHaHEhbZ5iCr
	wuED4tl+CZQm+SOD6U8nw/WsoEChKLI036SZOG5o7xGoL9mfAnZb0ac46KrBO4Gx
	k3OgvYGj73iOhRDgCbTUlXWzA3pG80GWrgS9nkpGX5M5d43syOFRc5mUyCh+5u0c
	YgKt26CJpSaEaj9bl7BGP1dboB+tkjN+ZNQ==
X-ME-Sender: <xms:kidcZ9l69IdCD-nk0tcKj4TXO6cj1GprO66zXpIC0hch1x4JxZVopQ>
    <xme:kidcZ41geT-xcWtHGYu9UVif4hHXK4KtWJ-QshAADdlSFHr_expkauyOp4ZQoqpP9
    2Ksxu27UzaNG9Tuqw>
X-ME-Received: <xmr:kidcZzoiyVI6eoxDesYvvT0BRAcqzn_CIxOQLrNvYcAMSvPDWzmqs_C5qzzeYreStgjCaXluTY3QCNpx--yYsKWvGmG0DhV9C_w8ENZx1yjd76g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kidcZ9kavxIXZWm2_BJnGA1ZHRphpRfYvTDs1xOPngDqkTX5vVP5rg>
    <xmx:kidcZ70ozddfmDuYwOKI-X7oSBzzJgEvA6WMBBQWcHYWXrD_VZKUbA>
    <xmx:kidcZ8vCFipd34xRlACqnFdtQ0DgsSjs9WsCJI3SenLedbLGPL1k8Q>
    <xmx:kidcZ_XjdG7havOVRVlTNB3RZnGk--viFTNjvIVLb8qShSPNpRkdlQ>
    <xmx:kidcZ8yW6rFz_JzkGzZUcaQOAWMc8OoEwi3cjB7nkzWnqQeRcFRjFT1y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 07:24:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e496c37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 12:23:10 +0000 (UTC)
Date: Fri, 13 Dec 2024 13:24:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 8/8] refs: add support for migrating reflogs
Message-ID: <Z1wngv1Kox_QQcwK@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-8-f28312cdb6c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-8-f28312cdb6c0@gmail.com>

On Fri, Dec 13, 2024 at 11:36:53AM +0100, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index 9f539369bc94a25594adc3e95847f2fe72f58a08..f19292d50f0003881220e8f7cfcf6c7eb4b2e749 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2708,6 +2710,53 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
>  	return ret;
>  }
>  
> +struct reflog_migration_data {
> +	unsigned int *index;
> +	const char *refname;
> +	struct ref_store *old_refs;
> +	struct ref_transaction *transaction;
> +	struct strbuf *errbuf;
> +};
> +
> +static int migrate_one_reflog_entry(struct object_id *old_oid,
> +				    struct object_id *new_oid,
> +				    const char *committer,
> +				    timestamp_t timestamp, int tz,
> +				    const char *msg, void *cb_data)
> +{
> +	struct reflog_migration_data *data = cb_data;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *date;
> +	int ret;
> +
> +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
> +	/* committer contains name and email */
> +	strbuf_addstr(&sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
> +
> +	ret = ref_transaction_update_reflog(data->transaction, data->refname,
> +					    new_oid, old_oid, sb.buf,
> +					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
> +					    (*data->index)++, data->errbuf);

This is where we now increment the reflog index to ensure a proper
ordering.

> +	strbuf_release(&sb);
> +
> +	return ret;
> +}

We're now allocating one buffer per reflog entry. We may want to
optimize this by having a scratch buffer in `migration_data`, which we
could then pass on via `reflog_migration_data`.

> @@ -2910,6 +2940,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	if (ret < 0)
>  		goto done;
>  
> +	data.reflog_index = 1;

I'm a bit surprised that we initialize the relfog entry here, because
that means we now have a globally increasing counter across all reflogs.
Couldn't we initialize the index per reflog instead? It ultimately does
not really matter, but feels like the more obvious design to me

Also, is there any specific reason why we start at 1 and not 0? Just curious.

Patrick
