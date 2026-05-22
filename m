Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6B2110E
	for <git@vger.kernel.org>; Fri, 22 May 2026 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408652; cv=none; b=gt3h6alNLuDmzi4RwAhF4DO1CP883s7ncdqiEThenlx9T5JVkz/N2mDNYEO6EJaYD8OqvAnD/j9AHNXi8+guhfYLOB1ThbHqodcuycV8QdTkzXOh8tLDXPY+CfMmvYxyI2AUnnxb9+rNZr63wKTEClubGClPoh4RQfXpvDysP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408652; c=relaxed/simple;
	bh=xJoIiS4wAs2TIgIoRTcxrcHvs4GW1lmMbp39FtCwFXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfWMdE8izdyPFFzYrSJUJffed/65SzZuJEjeFLJVoDnXIxqdP/m4GtAQiJ3tWoEnineifMfsL/c+TlStQZGIudVAAHEvWbWhnkQWzDeGbl1QwNO3rkcKjPv+AtzF0XiajUj/yt4rpVs484iypbaPr5esfXQtqjAKg373Dwc77Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sCjGap6E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQp/fSAd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sCjGap6E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQp/fSAd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 60C5A1D000D5;
	Thu, 21 May 2026 20:10:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 21 May 2026 20:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779408649; x=1779495049; bh=fySsYL8P9p
	opfmUfF/9rSrIYZjidCTluP3jwgVtHL5c=; b=sCjGap6EG1KeXpuLSdGm9lGAqs
	yufOfNFYGW7XMpdMjZwtQZCZulDK0fF4A2NKvlqAFRDDuc1AbGBJq4dSOvrhJ+F+
	1CkuRmfoNlgBflANouD8wpmtp832LN1hT4w7q+I94Z8wqdVXYSWKJJaNmopKpbjI
	C3ezr95aM0kHewTtoBjOplGlumkYbMGohIYGlPRZCaU9XNjoSi6nE+FpXD3hRzKY
	204ZM131cokOIt6UkBzQeVCknQ58gjQvZAUc4evmizk6L2pd0CVEJX1LFkbyv9aH
	BKiPaWYWNzSH5MRFujMAMXPf344iwqQE4O1mWmCB1R7+ORd+Z3mZJ23y6lLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779408649; x=1779495049; bh=fySsYL8P9popfmUfF/9rSrIYZjidCTluP3j
	wgVtHL5c=; b=TQp/fSAdnrvrwQ5/4dadLTCU9xl2nitvXp2uqEj/mIY1D4Llcfc
	/d5JBmWOovF3n9hv6PXO/s3AdKwDSNa9/Wa2UyWIFADqoMSNUeIL7Yt/8RRTcELS
	G3s1J/qkmuVHTqfirMevAuExnhlUgek0d03pKwYY1POj1h3RQX2pmwR6Ko0lvqeo
	eeBNXg8j35XOQNnkMAH0M7t1aWyc6VP4BpzRyURDuTj8cwSIVyIVk/mxUF2/CvX+
	2VcbZjiTXHzYdVinQTDZfabCH2LfHkFpZTmKLWaWgYkw22pF5qZEt0PpAO97Roso
	wNkvwEypYWiodZ+VgwDM5TcM5rmfqIzmYsQ==
X-ME-Sender: <xms:CJ8ParMW0C9Zgfyq97nvFALlMSd-AmEqVR1PuETLDSdzhPhvxbq15Q>
    <xme:CJ8Pai46jwrIAJA3im9GwqWzEYx7VcSCl_VqqIirZQn5N6M5uuvYkvMnc7VOQeSPW
    JwD8U4Ylth5PGBBBdtcCb1yqRVAB3GUDYw7uOIp2y9W1pdtgp0>
X-ME-Received: <xmr:CJ8Pal43kiizpX0QQEuADJPnF2k9dXqG66Sh0R-d8YDo8FvIdEi9utPTDaTrratpFgkIV_OLw7dKQ-FgWslrs_BMoQGJ5B6mhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepsh
    hiugguhhdrrhgrmhgrnhdrphgrnhhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehoshif
    rghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:CZ8PaoGV5lqXedF1isrAl9j9ADFHEk0QkElZVg6qci7VLyqp0daUFg>
    <xmx:CZ8PatWLI3DJZQobNh5uNUiBlOqSum7i4c6rBu32Tk1fEwLQBjy3_A>
    <xmx:CZ8PakU448_U4VNWyONovrrlpJp6fSZS_j07AL6IMWO6AW5lXnN5Ng>
    <xmx:CZ8ParLTnJA6amNcM870JCEGQeRt9P5y_-0fvJk-gISLA2h9E6hJZA>
    <xmx:CZ8PagQ2tirJZeOc9Iu6UkFCgZyM5zaypR2yPmNhP3C6dd5_bCVJFedu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 20:10:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "newren@gmail.com" <newren@gmail.com>,
  "ps@pks.im" <ps@pks.im>,  "oswald.buddenhagen@gmx.de"
 <oswald.buddenhagen@gmx.de>,  "code@khaugsbakk.name"
 <code@khaugsbakk.name>
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
In-Reply-To: <cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org> (Johannes Sixt's
	message of "Thu, 21 May 2026 16:36:05 +0200")
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
	<f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
	<b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
	<2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
	<cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org>
Date: Fri, 22 May 2026 09:10:47 +0900
Message-ID: <xmqqv7cgxq0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.05.26 um 11:59 schrieb Siddh Raman Pant:
>> The timeout is for the failure path, where the external helper has
>> already stopped following that protocol or is blocked on something
>> outside git's control. Since git starts the helper and puts it on the
>> log/grep path, git also needs a bounded way to recover when that helper
>> does not make progress. Otherwise an optional note source can prevent
>> the main git command from completing.
>
> That Git communicates with a process that looks like it stopped is the
> normal case, for example:
>
> - Output is sent to the pager. The user can take their time to study the
> output. All the while, git waits patiently for the user to advance the
> pager.
>
> - Git fetch transfers large amounts of data across the network. Most of
> the time it waits for data to arrive and does nothing. The peer process
> looks like it hangs. Git does not decide to kill the connection at any
> time. It is the user's decision to do so.
>
> If the notes provider hangs, then it is not on Git to decide when it has
> waited long enough.

It is often the sticking sore point that there is no good timeout
value that suites for everybody.

If a protocol builds its own way to declare "this backend is slow,
so please do not consider less than 3 seconds of nonaction something
to worry about but kill it off if you waited more than that" to make
the receiving/waiting end responsible for managing timeout, that
might be workable, but it certainly feels like a kludge.  The
protocol can instead allow an "error - for your particular request,
we couldn't come up with an answer within a reasonable time limit"
response (in practice, "within time limit" does not have to be the
only reason for such an error) to be returned, I think.




