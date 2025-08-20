Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE98213E6D
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704071; cv=none; b=FC7z4jtBGLpFh3maI9xeOAS1FtU5zTAp4OOz7F2n5ZT3+Nwr+F7M/UsSfC/pzP2BK31oGlKlJ4IDDX/d26zU3Hs2AgPMN4fPsTqT3eqL0XveCJhyCpQbAMg2Mhc9scyW8Yu5MZs4fcqDGr5qoxOgWXDeSHG3y8l8/7WSID+NuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704071; c=relaxed/simple;
	bh=vAoV7haBgdPQhyEfCwzg6CYW3ZXItIdgtf4dxWU2Ljw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QGSjnbE4p/FPYOsfauWXoMh9gRIRo9kqLX/phKrNyiQXYgC8hEvT+pkDf+38wEY34NVyqKFRHjkjkZHLolaQoIRZneVYSMm6hGtjSYl5XS/ulgC00XebxR7yu9yT5JattqCTucLOI1kjdNGEoHfUmac08YXfSlfUHAl+UOpn9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jx9BiklU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAwa/cj9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jx9BiklU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAwa/cj9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8998E7A004A;
	Wed, 20 Aug 2025 11:34:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 20 Aug 2025 11:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755704067; x=1755790467; bh=t0YITEXSyl
	Z+lL3hKpY+lJlpZNCTryXh7zo9NpwccRU=; b=Jx9BiklUnk3zJHXG7ee7jTaoOR
	c2ywKILbP9/MOgJ3SzwcEjvI9lNvoaZxeVCbX9+3UL1Vus4oZX1Foro1lbunNuxY
	0ksW75oEV+Z8kC4AVy12iwF2BeC9aHoXDorI8SLUF/Sy8krAw3iyAsBJOkr3QZzB
	N+KJ90vi0It8xeokkkqfaOUKB52nPzAxXmvZ8fAZOugHXxrfA9KFthgF3hFbLsWj
	v4j9yDSeCkFDCj0vtxa5T57uq6Sba16T1fYFHelykICZsj0AusTVbpOMM3Ogep73
	Dh0yFBQiIdSXUxgJ9xf3PPFpC6vdVgj7lSKKjC9HDcHV/7DC+IvRI+eWAGhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755704067; x=1755790467; bh=t0YITEXSylZ+lL3hKpY+lJlpZNCTryXh7zo
	9NpwccRU=; b=fAwa/cj9eg1UxoSXQA7Ye9VlJz0b7zwImY+spa7vWlGwblX9yBI
	hkXXTVHb69jFjznZLjI8Ydc8aZvq9QyvILJBJPRjDZuYlp3jKLiiL4Tmxq52d7VR
	/QPPbNeqaGsvjjtdIUvwaMbq+Op7dddB6v61c4Hdk4KsKU7keozgmAL2jdAbqe0T
	WBFCT1QH32Ej3xeKUc7/8RXVkoGnP2JGXH49KN1KDblLy8qg79XWRfRxGwNoFmMa
	2u6bh5lZlASQzar7bXAT5gr9Xm8maHdOUuRFqr2p6T4g3xik+E1UFathLKbfZA8b
	+LkuqvRpeM5wi8pHDzk3m+puVAwNozQanWg==
X-ME-Sender: <xms:AuulaJc4P13e4W0k8najQe37PROYpRFz3OJVvCA3tlT0jZGEeZwanw>
    <xme:AuulaBzQ4AvnCQoykrHBky_Jx8BN5Bp9ynU7iEetHiLatY2nSfDJkZFv6nLfMg2kF
    LkUYMc9DDuftCmJYA>
X-ME-Received: <xmr:AuulaPHRoQR_fNemAd3zgOd13KQoyyczjjoLMMyCDLdycZyTwzPHX8Lvz9EKYaF_sMSMKm7_J9TcmE3mxZ2yv0E2s6ywkIsg_myAJr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepudffkeefueetgfduveeiuddugefgtdetudeukeelveekvdejgeduueegkeej
    fffgnecuffhomhgrihhnpehoiihlrggsshdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AuulaFwf8pCuOgB0Jy-EpI3tBq1dBwLu861doraHShCiyXPvkMAUzg>
    <xmx:AuulaAtQqj59l4yz_CNNJfxyGsq_xd-5lPZsokFPQhdsKf8FBAWeCg>
    <xmx:AuulaC0KfY6ghXObcVfFkQ8JKfHV6ghW7hsnAgwdOZcsPKAKncPnCA>
    <xmx:AuulaL-pCoVDDlMBgpsfLWceAAXjaJflFlO24QGuUEcsjhvyT7a8yQ>
    <xmx:A-ulaIGaOUSXSh1zjahxV9055is8KklZUZa_oM1aSScnMckxHzVY1q2F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 11:34:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] doc/gitk: update reference to the external project
In-Reply-To: <249056e7-1332-4e6f-8d07-16c80fd4913e@kdbg.org> (Johannes Sixt's
	message of "Wed, 20 Aug 2025 08:16:05 +0200")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
	<20250819-b4-pks-meson-tcl-tk-v1-2-6bcaff0bc0a0@pks.im>
	<77fd0332-cc46-44b5-bbf2-94f326d5d754@kdbg.org>
	<249056e7-1332-4e6f-8d07-16c80fd4913e@kdbg.org>
Date: Wed, 20 Aug 2025 08:34:25 -0700
Message-ID: <xmqqv7miatxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Gitk is now maintained by Johannes Sixt and the repository can be
> cloned from a new URL. b59358100c20 (Update the official repo of
> gitk, 2024-12-24) could have updated this instance in the manual,
> too, but the opportunity was missed. Update it now. Do give credit
> to Paul Mackerras as the inventor of the program.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Thanks for the update.  This is long overdue.  I forgot that this
manual page was carried in my tree.

>  I just noticed that I would have removed the last user-visible
>  mention of Paul. Don't do that.
>
>  Documentation/gitk.adoc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitk.adoc b/Documentation/gitk.adoc
> index 58ce40ddb1..5b34dcd077 100644
> --- a/Documentation/gitk.adoc
> +++ b/Documentation/gitk.adoc
> @@ -163,16 +163,16 @@ used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
>  
>  History
>  -------
> -Gitk was the first graphical repository browser. It's written in
> -tcl/tk.
> +Gitk was the first graphical repository browser, written by
> +Paul Mackerras in Tcl/Tk.
>  
>  'gitk' is actually maintained as an independent project, but stable
>  versions are distributed as part of the Git suite for the convenience
>  of end users.
>  
> -gitk-git/ comes from Paul Mackerras's gitk project:
> +`gitk-git/` comes from Johannes Sixt's gitk project:
>  
> -	git://ozlabs.org/~paulus/gitk
> +	https://github.com/j6t/gitk
>  
>  SEE ALSO
>  --------
