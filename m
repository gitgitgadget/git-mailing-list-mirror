Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679253382FC
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253054; cv=none; b=njlIHRzl8uBqCLjimiZ0S1rnkQqTZC225PoZAFQq071S7e2ATM+JCskdR/02yBS3qk9QBhSNaCrkSkxC8SDoG1xUuSdsxFcvVvkSjkmznOaltfwsW1jr+36x/MBqD/WIf4S9k+U9mfq8jo+bRsXu8089S7j9+1Wu5p45g0Hc/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253054; c=relaxed/simple;
	bh=9twQuy/fdfSKmTB723AfGOYsiTVObV5BwR2XE9HLixM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iGGjOEeFicLCPCmKFmP6GDRgCKeJG+2+Hg51YT35JGd80B8BAVFFiCdH6XJdXp/8WmB5dUeTSGzIjiZ2zfQUXWURZjQZMh2eeXO6H06X4Qy7qB7GaR9vu18lnQYvL92SF8PiNQM5yUQzLdecokz5sJuwZidkHvuTHubYf9mW4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=vyVi767z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoVFCgm8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="vyVi767z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoVFCgm8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 65465EC012A;
	Thu, 24 Sep 2026 08:30:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 08:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790253051;
	 x=1790339451; bh=de1iApPO2p7yL/P0MO1oPQjMkddY6dKTKbDZxlPgaq4=; b=
	vyVi767zZuLKx9f+cgXAligZiRaj00ET/bO9ScYMJHQuTh9060IImWmdkrdsyauB
	cBslqJ2n0NCQ++a5XIABJdaoWmHCUwr73+1oJ78ekhTSnnur5gLNahf8CY/WPjHf
	irb6hfoXgMTa01k8xqS7bZ3NsVYjofNJCn2UzJyswbPHwrl6K1DUzbEMkjdrQD0B
	xhZjl2S4tMZhHzJwLRdKsV+w6KV9L89yf0+k8tZGfox2Ty3B8fnzaBxEtbxbeG/Q
	aFzTMSeGNtW6Oi56Spkd0wQ0vKKycjvXoBnuatQ2Z18ZjSXT2jP0ooM/fSA7iXKO
	NAbGlbmy7ISBNO+e0/wPlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790253051; x=
	1790339451; bh=de1iApPO2p7yL/P0MO1oPQjMkddY6dKTKbDZxlPgaq4=; b=A
	oVFCgm8l0jLFPf5SgbMEJPqHKHzUvw8bNnEhHAyplaRiLhIlBZNuGoWBgBlZj+KX
	2ItNc+hb5hf+wt7VfVYYR1n5mPJpickVkWxFzNrPTwqyXd5RyQvNdLSZbsDr9wUv
	1mHMEOtZrwdE36X2QBDZirueWC5zQ4LJ/ZNSyYTy+dqPMhzM5q10BsOm57R97eRN
	8KibtMlNQL+JkSpGfPXmzSEPmVVIxaVf2pmV1674bs5eo3IT01f3TKWoYCpK4kcD
	I3rr/cAmc+T1hWcjsK2RIkvtjIZ6ScGm8lmTmE/wwELpfk92GvCNrGUaOsOpt6SN
	3+3cc+XKFAH/lpjlx2ZYA==
X-ME-Sender: <xms:-xe1ap2hwkT4rdzXj4wApTPBLEJV2bJ2STt0UkFbro-ilcrXasO4cA>
    <xme:-xe1aq6xXCLBdtqfxeru1NuEuD3ciy-s8AAwvRDwKy4SLNZ2kFAGP81fKNEUsiWNt
    OefAGCtHsY2_-JUYqi6bzPYECrVB9ZF8Fon74h8LHZqy9JnlUnQmbQ>
