Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D93AEF56
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721903; cv=none; b=dEsdq599SpVmEDj1f2qiPJywzkKWxzHqz29ZAeINZ/+bYcuqyhqdhJWkz9eYfcLpDHRrlonPgpzfEX8wjfsoq6+xRZ9IF8DcuPTk45s+TAYRontbaybzeIIJhJisDjyTnrJJ2//KQewoh8pMXuVaeAaxc4t4kYGJWSUpLFUMNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721903; c=relaxed/simple;
	bh=ccK4cuCPDRevsu3jQ7tnBsC7QaNEHoLI9sWp2kp1eJ0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Km7B7ADD2/XEawPlH8mk+k7sKNug9m2p1EB//jWwvsfVGg7AeNGflqWRc6AHlQePMdwRPd9iK4rzpf3hKfAhBqVzbBv8yS3PHJDsZ5aS3GkMwIoPJTpCrnvw+jfWfu50b9OjHYVkCCXMurBLXTPIh5Rvw4hWCkBLxwLWNFWDVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ir2XxW6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtB9tsWn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ir2XxW6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtB9tsWn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DD407A0176;
	Thu,  5 Mar 2026 09:44:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 09:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772721899; x=1772808299; bh=ZW4JG59C7b
	wnpr80gsWqGBPMWF48PfpmTmy3wQ+kv5I=; b=Ir2XxW6YIo4HFHD76TUoHvGs47
	zt3SGAICR8tXXksUiVVlLuvz8+A39lOrL6Hn/IxIrzErmB3BxBFjvweevfbnjNn3
	LcTxdH4uHyq6QfIMrU8slJruTb/V+CbCZxN502sgHSyTW6brEmK47i4lx+1MTSQn
	g7Cor7zqBHu//F4sswXEup9O38A2yd9hZ/ttcuSiDYNF6F8EY71XU1i+wZQA1wY1
	gcG2+7ENbv10VvNfHhwYKmJHlZRZD1d5x3ZbhXAdIuYfb/fR06hwdUoqp35LWMay
	a+cVg3FjC9eoH2W0AtFYWh148n7upRH0bCPSaygqeHgtcrf8NAT+vBpTwHow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772721899; x=1772808299; bh=ZW4JG59C7bwnpr80gsWqGBPMWF48PfpmTmy
	3wQ+kv5I=; b=CtB9tsWn4RKmEBBVdpzVt72l5kY+IDnJ09rbZaQy2e0uC5Z3G/k
	WExzl9QOjNGGvh5jmHzO4BliRSqyPInzbDT4Modah8YxoF/IAnq4xlcKN4duOQu5
	1MXmAJDCUme3lRmUaKixWyiHzVnXsek7BCaYn+gKujdk1BzIExIdZoYs5IDsmOef
	mRF4nDVYjVUgd5IA2iURiQDi1tKIMm1ym6mGKVRQbVpJ2fru6VhDTBVpAfeThAsf
	M2cet3Fny4KK6pV3KRVwsFvOBdIwf6dX4phP4kPjmva/Qk9YtpVRK9b/r2efh5RG
	96e0SokW/9g02gFqZzDJki8ed1nYEmTLsfg==
X-ME-Sender: <xms:65apaUKmEVTbucyGHcMuI0PS5o3A2QtI0mofc_YRQCs9fWfNcVMezQ>
    <xme:65apabkNjdnxnq2H4C9uHay98e8CT7U1-A_Ygf3C8cqUbzsVkbR2DLDjY0P56NIWC
    wC9CGxIQ9s7PK025ARdBVScG2v7XaNsyUzJf2R6ON7DPiZfEUYf>
X-ME-Received: <xmr:65apaSEWbaTLHjsTc_jPsIVaRJn5ECE2xc64Gy6T3ouGywICeBZ2CipKfEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkedthfetteeutdehudehjeekgefgueehhfetfeelffffvdelueevgeetgedv
    veegnecuffhomhgrihhnpehmvghtrggtphgrnhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:65apabGVivEexFxWUT-emOjpHUpb_g2KgS5Fwil0kJjh304JbnKEzA>
    <xmx:65apafM9DEL23QuPiNGNnNivEW6AqTpZKxWTFhY_FeA2g66945pvaQ>
    <xmx:65apaaEzdP9MWK0-N8ugzEa8RW4cfBfkXJNEf9kOk4OOt90vVK0m2w>
    <xmx:65apaWOrG8-TnDIh5kjQBP-0IJOna0juar5QrwKA8ETt3cyuesjnyQ>
    <xmx:65apaUuWYT1T_LOzbY-lvSZN-AalzjGtEwLzie_D1AsHugNSMXXf_aB4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:44:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] send-email: pass smtp hostname and port to Authen::SASL
References: <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 05 Mar 2026 06:44:55 -0800
In-Reply-To: <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 5 Mar 2026 12:06:21 +0000")
Message-ID: <87ldg6jpy0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

[administrivia]

    Please do not send patch e-mails directly at me, unless you know
    that I am the area authority.  Initial submissions are better
    sent to the list on To: list, with area experts on Cc: if you
    know or found out who they are.

> Starting from version 2.2000, Authen::SASL supports passing the SMTP
> server hostname and port to the OAUTHBEARER string passed via SMTP AUTH.
> Add support for the same in git-send-email.

The proposed log message should answer these questions as well:

   What happens with version before 2.2000?  Is it safe to
   unconditionally add parameters like this patch does, and why?

> Link: https://metacpan.org/pod/Authen::SASL::Perl::OAUTHBEARER
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  git-send-email.perl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eed5420882..0ac4d634e8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1474,6 +1474,8 @@ sub smtp_auth_maybe {
>  						user     => $cred->{'username'},
>  						pass     => $cred->{'password'},
>  						authname => $cred->{'username'},
> +						host     => $smtp_server,
> +						(defined $smtp_server_port ? (port => $smtp_server_port) : ()),
>  					}
>  				);
>  				$result = $smtp->auth($sasl);

Thanks.
