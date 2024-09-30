Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69930161320
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683031; cv=none; b=J5BqlZ/U1gJumcGjVAcaCuiC+bcb5OUIARQ8BMght7Dv/XkD0mydc9fOTm+uKij10KgjY/sbAtYHsSO9shpLNtBcyM6RGTaTChaMoHgLqV2bg2mqNH36kBWvM6q54A2lPbix34dkCtwLb/ZMhRKGv7VLhdkcop9chRR1FoGVwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683031; c=relaxed/simple;
	bh=Hnt2GVXyH8sDwJnyGiTdVl55Gi8mY1f4tadVcdsrZXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFXq1j78ZKPSTArhqfQmO2PVtqxyCoZFhONYbjRB/hxvKm22K9QqMS/+01FT5se+aJ01D1eilQ1JNeADVi8PpPmHs4y1PjCkksn4BTtEq3N0Of+s6DFG3ZUtK4eJU5JXnURSflKLRvT3kNAGql85vcJ6vrbP8zYHhcZ4Aa+RSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yya/3ZEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FuhbcOho; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yya/3ZEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuhbcOho"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D51013802F6;
	Mon, 30 Sep 2024 03:57:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Sep 2024 03:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683028; x=1727769428; bh=2ZKSA2Dmap
	2pEUZq8aOmsreWW4LDkOAROPrdte2vN58=; b=Yya/3ZEcY0C1oBtn26gc++ZdCw
	5b++S9/1dPQsLAS8iMegDafQi6N6T79LGhjDVVVTllRrnqsInlDj2rXe2Ap67h/X
	zlxPnL7+ZlZEEx7QmRtn0AguSwAS+60pxh08rgUZPAoK/IJ9Bti09zy/5oIGqt1l
	P40qM1pTyDdbjRw35TpnTsdXeDBedYKmZhS/QCSlcbWWgT9BftQlBtJkGZyMXFP8
	Vz628KpJCqgj6Z1BdZvo4ZmVf+xFaW1J59MJk6K2OaXTPANmknDxbgpQfkrFjrHL
	fRaJNYqNfFnxO4hN6mK9YqwL+ge2Ymf5Ebnz9IHLcjAn8EMeuTJ+Cu60qkqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683028; x=1727769428; bh=2ZKSA2Dmap2pEUZq8aOmsreWW4LD
	kOAROPrdte2vN58=; b=FuhbcOhow4KedwkwMXWZYKhLi6AgUV/GmTDn4rsyHwN8
	zAiYZQEhRVSfrWPvy4+/APAA9MrNeieV3IsgIR8kU7v4g7X4OE9sWitFFU3YH+Mz
	JlQ1wmAr4lDqum4WTExqmm5UvA7iyPAsplJueB8PEoivtpGHxNHVliszUk44xEDb
	a3EOW6L2WC8g9/qBnUGZSgtciUvF6+QR9D3u2GfFJI8YGtbC9GZvDGJ43VNqAUU6
	FdHycpcu7YqpBANCOt+Ig3dax86wXovrDicjyVEM+CDeDi5jM/tQYZjaBBhJ4CJn
	2agZ9adbDC9cPrt2T80V6lndJt3u8rs/nW+GGtYYkw==
X-ME-Sender: <xms:01n6ZnODNcMMeATiCslPHWft_bwxKpV7ZFkR-_df9qJQAnLv3zZ-7A>
    <xme:01n6Zh9m3GEzULzAO_sxhg5ZBgaWdiGk5uldBCuYoqAzgz6Jhcj_KnePD6SV0c_Mh
    03VCV8FXq3DdOpXYA>
X-ME-Received: <xmr:01n6ZmSti6zQIpUtRrrxmqUHykbeSHkirq6YmkeRchH2Id5PhvaySqS1eIopjqGTdzNAFowVLZXk42VFjOIWuXWobGEgfp-6AqTQ8tglEYtGxQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:01n6ZrsXVMq-R00Z9zq7OERQ0ihudlRbB-tX4gTRT3v2yi31xbEspA>
    <xmx:01n6Zvfgx_mWBoteXtRsHiFFXyoR5NiQyTJjvUWWbWV84jlAmC0wcg>
    <xmx:01n6Zn1P0wRj_2RidMWiLCORYYKJGSHiVgy8FPngodwYuzU9CDIP4w>
    <xmx:01n6Zr-3PAeofID4fcn1Vz8yUVEzzpYIT2eyuJYpRsSDwhNHke2ZPA>
    <xmx:1Fn6Zhu2N2r8FpRqyx7D1OaF-BSBzQnOHo0xK1Tjr0lf3uToMipgt_mg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 03:57:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0781410 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 07:56:18 +0000 (UTC)
Date: Mon, 30 Sep 2024 09:56:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
Message-ID: <ZvpZy9XMpLI0DQQg@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <20240910163000.1985723-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910163000.1985723-4-christian.couder@gmail.com>