X-ME-Proxy-Cause: dmFkZTGQyX/Ptrb4HUIu8uJ1sFu4BnlHCgE2yHnRfKmlRMWY/G93IMIc+Ec3ew4uReQVOa
    xKjjSW8Qeh95qROMq09etCngUaPx3MyB36A1cp4rIB+g4Fwsa8cpH1L0f+AwfHEJnVH5WK
    9MfN2tPLqSqg1TyezdaSVeCDq2i7h7LQ0ThqalXBmPBUKcOcasy+JAMmJzNEf6D410JU+F
    JiROtprgi4USM/k+c7/YL58eXTqVk5INJTnatcNZGnFFDncqT2Ncqe0r5iqm3m3hsXYyK7
    m3YgTFBt7pe1JoPuSINJAgHiM+lRdjEA4WMUbShOzFqXpCVvwMXR13Wx4mcFyu5dwo/xjm
    qPtUesoPkQktTew0YIAJiuEIIL7dSa+/I7AERBavnW77goXj5XiiNnUQnJlYhFgDHOPGC5
    J3YlfyjXvHxNazC1qZziap/UjC8nafkZTNM1of4jiHFkjgICRE93lNjvLCS6pT3AwyutbB
    7kD07TbWLhRWrIqBfz4SLLOpERbfwHhJ/uC2QKyrUeaj5WcafNpBBtmgraPv5fNAaHTd90
    dwbPUxB6UmY9/IogjKK+WYBFYXaeC1/rEbFdJ0yIgq1LNt8RyY3xJvqiQWJ5pb2WpjByjc
    YLaul+dk8TXFhOAMkPTYtvZO9p7J/KpbRI4aIijYCVeF+Awdfu/JnpVa07aw
X-ME-Proxy: <xmx:-xe1avcx7vCBvBgvCiVJZ87yj5kGOiORsKTONapKd6hqv--O6XWH2w>
    <xmx:-xe1ajA-I7FZ60vbYIL511R0Zu6tSM-kpUIyt6XmTLvDSCLPz5sSjA>
    <xmx:-xe1ai_QYbcG-LzhAQVcyvElf0cLa5O8MOGirLs5UwCjlB41ruWN3w>
    <xmx:-xe1auIrmvFBJPbdLE3E-9C4-y46FK4gYOrOeqACSenu37J0Syyq5w>
    <xmx:-xe1avIGNjoFC7l4sMCWI9A9ysLmSLwKyQR2iq0XGxBqt3yo8B4AJ2RH>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2DA07780075; Thu, 24 Sep 2026 08:30:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFcAV8VPp38k
Date: Thu, 24 Sep 2026 08:30:31 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com>
In-Reply-To: <20260923214038.GA49087@coredump.intra.peff.net>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <xmqq4ifhdon2.fsf@gitster.g>
 <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
 <20260923214038.GA49087@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Even weirder, in the manpage output both implementations actually expa=
nd
> this to: the section called "FOO". So changing your patch like this:
>
>   -See the <<PRUNING,PRUNING>> section below for more details.
>   +See the <<PRUNING>> section below for more details.
>
> gives doc-diff output like this:
>
>   -         See the PRUNING section below for more details.
>   +         See the the section called =E2=80=9CPRUNING=E2=80=9D secti=
on below for more details.
>
> which is obviously nonsense.
>
> I could very well believe that some older versions did other weird
> things in the presence of includes. ;) But AFAICT the real need for the
> doubled text is to control what is in the expanded text (both because =
of
> differences between the versions, but also differences in output
> backends).
>
> Which is kind of a shame, because writing just <<PRUNING>> makes the
> source a lot more readable. I wonder if we can configure these text
> fallbacks, which would let us use the single-item form reliably.

Thanks for investigating, I was really dreading looking into the guts of
asciidoc to figure out exactly what was happening. It would be nice to b=
e able
to write just <<PRUNING>>, especially because I believe asciidoctor will=
 check
that internal links are valid, so there's no concern about breaking link=
s if we
change the title of a section.

Re your other message about breaking links because we're changing the
HTML IDs: the options I see right now are

1. Leave it is as is and break some links
2. manually enter the ID like `_editing_patches`, trying to make sure to=
 always
match the auto-generated ID (I'm not sure how to do that). I think this =
might
also cause some confusion for editors in the future as to why the sectio=
n IDs
are formatted like that
3. Somehow fix it so that we can just do <<PRUNING>>

I'm not sure if #1 or #2 is better, obviously I'm biased towards #1 beca=
use
it's less work for me. #3 seems like the ideal but I don't know how to d=
o that.

Here's a revised commit message, can submit that as a v2 if it seems cor=
rect.

    doc: add more AsciiDoc cross-references

    Instead of saying "see EXAMPLES below", say "see <<EXAMPLES,EXAMPLES=
>>
    below" to make the man pages easier to navigate on the web.

    The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
    (instead of <<EXAMPLES>>) is in some cases, the HTML output is rende=
red
    as `"EXAMPLES"` or `[EXAMPLES]` instead of just `EXAMPLES`.
    So this gives us more control over how the output looks.

    This also changes some of the HTML IDs of the headings from `_exampl=
es`
    to `EXAMPLES`, which has the potential to break some links.
