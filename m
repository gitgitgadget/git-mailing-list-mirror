Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0F7483
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265792; cv=none; b=ld0ErjqIHpQ7g1fQD6DY99scHXo+PekpsNATNZQNy2s/tTdzYlUIPdOEgI1vRGAGAqR8FzrcexC3s5N1/I+NAd8zi6lIxNVBxu//Rf92s4Rq771bry7OuMevZenRafugCy8hkJ5U1lNHbRSOQaF0yJNrHK8nzn+WX2DFKMzqkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265792; c=relaxed/simple;
	bh=D3HzVlGqVCHkJjFMUH/i5AC18OBjPYWwPus2KWjg1og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puMLyObFs7UQhReXdMlReBQFHs1J20r5LNOhcyHyKQJE4OTAKCzJFt01PlI5Kky/KdnaK89ITr2Jm8AY9daZyWz1SJoBWqF7SkxdjY0Oi0/28UtiSo2d8xmplmqj6s9e6PvuC/BYRrv4wmJf9AOCVImyYAuHJe+/7usrOePh9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OGWui3Im; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDAyhGa4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OGWui3Im";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDAyhGa4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 224BE114015C;
	Mon, 26 May 2025 09:23:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 26 May 2025 09:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748265790; x=1748352190; bh=mbg/RhoHx7
	L2owRu/Cmv7x6De6AZF9GknwHqN57bae0=; b=OGWui3ImzMzIQVEYa8k0QMfGpU
	wS45dehLRt1FizD2bp639xpTFtYbYZlCYvweqnMrwo8ptUyN5NKq20OV9P2wAah1
	BCDNtBbHi0h7rBtFJVfs/E1cD3HQA02pLwDykySnh0y1/tZ1tlZnElH5+uySaBPp
	lOKHC24uK0qZaAIoFvX9p0K0WZbNYP/3MGUFPC8EAKAsjYhLuloDhVvO8xT28NAy
	GHULVJZBooycYLyDfDLnGz+AIU9o9spfjV4zx0VpqZx5N/Nr2Y9acUt2TpK1V4LC
	vv+O1qxvRpFzzm7wEFrwbsIGOXHxS7JwbJUMbi7067FCLB44Na8Q24jE2jng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748265790; x=1748352190; bh=mbg/RhoHx7L2owRu/Cmv7x6De6AZF9GknwH
	qN57bae0=; b=oDAyhGa4V/mXn19g1bpSibvHmPj62vLbH731XJAv86OTuXo0iIU
	0BWdkXRdDDk79UwPRLgSNlDvd7E8La096YaqC27R+9Eosja/buDN4WtHRu+a3/iI
	GKs0zUPmA5UbFH4Hq3yBobr/93m8v2iPIGq4E9BylOwwfsXkVrmJPUfoUKE4tzXI
	/nr1GGzkyZnBULhZV9Scr0xsFjsVVWmYEVt43dbUGU+xJM7pZuH4LhPx6jMPlquf
	uMNfhy0d2Bx5cBeohjacEr428MmtOSv132/QLmk/sNUvCR53cy0K5MoXd3IEt8WP
	nUmGCn8CwYvRgVv8VHpe2/bWLegJK+a6fCQ==
X-ME-Sender: <xms:PWs0aP7h4id2jDcZHxwFn4JpjBrwhxxaqXZqEhDb2nc-pZMdjlpeJw>
    <xme:PWs0aE6JwrQFUKPWgsobtAFu2Bbucts986EXmRJV7Z47cTJAIGhTWzg0_3Y5nvbAy
    ioz5hcBJE-TfWNlmg>
X-ME-Received: <xmr:PWs0aGfieO0tKJ-WbLRosqeW1WR7OopQnuePPttq-XvxdOg9O8Q6DrJezxMd90lDsxMILoZHnqgA0szKF0ic1uAqbtvnyKPwZjpDeR5-4NCOjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeeifeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihrhhothhhsehprg
    hlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PWs0aAJcuAWL-Fqh36BENpRuvyN9EEIhLtao4HLVpMzCxeGV2wjWDQ>
    <xmx:PWs0aDK9RNz5eRQAVcH4rwW88PQuj5wHve1fj7Uo32eb5yaedaIuCg>
    <xmx:PWs0aJwWPtLsXkWYBG_XVaM5mn7_D9vhKQPisdV4C30IAEqWBQVh2A>
    <xmx:PWs0aPJZLd-lioumkUeZRgkGygs3VfWa3MWTE0WkYsdxMaBxW1-zaA>
    <xmx:Pms0aOehJIqz1m8eH2j4SXRAUvH5R528cQIjF21LmNXDuMcmvwq3c4dg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 09:23:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c89ad1df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 13:23:08 +0000 (UTC)
Date: Mon, 26 May 2025 15:23:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yonatan Roth <yroth@paloaltonetworks.com>
Cc: git@vger.kernel.org
Subject: Re: ISSUE - Sequential execution failure - Lock auto created between
 git commands
Message-ID: <aDRrO4x0o0Hit6au@pks.im>
References: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>

On Sun, May 25, 2025 at 05:13:30PM +0300, Yonatan Roth wrote:
> Hi,
> 
> 
> Using a script we run the following set of git commands:
> 
> git branch -a
> 
> git remote -v
> 
> git stash push --all --include-untracked
> 
> git checkout test_git_ver
> 
> git remote -v
> 
> git fetch
> 
> git status --branch --porcelain=v1 -u
> 
> git checkout test_git_ver_workspace
> 
> 
> 
> 
> After upgrading the git version to - *2.47.2*, we started getting the
> following error:
> 
> error: cannot lock ref 'HEAD': Unable to create '.../.git/*HEAD.lock*':
> File exists.

This sounds similar to the issue reported in [1], please see my reply
there. I'll send a patch series the over the next days to address the
issue.

Patrick

[1]: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>
