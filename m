Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DBE77F00
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198462; cv=none; b=XgOGAQWZWcv3QLWegzbq71UBqxGJjvqXn7jsde7HeINKF4xGDG1XviNrSSi05LiN2L6pugcNj0N30a0rgd139aMFXf/OQGqdqT3JMqeVIOpIN6xg8BVBCBovEF6tWmQLXu9EdBa68AKi/Xcj0Tye/TtSmla2gRoaEdy+JVtgjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198462; c=relaxed/simple;
	bh=ryLEjMYiAUQ6CxGYsfwPTdHpvwUd3MlNDXjsJVFQqHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnvbVkQWJ+DohpPUUGw0o7w+S5qEGr8RJ+QCMh11hVODRtjgNvqaivm+3kx9/64pssPzJsbPs7lJcpO7hduFiphZj//O6b4jPTMMO3x4BCiwBdlOPJBx2/69fwB2qW6wWc0V9ncOItrs+fmCyAbD4RhOSOsadH6of8wRGorHm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UTBfZMvW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vLHWnsg9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UTBfZMvW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vLHWnsg9"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 20B501140091;
	Tue,  6 Feb 2024 00:47:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 06 Feb 2024 00:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707198459; x=1707284859; bh=mS1r5ea+fx
	VzNGQyyLvmQwKhCQDFu0x8cslwNKC1xQI=; b=UTBfZMvWgaLqW0eIwC0F5wiNwJ
	O2J6tkDHUWCFqBmmp+WVyF+VzqnnFcZ/flLtM8+H6TCXquwc6eN0pkJR55LfdRD3
	LPK/EgibpyvIICZzVJRtb37Ry7pH/QBrM6MWLgBn5586UZpDE4xohsWlAr5YK8AZ
	6cl6u/2jdE1nT17O/Aa4WIqOXRnMDN2MvTwb9eOH72500nSD9IfRKSTDiOTkMqvs
	LjeTr4WvcJZoPltr2mPhMRzGzKam7BWJUI0x3/pZod6KU/Kwbi7Z7FU1vc6tefp9
	IVl5lzlf0nV3z/LzT/M6/rhfaxOipCOb1G4uH1w9/6FIDDYXYcJrAQ0LGGaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707198459; x=1707284859; bh=mS1r5ea+fxVzNGQyyLvmQwKhCQDF
	u0x8cslwNKC1xQI=; b=vLHWnsg9kARyeCsxpH3bj93AgDy9lK9T4sfXro0ynQNE
	39QB6rgI4RMWPgRS1VlN7cgSXPQfbyqA07jD3AD1J0rBIW4MNMsVc4ErZB5JBnE2
	7u+41jpt98hbr16aR3P29DK8h9RSJymho0WVlXqwom/aSC2DMJv/xbNzTrBU8+zq
	2ZYImjI/7O1Xq8H95YSRInncwnVG/tTUQv5PpBTRcHDowr6JLB3RswWhRbW1/jZ4
	JC3HLY6/dBJ19JjKeKRORRlAChChX2Bl4KcyDXBzc37ymvM1OUp9wpn4K5Wx9MPz
	MuNMQKMhSQdZDIM4zIPGB1b9XkLAgs/hk8d8HdH/jw==
X-ME-Sender: <xms:-sfBZSbZV-rnFsQSoCs2ESQYCdPmCIj7eJ2sbYutvcyoGBP_cgBYoQ>
    <xme:-sfBZVa1fR-E24Om6c53IE564LI7fNPtO6l9_iyuv8inQl3FTIYj-CkLUuzScY2SN
    FvtTDGTOGcXEyuK3A>
X-ME-Received: <xmr:-sfBZc_RGRCcz41tOwmvcBOpSSaZ5eDgSFjz0pUqk5N8o6aioOCwAgWFiraqRexOkw51kQCZwQ4voonxFxCQbGqyk0hBmbyhjh9JdVmg5uJ0EPqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephedvfeehtdehjefgtefftddvheeiueeihffhteeuveeftdehieekkefhgffhhefg
    necuffhomhgrihhnpehhthhtphhprhhothhotgholhdrihhtpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:-sfBZUq7NT8BcvMW63QflSHe4DRtgcv3WrNRKMMpIbf6dnrdJdULyg>
    <xmx:-sfBZdr-oEC4WHyQeSEnwfagg87-X5qT99q7rapeBeURk1zBW_BaFw>
    <xmx:-sfBZST7YqeKEihqFT_3yibV39aJiJk2ZZEEdFrkxZ5QxaMDZVMVEQ>
    <xmx:-8fBZefTpYA2uCRbhCCngjyTvZZT9Iaedo_ikfisznr_Znzq22WifQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 00:47:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58ab2318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:44:05 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:47:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
