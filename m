Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C59454
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494047; cv=none; b=b4MV5VrNp+Fh5lGl5NpGgGb2e3ikadfshmffPDv+PpRCH/V4k9r7GWD1y7MOcoUorQ5HJ9wNmcUqZA7ZqJWDoO7dsihdOT4CHdNlxWSTEZJbHou5yqooueowUyMFA+qCUji5MptwjiKKmBvfycLKJcY+lciB9qWUhvAVp0uMWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494047; c=relaxed/simple;
	bh=vkSQV9BoxxrnFy3wvywtN4urd/uM+MaRcwvB8ToSCtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqbEPokmVHGX0a1U3Slv9ddJCZkIsqy2UZ8A+iqIyd98QjM9k+ki3k5WA7iXkelGZvGObOuOjQhr0R/U4REJ8fQZPvcA6GHFyJBsbHiPYhGb+9yg2DE/2gvxG27OCGPlmhVstzpOVEtOIOtLD1PqzT6PC9k+cwXzjBD5TzA76Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=laRkChYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5eZL/8s; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="laRkChYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5eZL/8s"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 59CB613804CE;
	Mon, 21 Oct 2024 03:00:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 03:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729494044; x=1729580444; bh=sPLdDHFKiM
	mvuvr06eXDz2SfDxqT+Xhtiyn0SoAUsPM=; b=laRkChYaVdGslqzEZ74dZeN7LQ
	feOGjH3iQZ0llPDiX5xvKLddItywWh2QhlvGw6MkVbWLuZhPifUtSoxVpd7Gzenc
	52eUKabTgwgp7Zz6hu/94Mw4OwyyVXGG/VQBd0bX0RuCb/+D1UH7t0e/EWFyiyvB
	YqPw0XMGg1krVry8D10f0q4mLCFzzKisfnuZv8CmRQZb4QtsOgrQHauonBaSPFa9
	qj4mexofHlEK4d+rcTZUejru6AsupJBR8logcggiFIYsAaScTnuic1ZJ1jztDgNR
	wn7Zz4zVfL/Q1ZgApZTX87koy1vcJkLtN6rfCJ0s5lv7XLWZ7hW8wEJKGG8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729494044; x=1729580444; bh=sPLdDHFKiMmvuvr06eXDz2SfDxqT
	+Xhtiyn0SoAUsPM=; b=Q5eZL/8snfJX4RoayzYfYjYhLnfdetk0iP0AhwJ1Z2nb
	N+wkp85jQXOP40BDIL99AROe10KbeCP2Axay9+dV9dZJ8s7iJo1Vt9gEQR1NqSwe
	PM3yQE1yAiCrkAXMsC8iz7aPMlJ8YVQlpbdzvTgBlF+XlRZnVYvNA49wcNmuFKhW
	hdPFLQeQ1B+B9oVjSH2ZfhUbIS36kophdRCdXmOISuNGYUJve+mHpfqJ275ooyvn
	/FIH6+deQq37OuOwMeG1AL3jBKAzp6074/EsXyMHV/x+C9sx4p0ZYP5aurPysa4Y
	r5p+PN9eISGzSo/8r+n/46sEu7ymaAttRhcatPuFeA==
X-ME-Sender: <xms:G_wVZ9XBnMtCPHm51M3NeOhQVOZebLB7b-9PJGGJDlBUphHpDZCJsw>
    <xme:G_wVZ9kBNjZ_BHWhucGQP_HsTcJTvjs8cVnPedmwxJGhNXEiqE0hZOj7jof8inRch
    dVlBsnHL5Oz8avSKg>
X-ME-Received: <xmr:G_wVZ5YXFHS2HTVaDgcaLCSrxQ4u-Egb8ONXn-1XoVfwWW34_2pYKdzwSZC9iWR28_BCkkS8qXadUEGEHHUsSLB33QpyCmDM8_wnmq-xy7RC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hsvgguvghnohesmhhithdrvgguuhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G_wVZwU76pBINczjHhBFFQ-9_Ru-AeRLTlF1FKSYd-FZBxt45YEQDg>
    <xmx:G_wVZ3ljoR-LKj25hyw2QGLPhw47DRspDmc6_qCAr5EU1zH18uhJBA>
    <xmx:G_wVZ9esiJlrLkdSY6HoAVdiFdpgb6SRLO9wGD_7e6H2EBXqvVRpTQ>
    <xmx:G_wVZxFTTGWLl0AB5A_JmEPMJr-Y-tRtpwlIJ3Sa12JO-Uf_Eql-Lg>
    <xmx:HPwVZwDT1FupvLC8AF8UFzTLhWhij_sNwEmOFC7eVmOLZSbTZ5SkH51U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 03:00:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33d9f4e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 06:59:14 +0000 (UTC)
Date: Mon, 21 Oct 2024 09:00:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 2/2] Makefile: adjust sed command for generating
 "clar-decls.h"
Message-ID: <ZxX8FCE8rnLb-wvU@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1728903464.git.ps@pks.im>
 <dda9b8e033c2e32e17dff73cad43211dd355d3ec.1728903464.git.ps@pks.im>
 <87y12lbeix.fsf@iotcl.com>
 <ZxLPwKdUywa7vlu/@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLPwKdUywa7vlu/@nand.local>

On Fri, Oct 18, 2024 at 05:14:40PM -0400, Taylor Blau wrote:
> On Fri, Oct 18, 2024 at 05:45:58PM +0200, Toon Claes wrote:
> > You're most likely aware, but this change needs to move when the patch
> > "Makefile: extract script to generate clar declarations" [1] is merged,
> > because this line then lives in t/unit-tests/generate-clar-decls.sh.
> >
> > [1]: https://lore.kernel.org/git/7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im/
> 
> I believe that is what Patrick suggested in:
> 
>   https://lore.kernel.org/git/cover.1728914219.git.ps@pks.im/
> 
> , no?

Yup. I think it makes everyones life easier if I were to just merge
these two series together. I would've done so right from the start if I
noticed that they interact with each other, but only saw this at a later
point in time.

I'll send this out later today or early tomorrow.

Patrick
