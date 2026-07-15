Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57F43F0AE
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141640; cv=none; b=twZGYoqbVLXtFHnCv9NEqcoDrAWrHjBToaPL1UloBpx0B51s9Q5OpT8Dr9mG9mWattqToZJBtT7uBLRsqUBG6zp+t92BMZjJJB/Vbglub/x3kV+iia80bkXeqrQtZGMbULZHtTez8+M7yz6T+coHCcHZjC0EXESYsfOEr61x/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141640; c=relaxed/simple;
	bh=d8dKv1FbKTaAYHvSx1yCSHzE+2xTvgLp/cXVIlygjP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQA59j2wopD8ZPW44oJwybbRsax+xwr3xmAi9QP2cd3qbpvd9qwBLhVRpV+5kTJ6dNBTxegGu6t3pJUXhjwgxWBSR7jgntZU4G+v8HibqiZ0J5aG9yUbkdeahGA48mrii+oOm0lMn5Y1d7PvnuHclqx+bLz8IQ5Ee3m05bAy6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IFcZh0KL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpFwPjn3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IFcZh0KL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpFwPjn3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 574907A0097;
	Wed, 15 Jul 2026 14:53:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 14:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784141635; x=1784228035; bh=Gyao1W52SC
	W3kDqRDxPf3jJLeZAVsHieIjz2huji5vc=; b=IFcZh0KLxJtWQEymBnHmKGGO0x
	1nLJ89oV7smz3K428niXaUmu7nKQcDEO2aKbQ0BFSIrgG6gkhFZUa7EGCsvSoksM
	+ZlQA/lVL2UuoGJeSGGWTRm8fVFchcXxBhSBCRVp2T3Mw1LTCJbfPtsw7pwDyT3Y
	qeO6vtzlGZkFFCVdEwHScmGHMYaovFuwG2GNDX0cgWCCxrZylbMO/RH2HulADlax
	cgMwPjHILjOII48ZpjFlq7PbYlrEyWQlt6E2anIDmfvdt6eY5S6fP9XcMuacgWLP
	ZowM5uQfCBkERwJ5Xy6amJB1vXpE+j4llFb/PnJsdfABDupvUR1rWeihfbbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784141635; x=1784228035; bh=Gyao1W52SCW3kDqRDxPf3jJLeZAVsHieIjz
	2huji5vc=; b=bpFwPjn3EW+uvwSGKbpfRBl7Jm3lrPnudckD1jCjmVfh26Ndwwy
	zA7l/eBXpbJq9j4TljFXuAfj2REL2D1CysGBpsXhhX7rsXed6g9UBJD+lCO62q5L
	UX5q/4jF29SUoEm/g5r57m0FhXOUwTbW4gbPqlxO8d6+ndVglfdWL6KWqCjhfbUm
	dj4d3xeD0IVpAkXlyBeORYD9+UKJGD8wdSJkVhNPpIP5HoZrxLLYOstECYeCmWzj
	fwPDT54ZgvWgFonOAiq/xSogcOG9KRn/c9CIiF+Dbcot/mFIjekarOf1aWHqBwk2
	1+/yJZgrVqI/vD/CEmK96GcVNAF9DRbLR8Q==
X-ME-Sender: <xms:QtdXauJIDSto1wSuJJDRONOx3ICZ5Ukkk_jCQbfpoxbjBi36O6yqBA>
    <xme:QtdXam2CKv-VzPtpEEKjRv0gx0fIMXbfHICS1wqOVSMTmvWqN6BTjjzqD3ykM_yFh
    8FeYQu__ijIZW9eVj3JFfAFoZvhTCWj-6Y7yEzmSlln2q9ox19J1g>
