Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2D17A2FC
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306560; cv=none; b=vCw+kIjlu9AlTJHc7BziwpQr8c4I54Z0hlxuYUqwv9MjRzS//lPkLtc7xsFcoN1HdZInDhA94bjRjIWeTaot7MSkFjDgOJ9ecQZo156eens/ZVdCudNS7R3ktyMv/huB8frPVQoVomO2uBTIQO0Xd47CINIM7r0LEJnXoOpOe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306560; c=relaxed/simple;
	bh=SqP7W8shkY2ogiC7sRWYuRh8Db97n0tmvsvlRRQpcI0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=azlYg7W6OrDGccZqJR72cVQNho9oP5voRu8r8w6CESa8PMa7xqtfIbRzsQrjYY/Wwv1Fw5r6H3uuBz/f8fJKua14/dwh+xA9QrtXusdikm8sMIaU7HiX9rkEC4/FFPE2FPcg3j+FrrXqi+ngnWSx9Exvj8dG+IiAtQGvATPyywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bSwAcIAo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sa/YwoP8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bSwAcIAo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sa/YwoP8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BA967EC0184;
	Wed,  1 Oct 2025 04:15:56 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 01 Oct 2025 04:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759306556;
	 x=1759392956; bh=SqP7W8shkY2ogiC7sRWYuRh8Db97n0tmvsvlRRQpcI0=; b=
	bSwAcIAoopjeGN762SQVjQ+VQ+QT8IDdEnawh4fL3q6pBUTCydWzyMHTc+ctQmQQ
	zW5QWsonQRHaO70S0e/V1rrcA3fDheZIRSCmmkmJHAxjEvCF6PhDaB7bReFFgTek
	Z0YvhigkghO1dKzwzVzhDfHdcY3ehUiPy3xF/2x+2wa709UmjYjKzJn6G+SDiKAb
	s5irBaUiavEGqrkRuwlcC60XgaNp9hWaSE7AkMLf5nnxbAW1rIxWZntn5x83DNmi
	3yJ8QHX9HuJ42y/xK7Z8zO1tL6ra+SbWlMr4TFcLSgqmy5kD8N8f1+CAkUlJkHN9
	lLqZp5NPEJFytOLUrF1+vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759306556; x=1759392956; bh=S
	qP7W8shkY2ogiC7sRWYuRh8Db97n0tmvsvlRRQpcI0=; b=Sa/YwoP8zySqfLKmk
	/3ftxiv740+H/fSZUltAkBEwUZqgqhPvu9AoJFYskkCQkHxw9uzqhpkVclLbDLUN
	aCISdQw5FCU9bGJxQJFW3ItDmor9Ku2Z71smL883YRHDp1rhgRZHROoQfpPFDCEf
	eugwx2xplKykYU8V3XIeOlvpv6sQMqNLD+6JklCPdA96fDOjFiX+dO8VEzgztyNO
	Z+iHaA1Dr5iwlYJQ90HpyUEDS/b7kl1T8RSF/XXVmqtxJnrUekJJGwuqNREcGCLZ
	WeveCnw/K2ckeQzSx3Fbjbp7gCMs5G4RJgSoBAt/MXQUuiNizhFdSuABqOsaNeo2
	0kQqQ==
X-ME-Sender: <xms:POPcaF-ZV9pfu82Qf-yJLlEjE_gwO6MZI3h05wwx6e0wDIM7aqsPhZs>
    <xme:POPcaEh7OkwlGERsIzs_yA_LVJ2jI6E5AVBGNTIxeExapSX3Km3MA7dEsmFth630i
    meXMegepIJcFno_ZtOLmGKGAf57qh1xwO0v6QiEYrJAA6C1oWjy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpefftdffhfefffejfeffteetvdettdevfeetheegtdehtdeiudefffdu
    leffleeljeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehhvghnrhhiqhhuvghgohhgohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:POPcaEoWxzktU1_SmG2aHax7ryRAQdoIBc7ef-RfBNComX2_IFv5NQ>
    <xmx:POPcaIlC3VenoLjGC2SlQb8eNUfbe6zr5p8oyNqw81ubrYFNhm7-3g>
    <xmx:POPcaAzoDkGImXbfXhq7sWdy2CW4je7hd9-r8svgUWlSN_IoVRMFiQ>
    <xmx:POPcaImAewhGtAEPJRJLbWsHxiq3QoheHEPYaF4uk1CVN1VQ359swQ>
    <xmx:POPcaJQleOYicbDERetGcLyHMawNl6CN-LB2FeGq6MCakNa4VzBcogzi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64B3F1EA0068; Wed,  1 Oct 2025 04:15:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AM38Qt76lGbZ
Date: Wed, 01 Oct 2025 10:15:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Henrique Soares" <henriquegogo@gmail.com>, git@vger.kernel.org
Message-Id: <ba6b9a5e-72b5-4d66-a484-37140438702a@app.fastmail.com>
In-Reply-To: <aNygY8Cm7LEaBzV6@localhost>
References: <aNygY8Cm7LEaBzV6@localhost>
Subject: Re: How mantainers check Git diffs and patches?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 1, 2025, at 05:30, Henrique Soares wrote:
> This is a simple question I have related to the PR diff review process.
>
> How Git maintainers use to check diffs and review the code? I mean,
> sometimes I see that there are some large PATCHES that is hard or
> probably impossible to review only using e-mail client.
>
> Do you use some syntax highlight in client e-mail; any pipeline that
> automatically download e-mails and apply to a local branch; or for each
> PR you save the e-mail file then "git apply" to review / test the diff?
>
> This isn't a technical question, I'm just curious about how you do it.

Here is a relevant message (2016).

https://lore.kernel.org/git/20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net/
