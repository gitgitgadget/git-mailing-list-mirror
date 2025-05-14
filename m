Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70342746E
	for <git@vger.kernel.org>; Wed, 14 May 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257016; cv=none; b=qgNxs38x5RV0HdJyBKhVDiQWinJLP/35wIdsUqVclez6l6ya07LBOf7cJ7Kgrc1ztbVrFpuqGpIQKfrhgwl5f6q/0Zh4pOpWwgOhTzzVdCtoflLbe4PRuOJPhYInioVpwxAq8Xp5PwZMvGCWLPvOAjizsJCWbKNkeUgtl7LwMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257016; c=relaxed/simple;
	bh=xiE3iXnCZb+DWiOiPhzK12gkDEPsjhylMHmhvTGDvOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzaSvWib7ScuZ9jkXn/KmhAp/o6YlxgluM3+PhScy12q6ipLAPzbDeWcaQ6D8cTSSAqltXDXNtpbt7Sj3PwG/zrIKZyWfp2IdUhD3T1dFR2PSJ9zg3JPisXC4SBHG5AOXw5DtUKqACuVikOVRarvsyPTmZULHnV3gCvhZSyCowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WbsJalvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owN3HPg6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbsJalvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owN3HPg6"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 717EE254009D;
	Wed, 14 May 2025 17:10:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 14 May 2025 17:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747257012; x=1747343412; bh=FYGHRom681
	QKlg4AJtiAto8iLhwqChebhKJSkygSIek=; b=WbsJalvXd2Lp/RmE0ArQek/8yn
	+0Y9F6+tLl8RuHAnAdhWRqZ6WufK9pqmA2ed7gQGnaDD2diCHRQFdHVOcFO3lLvY
	5xl6a4hqYO5GKdGSjbGeOj9JR2/htxVirajOZ4iqRKH0dHz9fqBQGSrWT7wsH9l0
	AxBGLSTPANkmwN8SC49Y9W+8PDfGWuWqub380psg4+NdcOCGRUa3HXNAONG7i3VL
	RKXBGCgj8IR9L9iercDJCw7EmAiAlyx6E04QtQ6TOpsOLuYr05TcFYTNlp/5Gvyz
	b35b/Cxu7do9fTcks1W7ObHwnIwxpZ//ZTV+1zOWmf3sGso3CQoIqpUbOLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747257012; x=1747343412; bh=FYGHRom681QKlg4AJtiAto8iLhwqChebhKJ
	SkygSIek=; b=owN3HPg66WqWkuBntmNVFX7jdjqkqK8uQCxTMfCSxr2zBHMdIiw
	as+q+D2+LA4v5Yy3UDMAKQKXDATgxApBw4swqhyLN+FgbOpdqj8+8o5R71RW8Tl/
	F5aDmWF8zvZAgcIclJVHFxnlwnrXugQ4/m6o/WpSBR6AiZUcM0J0CZuv4uYGJmfy
	AbSHgnbduVupdfu3CS4AmplzpP2G5SXnlb1ncehrL8t3LW78c7Pyu9Wzu2106Hmu
	ui8PnH+tD+EMgN372NpksXa+0eASUK6zPCd3rO2+knBbLNGHMRERctstBg9RVkut
	GyqAHpTkGaCztGi0nyQ5MkmrJn90m3eFLeQ==
X-ME-Sender: <xms:tAYlaEatvA8d0zDbqEONoD6n1-7OPVx8Hi0wpUPz7ATe5KevLm3MoQ>
    <xme:tAYlaPbGgO9RdJNFoZeQyfG0vytqzTXKx3nET_ZP9q2fKqU2fxHgE53znrv4XYdgQ
    NKJeQIv8XNwcAeLgw>
X-ME-Received: <xmr:tAYlaO8SvmKv4MDRNsDP-Btrow-ag1-zz11y0M6ortuFuQ59jeK2BhOkQjFEv9jhrH9lyaOyKNl3X2PYLUbmzRk0yxSggzspeZeuMbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvg
    drkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tAYlaOo1KMsQmKE8MyTNlp0jLr84JojufPqI9NM7oLqr3dfXypGDYA>
    <xmx:tAYlaPr0inx5pGzsUpMUPLNwXePdkOMqR2VruACvrgG7F9PP_c_hVA>
    <xmx:tAYlaMSGoQJuU5sThmByzNPSljkGh9Ft9RE9tjWXL-u47nuW6kZxKg>
    <xmx:tAYlaPoKKOUpIdyiDbtVhqFqHkDzrq_nNr0HAhT-w08P0XIi_vpwZA>
    <xmx:tAYlaJj8o4bAh3th8IPQ6KGpsiH1PKJ4WlnqLObn1FcasWqPuKXo18aE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 17:10:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH RFC] diff --no-index: teach option to exclude files by
 pattern
In-Reply-To: <20250514204014.3106177-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Wed, 14 May 2025 13:40:14 -0700")
References: <20250514204014.3106177-1-jacob.e.keller@intel.com>
Date: Wed, 14 May 2025 14:10:10 -0700
Message-ID: <xmqqzffe7vbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git diff --no-index the ability to exclude files by wildmatch
> pattern when recursing through directories. The '--exclude' option
> builds up a string list containing the patterns. These are checked with
> wildmatch() in the read_directory_contents function. If any pattern
> matches, then the file is not included in the directory contents.

A quite natural question that comes to mind is:

    How would we do this for the normal "git diff" that is not the
    bolted on '--no-index' mode?

but ...

> The --exclude option is only supported by the --no-index mode. Standard
> diff modes support negative pathspecs which is more powerful. I tried to
> see if there was a way to add support for negative pathspecs themselves,
> but haven't yet figured out if this is possible.

... of course you have thought about it already.  I do agree with
you that we should figure out how and teach this mode to also use
pathspec, not necessarily only the negative ones but positive ones.

After all,

    $ git diff --no-index [<option>...] dirA dirB

is like running

    $ diff -r [<option>...] dirA dirB

after preparing these two directories like so:

    $ git archive revA | ( mkdir dirA && tar Cxf dirA - )
    $ git archive revB | ( mkdir dirB && tar Cxf dirB - )

Hence it is natural for users to expect that anything you can do
with

    $ git diff revA revB

should be doable, in

    $ git diff --no-index dirA dirB

and vice versa.  And as you said, when comparing two revisions,
you'd use pathspec for this kind of thing.

    $ git diff revA revB -- Documentation/ t/ ':!po/'

So, I pretty much agree with the need to be able to exclude some
parts of the tree(s) from comparison in "diff --no-index" mode, but
I doubt it is a good idea to tell what to exclude the "--no-index"
mode in a completely different way.

The last time I looked at it, I got an impression that the command
line argument parsing of "git diff --no-index" was messy (which is
sort of inevitable, since unlike the normal "git diff", it can
compare more than just two "collections"---it can take two paths to
regular files, for example, and in such a case pathspec arguments
can play no role), so teaching it pathspec parsing might be a bit of
work, though.

Thanks for starting an interesting topic.
