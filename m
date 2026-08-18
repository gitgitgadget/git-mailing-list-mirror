Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377647D451
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071259; cv=none; b=d0pMPrvrWMo6/6MG3IsTUJcaNGl8MIlVgBUVH+IcF+vsp0aEY0JczoiaxBqGQ4epdPjJGrF4Zf1jUf1ML2ZcTdmjUK9zUsRohb0MwWNWay8dMcDlGvN47HIpFx+y8ghrpON7+cBWLrW9H6ixdvtJsqWQT/rBc3Cht6rN09qGxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071259; c=relaxed/simple;
	bh=GCb8NbxncYNu+Kqx5VtBiud+X8DFeq8JVUkiur7x9aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZATI31xWe0Bd3osMVmsqehE6AbyFKI2LZBr6U3llrTirnZ4WEpxSe496ZwUuU4xwUcoLmZMQVSalERRkFIncwFzTMj4MqRRLuwOD1JEWqx7h9PmN6zr9Y2dB5Dcwdi1OH6tyVMse8NchMszZO6aaC2YkE2bK1XdkNmHmUVI0rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UQBNkmYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KslUnIVf; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UQBNkmYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KslUnIVf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E54197A002E;
	Tue, 18 Aug 2026 12:40:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 18 Aug 2026 12:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787071256; x=1787157656; bh=h9p4v3KN2n
	Zfymxoy8H6/sYpJGaRGr+so4lINaqLuyM=; b=UQBNkmYMGlZ35GdrFov4pWw3B9
	O9HqUFFdwp3liZ5M9OpgrlSQ9T34Jx0QJaYD78b9qoPKcmVaVgz49rMADIEqsGPw
	Jv+wKx8llyhqjkvr2G5MYNL8h/1rO1jaZR0H69tK65AZzRLWAAu5jQYuNwJe8ViR
	mHHy/c0zIN9z6kfmRfBCbud/9Iozz75cyqyWxHgbdx7tpQRytcNeUFf6f250ISl4
	hIFpG/oiIWcN8uZ6L20aVvOX9ANHH7UbAgTAXy/+As8sEVN3mg14Kcqq6mHTlKOM
	0KN0X1pHX4nkQM2Oj/QBxXUjCznv6qwMFmVmiDyMPEZrL6OTFfbz4QEsOCjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787071256; x=1787157656; bh=h9p4v3KN2nZfymxoy8H6/sYpJGaRGr+so4l
	INaqLuyM=; b=KslUnIVfT7qSexcaiMOmZ9rQauQNKWRZvzf2ngYN1169O9I36t5
	9pggjjnOvUt27KxGeOfMXn5KVGSb3TSe/Sv5+ixGcSjFYU/l/BKK7TI7zpeJJWrT
	IpfURtPE0xa9hNKpx01cDRTxrsahgqMGl9wLmEi/UbB6N99jkU2cfsYSxcGsqRpu
	4BOExQBodoGIZQf98AJFyGBFbyuWN5srEJ9CaF6q9RHdNqvpfbyVEtmXETNL1tr7
	uPV6P/ZUqK4fs7R+3I8KCYG4K5e8EH/RbvGprj2V3XCV/K3QzrDVnSy46AAucD75
	2cFmriux16kX3zxNAx50Xu79Nk9IE1UZ3gw==
X-ME-Sender: <xms:GIuEasKOERB36pnR8amIRv6wMUZ8gWjjiFl6ZfI46mGKdjeFLkJ_hg>
    <xme:GIuEajLVwtd-qyxLsno-pH1znOb6EoaRvV5gPfKW0bcJrXkNjhN94mb8v9yLyoKiy
    idjTyqIGVIG15WbFAzIZIoX8sNbNyW2MtrjoqM5c_ExYoepIUCCKJY>
