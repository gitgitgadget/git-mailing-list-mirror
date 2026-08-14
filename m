Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C341C84DC
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731136; cv=none; b=OtNcib5Bzyjt89i0l5qUcsuFjgto+Qtet2qwoinMQkYpHm9L7+0DBDfJsJKRJHB8DK2N6630SwNsdfIbSvhv3NisjxchzeI56qsfqIC+sbYRUpnkMGkxKsYKFInuRyRFXWcYjQrl6dNy0IDZC8Bmby8VWxCNTJiMrMrUgyqE2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731136; c=relaxed/simple;
	bh=v6MKuf8diIeK3HETlfr+XtQbAaXTUdqunUpenE6qmDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KexTchJESDDcVZDSAeXSS1wX/Z4FgpRsnlQOl8TpMnZbK8zcPH06LsJui4YZpIlc6WOjbgq1txSOpSB814/ISSzzdG+NYdC3GShSvNsf3bmqeLTsnMOKy645iMG9RELOhJZaqkyQZBl8VBtpFZZs+VNE4C6Yi1JbkioBgDPZ9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LZ6joz+3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbciP5pT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LZ6joz+3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbciP5pT"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50185140008C;
	Fri, 14 Aug 2026 14:12:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 14 Aug 2026 14:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786731133; x=1786817533; bh=ELT2RWZW/w
	x6Wc9UYIinMrTZh0FbAKpQNhJ2cwsPquQ=; b=LZ6joz+3PBVtXXPKEPDytXPLqT
	PICqFHWwX1Ms039vHkZV7YKliayRlQpFtR2zMMimcR+m3TKbR3C7XBqcvpS8taSJ
	yGNCwjhMbcy7r8Enta99KshPgcPFJlLruheWhte7XuwA4LImHDpSg41w5Yo9u94m
	vAdVD096RGiixSnuT91ZdohABgOfpaLaGgepdzmlIofJwnMUIoqvUNZmLhcy5VDT
	c0fjt/EixeCv6MCggrrvzAKGqkM0pdveL3+KS9pPnyTDvS1GtKFAwxV0xzln+DBD
	CPbWnhhi3vhrP77nCUkVobjMJCXF9rjX1Sa0iQSawSWKxLZ9VH2nZSsMVSNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786731133; x=1786817533; bh=ELT2RWZW/wx6Wc9UYIinMrTZh0FbAKpQNhJ
	2cwsPquQ=; b=YbciP5pTOEpanBEVdaFPzkbVcwON1YiMXMuWnbTmFIQ757YjXhg
	T6EZQzvDdInrLP1u2PRiAuIBPqFgGBqNrf5vT/7uiCp+4I8lMnLqCnUG6M/VAnf4
	j12EGc2cC6gE7hkFz8CBZGVbNWYE7UcKKB59FirdbLIRP/k9cWoDQkdPpT5vYGR9
	WO1Bp0cNmgVUtZYDm4JLLtdYpjkayOzKSBQ64BWQ0yPHrNRSMUsDcZvUkhHyXLJ/
	r3Zz6ItJuDqn1U+RsD3x2O3gFv2y+XoqCoaQtS/LKr2yE1fBBz8BxJPj36Bolxx9
	3SH+bRSsBHoiQBwdmJxbEb+HnC2CgBk3Xmw==
X-ME-Sender: <xms:fVp_an_qPA15IzQQSmZXpK6iB2Kuvx6Wq_CHh8n_90SI3EkiRomyPQ>
    <xme:fVp_aiztGjtTYFQjKjRkVRfJrJm_L36ZSPB1HXezicGknDOVX5yn5I9wM6Jfylmvd
    J4w-Yk7jdQ-1wKN1_W8-FpcuLkN2aFFNhM5toG29GbZ0KvnDbU0GZg>