On Tue, Sep 10, 2024 at 06:29:59PM +0200, Christian Couder wrote:
> diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
> index 98c5cb2ec2..9cbfe3e59e 100644
> --- a/Documentation/config/promisor.txt
> +++ b/Documentation/config/promisor.txt
> @@ -1,3 +1,20 @@
>  promisor.quiet::
>  	If set to "true" assume `--quiet` when fetching additional
>  	objects for a partial clone.
> +
> +promisor.advertise::
> +	If set to "true", a server will use the "promisor-remote"
> +	capability, see linkgit:gitprotocol-v2[5], to advertise the
> +	promisor remotes it is using, if it uses some. Default is
> +	"false", which means the "promisor-remote" capability is not
> +	advertised.
> +
> +promisor.acceptFromServer::
> +	If set to "all", a client will accept all the promisor remotes
> +	a server might advertise using the "promisor-remote"
> +	capability. Default is "none", which means no promisor remote
> +	advertised by a server will be accepted. By accepting a
> +	promisor remote, the client agrees that the server might omit
> +	objects that are lazily fetchable from this promisor remote
> +	from its responses to "fetch" and "clone" requests from the
> +	client. See linkgit:gitprotocol-v2[5].

I wonder a bit about whether making this an option is all that sensible,
because that would of course apply globally to every server that you
might want to clone from. Wouldn't it be more sensible to make this
configurabe per server?

Another question: servers may advertise bogus addresses to us, and as
far as I can see there are currently no precautions in place against
malicious cases. The server might for example use this to redirect us to
a remote that uses no encryption, the Git protocol or even the "file://"
protocol. I guess the sane thing here would be to default to allow
clones via "https://" only, but make the set of accepted protocols
configurable.

> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 414bc625d5..65d5256baf 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -781,6 +781,60 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> +promisor-remote=<pr-infos>
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The server may advertise some promisor remotes it is using or knows
> +about to a client which may want to use them as its promisor remotes,
> +instead of this repository. In this case <pr-infos> should be of the
> +form:
> +
> +	pr-infos = pr-info | pr-infos ";" pr-info

Wouldn't it be preferable to make this multiple lines so that we cannot
ever burst through the pktline limits?

> +	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +
> +where `pr-name` is the urlencoded name of a promisor remote, and
> +`pr-url` the urlencoded URL of that promisor remote.
> +In this case, if the client decides to use one or more promisor
> +remotes the server advertised, it can reply with
> +"promisor-remote=<pr-names>" where <pr-names> should be of the form:

One of the things that LFS provides is custom transfer types. It is for
example possible to use NFS or some other arbitrary protocol to fetch or
upload data. It should be possible to provide similar functionality on
the Git side via custom transport helpers, too, and if we make the
accepted set of helpers configurable as proposed further up this could
be made safe, too.

But one thing I'm missing here is any documentation around how the
client would know which promisor-remote to pick when the remote
advertises multiple of them. The easiest schema would of course be to
pick the first one whose transport helper the client understands and
considers to be safe. But given that we're talking about offloading of
large blobs, would we have usecases for advertising e.g. region-scoped
remotes that require more information on the client-side?

Also, are the promisor remotes promising to each contain all objects? Or
would the client have to ask each promisor remote until it finds a
desired object?

> +	pr-names = pr-name | pr-names ";" pr-name
> +
> +where `pr-name` is the urlencoded name of a promisor remote the server
> +advertised and the client accepts.
> +
> +Note that, everywhere in this document, `pr-name` MUST be a valid
> +remote name, and the ';' and ',' characters MUST be encoded if they
> +appear in `pr-name` or `pr-url`.

So I assume the intent here is to let the client add that promisor
remote with that exact, server-provided name? That makes me wonder about
two different scenarios:

  - We must keep the remote from announcing "origin".

  - What if we eventually decide to allow users to provide their own
    names for remotes during git-clone(1)?

Overall, I don't think that it's a good idea to let the remote dictate
which name a client's remotes have.

> +If the server doesn't know any promisor remote that could be good for
> +a client to use, or prefers a client not to use any promisor remote it
> +uses or knows about, it shouldn't advertise the "promisor-remote"
> +capability at all.
> +
> +In this case, or if the client doesn't want to use any promisor remote
> +the server advertised, the client shouldn't advertise the
> +"promisor-remote" capability at all in its reply.
> +
> +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> +options can be used on the server and client side respectively to
> +control what they advertise or accept respectively. See the
> +documentation of these configuration options for more information.
> +
> +Note that in the future it would be nice if the "promisor-remote"
> +protocol capability could be used by the server, when responding to
> +`git fetch` or `git clone`, to advertise better-connected remotes that
> +the client can use as promisor remotes, instead of this repository, so
> +that the client can lazily fetch objects from these other
> +better-connected remotes. This would require the server to omit in its
> +response the objects available on the better-connected remotes that
> +the client has accepted. This hasn't been implemented yet though. So
> +for now this "promisor-remote" capability is useful only when the
> +server advertises some promisor remotes it already uses to borrow
> +objects from.

In the cover letter you mention that the server may not even have some
objects at all in the future. I wonder how that is supposed to interact
with clients that do not know about the "promisor-remote" capability at
all though.

From my point of view the server should be able tot handle that just
fine and provide a full packfile to the client. That would of course
require the server to fetch missing objects from its own promisor
remotes. Do we want to state explicitly that this is a MUST for servers
so that we don't end up in a future where clients wouldn't be able to
fetch from some forges anymore?

Patrick
