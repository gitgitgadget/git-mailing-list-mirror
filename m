Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB3182D0
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998661; cv=none; b=fZ4tIrur3Xd1zIDTHjXvz2IPOK1GTdARasDc0yMMUnBqdgKpHppWSq1IbrVvaUoTUVJV8gApjoeZeEp+lHeZ5BRiiDKk8KrOTSXIlsJGfGueW89dkV3etYgxSLjAyYHo1hg37b4jok+Apl9Q4hXk1knL2TcnJT55Gi9dDgxrGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998661; c=relaxed/simple;
	bh=3d6PYvq+8rmjj5dKMTmzoHZwIhTmSP/Ar8CmY5hjW+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQPvJkwwklnizt1f3ZvYBiLzERm6DMqBG+y+fUKbLjXHzZbANv9Ju2O2Y2fStn90tDRki30ey4gL8fB5psJmITNQxfij0E7uYOmh1//T1+TLMBQJn3oMA8/bh0K9SKexfovyDQrQAn8YgPPnm+OOUJSjsb1nv4+CApMoKEypyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ywivGfu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmiuiMrL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ywivGfu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmiuiMrL"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7107114026B;
	Tue, 19 Nov 2024 01:44:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 19 Nov 2024 01:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731998657; x=1732085057; bh=JL7AcG3wkP
	szlAulrngUAVc9FxHAzXNH2Q5f+0a3KW8=; b=ywivGfu6zcKU6EKbX2TB4wgw+V
	byIS9WRzCbEOvzoBayQef07Mxr+VqoqPISec+MmwyB3as/q99G8xZ3IScZ0XiIpJ
	PfafMkX+W4VS4A2aFHJfG7vu88w3wL2zQZNhxFMZ9VOc8YtWk3kEz1yPcDPDth8l
	D342xeBVM7HeVOsEeT+SmziBAw8Y7JgLv+7BV5SsZYZM4Vfo+UgAkA7TxSUPcSnn
	vvhI36f9rNXi5Zrn4GRlA3ihattXfYb2PI59aBqG3JpuDG/GaPuRtVJlpgZyyZKY
	uBZFwG3FhDSmwfttx7v7CclRtlzSgwvkkqrpnYq6KgpCh6yVpIOnAYR7LpiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731998657; x=1732085057; bh=JL7AcG3wkPszlAulrngUAVc9FxHAzXNH2Q5
	f+0a3KW8=; b=mmiuiMrLMbP/lLSGSVoGvmLdGp3lcsMMFW0zJ+7btZ4v7NPJdvZ
	stbhoy+P5I18c01eJiMVsNaPWcGfIzQ91uYzzIoa2YEPGiPG+pGhMsY7njstDXzX
	kd56zvikcM2RYkXNLFz3aKuXj03EEr3ld5Bl7WAocm40TYq3Ib9qKdUQAzDUP0sK
	MnP9ncumWuMtO+hWXfWOQIyU70VoZLIhJHthbzbvY7rpZbgpN6XhvXozzkZh8qul
	VBKozfWRjZJ5vZtV1WqqEYI60NnIuRTCbcJ+L9rpu3GXMlSFfXgDL8NiruXUL7Mb
	wLB+00R0I6nQ/A/QXzu/mGxFvu8W/PH2kCA==
X-ME-Sender: <xms:wTM8Z4dtE_auEsjyPyTQIkz6G8Gg62UWlAlud0AI8YBiJ5QqDPi6Mg>
    <xme:wTM8Z6MIF41GgN5uJrSYmMHB6Y-kWZXZirUNGVla3WsjlG1I4af78WPLoFFeFrjac
    hZOGVZszF4fSyR70Q>
X-ME-Received: <xmr:wTM8Z5h3NQwPsBak3zVsErp_dsKNUBMCneaBTfFAHk9Rm4eJ3G9r_t8umpmbJ0FLO2D6Fyjlg4EcXuFb-cpbwGh5OF6kFuktbiXL_9ivPSvQy8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghntggvse
    hfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhi
    nhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:wTM8Z9_nOZEOxAs84MucTqhMuPU7pItHYE1ibSAayyAsoXboXd-cMA>
    <xmx:wTM8Z0vY0Tvq1Wd51hpV_7dd_y5x3HZmt2sdPMPBqgEhbobCBQOsog>
    <xmx:wTM8Z0EWt_BlgHcym-mv6w_YprOcLpN-eubQFnjshKCGYD-FQXO-vA>
    <xmx:wTM8ZzNxfFAUoZsE3UJgT-sFvFPTLvZO9_WROp_HLG5Nc7mcLEYVoA>
    <xmx:wTM8ZyB2Ee35esy02xRRO8r0Q3hOFuPGX4GULXuM2RNvwKuWKAdk_v_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 01:44:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e80bfcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 06:43:25 +0000 (UTC)