X-ME-Received: <xmr:QtdXas5KeOAECKsuioR_bP2BWvUfDeeZwrMi3ctZ--Kroyt_Jt87bNy-bvNfkhLTOViMizaap9-jMlcnIBDXbT2m1CRim-TB6j5gLQ8>
X-ME-Proxy-Cause: dmFkZTE87TVnWrdP8nnCv8zOPbj5lrD0nvHpK9yZcxznjDkTZw7LWRAHkOXhFmwKL7Tt84
    D3iEsoJDsd6xRDKAope8WYRc8xzPrC7P4fnZw+4oNrScz9frtOSGqBrf+oaPaX3bK65VsY
    X3rHvpSGdOQAAVO3XVsFy9+f4kGfTC9sVbJmGCJgI6xWNssQdS5gBNe+jumTpu71jKxgTZ
    Drvm/C3VydHvtGcxxauz9Wl+fV2/VAW4aaHmnI8OX/yapAObf9afh8mPj1JK3v1h4wHhOa
    p/wCBOYYj5DrFNyiYfwTU5TE6FlcnaDnjwhPv+P/R39Xw2pR0CGVTHfUuNnW1hM7Pr9Eoi
    D4rVqunic+jCJ5hhjf84isK+IHKCadcMmU3wY4tHHP1DCg9onFILdGS/TGiNZowAgkWVG9
    R9aKYBh7/EGd/8JBbDqAKGnTYDV0tKTQfWlsu9taUzYUEpto4oXavKYiC5S2UOgTU0fBBN
    AvRLAPQJWQHic4BExVhHhgeKRmvSJ0ruAeGtisp2yWE5vJrValT81C4AcuTlOB+dhXeTki
    YMSq8mR0xzaiIDjhCey/HXLGk5YjdOA/y3+ciWzo9F406f8SG1k0z670V2OFvPF90Ql/6b
    qY9ETqm1+7DreSnsnYG5vdTFru7exTg0zhxtccYGIHcVNEcrHk4E8Q6k0jKQ
X-ME-Proxy: <xmx:QtdXan9NopIrY1bsYF7kXgYQlO3mG13P6Mq7YdO81Tqln9f4a7pyng>
    <xmx:QtdXarV0qUdk2z76f4TLKDTuIbAuw_zdgzaOmf_TqMMDRBPobSBl2Q>
    <xmx:QtdXaipKRt2DWM7exocFQ2QVNwuk8YfVPWo0JnqcfD7tynVDjBJ0mQ>
    <xmx:QtdXatkN1LuE6yUoXC4orM8GUUNx_I1T0hlqn4D8kNq5PMnEBBcjBg>
    <xmx:Q9dXalgKWeC8R3_SEtJuyO0WG-YLWG1voaQWOkr_SJnXju0DSRb4iw5z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 14:53:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,  Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [PATCH v2 03/10] sequencer: be more careful with external merge
In-Reply-To: <6cdccc2b-c0b4-497f-8408-a18bd0981505@gmail.com> (Phillip Wood's
	message of "Wed, 15 Jul 2026 10:42:55 +0100")
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
	<cover.1783948637.git.phillip.wood@dunelm.org.uk>
	<3d79362332c1208eed1fb7f8b0d431ee92fe45c5.1783948637.git.phillip.wood@dunelm.org.uk>
	<alTvtOc39bLR4ocx@ugly.lan>
	<58c488c1-139a-4b56-9f80-2492b081f659@gmail.com>
	<6cdccc2b-c0b4-497f-8408-a18bd0981505@gmail.com>
Date: Wed, 15 Jul 2026 11:53:53 -0700
Message-ID: <xmqqo6g8m6da.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 15/07/2026 10:35, Phillip Wood wrote:
>> Hi Oswald
>> 
>> On 13/07/2026 15:01, Oswald Buddenhagen wrote:
>>> On Mon, Jul 13, 2026 at 02:17:20PM +0100, Phillip Wood wrote:
>>>> If an external merge strategy cannot merge (for example because it
>>>> would overwrite an untracked file) it exits with a non-zero exit
>>>> code other than 1. This should be treated differently to a merge
>>>>
>>> s/to/from/, i think?
>> 
>> Both are valid - the internet tells be "different to" is more common it 
>
> sigh s/be/me/
>
> Phillip

sigh s/it/in/ ;-)

>
>> British English, whereas "different from" is more common in American 
>> English. I guess for an international audience "from" would be the 
>> better choice.
