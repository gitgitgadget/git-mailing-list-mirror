Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA9159594
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567152; cv=none; b=CjLvO8+r3UvjeTt5eLCnhFgHVfKR7Nb56jCtgpLFejsOvpRpl9Sr/s/BabNpEkbUVF2uXif80dH3bZOEdQSxP/RInHd5qjecX1gBml1isP27vOa+t44k8WZNMOjMOvb7ENwhSIsjNOhLpWAn9jEOQamkV/1MzN9VT+hCRc1k13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567152; c=relaxed/simple;
	bh=f6zegFpK2wON13VOv9bt4y1kGRF27sXh/6hAYpXjOIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwtG9XSQeNhaGySdHB2AZcW76cMZ47KyqHpsMK8NV0WB6n8zcCsFzQF7Pq2fwTvgA01YoLthyqy/iK3c4lVQZViUbtJBRCfwPh7FZaqT+rjnYti7G1//RXFGoyzfqJCL9IP3Mi9aVF05f6tR+tbFBw26jQMOOSEcu3Ps24qgrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p5QE3d0D; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p5QE3d0D"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E53151BC0EB;
	Mon, 29 Jan 2024 17:25:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f6zegFpK2wON
	13VOv9bt4y1kGRF27sXh/6hAYpXjOIU=; b=p5QE3d0DF+/stXcUWU5md0TJ8wlJ
	NohKMN55k3WOwE8jd+UMJys0Iytc0uq4n74ySsz0shJxsIx9FFHyR27++MKjm9bC
	0GVqb7TptxTvBnABF9fk03tNjKJqLd1NY/NqRBFPG8v/GClONOcfRsACGwCNA/eV
	4+zjqJ/VneebTSo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DBDE01BC0EA;
	Mon, 29 Jan 2024 17:25:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 451C11BC0E8;
	Mon, 29 Jan 2024 17:25:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] test-lib: check for TEST_PASSES_SANITIZE_LEAK
In-Reply-To: <6447b11b-f916-4079-8936-8d4f6c480f57@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 29 Jan 2024 22:08:38 +0100")
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
	<6447b11b-f916-4079-8936-8d4f6c480f57@gmail.com>
Date: Mon, 29 Jan 2024 14:25:48 -0800
Message-ID: <xmqq5xzbhj4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5AB2AE0E-BEF5-11EE-A494-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> In a recent commit we fixed a test where it was set after sourcing
> test-lib.sh, leading to confusing results.

OK, the reference is to the previous step.  Makes sense.

>
> To prevent future oversights, let's add a simple check to ensure the
> value for TEST_PASSES_SANITIZE_LEAK remains unchanged at test_done().
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  t/test-lib.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index fc93aa57e6..042f557a6f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1297,6 +1297,11 @@ test_done () {
>  		EOF
>  	fi
> =20
> +	if test -z "$passes_sanitize_leak" && test_bool_env TEST_PASSES_SANIT=
IZE_LEAK false
> +	then
> +		BAIL_OUT "Please, set TEST_PASSES_SANITIZE_LEAK before sourcing test=
-lib.sh"
> +	fi
> +
>  	if test "$test_fixed" !=3D 0
>  	then
>  		say_color error "# $test_fixed known breakage(s) vanished; please up=
date test(s)"
