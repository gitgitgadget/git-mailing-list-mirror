Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC52F24
	for <git@vger.kernel.org>; Sat, 18 May 2024 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716007937; cv=none; b=aHiJYcePmDqTQsMSsiYE/a+Dcee3XNZoT0hd82Yb513MLpJXBMqyKgE+FgTdqniAVpwBewuaMuGFK9ia8ManjV8uAm1xv6p3AoLeeXaOjyHgBnt6WPCl+4yseVh76WZNyaf91ddGH3mWVQFNMafcDmKYTv3yRiVNP4FMDsvdPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716007937; c=relaxed/simple;
	bh=FFyASQOd6DDOsL777oR+LikEVUxvY9o01y5Ny22zJ1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X04bIR+ZfSJUcJpJzMeRovMz4DAoEYX+tcWkxD0iG+FK8YeXW/AD9k2WKlcekCVdzXhGM1Vyd2KwttdwW3V4D4xvAXCSKGOJU7W3MTlx+LkK2vGHPnjaAQQ1mS2butL9PgLQXL/dyra8eqIguPwl4osQeemvjfw3mXOQRCiwt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cLxd7WaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdDCcAJu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cLxd7WaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdDCcAJu"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A4A2311400A6;
	Sat, 18 May 2024 00:52:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 18 May 2024 00:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716007932; x=1716094332; bh=VXv2WhFCCK
	Dr2j2MOf1NDQhuP2jiLgTCrInbcR3m3wE=; b=cLxd7WaM4QJX29MSeRBuC2P8j+
	NeKw3u+xq/dHV0Y5PZzygEq4rtPdHeLFf24Y3/+QSkJXzxmAmCU71MoaQvzXByU4
	YfyiFaivrLyRcsp+Rgt9QkFB4uqz5geRr3hmGUfL0UyQWwYXV50VboRFWUM4C/ow
	NYG1RiW9nJaOo7b8+kzHKmsM2b3NAfkxGf3f9zviwTBgSBzWk6/V22vX89DwXMGz
	3XyKBqzdk3cHVi4ExK/PWIy/6kFFJJztJ/ueqS9ZmlzlayUI5Hy9spmQbbUX2CNu
	6y354u26SQTHQN500kV5p05gojxUUWCKp2lpX5le90iuPkkmEdRvFSg5Wt2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1716007932; x=1716094332; bh=VXv2WhFCCKDr2j2MOf1NDQhuP2ji
	LgTCrInbcR3m3wE=; b=LdDCcAJujjRFjyM9JzcLrqBUzHm69hOst3+Rr7TcWwxt
	tEREYLGdY8D3rkSxMGmk5JpL0eni8xdUX5sMPVkuxNonrhMqm7uQ4GYi2yE09DzX
	drhUALjYco/zB+oQGNdoG1lqf3GhhM3JiL0RmdDIUdRyCez/5ECdIsELrdyrKTPo
	7Y1OZyTMIDshQtGEuF8DQWajLpAKMTws/AqUVi84Yuzbq1/kq7VT9Thjuo0yp3kd
	h6Cn2KBxef/K6rFKUHeR6hfeguEWPbQu3QqfPzNPpp04Whwbgk1GZf92/6d6v8pd
	80+yj1zjV2zvbWrMrqMomMncsYPDVmLt1aIvVOxagw==
X-ME-Sender: <xms:_DNIZj-AGU1KKDrFIueLh2TXDq0NJZq2MMaI-222fJcjPdzUHGII9g>
    <xme:_DNIZvtQHuFrA35bSqEgRWiFsfz3Xojhs32M4no7WsWJ9sU040aYYO5E6F6BoMvOj
    c7aQ7YbXB_5EjkmPQ>
