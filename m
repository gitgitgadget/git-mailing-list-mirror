Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F483259CAF
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762551631; cv=none; b=IhaxVblOhorwgABGNvsbP9dlIlmy+LWIjb2xjtCkacYbfvFar+moFsDD+qczt/1GDqV48ZgHSPRSahzex6hc2OtucIDlslEr39elrAHRf0lsKTko19AzzOK3XdkhFuXmPZ4LDiJPTshzA9g8/kR1edz5Ma9mkvhj2/q2Z5rFaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762551631; c=relaxed/simple;
	bh=sw5T0OyALIjb9p4Igs18YrvB3dM1EBbWP5LiUkv9LT0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y4qJOdNzHGzqB9crVHHVaCaWdx4eKxcQgbD8+CcaGH4ebuFqxVM42ONZJ0WZQ5Dk1yze2/TJD9GohAhsjQguYGPM5PufiVyx1Edm/LZeOdwPm6v9uLJC1xkc7n1XwXs0guGtcM5XhiOLG0/JAtnzWsLxTel5D9Luh8OcsrTBsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=GKzH5jYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=irsDqdCA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="GKzH5jYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irsDqdCA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E718EC0288;
	Fri,  7 Nov 2025 16:40:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 07 Nov 2025 16:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762551628;
	 x=1762638028; bh=+v/fX4ZCl0Q9ZzGSfUmmqvF5JyJS/lyVNmKqu6/41Fc=; b=
	GKzH5jYYad7V4dnL51cMZxgPB2cKwzCddfuX19IGpJKCSx5eHNwHMCqEiAWW/sPB
	01yAktf5JZWN/hx4HRH2L9cxbGsKRPskDon6X4LppeKbULfa6gEHNiFX3jwCSD9A
	u4+61wBFWtAH3BM3w76OOoic6VkQ6wjNuMlBGiL0RHZKIXqhsVWj3cEuPMkgiazc
	BrU/Pnl383Wa/tyhvTMQPF7/7soX1pwD+UQJc0aB+z4o6OIXOP60PjonKSqHOMNr
	FHOPCdARgekCPhoNMj7xsLe3e4g6KAbX8yh+pKfXe46qw0mw9UjqcD2nNPOz4OZ1
	vMkskzBSTcaY8mqqchX1Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762551628; x=
	1762638028; bh=+v/fX4ZCl0Q9ZzGSfUmmqvF5JyJS/lyVNmKqu6/41Fc=; b=i
	rsDqdCA5R0lQSypFJnP+Bh9cJgQ5sAICZyFYuvI6YU/O1FzlgrNIWcrap0mgRWf/
	aYpkRZm4Bnt9pueLOcomfCbFQRsGm4xHpce7WAUVmq1REC5rhVogRYM8wxJCZOnB
	wAovg67MC2w28bAW866D3DZv0/lJvo/tpArl27L+trssGHMgIme7d2BphXz8xasw
	KTqBVSI5EzSYwwm+SERh/fkSyURcVOfrN5yaozhDXwK/lUsp84qAPQ1/KEEOExEB
	sNZ9TS4Ck9nh7siiusx6gLJB1MIskCaQZdLl5IMTk5BbpSqtQ1bEItGZE2xmwOS4
	IKzHQNTpWaxQwkfW8jl/g==
X-ME-Sender: <xms:TGcOaWnYiHFU2Wuj4uBzRVSYLmAs52f88Zz8CojuKxl5KQY2zPWczA>
    <xme:TGcOaYpODbREXnpi-cQOMcsVDjQg-sHV5YGJuVhjdmgtWPoTSCVQpu9qOu1YwoJB_
    z2rOmo9kTnIzN2YRpKk3kjcCA7xuL0j-1ML_NhvUr4iLwPBzL4sEow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epteejveehjeejudfhvefggeegtdetueeikeffuedtgfeggedugfekieduffetgeelnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TGcOacS5c_vjY0FW1Fj_D-Z929odp6KSA3lrmXuyzlIBMg063t47sA>
    <xmx:TGcOaTGgySVt8QjJPGfKxjkthHzuVnwfu5rl_1wO-8vPJh1H8nxUuQ>
    <xmx:TGcOaREKZ852_BbGpQ0Szxx_dE2xp49v4b5mqDnTDysS3HtCSMCHug>
    <xmx:TGcOaRSuxgkwrSVEXO5Ii4gL2fFbwRRQQ_moc3NMstvcV5LUkt9j_Q>
    <xmx:TGcOab4bNCwTQRxMasbDdikjG0vlzAwDQ5KEyXGI0FHN_K1m-XnQPW5C>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32D257800DA; Fri,  7 Nov 2025 16:40:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Fri, 07 Nov 2025 16:40:08 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <07cca81a-10fd-49aa-b175-17b49e4f1116@app.fastmail.com>
In-Reply-To: <xmqqseepedue.fsf@gitster.g>
References: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
 <xmqqseepedue.fsf@gitster.g>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Nov 7, 2025, at 4:23 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>     changes in v6:
>>     
>>      * Make punctuation more consistent (from Patrick's review)
>
> Good.
>
>>      * Explain more about when exactly amended commits will get deleted
>>        (when their reflog entry expires), from Junio's review
>
> Looked good.
>
>>      * Be more explicit that there are only 5 file modes in Git (from
>>        Junio's review)
>
> I find "These are all of the file modes in Git" hard to read and
> understand, and more importantly, does not imply that we won't be
> adding any others strongly enough, than something like "Git uses
> only the following modes to represent the objects it stores".
>
>>      * Make tag object description clearer (from Junio's review)

I wonder if it would help to de-emphasize the octal representation
of the file modes, and instead give them names since (from a
data model section Git's file modes are really more like an enum with
5 values than )

Something like this:

	Git has 5 file modes:

	  - *regular file* (with <<object,object type>> `blob`)
	  - *executable file* (with type `blob`)
	  - *symbolic link* (with type `blob`)
	  - *directory* (with type `tree`)
	  - *gitlink*, for use with submodules (with type `commit`)

	NOTE: Git normally displays file modes in the same format as Unix file modes
	(100644, 100755, 120000, 040000, and 160000 respectively), but file modes are
	only spiritually related to Unix file modes.

> OK.
>
>>      * We had a long discussion about the phrasing of "A branch refers to a
>>        commit ID" but I didn't come up with any ideas for how to improve the
>>        phrasing so I left it as is.
>
> I gave you something that is clearly an improvement there, though.
> Just like a tag object records "the ID of the object it references",
> a branch records "the ID of the commit it references".

To me an "improvement" is something that helps the reader understand how Git's
data model, and I do not understand in what way this rephrasing helps the
reader, or how you think the current phrasing might cause confusion for the
reader.

From my point of view "a branch refers to a commit ID" clearly means the exact
same thing as "a branch records the ID of the commit it references" and 
"a branch records the ID of the commit it references" is just a less clear and
more indirect way to communicate that.

> Another thing we discussed and a better alternative offered during
> the last round was "base directory", to which Patrick mentioned 
> "we rather consistently use 'root tree'"
>
>  cf. https://lore.kernel.org/git/aQhcbHJjiI5GtV6Y@pks.im/

I think it would be better to stick with "directory" here, because I've gotten
several reader comments saying that they do not understand the
term "tree" when it is used as a synonym for "directory".

Maybe "root directory"?

> Other than a few minor points I pointed out above, and the broken
> xml id/idref that does not validate, this round looks good to me.

Will fix the broken XML.
