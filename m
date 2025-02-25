Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085702139A8
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470302; cv=none; b=GcQ43VWHtROjBebENvGnR4/sGXzkSdwbxHdlaviaMIrTJc70zvW7HAiLM5I5RScJCzZxI+RXxChx3y/8H/izSLVhQaN8sMoNdKjTEIBC8tEsli73P2BL/zIL0OZMMC7y1TnhxYkG1jZ8fPeSKRJNXkaY8TnxU4s3r4AQ7+gbZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470302; c=relaxed/simple;
	bh=6G77cXYCqa+0j+dk60kfiNl2kEcuoG5lu3ikwqe45gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC01HCOFfMffYluUzaKEQzr7dcHgSM9cZ3XmnvziiS8PT8LiJDyua8g63ReOcr3ONaaWQUcZRqczVCbzlxkXrV5bkN80Did66FisX4kxRlKqofQ1iJXYiBo23kuXJZbJg9X7tnESKxvXcMzEon41/CctJv/GGV1cYCoknI57s84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FSGzewzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkiyjyhF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FSGzewzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkiyjyhF"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DE380114015A;
	Tue, 25 Feb 2025 02:58:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 02:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740470299; x=1740556699; bh=HktH70u4k1
	MEnPPwtHP3wV4faPRRt7YeHo350zysMto=; b=FSGzewzjf6sRZwEDhc0mvnhUww
	8qBYZsRBqBPPyplFlJm6JCkBOFpmULurDoyE7thHKFnVs5+HctP2jJGPZOTEchtQ
	2IoWK8C9F8dy350FwJuMaKgRB/iapuTtH4klWmfkTOZYKWrsXlVssgR6HYL6O9Jb
	7skmGkYasPMNII9A5l5hcIjXzajFcQ7nlUDwhMd2Td7gz+Rl4tDbO1Z/HqfK2LTB
	vzxkF6zEJ7DISr1tw7Rpi/iAP7BLe3asCWx7A8iTLBBjv3ZAhPxr6hwNccjktRPj
	ncuDNdCg/FDdC8FT7cAlU0VU/B/rsTixGH1nti7kZ+eq7847phkAOH+bH77A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740470299; x=1740556699; bh=HktH70u4k1MEnPPwtHP3wV4faPRRt7YeHo3
	50zysMto=; b=hkiyjyhFDQ159z/QwiKsmHicSUPSdo8fDM+g7Bjzwk1bOATtf93
	2QOcMYEFDoBeVhDO+8zHa8B7PqXI4DMgVIcbw1SFFVHNf7dmL/7BNrcxieQ0nWK/
	wY/VM3F4ybfCa5pPCxFH3vhkc7w1IHzujp4DOhjatyNUvwS9MfQ3uDutivDXlQ50
	8mpQyuzftM8Nyw+KArN9uHJRj06DcmgpgxoYhP4lBZdf9zwB5sijq1rRDAIu2heo
	LpEWDiEx+QPLR6vVJDGlHPM15AMc+8J6f1LIRqeqBJgwy6DON1rDXLgOsYJEbgM5
	laRO0tux3BH3S42R+O5Hsq4w4pv9h4jNcyw==
X-ME-Sender: <xms:Gni9ZwIe3nyY3-8JsSNOGBgvPAVPbS1eXV-TinKxxGchx8FKnvHxJQ>
    <xme:Gni9ZwKvVmc-cvZdAizmx4V9L9iSbPr5oFqz6FXqS-YacGtODCKTdUa61UPFU4sVk
    lHUMwIaRNd7BD5kOw>
X-ME-Received: <xmr:Gni9ZwuoXOoKJE8NVDa-6XWwW7IZxkwOF65i57FmP_WeahcIl3QT6LTeEU_fHERbvLlddLxQX6_8dFL_FBgQo6xTaGjQKdFTI6EY7YIHaCGWYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrohgsvghrthdrtghouhhpsehkohhorhguihhnrg
    htvghsrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhifihhlkhesjhifihhlkhdrnhgvthdprhgtphhtthhopegthhhrih
    hstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgi
    gsrhhiughgvgdrtggrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Gni9Z9badMFwztWfimVe5O5xOM8lU7Ki7aIOsi8gp2DdFvxLFdATyQ>
    <xmx:Gni9Z3Y16ehh-pqBh1TpqWioYSCYmICRih9uv7zcwTATMdCjfb4omA>
    <xmx:Gni9Z5BjAs-hxHOwsgTthVTp1mkOAwniqDDcivbE19mixcw1Yh_x2A>
    <xmx:Gni9Z9ZV1WSqOS034t6KMNzMhzXPUxLfq9Jb5260o6ZUb08wqhZEiQ>
    <xmx:G3i9Z779sekweryaIIIAh9qCoJihMMbSUejnaNxd0coRKDAQZ46EOiSR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:58:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bce636a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:58:16 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:58:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jakub Wilk <jwilk@jwilk.net>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Robert Coup <robert.coup@koordinates.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z714F8mLHZcoHptI@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
 <20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
 <20250221152644.o5ni6vn6rncvmaq6@jwilk.net>
 <xmqqmsef9mm1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsef9mm1.fsf@gitster.g>

On Fri, Feb 21, 2025 at 10:30:30AM -0800, Junio C Hamano wrote:
> Jakub Wilk <jwilk@jwilk.net> writes:
> 
> > * Patrick Steinhardt <ps@pks.im>, 2025-01-22 12:31:
> >>+As our documentation mentions, these directories are not to be found in modern
> >>+repositories at all and most users aren't even aware of these mechanisms. They
> >
> > This isn't accurate. The "branches/" directory used to be part of the
> > default template until very recently, so it's found all over the place
> > (although most likely empty).
> >
> > I'd say: "... these directories are unlikely to be used in modern
> > repositories and ..."
> 
> That's a very careful reading.  Thanks for pointing out the
> distinction between being found and being used.

Indeed. Do you maybe want to send a patch for this? Otherwise I can
handle it for you.

Thanks!

Patrick
