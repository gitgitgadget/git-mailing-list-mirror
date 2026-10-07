Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4FB39F191
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394518; cv=none; b=lo7YlDMYssbMsGwCqb8EzdxxtGRN23DZMEc7lkqEwaNI4pRj/QgthbXp78BlYo5pka+v8zMWo9DurZ4T31AG/8ova32evo0baujGGQR0bG4zQUXsMpZSWyyocXv1W0Ejlln3yHFJcxZkpWFZD+HKeGvYpyH4cYaaBsA0u7mQ7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394518; c=relaxed/simple;
	bh=nAfUMBAcyenzTxQCEpDdGSN9u0oF3xBZfawS6CK7xkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cd70PRBlDHJJ4KtPfWII1dWv2uob5Lvk4s4uKU/Rttcramqbv0jrxP3MqcAdkQJ7m+wMlbTDWwtHNtKyuYUz87C+jjl7XUh2xs9n0Aq2jVuYDGgHgSpzTqc/kbMWQx4Y27GS6PaBYIklasdR28mdEFTBrgT4cwHZSQ72KYdQa2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ERRx48pj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNjNDiez; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ERRx48pj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNjNDiez"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 556E114000FB
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:35:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 13:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791394516;
	 x=1791480916; bh=i/uqSmCJOa9bKoBHs0WVg9sYq72CUTCRfFBD1f11z2k=; b=
	ERRx48pjoYJjeBqgYQ0c4gC+yXYR4MtK637sJUDhf8c1ZLjG9auvg8kWozrP10ns
	XospCBYT8Gsso+5RThuUzuhSPSg07ZzXyGY8R31ErpYygkhhZ7wbsBDcWJ81/Z5x
	Gg5Zhp/9qOrbnvNARqiZP0iNixYmQTcdOoumORtwSAZ3v5mxtUJj7pyylA/xyd8t
	gc70N5zaAOOSFaZ1JzEXnc+sPgl84SM/MGT9aTrChJh1duW8YQKKiVOb/wp4QjNI
	CHeF5nAxLMfYP1eXxx2fcAE2cZLlbFPozH7Lv8VPnKwRu3nyu7iG8x63HtPXAPRT
	Tq1sD3uMP7LrdfxAe7aMdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791394516; x=
	1791480916; bh=i/uqSmCJOa9bKoBHs0WVg9sYq72CUTCRfFBD1f11z2k=; b=V
	NjNDiezrh2kkBIB1G279XAg1LKuDw8V/zRmlUiPdjQ8NK4vGui4X14CHT1PlKCej
	WcOIwqZQ9jS0zxoe5hi7BM6et5Jfs1Dnv+NMAkksg5yycFGkcruPEvSq9cqNCe4t
	6ErT1OPTe/mTSUQEt9pWP0nb4Mrto7zLHNGcX0qt0oDeLjk8flKmwsvv7ED3yNwn
	pfGWqlElOAwB+wGJwzFz+Jg+BBagZXcPsKKYpWst94PiCBHKVOiOtIQX+rgSt8oi
	yNMeAYBKRN517+I3n9qIpdAnhbLZNr8wcIs41z8rLWeU3bV7BT4OZDs9ewwjrR5V
	QPEHVd0t0oQ9ikKM2l14g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791394516; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AG6q9icJigiIJefRR4vBVhWFPk5YDJ3r+1KflZ3lQWDyF5z
	YsBk6H0gG0hpgiL/sk4jpZwcSsU7fyKyN73wonqtlcEvg4fIIm52ROxXxu0XqviH
	nN11EVJFXopjtVqKhodaKCTsv9Ouf+Fq/dQLcgHkeUwcxgwNQo3PiCokm09RA7a8
	xYhDrV5QMgJiFl9o7mGFSQNuT+9BAmwUsBD1v0gAYfXL42JGlwLgU4mWc6ymvE9R
	HXE+l8fL6YLTtgoumf3ZYnqduR9HdMj+JpYZkF0HS8y0kZ6UsFUZeUNtaWZ6p7k6
	cBRrOTqXf0fo93ByKXC8N0nSSLsQxjxjUQBDfZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:pM1KCf2hxFFdQNU6mv9ohrtL10V4JAAHG4VUk+nslhg=:nAfUMBAcyenzTxQCEpDdGSN9u0oF3xBZfawS6CK7xkg=;
X-ME-Sender: <xms:1ILGauE_FVdgjEML7jP8q2AzRDrAPEflu5DJAYRQD1TJ2td9gOWd4Q>
    <xme:1ILGajCaTSQyOWKmW1zLQRJcq1mV6lLNADOj4UqsRaDl2XgPsyown-DJomA8BLZ5O
    YP9HRSWdgP8i2ZQzlvwM2ozQq72MKWQD7dlsNB7LfOmwFQg2sUkDPM>