Message-ID: <ZcHH9UCiQgGvugyc@tanuki>
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iYHXNYA6NBOjD78n"
Content-Disposition: inline
In-Reply-To: <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>


--iYHXNYA6NBOjD78n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:43:17PM +0100, Christian Couder wrote:
> On Mon, Feb 5, 2024 at 9:39=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > Add project ideas for the GSoC 2024.
> > ---
> >
> > I came up with four different topics:
> >
> >   - The reftable unit test refactorings. This topic can also be squashed
> >     into the preexisting unit test topics, I wouldn't mind. In that case
> >     I'd be happy to be a possible mentor, too.
> >
> >   - Ref consistency checks for git-fsck(1). This should be rather
> >     straight forward and make for an interesting topic.
> >
> >   - Making git-bisect(1)'s state more self-contained as recently
> >     discussed. This topic is easy to implement, but the backwards
> >     compatibility issues might require a lot of attention.
> >
> >   - Implementing support for reftables in the "dumb" HTTP protocol. It's
> >     quite niche given that the dumb protocol isn't really used much
> >     nowadays anymore. But it could make for an interesting project
> >     regardless.
> >
> > It's hard to estimate for me whether their scope is either too small or
> > too big. So please feel free to chime in and share your concerns if you
> > think that any of those proposals don't make much sense in your opinion.
>=20
> Thanks a lot for these ideas! I have applied your patch and pushed it.
>=20
> I have a few concerns though, see below.
>=20
> >  SoC-2024-Ideas.md | 129 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> >
> > diff --git a/SoC-2024-Ideas.md b/SoC-2024-Ideas.md
> > index 3efbcaf..286aea0 100644
> > --- a/SoC-2024-Ideas.md
> > +++ b/SoC-2024-Ideas.md
> > @@ -39,3 +39,132 @@ Languages: C, shell(bash)
> >  Possible mentors:
> >  * Christian Couder < <christian.couder@gmail.com> >
> >
> > +### Convert reftable unit tests to use the unit testing framework
> > +
> > +The "reftable" unit tests in "t0032-reftable-unittest.sh"
> > +predate the unit testing framework that was recently
> > +introduced into Git. These tests should be converted to use
> > +the new framework.
> > +
> > +See:
> > +
> > +  - this discussion <https://lore.kernel.org/git/cover.1692297001.git.=
steadmon@google.com/>
> > +
> > +Expected Project Size: 175 hours or 350 hours
> > +
> > +Difficulty: Low
>=20
> "Difficulty: Low" might not be very accurate from the point of view of
> contributors. I think it's always quite difficult to contribute
> something significant to Git, and sometimes more than we expected.

That's certainly true. I understood the difficulty levels here as being
relative to the already-high bar that the Git project typically sets.
Otherwise there wouldn't be much use to specify difficulty in the first
place if all items had the same difficulty.

Or is the intent of the difficulty level rather on a global GSoC level?
In that case I agree that we should bump the difficulty to "medium".

