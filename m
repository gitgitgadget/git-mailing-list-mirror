Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9735184558
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209419; cv=none; b=DnRB8uzEuF0BOryscllqmCrzL3IEKf0uY1PUwh5PIUXbZQpHxmiUD76+oqp3E8cUMbl4yoovSyBkvMhWm3GIDZi82Qg6EZuokuH59ugGUcTsj5Ls9OYwbiaHISAavCkcUSTbNP9hWX+ihA9I/m0u1B51ADdq2ML0oSX8FYLeY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209419; c=relaxed/simple;
	bh=4bHT2U/zNkhL3cARPDRsMBhCq8+dZwQTzoDnOYTLsQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m32P3jnN/A6Vrk7j5q3HrekMmMK2l20Cg52hRgOKS5UTmtgjEAsPeQbYlKfS98nwAsm7Ky+HJHVoQJL0CXoL7erRP32IELTJwEH1aL/Ceqecb5CtSMLDEkRYUDvZPhYN6WL9Oma9o8Gmek4eY+hEGNHvfbrLHiGVY18ltTiu3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hD5pPP43; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k8XdN6b4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hD5pPP43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k8XdN6b4"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CA1F913805FC;
	Fri, 13 Sep 2024 02:36:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 13 Sep 2024 02:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726209415;
	 x=1726295815; bh=giNY/68RtsEU3G30IRQzBkGf2cuppe2bu4JE49Nxsgg=; b=
	hD5pPP43XkO/diJb1lePtb06Qas3FRFpJUNDSZT+9LgOIRluovBydOVlSpnDGtWL
	yCw242o5YD6U+W/e3R5g5iFC0vEMuef7dx+r5RRzy/EUG6WJR3H0/SOvGYlFtr9U
	BvZQRgtABGL1eKAKquceiR0iArCHk3Ow1mT+kaDy7j918LDQEilEQ43ZIQO07ewz
	iiHSYOy3TvJVYqV4uj3/P0kmvKrWHpB3d+grL6r5LloQ/xKLpdnhpVqJ6jJzgMPi
	jN9AiH2nCX183GXlcgR1VVjeSWh6dEKAZ+KY+OFZFj41frLoU1bdz02KVJUS8H01
	esSrIH6fFdn2lDeEShHOLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726209415; x=
	1726295815; bh=giNY/68RtsEU3G30IRQzBkGf2cuppe2bu4JE49Nxsgg=; b=k
	8XdN6b4Mj4uxJKG09fxn9tNwc/4dyUJPzBYYehV12X2owaxHZHdAmLHSI8UpXoG9
	q4iQ64479cTqx52V2r1o1YtLet6O89do5Z65wM07Zh7wUl8gdMGlBJ2eyfWoAucY
	5an1R9ggKrMdtl0aae2SEQwY3hpQ3Z2+EVRLwrLHzBQDxD81oR3xiyUQPKzQ0Uwl
	XqfEP1BbxA2ZATuKrFL4HCYbJwcYNjwDjTgxIJsvQTFuHX9QHU/6jW5QL7y3xYMA
	X9E/+iTp6Vl7+b5AG+pKNTftJqA0RRNTO5YU7d+eUpUvPYcwJELied5oP7kM9lMi
	afkUDLk15sDxsFndbpnfw==
X-ME-Sender: <xms:h93jZg1hFHFYD2xgdei7dceSdXpJzI0Qf63ZW2vGNS1wPUQigFLrJg>
    <xme:h93jZrEc0XoPfVZJ1oTaniho3sPdX0xeoGdw45okAoAXVYoN8wcwANSAXeu_Y0Znu
    JIG17YCnde83yATWQ>
X-ME-Received: <xmr:h93jZo6VXBPPbIkNVqz_E6iBmpbgGI9emr7gUuPg-G0kkyBXxYzrnyAERPsQf5RfaxwRs1OX9vmGt7r0i3nk6KuRCiTPJSsrNeyFOPoTXWfdOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeiteffteegfefhfeehudeuieeffeeulefgfeejjeef
    vdeufeduuedvjeejgeehgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhiihgvrd
    hsghdpuddvjedrtddrtddruddpfhhmihdrtghsnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoh
    epvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlheshhgrgiigrdhsvg
X-ME-Proxy: <xmx:h93jZp2tlLQIB_HDMY_0GDW96GmFKJQaGnIw6KpbTgYdGsa0OGPVPw>
    <xmx:h93jZjG-SOZxQ1CIZJqfFi-weveD1M0tKmdjhdjkNVudBkAwEKyRsA>
    <xmx:h93jZi-d67tLfvgSPKrGaD6r1rlTAp2jSjoB5NbgL3S_4i4moCnHhA>
    <xmx:h93jZom4e84LCyXxwlUtzAzu7FVe7Kiz_cSSBd1ZWD-zHDez4N7R_w>
    <xmx:h93jZoQAYYZgskkyyHV2Gx53Lf6jphA1jZ2UeFJ4zhpynerecKotRxX1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 02:36:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf9a41c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 06:36:41 +0000 (UTC)
Date: Fri, 13 Sep 2024 08:36:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Daniel Stenberg <daniel@haxx.se>
Cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
Message-ID: <ZuPdfsbHwjQPDPXc@pks.im>
References: <ZuPKvYP9ZZ2mhb4m@pks.im>
 <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>

On Fri, Sep 13, 2024 at 08:11:37AM +0200, Daniel Stenberg wrote:
> On Fri, 13 Sep 2024, Patrick Steinhardt wrote:
>=20
> > I noticed that GitLab's CI started to fail consistently with our
> > Alpine-based builds in t5559.30. After investigating a bit I couldn't
> > notice anything obvious on our side changing, so I checked whether
> > Alpine itself updated any packages. And indeed, it updated to curl 8.10
> > yesterday.
>=20
> Can you clarify for us exactly what the test case does so that we can try=
 to
> reproduce this?

In a nutshell:

  - We set up Apache with HTTP/2 support via -DHTTP2.

  - We create a bunch of Git repositories to serve via Apache. The
    number of refs in the repository is rather biggish.

  - We then clone a repository from Apache with http.postbuffer=3D65536,
    which makes us use a small buffer when POSTing data via curl. We
    typically use 1MB buffers, and when changing it back to 1MB instead
    of 65kB the test works just fine.

I've appended two curl traces, the working one with 1MB buffers and the
failing one with 65kB buffers. I hope that helps.

> We already fixed one 8.10.0 regression for HTTP/2 uploads with this PR:
>=20
>   https://github.com/curl/curl/pull/14877

I've applid 70d3a9b6a (http2: when uploading data from stdin, fix eos
forwarding, 2024-09-12), but it doesn't fix the issue. I've also
verified that the latest `master` at 8ca603083 (RELEASE-NOTES: synced,
2024-09-12) still runs into the timeout in the same way.

Patrick

### Working, 1MB buffer