X-ME-Received: <xmr:1ILGah8hlTrbS_SV6TuK0SuyxBFLra689l_u57o37f0HdwwXm42-WDNgvzCLnjd2USiANdKpSB9MX-RIx8msRoP79O8YfvRpUlpu>
X-ME-Proxy-Cause: dmFkZTG1qo/UNi2Km/oQ5o4u2uXHcNMFXeHnafIRk/KpM0O7vKQbtYtsgJ1C5EYt9FVAuL
    2uf3CJYynwKmHr4jzv4ow5H03PPsPkKHHbTXVEJ1ZwkCljSvsWahurw+MsMEGDpJdNYTOr
    jMu2Cjw6137A3dmMn8LE+Se1O3EpmBrntNm2F8jm7HHfv53nKioG7EmmSeCs5bBgUFMnZy
    JRWJwcpj3CmWhqzPaMv97l4SFGxhOHHIvoVzWAqZBGsjxNT8o0V92BSy4XarPeoBYjQ5RA
    q+b531kCApruLwDIPylRAtIbffIDClYLN4lHX+iSneHVISX3xOTU7pbqfCACif47m8IHqR
    PQSlwy9vSVsqf0ZswIfXWaH9S4BI7pjVi3tmV3glxC0SBa4xGO4me5MxvCMm0l9ku+BDNe
    syzIoBB0HxJEqxnxXUsRHIwzwcudKQjj0C4X6ujWkAlkyWAjON4n/Dj99T37xHG1WTZWPd
    OnRhzEcBMLz4Ajpi0FsgTmDtMxx1q/Z8zkaZWRXq4zsvDjUUhxoAUde15hLyUtpOaVBS07
    t1xwcWm6MTbVK91lXgkyFnyL9YjdvcUOpwnBv7ggRXWab/cd7U2M7f3rI+ieKCgUPWPK1I
    ijLTOv/Ev2gUgeR9CELQijrQGWawNg2cWOz5ZRWpIDC85nw8tkRPvU2PhFKw
X-ME-Proxy: <xmx:1ILGavBjwjtfgqelLc_9IIm3Metio30fmqCe2ItiY526N7T2wafmew>
    <xmx:1ILGamT8Q7-JdM5VyOpF6w_6KotW7IyRjo20KNiNx6jMLL1MHf5WvQ>
    <xmx:1ILGamttFHgz_gZUdlT9RkYtf1PFEV_wBfBSvVOYomo6BvEeDUeaIw>
    <xmx:1ILGai0vrTFnIr7QRtu8MXAgOmj-S0XyeTCc0K67oFGOuMCrWIfrIw>
    <xmx:1ILGaoqFW691rx-vXLxpT_lCGi7wCK13vHspeauxnKTHj0jIFLezLYRn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:35:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "Julia Evans" <gitgitgadget@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate
 the docs
In-Reply-To: <2ef42736-8879-4399-bbe9-3ba09522373d@app.fastmail.com> (Julia
	Evans's message of "Wed, 07 Oct 2026 09:57:15 -0400")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
	<ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
	<99bc9624-47a5-469d-bcae-8daa9b01581a@app.fastmail.com>
	<xmqqv77dbp1e.fsf@gitster.g>
	<2ef42736-8879-4399-bbe9-3ba09522373d@app.fastmail.com>
Date: Wed, 07 Oct 2026 10:35:14 -0700
Message-ID: <xmqqv77d8ld9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans" <julia@jvns.ca> writes:

> On Wed, Oct 7, 2026, at 9:47 AM, Junio C Hamano wrote:
>> "Julia Evans" <julia@jvns.ca> writes:
>>
>>>> Nitpick: Okay, but with the current commit message I don’t really
>>>> understand why the git.github.io link is gone. I have to guess that it
>>>> is an effective duplicate of git-scm or something since git-scm does
>>>> remain after this change.
>>>
>>> Yep! It has the same content as https://git-scm.com as far as I know,
>>
>> Correct.  That is direct rendition of what we ship.  git-scm.com has
>> some fruff around it (grouping and other meaningful usability
>> improvements besides coloring and fonts), but I do not know how
>> up-to-date the contents or the grouping is and how they are kept
>> synchronized to the originals at git.github.io/htmldocs/git.html.
>
> Yeah, the grouping at https://git-scm.com/docs is a bit out of date.
> I'm not sure how to fix it in a satisfactory way.

Another thing is I do not know how fresh the contents are.  I know
the one you are removing the reference to keeps up with the tip of
'main/master' so it may describe yet-to-be-released new features and
behaviours.  I am assuming that the one at git-scm.com is updated to
the latest released version, which may be more useful for general
audience.
