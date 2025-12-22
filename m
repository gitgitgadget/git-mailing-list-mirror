Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641D1DF271
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766420264; cv=none; b=Ppn6i7xD7nN5GLXpQi+YCBs1mJqb5OZFGi7ozq2ElbpUbNDsSpGwNtgXnYp31xCtng9nYwxLfNRZp4yqz+iOqg3rx2rC2zzUC053VeVwMNhM/n6LS2SssTHkFbw3kO9FvI3SEULR2BQji6JxxlhgfySYeY7zNaDvNR+CkdpQdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766420264; c=relaxed/simple;
	bh=0CPXDZwJU+8ZonwgfJqxqiEO83hIWPt2rZhk+NMb3y0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ruVukXKY0iaoHT+QmIJT+FNhvroMWj9F8GADxf21dQ5yxn+e21/4mpetSLbhfCzkjwdxfAE6Sq4mfACHqIDlEyG5+9WiXQFIeGysmz4N0nxEMwuUJreOAwXVxazZPIN6/mB4sSFbKbjTtM1vF4Zws8t6NtOZzesEWjBT2UFLBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U6wxkwKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=af3qj39T; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U6wxkwKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="af3qj39T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E9E77A007E;
	Mon, 22 Dec 2025 11:17:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 22 Dec 2025 11:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766420260;
	 x=1766506660; bh=kO9UrehFLg4Oq/WkyASw/GKaneZ0BiI7VuG7ite9rNc=; b=
	U6wxkwKI7hal4UD10e4xOz0uYvObeUpjZoNSW2nAdsezZG0Yy3zulZH5uCxKCVXR
	S3ybFkarib8NfoGgdJJ4jzO/skHlofMUN2dN4E5+zcLAyFV/mYSeakcilPxkchY0
	GxCbQTv4ZJShBp+bEJCyYfV3IO2hGEmQZ8Dk9L/3TuRuEoiEPDdURyp7m+xH2RYp
	aI0umMtQ3m9VH7uXPIoepDHKFZ1jJ0Xi6dyh6GDGaDKV1UxxqBGG4tAGhK24BYMR
	BnYw74YpATk/VhkJsa76xTdgoE89KEhLZnC7j41/uxFJR5bIrdyXFxjKUlQX8dd+
	Tf7aRoBxzxHhCowJL0aNzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766420260; x=1766506660; bh=k
	O9UrehFLg4Oq/WkyASw/GKaneZ0BiI7VuG7ite9rNc=; b=af3qj39TVPy5JtsG5
	6zaD+mBme1b6YLfA/izOyZJ3b/UJW2AerblD/By2ffRP2NFk8uL09UjL62bnNmcL
	YElrRDjabmSsNCbxTgvbxSEXd7tLrOam/Uj+qesuRPf5loNsydHSgxpOJie/ShJz
	HHkIFSpKx+NW4E9ABOEsCLTjwcMFQDM+ZPp2ru0nQEo/ZlBQMX9C2a5l4HyiqNva
	0xCXG8hcoUYTHzKgAFFG3HQk2Cc1droOUrtfsWYVqeA1F4UgKNfvSSHAZWINlVFc
	MwRIGNZslAUJRfzfMnUnhys6kPN/4AIKa39E5Tx/c3dxEhyEpSOZanJ+dHkG6MhP
	Yn0aw==
X-ME-Sender: <xms:JG9JafM2ebA6TOmxPYGhShEnQrynS3Z-zCAOkXDNKqjO4BELGY2cXDE>
    <xme:JG9JaUyLjUgjjNIoYFxPE_ui7AEv210ARgSz6VdzaDsPcR94xZPAE4DbfieE_v5KR
    er9Fikj6psFWSyJf3DoHWBfzOyYStCtwcdJBebZ_VOACQ3cxfmb6ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejvdfhjedvgfevhfdvjeefleelteffgfeuhfeihfeuuedvfeevteek
    teeugfehtdenucffohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoughivghvrdhgrghfsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JG9Jad5Am8Lfn1oWXD_aITNSO2awpwyYWjO5A2BgswdEH_bJO3LqAA>
    <xmx:JG9JaY1b5NDvxbaX1pNIivul43tqwCdzRcTy1iYiKg8Kh6XHZ8IIKQ>
    <xmx:JG9JacAmPrHZZh0o-JwBORifrYWKdVPARgkiNjPLwrbZdBkUMlAI3Q>
    <xmx:JG9JaS3r3iSkirJqj1AWcqp1cHk43mos9BYs_1ztx1SoZt6tKIVHtw>
    <xmx:JG9JaZjiuchzeRBnWSdjsb7cce1lCZo_SpSA0DbogZVFWwNEMEEH5p5R>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D49BE1EA0066; Mon, 22 Dec 2025 11:17:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUoAvYHkscC3
Date: Mon, 22 Dec 2025 17:17:20 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eugene R" <rodiev.gaf@gmail.com>, git@vger.kernel.org
Message-Id: <8cecaf95-1b08-4a9a-9b02-6920d46501e4@app.fastmail.com>
In-Reply-To: <3a63d796-b975-471a-84b4-8f8e7046615c@gmail.com>
References: <3a63d796-b975-471a-84b4-8f8e7046615c@gmail.com>
Subject: Re: [ORG] git config list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025, at 15:37, Eugene R wrote:
> On the page https://git-scm.com/docs/git-config (Russian version)=C2=A0=
 we
> can see: git config list, that is might be an mistype as we supposes to
> see: git config --list

No. The current documentation on that page is for Git 2.52.0. Git 2.46.0
introduced subcommands like `list` that deprecates the corresponding
options like `--list`. From the release notes:

      * The operation mode options (like "--get") the "git config" comma=
nd
        uses have been deprecated and replaced with subcommands (like "g=
it
        config get").

See also the [Deprecated Modes] section.

Both `git config list` and `git config --list` work. But the `--list`
form is deprecated.

Most people might use much older Git versions since that is what their
package manager (that they directly or indirectly use) provides. I see
that Debian Stable now uses a derivation of Git 2.47.0. But I think up
until recently it might have used Git 2.43.0?

=F0=9F=94=97: Deprecated Modes: https://git-scm.com/docs/git-config#_dep=
recated_modes
