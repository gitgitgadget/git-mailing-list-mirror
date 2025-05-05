Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FF3118E4
	for <git@vger.kernel.org>; Mon,  5 May 2025 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488981; cv=none; b=jb1dQjypQt1pPFwOeTgZjHw6rGa3MMGj0RN0IZzOLWqv3qWAZrwPBRfMuFmUGW/OPqdjUj6lvQGIOJadUzQYF7gd+3gnvaWaV6i+f5kHD19tcIrSu6FjBsZ5hCN+ToTKnjk42dJzN2cEU7iWhLxENSvHHM1g22Y8VJ5s4KjPqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488981; c=relaxed/simple;
	bh=JtNYBCKDeywS7YymHX0j5mNcHUjxHVOEqVOCMbPs3jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mtAUxtt0G2EKqFtr0ob8mS8OqTfzsCFsmu8wuIW0WiFUCRt/6W0VRli/o2gDjidr3bqDiHWL1+dlhySOIvwvpWDEXOkAsUK6TuITArBpovBM3SCPd6EoqmOhTnKbk/6RuOk4Mop8x7Qnxz96hPVeuNoAlZkDnJSqckERhVsFWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeLXCHPT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENwhlb6C; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeLXCHPT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENwhlb6C"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AC00611401C1;
	Mon,  5 May 2025 19:49:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 19:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746488975; x=1746575375; bh=tEArSvXLsn
	yKC8oddn2mhIJ8P6iW6YFejomXUSZzXi0=; b=AeLXCHPTq5F4MOAeoCQz5G3Gdt
	S1Hgv7meLYASyp2dPgB9/mQXr9mJW+ElKucti4VZXNttoBdVyoUqXqHjnuRVfFy5
	4d54sNVGlpE9ttugvnYO6odtKqjxL+3XE/muS8GA4AYCkwaLSsWfCF1KuliBYG5t
	Ee9m0RHDL21i2VvDBROe97y+ijHMIs7iouy/Mhvhzc7r3opqcOEATbf1aTMQDgdh
	mW/G8tT/WLfxg6dllBK9knANwEItvG2Ulbt/5g71IFKb9zRorlPTm7kbCI8UI4gJ
	Bib7+66KR4gsMW1WlN8KNkbZQdkK8Kua073880X5i0XvxQ7ueIp06fPYGHOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746488975; x=1746575375; bh=tEArSvXLsnyKC8oddn2mhIJ8P6iW6YFejom
	XUSZzXi0=; b=ENwhlb6C4L/LqvlpADnWVj17s0o5wwWbwFUTz346giPY6cZzLdN
	PfndJJ9mshh+snidmvjcu2GGmCCSl0FXKpKB/pFbJJp+p8vTQeJF39+soRihowj9
	RI3zxclbhizpZSpgNR5pdpugqGCGY/LvlUI1sR+fDNdbtO/yIvZdSZFTLCQ5u8Vz
	62Y65vknRU33ahqyu3tKXcM26lBpuAaphCuRQo66EMzZ3wnuuE9rOpXvWNFJLS4T
	aNs7hQ9BbvRBzZfpRHo69Mp8afBOJEu+noBi8c+HZDAqYMn8s/vRvgA3Vz6olPRT
	Yc3f08l6zEjeByqIlsshm/znE4QHDuWUnQA==
X-ME-Sender: <xms:j04ZaGse3KUWN0UlQPq2sdtH1_HJXcfBmF8R1ZnbRRvSDFNxAzx27A>
    <xme:j04ZaLcxp35OK8jIHQSAU9-E_9D0XhL_cQqdp0zMGltvMEITvIKY7tjFhqIOqv-Q6
    HApHqDdvVGTRXWCfw>
