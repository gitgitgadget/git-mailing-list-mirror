Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5F15696E
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819120; cv=none; b=QSTx38fUHTDSRiLeEoafBBHuwp4diDwmm1ueHEzv2mIrHl+18FAbss8FoldzUs1rb9/WaTAsVTJqT22XJutz9Y2Vat5VrtM0OXc9gWs5TaJ6HT+c9bjOlrvCyP7Liw3ug8PLZlOZ3nP9Mc7la5jgB8AdWWRIy6+YVpfC5Z7JF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819120; c=relaxed/simple;
	bh=oLYbltn6mvrvcbiPRWNGwoOyEgIyXNiHO5yNUQ3UFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf2YtXDa5A4p4zp83vTCvfl1mBWc6JldHNUEMbH1P8v6oKYsFJRy27bIZcANdrZGuGfbCmONUeqycZ04FUli8fRRf2sHmDSBAcfvEDgO9DLjc/9baxXRU3/tPj0zKvPvMjKsoMHrN+PKYTtMn23LO7zoj7TK0eT9CiCVjWz1CvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VDK8Qhxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9OCZfuc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VDK8Qhxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9OCZfuc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4A07A1380677;
	Wed, 24 Jul 2024 07:05:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 07:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721819116; x=1721905516; bh=lfF4jDyM6a
	a9xbdYq7HVSN3dQzqpQFMbIiUfAu+t+Z8=; b=VDK8Qhxdev1qw1U7nrqbBwVAtv
	kir3vFLMfbRcu1kDKJKeXgyfgthQLWb/au1n9yKx0slYLvH65CmRZqLGZE6/sf/R
	HxBqNyavS4eamE0KuGf4fQuU0Qs4vlPuDhruWShs3npnfaVTEeQqMglWJBKhYQy/
	VsKRCUmVv1fP/MxNTqa1cgEW6f48LoumSmZeodJc3M8ocVFbr5r4OqwRJANgdd1L
	e9Ldt1NE703++ATmeRXEKPcg5q8FC4tfbKRbOQ78gMhFTv0Xltswo2qh7ukmrF+X
	8UjcROuxKo5mJew4B2L4Wi7lszzhO/SaIHt6+iRJ2Y/ixhbxAXhILO0yP2Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721819116; x=1721905516; bh=lfF4jDyM6aa9xbdYq7HVSN3dQzqp
	QFMbIiUfAu+t+Z8=; b=c9OCZfuc+sbonixw1FUYYaAMISUJ5O+MDjsTzOcXzj2b
	mLL39ILqvJ0PwUv55/k1z/wisKfRO+iJypLoURcN4zUOc/QzWKOS0VYge0QSsTvJ
	uJDxlLgt6gIW1Hjuoo7uydf3ZppezUyAC3fmWzVuYJHDguxl2tLauEuqykHvlOFf
	eV4a4d3mB4QJyeie1I1lhIIVj0gFh9nAo/k506KgMJlbfOjf8opREn3lSRr+rHFy
	jhZ8fI24I7qydIhsmZ/cgzhu9EciZzbt3/36bHg82aIvdUQGSkkwz2NgvHspe2fH
	fVBrG+crFPRn91XI6jM/52sG9i6C6sVv+qPiz0kmCw==
X-ME-Sender: <xms:7N-gZg1lSHkUB9UTKjJubHFmaEuK1k5UifNVlP0KNw11SD4YAMpdlg>
    <xme:7N-gZrHQjmQ_vHoS-If2L7Er6bgAQLhoOpS0iEH1-pQLpn5Ay5Chd9_EUF8YZSpWr
    7wMO8PRNrVnkpwiGg>
