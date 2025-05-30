Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388D1A23A2
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626137; cv=none; b=FwBDLjMr5X7tfpyfB3l1llD2eWRIoVAiqaL0jZVh0g7wP8pMIF4Jj/ssKHki4N38Ss17i1j4IkllyKLtLTt/4MWTW6wSspce/iBVCxge9w0ppVCVAxTPj19QVIVsQ5BR/MFJyblJbDIJVzPdmkLlrlxCYFkcdWG2mHN3gpSX23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626137; c=relaxed/simple;
	bh=qDodmV0nwSEqjSbyf/Ml0EahXZMM4HaYcyfoPhs5rDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KA4+l3kM3vohkmRm15aG8v5FyuXsh+iyDZhFThBkOxZllSnOM0mK3CWgLrjGTPpaWmWQ9z37GIRbmN0X+N4XfoG0d2bO3AzCdrJY7LUsEDFA5s1Nigqpi/jTCKPdOLaHuoUfVNfVHx8N5Jftq2rkhxp4qlIMdZfJgnoTRCHiqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2Jh89V99; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9YvHBX/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2Jh89V99";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9YvHBX/"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 25D6A114017F;
	Fri, 30 May 2025 13:28:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748626133; x=1748712533; bh=iXzyd8VoCj
	xG7zDpEXrQ0MrYZNglt8wtbGojt0q8tL8=; b=2Jh89V99tywihdOOW41CTaNize
	yXj4T3TrYvTDg9SrF8j9o1bJoFuLsjaYQCQTfea0TXpnRGhSQw4QOwbUjlQRD4pW
	E1gcGH4GRovxP1I6x9ooTfgTQV6hs/MHoB2iQ96F3HAOIUfP6ZUPgimrgPOheb2I
	L52FXGjmCK5iXBH8xIfkKQpFLFOV2majxcH46ZezUQQOeytqxI8V6NhGBXd9+ZnQ
	O1zHNnH/qyobFdeMTzakDDKQdbT4H5NAegMaRYf6MZsCsU6hbC/KIJj8xw9peif6
	ket+HPYGKjWHnuH2nnNLDbEMP2lakeGek1osMfBBnD5MSAyNnbbsHBnQJ9nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748626133; x=1748712533; bh=iXzyd8VoCjxG7zDpEXrQ0MrYZNglt8wtbGo
	jt0q8tL8=; b=D9YvHBX/X5BpeI4UuZQzHzyvInCJTzFk+AK34AEfV1wa+G5GGTs
	Oy5HBrRw/19HnyH8wDWdbmFXt6HRjYiidKFFHfZwywLPKbohxTqTT7h74wXOuxFN
	D0BYXhD2KJz1w4XL2AFpT7CsxkoVeR5Q5y8isXueMD+Ajp4YqYjm7ne9lC7F2Hzx
	ulyemyUKtzb9VdeuYypT6nWVU7uv+CtJxxOrdL154ebg+7c5MpMvnF5Ezjbgm4I7
	fPUM4kFvyV8CIAjbBW1H5la5nO+wYcupBCeyS3gwkT06n0Hbde1kzcNQS+S/NT4E
	TXCPzsJnTXLgCAs5As0Afd0RZdCYMOvdgPQ==
X-ME-Sender: <xms:1Oo5aBrCzKZTIfbOPdF0-hkfeyI3Qqy6K69pEeU-etlfkr4ZbTnFPw>
    <xme:1Oo5aDodgL-ACxCQfQ_w87Y8k9eYzqZHWkVu09wKWaKyVyr5qJ_leszx1syL6q0rj
    WTeUDDMYNTG_rUWmQ>
X-ME-Received: <xmr:1Oo5aOPlptj4XlM0VE6arHEMM3UBjXm869_MLJ2k1L_iRW6FH92CqJRkAogKW7ePgGbAti3O46cfTcueqESGX5gDIKXQ7R6BHmdL9ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeiudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevuefgiedu
    keehvdevleehjeetvdehveetheekffehheefhedtvdevfeethfffteenucffohhmrghinh
    epghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdt
    keeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1Oo5aM4_wT3GBUOZNoXsEo6NcnXSLcNvhPvhI3zTs0DffVwDK6EbZA>
    <xmx:1Oo5aA4Dx5zu4feotZSRDfcQAnxybhQ9YB_kfHkTM-a8pW8qUN_TrQ>
    <xmx:1Oo5aEh9SQPh9GqMLOpKmTIcl66s6xZIcRHl86KwTwxPiHyltOKn-g>
    <xmx:1Oo5aC6Z1s08y5RgxlzHAqUIcvqNJ44kCVf32Y2oZo4HSwH1G6UBSg>
    <xmx:1Oo5aKNZp4Z-Wg6JoqPaRgQRLfFAIHzjTNdhf0CDNZ767L01poR2HiHH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 13:28:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v7 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
In-Reply-To: <20250530154934.10077-5-gargaditya08@live.com> (Aditya Garg's
	message of "Fri, 30 May 2025 15:50:07 +0000")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250530154934.10077-1-gargaditya08@live.com>
	<20250530154934.10077-5-gargaditya08@live.com>
Date: Fri, 30 May 2025 10:28:50 -0700
Message-ID: <xmqq4ix2f1nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +Gmail does not allow using your regular password for `git send-email`.
>  If you have multi-factor authentication set up on your Gmail account, you can
>  generate an app-specific password for use with `git send-email`. Visit
>  https://security.google.com/settings/security/apppasswords to create it.
>  
> -You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
> -`XOAUTH2` are common methods used for this type of authentication. Gmail
> -supports both of them. As an example, if you want to use `OAUTHBEARER`, edit
> -your `~/.gitconfig` file and add `smtpAuth = OAUTHBEARER` to your account
> -settings:
> +Alternatively, instead of using an app-specific password, you can use
> +OAuth2.0 authentication with Gmail. OAuth2.0 is more secure than
> +app-specific passwords, and works regardless of whether you have multi-factor
> +authentication set up.

Thanks.  Much nicer.
