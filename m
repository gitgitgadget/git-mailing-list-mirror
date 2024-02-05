Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DB11709
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122360; cv=none; b=hnDNPDCMA53EK77wqBv5i9ptcvVu0W02R6i+YHRguZk+FnnIp40DcdK28Ag96eCWXgJ4LbZnZD8Lout0uEQ+YXRMhGNmvf/e1nQs+qrsL0VOS7vB7ObLfdqO+21TxateV3SzX58pGwD1aV6eYWOp3TvH/mbwGH+w0NjSoHLthvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122360; c=relaxed/simple;
	bh=vStd8uDHP3PI+zsHFF5BbUBNtGJV8hfwLBqvrUMkjoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRk3K+PyrQp5vgGEDBJt6NJ09EqZr90kcA5wgR1NtI4ZISnjmYo7jWT76Bc2RJC6VW5gihvGV/1W+5KjMTMmZy4zQPbqs9pifkpaVFzuLZRWqg35oOuYbzeygNW2Q8+rzguMDuKSuDTnCfellu4tdBdqN0gl4wKZ+xZ03hio5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lxWCqswd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgA7d79M; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lxWCqswd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgA7d79M"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 027AB3200A72;
	Mon,  5 Feb 2024 03:39:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 05 Feb 2024 03:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707122355; x=1707208755; bh=XId42yeDDC
	+jJE+GfzhdFqSonyaDmvL5KcU32eMCfeY=; b=lxWCqswdxSIyXrdag+E4LrcVd1
	T24psob+OpRb3XBMg5KY/1NwrgDvInRCiniToOFYkFSnkpfqfC2wpeq1xxvFH46o
	xV6uc2yDtaRXoNlihtCUQNTkuyl4iamBLsJi7jyltG1+NSezJ/iVc7X4Bs0S6HUw
	arSxzjPMZMXoYo8WuoLSNmqYZUBCeGD/AN0knSnXUK4k++ySwmuJu+jSy1IZCMP+
	Ltr7p6AIsjj2r7WtPGfCWqQjxmLCxKQYFc6K4vC/b6kZyYGmu1fmhWiQ2RR195BP
	FI5Xy99/T8UdQMhygN4giizda4tF+emy+Di2zKrKiX+sIAdUBeqU02EYNFIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707122355; x=1707208755; bh=XId42yeDDC+jJE+GfzhdFqSonyaD
	mvL5KcU32eMCfeY=; b=MgA7d79Mp0oELQ0xMt6B3wJQJnNOtPiIRc4OAGC1K2Kv
	C0Lc9AObVpAJ11kUFgAntxzYULUT5IKa6uenlizNHIrDlRZVEznZfFxoBtv96ejf
	zicpIed68FViuZyzaYsz9RSGBQGIbwiLB9rFYeIg71fOUocQX2+Yugzws/k7/hm1
	seuZnIEugNIIRA6sc8MbYtBRs9dPHTQ/t6pRJSc9DvAZG/5mteimLbJEMU+HoybG
	SUQWAvLqF2ca/GQCCl/NfPIO51kCXqKQR+rzFm9gUn+6qRgVWvPNVSAqQzm46/h0
	ZrUZLM5f/CoSNm2dAh8nObhVYk5dt1nrm73CeLUixA==
X-ME-Sender: <xms:s57AZR1oTtbp91Dz2lAkBxir4J1NK9xm6KA585tTa6fWOk18NypnpQ>
    <xme:s57AZYF-nhmldWDFODgeveaIuEc4TdtJonz6Umb_LGoFodCyu6Bg7MDz2r8YkMtYg
    NEQW7wKvTbGhXFcxg>
X-ME-Received: <xmr:s57AZR4bcMIc2D6CTRujvzMr9jVzf843HygglPge08jT9FDlE2SCJAqa_AWfZJNddhoR9jYdokZym4cAd3fHyjYuAlC3bk21Z6ELAohO3_Prbjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeifefhfedthfeiveeiuedtfefftdegfffggefhfedtgedttdduhfeiueejffdt
    gfenucffohhmrghinhephhhtthhpphhrohhtohgtohhlrdhithdpkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimh
