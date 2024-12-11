Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E72175D29
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927206; cv=none; b=biW+om6XoPxl/MxqktlJlZflzSGa0GYF2eJOxsgdGClSGKjmhZLjVj40k4y6oKBAynoPbw77MBsTdNyaWdrrqMU33jAPSljwpOViGO0IJ1K20Zfy8zAmY3xhEABFAPJm0HxT4yIINFA0AanrGmnvNgKbFMweTZHRIdsDRgqK4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927206; c=relaxed/simple;
	bh=vicFdhnSoeAve589S+6gqNJuIy47v/2u91ErQz6qoxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skz+6Ysa92iPvrHR0+TIk4+RachdLMn/Lg9cH7Z9/gvNlmnboy0K4Ayai8gc092l4S95CxsL5VVu6+FKJITWHCQ+cS8Wdwe5DWHQibwmLZNJRDNRpv8tzw3H/TniLQMWq85GFXhfdscb64dkTkiei6rtM7psHrbWtrATGyGo+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aS5K7ZEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tu4sRyGL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aS5K7ZEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tu4sRyGL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DADC61140147;
	Wed, 11 Dec 2024 09:26:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Dec 2024 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733927202; x=1734013602; bh=jpMmgtKE77
	Z5UPyXZ1HpqDtSgSBQ2JMAPON8h/HVa2w=; b=aS5K7ZEJ5qFIQWCTNfahidOOer
	8h8pHrJsboB7nVOAl/FZrQ5DLPpF+U46n0dTXW0FM87rwDsOvMOppNqMS9l/IhcY
	TJU57ReFcsSCL2lZb2Lox3xQzaT9bV2lkeJcVAxBB+SvRu+hbzK1AKYWbhzIc/h7
	TUJNue133oMeQgIjH3LrHvNKpufJAPz431EGxXM6/ZjiVv+k6BaQOOvUoipa3eza
	Q2CBmthgfqgtxKQaw94XfGnABXPTmnVlOGzA6DqBjxHQDauzZYOcxJvIEujY00rz
	YhPzZBGkrmn56VTqq03XybZaGfSpXtdmrm76pBtIVyZfh0LH3up+pWGPIyRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733927202; x=1734013602; bh=jpMmgtKE77Z5UPyXZ1HpqDtSgSBQ2JMAPON
	8h/HVa2w=; b=tu4sRyGLWRY2h2oN0WDGvroYdeKS4QUX1d8/fZtutMR27GzjPf0
	eO1vXbwkVlq1dQfniWOqoTg7mmqSac8J4VTKX4XhOBY1fwvzQc/9MFl75VN2+mLG
	TFD6fwsXt72V+ychN/kKzBMZRQx2Solg8x1DBgV4Dyb8HwJuJj28oGiLlADQQZxC
	/tXS+7WJ/qRnnO/2ogAtC3R8xq5BdODO/JPwNHt6yQJY9IpuEFL+tXC1J3kZWkO3
	lmIHuI1SRrlNFLhy1wSiooReXke1yaljaDw4YN8c/rdL8oHPlU266DoS5g+VRoS2
	dhjRBRUaQnV2vOmQghOWH4BQNr84w+BRTMA==
X-ME-Sender: <xms:IqFZZ8XxLLgMnkH9ibW1WVl_PeURmZQwcka0-Ay5IzpMKYoZ02alZQ>
    <xme:IqFZZwkL7MuOu2xKuTnNCv0JL88e86Aj317y1Tk3S14hc4LPamKLyHX2Z8bYwNZqj
    jA-u4Z11m5Uteju_A>
