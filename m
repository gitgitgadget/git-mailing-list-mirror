Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A541DB924
	for <git@vger.kernel.org>; Thu, 29 May 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748544615; cv=none; b=Y8JWPqPbVaNj718bwiaxR2n/2ZxFx4z2X/ZcCAiAOHgizimwM1vJOSs3GB+w2K9fgYJ/oJMjisbwKwbkqq6pgeT1MmMCwPrMcLfh8I1dZzS0/AOY1MoZwucrIVA2TTo4IgGqlXjEb15ci0NMT0ldAOQiRlM50appRGcLttMelYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748544615; c=relaxed/simple;
	bh=r4mC64WKjJh8VvAuwTTTww7RnEmUcISgPPThj8y9LiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pC/hgdPrF8o3HSi2UrVPVCGOk5oRVV/1qhSkUpQk2PqbiWQDyhJadK1pdPaKlqnXd+2niY+DGAzalCHQS+ej6f6uZdD8nkp9BMbtWJfqNWFPYLWmad3846izk5Zuuo27OEJ3VeV4Ere4NNNiZvLGVuMOe14PQP+HTp0izy3cE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLRgzjxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3J+P15m; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLRgzjxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3J+P15m"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50F59114017A;
	Thu, 29 May 2025 14:50:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 29 May 2025 14:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748544612; x=1748631012; bh=jWHWojp7tO
	FJV8mkoMFZJhBVODH9BZxchgfVVXJ0rYw=; b=MLRgzjxL9WEOqYlJ+wKnCGEHh9
	pd69r7KnBXhh9/1q6GGLDg3BDcT88yxqM3OSEuhNGoAYYcuzxhY2Bj3lgoMf/fZP
	zR4+O9NjeaQSJdX4WHzHng3z7uMUQMjfCONyV575Mt1x6cMYZPx2YV3qTZAglRqo
	eENB25Ze4qvW3Axn65ePDP/SPVT9PXISM5R+qhKh4ITJdb0C4TeOOZ0ao2+o9gCn
	71KexDeeW8YQVnoGDlwx+co9r8C+8d//7lu3ISlSq4KdbH+gnSH5YmrzcFe48lfo
	U4owu5RGCmeZT8pRHBx0DZTslwcehIWaWrBj25lgsv9wkY9+sgvJOokhU9dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748544612; x=1748631012; bh=jWHWojp7tOFJV8mkoMFZJhBVODH9BZxchgf
	VVXJ0rYw=; b=b3J+P15moixzJRi/iAo1EdzPsO6FbhrJSbzinmgDkp0wTz+jLRV
	SsjynbBQtn1MZePdYjCGvPk9P5pvFvUhYPGzHstC+ZFzhUyEY8jIv9kuMmpFR6Bs
	Cj4m/K4PFHWjZptBqOo5qcVf3u9XwkV+8X0YB2CwWXJ324Tnlyjtz0XWPiRRn9j+
	pVUDoB1Az4iEg7n8Wxu7+k3nZTdwQPt97Ro1juMHH4XavfGeEThsy95Epn+Yk2p/
	dOMzZzqWXiU6uDyQjs+L14xQ/1By6LF5OqYI6Ff5atKbLZWpFL3E5zJy48ptb0+3
	bosiCXkBrzeoiNnu5GOaG4tK+l+DG9OVVJg==
X-ME-Sender: <xms:Y6w4aJL1PmkcxE-Oej-ZtR6xiP0IseDpB-8oNGGMLg1FuOb5O6JbnA>
    <xme:Y6w4aFLX_aYGvgXwD3_xvwKKnE67PKjKBAgbAS6JuwuqSbguZyrcdwJCWSBrba-vP
    RIb5KTZheYLrCq-rw>
X-ME-Received: <xmr:Y6w4aBuygLwF6422EwYpK0ED6e5OnA4zBH6uifM8GhRhjwyymBsEvwLTSKuykymvrdalwVeeaWjUeZ97kczDtWylz0o4Fr0wTXjhJK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieeltdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevuefgiedu
    keehvdevleehjeetvdehveetheekffehheefhedtvdevfeethfffteenucffohhmrghinh
    epghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdek
    sehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    iiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y6w4aKaDl8Kuo3yXAQr5a9ptjQ5bMhA_96Yp6-Nzn7cZgyafn-mQDA>
    <xmx:Y6w4aAb2FYhnXVL1Zzz46Z3AwI1WOdb0I0n3DsMNmT1hxyBZTtAQOQ>
    <xmx:Y6w4aODA0S7M8yoiaVftsRANjvb00ZhDt1TzUGAiJix-chtQv4rwXQ>
    <xmx:Y6w4aObwteO-56UuorY3aFEueJhYl9MWOPDOWZbaHdELDzvD-A56SA>
    <xmx:ZKw4aF8bqcQ8Ifm9k-7nWaEMW-wyCaK7YIGf9VHX2r8rVrYiq_sohwW0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 14:50:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
In-Reply-To: <20250528070521.17379-5-gargaditya08@live.com> (Aditya Garg's
	message of "Wed, 28 May 2025 07:05:38 +0000")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-5-gargaditya08@live.com>
Date: Thu, 29 May 2025 11:50:09 -0700
Message-ID: <xmqq5xhjl09q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> The current example for Gmail suggests using app passwords for
> send-email if user has multi-factor authentication set up for their
> account. However, it does not clarify that the user cannot use their
> normal password in case they do not have multi-factor authentication
> enabled.

Correct, and the clarification looks good.


> This commit clarifies that app passwords are required and suggests using
> OAuth2 if the user does not want to enable multi-factor authentication.

Dubious.  If the user does want to use 2FA (or already does use it),
there may be reasons why they still want to go the oauth route, no?

> ---
>  Documentation/git-send-email.adoc | 3 +++
>  1 file changed, 3 insertions(+)

Not signed off.

>
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index aff0861d29..99c126cd5a 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -524,9 +524,12 @@ edit `~/.gitconfig` to specify your account settings:
>  	smtpServerPort = 587
>  ----
>  
> +Gmail does not allow using your account password for `git send-email`.
>  If you have multi-factor authentication set up on your Gmail account, you can
>  generate an app-specific password for use with `git send-email`. Visit
>  https://security.google.com/settings/security/apppasswords to create it.
> +If you do not want to enable multi-factor authentication, you can use OAuth2.0
> +authentication as described below.

How about phrasing it more neutrally like ...

    "Alternatively, instead of using app-specific password, you can use ..."

The original somehow makes it sound like using 2FA + app_password is
the golden way, and short of that you could fall back to OAUTH, but
that is not the impression you would want to give to your readers, I
think.

>  You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
>  `XOAUTH2` are common methods used for this type of authentication. Gmail

Whether you take my suggestion or not, I think the first sentence
here is now redundant and can be safely removed.

