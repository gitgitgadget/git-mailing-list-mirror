Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97FC2E0
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338539; cv=none; b=EOzZN3PlwbdSVFOV/iy+1l5BmwSQNjnaXUviaklQ9q2eD2jJvwMt0PKQ97/jpFqPgq7xazSx6cpwRymhlhqDSXUt4Sg2BWfsVxXfPNfTEn+swCA85xV3H1dT+fSJ2XGqQe/fkp+7NXAVEA6InxZaBwjlzRD9EMeiz58xoq1V1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338539; c=relaxed/simple;
	bh=mcFp6yk8+vlo1hdV15CoKLZvYxXkaJhTWcyZgsQzFY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiHASSsMx1qZ0biGZE0AHEifDn/QWry+teWlDERN0PPiViDIaoXFfhc6QMsiek0eAhn2WeopklyvFO1y/FAGemnLdPhdplU+GKTgk4zbKFLbV1PcsV/VoNEY8jhxHWhXLPOEq3q9fqbpUfKC2xBeZqUD+gueo9JtluswXsOGDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OGu3jdNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGFf5ccF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OGu3jdNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGFf5ccF"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC81311401B6;
	Fri,  7 Mar 2025 04:08:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 07 Mar 2025 04:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741338535; x=1741424935; bh=jtzhBXA2MY
	p+yr3EXORnNWH+Lw4payP1RjSq43qecjA=; b=OGu3jdNPaz984EbuM+KjPcInPV
	BVvUBWVZkFZ2omm7tcZ23uwsoICC4iK3iOYgfZZIlTlD+c5j+8T+bIoQXJvMSE/7
	bOVtH1sIhBr4ZYI9fRwmYZCOwdEjyRbSu0+g3FgIPizTqZEgzy8Y5+D752wbRUlU
	ru0AppepXjN5drwsSJ85sxFXCaw3hMBEkLvdcTBP04aqnOoF6SDjUgiB9uYlNfdv
	KiyMiJmOWJCiQoAdfID5CLB3RgXXR+t95qKcyH0cXiGX2/tTtR+87bI9hLvAtUSm
	6qn6tMKCOEBBwy+MqGOB/7Sk+tfFidRfUyTwrB5To3oQN4m6RO9H1+CXbrtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741338535; x=1741424935; bh=jtzhBXA2MYp+yr3EXORnNWH+Lw4payP1RjS
	q43qecjA=; b=HGFf5ccFjvcXqcMIdFLB71pQp4OZwsC6LiKmWkr0GBgkKnFFc8q
	LCmqsOb6SBgAM3TLQ0VU6On8MF2JwKtay+yogMvo4/kQfv9f7z0N0PvPSvJe4eMW
	gbPxKpdK4IyhoUenZqXMxC4jXgN0FjN66nSzhTD2qFe4I17inqkIOlYRSCzp7qC7
	YDMrfBgzzbcnuSZgQ80rItp3QFpiwx7lpJz3IirzZ+lU9oZzP7diQY9Ec4PUZSjv
	abWKgWMZ7yhL9mpaZh9No3L8ON7CIKoBRnwJV9VDfT0OtEQa6k4mbLEaDmZrdbeF
	pk93qBPsaAiSmo8n92JnZ078xjw9iT9PuDw==
X-ME-Sender: <xms:p7fKZ91ffmguO8frcCba7xnA8qlRCY6NOn1u07cV3A6gnGfrdPYb3g>
    <xme:p7fKZ0F7oVUluUVLheAmnbktHX8zKqKavprXmrJHVZEwQRbSxJKKphpRM-YI_NS7E
    8q1xUoyAPD_b_4PIA>
X-ME-Received: <xmr:p7fKZ944yn8SMX0EL9cqxdmLXqxgL-egNxYPpavR_fr7xf1FeLWnt68Ggk1N9ng8QWMBcl3pA8_PVFx2QT6qBiAaBY0Xaa-27EnnuwQkxAJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p7fKZ60WvU00Rf6P4z2ndaQfVhPdg3ztm8NGZ09qxAAU4IdUP7i2OQ>
    <xmx:p7fKZwHaoSWtDTcNzDXWgPo0kj5Yw0gSiIiXzYXLmGAVmyxjycDCaQ>
    <xmx:p7fKZ79UmcfoPxzOovzxNS_XzJ_0sDPTu2tWQU_eS1wAuhO7wZM7Yg>
    <xmx:p7fKZ9lAHvN-HgUP3tWgqv1gCQaqq3ETkrJ2QUMNHPc5SPiSAbQ73g>
    <xmx:p7fKZ1NYDUsK7lpVSPREqJ1x8ZAKhro4xAOVQOcPI71_YuYg40x6N4Ca>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 04:08:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49897c0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 09:08:52 +0000 (UTC)
Date: Fri, 7 Mar 2025 10:08:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
Message-ID: <Z8q3nzhl3DHETZgf@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
 <20250306-b4-pks-objects-without-the-repository-v2-12-f3465327be69@pks.im>
 <xmqqr03ageej.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr03ageej.fsf@gitster.g>

