Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6891A08C2
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336500; cv=none; b=axasqiRxbrHtgW/uSwjNhTfcS9ZOzynQLcdMr7D80PH5MKFhrnhdhVS46UMvspch8lmLWW5DN4lFyl+Wn+m3q3HvV4AQBzHDJs1UL3Rl5xuNWh3M5nObyfePUAYhRPtYj9GqsBTll8AGAQPBtNe2woUtZ7OJMVSCF2MTaVLtjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336500; c=relaxed/simple;
	bh=PsCIfIvxpYF4jNB2tEX+s3pLAWMWDO3zHPvmfy3gNAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIFIR6kOo7yUfl/q8nnS8mhb2AS2J1aQ6WtAJpwiPCx2JpAH7ZJv++BUEEnquotRX0JjNkkd5JTXmOuZCiholEufZLPhNDl0IA+l/w2Sdtxf1JaWocTxwGayvdCdob6VpKaYv2Ow9gIuVkw8AcOMInRHxf75YooIEdCaL1b3JQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vKRowugA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hoHsi1KN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vKRowugA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hoHsi1KN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 821B313805FF;
	Mon, 11 Nov 2024 09:48:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 09:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731336497;
	 x=1731422897; bh=m7Jjje2LM4JzxmIUNVcnqlzf6YTUI1WL9gu0QSCq2Oo=; b=
	vKRowugAUoJOXaJc2YAlmaBPUkuOmkxIWySiI/feLUrBpfPTra1v64iW+8mdwzvn
	N80dSSQZyFoN2vXZvGHXBMylbfMQuo15I4UplxVlx5ZwYwVAsiRP8ve/XSnV/XB0
	vGahs8B18J08jjFeULK6TycscSWy2s+nXDyVslKIoxB688QlG9Z+rtzvLzo2/mKW
	gTY8hlgiCTk+lv41CoWrHCoHwCdkD4kKZfVs3PTiYGVc38cuDY8XMy/1/e/yP+zt
	pTSWpqze5nCdjtldk6HeEZFEjoz3BWxZJUZf8FW+YN7qRr1R0hfSA/ud9pAtCB9K
	JcCr9IYdKKuv6j7Bbet/5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731336497; x=
	1731422897; bh=m7Jjje2LM4JzxmIUNVcnqlzf6YTUI1WL9gu0QSCq2Oo=; b=h
	oHsi1KNZqg+jhcfHu8Z4evHNY8hLNczJiAf0lJSqfJ+QKWGkoae9SWNfjNNSYRlo
	APeMuB5fz0I6weo0l//ADI66RdgUOfeZXLG9eZtQ8uVh3/nVJqQkMCCAXwRuPa+c
	T/E+fv31FQkcZBzpn5rABtQMoRp1v2lqqUeK59Rizi0rJ5gWFZWUEMIBQvNnXJCz
	gs9z4S4ntVg0cz8f6Tqlmydd0Ogxiff7CC56qdszENOVSVuAI2sv+Trs4sVx2sRU
	Fq67/t6n/bX6vnxcfIVk7bk2uE+6tOIcLlCPNkVbsDakV9+hRZnzuwCEkx+lks+W
	xlNYGZGyO6j8ks/iLnBbw==
X-ME-Sender: <xms:MRkyZwDZCVtdaL7vggoUHwZqruQdBtszNq-Osq0tppPZCrhBH1VKyA>
    <xme:MRkyZyiBHfAAsMOzxzKMJ2RH_ND8rFoI63zgDiZwbKtsxrVY2KLR0CVV6XL7xULtb
    bz81OSwqA0g_lQTow>
X-ME-Received: <xmr:MRkyZzlG2nb-Eo7kfItvY8uby1JoOG5REdZYV_dRv37JM8JW1kNfc-NB1giiTWNEiXC2acNchWgZ_hn7kwIqR7o_Xipk81E9D8Tc0JX7WUyGe1sN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehprghulhesmhgrugdqshgtihgvnhhtihhsthdrnhgvth
X-ME-Proxy: <xmx:MRkyZ2yIdiW1Qs5Pf7A6TDeQSpfZuw-nddjpUps9q-6gKmuKpjVJWw>
    <xmx:MRkyZ1Ti3Bn5n2pdL8CMEldTRHRb56IKPy3Ah9906g4alytBG-EndQ>
    <xmx:MRkyZxZyunT3asvjXmbRl35oWaZ0gAsQMJ6faHqxSIxaZ8yr05wqbQ>
    <xmx:MRkyZ-Tox-i_pV-a9lHglFVJze44EGm8V5HalNX83mtR6noDiqjsLA>
    <xmx:MRkyZwdm-iTrv34mFZoticu9XhJ02nBjDaGk4RLRxk2u6_fLbIcNgdF2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 09:48:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ea0ea24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 14:47:40 +0000 (UTC)
Date: Mon, 11 Nov 2024 15:48:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Smith <paul@mad-scientist.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v4 05/19] Makefile: use "generate-perl.sh" to massage
 Perl library
Message-ID: <ZzIZJsDpwX37FFGO@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <eddafe1cf8935fd25d107645168ace3f65e1064c.1729771605.git.ps@pks.im>
 <6a608200-2dd5-4505-9e1d-1e161ae2896c@gmail.com>
 <ZzIQ8zENlz-0CZBX@pks.im>
 <99357763a692a0446624f59199fc91f683d2658f.camel@mad-scientist.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99357763a692a0446624f59199fc91f683d2658f.camel@mad-scientist.net>

On Mon, Nov 11, 2024 at 09:18:35AM -0500, Paul Smith wrote:
> On Mon, 2024-11-11 at 15:13 +0100, Patrick Steinhardt wrote:
> > > case "$OUTPUT" in
> > > *.pm)
> > >   dir="$(dirname $OUTPUT)"
> > >   if ! test -d "$dir"
> > >   then
> > >   mkdir -p "$dir"
> > >   fi
> > >      ;;
> > > esac
> 
> This seems kind of complicated to me.  Why not just simply:
> 
>   case "$OUTPUT" in
>     (*.pm) mkdir -p "$(dirname $OUTPUT)" ;;
>   esac
> 
> There's no point in testing for existence of the directory before
> invoking mkdir -p IMO.
> 
> Maybe the git environment has some rules about this?

I won't use either of these. Our Makefile already knows to create the
parent directory anyway:

    perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-PERL-DEFINES
        $(call mkdir_p_parent_template)
        $(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@"

The issue is rather that CMake didn't know to do the same, so I'm
solving this in CMake rather than in the script.

Patrick
