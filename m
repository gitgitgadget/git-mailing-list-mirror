Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748A143C5F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353993; cv=none; b=lN2BR6WopJtNk5lD3NfURUdkanNOYFZOjg8jgk1PJowbA64P3JVM4MPwu7rMxZNSphQ5AKyqqKxoWw4KTFs4+p06RKkVZJnjPtULF7QfvXxKz/gC+4mhdDK4LcE2r/fpC7eYDcgId9iTpqwPoV73LQnsQYBBZvZ9dRiZ8whqtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353993; c=relaxed/simple;
	bh=luvMbpQ069cWns+G4HDwukyhJyd8wjZor/K0zxKi8tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGcHG/FRwRnp5+J4Y50NlADaTUyC7Krk5MUn6Zw3PtfabjxeNR9W+X/WtXZ7Ru3l6LlktJeDFCGTHTSwWmTaO+RRWdiOJqQBtilww1fD5gNJIt/ixcrmfkPk89U9VRiGUnXTeI6on74m72lP2jgfL9M58Cn5LwS7wfFqIX7qCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VlLa9Gwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ubm0KVXM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VlLa9Gwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ubm0KVXM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E81213800E7;
	Mon, 25 Mar 2024 04:06:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 04:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711353989; x=1711440389; bh=lgTJPh4Opv
	A2xRD0jRlPR4RMzLtWmpuSS3tf78rcF4Y=; b=VlLa9Gwckn0+smrCywDeipMkmC
	Gr1AVHzQMZQt1iriXjcAIXj6RSIC3RBO+og8GlHS6csecX5OAHd+3F8K6eZwo11U
	D6eUGw4RjfSR2ZWEPE2nOD4xuVLKhRVCx0C296PVPr4L25926u/tI9OM6j6jGW0e
	j2YMEGZD2zrdzD8i5VDx+rJxu8szLx+XrdApPxJ0i+A+43nqNwUwv3epjaBCC32a
	k/q6nOA66sbrmvZ5mO/0CyM/HwEoUbMm20AGIw3ZckLekzbwZJADsYt6V970zBT7
	OGPujbOJK7B8gFp+PqGgblBo0Ejl1VeCHqwmp6KggwtHHGc5PM2fiZVU6Lxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711353989; x=1711440389; bh=lgTJPh4OpvA2xRD0jRlPR4RMzLtW
	mpuSS3tf78rcF4Y=; b=Ubm0KVXMGQTzt+6s0Iq7SHE7SOx6Dm5zm97/YlRGmVb9
	lIltC752kD4YrrYGXJFAguoYjLuSAVPX8let3R1Rv7YawRw7FS20911D8/E5N400
	D8WXy51UVAiBEfkm7SPvTEBjARLeVKlJQIAVg0jJ5iiY/t8sHaORyupAGqUbFOj0
	OTQYCelPnrI0yIarexL9umyAsD2hkEY/epU0KwFGI84ryll0G4dWaIV3EgaoJCZY
	Y4T6W+f0rvE3xeW9ob+qiMgT/zn96gap9wPGKvaFGKUpL+Li4Rs23c7v9ECLU1nq
	TXPeNfnQ25NaOGBHjsA1U6Z53FojZfgd8keLzmUUNQ==
X-ME-Sender: <xms:hTABZpdzhrxpapnhM8nL5ABAUuSl0IslGx19VfoY-8I_v7DkbGV0Bg>
    <xme:hTABZnP9QtpQ2VJgN1qXJTc45v00TTcEtmS7cDJHO0KQtYZmpDCWRsuC7zMuy3ynE
    Ix_EKv7Ct-iuFqTdg>
X-ME-Received: <xmr:hTABZiiUn3UL3mX8jT5UF54XdSnBh6Ben7qRWIVef1jS_Su3KugV_YUEwAImfvQMP3DqoIDV9D1yBgveucYdDjf6CbvZANEQ9qvnx5MxH9qqnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguth
    cuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefgleeufeehheejjeehkeei
    tddvieeludejffelgfefhfffledtuedttdetudefueenucffohhmrghinhepghhoohhglh
    gvrdgtohhmpdhgihhthhhusgdrtghomhdplhhuohhlihgsrhgrrhihrdgtohhmpdhkvghr
    nhgvlhdrohhrghdplhholhhirdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hTABZi9x0f043XZaBEFXeDEO82tZ6oInnn4MT18JlMlTqY2vVAEqOg>
    <xmx:hTABZlsvdZPGiQTzpqDjAu0foua-1YAPTokXKnIaSC5QcOmD4jQNsg>
    <xmx:hTABZhGIOyThobzye4ftGEGc5km2zHR1v6IBO51nrjscoVK5ZuPBRw>
    <xmx:hTABZsPG4YmIPRiN7uvFvk313ZBpP8mkoC_J36BjkAPd7oCCeQhMKw>
    <xmx:hTABZjVL7MSP7Qv6587Dgw499aHE5xkXQd2GOTZQbUUDeGLKZJWRcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 04:06:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 300ab5bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 08:06:16 +0000 (UTC)
