Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEA377A97
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478113; cv=none; b=Ck+Ir65MVkq9Am758tFtyHWd/31WV20CBdqr22Xduyta0WNSQDzQNsA1aVz+DDce3TI5AKVW3o3eeigeCQ4nqammru1FrQmOpr7wuOQRidcEMLrIudRRGY5+t8pX9OWpGjJ/iRz/Od+6S3vseErZwTdyJj0Xw237KBZ0qsRXGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478113; c=relaxed/simple;
	bh=CcMNvQ2Ta7QYKWcB9n8rxNZXMRiuhzZj71IZrxBYv7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvG8JGM9HqNmpLnZnT2q31n/GfZBLFlLTG/LNXBCub86EpaPrqtWMgZBtKEjhJu2Z7kff6r7e2JuqiQ/S+AN7Z2HecVhh1Z+W5A65wEaprSPczzmRqrlyFrMR22jIZASiIT7MMiiEXjlb17Q1Q4DRBtAgQ9sAU+p3srUrxHVOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g2DeiYJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9iN0QFz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g2DeiYJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9iN0QFz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E95D14000DD;
	Tue, 15 Sep 2026 09:15:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 09:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789478111;
	 x=1789564511; bh=cFEBBGHQs8bPoMVQ7pJr0TD+m0u5gwnq/6G/GgD0p+8=; b=
	g2DeiYJhNtRmB7cyXTkGYh7UAXjjOl7ih1vEPg7tubUHSW/NTE6NxZ89mwGUpuHh
	jQZdleOB3rnAiWLtT7D5FGSUl0+vpj56YiK07VBwXpAfCeQ1d7E8332Y4Bx7VGZ+
	VxaRf9NtObmh9Ft/okBlBKEZbf1IsQNqYRI8XDvGCkTLRkx9jCFEuGAbRyzy2Rv3
	MagmL55L3YuekIB1uFYWnD2Riz+UJRwsJ58cWZMSS6BhGJXeZyxja87HLvopxVmo
	HuoHQoTQ8VlK0w7//gLGRZO5SyMW1meHaUcpwbOBCiGO/CKvsIL274L8hgbzg04r
	/L+7N7HfpdDAHAtUn5Dpnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789478111; x=
	1789564511; bh=cFEBBGHQs8bPoMVQ7pJr0TD+m0u5gwnq/6G/GgD0p+8=; b=k
	9iN0QFzjKv2LNaphl8lMfibKUt64XZSCjrLsVJlwd9x47nVNN3ufhuzKrz1xpq/A
	DbiZlNoc7x0agBzUVQ1lOIWCdSSU0RuJA5xphE5q10WuSMCLDSULjr6+v7w0dpBB
	WiWXnsJVNq9ZK8e0fzNC164Lv2y0TjS8Ccs09MRfBLruYYXjXXV9+f9bo5shMZnk
	m9wA69Zf++3theEfJ95YXV2R7RJTDa862tWeqrUsQzGkK7dbUgFqXRN7j2If5Ltz
	rU2C6akPvOEYKbfh5JhlPhT7ZALTyfEPc0ICiW41fxvUyeAZAzje2LOMfOrO0jMT
	ohVV8DbQ6zb20FhALJ5kQ==
X-ME-Sender: <xms:30SpaiBjxVVr4fj5EIVBIHfvAAAVU3YQ39UFKFtN0iD33Uh0dZVL9A>
    <xme:30Spaj_sa6-foekp4VOlphFMRtfjkIr37qJJOjk3iMw18XwX5JkuYK0ve4T5KOKqC
    SA8m4BZigXUN07txEqVg-2-Wk5AiyRHVmQprJS7bDmz0E1pKHC7bA>
