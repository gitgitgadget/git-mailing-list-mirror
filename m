Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714E1F93E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290441; cv=none; b=Laya1+a2ZqTklYoMO3tjvX6QsQlzuwH7b6w+xG2AAh0RS4ozaUrQE6H5M9+tAmX+SgUlHaHaL/UHkn6WUySD0khlcvQl7NYzkm2s67F+oks/j+2fqQ4nMJkhtmxrjYh8b/BYARBMTUSqcW3q8YORqcaz9MkqxTbyTxGo86J8Pbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290441; c=relaxed/simple;
	bh=Oz0epKRuBMHbh4zDUjVLveTd/7Omad900DnCCzVuppM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja9lqz0Dygo8aY8VpDDkR9Sv+S2DnOul1jw8imrmt0urXotk5Trs8Odu28CU6MX8Q3hyr9jhjkbsEPqXa3/+IB5k6s4AnrQ1ZeFSzqhq7WhcPOP3eUJ2wyvvpBRwmUzp3Mj0DTFUTchX29e7iyr4h0B9JyjUeNo3ASYsFrzrezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fJwydpJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4IIy1gE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fJwydpJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4IIy1gE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 505901140092;
	Wed,  7 Feb 2024 02:20:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 02:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707290434; x=1707376834; bh=yNBlnFYBLc
	5f7ytFhWjeQCmWqJeJWapPqrxwqng2wnM=; b=fJwydpJYJtgXBekB9SgIWv2FCC
	A+ifgyRmNxeOpPjrIm6CzUya/ibDPt2wD5uDnYFbwydXud0IBjFOfshInYEMz1x2
	bXomJxuf6VIleXZtV5WKCNMPSBjguib2wXOyLWEUWcmbWJHKwrISNWxFfGcrRMDV
	i4GJKfGAY6kawPP2tzLQB25cxnLiSISQo+AQsVGzy88TflhnsoDZyK81kAmTaPn5
	tdUf1nqKq8KV7y/Lel+DCfGixEWhyXfzqttR1xPSG3c1GQIOudlGawFM3DXL5Rw2
	wYgatfuKbeSP3E710QyLmdl3aMnudHUybmciQDO+zEB7ODodcRPtL0a0BGag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707290434; x=1707376834; bh=yNBlnFYBLc5f7ytFhWjeQCmWqJeJ
	WapPqrxwqng2wnM=; b=T4IIy1gEIdeShLfN9EGE+TxIIldqaBfUfQArFuC15OOg
	enZk3ei/DAaNQ+anOuLQu/qc2OrkxfSz5gCZxCWbF9vDqHx7ETMeKuvTnCNnuEMJ
	xK5RlClbcAi0O1iBHPi1hEZ+VK++HL/25ymiCrYnV5yBYATFz7CsNoilosw8EA7o
	6lUM4h6mTbXCpybHdmtPk637Fog3nrURK+ZOUXlWJrVVPPpVovuJCDUO6pbJjvxh
	ZXOgRSIdgI1rxREWv3kvhpVi4otfLzwPpMpoh8zvtTkv2aBIqljnGSMRcvPOoZZM
	kR7pVTwjcCkDPBwaZn3wFKxuHe3KA4w4nVEEy+IT1Q==
X-ME-Sender: <xms:Qi_DZeslanTpGlSLfFl6HRhcpzbHeoCw3TLgzyb2VYAZjTEBq0UFrA>
    <xme:Qi_DZTdj3fXPkKztQxj8sNEcbUvWuEV5liy0HC5oclMt81da7rmPk4nfXoZ3aAWZj
    _BVwhpID_5P7CZc1w>
X-ME-Received: <xmr:Qi_DZZwAe7brVug2euFPQyVyxdts7dl774oo1DEGlbDCSqE-OnXfgKdcYQ_1j_H5KMuaKh6ZEeXsynJbbDqwzGlRE8KDguLuXyrp9l4hhx67Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptefftdduheegieevtedtueekiedvfeejjeefieetieffjeegtedtffefudeftdfh
    necuffhomhgrihhnpehhthhtphhtrhgrnhhsphhorhhtrdgrshdpphhusghlihgtqdhinh
    gsohigrdhorhhgpdhhthhtphgurdhshhdpuhhpuggrthgvrdhnvgifpdhuphgurghtvgdr
    nhgrmhgvpdhuphgurghtvgdrvghmrghilhdpuhhpuggrthgvrdhtiidpvhgrlhdvrdhtrg
    hrghgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Qi_DZZPWnlEmEzk3WOVhVlZ99rGVOd0IxW5WO_DJJI_ikznYReAoWw>
    <xmx:Qi_DZe8yMfu9ERDjtaocyI_3f_zA3NoMHDIrzsJ6o3iUrJ6toRL7vQ>
    <xmx:Qi_DZRUG8N6cKwTVA3FiIXJR9cvHH33p1ZvPm1UnAw0azr0vYfvh-A>
    <xmx:Qi_DZSZNLPhxx7ZW7CmDgqlapIutQJ1S4ui1sgcbV3kllTJB3DyZSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:20:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d94eccd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:17:01 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:20:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 1/2] refs: introduce reftable backend
Message-ID: <5de60d46bdccbfbf0a923abc2f45eda07f30c110.1707288261.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1707288261.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0L5ReFAz3rn0GTVv"
Content-Disposition: inline
In-Reply-To: <cover.1707288261.git.ps@pks.im>


--0L5ReFAz3rn0GTVv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Due to scalability issues, Shawn Pearce has originally proposed a new
"reftable" format more than six years ago [1]. Initially, this new
format was implemented in JGit with promising results. Around two years
ago, we have then added the "reftable" library to the Git codebase via
a4bbd13be3 (Merge branch 'hn/reftable', 2021-12-15). With this we have
landed all the low-level code to read and write reftables. Notably
missing though was the integration of this low-level code into the Git
code base in the form of a new ref backend that ties all of this
together.

This gap is now finally closed by introducing a new "reftable" backend
into the Git codebase. This new backend promises to bring some notable
improvements to Git repositories:

  - It becomes possible to do truly atomic writes where either all refs
    are committed to disk or none are. This was not possible with the
    "files" backend because ref updates were split across multiple loose
    files.

  - The disk space required to store many refs is reduced, both compared
    to loose refs and packed-refs. This is enabled both by the reftable
    format being a binary format, which is more compact, and by prefix
    compression.

  - We can ignore filesystem-specific behaviour as ref names are not
    encoded via paths anymore. This means there is no need to handle
    case sensitivity on Windows systems or Unicode precomposition on
    macOS.

  - There is no need to rewrite the complete refdb anymore every time a
    ref is being deleted like it was the case for packed-refs. This
    means that ref deletions are now constant time instead of scaling
    linearly with the number of refs.

  - We can ignore file/directory conflicts so that it becomes possible
    to store both "refs/heads/foo" and "refs/heads/foo/bar".

  - Due to this property we can retain reflogs for deleted refs. We have
    previously been deleting reflogs together with their refs to avoid
    file/directory conflicts, which is not necessary anymore.

  - We can properly enumerate all refs. With the "files" backend it is
    not easily possible to distinguish between refs and non-refs because
    they may live side by side in the gitdir.

Not all of these improvements are realized with the current "reftable"
backend implementation. At this point, the new backend is supposed to be
a drop-in replacement for the "files" backend that is used by basically
all Git repositories nowadays. It strives for 1:1 compatibility, which
means that a user can expect the same behaviour regardless of whether
they use the "reftable" backend or the "files" backend for most of the
part.

Most notably, this means we artificially limit the capabilities of the
"reftable" backend to match the limits of the "files" backend. It is not
possible to create refs that would end up with file/directory conflicts,
we do not retain reflogs, we perform stricter-than-necessary checks.
This is done intentionally due to two main reasons:

  - It makes it significantly easier to land the "reftable" backend as
    tests behave the same. It would be tough to argue for each and every
    single test that doesn't pass with the "reftable" backend.

  - It ensures compatibility between repositories that use the "files"
    backend and repositories that use the "reftable" backend. Like this,
    hosters can migrate their repositories to use the "reftable" backend
    without causing issues for clients that use the "files" backend in
    their clones.

It is expected that these artificial limitations may eventually go away
in the long term.

Performance-wise things very much depend on the actual workload. The
following benchmarks compare the "files" and "reftable" backends in the
current version:

  - Creating N refs in separate transactions shows that the "files"
    backend is ~50% faster. This is not surprising given that creating a
    ref only requires us to create a single loose ref. The "reftable"
    backend will also perform auto compaction on updates. In real-world
    workloads we would likely also want to perform pack loose refs,
    which would likely change the picture.

        Benchmark 1: update-ref: create refs sequentially (refformat =3D fi=
les, refcount =3D 1)
          Time (mean =C2=B1 =CF=83):       2.1 ms =C2=B1   0.3 ms    [User:=
 0.6 ms, System: 1.7 ms]
          Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   4.3 ms    133 r=
uns

        Benchmark 2: update-ref: create refs sequentially (refformat =3D re=
ftable, refcount =3D 1)
          Time (mean =C2=B1 =CF=83):       2.7 ms =C2=B1   0.1 ms    [User:=
 0.6 ms, System: 2.2 ms]
          Range (min =E2=80=A6 max):     2.4 ms =E2=80=A6   2.9 ms    132 r=
uns

        Benchmark 3: update-ref: create refs sequentially (refformat =3D fi=
les, refcount =3D 1000)
          Time (mean =C2=B1 =CF=83):      1.975 s =C2=B1  0.006 s    [User:=
 0.437 s, System: 1.535 s]
          Range (min =E2=80=A6 max):    1.969 s =E2=80=A6  1.980 s    3 runs

        Benchmark 4: update-ref: create refs sequentially (refformat =3D re=
ftable, refcount =3D 1000)
          Time (mean =C2=B1 =CF=83):      2.611 s =C2=B1  0.013 s    [User:=
 0.782 s, System: 1.825 s]
          Range (min =E2=80=A6 max):    2.597 s =E2=80=A6  2.622 s    3 runs

        Benchmark 5: update-ref: create refs sequentially (refformat =3D fi=
les, refcount =3D 100000)
          Time (mean =C2=B1 =CF=83):     198.442 s =C2=B1  0.241 s    [User=
: 43.051 s, System: 155.250 s]
          Range (min =E2=80=A6 max):   198.189 s =E2=80=A6 198.670 s    3 r=
uns

        Benchmark 6: update-ref: create refs sequentially (refformat =3D re=
ftable, refcount =3D 100000)
          Time (mean =C2=B1 =CF=83):     294.509 s =C2=B1  4.269 s    [User=
: 104.046 s, System: 190.326 s]
          Range (min =E2=80=A6 max):   290.223 s =E2=80=A6 298.761 s    3 r=
uns

  - Creating N refs in a single transaction shows that the "files"
    backend is significantly slower once we start to write many refs.
    The "reftable" backend only needs to update two files, whereas the
    "files" backend needs to write one file per ref.

        Benchmark 1: update-ref: create many refs (refformat =3D files, ref=
count =3D 1)
          Time (mean =C2=B1 =CF=83):       1.9 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.4 ms]
          Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   2.6 ms    151 r=
uns

        Benchmark 2: update-ref: create many refs (refformat =3D reftable, =
refcount =3D 1)
          Time (mean =C2=B1 =CF=83):       2.5 ms =C2=B1   0.1 ms    [User:=
 0.7 ms, System: 1.7 ms]
          Range (min =E2=80=A6 max):     2.4 ms =E2=80=A6   3.4 ms    148 r=
uns

        Benchmark 3: update-ref: create many refs (refformat =3D files, ref=
count =3D 1000)
          Time (mean =C2=B1 =CF=83):     152.5 ms =C2=B1   5.2 ms    [User:=
 19.1 ms, System: 133.1 ms]
          Range (min =E2=80=A6 max):   148.5 ms =E2=80=A6 167.8 ms    15 ru=
ns

        Benchmark 4: update-ref: create many refs (refformat =3D reftable, =
refcount =3D 1000)
          Time (mean =C2=B1 =CF=83):      58.0 ms =C2=B1   2.5 ms    [User:=
 28.4 ms, System: 29.4 ms]
          Range (min =E2=80=A6 max):    56.3 ms =E2=80=A6  72.9 ms    40 ru=
ns

        Benchmark 5: update-ref: create many refs (refformat =3D files, ref=
count =3D 1000000)
          Time (mean =C2=B1 =CF=83):     152.752 s =C2=B1  0.710 s    [User=
: 20.315 s, System: 131.310 s]
          Range (min =E2=80=A6 max):   152.165 s =E2=80=A6 153.542 s    3 r=
uns

        Benchmark 6: update-ref: create many refs (refformat =3D reftable, =
refcount =3D 1000000)
          Time (mean =C2=B1 =CF=83):     51.912 s =C2=B1  0.127 s    [User:=
 26.483 s, System: 25.424 s]
          Range (min =E2=80=A6 max):   51.769 s =E2=80=A6 52.012 s    3 runs

  - Deleting a ref in a fully-packed repository shows that the "files"
    backend scales with the number of refs. The "reftable" backend has
    constant-time deletions.

        Benchmark 1: update-ref: delete ref (refformat =3D files, refcount =
=3D 1)
          Time (mean =C2=B1 =CF=83):       1.7 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.2 ms]
          Range (min =E2=80=A6 max):     1.6 ms =E2=80=A6   2.1 ms    316 r=
uns

        Benchmark 2: update-ref: delete ref (refformat =3D reftable, refcou=
nt =3D 1)
          Time (mean =C2=B1 =CF=83):       1.8 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.3 ms]
          Range (min =E2=80=A6 max):     1.7 ms =E2=80=A6   2.1 ms    294 r=
uns

        Benchmark 3: update-ref: delete ref (refformat =3D files, refcount =
=3D 1000)
          Time (mean =C2=B1 =CF=83):       2.0 ms =C2=B1   0.1 ms    [User:=
 0.5 ms, System: 1.4 ms]
          Range (min =E2=80=A6 max):     1.9 ms =E2=80=A6   2.5 ms    287 r=
uns

        Benchmark 4: update-ref: delete ref (refformat =3D reftable, refcou=
nt =3D 1000)
          Time (mean =C2=B1 =CF=83):       1.9 ms =C2=B1   0.1 ms    [User:=
 0.5 ms, System: 1.3 ms]
          Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   2.1 ms    217 r=
uns

        Benchmark 5: update-ref: delete ref (refformat =3D files, refcount =
=3D 1000000)
          Time (mean =C2=B1 =CF=83):     229.8 ms =C2=B1   7.9 ms    [User:=
 182.6 ms, System: 46.8 ms]
          Range (min =E2=80=A6 max):   224.6 ms =E2=80=A6 245.2 ms    6 runs

        Benchmark 6: update-ref: delete ref (refformat =3D reftable, refcou=
nt =3D 1000000)
          Time (mean =C2=B1 =CF=83):       2.0 ms =C2=B1   0.0 ms    [User:=
 0.6 ms, System: 1.3 ms]
          Range (min =E2=80=A6 max):     2.0 ms =E2=80=A6   2.1 ms    3 runs

  - Listing all refs shows no significant advantage for either of the
    backends. The "files" backend is a bit faster, but not by a
    significant margin. When repositories are not packed the "reftable"
    backend outperforms the "files" backend because the "reftable"
    backend performs auto-compaction.

        Benchmark 1: show-ref: print all refs (refformat =3D files, refcoun=
t =3D 1, packed =3D true)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.5 ms =E2=80=A6   2.0 ms    1729 =
runs

        Benchmark 2: show-ref: print all refs (refformat =3D reftable, refc=
ount =3D 1, packed =3D true)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.5 ms =E2=80=A6   1.8 ms    1816 =
runs

        Benchmark 3: show-ref: print all refs (refformat =3D files, refcoun=
t =3D 1000, packed =3D true)
          Time (mean =C2=B1 =CF=83):       4.3 ms =C2=B1   0.1 ms    [User:=
 0.9 ms, System: 3.3 ms]
          Range (min =E2=80=A6 max):     4.1 ms =E2=80=A6   4.6 ms    645 r=