X-ME-Received: <xmr:_DNIZhBVbl9d8C27N9KyW-0yz3y6EjYefp6Pg07cLl82HZkC8xvq5mORTzC9n6ctxhY-BHPn6zVhNdad7shWir2gYe-IIS6KRpUhVd8pQrRiEg_p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeevffffkefgffegheduteetffegjeekge
    ektdduheefjeegleefgfeutefhkeekueenucffohhmrghinheprgguughrvghsshgvugdr
    phhspdhpkhhsrdhimhdpshhoohhnihhshhdrphhspdhgohdrphhsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_DNIZvcDClIS5irHhgaEIjjVv3GHZiej9-I87vbn2F4zbVKexq_u1w>
    <xmx:_DNIZoNeywP9NWBbQv0bf4KSl4KS1jFJ06HqTFP2TV2nHf4wl_BWDw>
    <xmx:_DNIZhmMK5A9UgcpHlzD8Qzk8n3bpFKKEX737yhLTtmypaHSH_lMWQ>
    <xmx:_DNIZiuuEsrToMGmldpc75n_b_w4q6-6lLkaCNqaDPeBsyQYbgnkUA>
    <xmx:_DNIZhaZpI9ZBKgq9rw8kh9h4Eq3TmbpjoCAbOJqjXbOpjXWTBr7_a3i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 May 2024 00:52:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 372229b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 18 May 2024 04:51:40 +0000 (UTC)
Date: Sat, 18 May 2024 06:52:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #07; Fri, 17)
Message-ID: <Zkgz90p62iDqAhKJ@framework>
References: <xmqqfrugdmnx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Y7TXeDBTNQ8Yasj"
Content-Disposition: inline
In-Reply-To: <xmqqfrugdmnx.fsf@gitster.g>


--/Y7TXeDBTNQ8Yasj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 04:49:22PM -0700, Junio C Hamano wrote:
> [New Topics]
>=20
> * tb/pack-bitmap-write-cleanups (2024-05-15) 6 commits
>  - pack-bitmap: introduce `bitmap_writer_free()`
>  - pack-bitmap-write.c: avoid uninitialized 'write_as' field
>  - pack-bitmap: drop unused `max_bitmaps` parameter
>  - pack-bitmap: avoid use of static `bitmap_writer`
>  - pack-bitmap-write.c: move commit_positions into commit_pos fields
>  - object.h: add flags allocated by pack-bitmap.h
>=20
>  The pack bitmap code saw some clean-up to prepare for a follow-up topic.
>=20
>  Will merge to 'next'?
>  source: <cover.1715716605.git.me@ttaylorr.com>

This patch series looks good to me. I left a few comments, but none of
them really need to be addressed.

> * ps/refs-without-the-repository-updates (2024-05-17) 17 commits
>  - refs/packed: remove references to `the_hash_algo`
>  - refs/files: remove references to `the_hash_algo`
>  - refs/files: use correct repository
>  - refs: remove `dwim_log()`
>  - refs: drop `git_default_branch_name()`
>  - refs: pass repo when peeling objects
>  - refs: move object peeling into "object.c"
>  - refs: pass ref store when detecting dangling symrefs
>  - refs: convert iteration over replace refs to accept ref store
>  - refs: retrieve worktree ref stores via associated repository
>  - refs: refactor `resolve_gitlink_ref()` to accept a repository
>  - refs: pass repo when retrieving submodule ref store
>  - refs: track ref stores via strmap
>  - refs: implement releasing ref storages
>  - refs: rename `init_db` callback to avoid confusion
>  - refs: adjust names for `init` and `init_db` callbacks
>  - Merge branch 'ps/refs-without-the-repository' into ps/refs-without-the=
-repository-updates
>=20
>  Further clean-up the refs subsystem to stop relying on
>  the_repository, and instead use the repository associated to the
>  ref_store object.
>=20
>  Will merge to 'next'?
>  source: <cover.1715929858.git.ps@pks.im>

The second version hasn't seen any reviews yet, so I wouldn't mind
waiting a few more days. But overall the changes are quite straight
forward and shouldn't be all that controversial, so I wouldn't mind it
much if it was landing soonish.

