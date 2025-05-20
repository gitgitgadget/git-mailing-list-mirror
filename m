Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088FEEC8
	for <git@vger.kernel.org>; Tue, 20 May 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718240; cv=none; b=sLAsKB5r+2HgWM751HOsv7E9VYLpjZDVN9qVn6F2EX70K3Nxir602EhEE+NGBqiFuJRMN0I7ZDamYfYwoYd6OucuxA0R3COkQ3TyVf+Xt08R6/qv86N7sIyf9F0jY9OSpX4vkKAXpfnatxfZ8lCZQaqSCTwX5xOUwuGGfKoQAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718240; c=relaxed/simple;
	bh=i8u3Hzn6aA+LdQ4GuEU1GqMvttHcu17BP3JVtgc1RXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdfTHlt9dLAfTm/3LJvFcGzoANJSDwsvM1X5zetyz6kdeCjikjx679t0W7Dqu1klwrxSZ9MT1Vdcfv9JmO80x7IdZ27G1QSYLnNyEkClR1WJT1S07saWgBWF7LJ20plnhNPv/MhVJfyBqMfhuoPKyGdbrY4LYCA0iJwjHzA0sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XwoY9jvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HBqjT+e0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XwoY9jvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBqjT+e0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 961271380426;
	Tue, 20 May 2025 01:17:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 20 May 2025 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747718235; x=1747804635; bh=tcbHx3htbP
	eNYnym16YHR2OOO3Z/3y9j2SIng02DnTw=; b=XwoY9jvsX4OgmAydxkQ0LYFbEU
	oIa2Cgooefs21kSnU1kSQlBrzb37XRQ8P1P6MZynbxQv0UaLyzw6xgxViesqhJoL
	GPkTq++nbPk2SyiBWIbLCfcOk8DgaY5tltSER8z3h0Panmoc7OmuvsixTyhX7Nwy
	j/eLmoHLlo+AZlskaHWuoC3TwH+wuZSKecfq5w3JEH9u81chGrMsBj7weNLOaEXm
	IESxCOJs5blrXeTI2IsBwELgXCot+VlJgskToxV3HyirgM75QKLZ6hX2B1AlgnbI
	y6CWZkurBVT7tY1YW09aLp5nIe3hRwMBVfUDCZxXxN36nwpn3LCshQ1kB9EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747718235; x=1747804635; bh=tcbHx3htbPeNYnym16YHR2OOO3Z/3y9j2SI
	ng02DnTw=; b=HBqjT+e0xlEGiRg97EpKzWdH1lJGxiWJtGfNhu79DzAinK/6ekG
	YYafNvT12kDwAIn7qOaIydJXRJzn8dsy0XEhMAkXIuUX8xAnsnbXzZ8HxxhT6uyU
	lSUtpVgGWFyu35PSBgDJtDunNS1IzHDTdpD+zygh65PPsPG+syCiSQKLe8I9zFTV
	SEdIIqnzs45rqtaRMr98zREukUu7Qh+0RNibhh2SL4Gy6t+WyaRYxWb1OLCdM7a5
	OkuvCRDaXz2Hh5Wu8ROF8mfG0i++Kpv4n3V498PCYYSCfLiR+BXuXS9Tr1kIJksu
	Ng/LF0h/0/aR338T2nHb2mEfPcuE0mh8frw==
X-ME-Sender: <xms:WxAsaFhPSqiEND9TFRRSL71mSWAMt64vnL_A8qYCYuJV2xkeNCxwbA>
    <xme:WxAsaKD0Aig6c3PRZz8ZLrsxGVfOyqVY_1VVPca02yvIeunE66Kb0fbygWfwkVCaW
    IEsCO6llz7P1EWnHQ>
X-ME-Received: <xmr:WxAsaFFA6utRZkJfNIiWwOwlA6f9aBuLy3Th5n0elHJRrN6IOuxpDSqJOv3L7XlKlbN29zA3DqdXK67g4FlMX8usH4WyZCkg2nM_E8g9oEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WxAsaKSUFbYIWLmm-NgtmoF4YBE4TgHdlSYqPKeXkdl3vCh2FoWvVw>
    <xmx:WxAsaCxmL2arMv7oV0hu0Clu0qitd3iHfM7iqSobgP3dELvrwfjkSQ>
    <xmx:WxAsaA6lcPFPFXalk6c3ft9mb8Zc8M0jhT4viwCBAGdJkqFLFmcp8w>
    <xmx:WxAsaHxsxsAEZt3vjI_yLGylmdqIfts1haH2TcGEQ-YHhw-rodD1iw>
    <xmx:WxAsaIrLHr3RDmnAOm7RB28t1bUfYOYPJSWa_ylwuzBkyQQXPyfbFFSe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 01:17:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0dcac22 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 20 May 2025 05:17:12 +0000 (UTC)