X-ME-Received: <xmr:GIuEahvAgT1-FK3zr8cqRfYSnAfPoYji02EflAwwlLV76OHQP8a-Q5RrUof4f8EJEXTrPUrKoXOWk_bj3kfviqNrP4ZdSy8mCA>
X-ME-Proxy-Cause: dmFkZTGhpQcejeo7rVR8er5CMbxC10HyWatSNVsy79eSHwp8Mn71B9AZQtMHDXXvpFAks1
    uS88DmKoiB73XmGpsfAPk3VyEWdLdj5wwHfmEOLp6tAzyQiRm0CoHLIcztcQFfExPcOR0z
    CDdU6k8MTE/QS59fRHyiD/w6dyHJw3jRDEpvX7wtQk58hEWnz2mzVokLbqgu/pAvpfrm7q
    cm4CloQOgtEv7/hjqzjUzhjLMsYshLv90SVk+XSIa6kL23/JRiSiJt/epWElN1Id72dqBs
    xI/WOdGtFoANLscs3bmZAI8NEJE+dB/eFq3QvrL+XQi5/aAC9NvLSnxPgaPMJAitKJHTqz
    12roiNln4hGiuzzCwLuXppt64QgdM+Kk+SzfbzHgBiac8Ea1j3Gas4LlXEsZ5pWFQweNg/
    XQ2/9MNFq5WxBjAbZh2ALMY2k+qVVDnPDSpK+ktDhgDOOY0pldblTOhwPjos+Q9xQoKmky
    O7GNd+Y+w9EXq7989DNw89y9EsGDnvl6aelbg/RA7PUdRxdkCruLGf4JIYfIja25nGUOl4
    3L8k5TCVXJnEZDB/YTPrhdcVmspitwrDoRptN/9gdjFZ5icFyckcNMS1a/2TRCSuNOwUEY
    dUi3FT5rJmQnZ4OevHc3mUQfQDJG6uzW+jJfNRdPGYSaALIFoBckDcHeosxQ
X-ME-Proxy: <xmx:GIuEaoQb2x5O1IGHBH4ROAhdye0gKiUyQ7bdBIXeK8lsm1XEQ_dPKw>
    <xmx:GIuEavOE9IAhDkVDQOAfL987AfdtJFypTyh3p_PJtA_ARawZr5Chjw>
    <xmx:GIuEalY7KTAYbMnO4y5PwQrQJ9r8DJ1GW6opM_BALRktafIz-JoSxA>
    <xmx:GIuEahybEFwnh7G9VwUQCzaOVTcqIdqo5d-zgZ9r0qa2_gfK7aCeOw>
    <xmx:GIuEahP20LxIoT4qMyY4k9XJ8oYYOtnKEgoSWWqUoEkLDboK-jmmebyJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 12:40:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: graysongordon-gl <graysongordon1@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <aoQOxISPfEwh-ik2@pks.im> (Patrick Steinhardt's message of "Tue,
	18 Aug 2026 09:50:28 +0200")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260817185242.22736-1-ggordon@gitlab.com> <aoQOxISPfEwh-ik2@pks.im>
Date: Tue, 18 Aug 2026 09:40:55 -0700
Message-ID: <xmqqecfv1iw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This is only part of the story though: GnuTLS 3.8 introduced
> GNUTLS_NO_STATUS_REQUEST, and curl 8.10 started to set that option in
> case of `!verifystatus`. So with new-enough versions of both libraries,
> Git behaves the same no matter whether we use OpenSSL or GnuTLS as
> backend. See also aeb1a281ca (gtls: fix OCSP stapling management,
> 2024-08-20) in curl.

Thanks for additional details.

>> Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
>> Because http_options() is the collect_fn of a urlmatch config, the
>> per-URL form works with no further changes:
>> 
>>     git config http.https://example.com/.sslVerifyStatus true
>> 
>> It defaults to false, and has to. The option is fail-closed: libcurl fails
>> verification when the server staples nothing at all, so turning this on
>> globally would break every remote that does not staple.
>> 
>> Leaving the default to libcurl is not an option either. The same
>> complaint was raised there in https://github.com/curl/curl/issues/15483
>> and closed as intentional ("Marked as enhancement since this was done on
>> purpose"), with the observation that stapling is expected to see less use
>> as Let's Encrypt drops OCSP support. If the check is to be reachable at
>> all, the lever has to come from the application.
>
> But... don't we still leave the default to libcurl? If
> "http.sslVerifyStatus" is not set then we don't touch
> `CURLOPT_SSL_VERIFYSTATUS`, either.
>
> I might be misreading this though, as the whole commit message is quite
> hard to digest. I'd assume that this is because it's generated by AI,
> and it added a lot of the usual weird phrases to the message. It might
> be a good idea to adapt the message to have a bit more of a human touch
> to it.

I too had trouble figuring out what the proposed log message really
wanted to say, but I wrote it off, blaming the difficulty on a
language barrier.  But as you said, perhaps it is because it was
written by something that does not truly understand what it is
talking about.  It may not have to explain things to readers as if
they were 5 years old, but it is definitely necessary to explain
well to readers as if they were humans with average intelligence
;-).

