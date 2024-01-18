Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCD1F60B
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604019; cv=none; b=o7FMtGnTPMa6WkzPfxSPpNBbA4nitkOAellwio6ZnBE5cHRYRj8WHwXLx2S7TAJcNYbqoCCRk6FDy/Iufa2BuDarjtq0ds/WjhKRO5CZiT/VMv/kbPiD5J/XRsNFF3JNAXL76EkfoEoXqhCIa2kxZRorvQ3A4t32b5cd/EQ04jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604019; c=relaxed/simple;
	bh=hstnUgGYoAGf00Yr8N/tZijnpYo9xkOOr4f2hIOYp9Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GFTXtX4USPeaj7o4tZE0X7cLVbYhRSYtrEDWwC/QwVST3zZ6EV52iwuHr+lqsIjVgZp1nsHVvvCg7bb9V+hYOD+jd0QRNqP+stSuxm4AjbuSa7+PHtZ5EbMddu3ko9Qw5Tbh3DFie/PyDPE2oLuud/+VX4ki9IcImBcPqwIeZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KCXXuKVP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KCXXuKVP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705604015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmv65b/5J544gKSpMj0S+PyGf0jpz2KGD9LWhiGZ3Lk=;
	b=KCXXuKVPwMRg3gKsStiAM7Za2++cTFP/6Hm38Jt0Qg6htr3nvwIsadWCMuPwIVQ/LomZDY
	iMdZEkGsmcWg/8wqtf36mthAd+p5VpKTjeEglWH3XIaM0WNP2z2LomfNEkW2WKnBIWj3Um
	fSnYnhJzcP6GkV8nMbsGNXpmN7XpY30pUSjtXib9gh6f21vuFZzP7s7ezISCoDkL4GO9Aw
	9RQBncMxLrN4bJoNqVG4Ytlx4QAzH18jW3X5eeROHHQGNEqzNo8wo9kvwu22I20vIbFq5a
	LKnvsvxrrILdfIqmLuPkskbdRy8s9UXwfkFFltHnv4et/ZUhNoaBY4j9NxremA==
Date: Thu, 18 Jan 2024 19:53:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <xmqqil3qsdkv.fsf@gitster.g>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org> <xmqqil41duov.fsf@gitster.g>
 <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
 <20240111080429.GG48154@coredump.intra.peff.net>
 <5f322b3e6053c27dda58ef1c1f025d11@manjaro.org> <xmqqil3qsdkv.fsf@gitster.g>
Message-ID: <bfded0571f133ffc1612fcbca1811a43@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-18 19:26, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Perhaps having both options available could be a good thing.  Though,
>> adding quite a few knobs may end up confusing the users, so we should
>> make sure to document it well.
> 
> I agree there is a need for documentation, but we are not increasing
> the number of knobs, are we?

Perhaps there would be one more knob if we end up deciding to implement
support for both approaches, as previously discussed.