Date: Mon, 25 Mar 2024 09:06:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PROPOSAL v1] Implement consistency check for refs
Message-ID: <ZgEwgNl3fug3qGG5@tanuki>
References: <Zf6o8k-OLuVslQsa@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qDMcajagtIfeMV6B"
Content-Disposition: inline
In-Reply-To: <Zf6o8k-OLuVslQsa@ArchLinux>


--qDMcajagtIfeMV6B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 06:03:30PM +0800, shejialuo wrote:
> Hi everyone,
>=20
> This is my proposal for the project "Implement consistency checks for
> refs". The web version can be viewed at
> https://docs.google.com/document/d/1pWnnyykGmJIN-wyosZ3PtueFfs_BRdvJq-cwr=
oRorBI/
>=20
> ----------
>=20
> # Implement consistency check for refs
>=20
> ## Personal Information
>=20
> + Name: Jialuo She
> + Email: shejialuo@gmail.com
> + Mobile no.: (+86) 13019582712
> + Education: Xidian University, Shanxi, China
> + Year: Final Year
> + Degree: Master in Software Engineer
> + GitHub: https://github.com/shejialuo
> + Blog: https://luolibrary.com/
>=20
> ## About Me
>=20
> I am someone who loves coding, and my favorite quote is from "The
> Shawshank Redemption": "Get busy living, or get busy dying". In my final
> year as a student, I hope to continue doing valuable things.
>=20
> I have some basic open-source experience, such as improving
> documentation for Angular [1]-[2], adding some features to the
> community [3]. I also maintain some open-source projects, mainly course
> codes, book answers, and some practical in-action tutorials to help
> others [4]. Additionaly, I write blogs to document and help others with
> some of the public courses I=E2=80=99ve taken [5]. I have written a toy g=
it by
> myself due to my interest [6].
>=20
> I am currently interning at NVIDIA, where I started in the software
> department working on CUDA Test Development. My current position is in
> the hardware department as a Tegra System Architect, and I will become
> a full-time employee this July.

Given that this overlaps with GSoC, how do you expect to allocate time
for both a full-time job and participating in the GSoC at the same time?

> I hope to use this opportunity to continue participating in the git
> community and contribute to open source in the future.
>=20
> ## Overview and Background
>=20
> As [7] shows, when the "packed-refs" file gets corrupted, the
> git-fsck(1) command cannot detect this situation where the "packed-refs"
> file contains corrupted binary zeros.
>=20
> The current mechanism for git-fsck(1) command can be classified into
> two parts. The first part is to check the object database. For every
> loose file which is under `$GIT_DIR/objects`, it will use the internal
> method `for_each_loose_file_in_objdir` to check whether the result of the
> content-hash is consistent. The second part is to check the "packed-refs"
> file, it will open and parse it to iterate the refs which provides an
> implicit consistency check. However, as [8] shows, when there are some
> null bytes, maybe the read file operation will just simply ignore
> those null bytes.

git-fsck(1) does a lot more nowadays: it also checks packfiles, commit
graphs, multi-pack indices, reverse indices and bitmaps.

> It turns out that the current git-fsck(1) command mainly focuses on
> checking the consistency of the object database. It lacks the
> functionality to check the consistency ref database explicitly. The
> upcoming retable backend will soon be released which is a binary
> format which would be hard for users to check the corruption.

This part is true though. Most of the above data structures are closely
tied to the objects that exist in the repository, while we have nothing
that explicitly checks the refdb.

