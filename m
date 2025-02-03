Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC132046B9
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572031; cv=none; b=oZE2oUnCmeZU2SLk5Kko/oT35ZlfW4U17/oJNBk4a09fkoDRDKkNk9F7RiMC4LmYn+0TBBMI+YnKARLPKWwVQsE3H3HrKVE8n1Khms9w155V4vtDA3ZlrvWm69hmAP8szSciMlOWtfXf7ZHgODPuZ3W9d2ctSgIi/hRCNa3+asQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572031; c=relaxed/simple;
	bh=Sx9YAkdfzo/kHuP/INHhPaVMNr3g4qOnwrxSeSUwaNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpQQd9CUWwLe+v/tBfmpirQNMkUCloknpqmfQribiMj0MmeqshdQrEbv0cAt3EtRRXy1n9KXWpsJTMFricbCxr3Mp8FC7HvM64LKSQO43I/qGbmGSEEyeqq6AcYAqr2w0/DEQF8QoxV++Jvom5aMY71T4LQRvaiX6xIIFGUq8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ym7qX45A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pKfQu9BY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ym7qX45A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKfQu9BY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B36FC1140152;
	Mon,  3 Feb 2025 03:40:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 03:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572028; x=1738658428; bh=raMluAfDhi
	bMH5+FMfQhuL077v3mFeqkX1KeOBrftCo=; b=Ym7qX45AuG8CcTj3LqHrra3zRY
	3ptC87FK+DMuJd2WWlFEjJpgV8KULS4K8DWqyB5XTJBvn/dznVvFu8G2jsAJ/H64
	u8MYG4p85bGMb462RJBpUOtJ5JtpuZIZeY3TjYUHQhIOTI/SwQa5Jj095oymPwwd
	8pX7I0L+yPqydaLFd6YCJMFdvfu6CeSGo61Fo/4xRUddVFxoj0xqTvX0BG5DIiTW
	wpfa/WUPyFRKhngWVO65We7AaFwWo9ph8NhU0M68+0cdHjhD5cjY3v3f0hzqRfA6
	FvCWs8tsmbExSU8ZWQEO6nqN8V6s19i9GNHxmXtuGLvQdUF9C9UToINzKCPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572028; x=1738658428; bh=raMluAfDhibMH5+FMfQhuL077v3mFeqkX1K
	eOBrftCo=; b=pKfQu9BYb4KHRtU4Y6/PzFgQITLrDwW032HlH8gMRluR1xbAyZQ
	WbKfZlpMhuKFHZkNnzjzJGuJ8z4Txf4JNpqfKdENTtUlUnd4YMnSfR3gD487igx9
	gg/4JJpAai020Gy8gm+OyoNXbKv95jf1w7NiuOXVzOz8VHAaiBy2g7YOlHIBrSHN
	+R4T0LEGPHvhm32hLb1tyf08IqbC5dOxMTJp4jkD7rq66tz5x8PNsiOAc1GykGYQ
	b5nEzY2ASPhkeFEdxdQ/HdNDEDEfjRYNl9VANtnTWzts7iCFMUWELrm3GX7u0tyL
	ZeJkrHZ1zHjNd9sbKiou2PYBCwrfl/MVNkw==
X-ME-Sender: <xms:_ICgZ_2Lmlg6395GzCqEBCEXFuAno3q7SrFxaWR7-aKk3pskanX_Zg>
    <xme:_ICgZ-EExU5fOTsX83Yg_NbfxfFS-QSLrMmAR1_HgRxaaeRZ4gEPPyLkUeZn-Ei6M
    EiaKHr5TtqudPRChw>
X-ME-Received: <xmr:_ICgZ_6RESFvhhZeytAs7JpJWwZfIZm3DGgIaHXKUe7DRTRtM0xm44T4tC79Cb2SR2gh1k70nh7fSl4UyN0NTjGbxqwChPYpgz22kzpVwTfOYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:_ICgZ03JsPx96AOWZQcegVK6DrDzMKhc9CbNmK6kawUub0VI0T1lWA>
    <xmx:_ICgZyGoYAFhzjuu-XWLPDCktY24uW9kb6qath1YQrsF-QRDHBYjvw>
    <xmx:_ICgZ1_Yh4qeNR-QZFyQN0xDrJDupCl-__lLMk2xfXb2wRKZXKoG7Q>
    <xmx:_ICgZ_kLblRpVv5RlBv9PX5fswn1FaVayxj-acKM4M3ZE6mvKw7i_Q>
    <xmx:_ICgZ_OI1NsR-0gC4omBWvdrNcenM1fHpFRG0Oumm7aBJefGwlzyrVUI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cbaa21e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:26 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 6/8] packed-backend: add "packed-refs" entry
 consistency check
Message-ID: <Z6CA-aj7cgAxLTUI@pks.im>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7Hlk_VS0jYU74@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r7Hlk_VS0jYU74@ArchLinux>

On Thu, Jan 30, 2025 at 12:07:58PM +0800, shejialuo wrote:
> "packed-backend.c::next_record" will parse the ref entry to check the
> consistency. This function has already checked the following things:
> 
> 1. Parse the main line of the ref entry, if the oid is not correct. It
>    will die the program. And then it will check whether the next
>    character of the oid is space. Then it will check whether the refname
>    is correct.
> 2. If the next line starts with '^', it will continue to parse the oid
>    of the peeled oid content and check whether the last character is
>    '\n'.
> 
> We can iterate each line by using the "packed_fsck_ref_next_line"
> function. Then, create a new fsck message "badPackedRefEntry(ERROR)" to
> report to the user when something is wrong.
> 
> Create two new functions "packed_fsck_ref_main_line" and
> "packed_fsck_ref_peeled_line" for case 1 and case 2 respectively. Last,
> update the unit test to exercise the code.

I think this message is going into too much detail about _how_ you are
doing things compared to _what_ you are doing and what the intent is.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 870c8e7aaa..271c740728 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1819,10 +1819,86 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
>  	return 0;
>  }
>  
> +static int packed_fsck_ref_peeled_line(struct fsck_options *o,
> +				       struct ref_store *ref_store,
> +				       struct strbuf *packed_entry,
> +				       const char *start, const char *eol)
> +{
> +	struct fsck_ref_report report = { 0 };
> +	struct object_id peeled;
> +	const char *p;
> +
> +	report.path = packed_entry->buf;
> +
> +	start++;

It's a bit weird that we increment `start` here, as it is very intimate
with how the caller calls us. Might be easier to reason about when the
caller did this for us.

> +	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
> +		return fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
> +				       "'%.*s' has invalid peeled oid",
> +				       (int)(eol - start), start);
> +	}

All the braces around those single-line return statements can go away.

> @@ -1843,6 +1919,26 @@ static int packed_fsck_ref_content(struct fsck_options *o,
>  				       "missing header line");
>  	}
>  
> +	while (start < eof) {
> +		strbuf_reset(&packed_entry);
> +		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
> +		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
> +		ret |= packed_fsck_ref_main_line(o, ref_store, &packed_entry, &refname, start, eol);

Don't we have to stop in case `next_line()` returns an error?

Patrick
