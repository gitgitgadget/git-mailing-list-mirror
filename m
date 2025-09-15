Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DE4A04
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966470; cv=none; b=EvNPgg+7grmV1CXDSJKWeeqft/3D887fbMyTPZ5mXDHGi3f/hsDRtHf9d6aWeDSz2AduIO5xAI3bYgHzI0isHZH/7RWGT8Ns745ykJ4/QteEK0nqPAXBSFTwNgAryHl4Gq4T/ZZQRiyMBJzxGSNUmNFoT2yfjoMRh8PwuwzATG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966470; c=relaxed/simple;
	bh=jEmsdt0sry9c24c1naPVkLWv/jrcn5tag09Hv9HICsQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XQBMsGsAxU6D1ieN6xepApG17rNr3ytTbMq6cslZ/YDM+fdSwtwaUg/AdyMrb8pFslt+/gPX3ABYsk1cMnNp+4JpMz5u6g3/MijGEVK9HGymXQRIkKDhNqUK1SGK3FOMUtnDwOXKTRQwEkBQ1fzCIH0ldI2RThL3wGM2S+ySJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=XXuP74Vk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJZQiSu5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="XXuP74Vk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJZQiSu5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 570DBEC0218;
	Mon, 15 Sep 2025 16:01:07 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 16:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757966467;
	 x=1758052867; bh=MS+vixxtnD/1h8lprplEZvWXoVkGVc7u7aDvC2Zyluc=; b=
	XXuP74VkQie7VcGWHAVHiI6sW17rafMU5YdcCmDWVUMI69rboC63yQ8N/a3uhleJ
	/WGlof1Phd3BjrzJEE7K2fiN0mhbSwVaxvWY6fR/QTclc1dtker8z2wbcqfBFO7j
	59+Jp5AQx445vOgJTCfvN8+llBscDAnOpu+7gsN9ufKG/1VridQJ50J53R8xE2GJ
	KH1PsvQkuIH0NONEkaEx2ce2gUowN5+2nW3hSF69MZqGIh+2HDz1mVc8SNbrGxU+
	yL+dolR+elazXJ0FiSCs/bI5QaO15EPZ2LU+bDhlIjn47H18gdb8KTykv6XDk14A
	0cLwCAu1fiPshhyzYqZ7og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757966467; x=
	1758052867; bh=MS+vixxtnD/1h8lprplEZvWXoVkGVc7u7aDvC2Zyluc=; b=Q
	JZQiSu5/d2DXDazA5IJvMMAXBwRj1DXUGas3W4P2VETbcejOox0xSGDVh+7/B+5h
	HNBcNU7X8N2wUhcEKFIqIefwS32MS1H7w1OBla//vlplXW7JslK0nTcK0fr0qCJw
	zNc8uIOFNuI0TOyXhg5xDAXNwz76yMRCfV4Dv7lXC8Mx8iY7lnAq8/cCYCUy4sFa
	uUm86zkLLveQ0K4vP3Gh5fj+rWmaD3gsXOfBdET1T1QLU1sZFKVRtsRNGM3V850T
	zQkus0pvaPpgbWhyD/kq+5koC0tEwIQs/R/dhCBtO3lJwYqXN+IogGG0irH6DHqM
	hw5GDy81ibzQCcVPlimGw==
X-ME-Sender: <xms:g3DIaJQ5uc9pf0GX47Q60C7rl2K2xk59CUJxV9bf2vIAfMQDDINozg>
    <xme:g3DIaCyY_o8AGyqTL_-DPb5qmTH5rY0M0pt2TctgiIU69OYm5a68B7vA3b_7E3iUP
    sJJA5wTzUiCdlUA0Vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:g3DIaJSHDigoX7usG_A2QXiz7B40avg11PnAzHNjNsrXKGQNeKiAAQ>
    <xmx:g3DIaP5uhKU3HkItHU8mgeQYNCWItBJWsn4DpJ8DF8C_BYOIKxJ9xA>
    <xmx:g3DIaN3PPw_SOFTizotAJbsMDJoQOxITaC3nuPRknw0OSqkeGrJk3g>
    <xmx:g3DIaCBX4W4OheOtql9bMx_6wHIFzCs9YKvqHXIT2Vx4mC_k8XriRw>
    <xmx:g3DIaMiqtifdm7boP9xtThwxP6KKk2Nd63OBFcjianoj-OqE7CgNsSPy>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0238E780271; Mon, 15 Sep 2025 16:01:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2KDzlJCb01s
Date: Mon, 15 Sep 2025 16:00:43 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <70034c35-8f08-4ee0-9017-7faf6f55ae14@app.fastmail.com>
In-Reply-To: <xmqqjz23l7ci.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
 <xmqqjz23l7ci.fsf@gitster.g>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Well, "this concept I do not understand" from many users is not
> necessarily mean that the concept does not have to be taught.

That's true. I'll try to explain in more detail why I think terms can be
omitted (or why they can't!) in the future.
Here we're talking about two terms: refs and objects.

Re "refs": I think "refs" is pretty relevant to `git push`, which is why I left it in
(as "or other references", to give readers a hint that a branch is a type
of ref/reference).

Re "objects": I can't think right now of a common reason why it would be useful
to understand the details of how Git's object database works in the context of
"git push", do you have an example? I think `git show` is a much better example
of a command where the term "object" is relevant, because you can use `git show`
to show blob objects.

>> -Updates remote refs using local refs, while sending objects
>> -necessary to complete the given refs.
>>
>> +Updates one or more branches, tags, or other references in a remote
>> +repository from your local repository.
>
> This is a very good rewrite of the first half of the sentence.
> Complete loss of the latter is a bit disturbing.
>
>     Send data that records commits, directories, and files
>     (collectively called "objects"), and update branches, tags and
>     other references at the remote repository, to make newer part of
>     the history available there.
>
> or something?

Will try this:

    Updates one or more branches, tags, or other references in a remote
    repository from your local repository, and sends all necessary data in
   those branches or tags that isn't already on the remote.

The goal there is to make sure the reader knows that git push may need to
send a significant amount of data, depending on what's in the new commits
you're pushing.

>>  OPTIONS[[OPTIONS]]
>>  ------------------
>
> Moving the description of the secondary effect down like this is a
> welcome change.
>
> The original had two blank lines to separate the previous section
> and the subsequent OPTIONS section, but now we have only one.

Will fix.
