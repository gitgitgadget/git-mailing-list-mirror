Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC12EE27B
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402138; cv=none; b=cTeEU1Mo3DPz9UC7BFAq3g7HR8e+izrA1P0gUO8/MxpsCthDPFa1Rl1Aa2lZXXbk+d30P7tpttksrIkVwRIMqoaDVDgi1oL6wUI+6jqCJtTlh5s+iXS23vlXp1fzuX78mAxKYHE/CTsOpFYxP7/idyYUAMbRU95RiVkf9oAx1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402138; c=relaxed/simple;
	bh=/PQthI0I7gGK3Iw5O3KuUA0P2TAEK2Z8XznKMHfKhcc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pDsrgYgLFXMCHoQoShjHPcVHpKKxHxyzkAnXGeshjnIVAaVd/dd2HypyuhDWjklikwnK9YtEGnVtz7c4ieGr2zZcDg+SbvAyFjgPD688PeZa9A4kQzHODBC57sscUJYqAE0FZiSx//ueVKhqG8EvMJr14x5j9+WIGwYowjF1P0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c1LghKN+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=heHZZ7B+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c1LghKN+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="heHZZ7B+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AC201D001B1;
	Tue,  1 Jul 2025 16:35:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 16:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751402135;
	 x=1751488535; bh=flkWiS1MdfPRbtbPphLPQe8Q8xVSZMkde+EHnttr8jg=; b=
	c1LghKN+0IkWqgopp5jzGk+UlncDz4RT/7LHhv5WpXPjItXTsPqxsQgS+4ynckd8
	caypwsepD8CZNIsolnJx60kFKzuyb41MwvbCs9k+ZfJpqGykvKc6wYJ16QUpaPye
	JZBL7sa82xJnVg7xJ+VCklW+5fBgMBwxnv8p9y6zBDcuTsGJ/03EU6XQs0/SbwXS
	/oeSb8KvGjFvTbLsDEb6xTQPZTN3Kfpril4HQvFZ6K9eVx+4w+s0AlAhgUSZiOlZ
	uX4i1uMMYNaOCV5n0x1mLxB35jW0NfyAs+FuTOZym40cCYFQACYi+bklTH5GexMe
	UiotEfnGG88pJg+U1C6Uyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751402135; x=
	1751488535; bh=flkWiS1MdfPRbtbPphLPQe8Q8xVSZMkde+EHnttr8jg=; b=h
	eHZZ7B+kr9xj6RPS/HRZynD/c+k249+XHSNPGSbycMMWaZ9Ufc8YigKsk8XLDhqh
	qf5xRS0j7sBeAqdbiMrr28lNqpxQQ4WcXB7TVwOCYBNCX5pvZ731vG6MyrMYgjNm
	wTvWDlj9LFXLK8aPjoV3CCKOUZhO4vcokbaEmPP1Ua3L5UsfpM/InrIbvkjCdKIJ
	b8OW3smEn1BBU8yGrRJsU5fOdBl5ucTaueg0l8ukam+5aPempLi0iGxtUi3SLGgt
	R7G0OQ4AmsBbwqfhUNgqqgpWkX+ct+WEzwmI+0C0nhQ/j1xtahsuTYUQ0b9pwvIC
	i5rhZgKEjhep2u0FwvlLg==
X-ME-Sender: <xms:lkZkaAhIMfU18vbNsGrGKmuW4GaS9euXwUoFn7obzkhkhv5tlS4X10w>
    <xme:lkZkaJD3CEzUBV47tb47qdCeoGRb2LG4LTT699DDXxGWKWcFx7x1L7u22lM-3CrKr
    W8hjWCO3_1luegpbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lkZkaIEgXX6RTnS_5a0DZpGmfdnHUZD67H8W-fUvogKK809LTMljBg>
    <xmx:lkZkaBQpqpJQK7AxDDLiorVeWTRX0a0sDcae_S5hZBA4JXPwSRtRUg>
    <xmx:lkZkaNw5D8a3NzmWHelr5n2e9OWFpGhR9KsIWXfRUySdt5Rf7_F5KA>
    <xmx:lkZkaP7mLaJp_LBVxkqMnGjO9_uD2ZfwTs7Zn5gT7gW6PqhunB_ooQ>
    <xmx:l0ZkaHkiRmtfH9Jqv_RD5PXitCYAXwHPUa7DorM9a5VAjcgLj5xFRbXd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C57201EA0066; Tue,  1 Jul 2025 16:35:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2f1a40a58e1f4414
Date: Tue, 01 Jul 2025 22:35:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
 "Derrick Stolee" <stolee@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
