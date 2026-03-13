Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00C2F5A29
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383006; cv=none; b=ICnx57XxeNOBrKYL8Zj12CKh5D1rUjJb7MiToJ344sdATbnrP9c+k9o3wvuKk7f0iOynyNi3/w3Bv+HMDmHepnf/6sNHiINUuDQGNYkGu6/7V+dLX9marIjJQPYtjnGknK83ZLVN4GsZhAQwk7C4/AP8yDjg7MkjeJC35n6Gr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383006; c=relaxed/simple;
	bh=TGtMiDZ8+rXRJpdEccsvW8P+C5nHRTDVXnqiKhnXixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7KbkRLb39bcMW0t+ZeWYb4DqKDwf5HiMrMxYozgHzQwGPf06FTIFZdHFMBBYIzFk6a8f2Ny6epcLH11B8ACAU6H+0k/PeHKbM7RA3XFWyFt/gcJRSvZPxOJxNMc1pgPvC9YqLkXRZw79c40vy+CZtPlPlHbB82magYDfN4eJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T4J0lkhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zF1uDW/S; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T4J0lkhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zF1uDW/S"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C78401D0007F;
	Fri, 13 Mar 2026 02:23:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 02:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773383003;
	 x=1773469403; bh=bdst7t1/5r23n6TghlUISJJDO/LS6WLBd+QGDo0F9Ds=; b=
	T4J0lkhUj3qfyibdC3Lonr8/JAIozomS3Bt+vWFsArqYtuE8KH7QQW5ltpgnnTwA
	4jMCTZJ6osT2wYleOh6Kd7wCHSbbFPuRVQ9XkUOJx7KPfP9raV7Hwdwr+eI885iD
	lJfFom8qLokOgpjjHLv5SUxm+1Gv8ZIEseStTLirP5CVo6FP688feloo23fzOYVV
	717P3uDtSu8D3w3dsrMM2JkpQbEibq3fSOHlrlrN3+ajUU0zhCqYo7lubL6Q0/kT
	iqpDjQkI+CV7V9oFNX0Fte4vPy4nfoqCb+0+yh7kYDaS5Yvl+s1w7eou8Ls7jQDs
	1xJBD8KXM9WUy42lfgYNLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773383003; x=
	1773469403; bh=bdst7t1/5r23n6TghlUISJJDO/LS6WLBd+QGDo0F9Ds=; b=z
	F1uDW/S1P4h+JGW8BguspnJ3gALR+r3Zp4eyxqlnaTUxo1C4X+7jJFfxo4nat2em
	hylQ2YLtPeycg6iqJwiRcJtry6yQpIi6DQW6TRrVIb8rlgyzNhaztkokXVKDctRy
	yPtAnrtbQgJVbMc0dGnXpGdBywOBZyR6plhMmKRuTPR+apOLGh8pHeUrwGbrHkWy
	nH+TEHdioCDQl5Pja+/CFKKtOAcNTFncM6RL9uPz/5IKwK13l6/7CksyGfBiLgVZ
	x5yVUGTd/cx4M3PCDa1h2HkYFDReHdA74rc2KjfGE9wZkCNY3+vWq6vq6z+Fn+XW
	EwDXXYk0bQweFa5R58CUA==
X-ME-Sender: <xms:W62zaX5lN-AMFDRBnHbCaeutmQzjI_8lR0ZjaP2suwW1nxz1Tu3tzw>
    <xme:W62zaZdRuYgjU6HOYprgE9ZtNI8pUDjZeOq506a9MBUmUD8fpM9WwgGbUwnJudThu
    rZIjJ1O34aubO7DxNv4TFS3hT5hjMUZb2vJZbIVirUb0JWqIv8zUg>
X-ME-Received: <xmr:W62zaS6gD1PpARZWJAVW28_NtHbGsyHLxiTUetxMmTSmnk0EYdHs0x54dZSKq6PK7P77wxii5tAp_bQm5-8Rje4Tu2fQr_6Vo3VffHsUkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsghkkhgrrhgr
    tggrhiesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:W62zae-IbSbmsXwGYZw3mkSrEs13vU63iK5TeYX6raO5dRycPqXWJA>
    <xmx:W62zacHfG6CIlvUo3w7YMckV2bGNDurVbd0iV0GZVPCSeitrnNiaNA>
    <xmx:W62zabUi1LO7l1vcCUKKBe-xJ0Es-_QZrlMBhOJcU1fbYnsdfvXyUg>
    <xmx:W62zaQ_OHbHTE9Akpo_slHZDRkFDCS8ZDS5lG1y1fqyeZmySZSIZdg>
    <xmx:W62zaWrJznyPuK1BSaysobrowXr1oXbQCRn8RFXgjog8HKq5VyzzR28w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:23:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 106ed5d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:23:19 +0000 (UTC)
Date: Fri, 13 Mar 2026 07:23:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com, l.s.r@web.de, peff@peff.net
Subject: Re: [PATCH v3 0/2] run-command: stop using the_repository
Message-ID: <abOtVYg1S_7aNNru@pks.im>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
 <20260312144437.626392-1-bkkaracay@gmail.com>
 <xmqqa4wdhxqn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa4wdhxqn.fsf@gitster.g>

On Thu, Mar 12, 2026 at 08:29:52AM -0700, Junio C Hamano wrote:
> Burak Kaan Karaçay <bkkaracay@gmail.com> writes:
> 
> > This patch series aims to remove the_repository dependency in
> > 'run-command.c'.
> >
> > The first patch removes the dependency in start_command() by replacing
> > the boolean 'close_object_store' flag with a pointer to the target
> > object store.
> >
> > The second patch handles the prepare_auto_maintenance() and
> > run_auto_maintenance() functions by passing a 'struct repository *'
> > parameter. With no global repository dependencies left, it drops the
> > USE_THE_REPOSITORY_VARIABLE macro from the file.
> >
> > Changes in v3:
> > - Added the second patch at the suggestion of Patrick to fully clean up
> >   the file.
> 
> [1/2] is now exactly as expected from the previous discussion.  The
> only miniscule thing I found in [2/2] was a new blank line
> introduced here, which seemed unnecessary and not in line with the
> existing style in that function.
> 
> Otherwise, looking very good.  Will queue.  Thanks.

Agreed, this looks good to me. Thanks!

Patrick
