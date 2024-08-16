Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400313A250
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799198; cv=none; b=ljvhOArxriDufpmN0IQ/yOfC9es1LX7eXjDK8EwbsuzCwmUYRGnyipoG82s601HwSc8l+TRE40G+n1BYYG07MUkGWJ6gyh2LBdIMB872jst6IONVUG21pOicwQRUmL1b9+FjkBYZPT+KtNlLi+7pzaSAqH3U+D/39Rc/vqQ5NqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799198; c=relaxed/simple;
	bh=r1GJIMtpr+BNHGX6FE+TFJh3NqT11WxffWUwkWgbhYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK9yggy27KHO28cIe0UwZdXWLXysrN5GUWfoRlOEtSKm3rYC7WhvdWC2sjQHayYXXrPqs6ouQHQcNzk1DTPlG+BWyCslJHFWLnvm3quYQEd3W6R6nEfc+PasV8n8RE5dLLLzH8y8BtbthLD7fI+ac7vIGK0ZMEbGi2U0L0hfNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FUPbg3Gu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XLFtywFH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FUPbg3Gu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XLFtywFH"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C53661151B45;
	Fri, 16 Aug 2024 05:06:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 Aug 2024 05:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723799195; x=1723885595; bh=MlN2WSupaG
	XUTuvgk9/uEQPP8j1D/GOwVHMsaJooMFQ=; b=FUPbg3GuRvcTUdGwq9qD5AwPUU
	m1ecGYcFi01J3wi4R6dD4j8GxwwJa8ZM+XaN3qer+s9QVbk9tCsHoBFZKdeul6yv
	zHEgAoId49nNSl7JwBh7tjei9Q0F/0Sq0375nbjjqGd5anO6C8avCi24qyLE9bzD
	qjquBT+sncJbPjWu+MFT/p8hqb+oc7c/l1X442XaHVz/xhGSR3Xn5fB5gArNh5ge
	I0zNO2p0IjUrmeSYCz1HlBTSmAMcfK2y0F8mCHZJofDUFUBRylDPx63lDQM/Ne9W
	Mo2K6EBzaLjutl3mTCdoCjSPuuXF99orGBauLdcBGsuT+tBE27mKwyTgIlyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723799195; x=1723885595; bh=MlN2WSupaGXUTuvgk9/uEQPP8j1D
	/GOwVHMsaJooMFQ=; b=XLFtywFHpxGaSr9teXCAUCNh2pmzHKyUzNzhRDGatNQP
	25bC13fx01dmqffuAMfxtwrU8aGKQ3UnaHWzCmlfcNQgucCSuhKEfg5jEMGFx7LY
	y9/1/kpURLJ8KKo7V/2g7fa8gDmpEHOROU4cA6Yb+SE8JWz8fBOS2SnajdPBYrgl
	Kf9+U2VHevHtyWZ+nUqkVIHFPZdDQRwNdh7K96jZVOgzVxq5i93w5POVxRpXqMMF
	nz7We1O07sFKMAJ8gIU4XMHMpFKkftvEIbGhz/FC4Iy3dU/pNIolMxnSln1FudxI
	eTKfNjR6eDyX1tmmrC2KG6UeVRxuec/hYZjgqbVtWw==
X-ME-Sender: <xms:mxa_ZpG7g6fIb4j3RPdMRN2IRfPxTD__8yIVNY2BEJ75ar36HkLJSg>
    <xme:mxa_ZuU-PZ2b-37N5MvaUaJbjCoqsZl5-iY4d8wM9JLI61-3xmVoVX3vZUciKK9kg
    Mno9P2d1Rrmr_YLYA>
X-ME-Received: <xmr:mxa_ZrLdEYIQ9Wq13lgMnXTwVIRLbwyRHShvGI18YlHw9eHOPnDcyUk8Oa5BJxAAOKvpVJYx5XpFRpxbkqcqwSPzyeNs8ApOGiAk2N-JDG5pbdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshh
    gvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mxa_ZvG8xG8Z2zrFeAVyQVX9UpM-7NJ-QMBiuHHdtrzAqEsx9yOYjQ>
    <xmx:mxa_ZvW89MBwYoMLDcVr2dJpOdyOrIvwc7iEYkFcGiwc_B-Cv1gOig>
    <xmx:mxa_ZqMuuzKPUomjm9XdPb9TA0zZ1y8D4A1s9OqRdJ73_bzku36-7Q>
    <xmx:mxa_Zu3eepBMNmx4mwGkn96aQVZOyNIK-zZfmnyVUNP5iUPYdP0Waw>
    <xmx:mxa_Zlx-frCjcfL-sUovLU-G3ew8svUxb1Wb2Gf3ygO-6pEmwpB_s50A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 05:06:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f99fed1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 09:06:10 +0000 (UTC)
