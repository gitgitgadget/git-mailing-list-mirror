Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83651C28E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925644; cv=none; b=Bczw2n7CYNjkiqVnm3n8rkU4jzI+ZJ0TC1oaSAZzNA66pi8f+RmJsS2q/QvzoZezbhktUzPn9VxxTNDZqgCWK6P336gJxGrweFi3ePAJT02CJTydoYhvn3mSnU/I5IvZIZnMvrxmqyWxXkJ/DdHx+ACfohDUoPDMHRthLJ+FNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925644; c=relaxed/simple;
	bh=Vg4uZlyZ0HkocMZU8OO1FNdEuI0+g40mt2USbjUyi9U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JdoBsmMaDdOnKWfUKE+sHmaZWVGQ6UEzLTbqxytceVXbFFU6G4Xg6twoHTMcaKxUalxOzZXMmMpLWjtjV6PQxK+qBGCNBlNxNjVuloXtKsInkaXuEtxjm11GnMQqoqlokd33G/8kHV18FcyDkt4ldSFZD+Ek8QICLX7dywKcvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=HCI9pK6v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wo2UWGrn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="HCI9pK6v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wo2UWGrn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CA8791D00017;
	Fri, 26 Sep 2025 18:27:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 26 Sep 2025 18:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758925640;
	 x=1759012040; bh=+2FlHLoMpFTBYw6iFSSs9DtdtJl5mDiPuxxhQtNWvjQ=; b=
	HCI9pK6vboGMRn3w60qxagWCKSwDVqBncPriRH6745fg+FM6NtkIpGzEMZ+X26PI
	q3BRrHVX0hgk/BSKUThhmEXPo1357ZRFYZgA2SoidusdhgyGkzPupk314P6tYq3H
	KzJOojR70vIN0bHNi9JYL3A3gBplmBDB1muGr1/vpSAtdhXYzBACKCjBp4u2VZFL
	bgJ93oTrgRrsTx6CZ20uByltC05YvXi5XrVE5xnSXQtu2zEtBAFKIUd6rklcPZl2
	SEJ6AYV/zrY43t3vdUnrMOCHIUGavRVoFEcqPktdoB2W/tDiBF/m0ztCFV6hUl2B
	/re7oxEWT9gWg2mlv5N8pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758925640; x=
	1759012040; bh=+2FlHLoMpFTBYw6iFSSs9DtdtJl5mDiPuxxhQtNWvjQ=; b=W
	o2UWGrnLVcUGo2xxoJM37wwjxFx9Sv4bb+zCiASiCBvhJXwXx8XjjjikxOeicMuW
	1AO+P145CpjRCOXSRyxLtDCzrYXJevpxR2w9w0otNqV1IIiKsEmtOzHNQgO0HRfr
	BWmzn5DkX4GR9TuvCqjGgy4El1kcQ1Yefvi5mH8BzNJrz3q6rIRL7w5B1Q5q+gBQ
	RH19tilOHJaCA12bsOPYSHtO8T+uzYbJUAG1xnZOito+sQqh4jnG9r49lLdVzVsv
	G+zvcrMd91R+RePuJd5B+cS3ysfN2hU7bpO0f4Zu4Z/HuOWFIvGxV3YFLvGG9vdn
	I12Q3UHSuqCIWxQdGB1yA==
