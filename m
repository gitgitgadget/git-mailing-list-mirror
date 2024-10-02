Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEF12C49C
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862465; cv=none; b=qRmRi5JDtMUh/lvd31ULupjUsKAM4D0rRJdvcyu74+c3QvDfrGeq6VwHVROVwlTgreOYUdcMS2JZ/kiQgBSA+/ayp2wjYtcYqb5fbD/xM0BCcFEtMZsp1f/s5SyLvyU0AnURCil5P7ELMLoCY1IEdjMa29Q+dBPG6bpyp1D/6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862465; c=relaxed/simple;
	bh=Z6VK6XYdRXLREt726c7oDTDOqUYI6H+hVt+ioi53Qjo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MISeCwefRP3hXsoo0ElyTwS6V+RDVfb5HOsgYem++CIrnwLMKlW+9VAJuj44TJPCOyFoa79Vsrud2govJxjq8aB9AA3cY/LXuvg9Ng2GGa1C1agwncVuR+yaNewZsYY98RMuC7ALcQ2Ply0K6BjS2noY+lMnJljENuJkk5AgJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=d3Wn03eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFSc9zDd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="d3Wn03eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFSc9zDd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A85D11401FE;
	Wed,  2 Oct 2024 05:47:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 05:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727862462;
	 x=1727948862; bh=NiYJmy/Fz/XP9NIlHhyQyI+zPkvP1+0qINbIJRbyn4o=; b=
	d3Wn03eMw9pN114sVRMmh3Drte/BNI/PQjO3my7g6ZawiDGGcx0iUhGS2VoKMb4X
	gCmuFHPhpbS0C64ZE0amg4Lmy/QHn2VkqOrJQYwd+ZlhjutcLnwFUno0MXGNCY/2
	+6ybITz4bso8yXEKwQDWZQTEmEBZYvptgs9WOmG7fphKkeUTNVhuNaWk/nXD7F5k
	uvuu937NqTicm/eERg79z0SkNo/t0v1TOm/VyAuU3y6xEEzR2k4ba6bDttFavifg
	y2jV0gT2G+8SU51FR93KQj4CZjPIk38MMzFOGibe5L9JivqoCZP8PJ1ShKOdMNYh
	7ov8+AjyuIyQcPF416VCJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727862462; x=
	1727948862; bh=NiYJmy/Fz/XP9NIlHhyQyI+zPkvP1+0qINbIJRbyn4o=; b=X
	FSc9zDdiFl59oxSQWKZGntkCs+XW0h80e2D0Cp4QtsBDR9N3sYLzxKcjtYkvKQZ9
	ecXGD4ZeudpvApROlZDYO7+0H0Mq54jPMWTJnYFw1WjFNygR9BrCkn01pbRWkfUo
	lJqBUZVaQSay9b3TFAsS7OyIMuyftHuTBeyw5IQc/tn77Lai9dYKX/RujZS5MKLV
	Reaj34X4BT+3lMVOCepj2fXoUl66WlfkOwLVvTR8nqaEPg3lz/jWQk/ZLmPbu3b+
	IPtlAEv8MSlEVYBYMPTxpdzRNBSr0X+rQM5iFRI+wQAvrZlvm2rbN4e2MToJ8bKX
	hn9o5joJXMDtqVduqB9ww==
X-ME-Sender: <xms:vRb9ZlLQnaqeZJJnkRhUJk5c_VsEbmqwZFdzeZT8KMPb_4Dd9qh19ZM>
    <xme:vRb9ZhJ76d3cKwqMr94XyFvDyGd5HYatln4NqqjH7buzy8LV4G1zrjEFuGcJ92CzR
    crHRe2F1abPB6iGWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmhhesghhl
    rghnughiuhhmrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vhb9Ztvq80h8rGCC6Qmbip1YKY2ATnXdTADMjlHFvgRRM68ml6YkTA>
    <xmx:vhb9ZmYto-W2Ji_Lb0ECBZxfi83X4hLBWmTWmYxQRjQosxVdROGzTA>
    <xmx:vhb9Zsa8j-vIwQrlDx3fL-hql4PAG33rXbeecpqSyoD8W3F4JdCV7g>
    <xmx:vhb9ZqDgO6sLFoymq3y4W1XWeviELji7XMTYx2NgafwZ5lj8J4VFWg>
    <xmx:vhb9ZkG6AwCLYBdTgVQGCsau0gB7jrHKGXQLty_8r3nJQedwsCG0pWl1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8ED8780068; Wed,  2 Oct 2024 05:47:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 11:47:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <cec3d068-38d3-4802-b2d0-77644dd425c3@app.fastmail.com>
In-Reply-To: <20241002090606.2076645-1-mh@glandium.org>
References: <20241002090606.2076645-1-mh@glandium.org>
Subject: Re: [PATCH] Fix unused-parameter warnings with NO_ICONV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 11:06, Mike Hommey wrote:
> The jk/unused-parameters topic enabled -Wunused-parameter. Some code in
> some non-typical configuration lacked annotations.

You forgot the sign-off.

-- 
Kristoffer Haugsbakk