In-Reply-To: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
Subject: Re: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025, at 11:33, Toon Claes wrote:
> This is another attempt to upstream the ~~git-blame-tree(1)~~
> git-last-modified(1) subcommand. After my previous attempt[1] the
> people of GitHub shared their version of the subcommand, and this
> version integrates those changes.
>
> What is different from the series shared by GitHub:
>
> * Renamed the subcommand from `blame-tree` to `last-modified`. There w=
as
>   some consensus[4] this name works better, so let's give it a try and
>   see how this name feels.
>
> * Patches for --max-depth are excluded. I think it's a separate topic =
to
>   discuss and I'm not sure it needs to be part of series anyway. The
>   main patch was submitted in the previous attempt[2] and if people
>   consider it valuable, I'm happy to discuss that in a separate patch
>   series.
>
> * The patches in 'tb/blame-tree' at Taylor's fork[3] implements a
>   caching layer. This feature reads/writes cached results in
>   `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
>   size, that feature is excluded from this series. I think it's better
>   to submit this as a separate series.
>
> * Squashed various commits together. Like they introduced a flag
>   `--go-faster`, which later became the default and only implementatio=
n.
>   That story was wrapped up in a single commit.
>
> * The last-modified command isn't recursive by default. If you want
>   recurse into subtrees, you need to pass `-r`.
>
> * Fixed all memory leaks, and removed the use of
>   USE_THE_REPOSITORY_VARIABLE.
>
> I've attempted to reuse commit messages as good as possible, but feel
> free to correct me where you think I didn't give proper credit or mess=
ed
> up. Although I have no idea what to do with the Signed-off-by trailers.
>
> I didn't modify the benchmark results in the commit messages, simply
> because I didn't get comparable results. In my benchmarks the differen=
ce
> between two implementations was negligible, and even in some scenarios
> the performance was worse in the "improved" implementation. As far as I
> can tell, I didn't break anything in my refactoring, because the versi=
on
> in these patches acts similar to Taylor's branch. To be honest, I cann=
ot
> explain why...?
>
> Again thanks to Taylor and the people at GitHub for sharing these
> patches. I hope we can work together to get this upstreamed.
>
> [1]:
> https://lore.kernel.org/git/20250326-toon-blame-tree-v1-0-4173133f3786=
@iotcl.com/
> [2]:
> https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786=
@iotcl.com/
> [3]: git@github.com:ttaylorr/git.git
> [4]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/
> --
> Cheers,
> Toon
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> Changes in v2:
> - The subcommand is renamed from `blame-tree` to `last-modified`
> - Documentation is added. Here we mark the command as experimental.
> - Some test cases are added related to merges.
> - Link to v1:
> https://lore.kernel.org/r/20250422-toon-new-blame-tree-v1-0-fdb51b8a39=
4a@iotcl.com

It feels like the command strays a bit from the usual patterns to me.  F=
or paths/files=20
that is.  I like this:

```
$ git last-modified -r refs.c refs.h
062b914c841329a003f74e1340ea5178391274a6	refs.c
47478802daddf3f9916111307f153c6298ffc0bc	refs.h
```

I ask for two files and I get those in the output.

But for individual files in subdirectories:

```
$ git last-modified refs.c refs.h Documentation/git-last-modified.adoc D=
ocumentation/git-config.adoc
3691fe72d927658ae77ade7fe967544fc6739e67	Documentation
062b914c841329a003f74e1340ea5178391274a6	refs.c
47478802daddf3f9916111307f153c6298ffc0bc	refs.h
```

Same as if I ask for `Documentation`:

```
$ git last-modified refs.c refs.h Documentation/
3691fe72d927658ae77ade7fe967544fc6739e67	Documentation
062b914c841329a003f74e1340ea5178391274a6	refs.c
47478802daddf3f9916111307f153c6298ffc0bc	refs.h
```

But I didn=E2=80=99t ask for the directory first.  I asked for two files.

I have to use `-r` (recurse):

```
$ git last-modified -r refs.c refs.h Documentation/git-last-modified.ado=
c Documentation/git-config.adoc
3691fe72d927658ae77ade7fe967544fc6739e67	Documentation/git-last-modified=
.adoc
062b914c841329a003f74e1340ea5178391274a6	refs.c
47478802daddf3f9916111307f153c6298ffc0bc	refs.h
0fbe93b36c05bbf4156c157f27998938ce312265	Documentation/git-config.adoc
```

And `-r` with a directory like `Documentation` will recurse through that
directory.

As a user I imagine I want `-r` to control whether to, say, only show
each directory under `Documentation`.  But now you seem to get a special
case of allowing directly listing first-level files but not the ones in
subdirectories.

I=E2=80=99m more used to being able to use individual files if I want th=
at
as well as pathspecs for recursion.  But now I just get the directory:

```
git last-modified -- 't/*'
532d9a0984e6464deadb6bdb0287fcce2990adc9	t
```

But I can still use pathspec magic which is nice:

```
$ git last-modified -r -- 't/*' ':^t/t1016*' | grep 1016
<empty>
```

I=E2=80=99m imagining that you may want to feed a specific pathspec to t=
he
command and get only the output for those that match.  Without having
worry about turning on recursion since that may cover some of the things
you want but also make it do too much.  Well maybe that is just as
controllable here but it seems less obvious than for commands where the
pathspec is used more directly (?).  I appreciate when these commands
allow me to express things directly without postprocessing (no excessive
pipelining).

Also you get a sort of trailing error if you give a non-existing option:

```
$ git last-modified --recursive
error: unknown last-modified argument: --recursive
fatal: error setting up last-modified traversal
```
