Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FE1D1739
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636169; cv=none; b=X2wDV7hB4okidkxRNA7SqtARMejc1lGFm0l/nQPjTJcpuchse52lS1a8wpDOeC+oaLf+FF/gOLHbYTO3HEjVNL35OqX9U2LUnMsf1ovN2fPWeoJoQ9+IsGHJ+vZN+1SJ2IfgoqRoxDah90JIelPXaIXTt8+bwz7X3aFZRH0KQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636169; c=relaxed/simple;
	bh=BqSguWs8HdIeubavwEEdgQ0RAcFTIwPcMJlfZJ1Y4e8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bOe9aaNYwkrEO7Veo5VswbD1XZ3XIgNlg39kFEPmCUw01QTzXXEn+WKrwD7dDAB45pyEwkKhRL17gMP7nLYis/hAn91EmAd7sgrQPsSA1vBNHBF4pci/JUDBXI4Q0Of9F3GM/ZFoGxQrnOBChjd59NaXZTo5jh4dqt7Bvs4wZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=FDxIGJQg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPyvLkPW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="FDxIGJQg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPyvLkPW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BB99813801ED;
	Fri,  6 Sep 2024 11:22:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Sep 2024 11:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1725636165; x=1725722565; bh=f+DjHeIBx+kJlWS3EmU6amSnETDiY7Qo
	EJ7biptNW1o=; b=FDxIGJQgtbFZANO+1EzRQ+ah3/UY1RxqeucbO0qZgCQuejZu
	Px7sHg94Xhi9KaHxdTJMAK1niqP2UAjgypd/95etuAP8rWMDKhbgoXydNKbdYpyn
	OvLD8008Y6TK2yQLFDRDFL3JG+Xt+yqdjRRbeifc849YF0V06Xri15CTLVBPC/xL
	21kodHSp5Dt7TJqrA1uQLA4+lXVpEgxC5rpMfrxgfemdaRuvMca1Oy8jTCb8/3DQ
	NFX+HTl9MnezqQGaWxoAAlhfU5Vsv1Vh3C+bU5kedTj6smNtThgN78McGmxyIPkc
	lbSANU5HVpmX7/TdaczgxCpTYYnAbWXocg2IYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725636165; x=
	1725722565; bh=f+DjHeIBx+kJlWS3EmU6amSnETDiY7QoEJ7biptNW1o=; b=F
	PyvLkPWKvY2BnbGvgwQ5OGXYGiTiBwDhxwieDOy2FW2VmJ3lshmxnMbsxS0BPggr
	AwnYCQBEBqHKtOxZL82nq/Xkj0hwUV2QFi9f1e8S9mp1z8Mx8jVIg30XIkxFVpBN
	jvBjyjsOeOFezUbyQIraCLm4dO+xk3RJ1YDK/Vm83eTF0s2AHxiN5gGOBVEm7G5s
	x6X6smI7IW1YJjOOBp6n/n/AYcXSxKW4X4KMxX+e0wcX/NbmPC+xZBu2e/XnBFGJ
	uRBSBanIpsHmITc/tNkzf/yx0jO2aT7VqyyxMafJwzM8IdTs8+KTGf9jzCQ+7WFX
	nme/VI2zc4K0bN2njZWpw==
X-ME-Sender: <xms:RR7bZiZUAHi68MmD-ym5fvv_k9PrkKtnv9io4KuFb2mW95Azi00uTg>
    <xme:RR7bZlYUvDJk_ZtE58HgoDUmA_sqeVuyxJ_DxfuM6k27RBjctRlkzwMT5PuvfSMaj
    Pe-HcjfcRaIzT30>
X-ME-Received: <xmr:RR7bZs9EAt_hIeB84nb7LyauXJ7zXwfl_aWZtgo5C_8UyoOiqyEX-rTXx2LATnUZ-To>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhf
    gjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepuehrohhokhgvucfmuhhhlhhm
    rghnnhcuoegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvg
    hrnhepleevieffgeevgfeileduveeuudekhffgteegvdefhfehhfevffdvffdugfehtedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghroh
    hokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RR7bZkqygDORsMgaD3S0TRooOtQAgv4QNxdWOnZzEkaPKnDdHV_aag>
    <xmx:RR7bZtopdlKv02URTPKF4AwFvXnH2ALBAN-p7bKg8_TNXX6pZAN3uA>
    <xmx:RR7bZiRKyGceKReR29XhrIdkGmV8kwmMM40jd4jjRgL526Uk1k-ftQ>
    <xmx:RR7bZtp6sSaeoRqbxQibo1iJ3lea7Iaz62qiW-qMCK70H1RCoreADQ>
    <xmx:RR7bZk3YhjT5st3UBU9udy1yDAX6IwGyVzrOn70vWm6cnE-iz5WsIsN4>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 11:22:44 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Should Git Tag trailer formatting work?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <20240906040434.GB4168449@coredump.intra.peff.net>
Date: Fri, 6 Sep 2024 09:22:33 -0600
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <249C7637-0032-4D53-A8A0-83935764334E@alchemists.io>
References: <E46F3EFF-66D1-4B29-BCF3-6FFAB2504411@alchemists.io>
 <20240906040434.GB4168449@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3776.700.51)

Hey Jeff, thanks.