X-ME-Proxy: <xmx:s57AZe3ro8rrM9En2PUtAkcJjf6PR5BF8qEiruQbcSr44lOScf1FYQ>
    <xmx:s57AZUEmgs4QKnK5rP1BjOZZ6l0ZiSGbo32At6dxIheQBgOJwEhn7w>
    <xmx:s57AZf9Lm_644XMtCeNiUoeSqDFky-C2F8B3wwXsCuoTea-_Ig0ZAQ>
    <xmx:s57AZZMpgGbhyfJrc0gCTtSnX4ldoYD1fpHaScIu9Fg_TyR97iBmLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 03:39:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19efd147 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Feb 2024 08:35:43 +0000 (UTC)
Date: Mon, 5 Feb 2024 09:39:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] Add ideas for GSoC 2024
Message-ID: <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bj0Pc5S9outuGiwk"
Content-Disposition: inline
In-Reply-To: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>


--Bj0Pc5S9outuGiwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add project ideas for the GSoC 2024.
---

I came up with four different topics:

  - The reftable unit test refactorings. This topic can also be squashed
    into the preexisting unit test topics, I wouldn't mind. In that case
    I'd be happy to be a possible mentor, too.

  - Ref consistency checks for git-fsck(1). This should be rather
    straight forward and make for an interesting topic.

  - Making git-bisect(1)'s state more self-contained as recently
    discussed. This topic is easy to implement, but the backwards
    compatibility issues might require a lot of attention.

  - Implementing support for reftables in the "dumb" HTTP protocol. It's
    quite niche given that the dumb protocol isn't really used much
    nowadays anymore. But it could make for an interesting project
    regardless.

It's hard to estimate for me whether their scope is either too small or
too big. So please feel free to chime in and share your concerns if you
think that any of those proposals don't make much sense in your opinion.

Patrick

 SoC-2024-Ideas.md | 129 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/SoC-2024-Ideas.md b/SoC-2024-Ideas.md
index 3efbcaf..286aea0 100644
--- a/SoC-2024-Ideas.md
+++ b/SoC-2024-Ideas.md
@@ -39,3 +39,132 @@ Languages: C, shell(bash)
 Possible mentors:
 * Christian Couder < <christian.couder@gmail.com> >