=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info:   Trying 127.0.0.1:5559...
=3D=3D Info: Connected to 127.0.0.1 () port 5559
=3D=3D Info: ALPN: curl offers h2,http/1.1
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D=3D Info: TLSv1.3 (OUT), TLS handshake, Client hello (1):
=3D> Send SSL data, 0000000512 bytes (0x00000200)
=3D> Send SSL data: ...........#v.#..qb.f.2a...d.W...+.... mNB...0K.._...=
=7FUz"...
=3D> Send SSL data: .C.x.@5.....>.......,.0.........+./...$.(.k.#.'.g.....9=
=2E....
=3D> Send SSL data: 3.....=3D.<.5./.....u..................................=
=2E......
=3D> Send SSL data: h2.http/1.1.........1.....*.(..........................=
=2E....
=3D> Send SSL data: ..........+............-.....3.&.$... St.........s7..[%=
=2E44g.
=3D> Send SSL data: .Sf7+jl..\.............................................=
=2E....
=3D> Send SSL data: .......................................................=
=2E....
=3D> Send SSL data: .......................................................=
=2E....
=3D> Send SSL data: ................................
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....z
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Server hello (2):
<=3D Recv SSL data, 0000000122 bytes (0x0000007a)
<=3D Recv SSL data: ...v...o.z....a&....Bz.<,.....!.bL.f.. mNB...0K.._...=
=7FUz"...
<=3D Recv SSL data: .C.x.@5..........+.....3.$... .".1.KV.G....X.$T......o.=
=2E...x
<=3D Recv SSL data: 8?
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....=20
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
<=3D Recv SSL data, 0000000015 bytes (0x0000000f)
<=3D Recv SSL data: .............h2
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Certificate (11):
<=3D Recv SSL data, 0000000704 bytes (0x000002c0)
<=3D Recv SSL data: ...........0...0........,./..H.cz....e..40...*.H.......=
=2E0.1.
<=3D Recv SSL data: 0...U....127.0.0.10...240913063249Z..241013063249Z0.1.0=
=2E..U.
<=3D Recv SSL data: ...127.0.0.10.."0...*.H.............0..........F....OHg=
R..(.
<=3D Recv SSL data: ......X\.ue.r.|.?....k}..9.0.J....=3D0..".Y+w&.m.=3D.a.=
_!..Z....
<=3D Recv SSL data: .]U.M.\.Dk....a. v.j.pV8..FU..;..j.e.M...'<............=
y...t
<=3D Recv SSL data: ....W&....e.......d......7.7}..j.!..._8.n..5..+........=
=2E.x..
<=3D Recv SSL data: .v.........ef.....bpe..../....^.Tu....;NG.R..Y...K...L.=
=2E..l.
<=3D Recv SSL data: y.....0...*.H..............1w...w......c..i.P..2....Ht.=
:u0..
<=3D Recv SSL data: Ef!d}....=7F*KNv=7F."b....|..d..>s..M6......u..;.....&J=
<...<@.qg
<=3D Recv SSL data: ....GD.....3.6... ....Q..Nk..f.xf.xP>....]..m=3D.[OP0..=
,..t..3
<=3D Recv SSL data: ..iE8B..Mu....4j.=3D. ...ll.1....k.2<.]w.U..*.&..k.C...=
=2ET.6.A.
<=3D Recv SSL data: ......t..O...rW...1..A..y.b...I.........]...
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, CERT verify (15):
<=3D Recv SSL data, 0000000264 bytes (0x00000108)
<=3D Recv SSL data: ........Y.s.'.=3DqB.Mh.j!\..j.........>.1..F...n85n(/..=
=2E......
<=3D Recv SSL data: ....[!5Jq.\.7....E...#...,-:...m......}..4..#N.n.\+v].a=
e...7
<=3D Recv SSL data: zy..r..f.8..e...".........L..<....Hf.k;.[ M..xhY2.."L..=
aS4..
<=3D Recv SSL data: .(..:..7.....`...%. .i.uh...... oVA...iIe.Sg/.qrkN...V9=
=2En..P
<=3D Recv SSL data: .......f_..G"....:.E.%@P
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....E
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Finished (20):
<=3D Recv SSL data, 0000000052 bytes (0x00000034)
<=3D Recv SSL data: ...0D~...K.{.t_KQ.v.S...v...M...;......j..B.:tWf...x
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D=3D Info: TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....E
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D=3D Info: TLSv1.3 (OUT), TLS handshake, Finished (20):
=3D> Send SSL data, 0000000052 bytes (0x00000034)
=3D> Send SSL data: ...0.b..0..k.[.N..z.G.....*.......tMqU..Q."(E8.L...3
=3D=3D Info: SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519=
 / RSASSA-PSS
=3D=3D Info: ALPN: server accepted h2
=3D=3D Info: Server certificate:
=3D=3D Info:  subject: CN=3D127.0.0.1
=3D=3D Info:  start date: Sep 13 06:32:49 2024 GMT
=3D=3D Info:  expire date: Oct 13 06:32:49 2024 GMT
=3D=3D Info:  issuer: CN=3D127.0.0.1
=3D=3D Info:  SSL certificate verify result: self-signed certificate (18), =
continuing anyway.
=3D=3D Info:   Certificate level 0: Public key type RSA (2048/112 Bits/secB=
its), signed using sha256WithRSAEncryption
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....Q
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D=3D Info: using HTTP/2
=3D=3D Info: [HTTP/2] [1] OPENED stream for https://127.0.0.1:5559/smart/re=
po.git/info/refs?service=3Dgit-upload-pack
=3D=3D Info: [HTTP/2] [1] [:method: GET]
=3D=3D Info: [HTTP/2] [1] [:scheme: https]
=3D=3D Info: [HTTP/2] [1] [:authority: 127.0.0.1:5559]
=3D=3D Info: [HTTP/2] [1] [:path: /smart/repo.git/info/refs?service=3Dgit-u=
pload-pack]
=3D=3D Info: [HTTP/2] [1] [user-agent: git/2.46.0.556.gcfcff505c7f.dirty]
=3D=3D Info: [HTTP/2] [1] [accept: */*]
=3D=3D Info: [HTTP/2] [1] [accept-encoding: deflate, gzip, br, zstd]
=3D=3D Info: [HTTP/2] [1] [pragma: no-cache]
=3D=3D Info: [HTTP/2] [1] [git-protocol: version=3D2]
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send header, 0000000231 bytes (0x000000e7)
=3D> Send header: GET /smart/repo.git/info/refs?service=3Dgit-upload-pack H=
TTP/2
=3D> Send header: Host: 127.0.0.1:5559
=3D> Send header: User-Agent: git/2.46.0.556.gcfcff505c7f.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
<=3D Recv SSL data, 0000000265 bytes (0x00000109)
<=3D Recv SSL data: .......,9.J............#....GL.A-J.E..%...+.Q..O,.I..0F=
=2E....
<=3D Recv SSL data: ...~{O.50W(._..}..k.6..sU=7Fo..OZS.&.c.m.1a..|.1xQH...K=
Wf.....
<=3D Recv SSL data: ....P.i(V.@...@......8.%x7M.....Z.T..t..Q..'..#..h.[..'=
jp...
<=3D Recv SSL data: ......p}[.mB....HD..F%[d...]$P.S....C.J%Q=3D.&.R...M5E.=
_..7.?.
<=3D Recv SSL data: .^. Q.I..-..b,.....K..,..
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
<=3D Recv SSL data, 0000000265 bytes (0x00000109)
<=3D Recv SSL data: .......,..V............#....GL.A-J.E..%$.....D.A..5....=
=2E..B.
<=3D Recv SSL data: 5..'.Y..X,.Z...ba..[.)0...eZ-.X......iZ)...0.......w.d.=
=2E.km.
<=3D Recv SSL data: ..I.m...`W..r.?...B.. 7.yF....RLW.Mt"4.q....(.$>bE.....=
OT..D
<=3D Recv SSL data: u.x...o.O*..T:t...N..3.o.c... ........A...*e.:.tD...F..=
=2E..=3D.
<=3D Recv SSL data: ..*..8....P...._...|..0..
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....-
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D=3D Info: Request completely sent off
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv header, 0000000013 bytes (0x0000000d)
<=3D Recv header: HTTP/2 200
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: cache-control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000059 bytes (0x0000003b)
<=3D Recv header: content-type: application/x-git-upload-pack-advertisement
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: date: Fri, 13 Sep 2024 06:32:49 GMT
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: server: Apache/2.4.62 (Unix) OpenSSL/3.0.14
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000154 bytes (0x0000009a)
<=3D Recv data: 000eversion 2.002cagent=3Dgit/2.46.0.556.gcfcff505c7f.dirty=
=2E00
<=3D Recv data: 13ls-refs=3Dunborn.0020fetch=3Dshallow wait-for-done.0012se=
rver-
<=3D Recv data: option.0017object-format=3Dsha1.0000
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000000 bytes (0x00000000)
=3D=3D Info: Connection #0 to host 127.0.0.1 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Re-using existing connection with host 127.0.0.1
=3D=3D Info: [HTTP/2] [3] OPENED stream for https://127.0.0.1:5559/smart/re=
po.git/git-upload-pack
=3D=3D Info: [HTTP/2] [3] [:method: POST]
=3D=3D Info: [HTTP/2] [3] [:scheme: https]
=3D=3D Info: [HTTP/2] [3] [:authority: 127.0.0.1:5559]
=3D=3D Info: [HTTP/2] [3] [:path: /smart/repo.git/git-upload-pack]
=3D=3D Info: [HTTP/2] [3] [user-agent: git/2.46.0.556.gcfcff505c7f.dirty]
=3D=3D Info: [HTTP/2] [3] [accept-encoding: deflate, gzip, br, zstd]
=3D=3D Info: [HTTP/2] [3] [content-type: application/x-git-upload-pack-requ=
est]
=3D=3D Info: [HTTP/2] [3] [accept: application/x-git-upload-pack-result]
=3D=3D Info: [HTTP/2] [3] [git-protocol: version=3D2]
=3D=3D Info: [HTTP/2] [3] [content-length: 198]
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....E
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send header, 0000000303 bytes (0x0000012f)
=3D> Send header: POST /smart/repo.git/git-upload-pack HTTP/2
=3D> Send header: Host: 127.0.0.1:5559
=3D> Send header: User-Agent: git/2.46.0.556.gcfcff505c7f.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 198
=3D> Send header:
=3D> Send data, 0000000198 bytes (0x000000c6)
=3D> Send data: 0014command=3Dls-refs.002bagent=3Dgit/2.46.0.556.gcfcff505c=
7f.di
=3D> Send data: rty0016object-format=3Dsha100010009peel.000csymrefs.000bunb=
orn
=3D> Send data: .0014ref-prefix HEAD.001bref-prefix refs/heads/.001aref-pref
=3D> Send data: ix refs/tags/.0000
=3D=3D Info: upload completely sent off: 198 bytes
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....<
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv header, 0000000013 bytes (0x0000000d)
<=3D Recv header: HTTP/2 200
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: cache-control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: content-type: application/x-git-upload-pack-result
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: date: Fri, 13 Sep 2024 06:32:49 GMT
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: server: Apache/2.4.62 (Unix) OpenSSL/3.0.14
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000145 bytes (0x00000091)
<=3D Recv data: 0050f39a92305d069e3dcdc4ce95c3001deec3642dc3 HEAD symref-tar
<=3D Recv data: get:refs/heads/main.003df39a92305d069e3dcdc4ce95c3001deec364
<=3D Recv data: 2dc3 refs/heads/main.0000
<=3D Recv data, 0000000000 bytes (0x00000000)
=3D=3D Info: Connection #0 to host 127.0.0.1 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Re-using existing connection with host 127.0.0.1
=3D=3D Info: [HTTP/2] [5] OPENED stream for https://127.0.0.1:5559/smart/re=
po.git/git-upload-pack
=3D=3D Info: [HTTP/2] [5] [:method: POST]
=3D=3D Info: [HTTP/2] [5] [:scheme: https]
=3D=3D Info: [HTTP/2] [5] [:authority: 127.0.0.1:5559]
=3D=3D Info: [HTTP/2] [5] [:path: /smart/repo.git/git-upload-pack]
=3D=3D Info: [HTTP/2] [5] [user-agent: git/2.46.0.556.gcfcff505c7f.dirty]
=3D=3D Info: [HTTP/2] [5] [accept-encoding: deflate, gzip, br, zstd]
=3D=3D Info: [HTTP/2] [5] [content-type: application/x-git-upload-pack-requ=
est]
=3D=3D Info: [HTTP/2] [5] [accept: application/x-git-upload-pack-result]
=3D=3D Info: [HTTP/2] [5] [git-protocol: version=3D2]
=3D=3D Info: [HTTP/2] [5] [content-length: 240]
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....8
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send header, 0000000303 bytes (0x0000012f)
=3D> Send header: POST /smart/repo.git/git-upload-pack HTTP/2
=3D> Send header: Host: 127.0.0.1:5559
=3D> Send header: User-Agent: git/2.46.0.556.gcfcff505c7f.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 240
=3D> Send header:
=3D> Send data, 0000000240 bytes (0x000000f0)
=3D> Send data: 0011command=3Dfetch002bagent=3Dgit/2.46.0.556.gcfcff505c7f.=
dirty
=3D> Send data: 0016object-format=3Dsha10001000dthin-pack000fno-progress000=
dof
=3D> Send data: s-delta0032want f39a92305d069e3dcdc4ce95c3001deec3642dc3.003
=3D> Send data: 2want f39a92305d069e3dcdc4ce95c3001deec3642dc3.0009done.0000
=3D=3D Info: upload completely sent off: 240 bytes
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....!
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv header, 0000000013 bytes (0x0000000d)
<=3D Recv header: HTTP/2 200
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: cache-control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: content-type: application/x-git-upload-pack-result
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: date: Fri, 13 Sep 2024 06:32:49 GMT
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: server: Apache/2.4.62 (Unix) OpenSSL/3.0.14
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....'
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000013 bytes (0x0000000d)
<=3D Recv data: 000dpackfile.
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000230 bytes (0x000000e6)
<=3D Recv data: 00e0.PACK..........x.+)JMU00775N31.073ML6LLK5202H22I510.0.0.
<=3D Recv data: LJ1I.0.J,-../RpT.U..1l .......9.z...v....F..&.....@c......%%
<=3D Recv data: .E.........\..n...T....0...x.340031QH..Ie..ou..].Ui...`.....
<=3D Recv data: O.......8x.K..+I.+........}....#Z.l.R.v.D.\.0006..
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000004 bytes (0x00000004)
<=3D Recv data: 0000
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000000 bytes (0x00000000)
=3D=3D Info: Connection #0 to host 127.0.0.1 left intact

### Failing

=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info:   Trying 127.0.0.1:5559...
=3D=3D Info: Connected to 127.0.0.1 () port 5559
=3D=3D Info: ALPN: curl offers h2,http/1.1
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D=3D Info: TLSv1.3 (OUT), TLS handshake, Client hello (1):
=3D> Send SSL data, 0000000512 bytes (0x00000200)
=3D> Send SSL data: .......e.K.6.u....b..."p.p..0.S...oJ}. .6...........a..=
=2E.!..
=3D> Send SSL data: ...Q..u.9...>.......,.0.........+./...$.(.k.#.'.g.....9=
=2E....
=3D> Send SSL data: 3.....=3D.<.5./.....u..................................=
=2E......
=3D> Send SSL data: h2.http/1.1.........1.....*.(..........................=
=2E....
=3D> Send SSL data: ..........+............-.....3.&.$... ....S..[%t.S].+..=
=2E...4
=3D> Send SSL data: .C.G=7F..<.;...........................................=
=2E......
=3D> Send SSL data: .......................................................=
=2E....
=3D> Send SSL data: .......................................................=
=2E....
=3D> Send SSL data: ................................
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....z
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Server hello (2):
<=3D Recv SSL data, 0000000122 bytes (0x0000007a)
<=3D Recv SSL data: ...v......%.jD]3....Q...t.v.;....H.K;. .6...........a..=
=2E.!..
<=3D Recv SSL data: ...Q..u.9........+.....3.$... ...(......r.^.=3DL......F=
mI.CS.A
<=3D Recv SSL data: .4
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....=20
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
<=3D Recv SSL data, 0000000015 bytes (0x0000000f)
<=3D Recv SSL data: .............h2
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Certificate (11):
<=3D Recv SSL data, 0000000704 bytes (0x000002c0)
<=3D Recv SSL data: ...........0...0.....O~.......F.......I.d0...*.H.......=
=2E0.1.
<=3D Recv SSL data: 0...U....127.0.0.10...240913063318Z..241013063318Z0.1.0=
=2E..U.
<=3D Recv SSL data: ...127.0.0.10.."0...*.H.............0.........y..i.^xtl=
=2E....
<=3D Recv SSL data: .D:..g...B[................s.P.Ea.O...M[....#Q. ..g._U.=
&..l9
<=3D Recv SSL data: ...uU......w... ...6.x...U........&.H|.+....H..bm....w.=
=2E.tx.
<=3D Recv SSL data: .....~\k....f4........u...6..1.[Z.Bu.X...H...!..h%.O.'.=
RdNG.
<=3D Recv SSL data: o..V.p.0.u60.....<.....^kC..n.w..=3D..y.*J(n....m...lB.=
=2E.K....
<=3D Recv SSL data: ......0...*.H..............[....0.X..if.C{....d..n....k=
=2EAI..
<=3D Recv SSL data: ......Q..m....>.m.i^.W=7F.S..,Pt.m.........Uo..Qk.*.u.w=
=2E.9lM..
<=3D Recv SSL data: .........k....L2.5..7+...j.cU...E.je..QPG.jt..H..~.P.(.=
=2E./.A
<=3D Recv SSL data: ..S.b...[hV.r....35.`..(..a.........u<e.9..P.N........8=
=2E.*.%
<=3D Recv SSL data: \(.......Sj...\l.3J...=7F..#..=3D{.~...^...Zv...
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, CERT verify (15):
<=3D Recv SSL data, 0000000264 bytes (0x00000108)
<=3D Recv SSL data: ........o.P..jt.2m.L4)..9p...K..................i.. G.$=
yz.U=20
<=3D Recv SSL data: A..s.CPk.....A........]....f.P.\(0...>..a.~}"......|.5.=
=2E..=3D.
<=3D Recv SSL data: N...|.6.M.g....1.........>.8.....h1....-.1.].o.yO......=
Ex(.g
<=3D Recv SSL data: .Y.u..+...<.2...[::y.....2bL.....|..._.<...n.9.+d....X.=
8-A~D
<=3D Recv SSL data: _.T.^.}......c..A]*G....
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....E
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Finished (20):
<=3D Recv SSL data, 0000000052 bytes (0x00000034)
<=3D Recv SSL data: ...0...nl.I..$..f.3.3T.+.i.......8f..1e.{G.....@5J..
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D=3D Info: TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....E
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D=3D Info: TLSv1.3 (OUT), TLS handshake, Finished (20):
=3D> Send SSL data, 0000000052 bytes (0x00000034)
=3D> Send SSL data: ...0|.*2\{U.Z.<..9.......-i..9..bnE. V....R...([.d..
=3D=3D Info: SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519=
 / RSASSA-PSS
=3D=3D Info: ALPN: server accepted h2
=3D=3D Info: Server certificate:
=3D=3D Info:  subject: CN=3D127.0.0.1
=3D=3D Info:  start date: Sep 13 06:33:18 2024 GMT
=3D=3D Info:  expire date: Oct 13 06:33:18 2024 GMT
=3D=3D Info:  issuer: CN=3D127.0.0.1
=3D=3D Info:  SSL certificate verify result: self-signed certificate (18), =
continuing anyway.
=3D=3D Info:   Certificate level 0: Public key type RSA (2048/112 Bits/secB=
its), signed using sha256WithRSAEncryption
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....Q
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D=3D Info: using HTTP/2
=3D=3D Info: [HTTP/2] [1] OPENED stream for https://127.0.0.1:5559/smart/re=
po.git/info/refs?service=3Dgit-upload-pack
=3D=3D Info: [HTTP/2] [1] [:method: GET]
=3D=3D Info: [HTTP/2] [1] [:scheme: https]
=3D=3D Info: [HTTP/2] [1] [:authority: 127.0.0.1:5559]
=3D=3D Info: [HTTP/2] [1] [:path: /smart/repo.git/info/refs?service=3Dgit-u=
pload-pack]
=3D=3D Info: [HTTP/2] [1] [user-agent: git/2.46.0.556.gcfcff505c7f.dirty]
=3D=3D Info: [HTTP/2] [1] [accept: */*]
=3D=3D Info: [HTTP/2] [1] [accept-encoding: deflate, gzip, br, zstd]
=3D=3D Info: [HTTP/2] [1] [pragma: no-cache]
=3D=3D Info: [HTTP/2] [1] [git-protocol: version=3D2]
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send header, 0000000231 bytes (0x000000e7)
=3D> Send header: GET /smart/repo.git/info/refs?service=3Dgit-upload-pack H=
TTP/2
=3D> Send header: Host: 127.0.0.1:5559
=3D> Send header: User-Agent: git/2.46.0.556.gcfcff505c7f.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D=3D Info: Request completely sent off
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
<=3D Recv SSL data, 0000000265 bytes (0x00000109)
<=3D Recv SSL data: .......,.#..............<....T..Xpu..............X~....=
=2E..b.
<=3D Recv SSL data: ..dW{-.*@...!c.....C..."4<...o.8\.W^Yhev.w.o......k.e..=
=2EA.B.
<=3D Recv SSL data: ....k..B....R..R....3...G.X<.nO>...v|.7z'..(+...u<.Ob..=
/.*y.
<=3D Recv SSL data: :a.=3D..`..1..F c..G..H....'8....|h.=7F.?.b............=
=2E..../f#.
<=3D Recv SSL data: ..n.......=7F..x..M...)t...
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D=3D Info: TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
<=3D Recv SSL data, 0000000265 bytes (0x00000109)
<=3D Recv SSL data: .......,{.p.............<....T..Xpu.....v........".,.a<=
=2E..lV
<=3D Recv SSL data: .v..g.........k.....zjo........J..... .. _....u....S..v=
=2E..>.
<=3D Recv SSL data: ...}.N.9#bc.(.-kn..G5..N.....4....i^6.&....}..../b.z.`.=
=2E....
<=3D Recv SSL data: .-....I.C.w../..[.._W.Id..Q,..n....F(`.....t...K.\.....=
=2E.2.O
<=3D Recv SSL data: ..u.-..x..A..e....D.[8@..
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....-
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv header, 0000000013 bytes (0x0000000d)
<=3D Recv header: HTTP/2 200
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: cache-control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000059 bytes (0x0000003b)
<=3D Recv header: content-type: application/x-git-upload-pack-advertisement
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: date: Fri, 13 Sep 2024 06:33:18 GMT
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: server: Apache/2.4.62 (Unix) OpenSSL/3.0.14
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000154 bytes (0x0000009a)
<=3D Recv data: 000eversion 2.002cagent=3Dgit/2.46.0.556.gcfcff505c7f.dirty=
=2E00
<=3D Recv data: 13ls-refs=3Dunborn.0020fetch=3Dshallow wait-for-done.0012se=
rver-
<=3D Recv data: option.0017object-format=3Dsha1.0000
<=3D Recv data, 0000000000 bytes (0x00000000)
=3D=3D Info: Connection #0 to host 127.0.0.1 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Re-using existing connection with host 127.0.0.1
=3D=3D Info: [HTTP/2] [3] OPENED stream for https://127.0.0.1:5559/smart/re=
po.git/git-upload-pack
=3D=3D Info: [HTTP/2] [3] [:method: POST]
=3D=3D Info: [HTTP/2] [3] [:scheme: https]
=3D=3D Info: [HTTP/2] [3] [:authority: 127.0.0.1:5559]
=3D=3D Info: [HTTP/2] [3] [:path: /smart/repo.git/git-upload-pack]
=3D=3D Info: [HTTP/2] [3] [user-agent: git/2.46.0.556.gcfcff505c7f.dirty]
=3D=3D Info: [HTTP/2] [3] [content-type: application/x-git-upload-pack-requ=
est]
=3D=3D Info: [HTTP/2] [3] [accept: application/x-git-upload-pack-result]
=3D=3D Info: [HTTP/2] [3] [content-length: 4]
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....=7F
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send header, 0000000234 bytes (0x000000ea)
=3D> Send header: POST /smart/repo.git/git-upload-pack HTTP/2
=3D> Send header: Host: 127.0.0.1:5559
=3D> Send header: User-Agent: git/2.46.0.556.gcfcff505c7f.dirty
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Content-Length: 4
=3D> Send header:
=3D> Send data, 0000000004 bytes (0x00000004)
=3D> Send data: 0000
=3D=3D Info: upload completely sent off: 4 bytes
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....<
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv header, 0000000013 bytes (0x0000000d)
<=3D Recv header: HTTP/2 200
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: cache-control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: content-type: application/x-git-upload-pack-result
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: date: Fri, 13 Sep 2024 06:33:18 GMT
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: server: Apache/2.4.62 (Unix) OpenSSL/3.0.14
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: .....
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv data, 0000000000 bytes (0x00000000)
=3D=3D Info: Connection #0 to host 127.0.0.1 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Re-using existing connection with host 127.0.0.1
=3D=3D Info: [HTTP/2] [5] OPENED stream for https://127.0.0.1:5559/smart/re=
po.git/git-upload-pack
=3D=3D Info: [HTTP/2] [5] [:method: POST]
=3D=3D Info: [HTTP/2] [5] [:scheme: https]
=3D=3D Info: [HTTP/2] [5] [:authority: 127.0.0.1:5559]
=3D=3D Info: [HTTP/2] [5] [:path: /smart/repo.git/git-upload-pack]
=3D=3D Info: [HTTP/2] [5] [user-agent: git/2.46.0.556.gcfcff505c7f.dirty]
=3D=3D Info: [HTTP/2] [5] [accept-encoding: deflate, gzip, br, zstd]
=3D=3D Info: [HTTP/2] [5] [content-type: application/x-git-upload-pack-requ=
est]
=3D=3D Info: [HTTP/2] [5] [accept: application/x-git-upload-pack-result]
=3D=3D Info: [HTTP/2] [5] [git-protocol: version=3D2]
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....W
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send header, 0000000282 bytes (0x0000011a)
=3D> Send header: POST /smart/repo.git/git-upload-pack HTTP/2
=3D> Send header: Host: 127.0.0.1:5559
=3D> Send header: User-Agent: git/2.46.0.556.gcfcff505c7f.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D> Send data, 0000000020 bytes (0x00000014)
=3D> Send data: 0014command=3Dls-refs.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....E
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000043 bytes (0x0000002b)
=3D> Send data: 002bagent=3Dgit/2.46.0.556.gcfcff505c7f.dirty
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....0
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000022 bytes (0x00000016)
=3D> Send data: 0016object-format=3Dsha1
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000004 bytes (0x00000004)
=3D> Send data: 0001
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....#
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000009 bytes (0x00000009)
=3D> Send data: 0009peel.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....&
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000012 bytes (0x0000000c)
=3D> Send data: 000csymrefs.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....%
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000011 bytes (0x0000000b)
=3D> Send data: 000bunborn.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000020 bytes (0x00000014)
=3D> Send data: 0014ref-prefix HEAD.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....5
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000027 bytes (0x0000001b)
=3D> Send data: 001bref-prefix refs/heads/.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: ....4
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000026 bytes (0x0000001a)
=3D> Send data: 001aref-prefix refs/tags/.
=3D> Send SSL data, 0000000005 bytes (0x00000005)
=3D> Send SSL data: .....
=3D> Send SSL data, 0000000001 bytes (0x00000001)
=3D> Send SSL data: .
=3D> Send data, 0000000004 bytes (0x00000004)
=3D> Send data: 0000
=3D=3D Info: upload completely sent off: 198 bytes
<=3D Recv SSL data, 0000000005 bytes (0x00000005)
<=3D Recv SSL data: ....0
<=3D Recv SSL data, 0000000001 bytes (0x00000001)
<=3D Recv SSL data: .
<=3D Recv header, 0000000013 bytes (0x0000000d)
<=3D Recv header: HTTP/2 408
<=3D Recv header, 0000000021 bytes (0x00000015)
<=3D Recv header: content-length: 221
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: content-type: text/html; charset=3Diso-8859-1
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: date: Fri, 13 Sep 2024 06:33:18 GMT
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: server: Apache/2.4.62 (Unix) OpenSSL/3.0.14
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000221 bytes (0x000000dd)
<=3D Recv data: <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">.<html><he
<=3D Recv data: ad>.<title>408 Request Timeout</title>.</head><body>.<h1>Req
<=3D Recv data: uest Timeout</h1>.<p>Server timeout waiting for the HTTP req
<=3D Recv data: uest from the client.</p>.</body></html>.
<=3D Recv data, 0000000000 bytes (0x00000000)
=3D=3D Info: Connection #0 to host 127.0.0.1 left intact
