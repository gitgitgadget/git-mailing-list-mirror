Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB9339395
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206219; cv=none; b=OLa27NQ/Su/j9/+08YBxB9XF3fuyFJ/cBXEQwjmIR3IokQMdpm8NdWyGibTSNGOQOBVukPnHXuEuaqbsCqV+JowNF2K+7mm2haWgcJbfncplLJw4jDnVBdG5RKrjI6UQbdzPExfg6f2Tdj0k4zgOFQlLvakW3TcaelJ/6UgAaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206219; c=relaxed/simple;
	bh=Duyva9Ia6T41YAgxse/t2aP0qLbn1gXaNF6FQV8XteI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mS7U19i7UQ1wQf91qyx1pMoRbV+VCS6AcrhvQl/VpXHMsVT4UyifhMvLnSVFTHL4gDLZN/BYVL28PlJ6PacP6/8QeNOkPez+DvblSZnFhFr5l3PnWwG1zJE4wKs4euOOrdQN3rSfZHLg9usLm0mfD5yzdsTjS5GkK2k8cEwY1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YHQamAP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BFrMkWzX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YHQamAP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BFrMkWzX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83E1D7A0050;
	Sat,  8 Aug 2026 12:23:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 08 Aug 2026 12:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786206217; x=1786292617; bh=l/ehOTb5t0
	C64YAwQM56QtVYsUSBYUAo3gTOtQsXnck=; b=YHQamAP4WgnjMSLpCukwAuI5/M
	DlQzy1KDt042H6wPZV0b5yEtQIO+N7Asy1oVcsKzhU7DXQcLxaimU1qqgfwyQecq
	FmXRNvYA4UWND2+zBh96rKwUWVAqu5TtbhARkJ69P0UBbvNCkjjtFMHwOUr4wYa2
	jSeIgGAQgsqyCHb3wbc+UjOHEyYNPH9r0zr8mnq1eGNiTq5X33nCbuOVJ7/sCpq5
	XbxPsZ8SCSrFep2oLbYhyl8hXKHiIgRj/QhzuHvOkvWMpiYLZQ6kxwYiICpXu555
	gWvXy7eeE5bWMPG9Mn7WOxrAzeNSH5uWf1ahEY2TNJ58yZT+od7B18yPBXew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786206217; x=1786292617; bh=l/ehOTb5t0C64YAwQM56QtVYsUSBYUAo3gT
	OtQsXnck=; b=BFrMkWzXhcKDoTkbi4Ko7DKlqcyWNuT9M5Oi75fKu/+anQrEYQm
	XRVxSOFnwY743/0tfmgIFiIQqrR6qhHyKEO/+KBFefUN5/YOKb3olRw/tCi7r/2M
	+9ue+lUTb9eRbYtFwziXqjHkMG0wmyKbV+hL0j/fghyIb47e5XSg3yYV15TcGgw3
	/1Cptzvf4s8ouENwJ+KE8wLCXasyonmqXZxtiD8kcIh4ApJMms27f1OsjsPXLxYi
	z1shkz/oXM+boBRwWGfEZTth0KAozT0wnrQhEfYq3hjH1L0aL3IHYwo77fdesI8a
	jMqf4dDYdGyjpS3B38bz5Py8bdHs7EwbKXA==
X-ME-Sender: <xms:CFh3aofJ9IP9DL5rsqwlEZsDugcRoBfMXkkTIKHHNQ8EcgSCn3ZUtw>
    <xme:CFh3anHt2n3oCJAk1z6SAKcVjAWGEGpNC_p2w6X-r9T0ZwFnE8ypygBsjbiIH3oBV
    qxQ0dQeCJ7WMDteUDUSWV9H93bJv_iuukY2yWHAbrKSyyaJDGirMtA>