uns

        Benchmark 4: show-ref: print all refs (refformat =3D reftable, refc=
ount =3D 1000, packed =3D true)
          Time (mean =C2=B1 =CF=83):       4.5 ms =C2=B1   0.2 ms    [User:=
 1.0 ms, System: 3.3 ms]
          Range (min =E2=80=A6 max):     4.2 ms =E2=80=A6   5.9 ms    643 r=
uns

        Benchmark 5: show-ref: print all refs (refformat =3D files, refcoun=
t =3D 1000000, packed =3D true)
          Time (mean =C2=B1 =CF=83):      2.537 s =C2=B1  0.034 s    [User:=
 0.488 s, System: 2.048 s]
          Range (min =E2=80=A6 max):    2.511 s =E2=80=A6  2.627 s    10 ru=
ns

        Benchmark 6: show-ref: print all refs (refformat =3D reftable, refc=
ount =3D 1000000, packed =3D true)
          Time (mean =C2=B1 =CF=83):      2.712 s =C2=B1  0.017 s    [User:=
 0.653 s, System: 2.059 s]
          Range (min =E2=80=A6 max):    2.692 s =E2=80=A6  2.752 s    10 ru=
ns

        Benchmark 7: show-ref: print all refs (refformat =3D files, refcoun=
t =3D 1, packed =3D false)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.5 ms =E2=80=A6   1.9 ms    1834 =
runs

        Benchmark 8: show-ref: print all refs (refformat =3D reftable, refc=
ount =3D 1, packed =3D false)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.4 ms =E2=80=A6   2.0 ms    1840 =
runs

        Benchmark 9: show-ref: print all refs (refformat =3D files, refcoun=
t =3D 1000, packed =3D false)
          Time (mean =C2=B1 =CF=83):      13.8 ms =C2=B1   0.2 ms    [User:=
 2.8 ms, System: 10.8 ms]
          Range (min =E2=80=A6 max):    13.3 ms =E2=80=A6  14.5 ms    208 r=
uns

        Benchmark 10: show-ref: print all refs (refformat =3D reftable, ref=
count =3D 1000, packed =3D false)
          Time (mean =C2=B1 =CF=83):       4.5 ms =C2=B1   0.2 ms    [User:=
 1.2 ms, System: 3.3 ms]
          Range (min =E2=80=A6 max):     4.3 ms =E2=80=A6   6.2 ms    624 r=
uns

        Benchmark 11: show-ref: print all refs (refformat =3D files, refcou=
nt =3D 1000000, packed =3D false)
          Time (mean =C2=B1 =CF=83):     12.127 s =C2=B1  0.129 s    [User:=
 2.675 s, System: 9.451 s]
          Range (min =E2=80=A6 max):   11.965 s =E2=80=A6 12.370 s    10 ru=
ns

        Benchmark 12: show-ref: print all refs (refformat =3D reftable, ref=
count =3D 1000000, packed =3D false)
          Time (mean =C2=B1 =CF=83):      2.799 s =C2=B1  0.022 s    [User:=
 0.735 s, System: 2.063 s]
          Range (min =E2=80=A6 max):    2.769 s =E2=80=A6  2.836 s    10 ru=
ns

  - Printing a single ref shows no real difference between the "files"
    and "reftable" backends.

        Benchmark 1: show-ref: print single ref (refformat =3D files, refco=
unt =3D 1)
          Time (mean =C2=B1 =CF=83):       1.5 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.0 ms]
          Range (min =E2=80=A6 max):     1.4 ms =E2=80=A6   1.8 ms    1779 =
runs

        Benchmark 2: show-ref: print single ref (refformat =3D reftable, re=
fcount =3D 1)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.4 ms =E2=80=A6   2.5 ms    1753 =
runs

        Benchmark 3: show-ref: print single ref (refformat =3D files, refco=
unt =3D 1000)
          Time (mean =C2=B1 =CF=83):       1.5 ms =C2=B1   0.1 ms    [User:=
 0.3 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.4 ms =E2=80=A6   1.9 ms    1840 =
runs

        Benchmark 4: show-ref: print single ref (refformat =3D reftable, re=
fcount =3D 1000)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.5 ms =E2=80=A6   2.0 ms    1831 =
runs

        Benchmark 5: show-ref: print single ref (refformat =3D files, refco=
unt =3D 1000000)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.5 ms =E2=80=A6   2.1 ms    1848 =
runs

        Benchmark 6: show-ref: print single ref (refformat =3D reftable, re=
fcount =3D 1000000)
          Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.1 ms    [User:=
 0.4 ms, System: 1.1 ms]
          Range (min =E2=80=A6 max):     1.5 ms =E2=80=A6   2.1 ms    1762 =
runs

So overall, performance depends on the usecases. Except for many
sequential writes the "reftable" backend is roughly on par or
significantly faster than the "files" backend though. Given that the
"files" backend has received 18 years of optimizations by now this can
be seen as a win. Furthermore, we can expect that the "reftable" backend
will grow faster over time when attention turns more towards
optimizations.

The complete test suite passes, except for those tests explicitly marked
to require the REFFILES prerequisite. Some tests in t0610 are marked as
failing because they depend on still-in-flight bug fixes. Tests can be
run with the new backend by setting the GIT_TEST_DEFAULT_REF_FORMAT
environment variable to "reftable".

There is a single known conceptual incompatibility with the dumb HTTP
transport. As "info/refs" SHOULD NOT contain the HEAD reference, and
because the "HEAD" file is not valid anymore, it is impossible for the
remote client to figure out the default branch without changing the
protocol. This shortcoming needs to be handled in a subsequent patch
series.

As the reftable library has already been introduced a while ago, this
commit message will not go into the details of how exactly the on-disk
format works. Please refer to our preexisting technical documentation at
Documentation/technical/reftable for this.

[1]: https://public-inbox.org/git/CAJo=3DhJtyof=3DHRy=3D2sLP0ng0uZ4=3DS-DpZ=
5dR1aF+VHVETKG20OQ@mail.gmail.com/

Original-idea-by: Shawn Pearce <spearce@spearce.org>
Based-on-patch-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/ref-storage-format.txt          |    2 +
 .../technical/repository-version.txt          |    5 +-
 Makefile                                      |    1 +
 contrib/workdir/git-new-workdir               |    2 +-
 path.c                                        |    2 +-
 path.h                                        |    1 +
 refs.c                                        |    1 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 2297 +++++++++++++++++
 repository.h                                  |    5 +-
 t/t0610-reftable-basics.sh                    |  887 +++++++
 t/t0611-reftable-httpd.sh                     |   26 +
 t/test-lib.sh                                 |    2 +
 13 files changed, 3226 insertions(+), 6 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0610-reftable-basics.sh
 create mode 100755 t/t0611-reftable-httpd.sh

diff --git a/Documentation/ref-storage-format.txt b/Documentation/ref-stora=
ge-format.txt
index 1a65cac468..14fff8a9c6 100644
--- a/Documentation/ref-storage-format.txt
+++ b/Documentation/ref-storage-format.txt
@@ -1 +1,3 @@
 * `files` for loose files with packed-refs. This is the default.
+* `reftable` for the reftable format. This format is experimental and its
+  internals are subject to change.
diff --git a/Documentation/technical/repository-version.txt b/Documentation=
/technical/repository-version.txt
index 27be3741e6..47281420fc 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -103,5 +103,6 @@ GIT_COMMON_DIR/worktrees/<id>/config.worktree)
=20
 =3D=3D=3D=3D `refStorage`
=20
-Specifies the file format for the ref database. The only valid value
-is `files` (loose references with a packed-refs file).
+Specifies the file format for the ref database. The valid values are
+`files` (loose references with a packed-refs file) and `reftable` (see
+Documentation/technical/reftable.txt).
diff --git a/Makefile b/Makefile
index 302b863548..dd7b1cf9dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1127,6 +1127,7 @@ LIB_OBJS +=3D reflog.o
 LIB_OBJS +=3D refs.o
 LIB_OBJS +=3D refs/debug.o
 LIB_OBJS +=3D refs/files-backend.o
+LIB_OBJS +=3D refs/reftable-backend.o
 LIB_OBJS +=3D refs/iterator.o
 LIB_OBJS +=3D refs/packed-backend.o
 LIB_OBJS +=3D refs/ref-cache.o
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-work=
dir
index 888c34a521..989197aace 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -79,7 +79,7 @@ trap cleanup $siglist
 # create the links to the original repo.  explicitly exclude index, HEAD a=
nd
 # logs/HEAD from the list since they are purely related to the current wor=
king
 # directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-c=
ache svn
+for x in config refs logs/refs objects info hooks packed-refs remotes rr-c=
ache svn reftable
 do
 	# create a containing directory if needed
 	case $x in
diff --git a/path.c b/path.c
index 0fb527918b..8bb223c92c 100644
--- a/path.c
+++ b/path.c
@@ -871,7 +871,7 @@ const char *enter_repo(const char *path, int strict)
 	return NULL;
 }
