Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10392C029D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204943; cv=none; b=r+SP80tNt7WCrJlveSeJX+yPBIe6LsrDihRXtiDWULkG0KWR7XIlOAfLl6W6nWgS60iyuGe+wgOmOx+LFJ/+wa4ilGI5BIgVSOox74eDitkRbwsmeGt5ty4HszyfnNphT2tEl2RnyZ13d4MReMGOqB4NtpYR9RuA99cHawjc+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204943; c=relaxed/simple;
	bh=/9SUwtidVqrIoEtXvthI0J5wH3eH0HbXXfe5REc3qVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aSGz85foRkK9oJcK4H5YrWkMKenmpH/f1bNR82SB9uA9pvjXRrPWUoLSwHbRGfcpSkko/srp34TJPyM699WedAc4c4UBPyyX+rwpvUzXjgqC9ThU0QfQj25nSf0Hst6mP5k6DwRPZtfuNwCbo4nXv84eXsfqcyeyqR1BAJDd9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a1l6jRHX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Av8rQLhP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a1l6jRHX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Av8rQLhP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAAF51400036;
	Tue, 14 Apr 2026 18:15:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 18:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776204940; x=1776291340; bh=5pdI14dj3g
	cuNBHc++XjiaQAYCr+6qgLMsTzflPlYEU=; b=a1l6jRHXP+scKYVGH5PkJAVQfK
	bXoXzNUgBwnHuDfcQAQx0CthACnkY0vFOBzD1mGmbYx8aCr2UthvONwVFiRnzhyZ
	Oc0qCyNfG6nNhj03Ej3G6ncgo/nw6C8Fb/jZGcoUPMXPgMm3s+irSlLETUu8+k2u
	iCetCzn9eGfffLWO+Ax7dNM9+rbRntTp9riJ+2Ox4Jgm1jE18PDpl8TsVyYYAWB0
	odBkNiDm/+na4PHiUApn0xENaj7A9U4Kh6KIQSBSkXZ2xP5F/qukuDmVSC2uZvof
	gRVneNUvNjSkUoYPwKlVXsN8ongofX7WVyXf6/YwHzr1BwocLKbBED1WSeOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776204940; x=1776291340; bh=5pdI14dj3gcuNBHc++XjiaQAYCr+6qgLMsT
	zflPlYEU=; b=Av8rQLhPCtlFIknPJUHtTiHiRAJ8EmitKaHihCFCdi9HmSmvy2g
	cxfnQ6Czd1DmHuhV09ZYcc40uazn0KEaddEDAAyRFEnq72P2/4MzOrM9aoHxanRb
	lPUdvaycsQQRnd1P1eVw0LkPyhNcdrmfYV/sFztfSVOfz3syEy/n5qr2ETtKQR5s
	bCME9QfI462k3Px1mykL/ipPRzJHm1CZrdYhPvkMWPJYBE4XBqIR61Pl2qZ+CY0i
	GUIvk4N3xx6ZOMF3WK3DIBTB5l4QrA1/F1nhuDK0WbJDmQQzE0W/hoCXbvdTPzb0
	h4MZ+jBqHBsU0cBidN0wI6DpnvHL+tjq/IQ==
X-ME-Sender: <xms:jLzeaepABaEhDkuZMPm7dB500S6eK6Rj0t188XT_vSEi9pNd-qlXXA>
    <xme:jLzeaRmV0xgDKBOhMsau2JhYfYimLb-g9ygK9srTis28ysxi0pGbDo6_AoJCPAWtQ
    soJLT2BWsH9o12qOBlQi-mtNXhSMR7M-yQcJPQDGy2utVscvXUWRg>
X-ME-Received: <xmr:jLzeaXchl0xoIhuxluFDZVuXOiZnDgdepmZ6OW7GK4x8pSnP76v_3Ru1TCYpl3pVAVJieS75ftpfWTjmumVpecZhzpaOOLdI0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihtghhihhn
    rdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:jLzeadrfv4FZ3fOJJjgOnicf67OKXQ9OH7QziqCCZVY-htosrqPGAw>
    <xmx:jLzeaRMoz9PSEiKy8OMSgTfgmwjiHW_ri1KQJ0EBoRZYYIZS-LzOHw>
    <xmx:jLzeaQgJhTDwN2utBdzAN6eGVwoYXKDhOvC7P-XrXJTvnnvufKJ78A>
    <xmx:jLzeaUtByOV-M9UKIF6UhClI_AA45p-ojtzymch67OAnpQZnFlKSzA>
    <xmx:jLzeaftydkbu-MXrR2lQiBHFscyKQ9GvWOIzsEAkNTi4pKWfnrqhSl0s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 18:15:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Yee Cheng Chin
 <ychin.git@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Jeff
 King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 4/6] xdiff/xdl_cleanup_records: make limits more clear
In-Reply-To: <CAH=ZcbCX8FEs4ueU7+groQp8XhiaP0QPHMeGqT+Ap1FjeW9foQ@mail.gmail.com>
	(Ezekiel Newren's message of "Tue, 14 Apr 2026 15:58:03 -0600")
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
	<32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com>
	<CAH=ZcbCX8FEs4ueU7+groQp8XhiaP0QPHMeGqT+Ap1FjeW9foQ@mail.gmail.com>
Date: Tue, 14 Apr 2026 15:15:38 -0700
Message-ID: <xmqqik9t89yt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> > +             mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
>> > +             mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
>>
>> As Junio has pointed out we now evaluate xdl_bogosqrt() twice which is
>> unfortunate. It would have been nice to mention that in the commit
>> message and explain why it does not matter.
>
> It doesn't matter because xdl_bogosqrt() was being called twice before
> and is being called twice now. There is no change in that regard.
> That's why I split mlim into 2 variables to make it more clear.
>
> It looks like you and Junio have both missed that xdl_bogo_sqrt() is
> being called on different values.

I think Phillip's point is that XDL_MIN(a, b) would evaluate (a)
twice.

	#define XDL_MIN(a, b) ((a) < (b) ? (a): (b))

So the code you have above

	mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);

actually is

	mlim1 = ((xdl_bogosqrt(xdf1->nrec) < XDL_MAX_EQLIMIT) 
		? xdl_bogosqrt(xdf1->nrec)
		: XDL_MAX_EQLIMIT);

If you are lucky and xdf1->nrec is so large, there is only one call
to xdl_bogosqrt() before mlim1 gets assigned XDL_MAX_EQLIMIT, but
usually you'll call it on the same xdf1->nrec twice before you
assign the result to mlim1, no?

The original lost by the patch looked like this:

 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;

which computed it once, assigned it to mlim, and then clamped.
