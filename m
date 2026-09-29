Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018D51DDF5
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699311; cv=none; b=BfUiiUrhy889RsHJO0XmLF3uvMTP963d6a61AHTMlgkJ/C4hh2GSKohTkMNx5gTUwrf/efPvzjSHOqXJLQHzHNICfFXGb2Miv2cjLFrlDDtYMqkqvBwXkMSDBo8EQt5SAziVtx9P5Wv/AhE4XherpeYshcTzq6Pqqs5R9LO8xFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699311; c=relaxed/simple;
	bh=0EY09lQWP/wi3Wy7Y6ywlRdq2sWvdnQrM8j1CEgerAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A447X18WPxJK1zIbky95Lv6Zkexx5O872vh3PeMqN7fQUODB6ffBmINCLwv1cPAwdbBuik6N6L5z0h0WuveTMOe3taxj6GVe2yPBNzvLqoVdWIaOYJbHxiqQG1mANjpCgxCb8unSlCecJuiWdjY9X+HONCXm+knR+TBqbz41ANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nPgEKtqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6WQweX3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nPgEKtqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6WQweX3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 651381D0030A;
	Tue, 29 Sep 2026 12:28:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 12:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790699308; x=1790785708; bh=Bgk75Rsdyb
	txlEiUvQ5ZhilWeWTsBbL5ugFrhPcCHXA=; b=nPgEKtqeP8S7uCSjyig8OBJYoD
	FCHsHY4NcpJzDJT3ksB/R6X/CDWM1ZeGd8Yx1Q8ov045IRYiiZ6gsKbizti/qfQi
	yaGS/EF5v5o0k2VpuU5Ydn1b6lfZJrIdHCXXDh1uIszm67/a820QMuvlV7qzuk27
	aBRwjF4elxxr92YKseFTMxkLzJSEPYFplY06HtrH/PSPkhfJYGQ2tvdEclIlAPQb
	TgsxNjcPpRvU62dZZRL7ARr518n4Sk1floOr68jgi9iro5qIqkb7are2+OL4TZ8H
	Ahcs9e9ZJslWhYUzSfAaYSoj2MZeAAjIZIEl/k+7pWN9JdlUzS/hmzC7RDqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790699308; x=1790785708; bh=Bgk75RsdybtxlEiUvQ5ZhilWeWTsBbL5ugF
	rhPcCHXA=; b=i6WQweX3QL8nwdMjOM9mQyzmnD0ykUzn5VP5LidVH2BY3Up++3M
	pHBu9Fs5sn2a6sol4U1OEs6TwI19xNocw4Rai9PklQCfR24JQMHh5Qk7suv76QTE
	1/CNPl+7aCfwHc3uAwOzHX8dyKx06Bac9BFscjkPUr+fZl6WNIW29Pmrb3mOcRAI
	8L1mzLMLRTcnEFFSNZoyx4Bped+t0dHchVxS+dfi1iKQiVzgJ7DVVDUSLKU9S/2O
	fj7vQpK/AE1jNjy70QNTLTQINZV1YNZtqoNQ9VaXj4N11gUebRu2aGsW2/LWkTkk
	fICXt/nXAqc0Kc4h4nOGABXy/F+2GyOp47A==
X-ME-Sender: <xms:K-e7ahArKL9G34AE-DAotM9tOb7M6FmUlYUHN7_9n1GNCxN89xedVg>
    <xme:K-e7ahy6WAxav45wfwNDZc_G2XGPrFUXOtwKgzz_Dd9k2aIM4GdhWMic0Pe5FEBEE
    s7dOeB0w2bj03TuvNsQEKT1SnyCuBwoIoYCHbVK9B2tseXe8rqO6bU>
