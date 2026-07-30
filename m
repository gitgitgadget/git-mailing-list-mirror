Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D640315B
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403243; cv=none; b=Am4jgklGTCwSBveAHbwodunNXkZwW6QlZFl2tcEmKrYEdQ2qjljUyuUeqTk5QmPFnWilVIJXVAZNP4EDweCGZsOhn+Qgx4kpjxLFYelxzn+Xmw1sE1gGDnGP3WxlJhWbsz8l6/DWIehG6erVwuY9I3qpSuJENKwQgGf+hXGH/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403243; c=relaxed/simple;
	bh=YcUc2GXWXfQTzX6E5n0XrAyO66ptiTeo21iJFQtPSXE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IZ2toXSOjYyReHkhZ0ppdK8YTcZif2DhQwB+zFDxhNkwXpcbljZEvutSPkReXv6tF5iA/D3MlponPSV1ywOmHWpXgMbTIPNp8EVbve6dalpC2h85o85ED3o+L0geG+Ca1t9wkHC0wIqNoqW+NNv+rWv7df04j+muGpm01YIdnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LyB92EY0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z/LTw5lB; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LyB92EY0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/LTw5lB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1809D7A01CB;
	Thu, 30 Jul 2026 05:20:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403241;
	 x=1785489641; bh=wJimjBLhxOkHKi1lpfG7wLIQOBADbFiz1r4MrQ8B5C8=; b=
	LyB92EY0fs4AIvQXG+DNJqDU3hepq8K2xxJeIRmmCQ4sroY7X2jx1OHDkxI9iG2C
	zgf2CNN8MfrjQxjaBZxXxY7XP5nRJMMjJMPO63ef7CA6LH+5PqXdrPysRtoyGO8P
	qT/kBZCekSTj+BRNuPuTvl7fDNMW3W1EESGrgNic4bW7xQnCiuq0m/63qknRd4ar
	h1o3632CK69oga2bj4z2eCjy5ZfNaOxiPzFGFD6AoY2EpVIeVaC583TogW+64dvk
	FnvVWzqBloZ38IXm/bYXrbYI3UdRdJgMU8kApTPl2oLapy/z38iVMTvov9feIoEx
	S+Z+Ahb+bqYjA0yVh2O4Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403241; x=
	1785489641; bh=wJimjBLhxOkHKi1lpfG7wLIQOBADbFiz1r4MrQ8B5C8=; b=Z
	/LTw5lBjSLq/SoQ+mMhD84QK4o3sswas4/fsQgeIImhSPu29KcM3p9xhoXG3kOk4
	LNPvNVwdgiEgQoConfWclml/kKPwc5/zpGP5S3sQlUs2F1sxXJpEJqIu9e9MuXbI
	cfdryLCUWbrZoRy3IhS1pVMEqpjJu/HnHAbM2/gbmOBxv8omUEj/BkMiXlyXaw9E
	TyRNJSyXxK0BNkpLwNbodMOxizQ51DKO2apitaOyptpWt0awwDXEvXM6kjqzG9Da
	bsS3Vj7qDCUE/PKuHvjOg65Ze+S7/hRxgmZG+mgMTidXGPrkuN7srAkg6PpdI1z8
	+vrcm9jbSik3fycDIJO1w==
X-ME-Sender: <xms:aRdrap3_rFDyX5twJ6eRl3cWJ6u1mW0wdCcH5n3-fCnZGipFpxKq610>
    <xme:aRdraq63mm22yG3QntxRbk4wWbL1qswquRaoDQhTISmITtR1cvA-zocS4XnE4BGqW
    CPLQQ2450rfFdh0cQo4EfdCkHALIEBJCV4AjCpbF0ye76V4Y5Py-g>
X-ME-Proxy-Cause: dmFkZTGbFwXG//MAuto0P9sA9fhM+7zeh55aJlkkj8905p0etvohiUW7MR5vyATE0AaL/d
    0vKvhJz9VtOpsBr38xTSsadCAdZgpFonzQfe1TGPGh/1OA+XawChhl4ePKkM5MtWOIRvwW
    99PZZk5WYpjXpI/NbQhraA2Rjy1TtiTVaUp0q5pFU3mgAFrX7ZIIw4OCEw+/Rqfeczf/3w
    CmnuBeLorzylCeopnqV/zzgL50W9u8/BD5fmAv0Z5t/AFYEiNEk5Jwea171vfAxDjkJt0g
    d+1AK+w2sYlQ+SPqpyOrgxI4QDCyjT56ylhzZgmjN+3ZWxa6nldotKK0bsUB4RwqAJowUq
    VqUH4T2vwHKR4NLmQHwbCLWiQm/q1k/ENM8dLZyDRAVjvD072gqE1i+sHCqhiyrcTKI2iH
    WB9mCr65YWOff/nos4UBgn8W42CAnnUZsmkaYdHXT5lsmCJI4mv5xrSqKBsE+urds0TfEj
    i6oIfjrB8wH8LyK7mxNfecqmyCEKzNbjIikD2YZ1Iu12TDbcA4QIfvL3uansTfLzUlHIqu
    +MNeR+c4dk7rgLU/JBtbbhpyMOyEEo+iTSzJqHlc5gQ1g2FYjKUC4ZgwZFFsi4roZ6EvFo
    wXNwk/w0kxKPN+5i6M4Y24lhcWFm9AGDrQ25V8CAD2BipDElNDZP+bqD5mhQ
X-ME-Proxy: <xmx:aRdranj9zP_LM2JuFTaiJx-ttrnI3vRP8CJkUnq6IxhaWdHVd0n9bw>
    <xmx:aRdratUrj7ScXpYaZy76cwlE1T1ONIckV6IioAs2nugn5QQno09O2A>
    <xmx:aRdrauXWKAeiyCmhYEZVwYBB1G-3Oz9S26T2k7NgEZTZ86eonDCcKA>
    <xmx:aRdralhcwf0LoOz-XbcMGr5Xx4hW3kiUSKc7sK5YjtJPm71bdCsqJQ>
    <xmx:aRdralXakfXi4pPjAwxoBTq8L0mStR-1TZNBR5wWDGkD-yDCVKHuHiCM>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA4D43020073; Thu, 30 Jul 2026 05:20:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Thu, 30 Jul 2026 11:20:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <21339fd9-9fcf-46ea-8896-9fde56cd1f29@app.fastmail.com>
In-Reply-To: <xmqqzezhb73q.fsf@gitster.g>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz> <xmqqcxxyt4op.fsf@gitster.g>
 <729baf6b-53ea-4e8d-95ab-5935667e66c2@app.fastmail.com>
 <xmqqzezhb73q.fsf@gitster.g>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, at 01:48, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> I was reviewing the draft of the What's Cooking report and noticed
> that this topic is among a handful of stalled efforts going nowhere.
>
>>> If you want to stress that a line with only whitespaces on it does
>>> not count as a blank line for the purpose of this paragraph, you can
>>> consistently say "an empty line" withotu saying "a blank line", and
>>> you do not need to have "(specifically an empty lline)" there.
>>
>> Okay, I=E2=80=99ll make it shorter.
>>
>> It felt too long for a simple concept indeed.
>> ...
>
> And it has been more than a month since we discussed this topic the
> last time.  Will we see an update anytime soon?  If not, let me
> mark the topic to be discarded in my draft of the whats-cooking
> report.

I=E2=80=99ve posted the next version now.
