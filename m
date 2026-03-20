Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077537B3EC
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004457; cv=none; b=I9Fu4rqnoLiwsiqDP9k0gBbYYDgBb7CY5HzQQM0yG9eKovE6jlpmJpc79S0JLf/NlVXAeI1COUQ5EWNIb4z7vd+2VUEjY9u+7UHTzH+4J0A3cP++i286hnbjq0yAS1kqzfoZ9vikl9qDxmK2IH2k8P90/jp9QWWqbCWFUH1VrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004457; c=relaxed/simple;
	bh=Qbc8dtlS496UG/jaceBf+rg9MzgamBngOYJG0UEVIR8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ofjpIvvQTmcdW6HBv8GqLLueSmpcfoT0JNaxedGG3Ex2h5uoZ29jY0YuNgOCIsOMmH1fdpy+9+73yL8im6ZuXdDtpGjXf/2sJVgJSCPtquiv223PVUEJgypnN/DBTBcB0acRDIF1SH0/mMBaVVldWlrjMbrKRz1WQOaXllIiOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jqhGM4Tu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gkp0s8Lb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jqhGM4Tu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gkp0s8Lb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A919EC01DD;
	Fri, 20 Mar 2026 07:00:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 07:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774004455;
	 x=1774090855; bh=I2ivwm4i7Gcuhb49FPL8f3ccYXGEv+KDuKkaH96lu5o=; b=
	jqhGM4TuyUgHIdqjfgINo8IoLV9LtdafZhCPOWTe87mC68Uz0j+fEFvtMOXcEi8Q
	PbzaB1v8xHdO8/T5SlCXcozAE6M/1279o+Uwt3LWdsY3qA5dWQIob7aihAsKMOqm
	1vDo6R6aemgesQCWQZdjlpwZPmwPOtKjNgE43FMijngbdw7bFJGU5A+p0VxGFdKC
	3i5gyMDaknuUqp1s+qfbtSeH4YfIPjZhxkAkdK+QFSu9Wr32joOGPpalICdAjXOm
	lK17je4oSsFP93JfhKHBjY5aWemo0mE3oG+cHhdmF3ne/A7NmyPde3+7KfBsURo5
	ZQu3P8HrI2GnTEq1y4aNxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774004455; x=1774090855; bh=I
	2ivwm4i7Gcuhb49FPL8f3ccYXGEv+KDuKkaH96lu5o=; b=Gkp0s8Lba+FLan+nk
	f5JfBpzVeEOy3Xn5qYN5CnxMGiEX5zEaqXHjBd3o8fYdXVn8h9jZpKPzr0FAYe1h
	w/VrER1wb6JBLSJlB3bJgHDb9qUy0J3mDCdk4ZqhIJGPvOlZieNcb45NXV1DAlVn
	6mO9yYwjUI+ZsDFFzJUYAe8KFnINVwhP5RxhepePasAR+PtmdgzqUAB7dihunMKg
	oAG2Xnz6bXtEYK75gkcNnJoUMJC9sWhEulo/rKVmbq3yQmb7ONLJFZycsDCxIcsE
	vSMBLjdghFqkHKofq4G3MXIeEjKaVGcI0UwcjzkbDQ3fIIrqAH1EybG4GeLKzu8e
	K68Ew==
X-ME-Sender: <xms:5ii9aYk--99PMqELZTaRlNSnu3TDhrjcgHxWfJn49mharSmE383-SU8>
    <xme:5ii9aSqKA2iqhuwp_4u7UfJ5_GO2ruDfnkLICftuHVDrqWIdVuU8BzYJ_FadUYMkM
    KgLcbdUv42hAQlql0E3h8Umln1Sq_TAHwr8-bGw5uPQAwKQX3ix8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehurd
    hklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5yi9afRZpobkuTqWR5iDlE9q3IS0mtxzKmdqVb99BPjf735vxhkqtg>
    <xmx:5yi9aevNb3ahu_YJ4xXuzuOaEnssX1vAc9xHCHwhArwH-KZg-EmLcg>
    <xmx:5yi9acZMBmnkk_NEcAMXkK22ITA_0fxt0p1Fra54TLI55isBT5zaag>
    <xmx:5yi9abt_yHjG8wo6BVliikTGa2caUUXx3qqaLp-9bqwW6rGK8C-HXw>
    <xmx:5yi9aUD6LU2qQM1Og60nroVhnoSqFl3X1QslRbQmi1t4EyMveQbdNxEt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE96D1EA006C; Fri, 20 Mar 2026 07:00:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIRVVvmVhujN
Date: Fri, 20 Mar 2026 12:00:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 git@vger.kernel.org
Message-Id: <4333ce73-9c30-417f-95a4-356362488444@app.fastmail.com>
In-Reply-To: <20260320102844.2714876-2-u.kleine-koenig@baylibre.com>
References: <20260320102844.2714876-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] Add a config option to add a comment to S-o-b lines
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, at 11:28, Uwe Kleine-K=C3=B6nig wrote:
> As an employee of a consultant company I'm often requested to mention
> the customer name in the Signed-off-by line. Add a config knob

And this is a widespread practice?

Looking at the Linux Kernel there does seem to be a fair few hits.

> "user.signoffcomment" to configure this and use it in automatically
> generated S-o-b lines.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koeni=
g@baylibre.com>
> ---
>[snip]

What are the alternatives? I imagine that the commit-msg hook with
git-interpret-trailers(1) could do the same thing.

Adding extra-ident data doesn=E2=80=99t seem to harmonize with grouping =
by
trailers (git-shortlog(1) with `--group=3Dtrailer:`) in the case where t=
he
same person contributes under different orgs or something across the
years. The mailmap can=E2=80=99t be used for trailers. In that light sho=
uld
git(1) implicitly encourage such a practice over the alternatives like a
separate trailer pre/post the `-by` trailer?

I know it=E2=80=99s not the same thing=E2=80=94just an extension=E2=80=94=
but git-commit(1)
now says:

    Git does not (and will not) have a configuration variable to enable
    the --signoff command line option by default; see the commit.signoff
    entry in gitfaq(7) for more details.

This does not configure a signoff but it does put more stuff on top of a
=E2=80=9Chistorical mistake=E2=80=9D.