X-ME-Received: <xmr:fVp_arNBqbtno2bbOA033HxivXKUTVHNlCHCMNmVtIAbnxmjQWHXLWVaNkE2cDgrPud3C7erToty0fVV3ezbV6CXtoIuC0t1ZA>
X-ME-Proxy-Cause: dmFkZTFglU84qBYEpr2Ty8cmi0HQpq9kkrcIZH09IKwnQJ9wwPPpLnSLZgev+giteAub1u
    fdjWaQd2NuEuCgvrCCzVmalxOYferYAO4f9yqpkhl52K8oXqfur9Bbm4B0Tz1ULgWaqQom
    ew5p/pH/eZ6bDRc+M77JYrHQIGtU5cBSUG/Jypxde7CJ7MG3i+IbijCBGSY47TSO5YLtwk
    RvRSk4umNFLZMhRllXDSq3li1UZnyGjtHgChIfY5d8LtU+AIeGyDaoWR9xiTGac9HN4DRf
    GT5NNSsCXpNcPkdJIo+R9zx/kwguvF3pU0eSWnJT+z3LI2y9V35/oFZ9nJqYlsVQrNp0VZ
    LGj1CTklQsJsNuCuw0/GEDo7QJszdP1aVyPUg/qu8JJwW4uD7md2ndMDY4Yz1XS/7KNbwl
    PwOOHylQIiHgNcX+4lGvuy40Xdubmqu6mAXUNiMwrXthxyuJf/aKd6hdCMagGKQsSRygxB
    XoHpsfNMOVqyOyR4dCVS3cpjwm/m3vZPDTpF815KcKFkd+HhQ9C4jHjadOCoe6f1H68rLR
    aGrx2xjCHhCVEagchkpTgEiuYDgK+d/XxWVHcbkPFUWy/dvK2T9+aMZlO0I8o/I78Lj/aO
    3OSll97IOb0OQ0p64ZuubPVJ+uVTzd9OQdGFeu2tI2dgiqPkw4zv0L1zCfNg
X-ME-Proxy: <xmx:fVp_av_oBDj31q2mVEchsnmRbQaOuQNEmObJh-w7AaTLWNl5wdhwvg>
    <xmx:fVp_ag7dvlij3lJcWAJfqwDRBL3ExuEQICTce8Z9YERMnoFv7vherw>
    <xmx:fVp_at6wfhGNnkdpKD8bz9pElYbaHkVjNvsywiD8pmj3FSUmXhorVg>
    <xmx:fVp_ahoTRFnrgPcyrnvY5_Zw44vVjs-x22MUpSfBW30lizQQrJNvfA>
    <xmx:fVp_alOVPkYGfZy-48Oh84nCT0lWxytz8E9259caO577Del9uqAC9rB6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 14:12:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 3/5] setup: add 'allow_dot' arg to
 path_allowlist_apply()
In-Reply-To: <20260813154748.2378747-4-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Aug 2026 17:47:46 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-4-christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 11:12:11 -0700
Message-ID: <xmqqy0e8mv0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit created path_allowlist_apply() with the goal of later
> reusing that function. But when it will be reused in a following commit
> this function will need to reject non-absolute paths including those
> with a single dot that are currently accepted.
>
> To prepare for reusing path_allowlist_apply(), let's add a
> `bool allow_dot` argument to it, and let's export this function.
>
> While at it let's document it properly in "setup.h".

If this is just "I want to add an extra caller that has specific
need and do not care about others in the future", this may be OK but
as a public function, this is a bit disappointing API design.  I
expected, as a generally useful function, you would instead add a
callback function to allow replacing the use of is_absoute_path()
plus the warning there, i.e.

void path_allowlist_apply(const char *key, const char *value,
			  const char *target_path, bool *matches,
			  bool (*allow_path)(const char *path))
{
	...

	if (!allow_path(allowed))
		goto end;

Also to avoid limiting this to configuration callback, I might
recommend to have it be more like this:

void path_allowlist_apply(const char *allowed, const char *target_path,
			  bool *matches,
			  bool (*allow_path)(const char *path, void *cbdata),
			  void *allow_path_cbdata)

where the original safe-directory thing may call
git_config_pathname() to compute allowed before calling this helper,
and pass the address of something like:

	struct { const char *key, *value } cbdata = {
		.key = key, .value = value;
	};

as the cbdata, and pass something like this

	static bool allow_safe_dir(const char *path, void *cbdata_)
	{
		struct { const char *key, *value } *cbdata = _cbdata;
		if (is_absoute_path(path) || !strcmp(path, ".")
			return true; /* ok */

		warning(_("%s '%s' not absolute"), cbdata->key, path);
		return false;
	}

as the allow_path callback function.  IOW warning, or insisting on
it being absolute, etc., does not have to be carved in stone.

Thanks.
