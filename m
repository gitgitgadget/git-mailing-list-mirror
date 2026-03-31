Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87620421F1F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975405; cv=none; b=VbGM/5gJ9KKAQ7c70r5lUzw3E5qtpOhy5FP5owIZS/SSZywCQBCMwiHq3MkH6p90jhjxIjdQ5AwjayFuyeWAqoowcAr1jF4E+WcNn0QyZJWQBzmV1qBhXLVJu8OFo0MKIOUu57QAMj0GPeeoiFxT/eg7kaE7g8smkCsXmnEKDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975405; c=relaxed/simple;
	bh=n9pTwEDa/NMPSjVCBpyaYMYaauGGINK5PoCH3dURndM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ir23pxJlioEl4h283EJ9P3HQkEo+i0IWx3aPr4iDk6ls4QNzxDzpxqpGExRKM/DTNqhXXVtY0i8DYvJwahhWWuzCMK5q1uL4IpWOxsm73npGVtEmLGBLdwwKBeRe3poW8keq+r8XpsUe9xSkElskrOyb/hURywxCNxWaD12RA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QxQiFsgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAwxt6v3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QxQiFsgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAwxt6v3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84403140013E;
	Tue, 31 Mar 2026 12:43:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 12:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774975403;
	 x=1775061803; bh=zdCmyPI6PlP5Gn+EgrKVP3PhSkjpwTHEEKG5OyYXXvI=; b=
	QxQiFsgqYLMleDFToM7dYA1+l59plyOfJI/XKE+a/Ho0peWuGX0xLT3/E6wS0a0O
	zyyouLSCo8lnTUuaHqij2GH0WQVpuqJfEG8kYRzZeOm+uPXjTlcl5XqjcoU/SYdl
	8sgP60AYHSgiXfaLGEg60KXt6ujY9xisXOw+w6KAh5tmO8g4ON86kLGaf72TBvK5
	s9WyCuJ7npnpHUASj93PwL1nb3OgGVfoucUXts2gqSg0iMPos1HuAbvTPR02iBAC
	KalGA1U1eHCx0OvNc7NxTVpvwkb4h2c1tJejVbFpPJcc7hWHZVjz1S3eS3jsQQ9I
	4Vjq2T8ivE06lqOQ6zH9xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1774975403; x=1775061803; bh=z
	dCmyPI6PlP5Gn+EgrKVP3PhSkjpwTHEEKG5OyYXXvI=; b=jAwxt6v3rIU89FmKV
	QeryQlcEGYNikgrWsxMD8HOQK/spR48om5B51vtL7ukU3udT7wtcCDVBfOBQ/6YI
	yiEsPYyEaXG7+IvEuKm1S/QWOT/5Hc7ax5a2f3vTX2NSdVg/E+ltPQMkOo5WdnR2
	G4h1Rexv5rUMy8AhMOaFMmcIDNn5SBxPpBvApc0IXt5NEZ9fYi2tVGtXLrXsGaE+
	Bwo3yIRd1hZ5fgY2+GpYMRboiqJ2TxRJSfIm+43C//8RWQU3ILCmzbKRX4Q5/noV
	Ou8C39qYnULS50OfECdIKvF/kIMyso9/ozzUhp3mfH+QP0k6gtMR4QKZLiWVK1/+
	oVDHQ==
X-ME-Sender: <xms:q_nLaR7ZviVi6RiJh6Rt2NPGFqLqs3EQV1UXWcP0NOZbxeQzPyXG3H4>
    <xme:q_nLaZs5ipDH9bgxsY4cJOkTaIGBay8UsRrEN2Dt3F7O-XtftcXqPvYrHZwIE6ZhM
    _UHVJghPwWTL530d8uZisqy3B8oftUh1OB7r2JdTgc0lY3YomJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhf
    vghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeek
    heetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgrghsphdrghhiohhrghhoshesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q_nLacnDCbBZRJYqM8vOSn91RJCyr4cySbx5RTmqIUqSk9WkP1u-PQ>
    <xmx:q_nLaZw7Na1YxspO5bkxzyO4_bZsZlcfIkh_60qDDVa8HUi83QCGPQ>
    <xmx:q_nLaSMHz7jxXMCQSxDQgwVnQgwITfG7ePsLe2sHsgfcCUmP9OAdXA>
    <xmx:q_nLaVRnazzWZ7xIHmpwe9aGp-j1TVS8EpEAnryA4QqMufeE4hzwRw>
    <xmx:q_nLaafpUkxmEO_VBh-NTRx8LM9NOdNUg9qTeUh880F3zDhkfm4Jib2g>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E30B1EA006B; Tue, 31 Mar 2026 12:43:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHgF0jPpqFYo
Date: Tue, 31 Mar 2026 18:43:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Giorgos Gasparis" <gasp.giorgos@gmail.com>, git@vger.kernel.org
Message-Id: <fab20df3-248b-4590-9b3e-e7601404df55@app.fastmail.com>
In-Reply-To: 
 <CALCP2CjymE-i9TsKB8TmW_0M=ZDbtLPzZFpx4-ba01164b1MOA@mail.gmail.com>
References: 
 <CALCP2CjymE-i9TsKB8TmW_0M=ZDbtLPzZFpx4-ba01164b1MOA@mail.gmail.com>
Subject: Re: [Feature Proposal] Add a built-in 'git whoami' command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, at 16:57, Giorgos Gasparis wrote:
> I would like to propose adding a native git whoami command to Git to
> easily check the currently active identity.
>
> Currently, users have to run two separate commands (git config
> user.name and git config user.email) to check this. This is a frequent
> friction point for developers balancing work and personal repositories
> who want to double-check their active profile before committing.
>
> To solve this locally, I currently use the following alias in my .gitc=
onfig:
>
> [alias] whoami =3D !echo "=F0=9F=91=A4 $(git config user.name) | =F0=9F=
=93=A7 $(git config
> user.email)"

Strange. I was looking at an example from git-interpret-trailers(1) toda=
y.

    $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git =
config user.email)>"'

And =E2=80=9Cgit-whoami(1)?=E2=80=9D jumped in to my mind.

You can kind of get that with [which Junio mentioned after I wrote this =
draft]

    git var GIT_AUTHOR_IDENT | sed -e 's/> .*/>/'

Too bad with the postprocessing needed for the timestamp.

> Having a built-in command that provides this kind of unified,
> single-line output natively (even as standard plain text without
> emojis) would be a great quality-of-life improvement for the wider
> community so they don't have to build custom aliases.

A problem (subjectively) is that there are already 147 git(1) commands.
