Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67B22D4C3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453559; cv=none; b=nzcIiGCq70o4J7/66RopAdgfM7zR/Og6AdvKxnCTAqZBI3C4FYMRFK5WrG82JRVgw+8z/0IFCyWZmcxcHt2yHdQs2ZJnnA71vjtmU7TfjoCDuX7CjaLA/QHtzfhRBOX5KrBBOFyjByJjDCFURU5rb2eg0R/mOC5X2m3N8gCCFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453559; c=relaxed/simple;
	bh=54PsCTWw3PHJMAGTb/t6ETCev6a+UmlgcYDyZbAHEsw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IwVjN9R/LFwQ0oc5OjQYlGbbHj4Shu+r9uREEL6Siv+klBSAY/WYxs9R5C//9fXdJrkgoM24vCsl3ZE8lbD/gh/R5n8G0VuUpXwp8zcvdGh+FctA3jDhqp23ju0pquYgbGxl3tPm4R/lU2C8mBrEfXCnJ2L2yxgM8NwEHchB4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=buOxBv3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHx4u9Tw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="buOxBv3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHx4u9Tw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B51B21400167;
	Wed, 25 Mar 2026 11:45:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 11:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774453556; x=1774539956; bh=v5YKsVwmt9
	Fxy/jimq8nftYpcOoTbUCuiL1H86cHCgI=; b=buOxBv3SXn3h7z2HofDBXdqOla
	EwCIsA9tHWXKUq7z6vPRM7hv6iIA0pcoArILvTVh4c62q0SSyoyU79yeZEzQR1R0
	MthBIrmThdgYL343lE8Y/fsKEv79it+fqlihgFGmzOdMC5zCjSabSxb97s37YyvP
	whQw4quQypOWsfpuX+J5xmwM7i+A+rS8GXt19b2HvfLp24t3GYkD9CVg3Hz0FSlP
	BQdQCWtnoSDmMVmpYl6Efp7JwAGSTvD8EgTwYWi2auXQ3vo8xyFezg9JEd+hXvbI
	jesnaqKkZTp7Ovw7oy3/MMQLt2jA7fjG500zjy4FHakjvdJFTTXa/vhYAMxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774453556; x=1774539956; bh=v5YKsVwmt9Fxy/jimq8nftYpcOoTbUCuiL1
	H86cHCgI=; b=PHx4u9Tw6zq4Ymx6RTh5JtPJ6A8UIMKCss4zxNIxvra4VTJuXTo
	fDXqNupg/b5/rLY2qu+HXzDCaIu6LmQjwxQF1qOHrqCdGQIrkE5KCKfHaUk/eynM
	NEiHzuqUzv6WRRnwc9rRuw05zdjDPykh+sV6FPlxTCPGJqXbtlJSykQ50cq/rp37
	Eig0gp7q0xDDaren9I8xIZzLETNfBbsNAm08Nua83iYNI67tSKYWHkacjdf5orzy
	iSGOtBHp+V/YSzcLP/R3V5aUuHRZ5F0yVQL+Sno4LMtfUOkz/5eu2cU/1NR1hnv8
	DuQdfbbHOyLowTORTByeEJgvvImfL75Mzjw==
X-ME-Sender: <xms:NAPEaZio0nh6ITpaCdTC3NdZCliHXgNWFqpYS443XI-N0dYvTgiBEQ>
    <xme:NAPEaVdQHKNl-7-iGlz9koA1hP7AuzRGG-_yRlUvrL155-Qy4YbeZKifedqV-aTrL
    ylLFa5VB2Vm4orMmeMjPm56Tc8xVtWnrXcZX-Bi8lG4rcMTXcNq8g>
X-ME-Received: <xmr:NAPEaWdn7pkkLZ8MunSCP6WZ434L4zDsRFM9fkHkGKhNKMBFxTCioBIaM0JxLdSF-huQ1jkI0QUWzST4JLIXxCmwIb9SI8xOvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:NAPEaX8UJ0l_FAh-bKkNJ5H4m8UDbNNvaPSkQHxnZ5LXCn_0DnG9Bg>
    <xmx:NAPEaalPg7PJ85XNAdBVXfSO7FC075rpsQvdeplyDy_gkjjih2qjSg>
    <xmx:NAPEaR9C2HCmNnGYp6WuUnpu7hJ-v0FBg52YqedlGziJiIq_b7HaEw>
    <xmx:NAPEaQkL45vQM_L-KVSLcDjiW4wSDCVgJ0sf3ITMOQslXtGvohUdrA>
    <xmx:NAPEadm1URL_a85OHCjpJbd84ymc5gIDlQZ0lOn-Yku59YfeZoiwzpR8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 11:45:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/11] t6002: make test "set -e" clean
In-Reply-To: <acOLlLzphGMfZeN6@pks.im> (Patrick Steinhardt's message of "Wed,
	25 Mar 2026 08:15:32 +0100")
References: <20260325062114.2067946-1-gitster@pobox.com>
	<20260325062114.2067946-4-gitster@pobox.com> <acOLlLzphGMfZeN6@pks.im>
Date: Wed, 25 Mar 2026 08:45:54 -0700
Message-ID: <xmqqcy0rykst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I've got this alternate fix, which I find a bit cleaner overall. With
> `$((...))` we don't have to worry about the return value of expr.
>
> Patrick

Yup.  I agree that arithmetic expansion is much easier to grok.


> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index daa009c9a1..f2de40b5ed 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -27,13 +27,16 @@ test_bisection_diff()
>  	# Test if bisection size is close to half of list size within
>  	# tolerance.
>  	#
> -	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
> -	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
> -	_bisect_err=$(expr $_bisect_err / 2) ; # floor
> -
> -	test_expect_success \
> -	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
> -	'test $_bisect_err -le $_max_diff'
> +	_bisect_err=$(($_list_size - $_bisection_size * 2))
> +	if test "$_bisect_err" -lt 0
> +	then
> +		_bisect_err=$((0 - $_bisect_err))
> +	fi
> +	_bisect_err=$(($_bisect_err / 2)) ; # floor
> +
> +	test_expect_success "bisection diff $_bisect_option $_head $* <= $_max_diff" '
> +		test $_bisect_err -le $_max_diff
> +	'
>  }
>  
>  date >path0