> And this project aims at implementing consistency check for refs
> suggested by [8] and [9]. And there are two backends for git: one
> is file and another is retable. Initially these checks may only apply
> to the "file" backend and then apply to the "retable" backend.
>=20
> The expected project difficulty is medium and the expected project
> size would be 175 hours or 350 hours depending on whether to implement
> consistency check for "retable" backend.
>=20
>=20
> ## Pre-GSoC
>=20
> I first got in touch with Git codebase in February, 2024. I have only
> submitted a minor patch as the microproject to get familiar with the
> workflow of the Git community.
>=20
>=20
> ### MicroProject
>=20
> t9117: prefer test_path_* helper functions
>   Mailing list thread:
>   https://lore.kernel.org/git/20240304095436.56399-2-shejialuo@gmail.com/
>   Status: merged into master
>   Description:
>   test -(e|d) does not provide a nice error message when we hit test
>   failures, so use test_path_exists, test_path_is_dir instead.
>=20
> ### Discussion
>=20
> I have discussed with the community for some implementation ideas in
> [10] which is the fundamental of the "Proposed Project" part.
>=20
> ### Learning the Source Code
>=20
> During the time from completing the microproject until now, I have
> primarily read the source code related to `fsck.c` and ref internals.
> I have summarized the implementation diagram of the ref mechanism as
> shown in [11].
>=20
> ### Previous Work
>=20
> This project might be a new idea here. It is proposed mainly due to
> the new-released retable backend [12].
>=20
> ## Proposed Project
>=20
> As [10] shows, Patrick wrote:
>=20
> > Some ideas from the top of my head:
> >
> >  - generic
> >    - Ensure that all ref names are conformant.
> >    - Ensure that there are no directory/file conflicts for the ref
> >      names.
> >  - files
> >    - Ensure that "packed-refs" is well-formatted.
> >    - Ensure that refs in "packed-refs" are ordered lexicographically.
> >    - Check for corrupted loose refs in "refs/".
> >  - reftable
> >    - Ensure that there are no garbage files in "reftable/".
> >    - Ensure that "tables.list" is well-formatted.
> >    - Ensure that each table is well-formatted.
> >    - Ensure that refs in each table are ordered correctly.
>=20
> ### Generic
>=20
> It's easy to ensure that all ref names are conformant. The
> git-check-ref-format(1) provides the functionality to check whether
> the name of a ref is ok. It eventually calls the `check_refname_component`
> in the `ref.c` file. And I have understood the rules of the ref name
> as the following:
>=20
> - Hierarchial Grouping:
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `refs/heads/.hidden-branch` (begins with a dot)
>     - Invalid: `refs/heads/feature.lock` (ends with `.lock`)
> - Contain at Least One Slash
>     - Valid: `refs/heads/main`
>     - Invalid: `main` (no slash)
> - No Consecutive Dots
>     - Valid: `refs/heads/feature/new.feature`
>     - Invalid: `refs/heads/feature..new-feature` (contains `..`)
> - No ASCII Control Characters, Space, Tilde, Caret, or Colon
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `refs/heads/feature^new` (contains `^`)
>     - Invalid: `refs/heads/feature: new` (contains `:` and space)
> - No Question-Mark, Asterisk, or Open Bracket
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `refs/heads/feature/new?feature`
>     - Invalid: `refs/heads/feature/*` (contains `*`)
> - No Leading or Trailing Slash, No Multiple Consecutive Slashes
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `/refs/heads/feature/new-feature` (begins with `/`)
>     - Invalid: `refs/heads//new-feature` (contains `//`)
> - No Ending with a Dot
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `refs/heads/feature.` (ends with `.`)
> - No Sequence `@{`
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `refs/heads/feature@{time}` (contains `@{`).
> - Not the Single Character `@`
>     - Valid: `refs/heads/feature/@new-feature`
>     - Invalid: `@` (single character `@`)
> - No Backslash
>     - Valid: `refs/heads/feature/new-feature`
>     - Invalid: `refs/heads/feature\new-feature`
>=20
> So for ref names, we could reuse this function for every backend.
>=20
> ### The Interface For Two Backends
>=20
> From the discussion in [10], Patrick wrote:
>=20
> > For what it's worth, not all of the checks need to be implemented as
> > part of GSoC. At a minimum, it should result in the infra to allow for
> > backend-specific checks and a couple of checks for at least one of the
> > backends.
>=20
> I think the most important thing for this project is to setup the
> infrastructure with good flexibility which allows backend-specific check
> and programmer can add checks easily. This is the reason why I dive into
> ref internal, I want to understand how Git handles these two interfaces.
> And I want to reuse this idea to add ref consistency checks.
>=20
> As picture [11] shows, the `ref_store` is the core abstraction provided
> by the `ref_internal.h`, it is the base class which contains the `be`
> pointer which provides backend-specific functions whose interfaces are
> defined in the `ref_storage_be`.
>=20
> In my view, I think we could reuse this polymorphism. We could define
> some common interfaces or only one interface in the `ref_storage_be`.
> For every backend, it needs to provide its own function pointer. And
> we could reuse `ref_store` structure to do this.
>=20
> At last, we can use this polymorphism in `fsck.c` to elegantly setup
> the infrastructure. And it has the following advantages:
>=20
> - Reuse the current polymorphism provided by `ref_store`.
> - We can add checks easily for future.

Sounds sensible.

