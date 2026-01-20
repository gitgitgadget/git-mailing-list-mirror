Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772B3A9629
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940294; cv=none; b=QnsWkY/ax4LCiqawuFGwaPLBJ+GFHvIKgt9ksDfOJWmPTTwqC2YyG6qJ4sUR4/Oimpgg5T+CNKTfkmbZsZEKr/R5T+pGdh8OiEAnUaklhVfzwbMZ+fp3g4s/suMMIxvfsu9zI674ZAI+RLGq3HLxW9AjCJQk4r4R6TuGwft8X7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940294; c=relaxed/simple;
	bh=uSM5qF56Zlo/v9OGbtpbdZ0oM51BR2R2m4iNkAFEWRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i17g1RQ9PUAqMOVQiKuqw1CDxAWosWJ2+v11oyrqLe64cMKBvDhNRbKysCBsjHBIdsk9NlB/9WDwRchgp/0lBI7ttWZfWtawbw5Yxolno3XnISCPxExdKkyIhiyO7XTApvj8+pUqNqT74Mx0nUxi4Q/SzdNrDVxYhMD9AOTuG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=deNC+dcx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0WREWcTL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="deNC+dcx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0WREWcTL"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 752247A00CC;
	Tue, 20 Jan 2026 15:18:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 15:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768940289; x=1769026689; bh=uf0Qk2K8m5
	BX0R/aBHcL/E8U8k3y8fgGcfcdaSIzRjI=; b=deNC+dcx1Zs1d6qOjo+us4Q5UX
	WYNPL2IdrwJfyQQ+jRgX9u5ahDmx8GkzkFJxB27Xp7NVWRoWPWogYnlShv+ofkM6
	sUKKZmSH5eo2BUfRXceifqxnardbM7vXs/2M59ZDAgA/P2oxk2Zta16zxvXtXeRN
	hggDNUjrZ7snXRfvF+milePMb9ZTh2eZyK2ptAL87T1/b3M9uWxhrQjuBQzVuME3
	LhRobsz7Bp7/8pxLQvsbOYEQADGXRldmMbY3nmro4z1CjAtdYvhLSGYmS0GmkPug
	nw91ImFX8OdfMDhOEbZ2h30jyKRV/18K+qbwRHT7Vn9IqPRDqwkG04IDOd3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768940289; x=1769026689; bh=uf0Qk2K8m5BX0R/aBHcL/E8U8k3y8fgGcfc
	daSIzRjI=; b=0WREWcTLk8LcGa9TTq3MlgeyJri/fNOW5ilQyDw5QB8I9M29KAo
	1Q/orHIEbsWNO/OnZWo1Md5h4oA0V8p2yKDwAt+Pkta9+sjdEmTB6D+7jjx6ETIu
	PCiXgTnzBFapkbEX2lxMat00ey7Vllmdx+bedxDpVZL9D7vNOXY3iLcznDT85pv4
	stL3GRa9Vkb9aP7lKWulhZWK6x7Gvn10nA58aFoGV/gEdxSJnyoZCBcxCTqKGzJz
	St5QuJiU9bTjGB16JWQMwOM6KVv4xZ9KmW8xubFoYaQztC91HZ8SngXK5RlPyiTs
	2rMaEy+o2Ie65Bl+P/D70L6qD5NMf11ODsg==
X-ME-Sender: <xms:AeNvacZTXVFL3N4-NB9oU-0MDWrWHDAuIrC56RMWMFT3qbPHuIQIxg>
    <xme:AeNvaeR1tYe7p8EeGO0ANiXXkSxYKPSTqVrEJ1Zp-mW80IeIjgm9PpkFCUr7NZjBV
    hzsMEf6VgkLBlpj40c4IuTkCMjTQA83HsoigDzZfA50iywAqsS7Fw>
X-ME-Received: <xmr:AeNvafSccNlU1K2zsE9oezFmmao2RoKOB6HgjPGdPCxu9zL_3-L67eWKPbNIM78zq3tRQshElukjEL1DpvuU0scL4HDAeQtENaI2Nmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AeNvaSQ2h5DgaR9ADFo3Mb8H0xBksE2kY7kjhVfgpG8HSGnu492Nkg>
    <xmx:AeNvaU4ifFr2O_SsGRvyOSWU7J3sGjITTgSVidkUwzfWOfzfGibf5A>
    <xmx:AeNvae0IkVW89NMfRaL5lxOko3R0YIOU_gWgINJhUHBg4D6Ch8-vvA>
    <xmx:AeNvafACe9N91wfEOhPrB3oWBdtQtjNiI1_SCrhVPEPfK6riDAPj-w>
    <xmx:AeNvaazFN20SnPM59JdyDPnmJEVgjVKQ4brHFAPim2XcQL1NOcl5flao>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:18:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/4] remote: return non-const pointer from error_buf()
In-Reply-To: <20260120193857.GC3295894@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 20 Jan 2026 14:38:57 -0500")
References: <20260119051858.GA1991308@coredump.intra.peff.net>
	<20260119051945.GA1991523@coredump.intra.peff.net>
	<aW3QVkpPPHjKVNLC@pks.im> <xmqqikcx3z5x.fsf@gitster.g>
	<20260120193857.GC3295894@coredump.intra.peff.net>
Date: Tue, 20 Jan 2026 12:18:07 -0800
Message-ID: <xmqqbjioyr5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jan 19, 2026 at 04:28:42PM -0800, Junio C Hamano wrote:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > This function signature is indeed quite misleading, and I'd argue that
>> > it continues to be so even after the change. I guess the intent is to
>> > make it a bit easier to print an error in functions that return a
>> > string.
>> >
>> > I'm not really a huge fan of this, but it's not a fault of this patch
>> > series, so let's read on.
>> 
>> I concur.  "If they do not return any useful value, they should be
>> void" was my first reaction, but presumably just like "return
>> error("message");" is a handy way to give message while signalling
>> an error to the caller, these are used to return NULL that signals
>> an error?  I do not offhand think of a good longer-term direction to
>> improve this one.
>
> Yes, that's exactly the purpose. I don't see many changes that could
> let it still fulfill that purpose, though perhaps one could argue that
> it is unnecessarily confusing for the small shortening of the code it
> provides (and ditto for error() itself).
>
> There is one thing it probably could do: return a "void *" instead. That
> would make it applicable to a wider variety of functions. But it also
> makes it even more obscure (IMHO), and this is a static-local function
> that is only used for functions that return strings anyway.
>
> If we wanted to make it more generic (and I do not think we want to), we
> can see that it differs from error() in two dimensions:
>
>   - error() writes to stderr, but error_buf() writes to a strbuf (or
>     nowhere if the strbuf is NULL)
>
>   - error() passes along integer "-1" to signal error, but error_buf()
>     passes along NULL
>
> So of the four combinations, we have:
>
>   - stderr / integer: error()
>   - stderr / pointer: not implemented
>   - strbuf / integer: not implemented
>   - strbuf / pointer: error_buf()
>
> One could imagine a suite of related functions: error_int(),
> error_null(), error_buf_int(), error_buf_null() that provide all four.
>
> But I do not see us clamoring to extend the pattern further. ;)

;-).  Perhaps stop being cute and doing

	if (... error ...) {
		format_error(err, _("error message"), ...);
                return NULL;
	}

without any magic might be more appropriate for a file-scope static
that is only used for a handful of times?  I do not think the
situation is bad enough to warrant patch noise like this, but it is
sufficiently bad that I wish we wrote them in such a more trivial
way in the first place X-<.