> > +Languages: C, shell(bash)
> > +
> > +Possible mentors:
> > +* Patrick Steinhardt < <ps@pks.im> >
> > +* Karthik Nayak < <karthik.188@gmail.com> >
> > +
> > +### Implement consistency checks for refs
> > +
> > +The git-fsck(1) command is used to check various data
> > +structures for consistency. Notably missing though are
> > +consistency checks for the refdb. While git-fsck(1)
> > +implicitly checks some of the properties of the refdb
> > +because it uses its refs for a connectivity check, these
> > +checks aren't sufficient to properly ensure that all refs
> > +are properly consistent.
> > +
> > +The goal of this project would be to introduce consistency
> > +checks that can be implemented by the ref backend. Initially
> > +these checks may only apply to the "files" backend. With the
> > +ongoing efforts to upstream a new "reftable" backend the
> > +effort may be extended.
> > +
> > +See:
> > +
> > +  - https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@r=
d10.de/
> > +  - https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/
> > +
> > +Expected Project Size: 175 hours or 350 hours
> > +
> > +Difficulty: Medium
> > +
> > +Languages: C, shell(bash)
> > +
> > +Possible mentors:
> > +* Patrick Steinhardt < <ps@pks.im> >
> > +* Karthik Nayak < <karthik.188@gmail.com> >
> > +
> > +### Refactor git-bisect(1) to make its state self-contained
> > +
> > +The git-bisect(1) command is used to find a commit in a
> > +range of commits that introduced a specific bug. Starting a
> > +bisection run creates a set of state files into the Git
> > +repository which record various different parameters like
> > +".git/BISECT_START". These files look almost like refs
> > +due to their names being all-uppercase. This has led to
> > +confusion with the new "reftable" backend because it wasn't
> > +quite clear whether those files are in fact refs or not.
> > +
> > +As it turns out they are not refs and should never be
> > +treated like one. Overall, it has been concluded that the
> > +way those files are currently stored is not ideal. Instead
> > +of having a proliferation of files in the Git directory, it
> > +was discussed whether the bisect state should be moved into
> > +its own "bisect-state" subdirectory. This would make it more
> > +self-contained and thereby avoid future confusion. It is
> > +also aligned with the sequencer state used by rebases, which
> > +is neatly contained in the "rebase-apply" and "rebase-merge"
> > +directories.
> > +
> > +The goal of this project would be to realize this change.
> > +While rearchitecting the layout should be comparatively easy
> > +to do, the harder part will be to hash out how to handle
> > +backwards compatibility.
> > +
> > +See:
> > +
> > +  - https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/
>=20
> From reading the discussion it looks like everyone is Ok with doing
> this. I really hope that we are not missing something that might make
> us decide early not to do this though.

I agree that this is a risky one, and that's what I tried to bring
across with the "harder part will be to hash out how to handle backwards
compatibility". Overall I think this project will be more about selling
the patch and reasoning about how it can be done without breaking
backwards compatibility.

We could bump the difficulty to high to reflect that better. But if you
deem the risk to be too high then I'm also happy to drop the topic
completely.

Patrick

--iYHXNYA6NBOjD78n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBx/QACgkQVbJhu7ck
PpTNIg//dmoE/q/r3mHC9QiNfZhoMXhuHmwab7KXxW+uOsdoAP+cXkV/Q/vnJZ9a
A8cTinuBWLKKnsSWVrUswlmixlyt7JOJlflMYtXhW/RPKN3CHdlxJQPFW1mpRq3U
QuHf2leFggNj9k99HRNd/SezDNNNRwV9DgEMkfy/1EdR71AluRdU2b661Yj7bSLw
P5jw4cz09XBIM4IwPu+M3vldvJ0nUxB4PAz26mjol5xRPWZcxlWttZ23t83wXdVm
X5UPN6SZ6UsY3CVuSA1L0aj+LKeREWL6wDdXBh3m7Z4ndjCj/fXWJDdb6utTTC9x
WzzwWs2BRSOe77fD3TYa1JQq8S4lmhGREoZ1v3d3gixVnHoDCQcf0tiXZ4QtfH6x
xI8qoJJqMF7UExWe+Jgz0/vU/WWoNU2+b4xFpYjKiWV66bfoigfh4je2SHLxnaQE
2iVez0/ioRsPW/Snce9Fc9Wqcq2+DhZ5nqU6H06IAx8ZZfVP2MdcnbvpDAKI24sK
uoVEWmYyF5TJv+6Kz42fK2rLUCjO8cviOFv0sv9b1m9V7eYMLTnAPnQA/2NtjH38
gE3mna3WtOk53/Jc9icEP99yKF8BkkBB1Ok7Q8L1a3qLNLk4h2o4+m7skieUhrRy
XKBV0xoTzQuBYbAOnJVjwWae36PmHkih4XznpUVcXAO4KvD8reY=
=SMKf
-----END PGP SIGNATURE-----

--iYHXNYA6NBOjD78n--
