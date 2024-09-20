Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B111862B3
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868452; cv=none; b=bemEuybbR9RWe3l9/amvK0/HT/tg5XKeJyHRmSESIRuG8HvGNJrblImcztfTwheEM44FcFz+53HpBdzp6ual2+kIEcS78Q+VKJByOeTSnpvLER30cgH9GF72BoRX5i/zY+sRc0Ys1XVuI4HwIO1CtQR1Wsa4qRW9NZXTppPl2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868452; c=relaxed/simple;
	bh=pnsjx1lGkCjMDhVvKLELUGTZ+FnrTVeL8SpL7ONyQ1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLiB8BaDGYO7S5o27/YlfC9MHoKrnIQYYiQbUOStfMqzo+8jjGWjqn66HF07/Sdqm4rT5l+nXiKnR6/1YX1nfaSe5gzs9Q7SO7R3Q4ZfkWzxXA9KTlWEqGkxHlrHdhypGixr+diuLHFU+CycGNuJQN7MXQYHGz5t7b6aGdHKQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xFKg0bAK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xFKg0bAK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B0D831FCBB;
	Fri, 20 Sep 2024 17:40:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pnsjx1lGkCjM
	DhVvKLELUGTZ+FnrTVeL8SpL7ONyQ1c=; b=xFKg0bAKBnkB/tm4JQ15I0nQEzHN
	yNKA7mNK8hvlQcMhDdTE0BOWl58CZf6MV8Yb0Lhln9HX7rEbVd8xbrp/LWyJ04vN
	YPm45qe+sEqIXPRNzbi5Z2uRmdDwoAmFh2a7nvS4f3cvcYV66uD9ZJWR/OKfuc/A
	ixRR61rxaRZ5mrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A88601FCBA;
	Fri, 20 Sep 2024 17:40:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C9EA1FCB9;
	Fri, 20 Sep 2024 17:40:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH v2] ci: update FreeBSD image to 13.4
In-Reply-To: <20240920201409.8723-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 20 Sep 2024 13:14:09 -0700")
References: <20240920201409.8723-1-carenas@gmail.com>
Date: Fri, 20 Sep 2024 14:40:47 -0700
Message-ID: <xmqqldzmdmw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 00599EE2-7799-11EF-82B9-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> FreeBSD 13.4 was recently released, and that means the version
> of the image used by this job (13.2) will be out of support soon.
>
> Update it before the job starts failing because packages are no
> longer compatible or the image gets retired by the provider since
> it is now EOL.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  .cirrus.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

> diff --git a/.cirrus.yml b/.cirrus.yml
> index 77346a4929..1fbdc2652b 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -9,7 +9,7 @@ freebsd_task:
>      DEFAULT_TEST_TARGET: prove
>      DEVELOPER: 1
>    freebsd_instance:
> -    image_family: freebsd-13-2
> +    image_family: freebsd-13-4
>      memory: 2G
>    install_script:
>      pkg install -y gettext gmake perl5
