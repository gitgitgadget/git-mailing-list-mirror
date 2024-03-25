Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20238178CD3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355272; cv=none; b=NQW5L3mdpp73MNgq9w7zSYel6UOC4dtCpQj28fEdjAGOQu9q9FvPx02YipcBv3+zRre82krvP3HKOQjQMOQCaHjU2cOCQR5H6S/OavxjWGWLCfgwEdgfoxCaNNgdvVWdIT6zhFmE9V25DGe/qcqIbkFD74D151vg3A1JMkiFuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355272; c=relaxed/simple;
	bh=mzsD+LwsDSW5v/z35h/E4RMhsUs4MycXEAIzPzKIHfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft0TpDvlyhtib4uENtvma8WLGUucWkhbyckn6LUnSHWPvY8oq9CB9CtnZVxSjFZng5/rL75bXaUev+k1zvEc7cFH/9F374Oz5XaYGY37PNZU7GITYs4Ef/bmHv8whfzFxyFbqmkfM9CdpSnD3v62Ep7ESdrZV4qfplojJtYbv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BSbAGRUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jvq5U50F; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BSbAGRUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jvq5U50F"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2EB2711400B3;
	Mon, 25 Mar 2024 04:27:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 04:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711355269; x=1711441669; bh=0S/XJ1TRM2
	QhokxQurDsdw6pS0sc4KD8BoTIb6/O54k=; b=BSbAGRUE5EzrQ97vpoxti/4O7i
	B2t9qpPRA5qqF3IcxUpB9aVIDMMj3MFrA8qQ/zjcYH7NJ5BMhD9Fglac9CVGpH+p
	ij67L2oktKknc8IBfDMr2CO1bfyO8mKChs9vVYHEmO9yKiLBIyAQKI1JT0l2wzzZ
	v+5K5Np0/NSu52qZQNHSYMkL6koU9V32Y2scPLung0mBO8jx1XgvVuGD5RLjeh7n
	8LXFrgsA+d0JGWk9ZdbZY9tM3a8oPJS3ANPgRVOumE0GPJV4k/pjIS6i2HjeiQBL
	vyL0xm0whWJNlz3u003sZwkUXt+p+tmu/9qlra0MmfvQAG3HMsHfMbIMQwPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711355269; x=1711441669; bh=0S/XJ1TRM2QhokxQurDsdw6pS0sc
	4KD8BoTIb6/O54k=; b=Jvq5U50F3rvo42fsgh/fTuGSE+ILJvcprw7ghSZTQ2Je
	gdQ1CzOiurIwyfAAKwWlRlXXH9l/q8RH4QjNngZKJlft39swMCtycZYJ57xP05/8
	Ryt3fbHczRbxD9TwFCsgNpx3PLoXGJY+bp5rC444QUO09rr7S3R3q//vJa6iVa2M
	pBvHo9BWN8mpBi6uGWmdCdSSBQSZEKKD98E1SAUcRmkl2TZZab48Vh/BJYhnxE0Z
	JRojHiY61jlPee/yIwqUex2Knz+S/OGfpBot9gWKDcv0P74NFNc3HkTfVhX8Xrlg
	crF2V/8FjGuyg0hVOIrlEyWf9COkZFDm6B+lyDMo3w==
X-ME-Sender: <xms:hDUBZjfMqhzT1liZDbDwIP4qgGgQpoaHImc3DYSl4PvrDgndfNsSQg>
    <xme:hDUBZpN53OSwDvUX1EXcaDRz8_l72_M58jMiYFnL5QLcVQKCIIvfanMXgXw2drMD3
    ww1WqrPp4fqTVbfWg>
X-ME-Received: <xmr:hDUBZsgt_gvMIAye4QsHpARJSDAQ9kOv4_6l53nnmUsbpAcQUJQvCp9emATARgDWSzJEWxdFIJAOh--ECZ4HrSBWYn_xRT7TpQTBb9_EVu3zCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeufeeludehheduheeiieelkeetfeekveeuleegtdegfeefieevudehvddttdeg
    heenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhm
X-ME-Proxy: <xmx:hTUBZk-anmGv0tDlNS1d3_7YtgKQQDqsCDLfIiydKy1S6irAru4Unw>
    <xmx:hTUBZvtxQg7C7Ghd7jxnT3hvdmHCk6cwTQlXrSlgeezQZw0fSCNDbQ>
    <xmx:hTUBZjGm_AIqyoz0_u60kP_ryT_WUN_VpgllJU9xodMNfB9nJsKjSA>
    <xmx:hTUBZmNarGjH5VrB-UzChrmI3FQCmmfDxGDEhornwJ05-RK_a_vhig>
    <xmx:hTUBZjitT3GpnjaujUFAbvEsZctLwqdQY1p_gNt-BRRImksrk9xjsQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 04:27:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c2d8bf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 08:27:36 +0000 (UTC)
Date: Mon, 25 Mar 2024 09:27:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: eugenio gigante <giganteeugenio2@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	kaartic.sivaraam@gmail.com
Subject: Re: [RFC][GSoC] Proposal: Refactor git-bisect(1)
Message-ID: <ZgE1fxIFFQIdtIyN@tanuki>
References: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S8DRoSRW+P8LEQV/"
Content-Disposition: inline
In-Reply-To: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>


--S8DRoSRW+P8LEQV/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:26:48AM +0100, eugenio gigante wrote:
> Hi all, this is my proposal for the GSoC 2024.
>=20
> -------------------------------------------------------------------------=
---------------------------
>=20
> Refactor git-bisect(1) to make its state self-contained
>=20
> Contacts
> -------------------
>=20
> Full Name: Eugenio Gigante
> Email: giganteeugenio2@gmail.com
> Github: www.github.com/EuGig
>=20
>=20
> Synopsis
> ------------
>=20
> The git-bisect(1) tool is employed to pinpoint the exact commit within a
> series of commits that introduced a particular bug. When initiating a
> bisection session,
> it generates a collection of state files within the Git repository,
> documenting diverse
> parameters such as ".git/BISECT_START". Instead of having different
> files scattered
> in the =E2=80=98.git=E2=80=99 directory, it has been suggested by Patrick=
 to introduce
> a new =E2=80=98.git/bisect-state=E2=80=99
> directory which will contain the state files
> (https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/).
> The aim of the project is to implement this new layout for storing
> git-bisect(1) related files.
> The project will also handle backward compatibility issues that may
> arise with such a change.
> This is one of the project ideas suggested by the community of Git.
> The difficulty for the project should be medium and it should take
> somewhat between 175 to 350 hours.
>=20
>=20
> Contributions
> -------------------
>=20
> add.c: use unsigned integral type for collection of bits
> (https://lore.kernel.org/git/20240224112638.72257-2-giganteeugenio2@gmail=
=2Ecom/)
>=20
>=20
> Description:
>=20
> Since the MSB of signed integral type=E2=80=99 is special, =E2=80=98flags=
=E2=80=99 fields should be
> declared of type =E2=80=98unsigned integral=E2=80=99. builtin/add.c:refre=
sh() declares
> 'flags' as signed,
> and uses it  to call refresh_index() that expects an unsigned value.
> Fix this by modifying its type =E2=80=98unsigned int=E2=80=99.
>=20
> Although the code was easy, this patch gave me the opportunity to get
> familiar with
> the process of submitting patches. The lesson learned was not only
> about understanding
> git commands for formatting and sending patches to the mailing list;
> but, most importantly,
> was about how to interact with the community; i. e., how to interact
> with reviewers,
> to ask them questions and give them answers. That is why I chose a
> micro-project idea
> that explicitly required interaction with the community, before
> writing any code.
>=20
> Status:
>=20
> Merged to master on: Thu Mar 7 15:59:41 2024
> commit f46a3f143eba661b9eb2b1e741447d6709eb6e90
>=20
>=20
> Deliverables
> ------------------
>=20
> As soon as the acceptance to the program is communicated, I will start wr=
iting a
> sort of Backlog of required changes which has to be shared with mentors.
> This has the goal of better tracking progress and possible issues.
> Already individuated changes and possible strategies are considered in
> what follows:
>=20
> 1. First, one needs to inspect the possible impacts such a change could h=
ave
> regarding Backward compatibility. There will be two possible situations i=
n which
> backward compatibility breaks:
>=20
> a. (Noted by Junio (https://lore.kernel.org/git/xmqqwms0ndvu.fsf@gitster.=
g/)).
> People switch versions in the middle of a git-bisect session. Even
> though I think this
> case would not be that common, one should take this into consideration
> nonetheless.
>=20
> b. (Noted by Patrick (https://lore.kernel.org/git/ZbDPqOnyLw4yhu--@tanuki=
/)).
> Different implementations of Git could suffer backward
> incompatibilities like Libgit2,
> JGit and Dulwich. In this case, I will investigate if (and how) these
> tools would suffer the change.
>=20
> In this phase it is important to find an agreement with the community
> if the refactoring
> would be worth it, and in case it is, to find the best solution to
> guarantee backward compatibility.
> The simplest way seems to be to teach Git how to recognise the old
> style layout and move
> the files by following the new one. This can be achieved by checking
> the presence of state files
> inside =E2=80=98.git=E2=80=99, just after the starting of a bisect sessio=
n and by
> moving them accordingly.

