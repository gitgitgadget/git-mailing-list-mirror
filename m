Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAA40B38C
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268331; cv=none; b=hQaTEkmc8JBTmn6EW4YLUrD1ACl6h6+iivHAEUDRjqKmFhus89qIm1R36ThRnPP5HNzkngPXkKTPTWFPNpiBihq2bkWl5pCuIbUkurZq9rP6pihtlt7Ar8Sdm7wuTjjI1nwCsDCKiv5IDyV32p+zxKx+cgCL789sVVwV8+xeDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268331; c=relaxed/simple;
	bh=or4MUrYZHze61T/TANZi5QqCHfLS4AtQPuuryOqqtZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKgxnfhh201HXTXr6Yq1wiKvwUWlbo2F2IlPK8sh9wGjLBlX7dC7jGogOOZI8ijZxVFlYnmR2a/dZlzGbFIRijffUZdtHN2PYEi8byFV0pBpdHleE8a2oMthFWhkWE17tnd4p3huX63/ZYG4kfTch6n8kV2bB+AvlJ+mGGNJVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0uGAP88; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOC2KiqO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0uGAP88";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOC2KiqO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AB49DEC01A5;
	Thu, 24 Sep 2026 12:45:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 12:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790268329; x=1790354729; bh=2jmxeYRHG1
	R3vjNeeQGydghZqkXc2J/bhrZ32gKhoFo=; b=e0uGAP88cJLWA8BL7ziLQ+c7kN
	dC32286e3JabdtExi2wQ/Le1lArWywWakUQJwsIXzLYAJv+qBLMUIe1qm69XTNcC
	CdSgiROlZTVO7OJH7uSRRnMNgoFVjHzcgVbngGEsJnoj4cBaiROjBhN0qkxuHtgJ
	wFT7uJo+InNOTjuMohpg85lRTxg9EoMJe0ktCXYr+av1sfYfc4CRMfJVxVHLdwbR
	m54bRhHRIxFlE/fPIHFVDDxcwyhFPxgGp+EmVwefwjjorBSaphvmwEOhCmt3fv6l
	D1zU7sFXvcee/hJqPNBzWpgiL87y8HIwuIvHyNyjve0uAr9UKyoqqoM9F1sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790268329; x=1790354729; bh=2jmxeYRHG1R3vjNeeQGydghZqkXc2J/bhrZ
	32gKhoFo=; b=iOC2KiqOtOOmfHRN+9YvWbVuvXeJJgMxnrd6kdhWfVUvN9JGOtq
	fPt+B9Yz7f1ipPMjsk8J8lGu47S3W9D7BxHlDQebsoc0FT/hm7waWluatVWFVvWN
	tT0vZf6E4p+/i5d/uXyFJkceQKJS4wEltW+V3ped6EV3OK2Vc+NnUzgysS5qKGDc
	UoNX1bvu43nFqlgULzhW9uMCf3qjvnVJiTXZJNK7nh6/S5/lBQ60/czPmnZcxwOc
	VLSDGh1zdIkBcGkX5kpShEm4vaox2ZMLOcgklbQeEtSWw1w/EXtj2Gl0VDrD2SL5
	+eeTfvxAizjpczN7dzDnmaz4+S3nTA9ifqg==
X-ME-Sender: <xms:qVO1agE1JocLif43dlZG-Qd-3-gvf50sr8KU1S6Puhvffc5SkvDqag>
    <xme:qVO1amNM7SAJAbxH9EgXZ3ap2FxYj1W27VciFP76PtQk_MHMvAX6OC2mIY7sPd7QW
    iuDxp3KiDDXF5ddZsXj9VmGYwWAXRX-6y9FPHJY5Dcs7unX6h7tkg>
