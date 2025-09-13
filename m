Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA21E515
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772682; cv=none; b=js6fy4yhkJv6NGG7veU8GpK56OW3sW2fUkARh1Wm/9bWIvaSUy89v6bFDrYCFYSF61cE699unPo7EegBCGTo/RJ52HO51TdrA7f4bUBZQkMmzJcaDOq+l15TsNOw3vhP+KQ8eL/yhguJelga6BvHDeoBqly2xSf3ODngUTEImM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772682; c=relaxed/simple;
	bh=GHTcoc4bqR+Jno5J8RgLCtKorn9JrypDq513eQ63PZw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dc01GpJ3ZH8zWwEAOqeDWzzBm2Mp6wr3Bd8B4hXZ1Ek5TtLy6H3bIVarbgUzSzjWlEdBE+xH+paBLAra8qT+wviHeivaXJKGQpyXCZHaPYTSm/+hIHrKIbNqDxVEmj/wq0SqgVIe10dDZcYjzayQn2vUJwZ+3rMC9UmaI6lsXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m+GsfAkD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVNtU6IV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m+GsfAkD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVNtU6IV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2718E7A0066;
	Sat, 13 Sep 2025 10:11:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 13 Sep 2025 10:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757772678;
	 x=1757859078; bh=0dq4zFpCR+taei404+69ZVDFtUnr4FzfcBy4i2rEksM=; b=
	m+GsfAkDiQw6LBQ1Ay5HycsLtj9ra60z7ZvSiUXAKv/HZoT9duWb498j08DSFERy
	ehyyR6xJgJA1Wyipa6UZARJYK6NtMAg33fZLtecaQ4mDG/LFsIj33dqHuNjPyiZv
	Xz5Brl1AL9angoFQ/DMVVV7lrSlNk8kQXmn9Rb7FNtiHHwEbmA3JBejEksjzYBhb
	wZFZhq4waIVUht+skFJCQIoMb1uZz1JjXyoQPUinLOFYWG1V5Lcdh0DQKyXZzVWp
	cgw0o492kAwsGhrs1xSY/0rIvslnu+hYVRijs1Yj93hpVbAIp1ua3KcyrRjbJnAx
	jvjAR1/JVyj4T/eGO3f4qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757772678; x=
	1757859078; bh=0dq4zFpCR+taei404+69ZVDFtUnr4FzfcBy4i2rEksM=; b=G
	VNtU6IV0kpN8ZQdIvJVGZcv8O0Mc3Hl1+TESq2d59NkggGs9FH+yE9g0VUhCmWHy
	ggxW9zsxcPbcSSvFDKkAqiFobSLrDEI9I8HgeqB2kNIPbKrStb6NfHc6Sn+g+mqc
	I634ndA9x3STfI2ri8rvvNpq5zvgjXLsujAAw+GsdczqjIoHd9JJ3AxAknJrx/LE
	VfYzKSFhMyeecYgR7IE2a22J1l+xih/eky7sUWZKlvfdqGYRgGUWcNiTGEkONGWL
	XYYGxFuUVa6tEaVQULv4upLxrT8SAcYSRxvHycxR86kQ3rr033n7qRSHneEC4zlk
	3dajp1BP7lAdsJQ+FKxAA==
X-ME-Sender: <xms:hXvFaGKeC4JEPJgtk2UyV_mZih0M--RZLduukXybdU9OiwE-3n-wm2o>
    <xme:hXvFaOKXjBVHclrJyrwEzzOgjGp9b6NrSmZREWWl2HSGSXfrI9bAigYuHQ4D_4zSU
    bvPUy4OBnKdyiHx8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hXvFaBIDPL-NG7a7l5TVyrVBXQsE10JtER3jwFrqOd0UtvoreDBDhw>
    <xmx:hXvFaKQ3_fwjGsstWjPhVGQA4ua1hYRVOWIa5jU61tUu5mMElLnRVg>
    <xmx:hXvFaIti-r5zjxZSMNgFNYHM6ICDX_YTOudmVSgghIg3QaqTxMtmnw>
    <xmx:hXvFaDYfgv2NxP2NcIKEv3g_HOqWHjccG_2SwKjeKd_0tc-LbUqr-Q>
    <xmx:hXvFaKQ8Q4M7wzqEX-LlMbGPcxGMhCH9JUX_UhVoWG9YGVBGfeTk-La5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 75A2E1EA006C; Sat, 13 Sep 2025 10:11:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Sat, 13 Sep 2025 16:10:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <98d206ca-3dc1-42cc-9f01-e3241d5a24af@app.fastmail.com>
