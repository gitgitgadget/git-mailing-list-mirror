Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D226FD88
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721410; cv=none; b=UA3Z13Vu3BDsHqYYh9xrGCqCd2YxYbmk2CITOP/mIOcNFlOshin1uHw2DK5rlE8hkij2D3+C9anRnjwiyBFIxd5IRVWjuWoIDdLTH1JmZad9HPK2e9FDIcsHrVLaMncUrP3UdtHn0eyir4QDWOlPbYYP0651m+fYuuVpv5K6KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721410; c=relaxed/simple;
	bh=fryy7JRWjRFW+EiPrZFR/zOKYxMPxeK4akJiID32CBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usbkhPUwL+RUV7znmp5BX2sgfiAJRkUAQoSUWXABxiEYUZrX/C+ZWMSWuEH6Pp5dx0j01gWaPNnt4+fiqNaBLTSMQzOTVBd5w2j80VJILk2wuDmDPu5Y/JH4WiTKDD3bjy3Kf0L+j1as1iEYOVQMMjH/2aTY0Wb3goACuHIUMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g+CzUTyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XqUJiZHw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g+CzUTyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqUJiZHw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 02A30114010C;
	Thu,  8 May 2025 12:23:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 12:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746721406; x=1746807806; bh=Yl961HYkms
	LzMLtvVPcoCOrv+BKv6rUN8IItzgH4SHk=; b=g+CzUTyTVXDFIOv1o1qAR5RqwW
	aGmhHJMyqQYnLbkoUPJDVIVbeAYkHCd9uayPVbVMDC0z4xhcJ29OmfMoQLcZcM2n
	+4HyYItGk4gVFIx/FRvbFWcU5KbAOh/YkTFJTG2p0F70l/5RCnccXYjcwXtjoGPN
	VtoqInGjrQBmb/NvG5nNXrIYl2QWxn2OgSvQDe2SomUOVpuOB4wsfItn5h7R/f1R
	28rK39hrHIvzua3h8NRtE1eQYH/N5VE+qv4Hht69Jl0oiJGtdSrVqg4fDSxcC+hF
	wW5vjdT/zTF3pT3bHRbrwPT4hTGDuyx25fGzS3RS8XfM/RLdNNeBR9F5TWGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746721406; x=1746807806; bh=Yl961HYkmsLzMLtvVPcoCOrv+BKv6rUN8II
	tzgH4SHk=; b=XqUJiZHwaUMzprAzDbuj/JnPJUlNHc2fyikQFr8dg9KgzRy+Zmt
	dl90TwI1rxh6aEyNcioa8X3ZnsFvRWuICWGXV8asaRY9YXjvboFhGgQxvLawze5X
	VRDfmsANFOozjjKJ7j3So9f6MiWRN1bQWtLfPzWKkOBKM6drmkYa5jaPk55dwdME
	GOaYaJ8SQsZHcj1E/HjzeNEDPj5/q9Xs+kgtxue+0/H83p2cYlovOW85XwjZTKWc
	9BifZEjN/QnOPsoWsNWRjDw3CIVkilIwORSVdKgZ/6FWCVO5D14d+/avR8cDYxdC
	OBkpr1f8t1ryWRCxQJQU0kuo578MiIs+5AA==
X-ME-Sender: <xms:fdocaLRFAVWNBRtnNTDQY62Cr1paEBIe88XHyrBq5PO61VCD15bKug>
    <xme:fdocaMyBEPjX0-F0s7OcKbIvlXw_bd8vQS3BRV4V0dcQX4obPL5YkCYLT2MfYe3Jg
    sy6-mczk4T5kN1zAw>
X-ME-Received: <xmr:fdocaA3kFPvJc3kE6v4P203tGARUssjI9DYNEbEBIj-vIaOHIw1QZQPro_8pS9C3UuRGg8KUdBK3J6MJiE6FiQbEWLmn3RJ-QZag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fdocaLAzqHNovMd0Nbiqnhb_Tf7n6i0M-FV58oMjtdbVYN5UvlGaIw>
    <xmx:fdocaEjmkd-0OATx4-Ytq-PGWLYS2CdNzd3v0pZdZBhhnGp8G-wWEA>
    <xmx:fdocaPpYSoF7tPGx6c370mVqG8AGZu3ngP6jB25kl09SNs0XtEnwaA>
    <xmx:fdocaPgPrh2VISlZY8kzjly9PYS_6GMB-SZgqyzPYipTxvbxgA2_5w>
    <xmx:ftocaBUl5LppwWqlWoH-Ypw7uhScAaLpjokl-Uq-fOz0IpAEt8CwB-45>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 12:23:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  M Hickford
 <mirth.hickford@gmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
In-Reply-To: <PN3PR01MB95972BB022C2297D3E52DE78B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 8 May 2025 13:52:26 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqwmar8bw9.fsf@gitster.g>
	<PN3PR01MB95972BB022C2297D3E52DE78B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 08 May 2025 09:23:23 -0700
Message-ID: <xmqq7c2r6phg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>> "Is this something the end-user would type verbatim?" is the criteria,
>
> So the end user won't type it. It's just a path of a file to be edited.
> If you still want to change it to backticks, I'll change it. Do confirm the same btw.
>
>> not "Is this a command name?".

Then perhaps 'type' -> 'use'; the idea is the same.  Are we showing
the exact concrete thing (e.g. "file at this path, which you would
spell `like so`") or a concept (e.g. "per-user configuration file")?
The `literal` mark-up is for the former.

> git send email can use any smtpAuth method that is supported by Authen::SASL
> and the server. So using XOAUTH2 with gmail will also work just fine.

OK.

> As far as giving information about supported authentication methods is concerned,
> we are writing an example, not giving a detailed guide with the providers docs.

Yes, but giving a passing mention, like

	You can also use OAuth2.0 authentication with Gmail.  Edit
	`~/.gitconfig` and set `sendemail.smtpAuth = OAUTHBEARER`
	there (they support both XOAUTH2 and OAUTHBEARER, but the
	latter is more recent and in the standard):

	---
	... example here ...
	---	

would make it easier to see to those who learn from elsewhere that
they can use their e-mail client (not `git send-email`) with Gmail
with OAuth, come here because they want to use the same account with
`git send-email` too.  If that 'elsewhere' only mentioned XOAUTH2,
writing something like the above would be more helpful than using
OAUTHBEARER without mentioning XOAUTH2 at all, no?

> Also, by this logic, Gmail also supports smtpAuth=LOGIN with app passwords.

But the question we need to answer is: does talking about it help
when people want to learn how to use OAuth2.0 instead of plain
vanilla password login?  I think talking about smtpAuth=OAUTHBEARER
and smtpAuth=XOAUTH2 does help; does talking about smtpAuth=LOGIN
help?

So, no, LOGIN is irrelevant, and I do not quite see the above as
making a meaningful analogy "by this logic".

> Plus, anyone reading this guide would most likely be a newbie, who will be more
> interested in "how to get this thing working" than knowing "oh, I can use XOAUTH2
> as well in gmail".

I am suggeting that you can cater to both of them with minimum
effort.  A newbie can fall into the latter class; those who used
XOAUTH2 when setting up other software (hence they know XOAUTH2
works with Gmail) but did not know that OAUTHBEARER also worked as
well.

Thanks.
