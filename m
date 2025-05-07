Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405C231A3B
	for <git@vger.kernel.org>; Wed,  7 May 2025 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746656510; cv=none; b=D7HBzAU4TGwOIi0G7BB3fHC/l8gPTdTgPoqeDCE03BvFjti4x7AZrx6BnkBE4O2mVh9GJTIST8pJqmc6wa48Ac3HtipV6BykbGFXpefh55POithcl95l8iW0mh5KH59ZFbHFQKia0t5jWbUcWJc4xznh2JTW64tlRzKNSOYmhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746656510; c=relaxed/simple;
	bh=C/nynAR4Eed6ylpQ/aLTziV5sNPZq258L5p5QsG7zZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJ+JzkLkQDTwNfGADFqZXZtB7+SGmDF97l9qS6Le0dCh/ZcHzjCJVAL7O4C3oG9ALVL2VmiUN3a7YgtaTd6S90PrmO9tOR3uvEnWfxYwyMmf6udNHntB5hzxf3BRvjDyL4thVqCstSGqmBoO0JWMCgZ62t+JkysKuB1kzkdqRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WxlebnpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWmNJVfg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WxlebnpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWmNJVfg"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CD961140118;
	Wed,  7 May 2025 18:21:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 07 May 2025 18:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746656506; x=1746742906; bh=FdJfkGH66a
	R1Bdsp3CSf3zNb65AKE+akwD5HX7nvMTE=; b=WxlebnpJyxbxaE+Yg1lR6M624I
	gONyYkofM3bW9lxhPCuatMyk3rLo20Och9+0/MdORTeA0fMmaDHk7EDXdcVKRiJO
	nX2ODZgU4Onsazq/18zX/QezYAtw8RPw99dtW6eeIeELhEzsQsvNWNzladS5hg3n
	RCx7vBOJHJyzIcp2/3Xi6eIh3UZEUcSS7waZREGcFJWwC66cWnNHZfB5uUMheE6X
	O/qbzdDfE4JH0saObSr52BRXDQ0YMYSdb/g8MYP6cZS6k1nMBvILKfyGwsH03+OR
	1bKak0W7z9KbKGt5Oge6qTX6iLJ2gGqTqj1VFOqa3MV/0EOWOiiGcdXxl85Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746656506; x=1746742906; bh=FdJfkGH66aR1Bdsp3CSf3zNb65AKE+akwD5
	HX7nvMTE=; b=CWmNJVfgkDGkWyP7Zp9fOYZ2P1uxUkNWVyXIQ6kuBxyJWhZxG4o
	cNvZH34zfq5xV/DNJ9aVc3aNfIYR4/53nic2A1ZwkmIWjcIYFyqQhcFh0NawAZlH
	ge9re+ZFe9vEx5v1casvUSLlIhwdjNpFDnpmcqqH3OSfAx+ero/wMPItSmOzjh7t
	ToZIImGQc0tdMJMeQidqd6pCTVvlrtESvysaZF6bRwd8vGZYqy6O8IASAnko9epg
	Ppg/PB4woFvRxqZJG2moHkRb3dSJadbG3xiZbzoDO6OTA5Lj+RL1WU+NR0yZ9qRr
	7boDQmkelN7vYJNHltEDHBtlFq1BJf4AEzw==
X-ME-Sender: <xms:-dwbaEPCNcIcyEWK175u4iBmv_0pH_IRHnP7a2ob-yPkmOMh65UbGQ>
    <xme:-dwbaK8EJnWJD8p0W12gO37QX_aOqiOg0tohNL4SZK_6HskRic4F_vXHLKQ8A9kJc
    fYu-BcEmrH2P7PgUw>
X-ME-Received: <xmr:-dwbaLSQGRQNqRDRDxYhjCnyTS2FA_ailyfTpQnuFAz_x2EYJgjvEa5lgx4ARzrMUupXjveT4Pu_PlbICDW2HhDinh2nAgoPenDF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephffhjeekhfettefgkeelfeevieffveel
    gfehfeevffejleettdegvedtiefggeelnecuffhomhgrihhnpehgohhoghhlvgdrtghomh
    dpohhffhhitggvfeeihedrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogi
    drtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhho
    rhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgr
    khgvrhhsrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-dwbaMvAt0kH3VkXA4i8RMHk-iSkZTgajzsmW6X3XuEdFlHPAjjEtw>
    <xmx:-dwbaMc823vo_RsvoSWOqGJNpltO_GGajU56LiMG5Nc-x83coUysUA>
    <xmx:-dwbaA1HTs9Jys-kuoSHcNM35FKPjL7GBhqIFIieIu-vVfMAzWFwAQ>
    <xmx:-dwbaA-Aw9AqXViKUo3edScCmoJyh_LiJxlH6HUgfuxD_4fgrWebIA>
    <xmx:-twbaDDYEl2dZmz2HQ4iMLtOy8vZRJf_1LlQ2-KCs4PTz7s_8QyVC0Qa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 18:21:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,
  sandals@crustytoothpaste.net,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
