Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B286359
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650941; cv=none; b=JbUxNHcfzLVBxgXwMHPJx1pWdufG8DgM4Tcu3H5kZljpBdzL8GvavcmcHefvQL/VRTQU9HXGmMPHAXBJaZ1aibbv/T+hwjB1pbtrLq1ud2UFBhV4Rn/wQt7FShaZO/sl1mZPgIKBDj/QU1R6bML9S7qxeaH0RtYT4apE+OmJxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650941; c=relaxed/simple;
	bh=LtJ7znj3m17S9c1M34DwwQM14iOPdG6umVOtb8/NMEs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qP6EAoXTtnc6pR9PH3q440kMc+dyM6obgGforZP0qfrUQ27zGDNDzbBTPNgACD/F9FBOtgfGdWmRm9m4ky2tDDC4t5kwY/c5Xj2N79xwXOEh+9LlAgHgHV4L0eabMBqJrsqCoc8KXKjSnxQCxwwbcierE8r0omAYZCJO6N68Jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=JSSZD22M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7aGrgT+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="JSSZD22M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7aGrgT+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BF737A02FE;
	Tue, 23 Sep 2025 14:08:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 23 Sep 2025 14:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758650938;
	 x=1758737338; bh=H69mDqxu5iKGBDa4QMwRzxrW5UOetLMoTLKu67eo9vQ=; b=
	JSSZD22MXvCa6MQ6ZWFaYgDRLW5o69bmNuwXapRnZFryBns3DBLuaPo9kG+UrjRN
	iv3S1FOxEr+dPK5r/k2ZFjjJFaWwkIi8QT347PbVnqOi8FTmR0iO359RX9HSyqzp
	i+Hl8+ViPW0gBmmlFvR0+KSupNjb+s3sNbeoZKiBIXI9bU+qvBf6rvhr8DQ9aMBA
	leVO25/8XV89eG+7AQpyNORQc78zzWk5o4gcQwv8X0ly+Ow+3aX0I2qDCCSIFCU3
	BMA+y0pTxwsMe+aDgvvWigAJRr7sm+rgLKLYNM4vH1gTnYIKpUJ4qAOEpCrBMkTM
	UFqhb+9qJ+ZwA9UmsPwKvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758650938; x=
	1758737338; bh=H69mDqxu5iKGBDa4QMwRzxrW5UOetLMoTLKu67eo9vQ=; b=X
	7aGrgT+363+FiTNAqX8Ch/fU0l6ulu3itnMZV+isp4ks2E3oMODNHxzGLRggwNXy
	5b+bL+Yn78GKG79vW5mVjDGM5qZOQ+Z5rQtUT5ojpmVOZIumcStjT7krlUUsjCJQ
	iWUhTldH+xA6WAHEVO+agwuFb6hwQxlEQH0r968ROdODwy9oBmfe6YLFlSSMG+iJ
	mZFU+ht2MrlrRnTR7s0jkAT6yz1hCK6F5fzzuU67rJVfgHk4LGMybjahhvuZd1Ft
	CLa0onVhl0/U8xoqWMVEawAi0gRvvMI0wp1cO+M+zuCCZtjuFYc8xg/E5Z+7R7Iy
	USmEyBjoZ/Xxu8RiioVnw==
X-ME-Sender: <xms:OeLSaDilgBahc_w_qWxM_tJ8YUf0YodlQX5EtyrZkKoYC1LmJ7KQcQ>
    <xme:OeLSaK18ZeRgjVJczxuJXt0Q9PwWKEvhwFxdjNs07TRE-7xlLJNGX5xok12vlJPq3
    Z79Yj_mZmOZ3BlVljkK0jz61X33hzkm3oXqofMZLQaBkP96IWl-lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    ekiefgiedtieekjeefveejueeggfehheelgfegkeelueelledvgfeigeeltdfgleenucff
    ohhmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OeLSaGJTCA8kqs_DB0PQF2vT0AqzNZrCPMaTznlbVyQq7Iulq17a4A>
    <xmx:OeLSaL-a7ZSbEWbpTtaU-2uffEhZUugnKv0UYGiF4rsm0gAdiN_f5w>
    <xmx:OeLSaBKzh9l8oRRMXxn5zs6LUlXu-_g8LJdWhnOZkY3UCDR7pgr3ew>
    <xmx:OeLSaIm414hr353ywX-tYBF4xCIw67mqTmoy23tdhMwSv9c7FmSNaA>
    <xmx:OuLSaEkNI-7Rw_iMJ1d8MS4emAnEaIqJLeea0Pz4JQ7GraPdH4mNuZLw>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94AC378026F; Tue, 23 Sep 2025 14:08:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APYrWJik5Pow
Date: Tue, 23 Sep 2025 14:08:37 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Jeff King" <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <955752f2-5695-433b-95d8-a7a40cb41d65@app.fastmail.com>
In-Reply-To: <20250919042545.GA3979@coredump.intra.peff.net>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
 <aMymMLkJg7PkmxL7@fruit.crustytoothpaste.net>
 <20250919042545.GA3979@coredump.intra.peff.net>
Subject: Re: [PATCH 0/2] doc: git-push: clarify section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Sep 19, 2025, at 12:25 AM, Jeff King wrote:
> On Fri, Sep 19, 2025 at 12:39:12AM +0000, brian m. carlson wrote:
>
>> In this case we have two possible implementations, AsciiDoc and
>> Asciidoctor, but both use the man macros.  I think if there were some
>> way to control the value generated as the argument to the `.RS` macro,
>> then that would be what you want, but I have no idea how to adjust that
>> in either one.  Personally, I would just leave it as it is, since I
>> believe 4 is the traditional value used with the man macros, even if
>> typographically or aesthetically it might be suboptimal.
>
> I think both implementations will just generate XML via our Makefile,
> and ultimately it is DocBook which will convert the <orderedlist> into
> actual roff. So something like:
>
> diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
> index beb5ff8ec2..b494fbb5df 100644
> --- a/Documentation/manpage-normal.xsl
> +++ b/Documentation/manpage-normal.xsl
> @@ -11,4 +11,6 @@
>  <!-- unset maximum length of title -->
>  <xsl:param name="man.th.title.max.length"/>
> 
> +<xsl:param name="man.indent.width" select="2"/>
> +
>  </xsl:stylesheet>
> would affect that process.

That's good to know, thanks. We'd need a way to indent unordered lists
by 2 and ordered lists by 4 anyway (to make space for the numbers in the
ordered lists) and at that point I'm not sure if it would even
look good. I think I'll leave this rabbit hole as is :)

> And I think there might even be a specific
> list-indent variable, but I didn't dig very far. I agree it's probably
> not worth going too far into the rabbit hole of manpage styling. The
> parameter docs are here:
>
>   https://docbook.sourceforge.net/release/xsl/1.78.1/doc/manpages/indent.html
>
> I believe Asciidocttor _can_ generate roff directly, but we don't use it
> that way. I don't think it would make sense to do so unless we are ready
> to drop AsciiDoc support entirely (since keeping them as close together
> as possible reduces the maintenance burden).
>
> -Peff