X-ME-Received: <xmr:qVO1ap4te4rRblSryRmQoIZnsvTrV83j-f54zeZD4cw5wf4CwCccFDgdTXPteuNwQfNkGOuGtQ13H5qhJdYuhYdRREyao5iLjHoP>
X-ME-Proxy-Cause: dmFkZTFdHI1b8+Iu98GZcePY65KfuoyilrGuLqlJrrgzFxcH2sj6QY4JaSftEfZ5j3nh4D
    9PeAhJOpRaFhd3hEEkBO7E0OeZad+7TGlnPW74NVBAgFlO0XpXeHeelTUbro8R71Lex3Sy
    lTZGK6OMh1Cd1wiCCIh9oIIhxS3Qh16xtGAtAolL2ShNIfUMavfFqSSIFBsg0NUZjrEHLR
    5OhWQJwryQTaJAW6e2AJPqsTxlI96dWDfos5rAt2nK6VPGOoWGRVtz5tNpVtCQpO62zQvF
    LEwzDhzjrddKkCYOFs5C2flAQaFQqMkF1MXBUdcKM8qI3O9KmdK4TF+5gvCwkfJN6VaIfF
    0mLweTro2+gn95lD9CH0bkTwkwstSnXoyfBHXHf/gRgqmsEpGIdGrpsNJYZ2YWeJayfi5C
    jTCq4tMQ+nVeV8WJByhyDWpfr7lhJePDlZd/GJTG7T9GjtFX+12YWy9YfoG5j7MPZwNoQX
    B6N2N0TqUZVRU+2qUqk9AYHEMxScyMqnzhDAeNMXaIP6P009WUh9jliYTU50BAqedTEtit
    Xcex5/DXB+qfm7ne2vBrSmCb6v9DL98sebrgC0MDH3aA+y0ejD5mLPl13NfL4u/GvXUym8
    C5pPPvqMnMLai62Xqlzve6VAm/wb7c4TJXEEtkoAdXZxzetKlZmFmHwZJrwA
X-ME-Proxy: <xmx:qVO1ahiQljR3mxHsrBetXyIcybM5xyUmfcdh5lrXWKo4rvlawTnQhg>
    <xmx:qVO1amegUmGDtzIGNkgOuYM_tIWV1WJtHvhor_QMFvxYVfMZA-WG1g>
    <xmx:qVO1ahzSRaYfMOWL3ptL0m0CSx58pz2tFy4uvRACcJmvLcfHpqQ24Q>
    <xmx:qVO1at2EG_gyaG6hmheAozqX8TPVxzt15zUJeQlQhIkvsuNXVJ71AQ>
    <xmx:qVO1ahE2xqNX57He9HfmTAzKeMOc5YI_83oBA8RxFyt-XshUbJiOo4q3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:45:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Phil Hord
 <phil.hord@gmail.com>,  Elijah Newren <newren@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch
 deletion
In-Reply-To: <arUEhkuC448hUTCw@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Sep 2026 13:07:50 +0200")
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
	<cover.1790196627.git.maciej.ciemborowicz@gmail.com>
	<9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
	<arUEhkuC448hUTCw@pks.im>
Date: Thu, 24 Sep 2026 09:45:27 -0700
Message-ID: <xmqq4ife4mzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Sep 23, 2026 at 11:04:40PM +0200, Maciej Ciemborowicz wrote:
>> refs_delete_refs() performs unconditional deletions, so callers cannot
>> preserve old values that they have already resolved. Consequently,
>> reference-transaction hooks see a null old OID.

I wasn't paying attention when I gave my reviews, but the above
puzzles me.

"callers cannot preserve", meaning "after deletion the values cannot
be read anymore"?  Of course, but then callers can read them
beforehand and use the stored value when calling hooks later.

Patrick, do you understand these three lines above?  I don't, and I
am asking you because below what you say mostly seems to make sense.

>> refs_delete_refs() has always promised best-effort deletion. Always use
>> REF_TRANSACTION_ALLOW_FAILURE and report rejected updates so one failure
>> does not prevent independent refs in the batch from being deleted. Let
>> callers request the exact set of failed refs when they need to report
>> partial results. This also completes the conversion that was missed when
>> batched transaction failure support was introduced.
>
> Taking a step back though... the only reason that this function really
> exists is to provide a convenience wrapper that deletes references while
> we don't care for the old state. If we want to not do that anymore and
> instead want to expect a specific old OID, is this function still the
> right function to use?
>
> In other words, shouldn't the callers instead be updated to drive their
> own transaction if they want more complex behaviour?

That is a valid question to ask.

I think the bulk deletion of refs is done via this function, so you
certainly can update those callers of it that wants to protect
references that are being updated from getting deleted with their
own transaction and remember what refs are and are not removed, but
I am not so convinced as you seem to be that adding an optional
transaction support to the existing function they all call to do so,
as the amount of the necessary call would be more or less the same.

>>  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>> -		     struct string_list *refnames, unsigned int flags)
>> +		     struct string_list *refnames,
>> +		     const struct oid_array *old_oids,
>> +		     struct string_list *failed_refs,
>> +		     unsigned int flags)
>
> And here we also have to yield failed refs now because we don't have a
> better mechanism. Same as before though, if we used a ref transaction
> we'd already have that mechanism.
>
> So overall I'm not quite on board with this change, as I think it's going
> down the wrong route. If you want more complex behaviour when deleting
> refs you should use a ref transaction, as it would already handle all of
> what you're trying to do here.

I am neutral and would need to see what the code would look like to
decide which one is more reasonable.

Thanks.