Yeah, I can render trailer information when using your examples but =
*only* if I disable signing my tags. Here's what my global Git =
configuration looks like:

[tag]
  gpgSign =3D true
  sort =3D version:refname

...and here's a better example to demonstrate:

mkdir demo
cd demo
git init

touch one.txt
git add .
git commit --message "Added one"
git tag 0.0.0 --message "Version 0.0.0" --trailer A:0

touch two.txt
git add .
git commit --message "Added two"
git tag 0.0.1 --message "Version 0.0.1" --no-sign --trailer A:1

Notice how Version 0.0.0 creates a signed tag but Version 0.0.1 forces =
the tag to not be signed. I can then run the following:

git tag --list \
        =
--format=3D"%(refname:short)|%(taggerdate:short)|%(taggername)|%(subject)|=
%(trailers:key=3DA)" \
       | column -s "|" -t

...to produce this output:

0.0.0  2024-09-06  Brooke Kuhlmann  Version 0.0.0
0.0.1  2024-09-06  Brooke Kuhlmann  Version 0.0.1  A: 1

So I can see that Git tag trailers are working but only if my tags are =
*not* signed. Here's what each tag looks like when I cat them out:

git cat-file tag 0.0.0

object ad13b82ff41d5698cfb03a06b95e6e5a98386ed4
type commit
tag 0.0.0
tagger Brooke Kuhlmann <brooke@alchemists.io> 1725635799 -0600

Version 0.0.0

A: 0
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0UiFiNLe33PmLweh8rxJvE/7mkgFAmbbHNcACgkQ8rxJvE/7
mkiBFRAAlaFfRQK6fK4J9z49tF9OR0vMJRygtR4LZE1z2JmPUTTapKf8meIFIFxU
GeIAfcD8aofgV6WeGDCIaL0Kg0quInlWA19Y+Yqv5ZL3J6dEkWu8R9hmgKK8jCPo
U+EtaCSv0cM+ZmN4paCM9ZirdvnTQY5gaTJ9D+xreklaqZSryrAFfMH6UdsGnFtQ
KkR+G2B9RCuD2loV5KBIttYAhnGf54xJxfGFcZiIGD/qErWWgABIN6zDP5SHPMXz
NOjDDLh3ZUA0D1nXqxS7Aq4fe4wrRIGmtLs+Kh+fnHLuhfBh7vqrkUBydGjiGuc3
bQVOHCxe3kpfqS+P/12aGfc4yTWdL89qBWZGCEtTPw4wqLAOvzMzJ6ffc6TKdz6r
mNsV4ZWKwigS6KpCyJt1ecWq3jAZIPwx2ADsw/JQm82LfcTrn3d3nIV/0qpM0oVL
jOoZh+ozPq2bWZWqHk6PfaW2m0dKN8w9o9paJGUdyj5KjolLtak7sY067ATbIFXM
hdkpFAhvc6VhFNIcfYStLd1yJggCigpXbtx/+QG/PMMx6wMwcz0kko1KfWW4fxs0
SiEbHO3Ja0o1DG31QFb54MOi8I7n8xVgtckSj+dr+/b4hEv8b1BS5x61NJaTsxu4
PQcWEburYAPeFkbmT/ji52vCLOetQ4GPEc2+sDPvZioxQgUuhzk=3D
=3Dv8eJ
-----END PGP SIGNATURE-----



git cat-file tag 0.0.1

object e10b4d0578a5b309aac31d036a2d33a7389eff2e
type commit
tag 0.0.1
tagger Brooke Kuhlmann <brooke@alchemists.io> 1725635858 -0600

Version 0.0.1

A: 1

So it seems like signing my tags is causing trailer information to be =
lost?


> On Sep 5, 2024, at 10:04=E2=80=AFPM, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Sep 05, 2024 at 10:05:24AM -0600, Brooke Kuhlmann wrote:
>=20
>> With the recent release of Git 2.46.0, the ability to add trailers to =
tags was added which is great! However, when attempting to list and =
format trailer information, I don't see the trailer information display =
using the following Bash code:
>>=20
>> ```=20
>> git tag --list \
>>        --color \
>>        =
--format=3D"%(color:yellow)%(refname:short)%(color:reset)|%(taggerdate:sho=
rt)|%(color:blue)%(color:bold)%(taggername)%(color:reset)|%(subject)|%(tra=
ilers:key=3DInsertions)" \
>>        | column -s"|" -t
>> ```
>=20
> This seems to work fine for me. If I do:
>=20
>  {
> 	echo "Version 0.0.0"
> 	echo
> 	echo "An example."
> 	echo
> 	echo "Insertions: 10"
>  } >input
>  git tag -F input foo
>=20
> then your example above produces:
>=20
>  foo  2024-09-06  Jeff King  Version 0.0.0  Insertions: 10
>=20
> I wonder if the contents of the tag are not exactly as you expect, and
> that is fooling the trailer parser (which relies on some heuristics to
> find the right spot). Can you show us the output of "git cat-file tag
> <some-tag>"? Mine looks like:
>=20
>  $ git cat-file tag foo
>  object af1c73c21ab34cfbdc86da838acacc6e45ccd264
>  type commit
>  tag foo
>  tagger Jeff King <peff@peff.net> 1725595316 -0400
>=20
>  Version 0.0.0
>=20
>  An example.
>=20
>  Insertions: 10
>=20
> -Peff