Date: Fri, 16 Aug 2024 11:06:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Implement ref content consistency check
Message-ID: <Zr8Wkudjn5n1Zm0y@tanuki>
References: <ZrtrT1CPI4YUf5db@ArchLinux>
 <CAOLa=ZQVkmyVWAxyjrEQoEJ+gKJoJjfFqsDvr_A15FHGX1w=rQ@mail.gmail.com>
 <Zr4EqESHSnQET1Xg@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr4EqESHSnQET1Xg@ArchLinux>

On Thu, Aug 15, 2024 at 09:37:44PM +0800, shejialuo wrote:
> On Thu, Aug 15, 2024 at 03:19:50AM -0700, karthik nayak wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> > 
> > > Hi All:
> > >
> > > We have already set up the infrastructure of the ref consistency.
> > > However, we have only add ref name check when establishing the
> > > infrastructure in below:
> > >
> > >   https://lore.kernel.org/git/ZrSqMmD-quQ18a9F@ArchLinux.localdomain/
> > >
> > > Actually, we already have a patch here which has already implemented the
> > > ref content consistency check. But during the review process, we have
> > > encountered some problems. The intention of this RFC is to make sure
> > > what content we should check and also to what extend.
> > >
> > > I conclude the following info:
> > >
> > > 1. For the regular ref which has a trailing garbage, we should warn the
> > > user. This is the most simplest situation, we could reply on
> > > "parse_loose_ref_content" to do this.
> > > 2. For the symref, we could also rely on "parse_loose_ref_content" to
> > > get the "pointee", and check the location of the "pointee", check the
> > > name of the "pointee" and the file type of the "pointee".
> > > 3. FOr the symbolic ref, we could follow the idea of 2.
> > >
> > 
> > Just to understand clearly, when you're talking about 'symbolic ref' you
> > are referring to symbolic links?
> > 
> 
> I am sorry about this. It's symbolic links here.

Wait, is it really symbolic link? I don't think so, you actually were
talking about symbolic refs correctly. The fact that symbolic refs have
been implemented as a symbolic link in the past (and still can be used
for that purpose) is rather an implementation detail. But the overall
context, and what we actually want to check on disk, is a symbolic ref
in its modern incarnation.

And checking the format of both normal and symbolic refs does make sense
in my opinion.

> > > But Patrick gives a question here:
> > >
> > >> In case the ref ends with a newline, should we check that the next
> > >> character is `\0`? Otherwise, it may contain multiple lines, which is
> > >> not allowed for a normal ref.
> > >>
> > >> Also, shouldn't the ref always end with a newline?
> > >
> > > For symref, I guess we have no spec here. From my experiments, a symref
> > > could have a newline or no newline, even multiple newlines. And also
> > > symref could have multiple spaces. But the following is a bad symref
> > >
> > >   ref: refs/heads/main garbage
> > >
> > > I think we should fully discuss what we should check here. Thus I will
> > > implement the code.
> > >
> > 
> > Agreed, in refs/files-backend.c:create_symref_lock, we write symrefs as
> > "ref: %s\n" so it makes sense to validate that there is nothing extra.
> 
> Yes, we should do this. I will implement the code and the send the
> patches to the mailing list.

Agreed. We have to exclude pseudorefs (FETCH_HEAD, MERGE_HEAD, see
gitglossary(7)) from these checks, as those _are_ allowed to contain
extra data. But no other reference should carry more data than that.
Namely, a regular ref should always be "hex * hash_len + \n", while a
symbolic ref should always be "ref: $valid_refname\n".

A ref that does not conform to this is not a properly formatted
reference and thus worth being warned about.

Patrick