X-ME-Sender: <xms:SBPXaCcBu2podiYrfAVFTQF4NAqYGO33NAWnao5bO1zv7t-qJAiLkA>
    <xme:SBPXaHBbKzI9A8HuxZamEcYmoCIc9qCUd8203XvDmpMwHyN0EkNaGb_z_GsvHWy3S
    32ISKkOQXXjYNIeyoRq9YqNYBXjeqa0fOIpfhrbsf4x0U0DaD-foQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    ekveegtdeggeduvdfftedvheduudegfeeuteelieekgeekfeeiueetudelhfejffenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdguvghfrghulhhtrdgrshenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdr
    tggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:SBPXaNDmPQGQeKEMT55uDgj6PgRCTDprLGcj-FVYJW2n1cGrrpP_4Q>
    <xmx:SBPXaNBQG9KTyD7litJ3sjeGjiBOQjLj22APgKR2IjSAsr6-cCRmbw>
    <xmx:SBPXaIoFEhU2h448g8rfTN2_SdsuFiS24IwgDrwF_Zpm8lNBV8ZWeg>
    <xmx:SBPXaHmx2vTzsFlpEolxGUw4_cBzAbbErusoSJaaAqUVV_wMsNmOUA>
    <xmx:SBPXaFXspl1L0-hE1gf0GpeRLTrlApJ3zkJJ8W6GHSMzXFM2NNof8HqW>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 593B9780271; Fri, 26 Sep 2025 18:27:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALMQnK0r4jnk
Date: Fri, 26 Sep 2025 18:27:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <2b8193d1-f492-4cfd-b568-107d68112d9a@app.fastmail.com>
In-Reply-To: <xmqqa52havek.fsf@gitster.g>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
 <xmqqqzvvk4bj.fsf@gitster.g>
 <2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
 <xmqqzfaidyil.fsf@gitster.g>
 <1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
 <xmqq348admuo.fsf@gitster.g> <xmqqwm5lcjvy.fsf@gitster.g>
 <442a4f25-7d7b-4f34-9e2c-ce396277e7be@app.fastmail.com>
 <xmqqa52havek.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Sep 26, 2025, at 3:03 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>> In other words, the push.default=3Dsimple mode does not tell Git to
>>> push to a branch with the same name.  Rather, as a variant of the
>>> push.default=3Dupstream mode, it tells Git to follow the same "push =
to
>>> the upstream branch" rule, which requires you to configure your
>>> upstream.  But the mode gives additional limit on the name of the
>>> branch that can be set to upstream.
>>
>> I like the idea of explaining it as "push.default=3Dsimple uses the
>> configured upstream branch, with the restriction that the upstream
>> branch must have the same name".
>>
>> But as I learned from you earlier in this thread: https://lore.kernel=
.org/git/pull.1964.v2.git.1757703309.gitgitgadget@gmail.com/T/#m896f4a32=
ca462d69637b56f9bdfaa61e55e6b952
>> push.default=3Dsimple will sometimes push the current branch
>> to the remote branch with the same name even if there's no configured
>> upstream branch.
>
> It was not me teaching anybody, though.  I was showing my puzzlement
> and confusion.

Oh, I'm glad I'm not the only one who's been confused about how
`push.default=3Dsimple` behaves :)

> When b55e6775 (push: introduce new push.default mode "simple",
> 2012-04-24) introduced the "simple" mode, the intention was fairly
> clear:
>
>     push: introduce new push.default mode "simple"
>   =20
>     When calling "git push" without argument, we want to allow Git to =
do
>     something simple to explain and safe. push.default=3Dmatching is u=
nsafe
>     when used to push to shared repositories, and hard to explain to
>     beginners in some contexts. It is debatable whether 'upstream' or
>     'current' is the safest or the easiest to explain, so introduce a =
new
>     mode called 'simple' that is the intersection of them: push to the
>     upstream branch, but only if it has the same name remotely. If not=
, give
>     an error that suggests the right command to push explicitely to
>     'upstream' or 'current'.
>   =20
>     A question is whether to allow pushing when no upstream is configu=
red. An
>     argument in favor of allowing the push is that it makes the new mo=
de work
>     in more cases. On the other hand, refusing to push when no upstrea=
m is
>     configured encourages the user to set the upstream, which will be
>     beneficial on the next pull. Lacking better argument, we chose to =
deny
>     the push, because it will be easier to change in the future if som=
eone
>     shows us wrong.
>   =20
>     Original-patch-by: Jeff King <peff@peff.net>
>     Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> We did reject a "git push" (no other arguments) in an unconfigured
> repository using push.default=3Dsimple.
>
> We must have _broken_ it along the way somewhere over the years.
>
> In the output from
>
>   $ git log --all-match --grep=3Dpush.default --grep=3Dsimple
>
> there are a handful of changes that touch PUSH_DEFAULT_SIMPLE in
> ancient history; ed2b1829 (push: change `simple` to accommodate
> triangular workflows, 2013-06-19), seems to have broken the
> unconfigured case, which 00a6fa07 (push: truly use "simple" as
> default, not "upstream", 2014-11-26) tried to fix it, and then
> another commit e291c75a (remote.c: add branch_get_push, 2015-05-21)
> further tweaked on the triangular (i.e. the remote you are pushing
> to is different from the remote you are fetching from) workflow.
>
> But that is long time ago; I do not think we can _fix_ the breakage
> as that would be a big behaviour change.  If 'simple' works to
> update the branch with the same name as your current branch at the
> remote you cloned from without you having to do anything special,
> such a convinience is something the existing users we acquired over
> the past 10 years must have become very accustomed to already.  We
> cannot break them.

