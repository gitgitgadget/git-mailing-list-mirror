Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F63630A6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749672; cv=none; b=BfYGJM9eq8qa+sZcOI9ZQqNrXdn3cTpNdrDTtUGttzK50f0iKqoF8JfJ0iSEnJC1qByE1hw6JYIBGSge4PbqSJ+olWeuezFlydUBmT4JOr5P/apefV0kSAfRhvpr3E7Fb3+6FEQRWCkvuqSz43cUass0KT8pWS+hxje2K1KyOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749672; c=relaxed/simple;
	bh=4xNjSqErW9DPmmu5B6qcdYnew2iV2XmmOObgq5hs7xM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bC+GQ4bzm75noq9dEZ09bMtOVNvYd3w8R0h5gfbPPeMXCDiSOL82Cz11gpvhVdCmCfPJBXejMJHjoisr/xw/7iCPe/XnIb/mBwb20MkHqy5tkTdRVHkmw9MXh1S3G4OZT7GxZ7C8+ivuZYTbG38zMhh1Ndi9lksqV+HcNcb0z6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hxy9q6oI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CLHUN9XT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hxy9q6oI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CLHUN9XT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A7B74EC05B1;
	Thu,  5 Mar 2026 17:27:49 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 17:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772749669;
	 x=1772836069; bh=s3HlLJ+5R2w25N/07XrfryRuU7cQYSjPApJY8ncv+RY=; b=
	hxy9q6oIgZVyZOItwfpZ1ezsFUv0yZaS7hM7cYAHd2R164SR8faRNhZfaVuZbV5R
	6B3TvmbJi9d8BKUJ6OlIiSFj8XQTvQ5ODhl2O2R2vLZMoA94HEhcFEMn0bQhl8fP
	0vkNvaWriqL8GWjyVc48wuhd8MYHfnVdPqEpzVQL2/hKnxjuuz3eAcF6EIGKBK5l
	+YzGx4PQb+DRU87I/VwH0TSTD3hSsjapuK4Hj9ri5DBdgleD444FakXMcS+s4sYV
	rsz6N7fD40cUFZfXgBvy5P9ArB8p6Q0LIqqjsRK6Z56ZE3WKe/2V5eb3hkQOr0O9
	1zm9NlEaDkdIVQh2glca/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772749669; x=
	1772836069; bh=s3HlLJ+5R2w25N/07XrfryRuU7cQYSjPApJY8ncv+RY=; b=C
	LHUN9XTKLqs+QkQvBJtiKwH6XFdj4wfVGeKzgpppxW3jaRXhunuWuAsJ1F3VTOoH
	9N9yNewm/AetJPKQE2cBnbq3Erv9dmQisaBdRO3UhHvyePQBRbs0r5nauV5epD0z
	ofZuCMBZXe+c8w7TlQUpHCEKuDEPYrkchq+nQcItZuARQXwWpLd82yrkXLm6smL6
	r9zbjn7c0qXnK09/VjzaDgsGXV074q8SV0rRqtH9kXXOPWAq9SH7LI0mCpZQPd12
	ve9v6uDIZnRwh5m4Zlar57TDm0zQZ8JEq2aa2/Y0oMi654egPz7KnwnqnKSVxxxY
	ud2Bpr1fcYojs+vWb0V9g==
X-ME-Sender: <xms:ZQOqacewEWmlws2WgEmxvr5KEebDuPB9QaAo4ebJdDpjxux-xLyM_S8>
    <xme:ZQOqaZDiXQYVIKZyT8finyCp2oXCRNYqAlLdQQQfNZ9GGj-2e83n8gU3NHSKNVv4a
    9F0ct6NsBLMMZqWS46ke1bEEZgzYE_1ktkAvZBtx7NaCxu84srQlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZQOqaabxa9WsKnqkILlLTiPq3ZL-DPFn5GvdfmAKg6Ithkor8Ln8ag>
    <xmx:ZQOqaVKL43ukxu4JgA6Vi7LBavUdOl4SS5LfBmDeARRQUG_2HKk6ig>
    <xmx:ZQOqaYB5ByWJkggko7lxUyZ3bqzbhw6cqRy5vlwfGRLvuzf1Zu2lTA>
    <xmx:ZQOqaao86YdjJINhUokcpiMC57YsC5KQMCJYPkE1UjUXe6YAg0XQgA>
    <xmx:ZQOqafUrCjUwzyTVWLuAlvT0GqbP8R-O4XzfkST54lJ119BerKFwxU6a>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 335631EA006B; Thu,  5 Mar 2026 17:27:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APO20d7PITeo
Date: Thu, 05 Mar 2026 23:27:28 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Justin Tobler" <jltobler@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <be9cbba2-883a-4ef8-838e-0941b75eee6f@app.fastmail.com>
In-Reply-To: <20260305193836.973122-1-jltobler@gmail.com>
References: <20260305193836.973122-1-jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026, at 20:38, Justin Tobler wrote:
> Before submitting patches on the mailing list, it is often a good idea
> to check for previous related discussions or if similar work is already
> in progress. This enables better coordination amongst contributors and
> could avoid duplicating work.
>
> Additionally, it is often recommended to give reviewers some time to
> reply to a patch series before sending new versions. This helps collect
> broader feedback and reduces unnecessary churn from rapid rerolls.
>
> Document this guidance in "Documentation/SubmittingPatches" accordingl=
y.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/SubmittingPatches | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches
> b/Documentation/SubmittingPatches
> index e270ccbe85..5acd692ad7 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -38,10 +38,23 @@ they have no obligation to help you (i.e. you ask
> them for help,
>  you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+
> would
>  help you find out who they are.
>
> +It is also a good idea to check whether your topic has been discussed
> +previously on the mailing list,

This is at the start of the document. =E2=80=9CThe mailing list=E2=80=9D=
 footnote
(git-ml) does not get mentioned until line 535.

Although there is the initial mention of `MyFirstContribution` which
prominently features the address at the start.

> or whether similar work is already in
> +progress.  Prior discussions may contain useful context, design
> +considerations, or earlier attempts at solving the same problem. Being
> +aware of such discussions can help you avoid duplicating work and may
> +allow you to coordinate with other contributors working in the same
> +area.
> +

This seems useful to cite. It seems less useful for people who go to the
effort of reading this file themselves. They presumably care enough to
try to get the procedural steps correct. It=E2=80=99s difficult to imagi=
ne that
they either think that their idea has to be unique or that there isn=E2=80=
=99t a
history.

>  . You get comments and suggestions for improvements.  You may even get
>    them in an "on top of your change" patch form.  You are expected to
>    respond to them with "Reply-All" on the mailing list, while taking
>    them into account while preparing an updated set of patches.
> ++
> +It is often beneficial to allow some time for reviewers to provide
> +feedback before sending a new version, rather than sending an updated
> +series immediately after receiving a review. This helps collect broad=
er
> +input and avoids unnecessary churn from many rapid iterations.

This addition makes sense including its placement.

>
>  . Polish, refine, and re-send your patches to the list and to the peo=
ple
>    who spent their time to improve your patch.  Go back to step (2).
>
> base-commit: 628a66ccf68d141d57d06e100c3514a54b31d6b7
> --
> 2.53.0.381.g628a66ccf6
