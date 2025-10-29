Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941E285C89
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737621; cv=none; b=qAW31SxQa4ZZxZypIwhGlbHbj5DteIkx/xNJGhEc68nqIMbfAHf4/TzsqH2m6OKzf2nT3oD1mrYQ1MLg9E54MW0ei97qkMaREJuOGdRrk9tTtKrdrD7C9Zqx+EmQ6BIWCHxs55zR9mfA2DfMP4EV8qrp2iTQVouBKDFG0vSFfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737621; c=relaxed/simple;
	bh=J3SmHbHcPN9vsdCJ2qJ1YkkjiV0LPkKYsADbY87w650=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bw+zGEDpe3jxVQMH8EZtGDVxRu5AMzXoi6XyI86Ehgc8ymZruDvz+tTaARWkz8s2gmkg9AKCCr0Pff2uLvtetY/XjBfQY3AdSJsNoyHW85NmK1nvvGBUvGonVj1O/sLssHHRH6KKzuVjm1IMYazvFH/Drd7lkFybRuLT+n45UXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MyX1Uiep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uEMbXTPY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MyX1Uiep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEMbXTPY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D2A7D1D00075;
	Wed, 29 Oct 2025 07:33:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 07:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761737617;
	 x=1761824017; bh=GInO+Bu4c4hfS8JE/D3RMw/dsgfJTtLSc2kzbRyI8Jc=; b=
	MyX1UiepmLNWtnYCEN/X6rddud7ykwfazPTOwB0qMucPJF7nErB2dbMpObAk8OCk
	3K0OkvOPQxoB9/79TABGiiLUfxpzCeCoNrhRGlBIzpVDaJ2K6+a6QbT/KHWcajwA
	ub+XyjJb8uDucL9v4AMfsfcMIRblKMedyDqoroWbYoHJzuUSzToJe2pNVl7Mxg+a
	xaiZul2LaHQBLti1y1fP5mUICCoxf1gSpbC8SkZiMwNi17O/KhtCWhoP9cy0zXU2
	BkOQ8it0jLobTQCit0bLjz0z7COpyezUyh32Kc5CcL3A4F4pzg7gBgc9Azn+JT07
	XmQPnGyM9I2su0gjUBqTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761737617; x=
	1761824017; bh=GInO+Bu4c4hfS8JE/D3RMw/dsgfJTtLSc2kzbRyI8Jc=; b=u
	EMbXTPY0aC4GA27SwV376k/f6QwZkvH7jib9CJjcNvDYOINQzvSsOB4tU/AmQcZ7
	ZKqlENiFv/ke51VN00Sidft5o0AH5svwHZZirlAFxVXVzcC0q2LN7uatNong5L8n
	urS5g03sNi8+sBAwHRpYgDSR4R3x2ZOZtbDZBYNETCwkDFk87KGJWKAHPbOBmbyR
	G/b8wsviEMUUDA1hGXBojnNwv30KP8jrsDFwxYLfzKSBIgFL3lnTjstY6orn53lZ
	T/IdcIo5mrOxh8tKIhxC4+EazGojipVq8jmD62e8ZPVDd0OFRK0n0AlV8SkTG4XA
	TBfNZCje+7Yv5Et7Vn+JQ==
X-ME-Sender: <xms:kfsBaX36J0hpBq-FE_T75wjnWhXSmGvQ8yP9ciXU5j-MYpy4RnQnYVg>
    <xme:kfsBaQ7J3NAftW3l4FYJDQ2aBqRXV_n31rIUugkbTVm5IH54k9c_hQUSlJXVBveWZ
    cV0NeT4bOIgFF2fejQet6gctGPEV-b3PI4c867lvrvsLOIM00WVPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghmrdgsohhsthhotghksehshhho
    phhifhihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kfsBaZ5x1CN4aV25ipK1GZWZ8JkQP4WEvd0PybmpjAfCma5ipuyFig>
    <xmx:kfsBaUARRhZXsWfiDqYKNcI9Cjn1NluSreDu2w0ui2hN3mE9ndQifA>
    <xmx:kfsBafcxUdr0WCMKgkgP0iYIK-xgIGIPq6babX_OpeTrhHmmsf973Q>
    <xmx:kfsBaTJ4Y3_csd7Lt9JT0fKENnhAnM7t6C1znDB_liiaJRe55Or6gw>
    <xmx:kfsBaWZjJgRVmtXJs2BWexC-V-mJnEGIAHFN4eyivcmOmcLik8SgOSje>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3172E1EA0062; Wed, 29 Oct 2025 07:33:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwMCQN4XWsM-