In-Reply-To: <20250911204302.GA1907101@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
 <20250911204302.GA1907101@coredump.intra.peff.net>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025, at 22:43, Jeff King wrote:
> On Thu, Sep 11, 2025 at 04:32:56PM -0400, Jeff King wrote:
>
>> It is a little funny to do it up front even when we're going to direc=
tly
>> run a builtin, but I don't think it harms much. OTOH I find the whole
>> placement a little odd in the first place. We are speculatively adding
>> to the cmd list before even finding out if we have an alias. It kind =
of
>> feels like this should be part of handle_alias() in the first place.
>> We'd need to pass in the cmd_list variable for it to add to and check.
>
> IOW, something like this (perhaps as a preparatory patch):
>[snip diff]
> And then along with that:
>
>   - a new test at least of the looping deprecated case (we have an
>     existing test for non-deprecated looping aliases)
>
>   - while we are moving all this code, I might consider calling cmd_li=
st
>     something more obvious like "expanded_aliases" or something.
>
>   - the placement above puts it next to the direct-recursion check in
>     handle_alias(). But it does change the output a bit, since we now =
do
>     the check after the "-h" expansion. So Before we'd print:
>
>       $ git -c alias.one=3Dtwo -c alias.two=3Done one -h
>       'one' is aliased to 'two'
>       'two' is aliased to 'one'
>       fatal: alias loop detected: expansion of 'one' does not terminat=
e:
>       one <=3D=3D
>       two =3D=3D>
>
>     And now we'll print:
>
>       $ ./git -c alias.one=3Dtwo -c alias.two=3Done one -h
>       'one' is aliased to 'two'
>       'two' is aliased to 'one'
>       'one' is aliased to 'two'
>       fatal: alias loop detected: expansion of 'one' does not terminat=
e:
>         one <=3D=3D
>         two =3D=3D>
>
>     with one extra "-h" line. Probably not a big deal, but that perhaps
>     points to the fact that we could be detecting the cycle one loop
>     sooner. I.e., as soon as we see that "two" points to "one" we know
>     we have cycled. We could probably be checking new_argv there
>     instead, after adding the current name to cmd_list (and in fact th=
at
>     would catch the direct-recursion case automatically and we would n=
ot
>     need to do so manually, though maybe people prefer the more specif=
ic
>     message it produces).
>
>     I'll leave that as an exercise for the reader. ;)

That=E2=80=99s great, thanks.  I=E2=80=99ve added it as a preparatory pa=
tch/commit with
this message.

-----

git: move seen-command bookkeeping into handle_alias(...)

We are about to complicate the command handling by allowing *deprecated*
builtins to be shadowed by aliases.  We need to organize the code in
order to facilitate that.[1]

The code in the `while(1)` speculatively adds commands to the list
before finding out if it=E2=80=99s an alias.  Let=E2=80=99s instead move=
 it inside
`handle_alias(...)` and in turn only run this logic when we have found
an alias.

This is not a refactor since the error output is changed; we will
now print

    '<cmd1>' is aliased to '<cmd2>'

while iterating in addition to the final `fatal` message.

[1]: We will do that by an additional call to `handle_alias(1)` inside
    the loop.  *Not* moving this code leaves a blind spot; we still
    detect regular alias looping/recursion but we miss it when it is
    done using deprecated builtins.

--=20
Kris