Date: Tue, 20 May 2025 07:17:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 2/2] builtin/receive-pack: add option to skip
 connectivity check
Message-ID: <aCwQU-SwlS8MR88l@pks.im>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250520014920.201736-1-jltobler@gmail.com>
 <20250520014920.201736-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520014920.201736-3-jltobler@gmail.com>

On Mon, May 19, 2025 at 08:49:20PM -0500, Justin Tobler wrote:
> During git-receive-pack(1), connectivity of the object graph is
> validated to ensure that the received packfile does not leave the
> repository in a broken state. This is done via git-rev-list(1) and
> walking the objects which can be expensive for large repositories.

s/objects/&,/

> 
> Generally, this check is critical to avoid an incomplete received
> packfile from corrupting a repository. Server operators may have
> additional knowledge though around exactly how Git is being used on the
> server-side which can be used to facilitate more efficient connectivity
> computatation of incoming objects.
> 
> For example, if it can be ensured that all objects in a repository are
> connected and do not depend on any missing objects, the connectivity of
> newly written objects can be checked by walking the object graph
> containing only the new objects from the updated tips and identifying
> the missing objects which represent the boundary between the new objects
> and the repository. These boundary objects can be checked in the
> canonical repository to ensure the new objects connect as expected and
> thus avoid walking the rest of the object graph.
> 
> Git itself cannot make the guarantees required for such an optimization
> as it is possible for a repository to contain an unreachable object that
> references a missing object without the repository being considered
> corrupt.

Yup, this reads very well to me now, and clearly lays out why it is an
assumption that _some_ setups can do, but others can't.

> Introduce the --skip-connectivity-check option for git-receive-pack(1)
> which bypasses this connectivity check to give more control to the
> server-side. Note that without proper server-side validation of newly
> received objects handled outside of Git, usage of this option risks
> corrupting a repository.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/git-receive-pack.adoc | 12 +++++++++
>  builtin/receive-pack.c              | 40 ++++++++++++++++-------------
>  t/t5410-receive-pack.sh             | 21 +++++++++++++++
>  3 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
> index 20aca92073..68427d93d9 100644
> --- a/Documentation/git-receive-pack.adoc
> +++ b/Documentation/git-receive-pack.adoc
> @@ -46,6 +46,18 @@ OPTIONS
>  	`$GIT_URL/info/refs?service=git-receive-pack` requests. See
>  	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
>  
> +--skip-connectivity-check::
> +	Bypasses the connectivity checks performed to validate incoming
> +	objects. This option exists for server operators that may want to
> +	implement their own object connectivity check outside of Git. This is
> +	useful in such cases where the server-side knows additional information
> +	about how Git is being used and thus can rely on guarantees to more
> +	efficiently compute object connectivity that Git itself cannot make.
> +	Usage of this option without a separate mechanism to validate and
> +	ensure incoming objects connect properly to the references risks a
> +	repository becoming corrupted and should not be used in the general
> +	case.

Nit: the connectivity check doesn't only have to verify that objects
connect to existing refs, but also that all objects part of the
transitive closure of reachable objects exist. Might be worthwhile to
point out here.

> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> index 9afea54a26..10c67c2bf8 100755
> --- a/t/t5410-receive-pack.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -62,4 +62,25 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
>  	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
>  '
>  
> +test_expect_success 'receive-pack missing objects bypasses connectivity check' '
> +	test_when_finished rm -rf repo remote.git setup.git &&
> +
> +	git init repo &&
> +	git -C repo commit --allow-empty -m 1 &&
> +	git clone --bare repo setup.git &&
> +	git -C repo commit --allow-empty -m 2 &&
> +
> +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> +	git -C repo send-pack ../setup.git --all \
> +		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> +
> +	# Replay captured git-send-pack(1) output on new empty repository.
> +	git init --bare remote.git &&
> +	git receive-pack --skip-connectivity-check remote.git <out >actual 2>err &&
> +
> +	test_grep ! "missing necessary objects" actual &&
> +	test_must_be_empty err &&

Yup, the connectivity check shouldn't fail anymore.

> +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)

And we do have the object now. Do we maybe also want to have a check
though that the repository itself _isn't_ fully connected to ensure that
the test setup isn't broken?

Patrick
