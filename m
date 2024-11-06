Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770661F9EB5
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921525; cv=none; b=tZbkN24+Fje5ubXEh6BQuvNseQW0atI0i0J4QJv7d5Ld4n4CY+iXoNkhWW7s9edPhem+0Vb3S8nxR1PhWWScz41XiuCiAnajXMKMoNcP1eLKns5XnNBcM3ysAndJ9ib0877hqY+CUjsng7g2hu/90CtvieSxxtASZVuT5tAxnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921525; c=relaxed/simple;
	bh=f5YpdMPdZ9HVN8bobsJXC843GIvqJZ6B4egwN5IpxCQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LiPsiCweL5DGs2XxU4cCIn9OYV1sA16Ou3CbEZGGyQCKym7K71wBh6iQAvAhszYq1rPVi4SS7Iu3JAMShYMwEUEeWx5T5vzeudlCq29AXrvZCWo+lbxdOKJW/Fi800fTdk0Tuy0e4W614nsOiCT79nacAk9G7jPpVqp5ItxFp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p4jHWORO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JH3Q4+dq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p4jHWORO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JH3Q4+dq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A545311400D3;
	Wed,  6 Nov 2024 14:32:01 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 14:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730921521;
	 x=1731007921; bh=FPhU0G38BjgUe0VfDlekpDFWtgaYccnaUdNiXaYzUro=; b=
	p4jHWORODWyMgcnrts/gIb41kR5sE4Z16yFiyuFGeeOKnZR2kSaw8wGA1Bg6qKLS
	pTksjEYuC8C6iOp/MXgLrbKB816bAlQGNZ1ZpEFuzL6x2kAhOGf81xvPx88utDPS
	yrq+a8KaMjAq+PaKpwNeBFi2ZZ6IZ4F46n2x39LjGNWx8D63cn5JibE9YHDMelpD
	wyyY0iMQoSifsZnrm4dKur71le+3mBY25EZp3cWgiKNpzs3Fw7bNDOJsbslQAG/1
	Urgv2y8RYRwMN9VcnosFv1Mrm+DWkvDlERIqqIENIegVccnVvRmHIP39k+Y2iS5t
	9YFan3t5JDXlk7SYZIb84g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730921521; x=
	1731007921; bh=FPhU0G38BjgUe0VfDlekpDFWtgaYccnaUdNiXaYzUro=; b=J
	H3Q4+dqrzE3UcK9WapNIlfulEhYOZKMi1Fs0gulT8O7N/BwsY1GZVCpIhQ5xFN0E
	fMtVOhzre5T5sQkWGt+CilfjcNAvYxajXvo6EfPG7mIIcbEVUmRufK+qZ6aa/SON
	4teav9UdplPbMnMJDHHFRa4ifGyL+fnkKYHUFLAJeU0GqbGN4HNUBWyAjKQYIdnC
	x9/LKrUkKFyfEvn/Mz9s+ExtsXK8OnKGoOErWFFfo0skUbDZIPxYrgqtZtjgrbGD
	5CGx7QSxEmHgHF9HnZtwRCDZAoi4Q0hNPMcgtRmqo7aBFlUhFoZenkk0KP13rwoP
	/cEXyGDXNrFxR5w41iIkg==
X-ME-Sender: <xms:McQrZzbGg4NQX8udhjB-zfALEBVyw5DICh5FiHViG4q-eF2Av2iy-I8>
    <xme:McQrZyYF7jiRYffDd1veKV5Nd4vw6FdsaDhbuTL8tjmNqzXMZMB-wO1iv_AV8j8nc
    kqYsXSxHAsfjA1rvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeej
    keelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:McQrZ1-tYMDHRmQzUGtAQO_tUbONHyNfIYiGdm67iULPZRmCP4o-pQ>
    <xmx:McQrZ5qXZD8C-SoUDN41gHuK92Kv-mrPSC513QE7_0OrumpJhKEqDA>
    <xmx:McQrZ-qsROheY3Wsswxkr4oHn7UPVmNaX66vPXuCw8xMeqp1kzP0Mw>
    <xmx:McQrZ_R3Nm2x6aMZDd8bVqt-cAhWrxAd4oL4Omkk9XH4bZ5yujOGrw>
    <xmx:McQrZ3nOKOxDT7jHuQi06a1EKiuvUrBLQD2ceRdCxVsYwimMfxM9BeBz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B03B780068; Wed,  6 Nov 2024 14:32:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Nov 2024 20:31:41 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <9ce2d94d-2baf-416a-9368-502d08886f9b@app.fastmail.com>