Date: Wed, 29 Oct 2025 12:33:15 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Sam Bostock" <sam.bostock@shopify.com>
Message-Id: <85d6fdcc-cee3-448a-8bda-72791f342be3@app.fastmail.com>
In-Reply-To: <aQHoKXtrbDx6eNpH@pks.im>
References: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
 <aQBwiE-bhqcaSHG_@pks.im> <xmqqfrb3dnis.fsf@gitster.g>
 <aQHoKXtrbDx6eNpH@pks.im>
Subject: Re: [PATCH] refs: support migration with worktrees
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 11:10, Patrick Steinhardt wrote:
> On Tue, Oct 28, 2025 at 09:00:43AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> >>  `migrate`::
>> >> -	Migrate ref store between different formats.
>> >> +	Migrate ref store between different formats. Supports repositori=
es
>> >> +	with worktrees; migration must be run from the main worktree.
>> >
>> > It feels a bit weird to single our worktrees specifically. We don't=
 say
>> > that the tool supports bare and non-bare repositories, either, so t=
he
>> > only reason why we'd have the note about worktrees is historic lega=
cy.
>> > How about this instead:
>> >
>> >     Migrate ref storage between different formats. Must be run from=
 the
>> >     main worktree in case the repository uses worktrees.
>>
>> Two thoughts.
>>
>>  * Would it be unacceptable if the primary repository and refstore
>>    uses reftable backend, and a newly attached worktree to the
>>    repository uses ref-files only for its per-worktree refs?  If we
>>    should allow it, then "if the ref store you are migrating is in a
>>    repository with multiple worktrees, you must migrate from the
>>    primary and migrate _all_ ref store for all worktrees at once,
>>    into the same backend", which the design of this patch seems to
>>    aim at, would contradict with it, no?
>
> The problem we have here is backwards compatibility. Right now we assu=
me
> that `extensions.refStorage` applies to all worktrees, so if we wanted
> to change it like you propose then we'd have to introduce a backwards
> incompatible change.

I don=E2=80=99t understand the motivation or use case for supporting dif=
ferent
backends for different worktrees. But Junio would have to explain that.

Maybe the motivation is this weird (from a user=E2=80=99s perspective) l=
imi-
tation that you have to run a command from the main worktree?  Okay,
that=E2=80=99s strange but you get the error and switch to wherever the =
main
worktree is (that the error message hopefully helpfully provides you
with) and run the command there.  Then you forget that weird thing five
minutes later since this was a one-off command.

>
> I agree though that it would've been great if we would have said from
> the beginning that the worktree-specific configuration is allowed to
> override the ref storage format for a worktree. If so, we could easily
> convert any of the worktrees (including the main one) by without having
> any impact on all the other worktrees.

As a user I don=E2=80=99t understand why that is a great thing to have.

>
> But we do not live in such a world right now, and getting there would
> require some significant reworking of how we handle per-worktree
> references. Unfortunate, but I also don't think there's a strong enough
> reason to change this.
>
>>  * If "you must do so from the primary worktree and we convert all
>>    the worktrees attached to the same repository" is the only mode
>>    of operation we support (which by the way I have no problem
>>    with---the first bullet point above was asking question, not
>>    suggesting change of design), then would it be easier for the
>>    user to use if the command noticed that it is not in the primary
>>    worktree and switched to it for the user, instead of complaining
>>    and failing?
>
> I'm not sure. The question is whether the user recognizes that migrati=
ng
> references in the worktree would also migrate references in the main
> repository. It might be surprising behaviour if we did that without
> asking.