X-ME-Received: <xmr:7N-gZo452vhv2UEZmXyVJHBfreHExJcxRyY-aJNL3zXVtmAr8H4RCLCEoDcDxozriPzbpYF81jOnhKhTd0Jz6C9lcgEW14Pdt0kBXF4H1MSwKUkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:7N-gZp2Ba3wam9aD1IzZIimHIVTvFOafZH_LmjHj2V0F7RkB0dC6RA>
    <xmx:7N-gZjECOW8PsgjyoOiQTFF8RsOXCnn-83aV1Bl_ZC9Y6nYM8CH55Q>
    <xmx:7N-gZi-RUJecCy1J1A1tfYc9aChWpOu5xunOyR6TQFJT8ao2ZOOhtg>
    <xmx:7N-gZomcr9sJIzbFPgm-pFO4VoxynNzaxx9EbINRU8cRG7E4LWanBQ>
    <xmx:7N-gZoTElTtd0FoWRDV0gaSQtJjgwyDezC0sAwE4xFyL49Kg1qLouRuD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 07:05:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1c9a0c52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 11:03:59 +0000 (UTC)
Date: Wed, 24 Jul 2024 13:05:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/3] Documentation: clarify indentation style for C
 preprocessor directives
Message-ID: <64e0b449936a6828ead98438d621f7e7684546c8.1721818488.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vaVQcalAjkg2HV8C"
Content-Disposition: inline
In-Reply-To: <cover.1721818488.git.ps@pks.im>


--vaVQcalAjkg2HV8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There has recently been some discussion around how C preprocessor
directives shall be indented [1]. This discussion was settled towards
indenting after the hash by two spaces [2]. Document it as such.

[1]: https://lore.kernel.org/all/xmqqwmmm1bw6.fsf@gitster.g/
[2]: https://lore.kernel.org/all/20240708092317.267915-2-karthik.188@gmail.=
com/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03..1d09384f28 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -214,6 +214,16 @@ For C programs:
  - We use tabs to indent, and interpret tabs as taking up to
    8 spaces.
=20
+ - Nested C preprocessor directives are indented after the hash by two
+   spaces per nesting level.
+
+	#if FOO
+	#  include <foo.h>
+	#  if BAR
+	#    include <bar.h>
+	#  endif
+	#endif
+
  - We try to keep to at most 80 characters per line.
=20
  - As a Git developer we assume you have a reasonably modern compiler
--=20
2.46.0.rc1.dirty


--vaVQcalAjkg2HV8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmag3+gACgkQVbJhu7ck
PpQGvg//R6v63LasVqlrzNH2GkrngwByu9uVgXptkyuduVDbT2Ici28RAcm+Hypq
+7qkBSPevfqNezbi24OXsTZvOKNohEKwJtxM4JSlED3rFiS7Nc4g0HQXGiuOFdfq
dnZK334D1+au9fsmitd577j48r9kgubRlHbywCM0GzyeOvV/fzZhoPg0nRaxekHI
hulseZjcTkW2HjlUN/qUNGTxJ4I7txV90Swd5IMT3MwGq8lsOMzWE7uD7RDYuqtj
Tw44ERGrMxda/updQbq8kscB0Nh0cWvTeqcqwLL/Zf7ylW6SR2JFcwlVS42/ddkx
ikdPeZKprnWMKrlM/cLhWrDt14SXyfrqdGngrH0nkDjIRhwzEM0rZOap0IZHpFhV
PzrHscGvPhqMS10ODL73UztfFxCUDhgLlauTwgZ8ezQuNFQAQu/WySZqllkIevqK
xkCe1qE0dL9zzH31ElOT2eZ+eALOYmVH2EGNMeTpu3Jo3sKdkKvUP4HzazRueLtn
TprW93gbIUaQzxm0Hn5RVEJ6/WtLMGF7c3wED8w+d/Yi2G6nSOyuEGIq8wSr/K6k
rZulS2Fg91H1Fj9TjjOLLvcQ2TO+RzFut4xxhNPWp6eNUbqvc/O4mtqOV19HhL6V
KwDvaHmLj4mb2hZvWfVfLM3C1SNR3W9Y9l/pUKoNe0YdC3GDB/4=
=lhfR
-----END PGP SIGNATURE-----

--vaVQcalAjkg2HV8C--
