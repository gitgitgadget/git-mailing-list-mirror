Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBE281503
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649698; cv=none; b=eT5SB/LIIYwXCCtzzThNGl12y2j7C+x/5lEbDxT21AZJjqxaS585vFR69SuzSMn7hjZpkO4md9esGyGCT9/RcGYdlLPJfYEBBAb14CpgV3DRv4ZmhCR+Vf9aVjFK1jye1FunaFF0fl7c71rwf2nTsghRdxIRza5KeO7mlXuNeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649698; c=relaxed/simple;
	bh=88phrxrdec6/HR8dLRL8b3R/GMYIPLRvBeewXdF+OeE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hol81fy5j8jXnx/9S7H2UNKqDcslthCfNx8ayhU2xMfCjj2w7I7mNSCy6ahJFpLoK3giF7tm9yYlk+k1prO86qb59QYbHg2RIGiIH7xZ81lFIFe/JWJ8KZ3hyMrhXLc88ScF/hQ73EogVh6BMHraux5GQhQyeJz5hq9TGTL5TDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=az1LYZTc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOm1/Iu/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="az1LYZTc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOm1/Iu/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EB87FEC01C0;
	Tue, 23 Sep 2025 13:48:13 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 13:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758649693;
	 x=1758736093; bh=qtyVU+xLb8tAK5mDD5psf8QD8DhOIuIZ1Nawqc3Nam0=; b=
	az1LYZTcVhZjRgvo4eztPmqCDQ7/Z3buC5JQIMuYw+DDsi+PK6ZV2pAeCsobwOg5
	1o4JI0w9NN8uQ/7vg66eQQxVktnvnTYaVLgviVvpgrOw75ofl+U+vvXzO9jj3N1Z
	uaXsGjbEo1ZpBszU+Gd3hiZrQeQIiE/ckJ+QHj+hbwNEbW6WysEoPoZkS1HwwWec
	tykqYw/QYD/hl9bpI/t+70Xo6/Sok7DSrcfx4OhUaJhd/F11VXWu6g+Dpeu/X7XL
	5DqEn5hTv9b3WODGNgHJoOGcDkv1Gez3ZLY1KlrSGX3rwQnR1VxRFmsWpwGVjVTc
	YoVQX38B6tsFGPYadxfP8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758649693; x=
	1758736093; bh=qtyVU+xLb8tAK5mDD5psf8QD8DhOIuIZ1Nawqc3Nam0=; b=j
	Om1/Iu/kWaLbIZEJSZlO9KsJ9jjcqVNMev9VBChSgrrcMeq7bXeAn9Y4QGVbhK4t
	+1g9+YG3yLFouw8Qx2XD09Wf29hs7P/yx/voNHGEhwcwjzHL4bWPAwJV7prgZHVE
	OA4g1BJ8LxVs5m2+AEltqalWfhzdPmk2DgqxGtdEaLYvWzKzDUMGMowi9klLPPe4
	vjBxTz3cULhE1/KTojSNZP59kH017bgQgnn7E705044mTjTYydKRQNoitetEPl+N
	TzlBqm1BjRaTqPd5TWrkNUsuu94dOvFeaWjgEcewUc9XQl+R25FkMYpnvLezlIif
	htpwVxQg6LRWs1Hu37mGg==
X-ME-Sender: <xms:Xd3SaBlNBSKMdztvecyhtUke69uOLn6eTESd_Jk2kp_AWy9jpHeWk2o>
    <xme:Xd3SaHodIdw2zQjtn8-h2vGxZKFlbys02KIwoMvW97S2UTeuu-ilYs6EDGzu5gfyA
    _lK27jF2dzTkhkGTjMkP6qPGoHVYY5qOJwpd27b9KFnQs6GpL6gwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:Xd3SaIQskfglAhKTgVur79KsBP4q6u7jp3PraLIdqq9YGu_Q6Avrtg>
    <xmx:Xd3SaDvVWO2M128IaEVmqLQollbb_OHLh6NIeJeypAp69VyfTfUX4A>
    <xmx:Xd3SaNZJkIQrOreqEFjEAN7-LV6Q4gouclvdwwanuIf_9p8c1c-M8g>
    <xmx:Xd3SaIufpVaKW8U_Ebs4VR6B7DbM1kDq5ytF4itEkf67wvNe4WAIog>
    <xmx:Xd3SaLb7BhosENfks8p157_W1JFdm5lZq13r2ZU2buniHjhlIPGhKjFc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AD4631EA0068; Tue, 23 Sep 2025 13:48:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AV1qRGHblxFk
Date: Tue, 23 Sep 2025 19:47:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <f1da0f06-e57c-4abd-b9ce-ef3fd5ce2037@app.fastmail.com>
In-Reply-To: <xmqqa52loyvq.fsf@gitster.g>
References: <cover.1758574974.git.code@khaugsbakk.name>
 <bb065767336.1758574974.git.code@khaugsbakk.name>
 <xmqqikharvyl.fsf@gitster.g>
 <ba9b7fb2-c990-44fb-a506-0800d02854a9@app.fastmail.com>
 <xmqqa52loyvq.fsf@gitster.g>
Subject: Re: [PATCH 1/2] revision: add rdiff_other_arg to rev_info
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025, at 19:35, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Mon, Sep 22, 2025, at 23:58, Junio C Hamano wrote:
>>> kristofferhaugsbakk@fastmail.com writes:
>>>
>>>> git-format-patch(1) is supposed to treat Git notes the same between
>>>> notes output beneath the commit message and the notes output for the
>>>> range-diff.
>>>
>>> Is this an opinion, or are there things that existing pieces of code
>>> already do to achieve such a behaviour already?
>>
>> What I mean is that
>> [snip]
>> That=E2=80=99s the point of passing `--notes` to range-diff.
>
> OK.  So it is more like "range-diff is supposed to show comparison
> of pairs of patches; if format-patch shows one set of notes after
> three-dash lines in its output, range-diff invoked by format-patch
> to compare its patches with another set of patches should also be
> comparing patches generated with the same set of notes".  That makes
> sense to me.

Exactly.

I might eventually send some drafts of better commit messages.

>> Thanks for the explanation.  I=E2=80=99ve added `.rdiff_other_arg =3D=
 STRVEC_INIT
>> \` to `REV_INFO_INIT`.
>
> Yup, I think I already have a fix-up patch mixed in your series in
> the integration result I pushed out last night.

Oh yeah I saw that afterwards.  Which made me spot a mistake in my own
fixup... which was instructive. ;)

>> Could it be as simple as `log_arg` or `log_args`?
>
> Yeah, that is much better than "other" (where it is unclear what are
> the "primary" things that "others" are in contrast).

I remember looking at the code and having that realization: Oh, *other*
is *log*.  Huh.

... Maybe specifically `log_args` since it=E2=80=99s a `strvec`?  `git g=
rep
'struct strvec'` seems to give me a lot of plural (style).