X-ME-Received: <xmr:IqFZZwYhF9ek62FoEDvNHpdL_BG6Ih_4HruhuCucH3b-aOlitgpbQbulkAyYHKG3iyoehv3FyXwccICke8cMRfCPJMlw-q7EoRJ8IToife57dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IqFZZ7Xf70ad1F3m5N6iPCyNUCUgmR5rc4wItmYQ3NuXV_GxjlvgIQ>
    <xmx:IqFZZ2miPiSxVIhPIoU9Wiz_xEQPLRXfQtrDX6UTK8fg5Wdr1GEEdw>
    <xmx:IqFZZwcZSPxfcwN6Vb5cZOAV6j2iWDu7yKtMa3eUNheG0zVAFAP-ag>
    <xmx:IqFZZ4GDQMgukGsuCi09UlaAXasBQHVunevHBijUDBO_TwgmhzKVJw>
    <xmx:IqFZZ3ChlFeFLnWSZyUOfDJ_gTGSEilVO2AmKeUzwePp_uTmFO4tKPfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 09:26:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd507037 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Dec 2024 14:25:06 +0000 (UTC)
Date: Wed, 11 Dec 2024 15:26:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/7] refs: allow multiple reflog entries for the same
 refname
Message-ID: <Z1mhEsu8DBsCsYuA@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com>

On Mon, Dec 09, 2024 at 12:07:20PM +0100, Karthik Nayak wrote:
> The reference transaction only allows a update for a given reference to
> avoid conflicts. This, however, isn't an issue for reflogs. There are no
> conflicts to be resolved in reflogs and when migrating reflogs between
> backends we'd have multiple reflog entries for the same refname.
> 
> So allow multiple reflog updates within a single transaction. Also the
> reflog creation logic isn't exposed to the end user. While this might
> change in the future, currently, this reduces the scope of issues to
> think about.
> 
> This is required to add reflog migration support to `git refs migrate`
> which currently doesn't support it.

Nit: the second half of this sentence starting with "which currently..."
feels rather pointless, as it's implicit in the first half. I'd just
drop it.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c    | 15 +++++++++++----
>  refs/reftable-backend.c | 16 +++++++++++++---
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 32975e0fd7a03ab8ddf99c0a68af99921d3f5090..10fba1e97b967fbc04c62a0a6d7d9648ce1c51fb 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2612,6 +2612,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  
>  	update->backend_data = lock;
>  
> +	if (update->flags & REF_LOG_ONLY)
> +		goto out;
> +
>  	if (update->type & REF_ISSYMREF) {
>  		if (update->flags & REF_NO_DEREF) {
>  			/*

Hm. Does this mean that we don't lock at all for REF_LOG_ONLY updates?
Reflogs themselves have no lockfile, so isn't it mandatory that we lock
the corresponding ref like we used to do? Otherwise I cannot see how we
avoid two concurrent writers to the same reflog.

> @@ -3036,8 +3042,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  
>  	/* Fail if a refname appears more than once in the transaction: */
>  	for (i = 0; i < transaction->nr; i++)
> -		string_list_append(&affected_refnames,
> -				   transaction->updates[i]->refname);
> +		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
> +			string_list_append(&affected_refnames,
> +					   transaction->updates[i]->refname);
>  	string_list_sort(&affected_refnames);
>  	if (ref_update_reject_duplicates(&affected_refnames, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;

This on the other hand is sensible -- having multiple REF_LOG_ONLY
transactions queued is fine.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..d9d2e28122a00ddd7f835c35a5851e390761885b 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1405,7 +1410,11 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>  				}
>  
>  				fill_reftable_log_record(log, &c);
> -				log->update_index = ts;
> +
> +				update_index = strintmap_get(&logs_ts, u->refname);
> +				log->update_index = update_index;
> +				strintmap_set(&logs_ts, u->refname, update_index+1);

So we're now tracking update indices via another map in order to ensure
that the update index will be increased if we have multiple reflog
entries for the same refname. Can we avoid that overhead by instead just
having a global update index counter that increases for every single
reflog entry, regardless of whether we have multiple ones queued up for
the same reference?

I guess the result would be kind of weird as a single transaction with
multiple ref updates would now always contain N different update
indices. Maybe there's an alternative that allows us to reduce the cost,
like only doing this for REF_LOG_ONLY updates?

I'm mostly being careful because this here is the hot loop of writing
refs, so I don't want to regress performance.

Patrick