=20
+### Convert reftable unit tests to use the unit testing framework
+
+The "reftable" unit tests in "t0032-reftable-unittest.sh"
+predate the unit testing framework that was recently
+introduced into Git. These tests should be converted to use
+the new framework.
+
+See:
+
+  - this discussion <https://lore.kernel.org/git/cover.1692297001.git.stea=
dmon@google.com/>
+
+Expected Project Size: 175 hours or 350 hours
+
+Difficulty: Low
+
+Languages: C, shell(bash)
+
+Possible mentors:
+* Patrick Steinhardt < <ps@pks.im> >
+* Karthik Nayak < <karthik.188@gmail.com> >
+
+### Implement consistency checks for refs
+
+The git-fsck(1) command is used to check various data
+structures for consistency. Notably missing though are
+consistency checks for the refdb. While git-fsck(1)
+implicitly checks some of the properties of the refdb
+because it uses its refs for a connectivity check, these
+checks aren't sufficient to properly ensure that all refs
+are properly consistent.
+
+The goal of this project would be to introduce consistency
+checks that can be implemented by the ref backend. Initially
+these checks may only apply to the "files" backend. With the
+ongoing efforts to upstream a new "reftable" backend the
+effort may be extended.
+
+See:
+
+  - https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.=
de/
+  - https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/
+
+Expected Project Size: 175 hours or 350 hours
+
+Difficulty: Medium
+
+Languages: C, shell(bash)
+
+Possible mentors:
+* Patrick Steinhardt < <ps@pks.im> >
+* Karthik Nayak < <karthik.188@gmail.com> >
+
+### Refactor git-bisect(1) to make its state self-contained
+
+The git-bisect(1) command is used to find a commit in a
+range of commits that introduced a specific bug. Starting a
+bisection run creates a set of state files into the Git
+repository which record various different parameters like
+".git/BISECT_START". These files look almost like refs
+due to their names being all-uppercase. This has led to
+confusion with the new "reftable" backend because it wasn't
+quite clear whether those files are in fact refs or not.
+
+As it turns out they are not refs and should never be
+treated like one. Overall, it has been concluded that the
+way those files are currently stored is not ideal. Instead
+of having a proliferation of files in the Git directory, it
+was discussed whether the bisect state should be moved into
+its own "bisect-state" subdirectory. This would make it more
+self-contained and thereby avoid future confusion. It is
+also aligned with the sequencer state used by rebases, which
+is neatly contained in the "rebase-apply" and "rebase-merge"
+directories.
+
+The goal of this project would be to realize this change.
+While rearchitecting the layout should be comparatively easy
+to do, the harder part will be to hash out how to handle
+backwards compatibility.
+
+See:
+
+  - https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/
+
+Expected Project Size: 175 hours or 350 hours
+
+Difficulty: Medium
+
+Languages: C, shell(bash)
+
+Possible mentors:
+* Patrick Steinhardt < <ps@pks.im> >
+* Karthik Nayak < <karthik.188@gmail.com> >
+
+### Implement support for reftables in "dumb" HTTP transport
+
+Fetching Git repositories uses one of two major protocols:
+
+  - The "dumb" protocol works without requiring any kind of
+    interactive negotiation like a CGI module. It can thus
+    be served by a static web server.
+
+  - The "smart" protocol works by having the client and
+    server exchange multiple messages with each other. It is
+    more efficient, but requires support for Git in the
+    server.
+
+While almost all servers nowadays use the "smart" protocol,
+there are still some that use the "dumb" protocol.
+
+The "dumb" protocol cannot serve repositories which use the
+"reftable" backend though. While there exists a "info/refs"
+file that is supposed to be backend-agnostic, this file does
+not contain information about the default branch. Instead,
+clients are expected to download the "HEAD" file and derive
+the default branch like that. This file is a mere stub in
+the "reftable" backend though, which breaks this protocol.
+
+The goal of this project is to implement "reftable" support
+for "dumb" fetches.
+
+Expected Project Size: 175 hours or 350 hours
+
+Difficulty: Medium
+
+Languages: C, shell(bash)
+
+Possible mentors:
+* Patrick Steinhardt < <ps@pks.im> >
+* Karthik Nayak < <karthik.188@gmail.com> >
--=20
2.43.GIT


--Bj0Pc5S9outuGiwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXAnqwACgkQVbJhu7ck
PpSKaA/+PFAcoOlCp97fRzmqOKadR8WXmq17T+rgaf9Ks5/vi7HMVBCIDKDK0P0i
Q298+fQx4N9oRuUgzFv6TLvvI+Z+//P/FIbrkZAXoDCimB+c1znCR9MfXEAqbo14
I4mO/wTqzioq9rav9bSmw0LZqR9BMSQDbuD2O3QJzWxVNnieFPCancOh7Hyk05q8
/p/QrYkikYY0597fC72NOs7aOcEu3fF1PYOj4txhoNkuOI1RdLTWHP/aG6qFW6/x
Wu0KDgtTAXf0PfwpiT3SgPxZ/NJ47U68cPR8p/66Hrp73VAKUROLMiO4WMmkSDA+
GYZrWU9J8733Hpf0Biz7sSfgkAmoBHc56OLaFvfW19y6HeXV9kggxiZ33fayKO5V
XrCV/Ckw6hgeHlYuE6XlmnMID/bdYOWOfmX7/0gWxMrKE4S3f++5VYQb6IZN/jcD
6YVDUeVm3cdHlAH/BkqJiLOEcL+l+B6PlmmDXweGK3pvZDR4KbzE/wTgq0YRdIB/
ecsGLGFdpzwp22PPKs81xGrK6Ek3+n6nx/j1cFAL+Sf6UTqMpxgdlaE0FWAc7J6K
tmEa8kOn+DsHfRAU0uQtPQ787puBx+/p/UAB3aUArLp7CVN5UV6tb19DE8Cjr0CD
3wLjcaK4GPKcC3M+0SYu4g1Qd0FpaY6QyiwNNqQOs82nCBsSllA=
=fREV
-----END PGP SIGNATURE-----

--Bj0Pc5S9outuGiwk--