On the contrary, as a user I think it mattering what worktree I run this
command from sounds very weird.  (But again I can tolerate it requiring
me to run it from the main worktree if there are technical difficulties/
limitations.  But using different backends for different
worktrees is very weird, again.)

If I run `git gc` I don=E2=80=99t want it to do different things based o=
n what
worktree I am. I want to operate on the repository, and the repository
is the same no matter what worktree I am in.  The same principle applies
to this command in my mind.

Is the =E2=80=9Cmain worktree=E2=80=9D even something that makes sense f=
rom the user=E2=80=99s
perspective?  It seems like it=E2=80=99s just a side-effect of the fact =
that the
repository itself has to live somewhere.  Imagine I have one main
worktree and two linked ones.  I delete the main worktree.  Imagine that
it works because the repository itself is moved to one of the linked
worktrees (arbitrary).  Which then becomes the main worktree.  But the
user does not have to care as long the user does not poke inside the
`.git` directory.  Which the user should not have to do (there should be
commands to answer whatever `.git`-poking motivations).

I am of course not suggesting such a change.  But the point is that the
=E2=80=9Cmain worktree=E2=80=9D is not such a useful end-user concept.

Sure, I happen to use a =E2=80=9Cmain worktree=E2=80=9D in the informal =
sense that I
often have the original path where I cloned or created the repository
and I have the other ones in satellite locations with more
pointed/topical names (e.g. `git-mine` is the basename of the Git
worktree that I use to `make install`).  But I never ever consult `git
worktree list` to remind me what the main worktree is.

Okay.  Let=E2=80=99s say I get tripped up by the gitlink or whatever it =
is kind
of file that worktrees use for `.git`.  Because I really want to poke at
the `.git` directory.  Then I think =E2=80=9CI need to find the main wor=
ktree=E2=80=9D
because it happens to have the repository and the link to that directory
could not be implemented using a symlink, maybe because of Windows
filesystems, I don=E2=80=99t know.  Again a technical limitation to my m=
ind.
No worktree is special except because of technical limitations.

(The =E2=80=9Cmain worktree=E2=80=9D even becomes a technically contradi=
ctory concept in
the case when the =E2=80=9Cmain worktree=E2=80=9D is bare. And that is a=
 popular
practice for some reason.)

And I wonder how many worktree users even actively think about the fact
that per-worktree refs exist.  It=E2=80=99s the kind of thing that you h=
ave to
logically conclude *has* to be the case:

1. `HEAD` is a ref and you need that for a worktree
2. You can have a bisect session in a worktree and that uses refs under
   the hood

But:

1. Conceptually I never really think about `HEAD` as a ref; =E2=80=9Cwhat
   branch/commit am I on=E2=80=9D is what I care about. It=E2=80=99s the=
 only builtin
   symref that I know of (or ref or symref depending on...). Not a usual
   ref at all.
2. I use git-bisect(1) to find a commit given a criteria.  Ones I have
   it I note the commit.  I don=E2=80=99t care that refs are used to sto=
re the
   bisect state while a session is active.

According to gitglossary(7) these are currently the only per-worktree
refs.  I do not know if you are allowed to use the `refs/worktree/`
hierarchy to create refs beyond that.

>
> It might of course also be surprising if you do that from the main
> working tree. But I think there's an argument to be made that it's at
> least _less_ surprising.
>
>> >> @@ -95,7 +96,7 @@ KNOWN LIMITATIONS
>> >>
>> >>  The ref format migration has several known limitations in its cur=
rent form:
>> >>
>> >> -* It is not possible to migrate repositories that have worktrees.
>> >> +* Migration must be run from the main worktree.
>> >>
>> >
>> > I'd drop this bullet point entirely, as I don't really see this as a
>> > limitation anymore.
>>
>> I agree that such a limitation should be lifted, but if we have to
>> say "you must do it this way, not that way", that is still a
>> limitation ;-).
>
> So with the above reasoning I'm not sure I'd call this a limitation.
> It's rather a mechanism to protect users from unexpected consequences.
