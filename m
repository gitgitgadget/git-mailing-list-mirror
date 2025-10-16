Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7183346A0
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635641; cv=none; b=POYxqblPQGcCOK+GjOMbeHr8x0aCeEH7+m4iJhWs9FWoMbMsmbfL7u3YbSlD+bdVh7iulGNSLX+x5RSrYKI6sgJZdeVqLRkWxPGEGSHKmhT5HgrBU8tC/Ybo2JwADEMqcD1+317IYyjesG0t/xPFqWQJMfVhK9m71IFg+8KYLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635641; c=relaxed/simple;
	bh=2JaM/9N4mzdntGIWctMgAnrGcTTh2ry4e4dPJeh7Phg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sh5nm1J1lVXtGJ8O1VIVrWVTBRQ1EBhhrDxT8adVUTHC8RnbwD6rvPj06+HbGudwazgfDtvoHEq1/AOLrF5rWkbFa1J2DD/ewdsEIUy2+TOlH3e08EOewhwEVc4pNhi9nOuGu7vjqcEKPO+YHR+7JDt9zgo62Tfm33VXn9VorxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GFcnZUDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drU5DPDi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GFcnZUDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drU5DPDi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D42B1D000D0;
	Thu, 16 Oct 2025 13:27:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 13:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760635638; x=1760722038; bh=hNHYS2ViL9
	LG2WtmTzPeIHkjjpJozx7rK+02rXHagPw=; b=GFcnZUDEBosO4uYoOyfsXKQJWr
	kBhMxm4g0hp75W6eJKNFHcGvxm5JDEcNIA9EL47y5gDUdecPLX2HwA7wNcr1K5fs
	rlF/E4/Bd4QJGwC8Dxfni+US5J4GzK7dgoowu2ocwkmJjMef+rPOHTZSj982Q6fp
	OtDOG9wl2B2A9glf6MYYM5IlwJ668RGXkeg9I7mMDdBdm81yekX45SKV+wf/mhsN
	mOxNAAAIDXRVc7VV4SRGt+XfiWV2x+KOF+/mTTT0vz4WKnnQY1UOoeSb21La6HPh
	o2wMdlL90fvsIFTLX1/PFIzYePIlPt3S3LmlAFFjnU3irF9qe6OAtpPeoI1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760635638; x=1760722038; bh=hNHYS2ViL9LG2WtmTzPeIHkjjpJozx7rK+0
	2rXHagPw=; b=drU5DPDiWpYAV9rBQq8swvwLyMZ01yTj6UhaZrgZqQ2GnB298zn
	0XRGeoo4nZocdIqhXu7S/4FFkALL11RzeJsT4BPM2FlmEY+rGVaPUrs8gb/oeEuV
	A0yg8XViRPeD27i/q3e+KalUjeZuvhE1fETcVLOFL0qQfodHSFTS/sAvOTu795DB
	If7KgU19BFwlu4L2JxG2/4LM8ApOQFpFYuKgydvmlIaNy+WS6AJXjs9tKfKcLsl+
	sDL9t7ulnPDfcN10bqPMkf1bJTA1m+JFh5VhkRwGUJvudu4LLtrlBzlMTz5O3zTf
	i7Z2n8tSy6kg0FJPlQF9BpkDrgJjn9wMF3Q==
X-ME-Sender: <xms:9irxaAGA9VTviy5BvUks1sbBu_vIRz5T4D1ovl-AyWOyDQ3HlEq4yQ>
    <xme:9irxaANNobfCspopyZk3LQ18DT7wfZt1Uonp-o6WG0APyFmGRjwYlFI4r3NqMhULL
    opJY0vkOFZC9VWrfldFdrNlDtynERr2jsyrV4V8E0FB6EMSRCxP6Q>
X-ME-Received: <xmr:9irxaCcPtVam6IhrulkwnLKrl1SqPJg7Asn-8fetT0bq0Oil7cXHN1KqD6bpAinrWHjYQmrD-SiMs8AKkEOgrIfG9KEfOvO72v77>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9irxaNunSeZbrzsNnlLzMJE0hVvmo4AK_UGnq6J8_kofvCpIGs7iHg>
    <xmx:9irxaDn3JBdUTn0zKoc7mlTzOMxbUdqyiBTkEqQwFV2EdIEheIj8Bg>
    <xmx:9irxaPzSYmvk-A3bsqBkCvm0UlUZq9PqihipYcmPqnU8rmvErNnSOQ>
    <xmx:9irxaFOFK-EmJMxCzZd8HBZ8-vLzNJViaYe1TULtVkkxe23iiPVPwA>
    <xmx:9irxaM9JW1gC-UHMGYl3dDvOSOgyjUidNcfmBeFHWh2BIXrIgKiMQJGo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 13:27:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v2 1/2] gpg-interface: replace
 strbuf_split_max() with string_list_split()
In-Reply-To: <818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Thu, 16 Oct 2025 01:03:53 +0000")
References: <cover.1760571220.git.belkid98@gmail.com>
	<818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
Date: Thu, 16 Oct 2025 10:27:16 -0700
Message-ID: <xmqqms5q4v0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> @@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
>  	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
>  	int ret = -1;
>  	struct strbuf fingerprint_stdout = STRBUF_INIT;
> -	struct strbuf **fingerprint;
> +	struct string_list split = STRING_LIST_INIT_DUP;
>  	char *fingerprint_ret;
>  	const char *literal_key = NULL;
>  
> @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
>  		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
>  			  signing_key);
>  
> -	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
> -	if (!fingerprint[1])
> +	if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) != 3)

The original splits the thing into upto 3 pieces, but only complains
if the second piece is NULL (i.e. we said "up to 3", but there was
not even one place to split, and the request to split_max gave the
one thing as one piece).  IOW, the original code will happily accept
if the finterprint_stdout is split only into two, not three.

The updated code asks to split at at most two places (yes, it is a
confusing API, but if you split at two places, you will end up with
three pieces), and insists that the split results in three pieces. 

So the rewrite tightens the error condition.

Was the original code too loose in detecting an error, and does this
patch tightens the condition "while at it"?  Or was the original
code correct to expect that there are legitimate cases where the
payload in finterprint_stdout only contains two pieces, and it was
the right thing to do to accept when fingerprint[1] is not NULL but
fingerprint[2] is NULL?

This is a genuine question.  I haven't studied the code path to
reach this point in the code flow, I don't know what the data in
fingerprint_stdout is supposed to look like, so I do not know the
answer to the question (in other words, it cannot be an oblique way
to point out that the updated code is wrong or anything like that).

>  		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
>  			  signing_key);
>  
> -	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
> -	strbuf_list_free(fingerprint);
> +	fingerprint_ret = xstrdup(split.items[1].string);
> +	string_list_clear(&split, 0);
>  	strbuf_release(&fingerprint_stdout);

Since this code releases fingerprint_stdout before leaving, and
returns a fresh copy of a split piece, it may make more sense to use
string_list_split_in_place(), which does not have to allocate extra
strings while it does its work, unlike string_list_split().

>  	return fingerprint_ret;
>  }