That makes sense, can=E2=80=99t break backwards compatibility.

>     And that is my excuse for stopping to look into the detauls of
>     these commits the above "git log" command found ;-)
>
>> So it seems more accurate to say that push.default.simple will push
>> to the branch with the same name, with the restriction that you might
>> have to set an upstream, because the branch must always have the
>> same name, but whether or not you have to set an upstream depends
>> on the situation.
>
> Now, I am still confused as I was when I wrote the message you
> cited earlier.
>
> Do we ever have a case where, with the "simple" mode, you have to
> set an upstream?

Yes. If you clone a repository, create a new branch, and run  `git push`
(to push to `origin`), Git will complain that you haven=E2=80=99t set an=
 upstream
for that branch, like this:

    $ git push
    fatal: The current branch testtesttesttest has no upstream branch.
    To push the current branch and set the remote as upstream, use
   =20
        git push --set-upstream origin testtesttesttest
    To have this happen automatically for branches without a tracking
    upstream, see 'push.autoSetupRemote' in 'git help config'

I use `push.default=3Dsimple` and this has happened to me a lot in the
past, personally I set `push.autoSetupRemote` to deal with this.

My best guess from my experimentation and from reading some
of the commit messages/code is that the rules for how
`push.default=3Dsimple` works are something like:

1. If the remote you're pushing to is the remote that `git pull`
   would normally pull from if run without any arguments,
   then require the user to set an upstream
   (with the idea that the remote is somehow "special"
   and should be protected from accidental pushes)
2. Otherwise, push to the branch to with the same name
   without requiring an upstream to be set

That said, the exact details of how push.default=3Dsimple works
(ironically) seem complicated enough that I don't think it's worth
documenting in detail at the beginning of the `git push` man page.
I definitely haven't been able to fully understand what they are yet.
Certainly it's true that sometimes you have to set an upstream
and sometimes you don't.

To go back to the original text I suggested:

> 3. The `push.default` configuration. The default is `push.default=3Dsi=
mple`,
>    which will push to a branch with the same name as the current branc=
h.
>    See the CONFIGURATION section below for more on `push.default`.
>=20
> As a safety measure, `git push` may fail if you haven't set an upstream
> for the current branch, depending on what `push.default` is set to.
> See the UPSTREAM BRANCHES section below for more on how to set and
> use upstreams.

The words "may fail" are definitely vague, and I agree it doesn't feel g=
ood
to give a vague explanation like this. But if we think the current
behaviour is "broken" and hard to understand and that we have to keep it=
 for
backwards compatibility reasons, giving a slightly vague explanation
(perhaps with a reference to where someone can read all the gritty
details) might be the best path.

I do like the idea (that I think you mentioned before) of adding a very
simple sentence like this near the beginning explaining what
`git push origin main` does, since it's easy to explain, and someone cou=
ld
easily successfully start using `git push` without knowing any other
information.

> `git push origin main` will push the local `main` branch to the `main`
branch on `origin`.