On Thu, Mar 06, 2025 at 11:14:28AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index a4431429b7d..2d2e90bc23a 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -234,7 +234,7 @@ static void show_submodule(struct repository *superproject,
> >  {
> >  	struct repository subrepo;
> >  
> > -	if (repo_submodule_init(&subrepo, superproject, path, null_oid()))
> > +	if (repo_submodule_init(&subrepo, superproject, path, null_oid(the_hash_algo)))
> >  		return;
> >  
> >  	if (repo_read_index(&subrepo) < 0)
> 
> This has an obvious semantic interaction with what is done in
> Usman's series <20250306143629.1267358-7-usmanakinyemi202@gmail.com>
> where builtin/ls-files.c claims that it got rid of its dependence on
> the_repository.
> 
> The resulting ls-files still calls null_oid() here, hence it depends
> on the_hash_algo hence indirectly on the_repository.  When these
> topics are merged together, builtin/ls-files.c again needs to be
> marked that it still needs the_repository variable in order to see
> the_hash_algo.

Ah, thanks for catching this!

> I _think_ the subrepo is not allowed to use different hash from the
> superproject, so we can pass superproject->hash_algo instead in this
> series to make it easier on the other topic?

That's actually a very good question -- I have no idea. My gut says that
it probably won't work, but on a conceptual level I think it would be
nice if it did. Reality lies somewhere between. The following commands
work alright:

    $ git init --object-format=sha256 repo
    $ cd repo
    $ git commit --allow-empty --message initial
    $ git submodule add https://github.com/git/git.git
    $ git -C git rev-parse --show-object-info HEAD
    sha1
    a36e024e989f4d35f35987a60e3af8022cac3420

We end up with a SHA1 submodule in a SHA256 repository. So far so good.
How does it look like?

    $ git diff --cached
    diff --git a/.gitmodules b/.gitmodules
    new file mode 100644
    index 0000000..3594794
    --- /dev/null
    +++ b/.gitmodules
    @@ -0,0 +1,3 @@
    +[submodule "git"]
    +	path = git
    +	url = https://github.com/git/git.git
    diff --git a/git b/git
    new file mode 160000
    index 0000000..a36e024
    --- /dev/null
    +++ b/git
    @@ -0,0 +1 @@
    +Subproject commit a36e024e989f4d35f35987a60e3af8022cac3420000000000000000000000000

Well, now it starts to become weird, as the commit hash is obviously
wrong. Can we update the submodule?

    $ git -C git switch next
    $ git diff
    diff --git a/git b/git
    index a36e024..4cd3354 160000
    --- a/git
    +++ b/git
    @@ -1 +1 @@
    -Subproject commit a36e024e989f4d35f35987a60e3af8022cac3420000000000000000000000000
    +Subproject commit 4cd33545ba4fa82324b454aa5bf2748b40a572fb

Well, that diff at least looks somewhat better than expected? Let's
commit it.

    $ git commit -m update
    $ git diff HEAD~
    diff --git a/git b/git
    index a36e024..4cd3354 160000
    --- a/git
    +++ b/git
    @@ -1 +1 @@
    -Subproject commit a36e024e989f4d35f35987a60e3af8022cac3420000000000000000000000000
    +Subproject commit 4cd33545ba4fa82324b454aa5bf2748b40a572fb000000000000000000000000

Oh, well... so, what happens if we ask git-log(1) to recurse into the
submodule?

    $ git log --submodule=diff --patch
    Segmentation fault (core dumped)

Yeah, no, that's not really working.

So in theory, I don't really think there is anything that keeps us from
mixing object formats, and I even think that this is a necessary feature
to have once people start to migrate their repositories to SHA256. There
are people out there who use submodules, and it may not be feasible for
them to wait until all of their submodules have been converted to SHA256
to migrate their own repositories.

From my perspective, we should thus treat it as a bug that the above
does not work.

> What do you think?

Anyway, that was a bit of a tangent to your initial question: which hash
should we be passing in the first place? As it turns out, we should be
passing the superproject's null OID indeed. The object ID we pass to
`repo_submodule_init()` does not describe any object in the submodule
itself, but rather indicates which tree-ish the submodule information
should be parsed from in the superproject. As such, it refers to an
object in the superproject itself and should thus use its object hash.

I'll include such a change in my patch series to resolve the semantic
conflict.

> Perhaps we should have hidden null_oid() as requiring the_repository
> just like the_hash_algo is guarded like so
> 
>         #ifdef USE_THE_REPOSITORY_VARIABLE
>         # include "repository.h"
>         # define the_hash_algo the_repository->hash_algo
>         #endif
> 
> in <hash.h>.
> 
> In other words, I wish we had the following patch already applied,
> before Usman started working on the other topic.

True. `USE_THE_REPOSITORY_VARIABLE` has always been best effort, and it
was clear from the beginning that it won't catch all functions that
implicitly depend on `the_repository`. The good news is that we uncover
and convert more and more of those implicit dependencies, so as time
progresses it becomes more accurate.

> But with this topic getting solidified, it would become a moot point
> to do that in the longer term.  This series removes null_oid() that
> had the implicit dependency anyway.

Indeed.

Patrick