In-Reply-To: <xmqqh68q1l37.fsf@gitster.g>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <cover.1730234365.git.code@khaugsbakk.name>
 <e9be866f33daab2d4038f8b3f1140fe41e5f49c5.1730234365.git.code@khaugsbakk.name>
 <xmqqh68q1l37.fsf@gitster.g>
Subject: Re: [PATCH v2 1/3] Documentation/git-bundle.txt: mention full backup example
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024, at 02:27, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Tell the user how to make a full backup of the repository right at the
>> start of the doc.
>>
>> This is a requested use-case.[1]  But the doc is a bit unassuming
>> about it:
>>
>>   =E2=80=9C If you want to match `git clone --mirror`, which would in=
clude your
>>     refs such as `refs/remotes/*`, use `--all`.
>
> What's the open fancy quote followed by a SP doing there, apparently
> without the matching closing one?  Can we replace it with a SP?

I=E2=80=99ll replace it.

The idea came from merge commits like:

```
Pull more 9p reverts from Dominique Martinet:
 "Revert patches causing inode collision problems.

  The code simplification introduced significant regressions on servers
  that do not remap inode numbers when exporting multiple underlying
  filesystems with colliding inodes. See the top-most revert (commit
  be2ca3825372) for details.

  This problem had been ignored for too long and the reverts will also
  head to stable (6.9+).

  I'm confident this set of patches gets us back to previous behaviour
  (another related patch had already been reverted back in April and
  we're almost back to square 1, and the rest didn't touch inode
  lifecycle)"
```

But (1) space between the quote char and the text to make it stand out
and (2) no trailing close quote (the deindent closes the quote).

>
>> The user cannot be expected to formulate =E2=80=9CI want a full backu=
p=E2=80=9D as =E2=80=9CI
>> want to match `git clone --mirror`=E2=80=9D for a bundle file or some=
thing.
>> Let=E2=80=99s drop this mention of `--all` later in the doc and front=
load it.
>
>> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.=
txt
>> index 3ab42a19cae..0fa181c749d 100644
>> --- a/Documentation/git-bundle.txt
>> +++ b/Documentation/git-bundle.txt
>> @@ -23,8 +23,8 @@ the "offline" transfer of Git objects without an ac=
tive "server"
>>  sitting on the other side of the network connection.
>>
>>  They can be used to create both incremental and full backups of a
>> -repository, and to relay the state of the references in one reposito=
ry
>> -to another.
>> +repository (`git bundle create <file> --all`), and to relay the stat=
e of
>> +the references in one repository to another.
>
> In the new construction, it is unclear if the new command line
> example is about making a "full backup" and not "incremental", or it
> applies to both.  I am not sure if this, especially with the removal
> of "--all" from the later section, is an improvement.  Let me try if
> I can come up with a better version by elaborating the later section
> without touching this part.
>
> This is not a new issue, but na=C3=AFvely, one would expect "full back=
up"
> to allow one to recover lost .git/config entries.  We should tighten
> the phrasing for "backups of a repository" to avoid such misleading
> false promises.  As it is the primary motivation of this series to
> clarify how you would use the command for "full backup", I think
> this point is worth tackling as part of this series.

Good point.  The change is biased by the groove I=E2=80=99ve gotten into=
 in the
last years: (1) of never leaving unstaged changes for such a long time
that I would be said if I lost them, and (2) never using git-stash(1)
unless I=E2=80=99m popping the stack within the next fifteen seconds.  S=
o there
is not much non-ref data (including the stash ref) that I would miss.

(But I have started using local repo config more so that could be lost)

And with worktrees, people could have a *quite a lot* of uncommitted
state lying around.  Since some people use worktrees like branches.

So yes.  There is absolutely a need to make clear that this =E2=80=9Cfull
backup=E2=80=9D doesn=E2=80=99t cover those things.

>
> This also is not a new issue, but the dashed-option "--all" after
> "<file>" is an oddball from "git help cli"'s point of view.  It
> perfectly fits within the SYNOPSIS for this command in that "--all"
> is merely a form of valid arguments you can give to "git rev-list",
> so I do not see anything that needs to be done on this point, though.
>
> So, here is my attempt.
>
> [=E2=80=A6]

Thank you.  I=E2=80=99ve adopted some of this for the next version.

> +
> +    $ git bundle create incremental.bundle --all --not \
> +	$(git bundle list-heads old.bundle | awk '{print $1}')
> +
> +which tells the command to include all refs (as if cloning with the
> +`--mirror` option), but without duplicating the objects already
> +available in the `old.bundle` bundle.

This approach seems less manual than the incremental backup examples in
the existing doc (Examples section).  But I think I=E2=80=99ll stick to =
just the
simple dump-to-file approach and leave the incremental backup example
for the existing example.

>  The 'git bundle verify' command can be used to check whether your
>  recipient repository has the required prerequisite commits for a
