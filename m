Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4063917993
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738539835; cv=none; b=e7PAW4QQHImWZ0Ymz+xZ7qazwQL3N2CFra768WtLyinOTG/xzvGf7uV0/FfIcD5qopCssxNdD8Dll8yPkPzC+GTnqm3U9bipfqYawLIIKJ2eKd+CrVbCPcUEtPfsJjbUNtprhfWLcBGS1Liwc8fXmfNYxdDy3BG5VXVFIALLGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738539835; c=relaxed/simple;
	bh=gKaZ71ztcY/Nm2qoLbHiqkFj4s5WFz6GjAhhV1lUfJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAkUfj3e7Li0SDuHxkCrBKIlr4n3cF9xqYW2awCttUFvIsqwEndvMhbOSgn1dfA5fiN6/4v/1uDhCLs510ROsc0SmhM2QCDK4SHZ52ax1v+3xLcBtXuznOxafo4kahcxP9ECJOaUhoVQG0SepsBr3VVogilK6oFhk6bz2upjZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NHWwqRir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1yj7hDS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NHWwqRir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1yj7hDS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 24B7D11400D4;
	Sun,  2 Feb 2025 18:43:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 02 Feb 2025 18:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738539831; x=1738626231; bh=Uu6PZobjk1
	Ugb9JVm+SYmEcnSmlBPEikbOyoyZX4aas=; b=NHWwqRirOzKTLZujKwpAqfzYLl
	XI5GLsOdOi/eql6KYup0lZPunTM0HHur9RUtE5TaTXEpvoLfJt7kYVLu7wG+OWyc
	lSlqaciXqpQay4GIVQyhjnWWHSA+JkcqMmdQ3/5SKbY81GZE+3ke4jsdpGw0zBDA
	UIXfazlsMmX+TtbwCzyzBFz/gBAHb2C7ASLs+AB+0vsl5G/w0re8lU8BipHce+5v
	QGBfvT+qAAMWvREg7AQOVCoucLq5sZ/aLjpYyffDL40hRA0BSITU+bfJD9iynzfX
	Vdzs30VmMzGBxr+kWm/pdbFC5pjLK/8nIP2jVPi4I4a1udeh9P5b1vY4WE3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738539831; x=1738626231; bh=Uu6PZobjk1Ugb9JVm+SYmEcnSmlBPEikbOy
	oyZX4aas=; b=f1yj7hDSx83tQb/LBAQQ0cmPRUBd4wpAERS2ycpsXuSmqxeZlyQ
	4jHLorU5q5h1zGqhOwnm26vrvgFEopxelrR3h/Tvh61tpP7Z/HvVERjQJT+wC7kz
	cb8KWnuy0IMlPhdK97a5uQ60oHpLT6F6rHCnn76XH2A/RWZNsFXN4SEBd7g7iONz
	RzfQsvTlGATmrM7K5ZRuExMdPmpEuH3Vqr1vCxxCJoqVAO4amdLFtO9UPWyiqm6W
	XlKYawQSy3MdQ2pI0z7t+0xxuJ9taUp483aI6eTPce8w6TW5+5ZwdSkEZ+sN45FM
	H+FKYFCeL9hV/69VqOqneYvZU0aX12uP0hw==
X-ME-Sender: <xms:NwOgZ0yfmSLqmllzzwAd6WTyOjfzPUR_So9QR6QZkTOEERZVYFvyHA>
    <xme:NwOgZ4Q3jcqdSJjIp4tftBOSXJGVvb5QFPcFnE-TwdV9JDCXJx9XJMhJkm2S45Zdf
    _MLKAX0frTiFMOt3w>
X-ME-Received: <xmr:NwOgZ2WTEbtfYyS91v5cwvljfpJ2i-3NfIwS74efK-bn8orEepCPjlyjt7-y4eAlTZnxIVHecHCDFzDDgYAotyi28rQwG-3GElqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhgthheliedthe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrghkrhgrvhgrrhhtthihrghmsggrrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NwOgZyjs5yzrydwKDyxOND5SB1pjU37FkOO2gxjRRkuKTc2VCEHUpA>
    <xmx:NwOgZ2BBDx767LpTiqN9fi0I2LYveCd9LcKPPXC87Ke2Uh8lvu9UBQ>
    <xmx:NwOgZzKyoYZ-EqSUV5ou5KtenhTQW6oChncMSqH3uEBcrixqQ1rgGQ>
    <xmx:NwOgZ9Bcp63G1ziPimE97paCeCWME3oQFTkrsNPHVe8hpGnGNPXIzA>
    <xmx:NwOgZ5-1OUT-cxgssnSgKbw3u0hJ-cL1Q3vrQLxO0WOeRD4-dEskqcO0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 18:43:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: ambar chakravartty <amch9605@gmail.com>
Cc: git@vger.kernel.org,  ambar chakravartty <chakravarttyambar@gmail.com>
Subject: Re: [PATCH 1/1] t5401: prefer test_path_is_* helper function
In-Reply-To: <20250201071210.30509-1-amch9605@gmail.com> (ambar chakravartty's
	message of "Sat, 1 Feb 2025 12:42:10 +0530")
References: <20250201071210.30509-1-amch9605@gmail.com>
Date: Sun, 02 Feb 2025 15:43:50 -0800
Message-ID: <xmqqjza73oax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ambar chakravartty <amch9605@gmail.com> writes:

> From: ambar chakravartty <chakravarttyambar@gmail.com>
>
>     test -f does not provide a nice error message when we hit test
>     failures, so use test_path_is_file instead
>
> Signed-off-by: ambar chakravartty <amch9605@gmail.com>
> ---

Much better.  You do not have to and you should not indent the
proposed log message, and you want the full-stop (.) at the end of
the word "instead" at the end of the sentence, but other than that
this looks very good.

Will queue after tweaking the log message.

Thanks.


>  t/t5401-update-hooks.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 723d1e17ec..17a46fd3ba 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -64,14 +64,14 @@ test_expect_success 'updated as expected' '
>  '
>  
>  test_expect_success 'hooks ran' '
> -	test -f victim.git/pre-receive.args &&
> -	test -f victim.git/pre-receive.stdin &&
> -	test -f victim.git/update.args &&
> -	test -f victim.git/update.stdin &&
> -	test -f victim.git/post-receive.args &&
> -	test -f victim.git/post-receive.stdin &&
> -	test -f victim.git/post-update.args &&
> -	test -f victim.git/post-update.stdin
> +	test_path_is_file victim.git/pre-receive.args &&
> +	test_path_is_file victim.git/pre-receive.stdin &&
> +	test_path_is_file victim.git/update.args &&
> +	test_path_is_file victim.git/update.stdin &&
> +	test_path_is_file victim.git/post-receive.args &&
> +	test_path_is_file victim.git/post-receive.stdin &&
> +	test_path_is_file victim.git/post-update.args &&
> +	test_path_is_file victim.git/post-update.stdin
>  '
>  
>  test_expect_success 'pre-receive hook input' '