Date: Tue, 19 Nov 2024 07:44:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of
 refs_read_symbolic_ref
Message-ID: <ZzwzrI6wJjY2dpp0@pks.im>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-3-bence@ferdinandy.com>
 <xmqq4j44ggq0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j44ggq0.fsf@gitster.g>

On Tue, Nov 19, 2024 at 10:22:31AM +0900, Junio C Hamano wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
> 
> > Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
> 
> "output" -> "return values", or something.
> 
> > When the symbolic reference we want to read with refs_read_symbolic_ref
> > is actually not a symbolic reference, the files and the reftable
> > backends return different values (1 and -1 respectively). Standardize
> > the returned values so that 0 is success, -1 is a generic error and -2
> > is that the reference was actually non-symbolic.
> 
> Are all the existing callers OK with this switch from 1 to -2?
> 
> IOW, if a caller using the ref-files backend start behaving
> differently with this change upon seeing a return value of -2 (where
> it previously was expecting to see 1), that would not be nice.
> 
> Because "reftable was already broken" is not a good excuse to
> introduce a separate regression to ref-files users, we'd want to be
> careful if we want to do this kind of "while at it" change.

There are only three callers:

  - "remote.c:ignore_symref_update()" only cares whether the return
    value is 0 or not.

  - "builtin/remote.c:mv()" is the same.

  - "refs.c:migrate_one_ref()" assumes the behaviour of the reftable
    backend and only checks for negative error codes.

So you could argue that it's the "files" backend that is broken, not the
"reftable" backend. Doesn't matter ultimately though, the real problem
is that this wasn't ever documented anywhere.

I agree that this should be part of the commit message.

> > +/*
> > + * Return 0 if the symbolic reference could be read without error.
> > + * Return -1 for generic errors.
> > + * Return -2 if the reference was actually non-symbolic.
> > + */
> 
> As this is an implementation of ref_stroage_be.read_symbolic_ref,
> the above comment must stay in sync with the comment over there (and
> a comment before the corresponding function in the other backend).
> 
> I personally would not add the above comment for that reason, but as
> long as we are consistent, I am OK either way.  So if we add this,
> we should do the same to the reftable side as well.

Another solution could be to have the comment in "refs.h" for the
caller-facing function, while the backend pointer simply says "Please
refer to the documentation of `refs_read_symbolic_ref()`."

> By the way, it is arguable that it is an error when a caller asks
> "here is a ref, please read it as a symbolic ref" and the ref turns
> out to be not a symbolic ref.  I'd say that it is a valid view that
> the caller asked the question to find out if the ref was a symbolic
> before making the call, and "that ref is not symbolic" is one of the
> valid and expected results.  So if you wanted to change the value
> from 1 to -2 only because "you called read_symbolic_ref() without
> checking if it is a symbolic to begin with, which is your fault and
> you deserve to get an error", I am not sure if I agree with that
> view and reasoning.

The reason why I've been proposing to return negative is because we have
the idiom of checking `err < 0` in many places, so a function that
returns a positive value in the case where it didn't return the expected
result can easily lead to bugs.

> In any case, this "not a symbolic ref" may want to have a symbolic
> constant.  With NOT_A_SYMREF being a non-error, you could structure
> the caller like so:

That'd be a good idea.

> 	status = read_symref()
> 	if (status < 0)
> 		... we got an error so we stop here ...
> 		... we do not behave differently on error type ...
> 
> 	switch (status) {
> 	case 0:
> 		... everything is peachy ...
> 		break ;;
> 	case NOT_A_SYMREF:
> 		... we want to handle non-symref here ...
> 		break ;;
> 	default:
> 		BUG("unhandled case");
> 	}
> 
> Also, even if we decide that we want to treat this as an error,
> lumping everything else as "generic error" might make it awkward to
> evolve the API, I suspect.

I guess most callers don't care about the exact error code, they only
care about whether or not they have been able to read the symref. I
think this idiom would easily be extensible in the future if all callers
know to check for `err < 0` by default, because introducing a new error
code would continue to work for them. And if they want to handle that
new error code they can adapt as you propose above with the switch.

Patrick
