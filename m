Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425F3C2786
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572723; cv=none; b=ashhLc7IQdc5uM37J2XDoUySZy+Oze+uq4FFR+SECtQ7ygvoXjcWwyaxqqXmhOrBnsXncDAYJpYl1WSnDEnIMdX8WTkbyaz/Qaxz5OYFLSP7yBsDUjPNH0Zi/g41SfYPr2mY2FgA843BCB4JQWXFWg4zHpmJ53qNlsi//pbicAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572723; c=relaxed/simple;
	bh=+L9Bumhf6Bg9TmX7eBkhdtsd8qz6M/zrqICcdDx32wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnOSCjHC2/ZvU3WWotDH9EtF80rEy9l6gXcgP8oshXcarfAGOkIFq/tmVQHwjKmWFttfvTcxSwElk6PotjQSaqwebapA4HLbi2meRY04O1bE7RPZlioojJepXsVKbNjo2M9/tzwfXiuqlP+6WaZKEEmKuGwLFRzR1LcFDMFEgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RAHtwxjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYUe6pJJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RAHtwxjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYUe6pJJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A5434EC0592;
	Tue,  3 Mar 2026 16:18:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 16:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772572721; x=1772659121; bh=+L9Bumhf6B
	g9TmX7eBkhdtsd8qz6M/zrqICcdDx32wU=; b=RAHtwxjLR8eRl/mrKgQoBQW0x6
	CBO58t4+jDp8sfN8nIfkaEImFBKwm+/vHlcf9ucIdDcUj+SPQfGIE2/y3EzebpGs
	Rt1PWe3x9CKKtLFj8SJpB9Ac9rSW60D7w7kjub33gsmih815toWbT17BdCmH9ozx
	10FThiwebG9eu7+mBIDz0ja+QhC4J9jnUeyOnwVfCAoYmJ2ouPCTFQPxCz0NREP+
	PkFe1rnplb4SPZJB3LMNECAOh8CwW3uio+ha6BERUiyPBBGIxSyzau5kFKgy68jG
	90Vlz+1lWjuUq35PJDVxWjrgM/l0ip3a9ZAPb+j/j7rrVBlBIdrjKVQotC3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772572721; x=1772659121; bh=+L9Bumhf6Bg9TmX7eBkhdtsd8qz6M/zrqIC
	cdDx32wU=; b=nYUe6pJJNau1CgO86MBOw5lxvmBfVVioev2wSVzJlWLnOm7pNgx
	myfYLan73iv7x/WxOxL/3jOi660oSko02c+B69dROYXwNzYFJiY3uGc2m+CqgGGY
	+2t4iz0eLZMV/13I3+kt/I5wjvIe2tnjJsK9sWHMzRgse2MyNHtS3SyshGuNgfSV
	wy8QD5oBAu0X/FHgOX3GY9/ch6u1Xd+e/j9/iXHq/aiiO3YQoJXtxJktM0qvJuHm
	FdG7q6uQlvM8Jb4aPF+TcbmM308npwu+80k9dKpuYL9iOcvxWoq3wNFzan1iIGYM
	aCtUvKEy7s6i3TB5ShLzlsNRnQ+Ethbf9nQ==
X-ME-Sender: <xms:MVCnaaWjif8CTjdKdoeoqjTTsUYs_KaflOgWWYKo-62rXnufq5l0mg>
    <xme:MVCnaYEVXu6hj4wgF4ayNF3c3d0RDm6MWUPoI7Om72ZPB1dSUUwF4OM7WtNBcKd5A
    309EOSK9yKHm2zq5XdsQeQ_9T_DRTwOjdiYl31vXfP05zl-4nKH86E>
X-ME-Received: <xmr:MVCnaefKYutE2BYbc7QF2IT84j47s96JLmDLF4vqElsjpGtUI3scrHXkUO3Uv9onhCeLoZ-Cq86VtkAII9ulHiOzN-uZNV6vcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MVCnaRJITF6LBn_-pZf37QzK9RFlrBQNmxQDnOG-glkRVfyqi5ILdQ>
    <xmx:MVCnabEjDBKBtjy2If42qUmx7XQLVdEx1f4YUDEkWcIkClCt71GMNA>
    <xmx:MVCnacB52fOzLU7U0PflDrrliDOfEQWKfTVQuakk9SnlJ0fZTEg-Sg>
    <xmx:MVCnaW-xvjyVgPBPknbh2zSbunChTQqIBie3lMaOTm9ANuPs2Bz5tA>
    <xmx:MVCnaYe35iywNwEqclV66cp9cw3A_bQtuSkgVleyS7fbQzNh9FFZ-Vwy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 16:18:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Li Chen"
 <me@linux.beauty>,  git@vger.kernel.org
Subject: Re: [PATCH v7 5/5] rebase: support --trailer
In-Reply-To: <22e1de8e-935d-4efa-9fa8-ef8d9b4ffc6a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 03 Mar 2026 21:36:53 +0100")
References: <20260224070552.148591-1-me@linux.beauty>
	<20260224070552.148591-6-me@linux.beauty>
	<824809c3-72ac-43fb-8a93-4f48e0727e6a@gmail.com>
	<22e1de8e-935d-4efa-9fa8-ef8d9b4ffc6a@app.fastmail.com>
Date: Tue, 03 Mar 2026 13:18:39 -0800
Message-ID: <xmqqqzq0boi8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> I wonder if it would be better to add the trailers before the signoff so
>> that "git rebase --signoff --trailer='Reviewed-by: ...'" adds the
>> "Reviewed-by:" trailer before the "Signed-off-by:" trailer.
>
> Why is that? Is that because that is the practice in this project (and
> maybe others)?

I do not think it is a good idea for the above sample command, where
we can argue that the intent of the user is to have sign-off and
then reviewed-by, expressed in the order of options given.

If we want to control where the new trailers are added, perhaps we
would need to match the --where option interpret-trailers has and
let the configuration honored by that command take care of the
ordering.
