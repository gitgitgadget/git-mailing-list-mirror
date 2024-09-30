Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FB15C15E
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683039; cv=none; b=qgmWWyR+/Xq6ORBv2O8KGLVsFalRJvYv0jg94tV6j3NFbrnfE2556IS/MZiUduFJTvT6ed2xO3fNPFyIr/yWjjgLPwkOUmEsVY5BgZ29mf4E8GzgiChYzj3xXCShaOnw7cXfeSUZg7SMDqUwjV6OMdWylN7xEcvuhzqRs50x3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683039; c=relaxed/simple;
	bh=rvX1ouVC5ArSTzOpor8rVUyZ4wQqgkNP8N4D2w2EeYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtk+EQ5jFtPVaVW9bpBFlEo8GXvhpln/y5XbfuxHsCc4y12x5k9xbIMaKN+iP7xgSkk6KnvanJudz6jk5jccH+xkD24I6jIsy+H8jnlic4+wn6iHa8/5+BB7AuStaAgDFxDfQEnXI93jK1TzgLGMOQ9/UpsyU5Gkq/6J86JmHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=damylwJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hztGXe8J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="damylwJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hztGXe8J"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 36155138021B;
	Mon, 30 Sep 2024 03:57:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Sep 2024 03:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683037; x=1727769437; bh=gDqlWL4P7m
	zZLRlchYA3YqvlSQwhdlyfMsFj+XvRlHo=; b=damylwJVsFW8oiVQK0uy13iKc0
	rafZ+NYos9biSoNZIDndYpTny9avn1rclm8mPVNgdVzHSvUEZIcf5f8eb8jIW1pD
	6UI8yjKqb0WzwBzqc+JzhdvnTocjFY/ZL5VE/F/lLslIRlL1PJ6WU9Cw9DVB+ROW
	+EP4WbDauCy45rCV0m7iySkne1ZjfPbazWtY+VRKlSnDc5tW4CfbLye5itD9Z1WB
	LShp+sksffB9+4z6ghDpNoz2d1wJDmC2eORHHFx0koz0yxetg8ULU3bQkcryGwJH
	0fKWps72nRaFE4bTUJm4bqxX8X+y3fX1VN0f92FNpcjg5ubahHpPbhO6A2Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683037; x=1727769437; bh=gDqlWL4P7mzZLRlchYA3YqvlSQwh
	dlyfMsFj+XvRlHo=; b=hztGXe8JJutYtGmkFZP7qlKsVIsaJAVAixpRt8h7vDo1
	UU78eYL5kvpLHl1Z+AYEicMWqS3xDe2iceCXq4ZM5QOXpErVTksO9/yqS1OWPfCU
	dlGsZ6OQYiLSjTAvaKH6iDljr2i0r14v8v4ETg3T/ug5AuDQfg13dWWRvKj8HRfc
	NWiXmqTCqkCEok/zqQgoNZsRywmjChB1Z9CWUbDBrAXfgAd8MnAnZ2h16OKnB2cQ
	bTKrGqLCe0QgVt+ZqNn0Du72Nmuu+3KxTTULRWQ2ms9C3r2eKf3HAp65jtFR9ALU
	6kxqiT/GACBLsPTrUdEFZR0VT2UH3dMx0toSLNS6Hw==
X-ME-Sender: <xms:3Vn6ZrwjzLp9SXDQoGXSdI-O0LJd_d4ElLzqoadFQ9ThHdu_2sN4Uw>
    <xme:3Vn6ZjQ7TDJx2sGr50zt4S2efHqrroFbre5Anh8l-ts-xXTHPEXeAaWriYd8amFh2
    hGSXGmHzYB8jbqTbw>
X-ME-Received: <xmr:3Vn6ZlVF9oo1kf7QToyIteaAR-KG2ddIwx0niROaIm3bVwuoa3KaUqFjZXfKVgIgPIyMaVTIyfySCwETppGcvfcJpYZ2yjzojc0nfhNLEkkwehY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3Vn6ZlhPZVJqIflrf1EsynLopGgCfYQ1WWoEnqw2ru_uu56Ka5V5CQ>
    <xmx:3Vn6ZtCcz8snuS9sQQDWFzyInBhDHN49zLTFTOZF12rf3XDDuPQbTw>
    <xmx:3Vn6ZuJA7771gHk17kMiU-3L8ApZx6v2l8n4-J6kmqhu6aBMrOD4Fg>
    <xmx:3Vn6ZsA9H384v86XmlWBNlb2JT66ngkv6scP6WRX1Yj9-0vWi-NInA>
    <xmx:3Vn6ZnD6yqOYEGszC3p7JfQYUhH-akxzwMNHfYq-9VZr89xMcGtKcBnu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 03:57:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 102ffc6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 07:56:30 +0000 (UTC)
Date: Mon, 30 Sep 2024 09:57:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] promisor-remote: check advertised name or URL
Message-ID: <ZvpZ0el1DI7iwfAq@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <20240910163000.1985723-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910163000.1985723-5-christian.couder@gmail.com>

Oh, so here you address my previous comments. I'd propose to either
squash those two commits or to not introduce "acceptFromServer" in the
preceding commit in the first place.

On Tue, Sep 10, 2024 at 06:30:00PM +0200, Christian Couder wrote:
> diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
> index 9cbfe3e59e..d1364bc018 100644
> --- a/Documentation/config/promisor.txt
> +++ b/Documentation/config/promisor.txt
> @@ -12,9 +12,19 @@ promisor.advertise::
>  promisor.acceptFromServer::
>  	If set to "all", a client will accept all the promisor remotes
>  	a server might advertise using the "promisor-remote"
> -	capability. Default is "none", which means no promisor remote
> -	advertised by a server will be accepted. By accepting a
> -	promisor remote, the client agrees that the server might omit
> -	objects that are lazily fetchable from this promisor remote
> -	from its responses to "fetch" and "clone" requests from the
> -	client. See linkgit:gitprotocol-v2[5].
> +	capability. If set to "knownName" the client will accept
> +	promisor remotes which are already configured on the client
> +	and have the same name as those advertised by the client.

Wait, does this mean that a server can start advertising new promisor
remotes at any point in time and we'd backfill them on the client
whenever we execute git-fetch(1)? That sounds fishy to me -- I wouldn't
want anything to touch my configuration after I have created the repo
unless I explicitly tell it to.

If so, how does this handle the case where I manually added a remote
that by accident (or malicious intent of the server) that matches one of
the newly-advertised promisor remotes? This goes back to one of my
previous comments, where I said that it's likely not a good idea to let
the remote dictate names of our remotes in the first place.

If not, where do the known names come from?

Patrick
