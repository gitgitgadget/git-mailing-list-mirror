Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D03ACEE7
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290008; cv=none; b=CAevvPLKfRre3w4p2CqGZRsYfT8XZ3adILskK7cIjjxiNzT0up6UsFJUSH/g8y2grwYQVBw642buBnxBRWyOHdxMe+HwHIWObaYfp5tKIgpMyhLlXvKpsymHmmH5GaSJgU/gFbix6vfNc9CWGTXz5B7QeLFrVRCkVJxemEQrLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290008; c=relaxed/simple;
	bh=GOiRK2N3emRiD9II0pZXL6ptdkU9N7K3JrqUmkLu390=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XoQDLgo9RfED/6d7Cu4JzrbLGtWDX2TVFj51FV0tTcH9DBLHJ0cls5kwK+Y1u4j2hftIyBQsvNS2/4CHdpEXUZhKyHucY1AWyuFsPNUphMmcYo63jx7HpZnQZ2MD+C8W4rcddJDJqv8400V94fr6zcShRvLagjQxEQc4G/pkyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z5qb4uUo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qJKYCVOB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z5qb4uUo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qJKYCVOB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EEBAF1D000E9;
	Thu,  5 Feb 2026 06:13:26 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 06:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770290006;
	 x=1770376406; bh=GOiRK2N3emRiD9II0pZXL6ptdkU9N7K3JrqUmkLu390=; b=
	Z5qb4uUozQ3ePMpp/TLCRKdVbnJFwi0SXEbFPtOfpg68sjotH9s/bwo2ML4Z1HEI
	bqWCC8Q97V39lP3+ETJNb8mFA9AQBpfvoGGb4/7UKHB6qD4TemQ+vLkA1ey7S+Lu
	h4yK51K+tkygV2CGyvB1c4L+OeRbqX+yZwvLo78KuKWTNjCvNyPAa5ri0eTRD2ZY
	z5QSoKEaIguExYhG18s41yZN/dmcnijpcomTCl47qbdbQfqRO23jYJbKm2JzN3/s
	UTx+paApnqpnUcBVuY/sDVOJsCjozIzlAZ/rJ5p+GMnI8ib5e6zs8/BRp/COKRDj
	czvPvbH2QrVxO3s8V2/YoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770290006; x=1770376406; bh=G
	OiRK2N3emRiD9II0pZXL6ptdkU9N7K3JrqUmkLu390=; b=qJKYCVOBxptfL8M5d
	i0014pGShCDHl0jplf0ukarGnU7JTIAHbOJS5f+060mJS8YmBiYQX9E46gd6Z4QX
	wngybmtA2nwwRj9N4o3cNg0OtBg4G7ATj4P+58bZTEr+r4CmT+i1tF3JivfqAF3q
	+K8N+aFWSRO/OsTb/8xPCR1ig8R/lQqRym79gmXFnEjMnbomqEaScsOLntU274Jz
	N5tfs4eJ3SHXM9+K9HUmq/x/HW6N9Fsx3TtfsD5wYr3VVsQm9bYuK9zBb9DTsRHs
	Jfv4gVlnIUDV85UJQMVmBxSNEeXZHxlJcUUMKwirHYwGyn4qx8i3DVwVMIkiHV2B
	PGP/Q==
X-ME-Sender: <xms:VnuEaVNi4jMWpFIFcOcBwe1ZrkU3VOXJTe1P65kHWwycrfGeanxdF3s>
    <xme:VnuEaSxDzfVRVduKpJ0Kxaz0Fqy7gvNi5k1GCyZRr9hoxZ1xWIIasFI51KegYrpc9
    U_Dzy1Ggh7ObgmGeRPQsc1ADuL1o4KA6oVfWZyHY-m_y4Q2Wp7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrg
    hmsehsrghmuhgvlhgsvghrnhgvhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VnuEaT4EJppXA3ao-_caLkuTsUMOFnrBUskfgJ4B4CeZPmZxULEvQg>
    <xmx:VnuEaW3LAZ-hrZyexPTBQ5FtXphoXOcKh51XwZ3GTc59f2s-m6uG_Q>
    <xmx:VnuEaSAJykjd2jBokbSxb-RyVEHYAq1ZaTnIUz58DW14__2dQZn6DQ>
    <xmx:VnuEaQ2OUEkhQu-M7nKX96AQ-ZX_GBkFfks2UqGp5JdBq0vZYoFg_g>
    <xmx:VnuEaQN-MPfP0LAs-4R9NmsH6ofJG0pKhbd_ys0r9q6PTHA7oZ1dBIrV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A146D1EA006B; Thu,  5 Feb 2026 06:13:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af998uhqBsqZ
Date: Thu, 05 Feb 2026 12:12:37 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Sam Berney" <sam@samuelberney.com>, git@vger.kernel.org
Message-Id: <1e8924cd-9e23-4fc5-b25f-9683da917b43@app.fastmail.com>
In-Reply-To: <106C80F0-C92E-4F23-9CCA-631AFF12AC65@samuelberney.com>
References: <106C80F0-C92E-4F23-9CCA-631AFF12AC65@samuelberney.com>
Subject: Re: Keep git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026, at 11:59, Sam Berney wrote:
> I have no idea why anyone would want to remove `git whatchanged`.

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

> Can=E2=80=99t you count to see how many people use it or something?

git(1) doesn=E2=80=99t have telemetry. Sending an email here is the tele=
mtry. :)

> I=E2=80=99m going to keep using it till it stops working and then I=E2=
=80=99ll be
> grumpy. Don=E2=80=99t make me grumpy!