X-ME-Received: <xmr:K-e7au1BEL5JMlnOg1Nsplxj4VAPAahBOeVO3yvYwasyEXkWc3bals3-m8WyLrcDO0qv38U7I-MVYBfTyBoUTyCNaFzr2z8C5Cek>
X-ME-Proxy-Cause: dmFkZTEMngz1Q5UEB1Ku/BhoNJv+R9UCd1PlwWkNFb83rJ4G2xJt3rrqXMkyqByYXqbF0F
    icbqrE84NqgEE8jkXEj1SoFTaJIpdLZZaXxBmbsbh5F2SB7ElUYxzrZjuJFsni0pRncPHB
    SKmliDouz4++9QeK7k1pjUd/eZER6no6ZZEVjjjt7Z0RzWFRkX9rr3jo4wVGguYTA1b6wh
    00nEuONIOkkJDeYwLabEdMYFeSIaVABG9/TGb7rDluwdMmZfwJNnRsU4rUJ4f5x2RF4QpU
    mQOUscz+/1cZiRvp0VOk5jIUJmDGXjrAwC/ln8jeDdVAvnA2aGeD4akJ+xKeoqW/6b4FG9
    RSeRXq9NIvaj5kTAHxbXwy0oofWfy2Ohq7BXql8s87JmihQ+TNCJ+2fZkNlvwo9V9ckoIF
    5lZPJwbMykGJyPQTIEV7yXB1M1XKCrPJlgTdCeeHJbI2XcwC9r3uNN5RvnuJ2ZNT7DFbeL
    hkbewenEhqMP9wfCo7bvtgufUplUV2OCpbaLz6RcgDDH+IbDVAoOHSaCr4IQ7UntFRANcB
    Dz21rEvYsxSw5DCM/NSx1JSPKYpQ8Y7QjqYtwl2nribQY8tm6Zaba5nNcWD/PWvnXwPZLr
    cKpII+uNkgQ4pmphGXNmj3SczEgsn31Wcxov+AVPEGELy+kiZjnkNxhBKvSA
X-ME-Proxy: <xmx:K-e7ahxuUmNya44oXq6SRr4Hc3U2oIb17Pv3qfw_1agMe7zrf_oh1Q>
    <xmx:K-e7alHeimpRSoWx62eKeym9v2FgvfP6u6kmri93KWPm3LaedHPbnQ>
    <xmx:K-e7akbO1qM3JjC4910BqfVgImKu7TnmCLmNRvuU24gf4DVD3DeD1g>
    <xmx:K-e7anATKxCRouCs2jIQbC_Riz90Z5zUn80DQJOe03Rh3lv23Z3rPw>
    <xmx:LOe7aqgpkgVwjB6bPGsCyhuN8CRG1Z-9vdKXcl-QMfgJt5WDnO8I5YLY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 12:28:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: git@vger.kernel.org,  Niklas Cassel <cassel@kernel.org>,  Bence
 Ferdinandy <bence@ferdinandy.com>,  Philip Oakley
 <philipoakley@iee.email>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2] doc: remote: say that it only affects the local
 repository
In-Reply-To: <20260929120010.840402-1-matthias.goergens@gmail.com> (Matthias
	Goergens's message of "Tue, 29 Sep 2026 20:00:10 +0800")
References: <20260927055040.2441925-1-matthias.goergens@gmail.com>
	<20260929120010.840402-1-matthias.goergens@gmail.com>
Date: Tue, 29 Sep 2026 09:28:25 -0700
Message-ID: <xmqqld8khviu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthias Goergens <matthias.goergens@gmail.com> writes:

> diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
> index eaae30aa88..315100409d 100644
> --- a/Documentation/git-remote.adoc
> +++ b/Documentation/git-remote.adoc
> @@ -28,6 +28,11 @@ DESCRIPTION
>  
>  Manage the set of repositories ("remotes") whose branches you track.
>  
> +`git remote` changes only the local repository, i.e. its configuration
> +and its refs, and never modifies a remote repository.  Some subcommands,
> +such as `show`, `prune`, `update` and `set-head --auto`, contact a
> +remote repository to read from it.
> +

I would not have minded having additional text in descriptions for
individual operations like 'set-head' and 'prune' that might be misread
to work on the other side, but the description above is very clear and
we may not need anything extra.

I also like the second sentence, mentioning that some commands read
from the remote.  It implicitly stresses that nobody writes to the
remote.

Thanks.