X-ME-Received: <xmr:30Spai85xkfWLfq4815XixMqUwrI37ge0-B_W6yi843OukRzSgRJOUh8OqizqpsT0iFnZSXMgPd5Bg6CCPPU7CxKaIASlAclejHJCoYI5J91aKto9RgbICM>
X-ME-Proxy-Cause: dmFkZTE5CvUAn0llkWvRAW+qDUAztOpzSUYBkL+bn7wmdoryC5WMjCgoulq7cgODNoEp6J
    pFFIhsdcHR7S/tvcXHXcJAxBPmMiHChRCbEriJHpcdQ6gY0L3o/SbpwuaX3vl4xNO0DGot
    zs52ChrDciz3tfh/i4D8o61AwmnRjWmNbKQXwQA02wyKPl6Za0IpOPRZu1vomBJ/e2/XTY
    Xqu4rc3/Q+vWa4GQXKTTOzxslp13W8iaUreN4T9/qZfeXqSYpiONyGTaMaHFVW78qAA6Vp
    CD95il2hCVk5E+WOe9L36swHhm79Ebg4OYj+vNhMGlm86aU7eJKD8gQRSKgbDbsnUzRAbM
    3dIoe77AAmZ2h/UNDxLq3+YkV8hLxSxkDePn6chssjwP5b00E0f2uCstfD4N2UXq8vLo2J
    I3rofvMmLeueeXTLUeLddmHOJOYcZcSBH2ha8N9KkzXde5nPYEN/qQJG71UAvxXiUUrqls
    syQPs6E/40QPQBk+1c+tAONZ3Cz9KIam/Inj7/4c1LAGTZ9qhq/1jMBwCeS2k8p+0Mmo1n
    SwO7nVSz+GAFdEeNBxTtnMs1fWkUqgSFO1uFJQExB09nizg0SvAxRvj8/kI29OtMtC3RZ8
    8IgjAu8AhVKfHIaDfYUnejKsTBPw0Cm6dwW0VlhoJDJLdSyIlQ/7F6F4DmiQ
X-ME-Proxy: <xmx:30SpaqcW5QhhngH9Pd-amF_IUPTnpQhtehyUWzjiHFZEgZUrGddHmA>
    <xmx:30SparEqOrpUvaqkmdcwzBxbJwMBDPd6ECgtFKQBkZi8ipyEUSqZnw>
    <xmx:30Spaoe03HCisGhQ2Pys7DmO7Nxpum6-0IvxIvKb8rX3cz_aEXd-FQ>
    <xmx:30SpalExcUSUBeGbZ52wH3TP_66nDvs-B8zT3GaveWE9ULe56H6WJw>
    <xmx:30SpamkBKTiQmQ31O3X_KOMUD8azvoZM1nttNweP2hdotxMr2gO_0wlN>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 09:15:10 -0400 (EDT)
Date: Tue, 15 Sep 2026 09:15:09 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] doc/pack-refs: convert synopsis and options to
 new style
Message-ID: <20260915131509.EztJBORN@teonanacatl.net>
References: <20260912191509.844954-1-tmz@pobox.com>
 <20260914124630.154107-2-tmz@pobox.com>
 <xmqqcxuf7svp.fsf@gitster.g>
 <20260914154350.LjUwy8DF@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914154350.LjUwy8DF@teonanacatl.net>

I wrote:
> Junio C Hamano wrote:
>> Todd Zullinger <tmz@pobox.com> writes:
>> 
>>> Replace [verse] with [synopsis] in the SYNOPSIS block and remove
>>> single-quote formatting from the command name.
>>>
>>> Backtick-quote all option terms in the OPTIONS section and convert
>>> the standalone placeholder _<branch>_ in prose.
>>>
>>> Update the included pack-refs-options.adoc to backtick-quote all
>>> configuration key terms.
>> 
>> Micronit.  I think you backtick-quoted `--all`, `--no-prune`, and
>> friends, that are not configuration keyu terms but command line
>> options.
> 
> Ahh, right you are.  That was due to my re-use of an earlier
> example from Jean-Noël's work and an incomplete
> proof-reading.  So I'll want to change "configuration key
> terms" to something like "option terms" to match what
> previous commits have used for similar changes.

In looking at that commit message further, I update the
wording slightly as there are no options in the OPTION
section which are not part of pack-refs-options.adoc.  I
condensed that to a single, more accurate sentence.

With luck, v3 is now ready to go.

Thanks,

-- 
Todd