To further stress the point: the biggest challenge of this project is
indeed to find an agreement with the community whether this refactoring
will ultimately be worth it. This will require some good arguing on your
part why exactly you think this is fine and how exactly this will
interact with other implementations of Git like libgit2/JGit/Dulwich. It
may very well happen that ultimately the community decides that this
whole endeavour is not worth it.

> 2. After a strategy for backward compatibility is decided, I will
> refactor the directory
> where all the file states are created. This is done by changing the
> function factory
> =E2=80=98GIT_PATH_FUNC=E2=80=99 in =E2=80=98builtin/bisect.c=E2=80=98=E2=
=80=99. The following is an example
> for =E2=80=98BISECT_START=E2=80=99:
>=20
> - #static GIT_PATH_FUNC(git_path_bisect_start, =E2=80=9CBISECT_START=E2=
=80=9D)
> + #static GIT_PATH_FUNC(git_path_bisect_start, =E2=80=9Cbisect-state/star=
t=E2=80=9D)
>=20
> Similarly for =E2=80=98bisect-state/terms=E2=80=99, etc. This kind of cha=
nges should
> also be done in =E2=80=98bisect.c=E2=80=99
> (which contains the binary searching algorithm git-bisect(1) uses).
> Then, as noted by
> Junio (https://lore.kernel.org/git/xmqqwms0ndvu.fsf@gitster.g/) this
> path should be
> marked per-worktree, since each worktree can have its own bisect sessions.
> Probably, also files related to git-worktree use the directory of
> state files somehow,
> so one should also check them.
>=20
> 3. Write some tests for the new layout. The plan is to use the new
> unit testing framework. First tests that come to mind are:
>=20
> a. Check that the state files are inside =E2=80=98.git/bisect-state=E2=80=
=99.
> b. Check if the path pertains to GIT_DIR and not COMMON_DIR.
> c. Check that after adding a worktree which was being bisected does
> not somehow spoil the session and the state files.
>=20
> This can be taken as an example of test file for git-bisect(1) using
> the new framework:
>=20
> #include test-lib.h
> #include bisect.h
>=20
> // Write functions like:
> // t_bisect_dir_init()
> // t_worktree_init()
> // t_test_layout()
> // and include them in cmd_main
>=20
> int cmd_main(int argc, const char **argv)
> {
> if (!TEST(t_bisect_dir_init(), =E2=80=9Cbisect directory initialized=E2=
=80=9D))
> test_skip_all(=E2=80=9CBisect initialization failed=E2=80=9D);
> if (!TEST(t_worktree_init(), =E2=80=9Cworktree initialized=E2=80=9D))
> test_skip_all(=E2=80=9CWorktree initialization failed=E2=80=9D);
> TEST(t_layout(), =E2=80=9Cnew laypout=E2=80=9D);
>=20
> return test_done();
> }

I don't think that the unit testing framework would be a good fit. The
intent of that new framework is mostly to test low-level functionality
that otherwise cannot be easily tested. But here it should actually be
quite easy to test things as part of our regular integration-style tests
in "t/t*.sh", so it would be preferable to write those instead.

> 4. Implement strategy for backward compatibility and related tests such a=
s:
>=20
> a. Check if Git correctly recognizes the old layout and in case
> correctly moves the files according to the new one.
>=20
>=20
> Timeline
> ------------
>=20
> May 1 - 26:
> Community bounding Period.
> Read Documentation.
> Write Backlog.
>=20
>=20
> May 27 - July 8:
> Implement a new layout for state files.
> Write tests.
>=20
> July 12 - August 19:
> Assess and implement backward compatibility.
>=20
> August 19 - Deadline :
> Write documentation for the project.
>=20
> I can dedicate 3 hours a day during weekdays, and 5 hours during the week=
ends.
>=20
>=20
> Benefits to the Community
> -------------------------------------
>=20
> How state files dedicated for git-bisect(1) are stored is not ideal.
> Having a single directory dedicated to these files, instead of having dif=
ferent
> files spread in the Git directory during the bisecting session, is
> better and facilitates
> even the removal of them after bisecting.  Moreover, as noted by
> Phillip (https://lore.kernel.org/git/9c800cd5-8d20-4df7-8834-f74ab000695e=
@gmail.com/#t),
> by aligning the organization of these files to that used for am,
> rebase, cherry-pick, etc.,
> the repo will have a more coherent and uniform layout.
> This will enhance readability and maintainability in general.
>=20
> Karthik [1] also expressed  the need of such refactoring as a prerequisite
> to introduce new syntax checks for pseudoref in =E2=80=98is_pseudoref_syn=
tax()=E2=80=99.
>=20
>=20
> [1] See Karthik=E2=80=99s commit: 1eba2240f8ba9f05a47d488bb62041c42c5d4b9c

Nicely summarized.

>=20
> Biographical information
> ----------------------------------
>=20
> I=E2=80=99m a former student of Logic and Philosophy who turned to coding
> after graduating.
> I have been working as a Developer for NTT Data Italia for a year.
> I hold a full-time job, but I've seen that it doesn't conflict with
> the rules of GSoC
> since I'm an open source beginner. I am fully capable of managing my
> workload independently,
> including my working hours. I know it is not ideal, but I can
> definitely work around
> my schedule and dedicate time to the project.
>=20
> Before, I have contributed small patches to two open source projects:
> - Pydata/Sparse: https://github.com/pydata/sparse/pull/611
> - Pennylane: https://github.com/PennyLaneAI/pennylane/pull/3959

Thanks for your proposal. Please make sure you submit it as a PDF file
to the GSoC website soonish, unless you already did that.

Patrick

--S8DRoSRW+P8LEQV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBNX4ACgkQVbJhu7ck
PpR9qQ/9Eixcwwt41xTrsQNtfeJobl9bonmtnowmdSXT5My76NvyO/Js4l4lxub0
57sWi9jNQO0AgNOGEDVOVA3Kwq8Zc7w+ghRSEazhvthJwjAm9kP4cFVthSFfThbG
e4OhEf4jLVjGGetzySzszII2UEDbWRo6xJE3oKcyURWlwMPaRaH3C9el0QOCwVbW
yZHMJ9/Oy/m26xuI+RsfV9o85YyBPQ1rkN6uuysuJXG5fp0P/O2DxrkhnBpbk9wk
uaACpMgQvg3k81PMj5JbVyUwaUGpXjjna2iv95om/XEzZ9oFIsxQQrUINVQ/O/Zr
AMAQGP4V3gef6H5IqwoaAvqDLvrtzzZ+yyUuaEkdXc5oYAsWWDMbJw3ntQH7hkRO
pCTXHiQniV4g41PP4ywuv96Y2j4hM41x9AWJXpGZhv35l8TkQFgQ/uCQqyEx4ldy
H7zeDhPETMudW89m9AEaI9ezMQwEtBl3mY4NJtJ3o4cCp7mLVCxx2MwyftXBIAZM
R/Q5HIJHKazNKs3oIKkGBrnn3J7MGUA+ZMDLt9ZNWvtazQp5uH99nSayBtRlgwVr
SSBo54U9RdSV1I0e2Ozuh5eTeKqV1AkXOkdooIe15oi7ewn779wX1nPPDGDB38/d
B/LH3SkVIbkEt22QUD24KjVN6jc0Lnj/CkQxHxmpCEG+3GoknGA=
=ghRg
-----END PGP SIGNATURE-----

--S8DRoSRW+P8LEQV/--
