Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD941A705B
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391271; cv=none; b=JLbJIdb77KGrNoUVQYX9g618lstPW5kcO5MjETUaifPN03EuZZYn2poTh/Egw8LjQSdc+zxQ1gRvBRxAbkmzWZrX7pGJOygOvrlcNtAzwRP6fb1LmH5bjtFznTr1LQt5aKx9JI/zsScQH9AVD9m6Y458l/YRLQHQcLbMlfl5KBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391271; c=relaxed/simple;
	bh=5u0IpbLdpJaL/wAA1UvLXEhkCIbIaFIif3hVYPe5Djw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gau66GzFnl6YvqL+lv+wuuxliDHjwNM2BD91KFx9CnkNLPk3/y0wiBFEz4twypL8J5wEEOBzwtaeHbvP6PCQaHfTAa84YG0pCv0sftidsfIWr/dLSgtf/WJYNXkInUi92qO3eYZHtVJ9lKHjriKgirhuyFjLZ5exLExWoseGryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nFSKyH/E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ycv4FSTK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nFSKyH/E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ycv4FSTK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 02807114019A;
	Thu, 31 Oct 2024 12:14:27 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 31 Oct 2024 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730391267;
	 x=1730477667; bh=0LrvQPYwVpBE7DmsAuetDuTTOJKYBzHyLZSPBFoGsfs=; b=
	nFSKyH/Evbd78AOQwkQjDsO6Quuc4eJItdvsmW4SxLTMqA0GxlTRMbHqLdaFGzU1
	gL+aM/Bc9x3N++gJTYr9mGilGmDz1E4jJUxPqaENeQSFxsxVGgx+60hg5UI3/99e
	6XKl41kvQILnTTZgTmzes1cFu1sdMj631k8rMv7JtXKQzLiDWO01c/7LcvWJyTsb
	MsLRpaxez0mfftBkNjXKONq2i8gz9mKaX8hzEZNXRblILPIocTaRlrNwv0MYgouV
	4/dQteLAfxhF/CTIHO2v97xEvIHuNX9ym8B2Fw/jk9ss9Jf77AMk2fcQNrc3bmS+
	f9hyWIaoxg/n4ldRSJD17w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730391267; x=
	1730477667; bh=0LrvQPYwVpBE7DmsAuetDuTTOJKYBzHyLZSPBFoGsfs=; b=Y
	cv4FSTKxx655rC5w1xDDM4S9Ycn4sV+5qgaZXOGH9mEDAFCNC06RVXsDTgRnM2NA
	vHFbYI2Qrxku25+sIx0WRMZ8cLSfcZ4yGrh47uzVn4i9M9OvvnHC4yVPGEupLs/H
	yXxnaC0cjpeWmIhpWnt06Fb3lyX5rjzwLMt/QSMti86KjN3VyiS0u0I+86BXaJkN
	mLQzdbXGsbQ2Kq9yEvz2qM1v1stfg+ZsR2b6xhnJUqeaWx631qd/kDgBPzODaUc4
	fxCooyKDg2jk7eaiQLzQAudA/xZpZYZsqG6kQDaTsqBCFmIHkfp4T5EmNFZKb02v
	3ufa2BNjE6iYCGp9fosmg==
X-ME-Sender: <xms:46wjZ9W7DXRzj5nwwRE-IiG8JQFF2V6bG2qRmmIUBN8MVoBAq5ZGcD8>
    <xme:46wjZ9lz7Oax2DDwcH06dy8RpjiBBty-bUobwp83eTywtLw1u13taqhYUBeNfAacm
    YcqsYmCWC4yxVGRnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekiedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhohhhithhnvghrudesghhmrghilhdrtghomhdprh
    gtphhtthhopehjphhoihhmsghovgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:46wjZ5ahLrSPWVmxHwaQgYxyCWiMEKukEIe68iktP2OvLW10EdoWTw>
    <xmx:46wjZwX9MuzsOdC9WW8I8m44Jo3Uhd0YsU4r2zI4UOuGdrptEjmOqw>
    <xmx:46wjZ3n95zOm0A1RBGzm4E9iWQQ4aQzLT9jURhkCY0OJU2HZGsbX6Q>
    <xmx:46wjZ9c-9KG1ERgMf1KIXp9WeKoMWwHxl56Lsy_vVT3RqyiA49e7Dg>
    <xmx:46wjZ1gIPxd6Zv-TEbLTQAMCwVoXj6Oyi1hS8yuigttByRJxwNSYDnBb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 99649780068; Thu, 31 Oct 2024 12:14:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Oct 2024 17:14:01 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: git@vger.kernel.org, rohitner1@gmail.com
Message-Id: <469d82f8-4883-4c87-b681-288a0520e745@app.fastmail.com>
In-Reply-To: <20241031114731.GA608553@coredump.intra.peff.net>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
Subject: Re: [BUG] "git describe --match" performance
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024, at 12:47, Jeff King wrote:
>   git commit-graph write --reachable
>
> That reduces the slow case for me by a factor of 10. And likewise other
> traversal operations should get faster.
>
> I think we'll build the commit graph file by default these days when y=
ou
> run "git gc". But we don't build it immediately after cloning. Perhaps
> we should change that.
>
> -Peff

There was this thread from last year where Rohit cloned Linux and the
command took more than twelve seconds.  Then git-commit-graph(1) fixed
it.

https://lore.kernel.org/git/CAKazavxTXwcZFtL2XyU3MpaUR=3DsnWY8w8Lwpco+mk=
bqm2nWE=3Dw@mail.gmail.com/

It would be nice if the graph was written on clone.  With the status quo
you might think that there is performance bug (if that=E2=80=99s the ter=
m)
somewhere.  Then you make a reproduction script using git-clone(1) in
order to have a blank slate.  Of course it reproduces every time.  But
the slow git-log(1) doesn=E2=80=99t happen for people who have had the r=
epo long
enough for a GC to hit.
