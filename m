Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A51D0F5C
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070763; cv=none; b=Ib+RwsfozGajVHAvyGWA88/WuFJgXYbzRAOl+GGy0UeNj1O/KNeJiKXJDTumxa8ES7+u/awKt3mEnEm0Tm85MkeKGJFpZsPflUFEBXnHxdt65qvNRwUfIzlhunOoDqXLudOSZdcrZMiNp8bYDsc9xA4434ZqTHgwHGg43KSph3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070763; c=relaxed/simple;
	bh=XZMi70wqT25G+nbD/KVvyin5Ahkcj9GXMp0TeQK4ea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kho7Csw9A0Ae1XihOYkfZH+kA6C4Q60EdrD0vbvDF+dZtwTwN+tnomMKmd9LQY0Puo4sE1N34dqIQC7g/NAfzZF5FkCBTe057qGzTmQFCo9nh0o9DfYcfajLs9nwZgUtpKhcqsp736+kFGsFSXUufKLhgoNsWVFkYupyiJQOEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yFwm0Ntj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KizhIifD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yFwm0Ntj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KizhIifD"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 460BA13801DA;
	Fri,  8 Nov 2024 07:59:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 07:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731070758; x=1731157158; bh=SU7OcvWnoB
	tYfLHL2fEiI/nB0DCunqy941nXss7l+YY=; b=yFwm0Ntjbz8sIvZ73oWZxC/nzX
	Mr6JRO2VdEiXPN8M6JkR2+IZXCe8mD6X+xignc55b06Vvmp/B80VttCt2jQoL5QM
	NvuDjUVc6gQRrbpOwOxd01sn9sUBmy74ZoYsXIqgZwQZsE68vpT9yw64ei4NS44D
	Q8L/mw7xmJULk3sSTaiBzVa1Ef+QGh9L4hErD7xQz7DL56qI5H1K4kGR1Gr1KNN7
	IvrLXbjG5qH2wqODqPyddIbaUrCBum5S8IUcLvyqfdbgmezqaB1gH/tTdxCIOC7Y
	6HVb1lVpCagiNeCQ4VZ3zIEkFjpHKqfnv6dkJI9Mg22m00KBWZM1nmgBeAzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731070758; x=1731157158; bh=SU7OcvWnoBtYfLHL2fEiI/nB0DCunqy941n
	Xss7l+YY=; b=KizhIifD9tZ5VPvG/ZWc33nQlNi69GtS2Amg5BSH35Xqdz+OhVg
	EgUQiqA3L6XdFgZ5toFLC5hIMNS/WQxZq3uYOVaa2cQvqoapz32Pb6a8TeVQwlci
	ChSrSTuK4T9VJbW+9NLHAMCQAPALR0fvcPc24gFO4cmBFUBI7Vr+aufxcyx6SIp+
	ii1p6/pmzzHZv17fKfN6+2+jDHUHgO4qLHVIKHrXfm0wxFJvhzoJVxhjEgNTIUzL
	MTUv0ZfsgpFRP9vPwYAGydk1JIEbIGMjLwxxOU7cluoY0U8KZyyz74ma+1k6hZUq
	Bn1TjSUeIDWqB1jRCE0HcYLWMHBxJzqyl+g==
X-ME-Sender: <xms:JAsuZ-gjN_3dn7uMToli9rHn0-INktiNNih3gsuzVYxgPiJBSWZu_w>
    <xme:JAsuZ_DVkuxwqIgqVg9L2N6olp2qersIkGEpvCb9cnmHabcxVbQ5vU1Ntic05lsW-
    6ZEELyskCcUKaALXA>
X-ME-Received: <xmr:JAsuZ2EPW_fuzsYRetgiNsRTCTL9qHGLsq1c6Lrqp8FCe2ENDlRFeY4IO1AIGQT1sqCkQ5Tbgn0f1vw4xf-3DTojSWsv01UMDFm5mVMi0ZfuFcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    htohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgv
    ughupdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepsghonhgvthesghhrvghnohgslhgvrdgtnhhrshdrfhhrpdhrtghpthhtohepvggurh
    gvvghlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JAsuZ3Qe5rFAouEYG3LAqozPFGElooxU_oh3om1A-lOHp3D-fmOhWA>
    <xmx:JAsuZ7zzimWjO66tLVsBvKRN1R9kgwbLxTQNNGtQCcatWCggM_TmlA>
    <xmx:JAsuZ15LW03vrRSSyc6x-b18GlxbPMUv6NE6bX6siY1noetwfWnxYA>
    <xmx:JAsuZ4wc22ZuBsmucY0rQVuO3VrQ2P2fyNw4DvUyVGNe1fhBe7Z-Sg>
    <xmx:JgsuZ57x8v82RzKNjVrIpTki-4v7i2-EKBzWtQvKhGsGggprr6Hd1qQH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:59:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc321ec9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 12:58:44 +0000 (UTC)
Date: Fri, 8 Nov 2024 13:59:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/5] cmake: set up proper dependencies for generated
 clar headers
Message-ID: <Zy4K_rcyGlwv64JZ@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
 <bb005979e7eb335b0178094251b5c37682d7d47b.1729506329.git.ps@pks.im>
 <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>
 <829fe630-e46a-4a3a-82dd-4e5feedd190c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829fe630-e46a-4a3a-82dd-4e5feedd190c@gmail.com>

On Wed, Nov 06, 2024 at 10:59:08AM +0000, Phillip Wood wrote:
> Hi Johannes
> 
> On 05/11/2024 19:55, Johannes Schindelin wrote:
> > Hi Patrick,
> > 
> > On Mon, 21 Oct 2024, Patrick Steinhardt wrote:
> > 
> > > The auto-generated headers used by clar are written at configure time
> > > and thus do not get regenerated automatically. Refactor the build
> > > recipes such that we use custom commands instead, which also has the
> > > benefit that we can reuse the same infrastructure as our Makefile.
> > 
> > For the record: I did not use a shell script to generate the header for a
> > specific reason: Unix shell scripts are not native to Windows. Therefore
> > they cannot in general be run on Windows, however that was precisely the
> > idea for the CMake definition: to be run on a vanilla Windows with Visual
> > Studio installed.
> > 
> > Sadly, even Git's CI definition sets things up in a way that Git for
> > Windows' Bash can be used in the CMake definition, but in the intended use
> > case (opening a checkout of git/git in Visual Studio without any further
> > tools required) won't have a usable Bash.
> > 
> > Therefore I am unsure whether this patch is desirable.
> 
> CMakeLists.txt tries to find sh.exe from git-for-windows and errors out if
> it cannot be found. It then uses that shell to run a number of scripts.
> Perhaps we should do the same in this patch? It would certainly be a
> worthwhile improvement to regenerate this file at build time if the source
> has changed.

Yeah, I think this solution makes most sense. I'll send a patch in a bit
to address this.

Thanks, both of you!

Patrick