=20
-static int calc_shared_perm(int mode)
+int calc_shared_perm(int mode)
 {
 	int tweak;
=20
diff --git a/path.h b/path.h
index b3233c51fa..e053effef2 100644
--- a/path.h
+++ b/path.h
@@ -181,6 +181,7 @@ const char *git_path_shallow(struct repository *r);
 int ends_with_path_components(const char *path, const char *components);
 int validate_headref(const char *ref);
=20
+int calc_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
=20
 char *interpolate_path(const char *path, int real_home);
diff --git a/refs.c b/refs.c
index c633abf284..fff343c256 100644
--- a/refs.c
+++ b/refs.c
@@ -35,6 +35,7 @@
  */
 static const struct ref_storage_be *refs_backends[] =3D {
 	[REF_STORAGE_FORMAT_FILES] =3D &refs_be_files,
+	[REF_STORAGE_FORMAT_REFTABLE] =3D &refs_be_reftable,
 };
=20
 static const struct ref_storage_be *find_ref_storage_backend(unsigned int =
ref_storage_format)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 82219829b0..83e0f0bba3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -693,6 +693,7 @@ struct ref_storage_be {
 };
=20
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
=20
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 0000000000..85214baa60
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,2297 @@
+#include "../git-compat-util.h"
+#include "../abspath.h"
+#include "../chdir-notify.h"
+#include "../environment.h"
+#include "../gettext.h"
+#include "../hash.h"
+#include "../hex.h"
+#include "../iterator.h"
+#include "../ident.h"
+#include "../lockfile.h"
+#include "../object.h"
+#include "../path.h"
+#include "../refs.h"
+#include "../reftable/reftable-stack.h"
+#include "../reftable/reftable-record.h"
+#include "../reftable/reftable-error.h"
+#include "../reftable/reftable-iterator.h"
+#include "../reftable/reftable-merged.h"
+#include "../setup.h"
+#include "../strmap.h"
+#include "refs-internal.h"
+
+/*
+ * Used as a flag in ref_update::flags when the ref_update was via an
+ * update to HEAD.
+ */
+#define REF_UPDATE_VIA_HEAD (1 << 8)
+
+struct reftable_ref_store {
+	struct ref_store base;
+
+	/*
+	 * The main stack refers to the common dir and thus contains common
+	 * refs as well as refs of the main repository.
+	 */
+	struct reftable_stack *main_stack;
+	/*
+	 * The worktree stack refers to the gitdir in case the refdb is opened
+	 * via a worktree. It thus contains the per-worktree refs.
+	 */
+	struct reftable_stack *worktree_stack;
+	/*
+	 * Map of worktree stacks by their respective worktree names. The map
+	 * is populated lazily when we try to resolve `worktrees/$worktree` refs.
+	 */
+	struct strmap worktree_stacks;
+	struct reftable_write_options write_options;
+
+	unsigned int store_flags;
+	int err;
+};
+
+/*
+ * Downcast ref_store to reftable_ref_store. Die if ref_store is not a
+ * reftable_ref_store. required_flags is compared with ref_store's store_f=
lags
+ * to ensure the ref_store has all required capabilities. "caller" is used=
 in
+ * any necessary error messages.
+ */
+static struct reftable_ref_store *reftable_be_downcast(struct ref_store *r=
ef_store,
+						       unsigned int required_flags,
+						       const char *caller)
+{
+	struct reftable_ref_store *refs;
+
+	if (ref_store->be !=3D &refs_be_reftable)
+		BUG("ref_store is type \"%s\" not \"reftables\" in %s",
+		    ref_store->be->name, caller);
+
+	refs =3D (struct reftable_ref_store *)ref_store;
+
+	if ((refs->store_flags & required_flags) !=3D required_flags)
+		BUG("operation %s requires abilities 0x%x, but only have 0x%x",
+		    caller, required_flags, refs->store_flags);
+
+	return refs;
+}
+
+/*
+ * Some refs are global to the repository (refs/heads/{*}), while others a=
re
+ * local to the worktree (eg. HEAD, refs/bisect/{*}). We solve this by hav=
ing
+ * multiple separate databases (ie. multiple reftable/ directories), one f=
or
+ * the shared refs, one for the current worktree refs, and one for each
+ * additional worktree. For reading, we merge the view of both the shared =
and
+ * the current worktree's refs, when necessary.
+ *
+ * This function also optionally assigns the rewritten reference name that=
 is
+ * local to the stack. This translation is required when using worktree re=
fs
+ * like `worktrees/$worktree/refs/heads/foo` as worktree stacks will store
+ * those references in their normalized form.
+ */
+static struct reftable_stack *stack_for(struct reftable_ref_store *store,
+					const char *refname,
+					const char **rewritten_ref)
+{
+	const char *wtname;
+	int wtname_len;
+
+	if (!refname)
+		return store->main_stack;
+
+	switch (parse_worktree_ref(refname, &wtname, &wtname_len, rewritten_ref))=
 {
+	case REF_WORKTREE_OTHER: {
+		static struct strbuf wtname_buf =3D STRBUF_INIT;
+		struct strbuf wt_dir =3D STRBUF_INIT;
+		struct reftable_stack *stack;
+
+		/*
+		 * We're using a static buffer here so that we don't need to
+		 * allocate the worktree name whenever we look up a reference.
+		 * This could be avoided if the strmap interface knew how to
+		 * handle keys with a length.
+		 */
+		strbuf_reset(&wtname_buf);
+		strbuf_add(&wtname_buf, wtname, wtname_len);
+
+		/*
+		 * There is an edge case here: when the worktree references the
+		 * current worktree, then we set up the stack once via
+		 * `worktree_stacks` and once via `worktree_stack`. This is
+		 * wasteful, but in the reading case it shouldn't matter. And
+		 * in the writing case we would notice that the stack is locked
+		 * already and error out when trying to write a reference via
+		 * both stacks.
+		 */
+		stack =3D strmap_get(&store->worktree_stacks, wtname_buf.buf);
+		if (!stack) {
+			strbuf_addf(&wt_dir, "%s/worktrees/%s/reftable",
+				    store->base.repo->commondir, wtname_buf.buf);
+
+			store->err =3D reftable_new_stack(&stack, wt_dir.buf,
+							store->write_options);
+			assert(store->err !=3D REFTABLE_API_ERROR);
+			strmap_put(&store->worktree_stacks, wtname_buf.buf, stack);
+		}
+
+		strbuf_release(&wt_dir);
+		return stack;
+	}
+	case REF_WORKTREE_CURRENT:
+		/*
+		 * If there is no worktree stack then we're currently in the
+		 * main worktree. We thus return the main stack in that case.
+		 */
+		if (!store->worktree_stack)
+			return store->main_stack;
+		return store->worktree_stack;
+	case REF_WORKTREE_MAIN:
+	case REF_WORKTREE_SHARED:
+		return store->main_stack;
+	default:
+		BUG("unhandled worktree reference type");
+	}
+}
+
+static int should_write_log(struct ref_store *refs, const char *refname)
+{
+	if (log_all_ref_updates =3D=3D LOG_REFS_UNSET)
+		log_all_ref_updates =3D is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_=
NORMAL;
+
+	switch (log_all_ref_updates) {
+	case LOG_REFS_NONE:
+		return refs_reflog_exists(refs, refname);
+	case LOG_REFS_ALWAYS:
+		return 1;
+	case LOG_REFS_NORMAL:
+		if (should_autocreate_reflog(refname))
+			return 1;
+		return refs_reflog_exists(refs, refname);
+	default:
+		BUG("unhandled core.logAllRefUpdates value %d", log_all_ref_updates);
+	}
+}
+
+static void clear_reftable_log_record(struct reftable_log_record *log)
+{
+	switch (log->value_type) {
+	case REFTABLE_LOG_UPDATE:
+		/*
+		 * When we write log records, the hashes are owned by the
+		 * caller and thus shouldn't be free'd.
+		 */
+		log->value.update.old_hash =3D NULL;
+		log->value.update.new_hash =3D NULL;
+		break;
+	case REFTABLE_LOG_DELETION:
+		break;
+	}
+	reftable_log_record_release(log);
+}
+
+static void fill_reftable_log_record(struct reftable_log_record *log)
+{
+	const char *info =3D git_committer_info(0);
+	struct ident_split split =3D {0};
+	int sign =3D 1;
+
+	if (split_ident_line(&split, info, strlen(info)))
+		BUG("failed splitting committer info");
+
+	reftable_log_record_release(log);
+	log->value_type =3D REFTABLE_LOG_UPDATE;
+	log->value.update.name =3D
+		xstrndup(split.name_begin, split.name_end - split.name_begin);
+	log->value.update.email =3D
+		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
+	log->value.update.time =3D atol(split.date_begin);
+	if (*split.tz_begin =3D=3D '-') {
+		sign =3D -1;
+		split.tz_begin++;
+	}
+	if (*split.tz_begin =3D=3D '+') {
+		sign =3D 1;
+		split.tz_begin++;
+	}
+
+	log->value.update.tz_offset =3D sign * atoi(split.tz_begin);
+}
+
+static int read_ref_without_reload(struct reftable_stack *stack,
+				   const char *refname,
+				   struct object_id *oid,
+				   struct strbuf *referent,
+				   unsigned int *type)
+{
+	struct reftable_ref_record ref =3D {0};
+	int ret;
+
+	ret =3D reftable_stack_read_ref(stack, refname, &ref);
+	if (ret)
+		goto done;
+
+	if (ref.value_type =3D=3D REFTABLE_REF_SYMREF) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.value.symref);
+		*type |=3D REF_ISSYMREF;
+	} else if (reftable_ref_record_val1(&ref)) {
+		oidread(oid, reftable_ref_record_val1(&ref));
+	} else {
+		/* We got a tombstone, which should not happen. */
+		BUG("unhandled reference value type %d", ref.value_type);
+	}
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	return ret;
+}
+
+static struct ref_store *reftable_be_init(struct repository *repo,
+					  const char *gitdir,
+					  unsigned int store_flags)
+{
+	struct reftable_ref_store *refs =3D xcalloc(1, sizeof(*refs));
+	struct strbuf path =3D STRBUF_INIT;
+	int is_worktree;
+	mode_t mask;
+
+	mask =3D umask(0);
+	umask(mask);
+
+	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
+	strmap_init(&refs->worktree_stacks);
+	refs->store_flags =3D store_flags;
+	refs->write_options.block_size =3D 4096;
+	refs->write_options.hash_id =3D repo->hash_algo->format_id;
+	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~mask=
);
+
+	/*
+	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
+	 * This stack contains both the shared and the main worktree refs.
+	 *
+	 * Note that we don't try to resolve the path in case we have a
+	 * worktree because `get_common_dir_noenv()` already does it for us.
+	 */
+	is_worktree =3D get_common_dir_noenv(&path, gitdir);
+	if (!is_worktree) {
+		strbuf_reset(&path);
+		strbuf_realpath(&path, gitdir, 0);
+	}
+	strbuf_addstr(&path, "/reftable");
+	refs->err =3D reftable_new_stack(&refs->main_stack, path.buf,
+				       refs->write_options);
+	if (refs->err)
+		goto done;
+
+	/*
+	 * If we're in a worktree we also need to set up the worktree reftable
+	 * stack that is contained in the per-worktree GIT_DIR.
+	 *
+	 * Ideally, we would also add the stack to our worktree stack map. But
+	 * we have no way to figure out the worktree name here and thus can't
+	 * do it efficiently.
+	 */
+	if (is_worktree) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/reftable", gitdir);
+
+		refs->err =3D reftable_new_stack(&refs->worktree_stack, path.buf,
+					       refs->write_options);
+		if (refs->err)
+			goto done;
+	}
+
+	chdir_notify_reparent("reftables-backend $GIT_DIR", &refs->base.gitdir);
+
+done:
+	assert(refs->err !=3D REFTABLE_API_ERROR);
+	strbuf_release(&path);
+	return &refs->base;
+}
+
+static int reftable_be_init_db(struct ref_store *ref_store,
+			       int flags UNUSED,
+			       struct strbuf *err UNUSED)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "init_db");
+	struct strbuf sb =3D STRBUF_INIT;
+
+	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
+	write_file(sb.buf, "ref: refs/heads/.invalid");
+	adjust_shared_perm(sb.buf);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
+	write_file(sb.buf, "this repository uses the reftable format");
+	adjust_shared_perm(sb.buf);
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+struct reftable_ref_iterator {
+	struct ref_iterator base;
+	struct reftable_ref_store *refs;
+	struct reftable_iterator iter;
+	struct reftable_ref_record ref;
+	struct object_id oid;
+
+	const char *prefix;
+	unsigned int flags;
+	int err;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct reftable_ref_iterator *iter =3D
+		(struct reftable_ref_iterator *)ref_iterator;
+	struct reftable_ref_store *refs =3D iter->refs;
+
+	while (!iter->err) {
+		int flags =3D 0;
+
+		iter->err =3D reftable_iterator_next_ref(&iter->iter, &iter->ref);
+		if (iter->err)
+			break;
+
+		/*
+		 * The files backend only lists references contained in
+		 * "refs/". We emulate the same behaviour here and thus skip
+		 * all references that don't start with this prefix.
+		 */
+		if (!starts_with(iter->ref.refname, "refs/"))
+			continue;
+
+		if (iter->prefix &&
+		    strncmp(iter->prefix, iter->ref.refname, strlen(iter->prefix))) {
+			iter->err =3D 1;
+			break;
+		}
+
+		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    parse_worktree_ref(iter->ref.refname, NULL, NULL, NULL) !=3D
+			    REF_WORKTREE_CURRENT)
+			continue;
+
+		switch (iter->ref.value_type) {
+		case REFTABLE_REF_VAL1:
+			oidread(&iter->oid, iter->ref.value.val1);
+			break;
+		case REFTABLE_REF_VAL2:
+			oidread(&iter->oid, iter->ref.value.val2.value);
+			break;
+		case REFTABLE_REF_SYMREF:
+			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
+						     RESOLVE_REF_READING, &iter->oid, &flags))
+				oidclr(&iter->oid);
+			break;
+		default:
+			BUG("unhandled reference value type %d", iter->ref.value_type);
+		}
+
+		if (is_null_oid(&iter->oid))
+			flags |=3D REF_ISBROKEN;
+
+		if (check_refname_format(iter->ref.refname, REFNAME_ALLOW_ONELEVEL)) {
+			if (!refname_is_safe(iter->ref.refname))
+				die(_("refname is dangerous: %s"), iter->ref.refname);
+			oidclr(&iter->oid);
+			flags |=3D REF_BAD_NAME | REF_ISBROKEN;
+		}
+
+		if (iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS &&
+		    flags & REF_ISSYMREF &&
+		    flags & REF_ISBROKEN)
+			continue;
+
+		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(iter->ref.refname, refs->base.repo,
+					    &iter->oid, flags))
+				continue;
+
+		iter->base.refname =3D iter->ref.refname;
+		iter->base.oid =3D &iter->oid;
+		iter->base.flags =3D flags;
+
+		break;
+	}
+
+	if (iter->err > 0) {
+		if (ref_iterator_abort(ref_iterator) !=3D ITER_DONE)
+			return ITER_ERROR;
+		return ITER_DONE;
+	}
+
+	if (iter->err < 0) {
+		ref_iterator_abort(ref_iterator);
+		return ITER_ERROR;
+	}
+
+	return ITER_OK;
+}
+
+static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	struct reftable_ref_iterator *iter =3D
+		(struct reftable_ref_iterator *)ref_iterator;
+
+	if (iter->ref.value_type =3D=3D REFTABLE_REF_VAL2) {
+		oidread(peeled, iter->ref.value.val2.target_value);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct reftable_ref_iterator *iter =3D
+		(struct reftable_ref_iterator *)ref_iterator;
+	reftable_ref_record_release(&iter->ref);
+	reftable_iterator_destroy(&iter->iter);
+	free(iter);
+	return ITER_DONE;
+}
+
+static struct ref_iterator_vtable reftable_ref_iterator_vtable =3D {
+	.advance =3D reftable_ref_iterator_advance,
+	.peel =3D reftable_ref_iterator_peel,
+	.abort =3D reftable_ref_iterator_abort
+};
+
+static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftabl=
e_ref_store *refs,
+							    struct reftable_stack *stack,
+							    const char *prefix,
+							    int flags)
+{
+	struct reftable_merged_table *merged_table;
+	struct reftable_ref_iterator *iter;
+	int ret;
+
+	iter =3D xcalloc(1, sizeof(*iter));
+	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable, 1);
+	iter->prefix =3D prefix;
+	iter->base.oid =3D &iter->oid;
+	iter->flags =3D flags;
+	iter->refs =3D refs;
+
+	ret =3D refs->err;
+	if (ret)
+		goto done;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		goto done;
+
+	merged_table =3D reftable_stack_merged_table(stack);
+
+	ret =3D reftable_merged_table_seek_ref(merged_table, &iter->iter, prefix);
+	if (ret)
+		goto done;
+
+done:
+	iter->err =3D ret;
+	return iter;
+}
+
+static enum iterator_selection iterator_select(struct ref_iterator *iter_w=
orktree,
+					       struct ref_iterator *iter_common,
+					       void *cb_data UNUSED)
+{
+	if (iter_worktree && !iter_common) {
+		/*
+		 * Return the worktree ref if there are no more common refs.
+		 */
+		return ITER_SELECT_0;
+	} else if (iter_common) {
+		/*
+		 * In case we have pending worktree and common refs we need to
+		 * yield them based on their lexicographical order. Worktree
+		 * refs that have the same name as common refs shadow the
+		 * latter.
+		 */
+		if (iter_worktree) {
+			int cmp =3D strcmp(iter_worktree->refname,
+					 iter_common->refname);
+			if (cmp < 0)
+				return ITER_SELECT_0;
+			else if (!cmp)
+				return ITER_SELECT_0_SKIP_1;
+		}
+
+		 /*
+		  * We now know that the lexicographically-next ref is a common
+		  * ref. When the common ref is a shared one we return it.
+		  */
+		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
+				       NULL) =3D=3D REF_WORKTREE_SHARED)
+			return ITER_SELECT_1;
+
+		/*
+		 * Otherwise, if the common ref is a per-worktree ref we skip
+		 * it because it would belong to the main worktree, not ours.
+		 */
+		return ITER_SKIP_1;
+	} else {
+		return ITER_DONE;
+	}
+}
+
+static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *r=
ef_store,
+						       const char *prefix,
+						       const char **exclude_patterns,
+						       unsigned int flags)
+{
+	struct reftable_ref_iterator *main_iter, *worktree_iter;
+	struct reftable_ref_store *refs;
+	unsigned int required_flags =3D REF_STORE_READ;
+
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+		required_flags |=3D REF_STORE_ODB;
+	refs =3D reftable_be_downcast(ref_store, required_flags, "ref_iterator_be=
gin");
+
+	main_iter =3D ref_iterator_for_stack(refs, refs->main_stack, prefix, flag=
s);
+
+	/*
+	 * The worktree stack is only set when we're in an actual worktree
+	 * right now. If we aren't, then we return the common reftable
+	 * iterator, only.
+	 */
+	 if (!refs->worktree_stack)
+		return &main_iter->base;
+
+	/*
+	 * Otherwise we merge both the common and the per-worktree refs into a
+	 * single iterator.
+	 */
+	worktree_iter =3D ref_iterator_for_stack(refs, refs->worktree_stack, pref=
ix, flags);
+	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
+					iterator_select, NULL);
+}
+
+static int reftable_be_read_raw_ref(struct ref_store *ref_store,
+				    const char *refname,
+				    struct object_id *oid,
+				    struct strbuf *referent,
+				    unsigned int *type,
+				    int *failure_errno)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	int ret;
+
+	if (refs->err < 0)
+		return refs->err;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		return ret;
+
+	ret =3D read_ref_without_reload(stack, refname, oid, referent, type);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		*failure_errno =3D ENOENT;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
+					 const char *refname,
+					 struct strbuf *referent)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_READ, "read_symbolic_ref");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct reftable_ref_record ref =3D {0};
+	int ret;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		return ret;
+
+	ret =3D reftable_stack_read_ref(stack, refname, &ref);
+	if (ret =3D=3D 0 && ref.value_type =3D=3D REFTABLE_REF_SYMREF)
+		strbuf_addstr(referent, ref.value.symref);
+	else
+		ret =3D -1;
+
+	reftable_ref_record_release(&ref);
+	return ret;
+}
+
+/*
+ * Return the refname under which update was originally requested.
+ */
+static const char *original_update_refname(struct ref_update *update)
+{
+	while (update->parent_update)
+		update =3D update->parent_update;
+	return update->refname;
+}
+
+struct reftable_transaction_update {
+	struct ref_update *update;
+	struct object_id current_oid;
+};
+
+struct write_transaction_table_arg {
+	struct reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	struct reftable_addition *addition;
+	struct reftable_transaction_update *updates;
+	size_t updates_nr;
+	size_t updates_alloc;
+	size_t updates_expected;
+};
+
+struct reftable_transaction_data {
+	struct write_transaction_table_arg *args;
+	size_t args_nr, args_alloc;
+};
+
+static void free_transaction_data(struct reftable_transaction_data *tx_dat=
a)
+{
+	if (!tx_data)
+		return;
+	for (size_t i =3D 0; i < tx_data->args_nr; i++) {
+		reftable_addition_destroy(tx_data->args[i].addition);
+		free(tx_data->args[i].updates);
+	}
+	free(tx_data->args);
+	free(tx_data);
+}
+
+/*
+ * Prepare transaction update for the given reference update. This will ca=
use
+ * us to lock the corresponding reftable stack for concurrent modification.
+ */
+static int prepare_transaction_update(struct write_transaction_table_arg *=
*out,
+				      struct reftable_ref_store *refs,
+				      struct reftable_transaction_data *tx_data,
+				      struct ref_update *update,
+				      struct strbuf *err)
+{
+	struct reftable_stack *stack =3D stack_for(refs, update->refname, NULL);
+	struct write_transaction_table_arg *arg =3D NULL;
+	size_t i;
+	int ret;
+
+	/*
+	 * Search for a preexisting stack update. If there is one then we add
+	 * the update to it, otherwise we set up a new stack update.
+	 */
+	for (i =3D 0; !arg && i < tx_data->args_nr; i++)
+		if (tx_data->args[i].stack =3D=3D stack)
+			arg =3D &tx_data->args[i];
+
+	if (!arg) {
+		struct reftable_addition *addition;
+
+		ret =3D reftable_stack_reload(stack);
+		if (ret)
+			return ret;
+
+		ret =3D reftable_stack_new_addition(&addition, stack);
+		if (ret) {
+			if (ret =3D=3D REFTABLE_LOCK_ERROR)
+				strbuf_addstr(err, "cannot lock references");
+			return ret;
+		}
+
+		ALLOC_GROW(tx_data->args, tx_data->args_nr + 1,
+			   tx_data->args_alloc);
+		arg =3D &tx_data->args[tx_data->args_nr++];
+		arg->refs =3D refs;
+		arg->stack =3D stack;
+		arg->addition =3D addition;
+		arg->updates =3D NULL;
+		arg->updates_nr =3D 0;
+		arg->updates_alloc =3D 0;
+		arg->updates_expected =3D 0;
+	}
+
+	arg->updates_expected++;
+
+	if (out)
+		*out =3D arg;
+
+	return 0;
+}
+
+/*
+ * Queue a reference update for the correct stack. We potentially need to
+ * handle multiple stack updates in a single transaction when it spans acr=
oss
+ * multiple worktrees.
+ */
+static int queue_transaction_update(struct reftable_ref_store *refs,
+				    struct reftable_transaction_data *tx_data,
+				    struct ref_update *update,
+				    struct object_id *current_oid,
+				    struct strbuf *err)
+{
+	struct write_transaction_table_arg *arg =3D NULL;
+	int ret;
+
+	if (update->backend_data)
+		BUG("reference update queued more than once");
+
+	ret =3D prepare_transaction_update(&arg, refs, tx_data, update, err);
+	if (ret < 0)
+		return ret;
+
+	ALLOC_GROW(arg->updates, arg->updates_nr + 1,
+		   arg->updates_alloc);
+	arg->updates[arg->updates_nr].update =3D update;
+	oidcpy(&arg->updates[arg->updates_nr].current_oid, current_oid);
+	update->backend_data =3D &arg->updates[arg->updates_nr++];
+
+	return 0;
+}
+
+static int reftable_be_transaction_prepare(struct ref_store *ref_store,
+					   struct ref_transaction *transaction,
+					   struct strbuf *err)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_tra=
nsaction_prepare");
+	struct strbuf referent =3D STRBUF_INIT, head_referent =3D STRBUF_INIT;
+	struct string_list affected_refnames =3D STRING_LIST_INIT_NODUP;
+	struct reftable_transaction_data *tx_data =3D NULL;
+	struct object_id head_oid;
+	unsigned int head_type =3D 0;
+	size_t i;
+	int ret;
+
+	ret =3D refs->err;
+	if (ret < 0)
+		goto done;
+
+	tx_data =3D xcalloc(1, sizeof(*tx_data));
+
+	/*
+	 * Preprocess all updates. For one we check that there are no duplicate
+	 * reference updates in this transaction. Second, we lock all stacks
+	 * that will be modified during the transaction.
+	 */
+	for (i =3D 0; i < transaction->nr; i++) {
+		ret =3D prepare_transaction_update(NULL, refs, tx_data,
+						 transaction->updates[i], err);
+		if (ret)
+			goto done;
+
+		string_list_append(&affected_refnames,
+				   transaction->updates[i]->refname);
+	}
+
+	/*
+	 * Now that we have counted updates per stack we can preallocate their
+	 * arrays. This avoids having to reallocate many times.
+	 */
+	for (i =3D 0; i < tx_data->args_nr; i++) {
+		CALLOC_ARRAY(tx_data->args[i].updates, tx_data->args[i].updates_expected=
);
+		tx_data->args[i].updates_alloc =3D tx_data->args[i].updates_expected;
+	}
+
+	/*
+	 * Fail if a refname appears more than once in the transaction.
+	 * This code is taken from the files backend and is a good candidate to
+	 * be moved into the generic layer.
+	 */
+	string_list_sort(&affected_refnames);
+	if (ref_update_reject_duplicates(&affected_refnames, err)) {
+		ret =3D TRANSACTION_GENERIC_ERROR;
+		goto done;
+	}
+
+	ret =3D read_ref_without_reload(stack_for(refs, "HEAD", NULL), "HEAD", &h=
ead_oid,
+				      &head_referent, &head_type);
+	if (ret < 0)
+		goto done;
+
+	for (i =3D 0; i < transaction->nr; i++) {
+		struct ref_update *u =3D transaction->updates[i];
+		struct object_id current_oid =3D {0};
+		struct reftable_stack *stack;
+		const char *rewritten_ref;
+
+		stack =3D stack_for(refs, u->refname, &rewritten_ref);
+
+		/* Verify that the new object ID is valid. */
+		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
+		    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
+		    !(u->flags & REF_LOG_ONLY)) {
+			struct object *o =3D parse_object(refs->base.repo, &u->new_oid);
+			if (!o) {
+				strbuf_addf(err,
+					    _("trying to write ref '%s' with nonexistent object %s"),
+					    u->refname, oid_to_hex(&u->new_oid));
+				ret =3D -1;
+				goto done;
+			}
+
+			if (o->type !=3D OBJ_COMMIT && is_branch(u->refname)) {
+				strbuf_addf(err, _("trying to write non-commit object %s to branch '%s=
'"),
+					    oid_to_hex(&u->new_oid), u->refname);
+				ret =3D -1;
+				goto done;
+			}
+		}
+
+		/*
+		 * When we update the reference that HEAD points to we enqueue
+		 * a second log-only update for HEAD so that its reflog is
+		 * updated accordingly.
+		 */
+		if (head_type =3D=3D REF_ISSYMREF &&
+		    !(u->flags & REF_LOG_ONLY) &&
+		    !(u->flags & REF_UPDATE_VIA_HEAD) &&
+		    !strcmp(rewritten_ref, head_referent.buf)) {
+			struct ref_update *new_update;
+
+			/*
+			 * First make sure that HEAD is not already in the
+			 * transaction. This check is O(lg N) in the transaction
+			 * size, but it happens at most once per transaction.
+			 */
+			if (string_list_has_string(&affected_refnames, "HEAD")) {
+				/* An entry already existed */
+				strbuf_addf(err,
+					    _("multiple updates for 'HEAD' (including one "
+					    "via its referent '%s') are not allowed"),
+					    u->refname);
+				ret =3D TRANSACTION_NAME_CONFLICT;
+				goto done;
+			}
+
+			new_update =3D ref_transaction_add_update(
+					transaction, "HEAD",
+					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
+					&u->new_oid, &u->old_oid, u->msg);
+			string_list_insert(&affected_refnames, new_update->refname);
+		}
+
+		ret =3D read_ref_without_reload(stack, rewritten_ref,
+					      &current_oid, &referent, &u->type);
+		if (ret < 0)
+			goto done;
+		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) || is_null_oid(&u->old_oid)))=
 {
+			/*
+			 * The reference does not exist, and we either have no
+			 * old object ID or expect the reference to not exist.
+			 * We can thus skip below safety checks as well as the
+			 * symref splitting. But we do want to verify that
+			 * there is no conflicting reference here so that we
+			 * can output a proper error message instead of failing
+			 * at a later point.
+			 */
+			ret =3D refs_verify_refname_available(ref_store, u->refname,
+							    &affected_refnames, NULL, err);
+			if (ret < 0)
+				goto done;
+
+			/*
+			 * There is no need to write the reference deletion
+			 * when the reference in question doesn't exist.
+			 */
+			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+				 ret =3D queue_transaction_update(refs, tx_data, u,
+								&current_oid, err);
+				 if (ret)
+					 goto done;
+			 }
+
+			continue;
+		}
+		if (ret > 0) {
+			/* The reference does not exist, but we expected it to. */
+			strbuf_addf(err, _("cannot lock ref '%s': "
+				    "unable to resolve reference '%s'"),
+				    original_update_refname(u), u->refname);
+			ret =3D -1;
+			goto done;
+		}
+
+		if (u->type & REF_ISSYMREF) {
+			/*
+			 * The reftable stack is locked at this point already,
+			 * so it is safe to call `refs_resolve_ref_unsafe()`
+			 * here without causing races.
+			 */
+			const char *resolved =3D refs_resolve_ref_unsafe(&refs->base, u->refnam=
e, 0,
+								       &current_oid, NULL);
+
+			if (u->flags & REF_NO_DEREF) {
+				if (u->flags & REF_HAVE_OLD && !resolved) {
+					strbuf_addf(err, _("cannot lock ref '%s': "
+						    "error reading reference"), u->refname);
+					ret =3D -1;
+					goto done;
+				}
+			} else {
+				struct ref_update *new_update;
+				int new_flags;
+
+				new_flags =3D u->flags;
+				if (!strcmp(rewritten_ref, "HEAD"))
+					new_flags |=3D REF_UPDATE_VIA_HEAD;
+
+				/*
+				 * If we are updating a symref (eg. HEAD), we should also
+				 * update the branch that the symref points to.
+				 *
+				 * This is generic functionality, and would be better
+				 * done in refs.c, but the current implementation is
+				 * intertwined with the locking in files-backend.c.
+				 */
+				new_update =3D ref_transaction_add_update(
+						transaction, referent.buf, new_flags,
+						&u->new_oid, &u->old_oid, u->msg);
+				new_update->parent_update =3D u;
+
+				/*
+				 * Change the symbolic ref update to log only. Also, it
+				 * doesn't need to check its old OID value, as that will be
+				 * done when new_update is processed.
+				 */
+				u->flags |=3D REF_LOG_ONLY | REF_NO_DEREF;
+				u->flags &=3D ~REF_HAVE_OLD;
+
+				if (string_list_has_string(&affected_refnames, new_update->refname)) {
+					strbuf_addf(err,
+						    _("multiple updates for '%s' (including one "
+						    "via symref '%s') are not allowed"),
+						    referent.buf, u->refname);
+					ret =3D TRANSACTION_NAME_CONFLICT;
+					goto done;
+				}
+				string_list_insert(&affected_refnames, new_update->refname);
+			}
+		}
+
+		/*
+		 * Verify that the old object matches our expectations. Note
+		 * that the error messages here do not make a lot of sense in
+		 * the context of the reftable backend as we never lock
+		 * individual refs. But the error messages match what the files
+		 * backend returns, which keeps our tests happy.
+		 */
+		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
+			if (is_null_oid(&u->old_oid))
+				strbuf_addf(err, _("cannot lock ref '%s': "
+					    "reference already exists"),
+					    original_update_refname(u));
+			else if (is_null_oid(&current_oid))
+				strbuf_addf(err, _("cannot lock ref '%s': "
+					    "reference is missing but expected %s"),
+					    original_update_refname(u),
+					    oid_to_hex(&u->old_oid));
+			else
+				strbuf_addf(err, _("cannot lock ref '%s': "
+					    "is at %s but expected %s"),
+					    original_update_refname(u),
+					    oid_to_hex(&current_oid),
+					    oid_to_hex(&u->old_oid));
+			ret =3D -1;
+			goto done;
+		}
+
+		/*
+		 * If all of the following conditions are true:
+		 *
+		 *   - We're not about to write a symref.
+		 *   - We're not about to write a log-only entry.
+		 *   - Old and new object ID are different.
+		 *
+		 * Then we're essentially doing a no-op update that can be
+		 * skipped. This is not only for the sake of efficiency, but
+		 * also skips writing unneeded reflog entries.
+		 */
+		if ((u->type & REF_ISSYMREF) ||
+		    (u->flags & REF_LOG_ONLY) ||
+		    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid))) {
+			ret =3D queue_transaction_update(refs, tx_data, u,
+						       &current_oid, err);
+			if (ret)
+				goto done;
+		}
+	}
+
+	transaction->backend_data =3D tx_data;
+	transaction->state =3D REF_TRANSACTION_PREPARED;
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	if (ret < 0) {
+		free_transaction_data(tx_data);
+		transaction->state =3D REF_TRANSACTION_CLOSED;
+		if (!err->len)
+			strbuf_addf(err, _("reftable: transaction prepare: %s"),
+				    reftable_error_str(ret));
+	}
+	string_list_clear(&affected_refnames, 0);
+	strbuf_release(&referent);
+	strbuf_release(&head_referent);
+
+	return ret;
+}
+
+static int reftable_be_transaction_abort(struct ref_store *ref_store,
+					 struct ref_transaction *transaction,
+					 struct strbuf *err)
+{
+	struct reftable_transaction_data *tx_data =3D transaction->backend_data;
+	free_transaction_data(tx_data);
+	transaction->state =3D REF_TRANSACTION_CLOSED;
+	return 0;
+}
+
+static int transaction_update_cmp(const void *a, const void *b)
+{
+	return strcmp(((struct reftable_transaction_update *)a)->update->refname,
+		      ((struct reftable_transaction_update *)b)->update->refname);
+}
+
+static int write_transaction_table(struct reftable_writer *writer, void *c=
b_data)
+{
+	struct write_transaction_table_arg *arg =3D cb_data;
+	struct reftable_merged_table *mt =3D
+		reftable_stack_merged_table(arg->stack);
+	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
+	struct reftable_log_record *logs =3D NULL;
+	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
+	int ret =3D 0;
+
+	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	for (i =3D 0; i < arg->updates_nr; i++) {
+		struct reftable_transaction_update *tx_update =3D &arg->updates[i];
+		struct ref_update *u =3D tx_update->update;
+
+		/*
+		 * Write a reflog entry when updating a ref to point to
+		 * something new in either of the following cases:
+		 *
+		 * - The reference is about to be deleted. We always want to
+		 *   delete the reflog in that case.
+		 * - REF_FORCE_CREATE_REFLOG is set, asking us to always create
+		 *   the reflog entry.
+		 * - `core.logAllRefUpdates` tells us to create the reflog for
+		 *   the given ref.
+		 */
+		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(=
&u->new_oid)) {
+			struct reftable_log_record log =3D {0};
+			struct reftable_iterator it =3D {0};
+
+			/*
+			 * When deleting refs we also delete all reflog entries
+			 * with them. While it is not strictly required to
+			 * delete reflogs together with their refs, this
+			 * matches the behaviour of the files backend.
+			 *
+			 * Unfortunately, we have no better way than to delete
+			 * all reflog entries one by one.
+			 */
+			ret =3D reftable_merged_table_seek_log(mt, &it, u->refname);
+			while (ret =3D=3D 0) {
+				struct reftable_log_record *tombstone;
+
+				ret =3D reftable_iterator_next_log(&it, &log);
+				if (ret < 0)
+					break;
+				if (ret > 0 || strcmp(log.refname, u->refname)) {
+					ret =3D 0;
+					break;
+				}
+
+				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+				tombstone =3D &logs[logs_nr++];
+				tombstone->refname =3D xstrdup(u->refname);
+				tombstone->value_type =3D REFTABLE_LOG_DELETION;
+				tombstone->update_index =3D log.update_index;
+			}
+
+			reftable_log_record_release(&log);
+			reftable_iterator_destroy(&it);
+
+			if (ret)
+				goto done;
+		} else if (u->flags & REF_HAVE_NEW &&
+			   (u->flags & REF_FORCE_CREATE_REFLOG ||
+			    should_write_log(&arg->refs->base, u->refname))) {
+			struct reftable_log_record *log;
+
+			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+			log =3D &logs[logs_nr++];
+			memset(log, 0, sizeof(*log));
+
+			fill_reftable_log_record(log);
+			log->update_index =3D ts;
+			log->refname =3D xstrdup(u->refname);
+			log->value.update.new_hash =3D u->new_oid.hash;
+			log->value.update.old_hash =3D tx_update->current_oid.hash;
+			log->value.update.message =3D
+				xstrndup(u->msg, arg->refs->write_options.block_size / 2);
+		}
+
+		if (u->flags & REF_LOG_ONLY)
+			continue;
+
+		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
+			struct reftable_ref_record ref =3D {
+				.refname =3D (char *)u->refname,
+				.update_index =3D ts,
+				.value_type =3D REFTABLE_REF_DELETION,
+			};
+
+			ret =3D reftable_writer_add_ref(writer, &ref);
+			if (ret < 0)
+				goto done;
+		} else if (u->flags & REF_HAVE_NEW) {
+			struct reftable_ref_record ref =3D {0};
+			struct object_id peeled;
+			int peel_error;
+
+			ref.refname =3D (char *)u->refname;
+			ref.update_index =3D ts;
+
+			peel_error =3D peel_object(&u->new_oid, &peeled);
+			if (!peel_error) {
+				ref.value_type =3D REFTABLE_REF_VAL2;
+				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
+				memcpy(ref.value.val2.value, u->new_oid.hash, GIT_MAX_RAWSZ);
+			} else if (!is_null_oid(&u->new_oid)) {
+				ref.value_type =3D REFTABLE_REF_VAL1;
+				memcpy(ref.value.val1, u->new_oid.hash, GIT_MAX_RAWSZ);
+			}
+
+			ret =3D reftable_writer_add_ref(writer, &ref);
+			if (ret < 0)
+				goto done;
+		}
+	}
+
+	/*
+	 * Logs are written at the end so that we do not have intermixed ref
+	 * and log blocks.
+	 */
+	if (logs) {
+		ret =3D reftable_writer_add_logs(writer, logs, logs_nr);
+		if (ret < 0)
+			goto done;
+	}
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	for (i =3D 0; i < logs_nr; i++)
+		clear_reftable_log_record(&logs[i]);
+	free(logs);
+	return ret;
+}
+
+static int reftable_be_transaction_finish(struct ref_store *ref_store,
+					  struct ref_transaction *transaction,
+					  struct strbuf *err)
+{
+	struct reftable_transaction_data *tx_data =3D transaction->backend_data;
+	int ret =3D 0;
+
+	for (size_t i =3D 0; i < tx_data->args_nr; i++) {
+		ret =3D reftable_addition_add(tx_data->args[i].addition,
+					    write_transaction_table, &tx_data->args[i]);
+		if (ret < 0)
+			goto done;
+
+		ret =3D reftable_addition_commit(tx_data->args[i].addition);
+		if (ret < 0)
+			goto done;
+	}
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	free_transaction_data(tx_data);
+	transaction->state =3D REF_TRANSACTION_CLOSED;
+
+	if (ret) {
+		strbuf_addf(err, _("reftable: transaction failure: %s"),
+			    reftable_error_str(ret));
+		return -1;
+	}
+	return ret;
+}
+
+static int reftable_be_initial_transaction_commit(struct ref_store *ref_st=
ore UNUSED,
+						  struct ref_transaction *transaction,
+						  struct strbuf *err)
+{
+	return ref_transaction_commit(transaction, err);
+}
+
+static int reftable_be_pack_refs(struct ref_store *ref_store,
+				 struct pack_refs_opts *opts)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "pack_r=
efs");
+	struct reftable_stack *stack;
+	int ret;
+
+	if (refs->err)
+		return refs->err;
+
+	stack =3D refs->worktree_stack;
+	if (!stack)
+		stack =3D refs->main_stack;
+
+	ret =3D reftable_stack_compact_all(stack, NULL);
+	if (ret)
+		goto out;
+	ret =3D reftable_stack_clean(stack);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+struct write_create_symref_arg {
+	struct reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct reftable_writer *writer, void =
*cb_data)
+{
+	struct write_create_symref_arg *create =3D cb_data;
+	uint64_t ts =3D reftable_stack_next_update_index(create->stack);
+	struct reftable_ref_record ref =3D {
+		.refname =3D (char *)create->refname,
+		.value_type =3D REFTABLE_REF_SYMREF,
+		.value.symref =3D (char *)create->target,
+		.update_index =3D ts,
+	};
+	struct reftable_log_record log =3D {0};
+	struct object_id new_oid;
+	struct object_id old_oid;
+	int ret;
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	ret =3D reftable_writer_add_ref(writer, &ref);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note that it is important to try and resolve the reference before we
+	 * write the log entry. This is because `should_write_log()` will munge
+	 * `core.logAllRefUpdates`, which is undesirable when we create a new
+	 * repository because it would be written into the config. As HEAD will
+	 * not resolve for new repositories this ordering will ensure that this
+	 * never happens.
+	 */
+	if (!create->logmsg ||
+	    !refs_resolve_ref_unsafe(&create->refs->base, create->target,
+				     RESOLVE_REF_READING, &new_oid, NULL) ||
+	    !should_write_log(&create->refs->base, create->refname))
+		return 0;
+
+	fill_reftable_log_record(&log);
+	log.refname =3D xstrdup(create->refname);
+	log.update_index =3D ts;
+	log.value.update.message =3D xstrndup(create->logmsg,
+					    create->refs->write_options.block_size / 2);
+	log.value.update.new_hash =3D new_oid.hash;
+	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
+				    RESOLVE_REF_READING, &old_oid, NULL))
+		log.value.update.old_hash =3D old_oid.hash;
+
+	ret =3D reftable_writer_add_log(writer, &log);
+	clear_reftable_log_record(&log);
+	return ret;
+}
+
+static int reftable_be_create_symref(struct ref_store *ref_store,
+				     const char *refname,
+				     const char *target,
+				     const char *logmsg)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_symref");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct write_create_symref_arg arg =3D {
+		.refs =3D refs,
+		.stack =3D stack,
+		.refname =3D refname,
+		.target =3D target,
+		.logmsg =3D logmsg,
+	};
+	int ret;
+
+	ret =3D refs->err;
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		goto done;
+
+	ret =3D reftable_stack_add(stack, &write_create_symref_table, &arg);
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	if (ret)
+		error("unable to write symref for %s: %s", refname,
+		      reftable_error_str(ret));
+	return ret;
+}
+
+struct write_copy_arg {
+	struct reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *oldname;
+	const char *newname;
+	const char *logmsg;
+	int delete_old;
+};
+
+static int write_copy_table(struct reftable_writer *writer, void *cb_data)
+{
+	struct write_copy_arg *arg =3D cb_data;
+	uint64_t deletion_ts, creation_ts;
+	struct reftable_merged_table *mt =3D reftable_stack_merged_table(arg->sta=
ck);
+	struct reftable_ref_record old_ref =3D {0}, refs[2] =3D {0};
+	struct reftable_log_record old_log =3D {0}, *logs =3D NULL;
+	struct reftable_iterator it =3D {0};
+	struct string_list skip =3D STRING_LIST_INIT_NODUP;
+	struct strbuf errbuf =3D STRBUF_INIT;
+	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
+	int ret;
+
+	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
+		ret =3D error(_("refname %s not found"), arg->oldname);
+		goto done;
+	}
+	if (old_ref.value_type =3D=3D REFTABLE_REF_SYMREF) {
+		ret =3D error(_("refname %s is a symbolic ref, copying it is not support=
ed"),
+			    arg->oldname);
+		goto done;
+	}
+
+	/*
+	 * There's nothing to do in case the old and new name are the same, so
+	 * we exit early in that case.
+	 */
+	if (!strcmp(arg->oldname, arg->newname)) {
+		ret =3D 0;
+		goto done;
+	}
+
+	/*
+	 * Verify that the new refname is available.
+	 */
+	string_list_insert(&skip, arg->oldname);
+	ret =3D refs_verify_refname_available(&arg->refs->base, arg->newname,
+					    NULL, &skip, &errbuf);
+	if (ret < 0) {
+		error("%s", errbuf.buf);
+		goto done;
+	}
+
+	/*
+	 * When deleting the old reference we have to use two update indices:
+	 * once to delete the old ref and its reflog, and once to create the
+	 * new ref and its reflog. They need to be staged with two separate
+	 * indices because the new reflog needs to encode both the deletion of
+	 * the old branch and the creation of the new branch, and we cannot do
+	 * two changes to a reflog in a single update.
+	 */
+	deletion_ts =3D creation_ts =3D reftable_stack_next_update_index(arg->sta=
ck);
+	if (arg->delete_old)
+		creation_ts++;
+	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
+
+	/*
+	 * Add the new reference. If this is a rename then we also delete the
+	 * old reference.
+	 */
+	refs[0] =3D old_ref;
+	refs[0].refname =3D (char *)arg->newname;
+	refs[0].update_index =3D creation_ts;
+	if (arg->delete_old) {
+		refs[1].refname =3D (char *)arg->oldname;
+		refs[1].value_type =3D REFTABLE_REF_DELETION;
+		refs[1].update_index =3D deletion_ts;
+	}
+	ret =3D reftable_writer_add_refs(writer, refs, arg->delete_old ? 2 : 1);
+	if (ret < 0)
+		goto done;
+
+	/*
+	 * When deleting the old branch we need to create a reflog entry on the
+	 * new branch name that indicates that the old branch has been deleted
+	 * and then recreated. This is a tad weird, but matches what the files
+	 * backend does.
+	 */
+	if (arg->delete_old) {
+		struct strbuf head_referent =3D STRBUF_INIT;
+		struct object_id head_oid;
+		int append_head_reflog;
+		unsigned head_type =3D 0;
+
+		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
+		fill_reftable_log_record(&logs[logs_nr]);
+		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].update_index =3D deletion_ts;
+		logs[logs_nr].value.update.message =3D
+			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
+		logs[logs_nr].value.update.old_hash =3D old_ref.value.val1;
+		logs_nr++;
+
+		ret =3D read_ref_without_reload(arg->stack, "HEAD", &head_oid, &head_ref=
erent, &head_type);
+		if (ret < 0)
+			goto done;
+		append_head_reflog =3D (head_type & REF_ISSYMREF) && !strcmp(head_refere=
nt.buf, arg->oldname);
+		strbuf_release(&head_referent);
+
+		/*
+		 * The files backend uses `refs_delete_ref()` to delete the old
+		 * branch name, which will append a reflog entry for HEAD in
+		 * case it points to the old branch.
+		 */
+		if (append_head_reflog) {
+			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+			logs[logs_nr] =3D logs[logs_nr - 1];
+			logs[logs_nr].refname =3D "HEAD";
+			logs_nr++;
+		}
+	}
+
+	/*
+	 * Create the reflog entry for the newly created branch.
+	 */
+	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
+	fill_reftable_log_record(&logs[logs_nr]);
+	logs[logs_nr].refname =3D (char *)arg->newname;
+	logs[logs_nr].update_index =3D creation_ts;
+	logs[logs_nr].value.update.message =3D
+		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
+	logs[logs_nr].value.update.new_hash =3D old_ref.value.val1;
+	logs_nr++;
+
+	/*
+	 * In addition to writing the reflog entry for the new branch, we also
+	 * copy over all log entries from the old reflog. Last but not least,
+	 * when renaming we also have to delete all the old reflog entries.
+	 */
+	ret =3D reftable_merged_table_seek_log(mt, &it, arg->oldname);
+	if (ret < 0)
+		return ret;
+
+	while (1) {
+		ret =3D reftable_iterator_next_log(&it, &old_log);
+		if (ret < 0)
+			goto done;
+		if (ret > 0 || strcmp(old_log.refname, arg->oldname)) {
+			ret =3D 0;
+			break;
+		}
+
+		free(old_log.refname);
+
+		/*
+		 * Copy over the old reflog entry with the new refname.
+		 */
+		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+		logs[logs_nr] =3D old_log;
+		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs_nr++;
+
+		/*
+		 * Delete the old reflog entry in case we are renaming.
+		 */
+		if (arg->delete_old) {
+			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
+			logs[logs_nr].refname =3D (char *)arg->oldname;
+			logs[logs_nr].value_type =3D REFTABLE_LOG_DELETION;
+			logs[logs_nr].update_index =3D old_log.update_index;
+			logs_nr++;
+		}
+
+		/*
+		 * Transfer ownership of the log record we're iterating over to
+		 * the array of log records. Otherwise, the pointers would get
+		 * free'd or reallocated by the iterator.
+		 */
+		memset(&old_log, 0, sizeof(old_log));
+	}
+
+	ret =3D reftable_writer_add_logs(writer, logs, logs_nr);
+	if (ret < 0)
+		goto done;
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	reftable_iterator_destroy(&it);
+	string_list_clear(&skip, 0);
+	strbuf_release(&errbuf);
+	for (i =3D 0; i < logs_nr; i++) {
+		if (!strcmp(logs[i].refname, "HEAD"))
+			continue;
+		if (logs[i].value.update.old_hash =3D=3D old_ref.value.val1)
+			logs[i].value.update.old_hash =3D NULL;
+		if (logs[i].value.update.new_hash =3D=3D old_ref.value.val1)
+			logs[i].value.update.new_hash =3D NULL;
+		logs[i].refname =3D NULL;
+		reftable_log_record_release(&logs[i]);
+	}
+	free(logs);
+	reftable_ref_record_release(&old_ref);
+	reftable_log_record_release(&old_log);
+	return ret;
+}
+
+static int reftable_be_rename_ref(struct ref_store *ref_store,
+				  const char *oldrefname,
+				  const char *newrefname,
+				  const char *logmsg)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
+	struct reftable_stack *stack =3D stack_for(refs, newrefname, &newrefname);
+	struct write_copy_arg arg =3D {
+		.refs =3D refs,
+		.stack =3D stack,
+		.oldname =3D oldrefname,
+		.newname =3D newrefname,
+		.logmsg =3D logmsg,
+		.delete_old =3D 1,
+	};
+	int ret;
+
+	ret =3D refs->err;
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		goto done;
+	ret =3D reftable_stack_add(stack, &write_copy_table, &arg);
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	return ret;
+}
+
+static int reftable_be_copy_ref(struct ref_store *ref_store,
+				const char *oldrefname,
+				const char *newrefname,
+				const char *logmsg)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
+	struct reftable_stack *stack =3D stack_for(refs, newrefname, &newrefname);
+	struct write_copy_arg arg =3D {
+		.refs =3D refs,
+		.stack =3D stack,
+		.oldname =3D oldrefname,
+		.newname =3D newrefname,
+		.logmsg =3D logmsg,
+	};
+	int ret;
+
+	ret =3D refs->err;
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		goto done;
+	ret =3D reftable_stack_add(stack, &write_copy_table, &arg);
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	return ret;
+}
+
+struct reftable_reflog_iterator {
+	struct ref_iterator base;
+	struct reftable_ref_store *refs;
+	struct reftable_iterator iter;
+	struct reftable_log_record log;
+	struct object_id oid;
+	char *last_name;
+	int err;
+};
+
+static int reftable_reflog_iterator_advance(struct ref_iterator *ref_itera=
tor)
+{
+	struct reftable_reflog_iterator *iter =3D
+		(struct reftable_reflog_iterator *)ref_iterator;
+
+	while (!iter->err) {
+		int flags;
+
+		iter->err =3D reftable_iterator_next_log(&iter->iter, &iter->log);
+		if (iter->err)
+			break;
+
+		/*
+		 * We want the refnames that we have reflogs for, so we skip if
+		 * we've already produced this name. This could be faster by
+		 * seeking directly to reflog@update_index=3D=3D0.
+		 */
+		if (iter->last_name && !strcmp(iter->log.refname, iter->last_name))
+			continue;
+
+		if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->log.refname,
+					     0, &iter->oid, &flags)) {
+			error(_("bad ref for %s"), iter->log.refname);
+			continue;
+		}
+
+		free(iter->last_name);
+		iter->last_name =3D xstrdup(iter->log.refname);
+		iter->base.refname =3D iter->log.refname;
+		iter->base.oid =3D &iter->oid;
+		iter->base.flags =3D flags;
+
+		break;
+	}
+
+	if (iter->err > 0) {
+		if (ref_iterator_abort(ref_iterator) !=3D ITER_DONE)
+			return ITER_ERROR;
+		return ITER_DONE;
+	}
+
+	if (iter->err < 0) {
+		ref_iterator_abort(ref_iterator);
+		return ITER_ERROR;
+	}
+
+	return ITER_OK;
+}
+
+static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator,
+						 struct object_id *peeled)
+{
+	BUG("reftable reflog iterator cannot be peeled");
+	return -1;
+}
+
+static int reftable_reflog_iterator_abort(struct ref_iterator *ref_iterato=
r)
+{
+	struct reftable_reflog_iterator *iter =3D
+		(struct reftable_reflog_iterator *)ref_iterator;
+	reftable_log_record_release(&iter->log);
+	reftable_iterator_destroy(&iter->iter);
+	free(iter->last_name);
+	free(iter);
+	return ITER_DONE;
+}
+
+static struct ref_iterator_vtable reftable_reflog_iterator_vtable =3D {
+	.advance =3D reftable_reflog_iterator_advance,
+	.peel =3D reftable_reflog_iterator_peel,
+	.abort =3D reftable_reflog_iterator_abort
+};
+
+static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct r=
eftable_ref_store *refs,
+								  struct reftable_stack *stack)
+{
+	struct reftable_merged_table *merged_table;
+	struct reftable_reflog_iterator *iter;
+	int ret;
+
+	iter =3D xcalloc(1, sizeof(*iter));
+	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable, 1);
+	iter->refs =3D refs;
+	iter->base.oid =3D &iter->oid;
+
+	ret =3D refs->err;
+	if (ret)
+		goto done;
+
+	ret =3D reftable_stack_reload(refs->main_stack);
+	if (ret < 0)
+		goto done;
+
+	merged_table =3D reftable_stack_merged_table(stack);
+
+	ret =3D reftable_merged_table_seek_log(merged_table, &iter->iter, "");
+	if (ret < 0)
+		goto done;
+
+done:
+	iter->err =3D ret;
+	return iter;
+}
+
+static struct ref_iterator *reftable_be_reflog_iterator_begin(struct ref_s=
tore *ref_store)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_iterator_begin");
+	struct reftable_reflog_iterator *main_iter, *worktree_iter;
+
+	main_iter =3D reflog_iterator_for_stack(refs, refs->main_stack);
+	if (!refs->worktree_stack)
+		return &main_iter->base;
+
+	worktree_iter =3D reflog_iterator_for_stack(refs, refs->worktree_stack);
+
+	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
+					iterator_select, NULL);
+}
+
+static int yield_log_record(struct reftable_log_record *log,
+			    each_reflog_ent_fn fn,
+			    void *cb_data)
+{
+	struct object_id old_oid, new_oid;
+	const char *full_committer;
+
+	oidread(&old_oid, log->value.update.old_hash);
+	oidread(&new_oid, log->value.update.new_hash);
+
+	/*
+	 * When both the old object ID and the new object ID are null
+	 * then this is the reflog existence marker. The caller must
+	 * not be aware of it.
+	 */
+	if (is_null_oid(&old_oid) && is_null_oid(&new_oid))
+		return 0;
+
+	full_committer =3D fmt_ident(log->value.update.name, log->value.update.em=
ail,
+				   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
+	return fn(&old_oid, &new_oid, full_committer,
+		  log->value.update.time, log->value.update.tz_offset,
+		  log->value.update.message, cb_data);
+}
+
+static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_s=
tore,
+						   const char *refname,
+						   each_reflog_ent_fn fn,
+						   void *cb_data)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_rev=
erse");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct reftable_merged_table *mt =3D NULL;
+	struct reftable_log_record log =3D {0};
+	struct reftable_iterator it =3D {0};
+	int ret;
+
+	if (refs->err < 0)
+		return refs->err;
+
+	mt =3D reftable_stack_merged_table(stack);
+	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	while (!ret) {
+		ret =3D reftable_iterator_next_log(&it, &log);
+		if (ret < 0)
+			break;
+		if (ret > 0 || strcmp(log.refname, refname)) {
+			ret =3D 0;
+			break;
+		}
+
+		ret =3D yield_log_record(&log, fn, cb_data);
+		if (ret)
+			break;
+	}
+
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return ret;
+}
+
+static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
+					   const char *refname,
+					   each_reflog_ent_fn fn,
+					   void *cb_data)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct reftable_merged_table *mt =3D NULL;
+	struct reftable_log_record *logs =3D NULL;
+	struct reftable_iterator it =3D {0};
+	size_t logs_alloc =3D 0, logs_nr =3D 0, i;
+	int ret;
+
+	if (refs->err < 0)
+		return refs->err;
+
+	mt =3D reftable_stack_merged_table(stack);
+	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	while (!ret) {
+		struct reftable_log_record log =3D {0};
+
+		ret =3D reftable_iterator_next_log(&it, &log);
+		if (ret < 0)
+			goto done;
+		if (ret > 0 || strcmp(log.refname, refname)) {
+			reftable_log_record_release(&log);
+			ret =3D 0;
+			break;
+		}
+
+		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+		logs[logs_nr++] =3D log;
+	}
+
+	for (i =3D logs_nr; i--;) {
+		ret =3D yield_log_record(&logs[i], fn, cb_data);
+		if (ret)
+			goto done;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	for (i =3D 0; i < logs_nr; i++)
+		reftable_log_record_release(&logs[i]);
+	free(logs);
+	return ret;
+}
+
+static int reftable_be_reflog_exists(struct ref_store *ref_store,
+				     const char *refname)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct reftable_merged_table *mt =3D reftable_stack_merged_table(stack);
+	struct reftable_log_record log =3D {0};
+	struct reftable_iterator it =3D {0};
+	int ret;
+
+	ret =3D refs->err;
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	if (ret < 0)
+		goto done;
+
+	/*
+	 * Check whether we get at least one log record for the given ref name.
+	 * If so, the reflog exists, otherwise it doesn't.
+	 */
+	ret =3D reftable_iterator_next_log(&it, &log);
+	if (ret < 0)
+		goto done;
+	if (ret > 0) {
+		ret =3D 0;
+		goto done;
+	}
+
+	ret =3D strcmp(log.refname, refname) =3D=3D 0;
+
+done:
+	reftable_iterator_destroy(&it);
+	reftable_log_record_release(&log);
+	if (ret < 0)
+		ret =3D 0;
+	return ret;
+}
+
+struct write_reflog_existence_arg {
+	struct reftable_ref_store *refs;
+	const char *refname;
+	struct reftable_stack *stack;
+};
+
+static int write_reflog_existence_table(struct reftable_writer *writer,
+					void *cb_data)
+{
+	struct write_reflog_existence_arg *arg =3D cb_data;
+	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
+	struct reftable_log_record log =3D {0};
+	int ret;
+
+	ret =3D reftable_stack_read_log(arg->stack, arg->refname, &log);
+	if (ret <=3D 0)
+		goto done;
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	/*
+	 * The existence entry has both old and new object ID set to the the
+	 * null object ID. Our iterators are aware of this and will not present
+	 * them to their callers.
+	 */
+	log.refname =3D xstrdup(arg->refname);
+	log.update_index =3D ts;
+	log.value_type =3D REFTABLE_LOG_UPDATE;
+	ret =3D reftable_writer_add_log(writer, &log);
+
+done:
+	assert(ret !=3D REFTABLE_API_ERROR);
+	reftable_log_record_release(&log);
+	return ret;
+}
+
+static int reftable_be_create_reflog(struct ref_store *ref_store,
+				     const char *refname,
+				     struct strbuf *errmsg)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct write_reflog_existence_arg arg =3D {
+		.refs =3D refs,
+		.stack =3D stack,
+		.refname =3D refname,
+	};
+	int ret;
+
+	ret =3D refs->err;
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		goto done;
+
+	ret =3D reftable_stack_add(stack, &write_reflog_existence_table, &arg);
+
+done:
+	return ret;
+}
+
+struct write_reflog_delete_arg {
+	struct reftable_stack *stack;
+	const char *refname;
+};
+
+static int write_reflog_delete_table(struct reftable_writer *writer, void =
*cb_data)
+{
+	struct write_reflog_delete_arg *arg =3D cb_data;
+	struct reftable_merged_table *mt =3D
+		reftable_stack_merged_table(arg->stack);
+	struct reftable_log_record log =3D {0}, tombstone =3D {0};
+	struct reftable_iterator it =3D {0};
+	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
+	int ret;
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	/*
+	 * In order to delete a table we need to delete all reflog entries one
+	 * by one. This is inefficient, but the reftable format does not have a
+	 * better marker right now.
+	 */
+	ret =3D reftable_merged_table_seek_log(mt, &it, arg->refname);
+	while (ret =3D=3D 0) {
+		ret =3D reftable_iterator_next_log(&it, &log);
+		if (ret < 0)
+			break;
+		if (ret > 0 || strcmp(log.refname, arg->refname)) {
+			ret =3D 0;
+			break;
+		}
+
+		tombstone.refname =3D (char *)arg->refname;
+		tombstone.value_type =3D REFTABLE_LOG_DELETION;
+		tombstone.update_index =3D log.update_index;
+
+		ret =3D reftable_writer_add_log(writer, &tombstone);
+	}
+
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return ret;
+}
+
+static int reftable_be_delete_reflog(struct ref_store *ref_store,
+				     const char *refname)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct write_reflog_delete_arg arg =3D {
+		.stack =3D stack,
+		.refname =3D refname,
+	};
+	int ret;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret)
+		return ret;
+	ret =3D reftable_stack_add(stack, &write_reflog_delete_table, &arg);
+
+	assert(ret !=3D REFTABLE_API_ERROR);
+	return ret;
+}
+
+struct reflog_expiry_arg {
+	struct reftable_stack *stack;
+	struct reftable_log_record *records;
+	struct object_id update_oid;
+	const char *refname;
+	size_t len;
+};
+
+static int write_reflog_expiry_table(struct reftable_writer *writer, void =
*cb_data)
+{
+	struct reflog_expiry_arg *arg =3D cb_data;
+	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
+	uint64_t live_records =3D 0;
+	size_t i;
+	int ret;
+
+	for (i =3D 0; i < arg->len; i++)
+		if (arg->records[i].value_type =3D=3D REFTABLE_LOG_UPDATE)
+			live_records++;
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	if (!is_null_oid(&arg->update_oid)) {
+		struct reftable_ref_record ref =3D {0};
+		struct object_id peeled;
+
+		ref.refname =3D (char *)arg->refname;
+		ref.update_index =3D ts;
+
+		if (!peel_object(&arg->update_oid, &peeled)) {
+			ref.value_type =3D REFTABLE_REF_VAL2;
+			memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
+			memcpy(ref.value.val2.value, arg->update_oid.hash, GIT_MAX_RAWSZ);
+		} else {
+			ref.value_type =3D REFTABLE_REF_VAL1;
+			memcpy(ref.value.val1, arg->update_oid.hash, GIT_MAX_RAWSZ);
+		}
+
+		ret =3D reftable_writer_add_ref(writer, &ref);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * When there are no more entries left in the reflog we empty it
+	 * completely, but write a placeholder reflog entry that indicates that
+	 * the reflog still exists.
+	 */
+	if (!live_records) {
+		struct reftable_log_record log =3D {
+			.refname =3D (char *)arg->refname,
+			.value_type =3D REFTABLE_LOG_UPDATE,
+			.update_index =3D ts,
+		};
+
+		ret =3D reftable_writer_add_log(writer, &log);
+		if (ret)
+			return ret;
+	}
+
+	for (i =3D 0; i < arg->len; i++) {
+		ret =3D reftable_writer_add_log(writer, &arg->records[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int reftable_be_reflog_expire(struct ref_store *ref_store,
+				     const char *refname,
+				     unsigned int flags,
+				     reflog_expiry_prepare_fn prepare_fn,
+				     reflog_expiry_should_prune_fn should_prune_fn,
+				     reflog_expiry_cleanup_fn cleanup_fn,
+				     void *policy_cb_data)
+{
+	/*
+	 * For log expiry, we write tombstones for every single reflog entry
+	 * that is to be expired. This means that the entries are still
+	 * retrievable by delving into the stack, and expiring entries
+	 * paradoxically takes extra memory. This memory is only reclaimed when
+	 * compacting the reftable stack.
+	 *
+	 * It would be better if the refs backend supported an API that sets a
+	 * criterion for all refs, passing the criterion to pack_refs().
+	 *
+	 * On the plus side, because we do the expiration per ref, we can easily
+	 * insert the reflog existence dummies.
+	 */
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
+	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct reftable_merged_table *mt =3D reftable_stack_merged_table(stack);
+	struct reftable_log_record *logs =3D NULL;
+	struct reftable_log_record *rewritten =3D NULL;
+	struct reftable_ref_record ref_record =3D {0};
+	struct reftable_iterator it =3D {0};
+	struct reftable_addition *add =3D NULL;
+	struct reflog_expiry_arg arg =3D {0};
+	struct object_id oid =3D {0};
+	uint8_t *last_hash =3D NULL;
+	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
+	int ret;
+
+	if (refs->err < 0)
+		return refs->err;
+
+	ret =3D reftable_stack_reload(stack);
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_new_addition(&add, stack);
+	if (ret < 0)
+		goto done;
+
+	ret =3D reftable_stack_read_ref(stack, refname, &ref_record);
+	if (ret < 0)
+		goto done;
+	if (reftable_ref_record_val1(&ref_record))
+		oidread(&oid, reftable_ref_record_val1(&ref_record));
+	prepare_fn(refname, &oid, policy_cb_data);
+
+	while (1) {
+		struct reftable_log_record log =3D {0};
+		struct object_id old_oid, new_oid;
+
+		ret =3D reftable_iterator_next_log(&it, &log);
+		if (ret < 0)
+			goto done;
+		if (ret > 0 || strcmp(log.refname, refname)) {
+			reftable_log_record_release(&log);
+			break;
+		}
+
+		oidread(&old_oid, log.value.update.old_hash);
+		oidread(&new_oid, log.value.update.new_hash);
+
+		/*
+		 * Skip over the reflog existence marker. We will add it back
+		 * in when there are no live reflog records.
+		 */
+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
+
+		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+		logs[logs_nr++] =3D log;
+	}
+
+	/*
+	 * We need to rewrite all reflog entries according to the pruning
+	 * callback function:
+	 *
+	 *   - If a reflog entry shall be pruned we mark the record for
+	 *     deletion.
+	 *
+	 *   - Otherwise we may have to rewrite the chain of reflog entries so
+	 *     that gaps created by just-deleted records get backfilled.
+	 */
+	CALLOC_ARRAY(rewritten, logs_nr);
+	for (i =3D logs_nr; i--;) {
+		struct reftable_log_record *dest =3D &rewritten[i];
+		struct object_id old_oid, new_oid;
+
+		*dest =3D logs[i];
+		oidread(&old_oid, logs[i].value.update.old_hash);
+		oidread(&new_oid, logs[i].value.update.new_hash);
+
+		if (should_prune_fn(&old_oid, &new_oid, logs[i].value.update.email,
+				    (timestamp_t)logs[i].value.update.time,
+				    logs[i].value.update.tz_offset,
+				    logs[i].value.update.message,
+				    policy_cb_data)) {
+			dest->value_type =3D REFTABLE_LOG_DELETION;
+		} else {
+			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
+				dest->value.update.old_hash =3D last_hash;
+			last_hash =3D logs[i].value.update.new_hash;
+		}
+	}
+
+	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
+	    reftable_ref_record_val1(&ref_record))
+		oidread(&arg.update_oid, last_hash);
+
+	arg.records =3D rewritten;
+	arg.len =3D logs_nr;
+	arg.stack =3D stack,
+	arg.refname =3D refname,
+
+	ret =3D reftable_addition_add(add, &write_reflog_expiry_table, &arg);
+	if (ret < 0)
+		goto done;
+
+	/*
+	 * Future improvement: we could skip writing records that were
+	 * not changed.
+	 */
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN))
+		ret =3D reftable_addition_commit(add);
+
+done:
+	if (add)
+		cleanup_fn(policy_cb_data);
+	assert(ret !=3D REFTABLE_API_ERROR);
+
+	reftable_ref_record_release(&ref_record);
+	reftable_iterator_destroy(&it);
+	reftable_addition_destroy(add);
+	for (i =3D 0; i < logs_nr; i++)
+		reftable_log_record_release(&logs[i]);
+	free(logs);
+	free(rewritten);
+	return ret;
+}
+
+struct ref_storage_be refs_be_reftable =3D {
+	.name =3D "reftable",
+	.init =3D reftable_be_init,
+	.init_db =3D reftable_be_init_db,
+	.transaction_prepare =3D reftable_be_transaction_prepare,
+	.transaction_finish =3D reftable_be_transaction_finish,
+	.transaction_abort =3D reftable_be_transaction_abort,
+	.initial_transaction_commit =3D reftable_be_initial_transaction_commit,
+
+	.pack_refs =3D reftable_be_pack_refs,
+	.create_symref =3D reftable_be_create_symref,
+	.rename_ref =3D reftable_be_rename_ref,
+	.copy_ref =3D reftable_be_copy_ref,
+
+	.iterator_begin =3D reftable_be_iterator_begin,
+	.read_raw_ref =3D reftable_be_read_raw_ref,
+	.read_symbolic_ref =3D reftable_be_read_symbolic_ref,
+
+	.reflog_iterator_begin =3D reftable_be_reflog_iterator_begin,
+	.for_each_reflog_ent =3D reftable_be_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse =3D reftable_be_for_each_reflog_ent_reverse,
+	.reflog_exists =3D reftable_be_reflog_exists,
+	.create_reflog =3D reftable_be_create_reflog,
+	.delete_reflog =3D reftable_be_delete_reflog,
+	.reflog_expire =3D reftable_be_reflog_expire,
+};
diff --git a/repository.h b/repository.h
index 7a250a6605..1645cef518 100644
--- a/repository.h
+++ b/repository.h
@@ -24,8 +24,9 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
=20
-#define REF_STORAGE_FORMAT_UNKNOWN 0
-#define REF_STORAGE_FORMAT_FILES   1
+#define REF_STORAGE_FORMAT_UNKNOWN  0
+#define REF_STORAGE_FORMAT_FILES    1
+#define REF_STORAGE_FORMAT_REFTABLE 2
=20
 struct repo_settings {
 	int initialized;
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
new file mode 100755
index 0000000000..6a131e40b8
--- /dev/null
+++ b/t/t0610-reftable-basics.sh
@@ -0,0 +1,887 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Google LLC
+#
+
+test_description=3D'reftable basics'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+if ! test_have_prereq REFTABLE
+then
+	skip_all=3D'skipping reftable tests; set GIT_TEST_DEFAULT_REF_FORMAT=3Dre=
ftable'
+	test_done
+fi
+
+INVALID_OID=3D$(test_oid 001)
+
+test_expect_success 'init: creates basic reftable structures' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_path_is_dir repo/.git/reftable &&
+	test_path_is_file repo/.git/reftable/tables.list &&
+	echo reftable >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init: sha256 object format via environment variable' '
+	test_when_finished "rm -rf repo" &&
+	GIT_DEFAULT_HASH=3Dsha256 git init repo &&
+	cat >expect <<-EOF &&
+	sha256
+	reftable
+	EOF
+	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init: sha256 object format via option' '
+	test_when_finished "rm -rf repo" &&
+	git init --object-format=3Dsha256 repo &&
+	cat >expect <<-EOF &&
+	sha256
+	reftable
+	EOF
+	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init: reinitializing reftable backend succeeds' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo for-each-ref >expect &&
+	git init --ref-format=3Dreftable repo &&
+	git -C repo for-each-ref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init: reinitializing files with reftable backend fail=
s' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=3Dfiles repo &&
+	test_commit -C repo file &&
+
+	cp repo/.git/HEAD expect &&
+	test_must_fail git init --ref-format=3Dreftable repo &&
+	test_cmp expect repo/.git/HEAD
+'
+
+test_expect_success 'init: reinitializing reftable with files backend fail=
s' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=3Dreftable repo &&
+	test_commit -C repo file &&
+
+	cp repo/.git/HEAD expect &&
+	test_must_fail git init --ref-format=3Dfiles repo &&
+	test_cmp expect repo/.git/HEAD
+'
+
+test_expect_perms () {
+	local perms=3D"$1"
+	local file=3D"$2"
+	local actual=3D$(ls -l "$file") &&
+
+	case "$actual" in
+	$perms*)
+		: happy
+		;;
+	*)
+		echo "$(basename $2) is not $perms but $actual"
+		false
+		;;
+	esac
+}
+
+for umask in 002 022
+do
+	test_expect_success POSIXPERM 'init: honors core.sharedRepository' '
+		test_when_finished "rm -rf repo" &&
+		(
+			umask $umask &&
+			git init --shared=3Dtrue repo &&
+			test 1 =3D "$(git -C repo config core.sharedrepository)"
+		) &&
+		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
+		for table in repo/.git/reftable/*.ref
+		do
+			test_expect_perms "-rw-rw-r--" "$table" ||
+			return 1
+		done
+	'
+done
+
+test_expect_success 'clone: can clone reftable repository' '
+	test_when_finished "rm -rf repo clone" &&
+	git init repo &&
+	test_commit -C repo message1 file1 &&
+
+	git clone repo cloned &&
+	echo reftable >expect &&
+	git -C cloned rev-parse --show-ref-format >actual &&
+	test_cmp expect actual &&
+	test_path_is_file cloned/file1
+'
+
+test_expect_success 'clone: can clone reffiles into reftable repository' '
+	test_when_finished "rm -rf reffiles reftable" &&
+	git init --ref-format=3Dfiles reffiles &&
+	test_commit -C reffiles A &&
+	git clone --ref-format=3Dreftable ./reffiles reftable &&
+
+	git -C reffiles rev-parse HEAD >expect &&
+	git -C reftable rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+
+	git -C reftable rev-parse --show-ref-format >actual &&
+	echo reftable >expect &&
+	test_cmp expect actual &&
+
+	git -C reffiles rev-parse --show-ref-format >actual &&
+	echo files >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone: can clone reftable into reffiles repository' '
+	test_when_finished "rm -rf reffiles reftable" &&
+	git init --ref-format=3Dreftable reftable &&
+	test_commit -C reftable A &&
+	git clone --ref-format=3Dfiles ./reftable reffiles &&
+
+	git -C reftable rev-parse HEAD >expect &&
+	git -C reffiles rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+
+	git -C reftable rev-parse --show-ref-format >actual &&
+	echo reftable >expect &&
+	test_cmp expect actual &&
+
+	git -C reffiles rev-parse --show-ref-format >actual &&
+	echo files >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ref transaction: corrupted tables cause failure' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file1 &&
+		for f in .git/reftable/*.ref
+		do
+			: >"$f" || return 1
+		done &&
+		test_must_fail git update-ref refs/heads/main HEAD
+	)
+'
+
+test_expect_success 'ref transaction: corrupted tables.list cause failure'=
 '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file1 &&
+		echo garbage >.git/reftable/tables.list &&
+		test_must_fail git update-ref refs/heads/main HEAD
+	)
+'
+
+test_expect_success 'ref transaction: refuses to write ref causing F/D con=
flict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo file &&
+	test_must_fail git -C repo update-ref refs/heads/main/forbidden
+'
+
+test_expect_success 'ref transaction: deleting ref with invalid name fails=
' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo file &&
+	test_must_fail git -C repo update-ref -d ../../my-private-file
+'
+
+test_expect_success 'ref transaction: can skip object ID verification' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_must_fail test-tool -C repo ref-store main update-ref msg refs/heads=
/branch $INVALID_OID $ZERO_OID 0 &&
+	test-tool -C repo ref-store main update-ref msg refs/heads/branch $INVALI=
D_OID $ZERO_OID REF_SKIP_OID_VERIFICATION
+'
+
+test_expect_success 'ref transaction: updating same ref multiple times fai=
ls' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	cat >updates <<-EOF &&
+	update refs/heads/main $A
+	update refs/heads/main $A
+	EOF
+	cat >expect <<-EOF &&
+	fatal: multiple updates for ref ${SQ}refs/heads/main${SQ} not allowed
+	EOF
+	test_must_fail git -C repo update-ref --stdin <updates 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'ref transaction: can delete symbolic self-reference w=
ith git-symbolic-ref(1)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -C repo symbolic-ref refs/heads/self refs/heads/self &&
+	git -C repo symbolic-ref -d refs/heads/self
+'
+
+test_expect_success 'ref transaction: deleting symbolic self-reference wit=
hout --no-deref fails' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -C repo symbolic-ref refs/heads/self refs/heads/self &&
+	cat >expect <<-EOF &&
+	error: multiple updates for ${SQ}refs/heads/self${SQ} (including one via =
symref ${SQ}refs/heads/self${SQ}) are not allowed
+	EOF
+	test_must_fail git -C repo update-ref -d refs/heads/self 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'ref transaction: deleting symbolic self-reference wit=
h --no-deref succeeds' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -C repo symbolic-ref refs/heads/self refs/heads/self &&
+	git -C repo update-ref -d --no-deref refs/heads/self
+'
+
+test_expect_success 'ref transaction: creating symbolic ref fails with F/D=
 conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	cat >expect <<-EOF &&
+	error: unable to write symref for refs/heads: file/directory conflict
+	EOF
+	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'ref transaction: ref deletion' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file &&
+		HEAD_OID=3D$(git show-ref -s --verify HEAD) &&
+		cat >expect <<-EOF &&
+		$HEAD_OID refs/heads/main
+		$HEAD_OID refs/tags/file
+		EOF
+		git show-ref >actual &&
+		test_cmp expect actual &&
+
+		test_must_fail git update-ref -d refs/tags/file $INVALID_OID &&
+		git show-ref >actual &&
+		test_cmp expect actual &&
+
+		git update-ref -d refs/tags/file $HEAD_OID &&
+		echo "$HEAD_OID refs/heads/main" >expect &&
+		git show-ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ref transaction: writes cause auto-compaction' '
+	test_when_finished "rm -rf repo" &&
+
+	git init repo &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list &&
+
+	test_commit -C repo --no-tag A &&
+	test_line_count =3D 2 repo/.git/reftable/tables.list &&
+
+	test_commit -C repo --no-tag B &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list
+'
+
+check_fsync_events () {
+	local trace=3D"$1" &&
+	shift &&
+
+	cat >expect &&
+	sed -n \
+		-e '/^{"event":"counter",.*"category":"fsync",/ {
+			s/.*"category":"fsync",//;
+			s/}$//;
+			p;
+		}' \
+		<"$trace" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ref transaction: writes are synced' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo initial &&
+
+	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
+	GIT_TEST_FSYNC=3Dtrue \
+		git -C repo -c core.fsync=3Dreference \
+		-c core.fsyncMethod=3Dfsync update-ref refs/heads/branch HEAD &&
+	check_fsync_events trace2.txt <<-EOF
+	"name":"hardware-flush","count":2
+	EOF
+'
+
+test_expect_success 'pack-refs: compacts tables' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+
+	test_commit -C repo A &&
+	ls -1 repo/.git/reftable >table-files &&
+	test_line_count =3D 4 table-files &&
+	test_line_count =3D 3 repo/.git/reftable/tables.list &&
+
+	git -C repo pack-refs &&
+	ls -1 repo/.git/reftable >table-files &&
+	test_line_count =3D 2 table-files &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'pack-refs: prunes stale tables' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	touch repo/.git/reftable/stale-table.ref &&
+	git -C repo pack-refs &&
+	test_path_is_missing repo/.git/reftable/stable-ref.ref
+'
+
+test_expect_success 'pack-refs: does not prune non-table files' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	touch repo/.git/reftable/garbage &&
+	git -C repo pack-refs &&
+	test_path_is_file repo/.git/reftable/garbage
+'
+
+for umask in 002 022
+do
+	test_expect_success POSIXPERM 'pack-refs: honors core.sharedRepository' '
+		test_when_finished "rm -rf repo" &&
+		(
+			umask $umask &&
+			git init --shared=3Dtrue repo &&
+			test_commit -C repo A &&
+			test_line_count =3D 3 repo/.git/reftable/tables.list
+		) &&
+		git -C repo pack-refs &&
+		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
+		for table in repo/.git/reftable/*.ref
+		do
+			test_expect_perms "-rw-rw-r--" "$table" ||
+			return 1
+		done
+	'
+done
+
+test_expect_success 'packed-refs: writes are synced' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo initial &&
+	test_line_count =3D 2 table-files &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
+	GIT_TEST_FSYNC=3Dtrue \
+		git -C repo -c core.fsync=3Dreference \
+		-c core.fsyncMethod=3Dfsync pack-refs &&
+	check_fsync_events trace2.txt <<-EOF
+	"name":"hardware-flush","count":2
+	EOF
+'
+
+test_expect_success 'ref iterator: bogus names are flagged' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit --no-tag file &&
+		test-tool ref-store main update-ref msg "refs/heads/bogus..name" $(git r=
ev-parse HEAD) $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+
+		cat >expect <<-EOF &&
+		$ZERO_OID refs/heads/bogus..name 0xc
+		$(git rev-parse HEAD) refs/heads/main 0x0
+		EOF
+		test-tool ref-store main for-each-ref "" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ref iterator: missing object IDs are not flagged' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test-tool ref-store main update-ref msg "refs/heads/broken-hash" $INVALI=
D_OID $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+
+		cat >expect <<-EOF &&
+		$INVALID_OID refs/heads/broken-hash 0x0
+		EOF
+		test-tool ref-store main for-each-ref "" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'basic: commit and list refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo file &&
+	test_write_lines refs/heads/main refs/tags/file >expect &&
+	git -C repo for-each-ref --format=3D"%(refname)" >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'basic: can write large commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	perl -e "
+		print \"this is a long commit message\" x 50000
+	" >commit-msg &&
+	git -C repo commit --allow-empty --file=3D../commit-msg
+'
+
+test_expect_success 'basic: show-ref fails with empty repository' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_must_fail git -C repo show-ref >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'basic: can check out unborn branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -C repo checkout -b main
+'
+
+test_expect_success 'basic: peeled tags are stored' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo file &&
+	git -C repo tag -m "annotated tag" test_tag HEAD &&
+	for ref in refs/heads/main refs/tags/file refs/tags/test_tag refs/tags/te=
st_tag^{}
+	do
+		echo "$(git -C repo rev-parse "$ref") $ref" || return 1
+	done >expect &&
+	git -C repo show-ref -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basic: for-each-ref can print symrefs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file &&
+		git branch &&
+		git symbolic-ref refs/heads/sym refs/heads/main &&
+		cat >expected <<-EOF &&
+		refs/heads/main
+		EOF
+		git for-each-ref --format=3D"%(symref)" refs/heads/sym >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'basic: notes' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		write_script fake_editor <<-\EOF &&
+		echo "$MSG" >"$1"
+		echo "$MSG" >&2
+		EOF
+
+		test_commit 1st &&
+		test_commit 2nd &&
+		GIT_EDITOR=3D./fake_editor MSG=3Db4 git notes add &&
+		GIT_EDITOR=3D./fake_editor MSG=3Db3 git notes edit &&
+		echo b4 >expect &&
+		git notes --ref commits@{1} show >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'basic: stash' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file &&
+		git stash list >expect &&
+		test_line_count =3D 0 expect &&
+
+		echo hoi >>file.t &&
+		git stash push -m stashed &&
+		git stash list >expect &&
+		test_line_count =3D 1 expect &&
+
+		git stash clear &&
+		git stash list >expect &&
+		test_line_count =3D 0 expect
+	)
+'
+
+test_expect_success 'basic: cherry-pick' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit message1 file1 &&
+		test_commit message2 file2 &&
+		git branch source &&
+		git checkout HEAD^ &&
+		test_commit message3 file3 &&
+		git cherry-pick source &&
+		test_path_is_file file2
+	)
+'
+
+test_expect_success 'basic: rebase' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit message1 file1 &&
+		test_commit message2 file2 &&
+		git branch source &&
+		git checkout HEAD^ &&
+		test_commit message3 file3 &&
+		git rebase source &&
+		test_path_is_file file2
+	)
+'
+
+test_expect_success 'reflog: can delete separate reflog entries' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit file &&
+		test_commit file2 &&
+		test_commit file3 &&
+		test_commit file4 &&
+		git reflog >actual &&
+		grep file3 actual &&
+
+		git reflog delete HEAD@{1} &&
+		git reflog >actual &&
+		! grep file3 actual
+	)
+'
+
+test_expect_success 'reflog: can switch to previous branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file1 &&
+		git checkout -b branch1 &&
+		test_commit file2 &&
+		git checkout -b branch2 &&
+		git switch - &&
+		git rev-parse --symbolic-full-name HEAD >actual &&
+		echo refs/heads/branch1 >expect &&
+		test_cmp actual expect
+	)
+'
+
+test_expect_success 'reflog: copying branch writes reflog entry' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit file1 &&
+		test_commit file2 &&
+		oid=3D$(git rev-parse --short HEAD) &&
+		git branch src &&
+		cat >expect <<-EOF &&
+		${oid} dst@{0}: Branch: copied refs/heads/src to refs/heads/dst
+		${oid} dst@{1}: branch: Created from main
+		EOF
+		git branch -c src dst &&
+		git reflog dst >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'reflog: renaming branch writes reflog entry' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git symbolic-ref HEAD refs/heads/before &&
+		test_commit file &&
+		git show-ref >expected.refs &&
+		sed s/before/after/g <expected.refs >expected &&
+		git branch -M after &&
+		git show-ref >actual &&
+		test_cmp expected actual &&
+		echo refs/heads/after >expected &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'reflog: can store empty logs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_must_fail test-tool ref-store main reflog-exists refs/heads/branch =
&&
+		test-tool ref-store main create-reflog refs/heads/branch &&
+		test-tool ref-store main reflog-exists refs/heads/branch &&
+		test-tool ref-store main for-each-reflog-ent-reverse refs/heads/branch >=
actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'reflog: expiry empties reflog' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit initial &&
+		git checkout -b branch &&
+		test_commit fileA &&
+		test_commit fileB &&
+
+		cat >expect <<-EOF &&
+		commit: fileB
+		commit: fileA
+		branch: Created from HEAD
+		EOF
+		git reflog show --format=3D"%gs" refs/heads/branch >actual &&
+		test_cmp expect actual &&
+
+		git reflog expire branch --expire=3Dall &&
+		git reflog show --format=3D"%gs" refs/heads/branch >actual &&
+		test_must_be_empty actual &&
+		test-tool ref-store main reflog-exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog: can be deleted' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test-tool ref-store main reflog-exists refs/heads/main &&
+		test-tool ref-store main delete-reflog refs/heads/main &&
+		test_must_fail test-tool ref-store main reflog-exists refs/heads/main
+	)
+'
+
+test_expect_success 'reflog: garbage collection deletes reflog entries' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for count in $(test_seq 1 10)
+		do
+			test_commit "number $count" file.t $count number-$count ||
+			return 1
+		done &&
+		git reflog refs/heads/main >actual &&
+		test_line_count =3D 10 actual &&
+		grep "commit (initial): number 1" actual &&
+		grep "commit: number 10" actual &&
+
+		git gc &&
+		git reflog refs/heads/main >actual &&
+		test_line_count =3D 0 actual
+	)
+'
+
+test_expect_success 'reflog: updates via HEAD update HEAD reflog' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit main-one &&
+		git checkout -b new-branch &&
+		test_commit new-one &&
+		test_commit new-two &&
+
+		echo new-one >expect &&
+		git log -1 --format=3D%s HEAD@{1} >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'worktree: adding worktree creates separate stack' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo worktree add ../worktree &&
+	test_path_is_file repo/.git/worktrees/worktree/refs/heads &&
+	echo "ref: refs/heads/.invalid" >expect &&
+	test_cmp expect repo/.git/worktrees/worktree/HEAD &&
+	test_path_is_dir repo/.git/worktrees/worktree/reftable &&
+	test_path_is_file repo/.git/worktrees/worktree/reftable/tables.list
+'
+
+test_expect_success 'worktree: pack-refs in main repo packs main refs' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+	git -C repo worktree add ../worktree &&
+
+	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 4 repo/.git/reftable/tables.list &&
+	git -C repo pack-refs &&
+	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: pack-refs in worktree packs worktree refs' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+	git -C repo worktree add ../worktree &&
+
+	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 4 repo/.git/reftable/tables.list &&
+	git -C worktree pack-refs &&
+	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 4 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: creating shared ref updates main stack' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo worktree add ../worktree &&
+	git -C repo pack-refs &&
+	git -C worktree pack-refs &&
+	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list &&
+
+	git -C worktree update-ref refs/heads/shared HEAD &&
+	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 2 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: creating per-worktree ref updates worktree =
stack' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo worktree add ../worktree &&
+	git -C repo pack-refs &&
+	git -C worktree pack-refs &&
+	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list &&
+
+	git -C worktree update-ref refs/bisect/per-worktree HEAD &&
+	test_line_count =3D 2 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: creating per-worktree ref from main repo' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo worktree add ../worktree &&
+	git -C repo pack-refs &&
+	git -C worktree pack-refs &&
+	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list &&
+
+	git -C repo update-ref worktrees/worktree/refs/bisect/per-worktree HEAD &&
+	test_line_count =3D 2 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: creating per-worktree ref from second workt=
ree' '
+	test_when_finished "rm -rf repo wt1 wt2" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo worktree add ../wt1 &&
+	git -C repo worktree add ../wt2 &&
+	git -C repo pack-refs &&
+	git -C wt1 pack-refs &&
+	git -C wt2 pack-refs &&
+	test_line_count =3D 1 repo/.git/worktrees/wt1/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/worktrees/wt2/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list &&
+
+	git -C wt1 update-ref worktrees/wt2/refs/bisect/per-worktree HEAD &&
+	test_line_count =3D 1 repo/.git/worktrees/wt1/reftable/tables.list &&
+	test_line_count =3D 2 repo/.git/worktrees/wt2/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: can create shared and per-worktree ref in o=
ne transaction' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo A &&
+
+	git -C repo worktree add ../worktree &&
+	git -C repo pack-refs &&
+	git -C worktree pack-refs &&
+	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 1 repo/.git/reftable/tables.list &&
+
+	cat >stdin <<-EOF &&
+	create worktrees/worktree/refs/bisect/per-worktree HEAD
+	create refs/branches/shared HEAD
+	EOF
+	git -C repo update-ref --stdin <stdin &&
+	test_line_count =3D 2 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count =3D 2 repo/.git/reftable/tables.list
+'
+
+test_expect_success 'worktree: can access common refs' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo file1 &&
+	git -C repo branch branch1 &&
+	git -C repo worktree add ../worktree &&
+
+	echo refs/heads/worktree >expect &&
+	git -C worktree symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	git -C worktree checkout branch1
+'
+
+test_expect_success 'worktree: adds worktree with detached HEAD' '
+	test_when_finished "rm -rf repo worktree" &&
+
+	git init repo &&
+	test_commit -C repo A &&
+	git -C repo rev-parse main >expect &&
+
+	git -C repo worktree add --detach ../worktree main &&
+	git -C worktree rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch: accessing FETCH_HEAD special ref works' '
+	test_when_finished "rm -rf repo sub" &&
+
+	git init sub &&
+	test_commit -C sub two &&
+	git -C sub rev-parse HEAD >expect &&
+
+	git init repo &&
+	test_commit -C repo one &&
+	git -C repo fetch ../sub &&
+	git -C repo rev-parse FETCH_HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0611-reftable-httpd.sh b/t/t0611-reftable-httpd.sh
new file mode 100755
index 0000000000..5e05b9c1f2
--- /dev/null
+++ b/t/t0611-reftable-httpd.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description=3D'reftable HTTPD tests'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd
+
+REPO=3D"$HTTPD_DOCUMENT_ROOT_PATH/repo"
+
+test_expect_success 'serving ls-remote' '
+	git init --ref-format=3Dreftable -b main "$REPO" &&
+	cd "$REPO" &&
+	test_commit m1 &&
+	>.git/git-daemon-export-ok &&
+	git ls-remote "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" | cut -f 2-2 =
-d "	" >actual &&
+	cat >expect <<-EOF &&
+	HEAD
+	refs/heads/main
+	refs/tags/m1
+	EOF
+	test_cmp actual expect
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 042f557a6f..c8af8dab79 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1755,6 +1755,8 @@ esac
 case "$GIT_DEFAULT_REF_FORMAT" in
 files)
 	test_set_prereq REFFILES;;
+reftable)
+	test_set_prereq REFTABLE;;
 *)
 	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_FORMAT"
 	exit 1
--=20
2.43.GIT


--0L5ReFAz3rn0GTVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDLz4ACgkQVbJhu7ck
PpSDHBAAk8d81c947AxlQYDSJwOpfVf1mYaKz9VH/pdhKk9l0Y82KOs6a7oQ0zUt
YQeUG7yE8ffcY8E3U2oXtwXI+H86DoljdvPdNYLoLW8bnSlrQGc7YdD53q+qENOt
qk5ChXepj43Q2QmRGBSipxNUZHG3u31oFb5kza8ABPCWpvrD5UpCwS99BQhA//e8
MgnECaANFPU2rBzdsyfjSsaczD9Xt1jCUDbfJ0oChneihZZ+4qwB/ANuZg90tPPf
0qb5x8qQZ8j9FWtpqlu+E60p6UWmG3xu4SX6cva7y+LhxzfueQh3KMnP7DzQDKF/
y1xJlVVP/g4dkXNafwb/uYi4WLFoEYurmAw5eiXkLAYNcztAdKhv5WFzN+4+vh0Z
lIcEQSi0LdL8gIBA7jsJQrga7m9LEX/KK5IULL5/crTV0Miot6jQGsPIrsL3Fx06
0rpR6MDrSTZBSmVA2O4mL2BoNuad0igsar4yC+q/ciitSljXiwvzuiV6TPknLQVs
mYCR1RdCSZbzAEK8dUmuhd6XtVcaTxee2kgXZBsnLsGQolGl8p0hSJWIcqZbTDrl
HlNUjxFeC2EqB7Hbi4KM99mlHOIIa9FYfQSiG8rHbX4h79BnTnUIAptQ+eeCyng1
LRZouIjo8NJOlN4i2JFjz0Ur6t5mTRw6B26l3yYgsbFFx0rf4Y0=
=pBP9
-----END PGP SIGNATURE-----

--0L5ReFAz3rn0GTVv--
