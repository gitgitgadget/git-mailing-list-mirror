Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB162205AB8
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572034; cv=none; b=SXc/t8FMLL1w/4I/Hy9Cu3hLDp7Nlga47KHAp75J68YkuVhRrFOIIQYJV/wSBKFpdvaNC9PD6UVz374LUCBs+RNgcYwrjJt4HFIZYhWzYn9f5wrogA5fK2d5kUwqLWNOrF84hXRpStonaj8sPF0h/qmw20xKZiQ4URGt+5M6Y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572034; c=relaxed/simple;
	bh=S6dFwr4RLs6zQeZfoIu/F2VX0SGO/B+F4gnchDCvFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP7ZFYHuR2FkqR6VqQrdg2iHd5XKgLmZQqQDjlSPAAzzHSPBXXBDUObZ+D+ml6pGeD4vaP/Wyvyi/s+RAddMrbtUsrTa/5rkknkK5dYCDApUfRx8CGL9yCDCSJO9rs8a1aqtgecJvik95+Ei/gnRegDCk1i6BcO+Fyl2/bxdsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C5pGt5Kp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zyGV7zqu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C5pGt5Kp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zyGV7zqu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0856C138085C;
	Mon,  3 Feb 2025 03:40:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 03:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572032; x=1738658432; bh=Dd6ZDq9gya
	Hhnx45Omey8oD3t3lTW1jpiTkFmuU/wmg=; b=C5pGt5KpA3wg0JNYqrfeyMerKo
	DIUJ1+TEXQYjMvJeX0ycQ1oh0DOflxaB5DZBniEkwv+uEwafwvmEm/OZ93m6HgHp
	SU55z0h1080wh0hQRlzjH6lJVPm1++Nmas7k2BCbz33jK0ZekPk9cE/HdJVf9ttx
	akHtlXHkqLsbYjnPZPaKZq45wFlj3/ztr0LFQbeUwpz6ZJAXn7sYQULfBqFY6Wfq
	kUHrrlWQcDbnOTGIiRHwnW03zDUwKsUGLjGDd0OwpPDRLvYQNcdyKXuz/o/XXtTK
	uyDvGiRMsKZbLdms+zWj5qppII27Pkb56W8wsr5Iu2KKdy8Pxqq147lPIG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572032; x=1738658432; bh=Dd6ZDq9gyaHhnx45Omey8oD3t3lTW1jpiTk
	FmuU/wmg=; b=zyGV7zqu13ep7vjIzvwtWEuiyCZl8RwID9o6pGt4HZN5FFzuup1
	fDa+0IuOvn7N66I7u/Vk0RmG+9vX9R9q6yWOmSXKdeMLcEiIRZ9ZiTwyYbHmJPZf
	A0eXiu9idzYrjBAQj16n3hXYudq2r+tlDgt8HXdGvN2KnuRL0+ndVwfmIAk0gEmU
	Vl+20EqJl5NWYJ8RBTLHAalOnI+4j6LULJ4BKKvKXQPISEJlwPjD+UytYtu7kOcS
	vpc7U4AnAwFxU+hgaoQWUcSZIn9St6ozeYxmGWD9TrMMIS/WIpuFx/MgIJrYEZ12
	YLPo5ZCWmmjogs4up/kpg60uDFoV6TD5qFw==
X-ME-Sender: <xms:_4CgZ8HWjqJjcGIAPr8ssYMMNLlVlWdPdzCZB-slj_dAwewOIRb3Yw>
    <xme:_4CgZ1XypCvNNuFrz4AM8K-ANNw5JtF9N9Scj9h4iWvD7ZbUi3ctb39LE57mnFSB5
    -qSvL4R5CFR9-EFzg>
X-ME-Received: <xmr:_4CgZ2Lkr9parIgjbiOfgCjxivy14OzBIqGX63piHiLvl_lJvjDqVVsZM0TMhklk9SyLUnyzWXAmM5Dog8JLvn0--uzX5WyPyuXIBJE93l9oUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_4CgZ-G1T-87BKoRyIQW0IuexHVph3ecNShfi9H7FIk59vQ6koUb2Q>
    <xmx:_4CgZyVbCIhZhRX8s3ObwB7YDtpm_mnvXxaHTe6bMwCXswIa1bY13Q>
    <xmx:_4CgZxOpdAoq30t2G7FX3w-VnNzteDd-qWMftVsUbOxIUP11zvOOrg>
    <xmx:_4CgZ52gtA14WZcAxC2nm1Zp7KAH73nDY2iHfQkbipozSACrqY0YWw>
    <xmx:AIGgZ0cR2IyD-d4mDyeSsOlYQT5_N-MPk2lVFSvZhgjtbcnVWFwwaM2i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d02e28ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:30 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z6CA_aKlWHLwHghA@pks.im>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7KvL1bvSO4UQY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r7KvL1bvSO4UQY@ArchLinux>

On Thu, Jan 30, 2025 at 12:08:10PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 271c740728..b250f987b2 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1768,6 +1774,28 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>  
> +struct fsck_packed_ref_entry {
> +	int line_number;

This should rather be a `size_t`, or at least `unsigned`.

> +
> +	struct snapshot_record record;
> +};
> +
> +static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(int line_number,
> +								  const char *start)
> +{
> +	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
> +	entry->line_number = line_number;
> +	entry->record.start = start;
> +	return entry;
> +}
> +
> +static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, int nr)
> +{
> +	for (int i = 0; i < nr; i++)

Let's use `size_t` for both `i` and `nr`.

> +		free(entries[i]);
> +	free(entries);
> +}
> +
>  static int packed_fsck_ref_next_line(struct fsck_options *o,
>  				     struct strbuf *packed_entry, const char *start,
>  				     const char *eof, const char **eol)
> @@ -1893,13 +1921,60 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
>  	return 0;
>  }
>  
> +static int packed_fsck_ref_sorted(struct fsck_options *o,
> +				  struct ref_store *ref_store,
> +				  struct fsck_packed_ref_entry **entries,
> +				  int nr)
> +{
> +	size_t hexsz = ref_store->repo->hash_algo->hexsz;
> +	struct strbuf packed_entry = STRBUF_INIT;
> +	struct fsck_ref_report report = { 0 };
> +	struct strbuf refname1 = STRBUF_INIT;
> +	struct strbuf refname2 = STRBUF_INIT;
> +	int ret = 0;
> +
> +	for (int i = 1; i < nr; i++) {

Here, as well.

Patrick