X-ME-Received: <xmr:j04ZaBzt7qE-fryAvU_7KL-hNB1lsHLuSL-4hI328FQXwCxmpDKpVQtv5KmjNm21QD45Iu37lL6PJMCiw67vTkA3acaMV1-da2uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkeevkeekgeegfedvleefteekleeihfef
    veejtdetfefggeffkedugeegkeejveetnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrh
    hoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:j04ZaBOJdb6ttSktdu8bw_fdxEKCFd8IVANWVM-soIFl_lVq0OV8cA>
    <xmx:j04ZaG8z-sTRXLA-NHYa_IgzYh-BOOi7naNiT8EisKZRDDRrNCHsww>
    <xmx:j04ZaJU8-NWXu9SaUax-YLZXJvKhlRxfdN7jAubHcenJVAHooZa-Rw>
    <xmx:j04ZaPc6GaNppomXF6rxEfe-dLQmQv-sBP8IJly62yf4DaSqDjCHOw>
    <xmx:j04ZaHiww6vARqqRvdRvHINMHRDlkCsLKqLtZLYOj7sU8tHQWjmOKlIS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 19:49:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Julian
 Swagemakers <julian@swagemakers.org>,  sandals@crustytoothpaste.net,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
In-Reply-To: <PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 5 May 2025 15:23:03 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 05 May 2025 16:49:33 -0700
Message-ID: <xmqqplgmlisy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Due to current implementation, I was not able to send emails from
> Ubuntu.

It may be that send-email did not complain, but I have a suspicion
that it the above is only half truth.  We do have an ugly last-ditch
fallback to claim that we are localhost.localdomain, instead of
using a misconfigured maildomain name that servers would not like,
but that name is a meaningless name; from the point of view of the
server, if everybody uses that name, the name loses the meaning as
an identifier.

It is more like due to misconfiguration you couldn't send e-mails,
and by tightening the condition to tell an invalid maildomain name
and have the misconfigured maildomain name that is invalid replaced
with "localhost.localdomain" fallback, you managed to send things
out.

The real fix for individual users may probably be to see how
maildomain_net() and/or maildomain_mta() gives you a bogus
"Macbook.." and fix _that_.  Until that gets fixed, trying to use
"localhost.localdomain" fallback might be a good workaround, but
that is a workaround, not a real solution, isn't it?

When using this fallback, we are at server's mercy; if a server
checks the name you give it against your IP address, for example,
the "localhost.localdomain" fallback may be rejected and you would
need to figure out the real maildomain name the server wants you to
identify as.  What I am worried about this patch the most is if it
is tightening valid_fqdn too much to make a good maildomain name
that real users are currently using to cause them to instead use the
"localhost.localdomain" fallback, and their SMTP servers are not
as lenient as your case and start rejecting their requests.

With a cursory read of this patch, I think basic "at most 63 Alnum
or dash" DNS label defined in the ASCII-only era may be sufficient
for 99% of the users, so I am not too worried by this particular
change (I do not think anybody uses those UUCP!style!addresses
anymore these days), but this patch is an example why we always
want to be careful not to introduce unintended regressions.

> Upon debugging, I found that the SMTP domain was coming out
> to be "MacBook.." and was being considered as valid.

"as valid." -> "as valid, which prevented the fallback
localhost.localdomain from being used."

> As a result
> the script was failing. The debug logs with the failed script are
> below:

Don't give overly long and irrelevant details.  Say something like

	The SMTP exchange started like this:

	<<< 220 ...outlook.office365.com Microsoft ...
	>>> EHLO MacBook..
	<<< 501 5.5.4 Invalid domain name ...

	Notice that an invalid domain name "MacBook.." is sent by
	git-send-email.  We have a fallback code that checks output
	from Net::Domain::domainname() or asking domain method of an
	Net::SMTP instance to detect a misconfigured hostname and
	replace it with fallback "localhost.localdomain", but
	the valid_fqdn apparently is failing to say "MacBook.." is
	not a valid_fqdn.

	With this patch, the rule used in valid_fqdn is tightened,
	the beginning part of the SMTP exchange looked like this:

	<<< 220 ...outlook.office365.com Microsoft ...
	>>> EHLO localhost.localdomain
	<<< 250-250-PN4P287CA0064.outlook.office365.com Hello ...
	<<< 250 ...

	and the server I was using to test this patch was happy with
	the fallback "localhost.localdomain":

perhaps?

Thanks.
