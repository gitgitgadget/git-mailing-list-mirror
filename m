Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E34215F46
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711244; cv=none; b=mC+S+HTvXrsFI0kI6rl35F3Q6wk8gBAVIxMZBrqGkJgPIw3wnSdk0a/Es4H8JI0U6GeI1nN8cLtiHJ212K7zoVObkCncBZr0dbZHZvbFNIU5ALN3oeuk/B+Ieg0yXHVW+YQLV4gg+Wu/SVqewGM/APsX5FWY73yAQow+DlOJzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711244; c=relaxed/simple;
	bh=NITlHdVzzMIEn1iJezxY99kHu+HkVtleW3en3svxPB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qO0LgMTvU1+eIUYBtndTPJNwMJPMGsXbQHJk8U6K8XDLjqUrEF3GT2XLL++jmep2rqilMsSrKuW1LmHeXbRrXSE6zT4K2n9e0xGfEzR9t2+vo43vkiNGHAKEPH2vqW2cORxtdvIzkmAMn1LlFva9pcVtKG4iSIJHF+k3xnBKZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqbUZdaz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VtJFgRci; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqbUZdaz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VtJFgRci"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 29B1211401B8;
	Thu,  8 May 2025 09:34:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 08 May 2025 09:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746711241; x=1746797641; bh=1LJd9GsPnM
	i8/IFQWq19gGsTreUQ6E/tTF/CCFlX1vw=; b=TqbUZdazpuHKjlqCGU1++qQbQU
	VeS4lNx4o1N29h2FSf851dIRV9T+1pbQhWrJuWgyc3cLJePBUEh5pDHkNJHYx4sT
	Dd1E/vclDL+2VHywvyTZSU/8pqtM8EnvEnN1w6TrDFh3b78paQkQ3mWjOrWgOo7a
	Es7v4Eaa8Tb7+SbZznnkH+HZwi5rh4OfHXmEvE8LrhrnrsySTmzsN37cvjQ6qRMn
	TRxx2Wj68gb1p/vZJDbfYE9wS0BupXMZQmB6F/j42LnKbeH91Jiaqk5UavBTSixU
	FlEqFYK7W2BIw9GuCGzFv0RBvoLp0AZyxbgZLILX0RabI81piFRFjE/yjgSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746711241; x=1746797641; bh=1LJd9GsPnMi8/IFQWq19gGsTreUQ6E/tTF/
	CCFlX1vw=; b=VtJFgRciVhA5MTnDhAXiaWGuJNqSzvMO6T+yYsWSHax2h32lFMZ
	BzVk2swKLiDvnpfV1IMAB0NglK9JoSQbsD1CtuwmOvwUxFdqX3gK8s2BsJE2jtdG
	IsZa0Pjvz1ERUZFDquJb/2PGkQiAAMCDYa4qluHG8hJxv0fEtRKZHMzR4rRU9dtM
	JA0c2t3ZdO87qf7v2O2pJ1Qvs8/R3nMhjH996/eBgV5j6iSJk6MKeJQroOPSIRc8
	DlwxfK0G1oexLK/B6p7QBXY+iQxqBd5vrPBh8pnr6dLGf4RNv96dwuVLji25AdqQ
	BZyWk40YUirfztHBu935BdQl2JJRd9/Yybw==
X-ME-Sender: <xms:x7IcaEvTbjxyT_zadxFHc7DY028Pb0ITAXUdXINkHR5erGBsSEGckw>
    <xme:x7IcaBd1H2hAw_q2FgKY-8QSb-QaPuclAx1jgT8W-X4gHUXszCTfPvaw0XSJBo0_9
    Z6xQz_aBRIIFpPeGw>
X-ME-Received: <xmr:x7IcaPzcK3MvaY90VspwSJewXwxjh_sjSLkfd6SAvCZiSyx_Po1dKp4_1G7_70zjMRVxV1X13prwCqvw_Q0OYY4p6Ji4eiT_jmBp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x7IcaHPravckV6OO61Y7z8ZCbATX7EHYsUQa6BmMZyScb4skWea4dw>
    <xmx:x7IcaE9WV2xOAETIlPc-26FtXxg7EFqezI0DpMDdCkm5zMUa6OZkIQ>
    <xmx:x7IcaPVVdSzVyNGDexfptf6sEwnmIh17QXLaJf9vsAZWAETAAIoEWw>
    <xmx:x7IcaNdIqX9otih3oG3vCEkah_jN7nAsQLSVInDAbd8HwiO448GMKQ>
    <xmx:ybIcaNjSSy68IaVnElV5bX3sG0FrUwYhWyG65WjYVm-ZDxn57stykMwz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 09:33:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  M Hickford
 <mirth.hickford@gmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
In-Reply-To: <PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 8 May 2025 03:29:58 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 08 May 2025 06:33:58 -0700
Message-ID: <xmqqwmar8bw9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>>> -To use 'git send-email' to send your patches through the GMail SMTP server,
>>> -edit ~/.gitconfig to specify your account settings:
>>> +To use 'git send-email' to send your patches through the Gmail SMTP server,
>>> +edit '~/.gitconfig' to specify your account settings:
>> 
>> The four single quotes above should probably be changed to back
>> quotes, to match the "You can also use OAuth2.0..." below.
>
> I think ~/.gitconfig should be in single quotes, its not a command.

"Is this something the end-user would type verbatim?" is the criteria,
not "Is this a command name?".

> Gmail supports for OAUTHBEARER and XOAUTH2. I added OAUTHBEARER
> just for the sake of a different example. I think adding a choice
> between two will just cause confusion among people.
>
> Outlook supports only XOAUTH2 (which is surprising since OAUTHBEARER
> is described in RFC, and XOAUTH2 is Google's).

Your examples that show that smtpAuth can take these different
values are certainly good.  As we know what these two services
support, it is worth saying, no?  Unless it is like Gmail supports
both but git-send-email for whatever reason can use only one of them
to talk to Gmail, that is.

Thanks.
