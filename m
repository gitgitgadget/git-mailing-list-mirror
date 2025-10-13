Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F43243374
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393753; cv=none; b=OCifbBONRkwZlqV2pxk8fDomGqdy+7BdGOCkeHyj3kaD+CE/PtMLPl/lnVISaQkRIuWlVRxpbWd6xUbGibAFusf9x2Ay8nszRDXofRQFpNwKu8umTUpjLjuqGPTsjN4BZ0Ncf4srxTWp1Hpsrou5owjxh4CrVFGES+8nKAdHbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393753; c=relaxed/simple;
	bh=AIBEl0ZtMmKepboP+rhTgntcWABDa/gpzi2TA8wXDdk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nN0PVwEw8iKZy0M/Qa16iExlmtQyAdQFR5c3EFEONQxG6zzZmoLcWktkPJpnemB3pnan3S3+K7CngG2n+6LQup1GPgtGTny6oddSgoxW8cnxCdZ1A7i8SGSQ1FoWNcIuB6X789adgAXWaWBEMa2aIhJNzJuZsGTHgq37n300B+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cyIK8ce/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ex+3Opl7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cyIK8ce/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ex+3Opl7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 875DB140012E;
	Mon, 13 Oct 2025 18:15:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 18:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760393749;
	 x=1760480149; bh=AIBEl0ZtMmKepboP+rhTgntcWABDa/gpzi2TA8wXDdk=; b=
	cyIK8ce/A3E903CjxmO2beiSOI4U471cWPYFqxFqG8SN3JC0p8Oge6wfdqGiRSE0
	ojW0akrIXuqPzfOY19giDD7C+EJ5WVFy0t3NM1BvcgYjCQ9dIZ0ual+KUI7Buj3i
	iFlRBp9MLJOsVr2Rnn2/j9FAUqptjzrSiMaeJmXP95zmaxAxH/qGBBa/UJVAKbhJ
	FgfZPlvbFhUs8TdOIb9JFaeM9fTCY5uFDp0uBcwC4nY0ZhWa3HpnVnaEYvof3KN9
	6HCnM5dwFuSFJyb/imrzGDBTHQEn8O6/uSwTUgnjCeL9rRLsxme9ly/6HsUgi73C
	l/LSRz8TWToC8WpCWufwfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760393749; x=1760480149; bh=A
	IBEl0ZtMmKepboP+rhTgntcWABDa/gpzi2TA8wXDdk=; b=ex+3Opl7Tgp5ezo1E
	9VXLBvRIE3LrGKJ4Qs5S08yuICd676al/cvOWXGk/cXtsFK5XQmWPnr+MGORBXiq
	kPmd1gRvhkohcxbwDqNHPBERxqk2097QMOEioMIsxhjX4/cf+ZQRWKdEJCDyedu4
	5F7Dn0xcL5QYLnpkfve5lVU+fERoGN6b2RvCKlku2dy2YFEYQvjb56QcMDpTv6dZ
	RiZEt+SpesOVB7OQ+i61mBOkGEwFnbZkN3Wyj8kmF5GqY3qeBXJg4+V424bZKdDh
	p9KEkbodxKosgNPpBhhJSIDm72fvxHeUs7GKAdjk5zTvJ9Sr5YYpKrH+LbR+a2gx
	qrj5w==
X-ME-Sender: <xms:FXrtaPg3qmlm0eXAclHxVU-dpXIyxoMwrhbkgWWH62sVXcNFIxSubr8>
    <xme:FXrtaG148W81pWoaE_-60AsGB5dIKPDGHcQlVjZnfJDCm--fa5uH4TRfEKOxVDX-M
    XB4fuBkWgLJzE5kbx5ybvjHHKnn-vsn17tnejxGs4JDfUqS93L75Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshgrmhgvrhdrrggsuggrlhhlrghhrddttdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:FXrtaCONUoBY1PX0RHh3C23VPErvmOGJLC1iyos89QeAg-n4a1rOhQ>
    <xmx:FXrtaO7SEWzniYDtQgybSIhlCUQySS7t6f9zA4b-S2Zo73wzNgLDNQ>
    <xmx:FXrtaA0hR8ih2oqcPSP-RS4ujK3n4Q0YEH-jWOuFZkBJ9Pb_vlv7Cw>
    <xmx:FXrtaParjolybODLUD6jKIo0tv26tJPl7ntv4tt6iCjOVnd0LRNcGw>
    <xmx:FXrtaPkinNeyEgvwtDy1p5oaGv12dKa7tWWYP1LYH_tut77tBCZmgihP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3ADC01EA0062; Mon, 13 Oct 2025 18:15:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdytnZtU3TV-
Date: Tue, 14 Oct 2025 00:15:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Samer Abdallah" <samer.abdallah.00@gmail.com>, git@vger.kernel.org
Message-Id: <ae47adc7-7393-4994-9aae-e661c0e36b66@app.fastmail.com>
In-Reply-To: <EBCAE8A8-E556-4DE9-9B76-EA4C27EECA01@gmail.com>
References: <EBCAE8A8-E556-4DE9-9B76-EA4C27EECA01@gmail.com>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025, at 23:59, Samer Abdallah wrote:
> I still use git whatchanged.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).
