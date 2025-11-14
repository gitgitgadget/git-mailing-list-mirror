Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1B226CFE
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105508; cv=none; b=MC1mmzRILdT/k5T5RfMI89sjLaLHh/1fdaMrqjeVKxH5cFJR4jKbh6EYhM1ZMvu2BZPl8y25MSpC4POmxgRN72Hde+4UrqiA/Nr2z9g2ur7IfRxfXHPbmULcbWdBir1Xkaja/FM5zCdFQwa6nFJyiT1kXFH3Eyhy/IaHli+/4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105508; c=relaxed/simple;
	bh=JZf2BJEWTnr4xgVfcaf8vEdxp0N6Kcmfpg7tHME5ew0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kjc0y0V4QWX2G1nIXdUHJ5A/uEXXqigwYRQwOqI30o4r39/bQ3dvJmjsW5xzpVBVvWoIdhK1rAnPz5xzYg1lV2tadp2SESjqksROz509ucuSfH/Zi+C+s6cQAgOQGD8EBhAQKvv7oWw+FPocR+8wjuyQN7HTT5dv2OGnTPl3Z4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=I3Hirv3R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qz+uxLGm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="I3Hirv3R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qz+uxLGm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EEB551D000F9;
	Fri, 14 Nov 2025 02:31:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 14 Nov 2025 02:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763105503;
	 x=1763191903; bh=aD+YbE9xAYxF0PROsMKhbu58W66qHRnn6jxiJQEDL94=; b=
	I3Hirv3RTp2X5dL28/wbqM6urG5tauu91t5KgUmKZVrkGwdRFG/gDXqvBaW9S21A
	78HXQ+qJObUN9UxUfaKwUr3EGUK++Vj+6aPeu/HAJZAEwZ698DF4p3dTk7vDN7lW
	PuYDUQnpU2VOPb6bparpsFAU57YDnPpGvXoPCJ1RZP8V+hYMJi6tehuZZ4VZ/wuQ
	LCCWKTU3877mxyW0vzJ2WUGxbfF3M8UwlAlR798uNkNHohQFIFpRFIqaYXTObnKF
	S5V3Dq7m/IqIteI7wHKfbthCkYJs2MxSY1oEqZICu8NJEYtVFQ6gekMHqYzCYoSI
	Jvl/K49tLPc5kcdUlhpj/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763105503; x=1763191903; bh=a
	D+YbE9xAYxF0PROsMKhbu58W66qHRnn6jxiJQEDL94=; b=Qz+uxLGm34VF72uiR
	O7fsIOpQzxkOgjGQRN4RmLiteTiJnvtC4dn1GPoPYYo3U70hrRjVPx5ygAg7SBQo
	yl/PMpIX6NJ6gY0jYwyJe5oGMuGIdzk8gcbB5uiKSIjKaVCJM5rvs+724OJg+kat
	ULNEmvEN1lIilEDDt+N14cvp2TH9S/RCiL4uJFjG9kndWHrM8NndiAGXriCpF4Jd
	s0HxnSs6/cwh/wXqNRxtYs6NtXXNQoFdb/SqdyTnZHuWamiNUiT5JpryS5mo1j82
	ghs/piV+ygWq3LCPW1pP5qU7QdhFL3qviYGMWjU/rnrHdcpRBBIQ7gkbi5d0zfET
	MD16Q==
X-ME-Sender: <xms:39oWaWOjr6oVYoaiRzQIZPZ-UNdqu9e-73WFgXwo79AMsXftEMB6GCo>
    <xme:39oWafxWZs6efPSi76c33rDQmxGxvIc-KGNT0aA7tR2Vy1HJM2Nna3QbSFdzfywEw
    m-ONe2PsPnfOhUawtLyOrY0U50f4S749pm91WH2NhRoXYdxg-fChw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvug
    hisehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:39oWaU6pBdpZ8aBe0UCzfMUJv_vWJHXpIQ49xyU22YTVLBehi4vhkg>
    <xmx:39oWaT1zR8rVE47fOfvffjnwcLS3KAaYbGR0IvSbjKSHvzmYItuTVw>
    <xmx:39oWabBc913oK0YbXpDz1CK_yYXG2lcsx8q06s3Nl3hlQD3xxAD5jg>
    <xmx:39oWaV2CcO_whdk8Nmkn7PpFSsLQ_O1S-0xpBstfRQr5USke0DA5fA>
    <xmx:39oWaYIWqedvsfuZwCBhJT22-CwED18dM356FIUz7Xkqw7SSeD4zKqeJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E9631EA0062; Fri, 14 Nov 2025 02:31:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmONYxKWR8u7
Date: Fri, 14 Nov 2025 08:31:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eduard Bloch" <edi@gmx.de>, git@vger.kernel.org
Message-Id: <447ddfcd-b5b7-4047-aee3-496bc4c0c70e@app.fastmail.com>
In-Reply-To: <aRZHpI7uvNeHTD63@rotes76.wohnheim.uni-kl.de>
References: <aRZHpI7uvNeHTD63@rotes76.wohnheim.uni-kl.de>
Subject: Re: I still use whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 13, 2025, at 22:03, Eduard Bloch wrote:
> Yes, guys,
>
> that may sound totally ridiculous but I want my normal "git whatchanged"
> command back.
>
> Because calling it means typing "git wh<tab>". Just 6 keystrokes!

Since you specifically want the user experience of typing `git
whatchanged` or a prefix:

You can set up an alias with that name on Git 2.51.1 and 2.51.2.  (And
later Git 2.52.0 (soon released).)

    git config set --global alias.whatchanged 'log --raw --no-merges'

You cannot do that on Git 2.51.0 since you cannot alias builtin
commands.  But you can alias deprecated builtin commands on
those versions.

>
> And what is the replacement call? Jeez, this dumb message about
> "--i-still-use-this" should have mentioned that detail! Now I had to
> google it which was not great UX in the first place.
>
> Okay, the replacement is apparently "git log --ra<tab>", at least 12
> keystrokes.

The closest equivalent is `git log --raw --no-merges` (see above).

> That is a clear downgrade. So, please bring "whatchanged"
> shortcut back. You may print scary warnings about eating my dogs for
> breakfast or similar, I don't care.
