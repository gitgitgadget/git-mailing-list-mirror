Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1095267B84
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481690; cv=none; b=cEPLMoRWbRxHJXmUyVSsv2r8IYZjebnDSd+PRoCrZVZfn6/PkuaduPJD710XvKkzuYdUnEPAzzUEXIywQIb/TfbtLJWASjuwECEZP5x3iJOrjdfzRALsS29WQgHB2/wv45lQYHLR/wine5os9+A8EMeRpgBQySLDjf1r+PUb4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481690; c=relaxed/simple;
	bh=KgiNaRWV52HgMv3bxXj3SizcjeVQyZvGW6VgrZal5o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSIVHUBNKZoMeeDSujfSZ+7LhGmcyUXlYTR88yEwY68YcvtXZ1OsrOeT1qAQXJ4mma9TyoOI2WHIiJqK8JAVuo6ffWGVwoGj3McKkfDK/daQNYJdVZGVgBnXIWie2Vt/1gIGH+lrlTkPanJrivC9SRJySMXIYFBQpA3cK1HJUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SJriBJAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJ3Y4+Sc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SJriBJAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJ3Y4+Sc"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9828A2540099;
	Tue, 25 Feb 2025 06:08:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Feb 2025 06:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740481687;
	 x=1740568087; bh=OTiBHL4p3hlgnZCtqXYH8IFn5/hKh57jEgtMUSTNAUw=; b=
	SJriBJAyhDxBw6IQJZX+Wcu6nBoELH7UO6/TXwE7DTycZ3q+IjlrqUTMqMB159O1
	Y6ByGueSqvtwJoSjRqiAIYLwMSwC6QiyBWGICyqCM2V4iu/dsubcEBDH3j5YSmx1
	y9n/cqHxnJZwKuks9YBGAmjmoqz4siQlUhP3kB6Sm5cEBD61y74SCd9r7w9oLGu3
	Irh+vAP4VkvAY2gVjecnqZYhFtHPN2dbqbwlnwyPcx1oJRsEXrSkFQjeHpvooMoG
	5GRP4YypHj8W+b5JrBcG2RmWcte4F/go05X8xaeJFR+aTT534RtQNWSRssQ22QGd
	6ER4QK8fVl3jjs125Q0vTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740481687; x=
	1740568087; bh=OTiBHL4p3hlgnZCtqXYH8IFn5/hKh57jEgtMUSTNAUw=; b=K
	J3Y4+Sc7fBaNg8CkxPMdxEh2R/70TNZTMRizg0DbDEbkHXxCxWJqtYj3NYHLu6TT
	0cojLtnXidY2EZLntFC8BqOTMSsx8hPb8BAcT7fInK944cHJY3YUsqabw/QnOzMv
	fjr7l4KB8jmVG7e9FahVvRFmgWrZZFk3mVGR9azckQek/vqllILxmH+ofmYo9bAS
	dfKjb4ZfaxwzNWpxYtEqz+tpW1Gun6AvZh4l2xz8y/fnaVPtuS1NegFSaReqNJJm
	pLSHEXpipiTGOCyBTzGQ1A0ehcPkj20NXTKdaTux4VXLovbqwbzNjFu8Gp+uIitr
	0/zsL7DzKDP80di4D4SDA==
X-ME-Sender: <xms:l6S9Z-QBArXkeMPo5-JMAiMuIokIBLSFS982R6_8P6OXK4Oe7DuTrA>
    <xme:l6S9ZzzCs50Wm_nvJb3ejnHaH3Xzg4Xoah7HPTlFiEV7Iw2XDgpEJAdm19P5T-n2F
    8OxOamv2g1F-Q6big>
X-ME-Received: <xmr:l6S9Z73zu7TxvbmAuEIc0ehlO-z6eBa4FCjrEmAwa-7WKZEePmOFtx6YRgYzlgysMyjsBk4M12-MfFu3aorMqTVHCUGIwaQgh7m2aWFZYOytQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l6S9Z6ABIq5InXNjlQNRDieMyrjTNDpoGWirP8DurJIxzlCsr5gGIQ>
    <xmx:l6S9Z3g1tC1zZRI59MLiZ-O8qZ8Dr_93xz0YM3tU4nvQynAiuroNHQ>
    <xmx:l6S9Z2owSzmOSzBgDPH6Snqd851PPcBeT8e8jzq__Eh8ecbKyLEc8Q>
    <xmx:l6S9Z6hq2PKl8_mP3mxWppe_TnyprSFI_LaHPZReqbdisofbxyX8Bw>
    <xmx:l6S9Z3emXc8Jr4WYQDVYgtInqHqmU6yPjrr1fsNhp6qOCZcDBCyuhC8U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 06:08:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a86ed7c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 11:08:05 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:08:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v2 7/7] update-ref: add --allow-partial flag for stdin
 mode
Message-ID: <Z72klAEpQ0-cWCGa@pks.im>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com>

On Tue, Feb 25, 2025 at 10:29:10AM +0100, Karthik Nayak wrote:
> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 9e6935d38d..fc73f1d8aa 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -7,8 +7,10 @@ git-update-ref - Update the object name stored in a ref safely
>  
>  SYNOPSIS
>  --------
> -[verse]
> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
> +[synopsis]
> +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
> +	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
> +               [-m <reason>] [--no-deref] --stdin [-z] [--allow-partial]
>  
>  DESCRIPTION
>  -----------
> @@ -57,6 +59,17 @@ performs all modifications together.  Specify commands of the form:
>  With `--create-reflog`, update-ref will create a reflog for each ref
>  even if one would not ordinarily be created.
>  
> +With `--allow-partial`, update-ref continues executing the transaction even if
> +some updates fail due to invalid or incorrect user input, applying only the
> +successful updates. Errors resulting from user-provided input are treated as
> +non-system-related and do not cause the entire transaction to be aborted.
> +However, system-related errors—such as I/O failures or memory issues—will still
> +result in a full failure. Additionally, errors like F/D conflicts are batched
> +for performance optimization and will also cause a full failure. Any failed
> +updates will be reported in the following format:

Shouldn't it be possible to detect F/D conflicts though and not abort
the transaction? If we want to make use of partial transactions in the
context of git-fetch(1) and/or git-receive-pack(1) we would have to
handle them.

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 1d541e13ad..b03b40eacb 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -565,6 +566,54 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
>  	report_ok("abort");
>  }
>  
> +static void print_rejected_refs(const char *refname,
> +				const struct object_id *old_oid,
> +				const struct object_id *new_oid,
> +				const char *old_target,
> +				const char *new_target,
> +				enum transaction_error err,
> +				void *cb_data UNUSED)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	char space = ' ';
> +	const char *reason = "";
> +
> +	switch (err) {
> +	case TRANSACTION_NAME_CONFLICT:
> +		reason = _("refname conflict");
> +		break;
> +	case TRANSACTION_CREATE_EXISTS:
> +		reason = _("reference already exists");
> +		break;
> +	case TRANSACTION_NONEXISTENT_REF:
> +		reason = _("reference does not exist");
> +		break;
> +	case TRANSACTION_INCORRECT_OLD_VALUE:
> +		reason = _("incorrect old value provided");
> +		break;
> +	case TRANSACTION_INVALID_NEW_VALUE:
> +		reason = _("invalid new value provided");
> +		break;
> +	case TRANSACTION_EXPECTED_SYMREF:
> +		reason = _("expected symref but found regular ref");
> +		break;
> +	default:
> +		reason = _("unkown failure");
> +	}

As git-update-ref(1) is part of plumbing we don't want to translate
those messages.

Patrick