X-ME-Received: <xmr:CFh3apRUQzfmZAj6-BCRnn9WdGAfEJ_qcMmQhvITvb9jZ23qbiaI5Q9-2eiunUnf4pCfHEnDsGLjtt3PhalFH50Y48HJFckUDw>
X-ME-Proxy-Cause: dmFkZTFqHz7fY+8jJVlw6Hke6mOQmR3QO1IgcHz26m0sXJeyv0eRENsKqMR5xK1FZ2NgsV
    25oaSopW7DCIS9KJjP9gAIFA+ltuQv8dWygyOytdtYShSdOwXAoloAjDqj5W+HweYZr/Yp
    O8V+D+vFKGxI10xN2pEFRTRZ2pMvCB5ha1zz1XXehbrQCbrzVrKM/x7Ct+nqjpwUw2MrwX
    Va/R8LZxd2dTxZEv+9ybgufVB4RcCtnDROWdCK8Xuoi11Fckk5gjYnYdade7uQR079ofX0
    hm487arh+nj8Xqmwjd65h8A1Dam7ieHWcXnw/btRII11+dQ+fbD8uqGi1m7EKqtrthfUEQ
    nDhmmc02mV4DXSJvY6bXDhcuQO9ddVAkIFrFPGh5AzOac5BEtHZo2XaNpOwwbNiAqczfx1
    d7Et4M78JqJidaTq64kh7WDoWVJyc41HBcphBezyjpRmaX5aoo14ifJzuCPQYAk88pBWQP
    EpIFrxJeqEAbnJUwmSFS5oYZInpuj1z8FQJApqDPVD8KS33BLm27iqKoSeIKekoCuSEgK7
    kvAyqk/dcKYT+NZWEEklOzVj3pM7heyeQm4V3N+iA04EoUNDRsD0/04IYSJL87Vf+8CRNB
    VIZvPE2PbbgHoBje7vFxTw5FMP8iC43ikWoC8VhXFR0uRXqHjpL0SqfjCfog
X-ME-Proxy: <xmx:CFh3atYqmNcOhEk2UKkitQss8yXzSYRX-9mXsThDWxCSs1gEG-tVvw>
    <xmx:CFh3ak03MKUISxq13-MCOVeKNl2eyqVm-Ht9lgYD39MZAC7fPwn4Ow>
    <xmx:CFh3agq2OTHi6g_VhxJ75JVTnnYZ8DAjzm3Ps9ehvBIa5C94pAPSFQ>
    <xmx:CFh3ajNlI8SkAvy8YSHuoCbh39oxLX_swDUkInR-4upWrtodTXJzUQ>
    <xmx:CVh3as3hADyDc76RM3hSKVqLrXEnYO5geAVPJH5Q2kM0JkDZGPp7bLYg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 12:23:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ted Nyman <tnyman@openai.com>,  git@vger.kernel.org,  me@ttaylorr.com,
  ps@pks.im,  karthik.188@gmail.com,  sandals@crustytoothpaste.net,
  avarab@gmail.com
Subject: Re: [PATCH v6 0/6] packfile URIs: support concurrent downloads
In-Reply-To: <20260801140255.GC2041176@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 1 Aug 2026 10:02:55 -0400")
References: <cover.1785047139.git.tnyman@openai.com>
	<cover.1785111375.git.tnyman@openai.com> <xmqqcxw5o4m8.fsf@gitster.g>
	<20260801140255.GC2041176@coredump.intra.peff.net>
Date: Sat, 08 Aug 2026 09:23:34 -0700
Message-ID: <xmqqik5kbmyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jul 29, 2026 at 02:41:51PM -0700, Junio C Hamano wrote:
>
>> Ted Nyman <tnyman@openai.com> writes:
>> 
>> > Changes since v5:
>> >
>> > * Split the existing double-close fix, HTTP 416 handling, generic
>> >   concurrent-download fix, and Windows sharing fix into separate
>> >   patches.
>> > * Replace the FIFO-based concurrent HTTP 416 test with a standalone
>> >   completed-partial test. Besides simplifying the test, this covers the
>> >   non-concurrent interrupted-download case directly.
>> > * Keep the final production code unchanged.
>> >
>> > Each patch passes t5550-http-fetch-dumb.sh. The final series also passes
>> > t5702-protocol-v2.sh, and the overlapping-download test passes 240 runs
>> > with 12 parallel stress jobs.
>> >
>> > The v5 discussion is at:
>> >
>> > https://lore.kernel.org/git/cover.1785047139.git.tnyman@openai.com/
>> 
>> Is everybody happy with this new iteration?
>> 
>> The design of the re-download feature itself, as far as I
>> understand, was favourably accepted from the earliest iteration, and
>> now the CI breakages were corrected with the latest iteration of the
>> tests, so we should be in pretty good shape, I presume.
>
> Yeah, sorry, I hadn't had time to look carefully. I just did so, and it
> all looks good to me. v6 splits the patches in a way that (at least to
> my mind) make the trickiest parts of the logic easier to follow.

Thanks.

