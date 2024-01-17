Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE022EE8
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527230; cv=none; b=BZu4RUTQqnGP0b4WC5g2eqts3mmiRWyBJ9Xppr62lRAQ89PPi6JtgJXLcyx6TKt8Zz0zJgax4acodyYl+F9R8wAlyfv2plJx5VOVuCjGHZs2jMFmE0RHjcvgAV+30KUqO48W08yshCMNC2cIdeGjwusaAww5degsMTIlAnLaFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527230; c=relaxed/simple;
	bh=O0GNFwiQvryLaaPa1mSoQ+BJmYmHZgUS05sf1AtuFjI=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=aAPGFgl6n6OfmVBlj3QVX3dHlS9yY6huAlT6nqs6cO3+0hSj4Jl67NW5NMJGKR/1a/YWlSNh14BB0Tsp190eWyOrIO2R2Kwwf8FB+5t/IH/DwH92XYAC6CrAluQ0WKAJY090OIrG+tOuxyLyYE/WMk9vtla6jA71QPO7t2ONn5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BPxidoRw; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BPxidoRw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EF2A2FBFE;
	Wed, 17 Jan 2024 16:33:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O0GNFwiQvryLaaPa1mSoQ+BJmYmHZgUS05sf1A
	tuFjI=; b=BPxidoRwujon0Md9OQusHn/dNroalcFMhN1I8OPKLZnv1+6J0Z4UJ0
	LeTzBmckz/RiuTdaEr90rETKYJDzsFa1PDL2uXbGXioXt7FANNmK6erIdivxaLBQ
	YIXY6IO68GkJmWUH9g7ZLr4qk77GXFXIT/Rh7aQ7gCBkPa37mjrT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F8D72FBFC;
	Wed, 17 Jan 2024 16:33:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6CAB2FBFA;
	Wed, 17 Jan 2024 16:33:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH v6 0/2] t7501: add tests for --include, --only, --signoff
In-Reply-To: <20240117161421.17333-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 17 Jan 2024 21:43:53 +0530")
References: <20240113042254.38602-1-shyamthakkar001@gmail.com>
	<20240117161421.17333-1-shyamthakkar001@gmail.com>
Date: Wed, 17 Jan 2024 13:33:37 -0800
Message-ID: <xmqq34uvwspa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 13D5ED26-B580-11EE-94FA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> The v6 addresses the comments from Junio, which suggested to improve the
> TODO comment describing the potential bug for --include. Also, replace
> here-doc with expected output file for better debugging, as suggested by
> Junio.
>
> --signoff tests remain unchanged.
>
> Ghanshyam Thakkar (2):
>   t7501: add tests for --include and --only
>   t7501: add tests for --amend --signoff
>
>  t/t7501-commit-basic-functionality.sh | 98 ++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 2 deletions(-)

Looks quite good.  Let's declare victory and merge it down to 'next'
soonish.

Thanks.