In-Reply-To: <PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 7 May 2025 12:33:06 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 07 May 2025 15:21:43 -0700
Message-ID: <xmqq5xicawp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> -EXAMPLES
> ---------
> -Use gmail as the smtp server
> +EXAMPLES OF SMTP SERVERS
> +------------------------
> +Use Gmail as the SMTP Server

Nice to see that you got the capitalization got right while at it.

>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -To use 'git send-email' to send your patches through the GMail SMTP server,
> -edit ~/.gitconfig to specify your account settings:
> +To use 'git send-email' to send your patches through the Gmail SMTP server,
> +edit '~/.gitconfig' to specify your account settings:

The four single quotes above should probably be changed to back
quotes, to match the "You can also use OAuth2.0..." below.

> @@ -528,6 +528,37 @@ If you have multi-factor authentication set up on your Gmail account, you can
>  generate an app-specific password for use with 'git send-email'. Visit
>  https://security.google.com/settings/security/apppasswords to create it.
>  
> +You can also use OAuth2.0 authentication with Gmail. To do this, edit your
> +`~/.gitconfig` file and add `smtpAuth = OAUTHBEARER` to your account settings:
> +
> +----
> +[sendemail]
> +	smtpEncryption = tls
> +	smtpServer = smtp.gmail.com
> +	smtpUser = yourname@gmail.com
> +	smtpServerPort = 587
> +	smtpAuth = OAUTHBEARER
> +----
> +
> +Use Microsoft Outlook as the SMTP Server
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
> +Therefore, OAuth2.0 authentication must be used for Outlook.
> +
> +Edit '~/.gitconfig' to specify your account settings for Outlook and use its
> +SMTP server with 'git send-email':
> +
> +----
> +[sendemail]
> +	smtpEncryption = tls
> +	smtpServer = smtp.office365.com
> +	smtpUser = yourname@outlook.com
> +	smtpServerPort = 587
> +	smtpAuth = XOAUTH2
> +----

Just for my education, the above description does say why Outlook
needs to use OAuth2.0, but does not hint the reason for the
difference between the two example, OAUTHBEARER vs XOAUTH2.  Do
these two services support both, or does Gmail support only
OAUTHBEARER while Outlook supports only XOAUTH2?  

Given that the former is described in RFC and the latter sometimes
described as "Proprietary Google extension, not a standard", it is
somewhat funny to see that Gmail example uses OAUTHBEARER while
Outlook example uses XOAUTH2.

> +SENDING PATCHES
> +---------------
>  Once your commits are ready to be sent to the mailing list, run the
>  following commands:
>  
> @@ -536,9 +567,23 @@ following commands:
>  	$ git send-email outgoing/*
>  
>  The first time you run it, you will be prompted for your credentials.  Enter the
> -app-specific or your regular password as appropriate.  If you have credential
> -helper configured (see linkgit:git-credential[1]), the password will be saved in
> -the credential store so you won't have to type it the next time.
> +app-specific or your regular password as appropriate.
> +
> +If you have a credential helper configured (see linkgit:git-credential[1]), the
> +password will be saved in the credential store so you won't have to type it the
> +next time.
> +
> +If you are using OAuth2.0 authentication, you need to use an access token in
> +place of a password when prompted. Various OAuth2.0 token generators are
> +available online. Community maintained credential helpers for Gmail and Outlook
> +are also available:
> +
> +	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail] (cross platform, dedicated helper for authenticating Gmail accounts)
> +
> +	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)

Given that this will be formatted via AsciiDoc (or asciidoctor),
would it make sense to make it easier for readers of the source
document by folding lines, like:

	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail]
	  (cross platform, dedicated helper for authenticating Gmail accounts)

	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)

or something?

Other than that, very nicely done.  Thanks.
