Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11793403E8
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352593; cv=none; b=Ku2Wn7dIKFL5E6jyOETNR6KwvpThFb288a7Q5Fg7P3PGR3RNrwbC2Nog+0Al5NcMlfdm//tDO2618E4IsIT8RDczu04Qf2DVrktilxosd2kHoO6zb1wNGS9P1YEdK/8vCtd8PfE+1zTGTTLBomZFbLJ1VYs4laqBg+ym2s6xYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352593; c=relaxed/simple;
	bh=sMS9s7CrRnUJMtljWqy26qDxGt6Wkxw7k5caQD03GMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LjohNchsuTQIWaMo1TZg8qnRu76I+vZSMR7QRDlGQyAGbUMpNoRHldmB36t1y70Brd8MlNLxi6KWiL1BJmPgbu7Lb7HCpnlZO3e7A1I2lBB2GT6Y+MtuNhDxV+5E/2T1d4E9XS5tB4Sx2IIrdhfB7iAGX0JCq74GdyRd4q9uNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vh3hsnzn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2pYpHcM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vh3hsnzn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2pYpHcM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E235B7A00FA;
	Mon,  1 Jun 2026 18:23:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 18:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780352591; x=1780438991; bh=/o1iwJNPGx
	V/T8CqLd2Z3VxEe4o5bvwh2ik3ZvJzNbk=; b=Vh3hsnznkNMWvubLpDWjtTsK/Y
	RR6iA00NLjVrDRRdeL9o2wTtqVwx9DDXw2sz2K66B9dH/41jUWSWnMeYRpul9/Ne
	33mhVwgm8U+hKqyDg7k5RCSKT8SIpzvxf4tbXVqCRVV/i8YfO4iCmM5AsZjj6EHp
	3vDoBPpzzY5O0x+Ed0rDLbTR71Sv0uHT66pe3e6pWZtwdXQMRddXF+zayoI02rkL
	SMbXIuS7Ul21GfGmJZS9RBjser1xNXjLUG0WgxBtcmxE/Du2OjSio8jvfYiXYhWF
	sW+VQQfyBntxvgHd/7gI/aGrXZLKlHBTbhxlKhwx8RqDcXdQTQc156DPJ7eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780352591; x=1780438991; bh=/o1iwJNPGxV/T8CqLd2Z3VxEe4o5bvwh2ik
	3ZvJzNbk=; b=c2pYpHcM7QBCbh3a8ac1EnHRmcypftmaKz1lKsW2bs75TBQct7o
	E8782KFyLV0sHT5WQEbcpuJEnkNUKmh+DmPEjbC/wBFGDZiyuFt9I9dyz3ho4zvm
	iumdTYlbd667mD9qIqLlndAvGSoLTFmUSbsdlai+DbGs6YkLQRK4SCU2kZ3xc0bB
	kLd3OtkC7cpcP3yc2lFf40Y2XVRttYUmKAWfTbtszU7Z07FDLqnZ6wxPRAuxdoBg
	69cG4dmN3epA7QYK8DHZeYHxpflmXU3kN2KP2jCmBEcRUrlmDYsu5iGxBcfE7pXG
	+3m5CnxwRaPA752IjK/NGdnhEMUuxDvIE9w==
X-ME-Sender: <xms:TwYeaqdiXdVxINheKfC35a_O5x3U3xfIj_916qjsbcmnhXYD61w37g>
    <xme:TwYearPLh-Z3_kCdKZ0xFAPP2JAYYOzYNVmCxD3LRNzZhNxwErefDYf9UDzYjzQvn
    cwMYx5a9QHZSlu_Bh7gzWKlDILGKVe9yybvvz396_x8jQWBCkxa_w>
X-ME-Received: <xmr:TwYeagibwpl6JvFijOwVVPLcPuDHB3d10LRbmtVYFu543B5dN6FPoydpbCbvzVAYicDWapwqYhJh6up5oMVJOaKVL93p0CVXx-e7>
X-ME-Proxy-Cause: dmFkZTFfcpMkR9P4pG8PT0bkga7w6jonMd6eBh7E+e/JlMrXGTS2l/TXfDqNDQJU/5t39/
    YcyAqRWRQPrsh0YNc3FTCFEEATzCTshZ4a2KyHG9uzlCLn5O/aXSNHtIQxA2+UEeQW/V6h
    KggoPgL7PTK2vMjyf9mS7YWyR5STx4dacJJUX/CqKWxD//WnLTD4tAaNQXwdD0ycQEYtze
    q2deN276UBHlU+r9D+/Te2aDQPSL6qYNZaUkQuXFsN0ecuWe5oLu9d22hbVAQlDGUnlznn
    zbe0RnNcpGIPjuyudLKv5zt0wWEyYpeeBoEudXqRAWcPqK6UB23D1PB2ER36hJ5qiGwAf1
    8dHStpyml4e1zAh8LByFz3kaLn6J/xWBQ5haYlpwLtqDfnSMwoCK87Ijwv5g09AWU2xbl2
    GEOIVzG+IrM/hPdvhCHMc9RoH/FG5xNVCgotjkdbYEfz1A4zIYuO1jjQQbnWUZdyakhdxF
    ZD43+biH8IVC3q0dQ2wgt5VQdei3sDnZJDBXTd2ryabzUMBgofGtemzudZGWAEwivSEJ6h
    UpFF9ZSLzqm3kf9L46MI0XbHTF4W/hrtzMj3ELan6C8jBAG0YtYOwhmkRRQQxgsVRbsBxp
    Nln9lCj3zXhZxe2VpwKabIxUcS1u6j6Mcd+S0vRztQJcX34nnGdXZFmBSXbA
X-ME-Proxy: <xmx:TwYeam1ApQO6Sr0AChazrj5XBBl1By5KypmD4noi637pFd_CnatauQ>
    <xmx:TwYeaiiS-5xxoMuZqKkOFBwrcIph0G_WEg7ZA6Ci1pl9GFr-QRAKHA>
    <xmx:TwYeaud445dmwCF2gYGHFNPCdzBFnUGU5I37komzwPMAib4EVlrZjQ>
    <xmx:TwYeatkXWVkxHnl8a9cxWnvIJSNGU1pxcA_Sr43-MmsCZe7ZVo0lQg>
    <xmx:TwYeakjNB7JJW6dKuxWCvk5GbRbl5bEr8HNtBI8Ly6AvmO2VEMxA7xot>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:23:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: Andrew Kreimer <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: fix typos and grammar
In-Reply-To: <7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>
	(Weijie Yuan's message of "Fri, 29 May 2026 16:17:04 +0800")
References: <7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>
Date: Tue, 02 Jun 2026 07:23:10 +0900
Message-ID: <xmqq8q8x3nox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> Fix several spelling mistakes, subject-verb agreement issues, and
> duplicated words.
>
> Signed-off-by: Weijie Yuan <wy@wyuan.org>
> ---

Sorry, I lost track.

How does this patch relate to the large patch from Andrew that you
reviewed earlier?  Is this meant to replace it, or is it an
independent effort that may or may not overlap what is fixed by the
other patch?  Something else?

Thanks.  All the changes in _this_ patch looked sensible to me (and
to my agent as well ;-).