> * ps/builtin-config-cleanup (2024-05-15) 22 commits
>  - builtin/config: pass data between callbacks via local variables
>  - builtin/config: convert flags to a local variable
>  - builtin/config: track "fixed value" option via flags only
>  - builtin/config: convert `key` to a local variable
>  - builtin/config: convert `key_regexp` to a local variable
>  - builtin/config: convert `regexp` to a local variable
>  - builtin/config: convert `value_pattern` to a local variable
>  - builtin/config: convert `do_not_match` to a local variable
>  - builtin/config: move `respect_includes_opt` into location options
>  - builtin/config: move default value into display options
>  - builtin/config: move type options into display options
>  - builtin/config: move display options into local variables
>  - builtin/config: move location options into local variables
>  - builtin/config: refactor functions to have common exit paths
>  - config: make the config source const
>  - builtin/config: check for writeability after source is set up
>  - builtin/config: move actions into `cmd_config_actions()`
>  - builtin/config: move legacy options into `cmd_config()`
>  - builtin/config: move subcommand options into `cmd_config()`
>  - builtin/config: move legacy mode into its own function
>  - builtin/config: stop printing full usage on misuse
>  - Merge branch 'ps/config-subcommands' into ps/builtin-config-cleanup
>=20
>  Code clean-up to reduce inter-function communication inside
>  builtin/config.c done via the use of global variables.
>=20
>  Will merge to 'next'?
>  source: <cover.1715755055.git.ps@pks.im>

I think this should be ready to go.

> * ps/pseudo-ref-terminology (2024-05-15) 10 commits
>  - refs: refuse to write pseudorefs
>  - ref-filter: properly distinuish pseudo and root refs
>  - refs: pseudorefs are no refs
>  - refs: classify HEAD as a root ref
>  - refs: do not check ref existence in `is_root_ref()`
>  - refs: rename `is_special_ref()` to `is_pseudo_ref()`
>  - refs: rename `is_pseudoref()` to `is_root_ref()`
>  - Documentation/glossary: define root refs as refs
>  - Documentation/glossary: clarify limitations of pseudorefs
>  - Documentation/glossary: redefine pseudorefs as special refs
>=20
>  Terminology to call various ref-like things are getting
>  straightened out.
>=20
>  Will merge to 'next'?
>  cf. <vgzwb5xnlvz2gfiqamzrfcjs2xya3zhhoootyzopfpdrjapayq@wfsomyal4cf6>
>  source: <cover.1715755591.git.ps@pks.im>

This has seen quite some discussion, but to the best of my knowlegde I
have addressed all the feedback. So I think this one should be ready to
go, too.

Thanks!

Patrick

--/Y7TXeDBTNQ8Yasj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZIM/EACgkQVbJhu7ck
PpQOsw//dZHAoe4ysuEJEb85GeBJrxl9XdV0Gu6lcsQV58dDvqKpUyiw3aqPGkTB
8vjDrPUfph6eBrbnHJ5pjXgxS5fyMTUPel37W0D69E8iRNdFoDr9JgBX40YKVhmN
qaqpfZok7bDVrVZb7skXOeYizITIbs4asFNzuorSXUjrYSoCB9nGaRkVUfnFyttw
RQKX8bUagMLHMaWloJOfdgbmEpWVDLoYt2KlgFeFbu2JM4zP3Cu4ecAs07NlWwoT
NfGg+hdCT+MhSg6Ad4nc8NUo4p5K9T5q2u11sEAtkyULJELQpT6ioluZcb9lOuap
GKeYyES/k3CHj5kR04m6k1O3kkTFXI1WttMxizGy4DNLMzWCbg+MgYyEGp7hBpL6
jCpoqhuBPIcC+LnCNo+jnxAiupfLfXCqH60sr46FfsYmbv6jp/J9GLy5TpC4/Gfz
TEmALeDedJ4Jx6ktxF17zeUf5spETtoPPoYBTQChUhTlMhLCKeF7FrBXAG2GQ63c
me8FapMPhY8E4/KX7lBLMil1cVYxX8mUr26VtuK5jjwXSoyKQGeouctoUKkl/ElL
NTaxkfzCFXijT6AdRG1QF6cgDX2E+4wfZHAxcX3tCHw+EjqnmxH2qHa6ttZhi5e8
YpeCA+t51gutcD1bGEq3d5VmNnlcGWn+t0RVbe3DKZ8JUTiHLKM=
=BKA4
-----END PGP SIGNATURE-----

--/Y7TXeDBTNQ8Yasj--
