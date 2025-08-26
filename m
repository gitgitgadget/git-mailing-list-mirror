Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3317C91
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219914; cv=none; b=q26515fQD8EE+HpQ2T/OccfjYlApiVZyPtMSkYoSinEn0iqJIIMVYACpPGrXrdOj5AGh0+/JV5xvuOTok251zkWl8UP6mnRNIgvQpN5Ltm6oTGfVNshaVBPD3NuWIIFZbxIbPye17CfMp7B+xHTaQVbXlcKPIpF/k6sFh6rocfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219914; c=relaxed/simple;
	bh=JQ+NS/wzqfXTX4HHXPwOdMKAb5cMn6LjFYZq5dzpSGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gg+on0trUna7xc4JvnQIJ73iArylbubrQHaGxj0jIbrL9uk6Baz2+W/vTRUZFN5UNKyXQbu9QCy5/fqbEHqtAg89+PNBmOs2VUyVLWZ+d/xGX85qoIwGdxq83hi52h4wUurqJg6kKjtYXIX18r9CqjB5DbkRWlgc1FRZfT3VrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TlbCEjrY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9brZ8C5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TlbCEjrY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9brZ8C5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E48CF14000D2;
	Tue, 26 Aug 2025 10:51:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 26 Aug 2025 10:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756219911; x=1756306311; bh=7cSxX1KY1W
	hTUGAHLA8eUDP1MpqHE1MZHNMXlvEmxQ4=; b=TlbCEjrY/oMwZUK8GMtvpa0kDP
	2QbEyn2If2/BKEwxtB4NQL0XDdZiF0onLlnsvBnePyTsmUxybZ7/AEKyT8Z/BX16
	6E676w9+dYkSedBZIbqeQMseZSwTiSSKqHTl5T5uq7/atGqG1hFizniyHIGFPA6X
	0WjbeRF6nUN/t1gBVxnyt40R8FNSyE/KXp77FhMU+b76taoIUfu+zOO7ShxGViDj
	HxSPqoBxkamPqbU+ndN6ngOgH4K8ZS6CIgTH+nI0VSWNuqy4b98Z+cPwp7xE0Tch
	IkctK3Qov4lwbhkqWqk5W9ne3pCvKFeJmSXvPGkYc28IXBwdSRIs9XFrSdew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756219911; x=1756306311; bh=7cSxX1KY1WhTUGAHLA8eUDP1MpqHE1MZHNM
	XlvEmxQ4=; b=d9brZ8C50EvzhqQofj54b+NCUrVhaRmXsWJ6BRoPFOs88nqxEYY
	sHZdIage2IeDeFyRiXsdJpVgKcKYo/fVh6sfV0zK3TDqXNj8dq+jr5PsRK2uX1Mp
	F8QrbmSJRokjRl2EjLdD0c7DLLO86Bi1LZR4V0gS6eDQ6BRE8gz+JBzXxkHYG78r
	2/2sRfv1QTviR2rwN5tYL1itdOGljB8tpqU07GUK46gYIAY5dLFXD/vEHaM7LgKn
	ql9ISSN3Nk5C0qVetbe7V5oV2tGshqDwuWTaCuXjfk1PKjgiiQfsUB9K8dY2bVS5
	teoZbmKr45RAPklc0HWxioGOD3lvKSgXYtQ==
X-ME-Sender: <xms:B8qtaLJcVgT0p14uWFLc4RlHVjPPWb-hlBX0HeJd7SyFZpM5QlMMrQ>
    <xme:B8qtaHm-6IiKkxfpspZ7Krz9i2d94AP7rqBB7HO2ATBTmgZbEEBBC0Aq02zzLb-hD
    ugiqs06iLIkWP5sEg>
X-ME-Received: <xmr:B8qtaEI_s89S6AdjfQeQiMZIpmxlwYWaM_MQkmP_Br8JIheLaFc6G1BBZIRNfRm-1pf0m0ZNE89MuaMQmrnJN0JvdRFpGstvrrp6XjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:B8qtaE4KdW0ehp6_RcT3il_Bxp8ijHdbbYtY9B2ZpObpUvzwBzNNpQ>
    <xmx:B8qtaA2WL3UlLE-VmrAsvGYcbFDWbG2oVAE1E36qEdiXaiYwot3lzg>
    <xmx:B8qtaCcIF06pP7pthNfiuwdsnW--Rzs6Dtnz6g5Rp4Cpm5vo8Ur53A>
    <xmx:B8qtaOeG40USoe6V7SwfO_3JfHLmD2mWZhh9FQA-HEbKI4cmt1hYyQ>
    <xmx:B8qtaGMhcQ0ffBvJ5fLEZApzoL3rbV_FFpLp0RiwOMlk3M40jBNtIez4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 10:51:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Ben
 Knoble <ben.knoble@gmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] docs: update sendmail docs to use more secure SMTP
 server for Gmail
In-Reply-To: <PN3PR01MB95973B72C16F68D63BE2B410B83EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 25 Aug 2025 12:25:15 +0530")
References: <PN3PR01MB95973B72C16F68D63BE2B410B83EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 26 Aug 2025 07:51:50 -0700
Message-ID: <xmqqcy8im8zd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Gmail's SMTP server also has a port 465 with SSL/TLS encryption. It is
> more secure than port 587 with STARTTLS encryption. Update the docs to
> reflect this change.

"Update the docs to reflect this change"?  When there is no change
other than the changes this patch is making to the documentation,
that is a very strange thing to say.

I would have explained it this way instead, perhaps.

    Earlier recommendation by IETF with RFC 2595 was to deprecate
    implicit TLS in preference for upgrade an initially unencrypted
    connection with STARTTLS command.  These days, however, IETF
    recommends that connections be made using "Implicit TLS", in
    preference to STARTTLS and the like, completely reversing their
    earlier position, in RFC8314.

    Update the GMail example to use the implicit TLS to match the
    current recommendation at port 465.




> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/git-send-email.adoc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index 5335502d68..c610909a92 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -521,10 +521,10 @@ edit `~/.gitconfig` to specify your account settings:
>  
>  ----
>  [sendemail]
> -	smtpEncryption = tls
> +	smtpEncryption = ssl
>  	smtpServer = smtp.gmail.com
>  	smtpUser = yourname@gmail.com
> -	smtpServerPort = 587
> +	smtpServerPort = 465
>  ----
>  
>  Gmail does not allow using your regular password for `git send-email`.
> @@ -542,10 +542,10 @@ if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
>  
>  ----
>  [sendemail]
> -	smtpEncryption = tls
> +	smtpEncryption = ssl
>  	smtpServer = smtp.gmail.com
>  	smtpUser = yourname@gmail.com
> -	smtpServerPort = 587
> +	smtpServerPort = 465
>  	smtpAuth = OAUTHBEARER
>  ----
