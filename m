Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7E1D555
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914468; cv=none; b=bEQMYZ3QSd9IVQwqS4KTQCuMKglVpkgBj8kVcgs82GMuanWIUZwZ5zR82loxzNn6ESs8tu9qiuhbR+M7NEnEE87ubZRSz4rbSMYGQzlm07wULAo3jjHgnVXxTZBCyDaZL0n9B9E+qVFlzsSIqZCGTIgGWfG7BNkcSlh6zcb+e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914468; c=relaxed/simple;
	bh=auj2fGLA62KzQtukFXmRLnyL8XOdVN96qctL+AoLos0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxS8E0SoSh05PhGPqrMVEZeASeD6USgtmpW0vAyEEHvHBkXx9HXAFIJ48XrcwoVB0LW1chZ4YRKMwnoegIW063q6IqQ1TBCQ2Ivd8ieVYV9I4GipoojKOqTyb/yqKwC2b29Ms0tYzqMvH8PX7feREJfoPb8Y1xSMObcxKhw3ySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r4FdciKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZN/ghNzL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r4FdciKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZN/ghNzL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D7AD138039E;
	Mon, 14 Oct 2024 10:01:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Oct 2024 10:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728914465;
	 x=1729000865; bh=Uzd5XdzmmF9HjscNuz+eW+PbJP1V3Mji0ZzDO2tsjmI=; b=
	r4FdciKiq0d5sfL7eCD7NO4UQjeDETStZtNRB37CarN4myzNhAAa/DiaJV69P2HN
	f5ie3XQQaNlLcaxLCMmAf9kiRIu0qoEXuJhbw+bla7b6U/Rj9OKyDh33+UoWTAql
	KnFgBKXHW0aTPQrMlkaDbAM32ho6eb5pgI58eRPyWrDfexDxJxFffEiPGbod39uw
	Ttj26RBK7x1Wp0HQPdU4+Xmmh3Xf24zzkBbThFiEi4mKZTvKwmZqHxBw76+6fl08
	ceYOFnbsqWixi0miW26lWBiSohIglM9BaNcegyAuhuupfNOFM5FkRopitSBV4elw
	234hag0k4WLQaNBn0rGIJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728914465; x=
	1729000865; bh=Uzd5XdzmmF9HjscNuz+eW+PbJP1V3Mji0ZzDO2tsjmI=; b=Z
	N/ghNzLem17zOfQ/3jgY2JU9aMIFNFbkQ2Q+AVzId2X4iDVU+uiExTL8FId4pZPy
	ObCZ2IiiqLEg6G7Qf6BrVARMRJPeKD+unxziSyXGPmKoa+Kp+MIbKv+F+LKk3FT3
	/ScE+hzB4/P/GGfvglQ9q5bBbS00nFuhrFMGUY8vPzUGBUvloW3Vu7GS55bgAkpO
	O+mkuwLOGLJCKPGpweV0kqTqOVPwIQzeik8LyoW14y1cYJ+bd1RY3mkX22daTvOU
	aup6Lngok9i3urTEj2xbjR0PHYyBm2CnCfVI2WeXhp0Nwg8fqpGdCI8mHTwa6EKW
	xr4jBFQK8C3oDsmsgLX3Q==
X-ME-Sender: <xms:ICQNZ-dwIFfLdcBBeMX7lui62-PshW5K3C48YeBrU_tjw0HylYEcsg>
    <xme:ICQNZ4O4Ke1DQ8fi6_YNC6eIHdScy4_ADS2ummVI2HuXz4QlKSNYc_cyOGe62tZr3
    SCkTLOqy9yxOXymQg>
X-ME-Received: <xmr:ICQNZ_iZrSCY0ENgnX14U8yFDEv35tpF3THC6I7Gzl_kdtE1TUJ8_pVXvSwXwySLld1MIPbaGEhaMW0giqHQ5qL939fUR6kkvzeGosopyS7qoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ICQNZ7_KwidzFHBOqJuk7XHvyQ07nc0-0QJkdfQfzw13oANqv7g1ng>
    <xmx:ICQNZ6uxb7bXgYzmbgxCiekS8B5Zg8RmwqmWXOoBbnhbgX8noKzH4A>
    <xmx:ICQNZyHkuJs9O0izqwz7WG1i3m7KGrfPj_TgNj0zv4U8TaU2JTtvBw>
    <xmx:ICQNZ5NZuMmS7Qyw3qPt3gZ75xNOaaNGlJ6mP0SW-DJ55KVphkmHKw>
    <xmx:ISQNZ8JnlhTrYQQTU65WKSz_GPtVmIdproOM1gvg7Elo8Zo8-d_Ijkux>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 10:01:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 581a68b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:59:47 +0000 (UTC)
Date: Mon, 14 Oct 2024 16:00:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <Zw0kGLZ-mcYjb6Je@pks.im>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im>
 <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>

On Mon, Oct 14, 2024 at 02:57:13PM +0100, Phillip Wood wrote:
> On 14/10/2024 11:53, Patrick Steinhardt wrote:
> > On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
> > > On Sat, Oct 12, 2024 at 11:09 PM Usman Akinyemi via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > > 
> > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > > 
> > > > Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> > > > and strtol_i() for signed integers across multiple files. This change
> > > > improves error handling and prevents potential integer overflow issues.
> > > > 
> > > > The following files were updated:
> > > > - daemon.c: Update parsing of --timeout, --init-timeout, and
> > > >    --max-connections
> > > > - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
> > > >    tags
> > > > - merge-ll.c: Enhance parsing of marker size in ll_merge and
> > > >    ll_merge_marker_size
> > 
> > To me it's always an indicator that something should be split up across
> > multiple commits once you have a bulleted list of changes in your commit
> > message.
> 
> Agreed, but I think in this case there is a common theme (converting atoi()
> to a safer alternative) and the problem is with the commit message listing
> which files have changed rather than unrelated code changes being grouped
> together. This patch could be split up and if there were many more atoi()
> conversions it would need to be split to prevent it being too long but I
> don't think its essential to do so.

In theory I agree. In practice I think we should have better
explanations why the respective conversions are fine and whether this is
fixing a bug or not. And if it is fixing bugs I'd also like to see tests
added to the tree.

And by the time we got there it makes sense to split up commits.

Patrick
