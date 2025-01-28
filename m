Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C48462
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738051627; cv=none; b=IqNj/d9GC5paqIKffsGNq4pd1KBtMoJD3dFT/TIAAPSHUGf2sJZ342xl5bOewFPqC+mete9MLrX+hdlz40MC0NZYIOAI/U578mb+oBVcKA4ooWIKfV6IySdquQt4sPKbAYtXeoxuWu5WYWe81sALWyAui4bMryjwm1jZgr4SClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738051627; c=relaxed/simple;
	bh=1mDKHWD2D06dgKCBCaiLMEABgQ/xOz0WPIm8m6fThos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWKyngiyUNkBHo3A9Rsp4z0D/lOiclRxlCA/apPWTmoYyjaoutG4uVeNMfgfIXSObUdKmWupXAG3Qr+RtdjuIV6YfKXeEgiJP0dVp/0JmwupSAX8GLpYUMxggh1edjDzYdBYmZE2Hd6ZZOKqYLhBKo43jxd1qhY7SveuDmLXsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oIaPqviG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwtVv9Rz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oIaPqviG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwtVv9Rz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CDA9F11401E7;
	Tue, 28 Jan 2025 03:07:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jan 2025 03:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738051623; x=1738138023; bh=ihpEhxGeQ2
	u4Ki6Vhyq/y1/cY3y4oPCOjjrdBIZj3TY=; b=oIaPqviGKcpu8zWeVi4Xr9uUMO
	H80ZdBFu9/Xz7CwcoI4TFbWMXtWN9V4lL+6+RlIrJM2cRrhIPy00vGXt2B3uk3E6
	qbMPPnx7yIpgnyMcT2lM+/3OP/Wtl5ExF2zFVsWKxWLOeGIsS7dSCfu4svGNW9Ao
	kNji7IZs6sX30+AIh7DWxdn1cMymFxCQyd+po/hxaiu31n4vfhiPfz1yNCqLiHrK
	hmr+dYB9vugq7zh8WxFw6unMXCufTjDtUo9Qlwp60Nszv65p+XnHtrbvqejeXRSz
	aA/8QcfNGobnJFodHcavo4msrzt94KfcEZLJ7g/4DK5XmrdW3HHh6EHR9FHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738051623; x=1738138023; bh=ihpEhxGeQ2u4Ki6Vhyq/y1/cY3y4oPCOjjr
	dBIZj3TY=; b=QwtVv9RzYEiZ+GdAXM18vvb3BDiUMY8mi6HKXjIB4UjOUpy7JpZ
	NOkzXEuvwTOy50S2JSOCWCJbcb2/oLrcvHe0m4TQse1GhXpL2Y99EMC3JnhKx4zO
	IOXGOdAVIREFEUxVQGKqzsON8b7aHx+9mStiCLNqVq69kezlTVZMcAib86sUQIua
	Dgxn1NA4/R9gQn1iFCpHuBZUX8gsSiK4jfiWnzp0El5kYPwOwhFW16gpUqlNu83F
	W4Mz7//kKEOLhc26WWETJcIjledo1XpG7H7rNqfMsrtG8+wUmsQ9JuCo6h5s7/St
	rjMMz5GXrV8C4PTRt5RWLMQlqfYUXHJMvlQ==
X-ME-Sender: <xms:J5CYZ1zQsFeXWEaQvqdiX9A6QtkPkSOTVfPumo0OCyqdNsu5Tzl2Pg>
    <xme:J5CYZ1R7QVYZS1pGt1HYccte4Gco8It6swpxJ8O8FlJ4DiOQsRf88SCRN6IxdOo04
    Gvjy1yD4sN6TCxBfA>
X-ME-Received: <xmr:J5CYZ_VSfw9FZQ0Sfb8jnfAhvCxH1xkfQTG-SknYgpJ3wECYkkCgteMOX2HPf-LfzUbBfxiQq_B5umSK-7u40q53CDp2M1lDY3-eywinyCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J5CYZ3jcfTLB8rKdr5-cMJTyH3DeHVE5IUtkv7d1hylg24ar02Kcjw>
    <xmx:J5CYZ3Bzjh51BwvL2X1TndATRDXLQ_UFJPtRe_3vAo9QnNPO3NB2Ew>
    <xmx:J5CYZwJjhAqBJqwTxUcvtwxVi8Bp1L5NKhvFlCowcE6YQv14RWj4cA>
    <xmx:J5CYZ2CFx9-HICqDM8r5t79crc05cxeMTtReUNAAqUHU74EbbYrCWg>
    <xmx:J5CYZ-NmgQfx-Woc5ojeFExq-rKcHt6dkzPxG1nCa1_jolZYqKb305-b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:07:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 459b86c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:07:00 +0000 (UTC)
Date: Tue, 28 Jan 2025 09:06:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 01/19] reftable/stack: stop using `read_in_full()`
Message-ID: <Z5iQH4C2JqazaJUl@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250127-pks-reftable-drop-git-compat-util-v1-1-6e280a564877@pks.im>
 <u7hbqd6at3owgka4pitd4vgzc5emgipnx3w4dat5ofpiv5hxxo@lbfj36uhqtsr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u7hbqd6at3owgka4pitd4vgzc5emgipnx3w4dat5ofpiv5hxxo@lbfj36uhqtsr>

On Mon, Jan 27, 2025 at 10:57:20AM -0600, Justin Tobler wrote:
> On 25/01/27 02:04PM, Patrick Steinhardt wrote:
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index f7c1845e15..9490366795 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
> >  
> >  static int fd_read_lines(int fd, char ***namesp)
> >  {
> > -	off_t size = lseek(fd, 0, SEEK_END);
> >  	char *buf = NULL;
> >  	int err = 0;
> > +	off_t size;
> > +
> > +	size = lseek(fd, 0, SEEK_END);
> >  	if (size < 0) {
> >  		err = REFTABLE_IO_ERROR;
> >  		goto done;
> >  	}
> > +
> >  	err = lseek(fd, 0, SEEK_SET);
> >  	if (err < 0) {
> >  		err = REFTABLE_IO_ERROR;
> > @@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
> >  		goto done;
> >  	}
> >  
> > -	if (read_in_full(fd, buf, size) != size) {
> > -		err = REFTABLE_IO_ERROR;
> > -		goto done;
> > +	for (size_t total_read = 0; total_read < (size_t) size; ) {
> 
> The cast from off_t -> size_t matches the currect behavior, but is it
> always safe to do this? In `git-compat-util.h` it looks like we have
> `xsize_t()` to safely handle these conversions. Since this series is
> moving away from `git-compat-util.h` should ideally something similar be
> implemented?

It is safe, because a couple lines further up we check for `size < 0`
and error out if that is the case. So we know it's a positive integer,
and thus it can be represented via `size_t`.

> > +		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
> > +		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
> 
> The error handling here for EAGAIN doesn't go as far as what `xread()`
> does via `handle_nonblock()`. In this scenario is that ok?

Yes, because we don't set `O_NONBLOCK` in the reftable library.

I'll note that in the commit message.

Patrick