> ### The Concrete Checks
>=20
> At current, this project proposal cannot determine the concrete checks.
> It should be discussed to make the checks concrete and clear.
>=20
> ### Timeline
>=20
> Pre-GSoC
> (Until May 1)
> - Continue to read the source code especially for retable backend.
>   Understand the retable format to determine the concrete checks
>   with mentors.
>=20
> Community Bonding
> (May 1 - May 26)
> - Talk with mentors to determine the detailed infrastructure should be
>   implemented to provide flexibility for programmers. Also, determine
>   the checks for the generic part and continue understanding the retable
>   format and code.
>=20
> Phase I
> (May 27 - July 7)
> - Implement the infrastructure to support both file-backend and
>   retable-backend. Write tests to make sure the correctness of the
>   infrastructure. And then add the some generic ref checks both for
>   file-backend and retable-backend (such as use existing
>   `check_refname_component`) and write tests.
>=20
> Phase II
> (July 7 - Aug 19)
> - Talk with mentors to determine the ref checks for file-backend and
>   continue to add ref checks for file-backend. Also add write unit tests.
>=20
> Final Week
> (Aug 19 - Aug 26)
> - Fix any bugs.
> - Write the final report.
>=20
> However, in my perspective, I hope this project could last 22 weeks and
> I could add ref checks for retable-backend. But due to uncertainly,
> I omit the timeline here.

That's fine. Adding consistency checks to the "reftable" backend can
easily be defined as a stretch goal or even not at all.

> ### Availability
>=20
> Currently, I am engaged in a remote internship, which allows me to
> work 2-3 hours each evening from Monday to Friday. On weekends, I
> am able to dedicate 8 hours each day to work. As I am in my final year
> and do not have exams, I can commit to 20-30 hours of work per week.
> Even after becoming a full-time employee in July, my schedule will remain
> similar to my internship period. Additionally, I am able to continue
> working until November (22 Week Project).

Hum, okay. This does sound extremely taxing and I do wonder whether this
is going to be a sustainable mode of working for multiple months in a
row.

Thanks for your application!

Patrick

> ## Post-GSoC
>=20
> After completing the GSoC, I plan to continue working on the code related
> to retable and read other modules in Git. This was my original intention
> for participating in GSoC, to integrate into the community through this
> opportunity and, if possible, to become a mentor in the future, igniting
> the flame in others' hearts. Most importantly, to "Get busy living."
>=20
> ## Closing Remarks
>=20
> Thanks for every review for reviewing this proposal. It=E2=80=99s my hono=
r to
> work with the community.
>=20
> ## References
>=20
> [1] https://github.com/angular/angular/pull/44674
> [2] https://github.com/angular/angular/pull/44628
> [3] https://github.com/ehForwarderBot/efb-qq-plugin-go-cqhttp/pull/68
> [4] https://github.com/shejialuo/database-systems-complete-book-solutions
> [5] https://luolibrary.com/categories/CS144/
> [6] https://github.com/shejialuo/ugit-cpp
> [7] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10=
=2Ede/
> [8] https://lore.kernel.org/git/20240120010055.GC117170@coredump.intra.pe=
ff.net/
> [9] https://lore.kernel.org/git/ZakIPEytlxHGCB9Y@tanuki/
> [10] https://lore.kernel.org/git/Ze2E_xgfwTUzsQ92@ArchLinux/
> [11] https://s2.loli.net/2024/03/23/3YGoBgZzHNtOfVw.png
> [12] https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/

--qDMcajagtIfeMV6B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBMH8ACgkQVbJhu7ck
PpQ6LRAAir3KfZjYPPnjZV6CF/f13NkhanD1OswGjfI3vi8eZtb9bktWpzees15X
OT2wJdtKtQym5o0hBYMYDiYka4lwntXciwlWEkwQRpiJKUTTZOg3dUMHSh+Vy1Tn
zBh9VUwZPF2MhUfsGfCZcRtwt5qAHot7rCF9A45SYbL1aGFo4E/JP+/In2qYnNqE
KcuRWeFby8yHPXrquPh+kmCM7vMSkCQ0+7ZPqtlu3dlc92dZcZ1NI08yH8Xo+IcB
viofOl4gZJciU7R13qP7yJ4z/gwcDOjGNeUAYjNoDDJojGDJ0RERaUj9QW4pBnz4
gjTA5mLlTG1nMDhsdIDZP+S+NzwhtDOHZSJt6DiTbrHjfE+o86+bSp8ILgrt8P3b
2d3apcLHBl1VzMqwJpfy2xJxFzuxOcoGEqnRBwLBZUsq2tKaFFquwvooGlo+S3ha
JVMVOw9mfZbdrF4HtJE+Zuzzd4QJ3RAGDccf7qvTBy9x08Jgexntqzb4bKnMXmVh
mSNm4up1uh5a4o6tkISBZHF9Olxx8+BqE2GpMuaR+1/FWixnkIHLvNDg1DnFcX0p
cat9iQwomLjQntaabvDfC957PCxv7aSLaXh5/PQwKTho4HJU1xoQMOfh1rCxEkBk
kT9Olqx+PeRGgrjiz+iJHzFBFJ78sb+jU9RTKJ2iGZKPYsZcIIo=
=wOfp
-----END PGP SIGNATURE-----

--qDMcajagtIfeMV6B--
