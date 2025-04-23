Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C4293B5B
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745435036; cv=none; b=roC9l26LyG4JtlTEX0Jp84P1etzbROV756yQB15nZX4eB0TKFvUENW33xVFro1ZSfKMNRY3dMhbfVT23X/hOrdZ0+kT4aSaCFVfC3/IVCxbhafQqpx2J6toOaTC9KcDKMtFiRhDYW7IIJLp6ie3naWyXAJ5d4ftIKCMszp5wqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745435036; c=relaxed/simple;
	bh=6qfYdSQ8AqLRo97AvSsi5GoH3eEg11ZmFt0hxaXWhlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmA4550qcVWw2Ggd9mf4Fb479K7nXlDIWti7w2VHJAxXKJlam+cRbOoDbnoUsknfyFL92qi4g3RSaFFhlaop6CWlqlabGWLNNQkgvfXdE9EGe76PKr1PMNKM0zk9LjGbA+cqzCT9DIARQx/zpVWF+da522Wd6SFvxr0/i5Yg4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DWc4TdBe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egxrRbuc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DWc4TdBe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egxrRbuc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE56F11401BE;
	Wed, 23 Apr 2025 15:03:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 23 Apr 2025 15:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745435032; x=1745521432; bh=Y/AAEsQ8ax
	3d49W2dQ95dZmnYZcY8sqH//POztBtdDA=; b=DWc4TdBeLRZ9s3GYtKynt1xCmG
	0J1ZBnRemKgBkJCpjwjTX3YrLp5kQv19irfQD+NoEJxAuHryKYwmLxys1DKOXSk9
	7KAx4ONIh0Buxek/cGwkU56FTMwku7AuHFtj2PPt/TEMMpiqEeQACHNtWQeebtP1
	yzO7P00t3QCjve2dMGy0j7LCibSELmdud0HjaQPUPDj4XivYnERpOVCMQvZ6Yp/T
	B5mNJvucHlNMDOgzlDrZPYgHRlYpGDhrlB6mDVpfTfhfNBcSzWgA6BIfDrQ5RLHn
	RIkrj2sZ5vcx6KjRereoR1+qsdtxtCYQCgAo52r1Rk/Z2BzhDRQvhedqTuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745435032; x=1745521432; bh=Y/AAEsQ8ax3d49W2dQ95dZmnYZcY8sqH//P
	OztBtdDA=; b=egxrRbuc+5+6nKtxJ8icjJ7PlYPzWG9N+EOOE4lh/og0rPqbbb+
	+WdkyKFcdga+i0p2thSg7h3uPyQG+YU8U/IPYD6su6KLKh9lEwNfE7or+IWJlycN
	ksoTlNsMWImLiiupwWdClsneyhxAD07aoYc+5Vv3qKb2omHhMUsF+BaJzDl656LI
	ek/1wsSw5mqZAtUMF2BO3TjCJkyKVVcxifzbCNoZA3xATXEktgirwbHLzndwA+C1
	BUBlSuFnD/1cEIJ1NoqJAtlPzVNwYYs54nhKSRf7ON0jrF1QqpoW0wqDQfUsJGrr
	G3P734xuUZjS3mafpF3l6uob03MhqSNXUPg==
X-ME-Sender: <xms:mDkJaCMN3HKaNE1eS1yTNPJROoTZoD1kweMe0CF1jmcMNpfRG8cIMw>
    <xme:mDkJaA8muVlmzJo-Vet8fDdU4mxGxfNwIknhMyGCJoWacBTP8s9BzBUe2VsDKurOV
    oPnSjamamajCNY4sg>
X-ME-Received: <xmr:mDkJaJQGO5vFbowukrBhq7Q30-kK9TFtqm9toSngHu-AhoQS_qhPoW_-H7ZKUnvLn-UEFHj9lAUfDywJuRkbk573yXcQ098_UGUH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghm
    rghkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mDkJaCsxXs1_Fzm0uwEE1_xfOI_5tQuB0qE-_LTRn6EGgN5OzorXMw>
    <xmx:mDkJaKdVL-vUDze4CX0oA0JROynJF_GflvErLB5WKC7IrreCnwgsoQ>
    <xmx:mDkJaG0e9vIvz7qKtIHEk-A_6NBr84hAjGLBpBfB-WjoHbYDeSoB8w>
    <xmx:mDkJaO9zOpeidjHYfyMEQ6f9EFDI1Pv7BoytxOmePbeEo8kPQLKISQ>
    <xmx:mDkJaAqaKvIYoAAQti1NiS6IR4vmdT_JQ3aINIh7Pa7mIartQNr-9FDb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 15:03:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
In-Reply-To: <PN3PR01MB9597B50EF69AD097C594F844B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Apr 2025 12:19:47 +0000")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B50EF69AD097C594F844B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Apr 2025 12:03:50 -0700
Message-ID: <xmqqwmbaya21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> @@ -230,6 +230,14 @@ or on the command line. If a username has been specified (with
>  specified (with `--smtp-pass` or `sendemail.smtpPass`), then
>  a password is obtained using 'git-credential'.
>  
> +--smtp-passeval[=<command>]::

Lose the pair of [] that marks the value optional.  Compare it with,
say, --smtp-user that is described as:

    --smtp-user=<user>::
            Username for SMTP-AUTH. Default is ...

because they are defined in %options (below) in a similar way, like
so:

>  		    "smtp-user=s" => \$smtp_authuser,
>  		    "smtp-pass:s" => \$smtp_authpass,
> +		    "smtp-passeval=s" => \$smtp_authpasseval,
>  		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },

taking a string value =s that is not optional.

> +	Generate password like OAuth2 token for SMTP AUTH. If specified,
> +	it will use the output of the command specified as a password for
> +	authentication.
> ++

> diff --git a/git-send-email.perl b/git-send-email.perl
> index a18e978e22..cafb9aa43b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -59,6 +59,8 @@ sub usage {
>      --smtp-server-port      <int>  * Outgoing SMTP server port.
>      --smtp-user             <str>  * Username for SMTP-AUTH.
>      --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
> +    --smtp-passeval         <str>  * Path to script or a command to generate
> +                                     password like OAuth2 token for SMTP-AUTH.
>      --smtp-encryption       <str>  * tls or ssl; anything else disables.
>      --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
>      --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).

Looking good.

> +	# If smtpPassEval is set, run the user specified command to get the password
> +	if (defined $smtp_authpasseval) {
> +		printf __("Executing token generating script: %s\n"), $smtp_authpasseval;
> +		chomp(my $generated_password = `$smtp_authpasseval 2>&1`);

How careful do we need to protect ourselves against a bad value in
this variable (like "rm -rf $HOME; password-command") ?  Are we OK
with trusting that the command line and the configuration file are
not under control of an attacker?  I am assuming it is OK, but you
folks have thought about this code path much longer than I have, so
I thought I should ask just to make sure.

Thanks.
