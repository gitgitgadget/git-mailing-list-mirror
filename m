Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B518593A
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751458; cv=none; b=BVd8fT2pfshEOROGnQbxXy+u1X59yL+QOTELx4ZUihluV2Iz2Q5EX9/mhfhRg7zsOzl+6MHxKLfyQamJt0d/28Ku2zCFhVl4L6tZGvtx9cOZ1aK2xHyHSvBl0gPclo2eJDQNgGp6kYHWYt+uPWF44+4V6cKV/GnvNBN1Ge8YqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751458; c=relaxed/simple;
	bh=7tTqeMYTcbPZljVnagyJ3YACUzjbAHTj/z0cAMsqXS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af7X+DJUy75YDGzkXSJR5Z3MZZR6+J94gePx1oE3sqboypywMZuKzCyAdqW7Bc9RTa65XTm6VuRP4k1EeG9mJ747pjeoyMZrD/fKCxrMDI5HETT54PAgwCqENCuLi9yqsu2U+Oiqodi/ZJCltMakP6FKWS3HVu1hFA1fUtE+pU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xaiCjUts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZ4dbX3y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xaiCjUts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZ4dbX3y"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CDC8A13805C9;
	Thu, 24 Oct 2024 02:30:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 24 Oct 2024 02:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729751455; x=1729837855; bh=SrKe1bE2qp
	fTyKfbjpFeq3QGY9wN36am+aII9H/qCK8=; b=xaiCjUtsyNalpkKPD8mC8c0SNV
	OZY76XZXjn5Nnue2AksmWahV6cIqLQf4vLJ00IIQbosKtQFPPB2rZhz+jvFegWpU
	hMWf0SplRnHz2gI8FG2zKf27ICv8wpfL7O9RUunnMxO3OmO/bVlBaTMIeEmAgxRL
	QpCa4rTg6qdKDXDJ89k8COil8snuxsWmpKjicv5YZK/u9u9sL8yCYl53KvvEBflL
	hREzJQzw2XHXih0WkuQOxWrLmyzTrLFRpk0uQbiuyR6mxbhpTl31L/dfToIFt1AP
	z+ghy+RH1Df72XwTsiRH7WvGlnGV5Qsw5XvdVT9XCql8PaDdRosnBmEL4Fkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729751455; x=1729837855; bh=SrKe1bE2qpfTyKfbjpFeq3QGY9wN
	36am+aII9H/qCK8=; b=kZ4dbX3yRYJuTZVpwC/NjGz/eoTzu5ARKG+aXh7gvXnm
	9hOTMcWBqJnAvfDfjegVsIFTMhQOv6UNb1f5o4hIW1LrtD9/m3BZiMS7bF0ew9Wg
	YkP08dudQLgrKY39xKW+O8x6bG8LFPGWWFwKxaHI9968jbaqMKnhdsP09lzlv6n0
	uUaeXwWmoKe4/c6l5hoqGMJl1YWvVK/9zDnp+haeMCwVsFpaO2Wr64H//Dm5kwyV
	Sdwcxd6uJoccCoP2fYXdl0qVcvpCF505PbPEzFwISbHKVpzNApXkjdgJWMcqZ9ek
	lFRrbk865HqIzPGAR0rYbhlbp13ilvYnrB/nE11j+w==
X-ME-Sender: <xms:n-kZZ8D6rRkfOTTZ_-k4JeIFgS0uWM2Sq4Xh9IlNAnkV-fFx-EC9AQ>
    <xme:n-kZZ-hfUi943yZuhJbpo8VrMTl3ztwfckcXukou--22KbNiVoi6vO3J3GLTTaNny
    l_vhm_DnzzUm2r1wQ>
X-ME-Received: <xmr:n-kZZ_mdfbnnqhbIgfBEYMHFH4tczqrCXqpmTy-7oM2M5sawg8fGBNsYU8t0qUMr-_ys-UMp-aMsWqE0gA2BdVGmH4S0kE2-cpJ6BoqA48GXe5il>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggv
X-ME-Proxy: <xmx:n-kZZyxl2arcCDqEuU9WioSJassA3VYQCPIJZMRYu7KNmAmFv99Vnw>
    <xmx:n-kZZxRgSbgtE1XElSlIcg7nJS1qIyVzZdvbhZAhKzMN7AZTy-ILkA>
    <xmx:n-kZZ9Z85s4JirYGfHrJCAS-1u6pGq94t8Qq36Gqfq28Pj_T4aux1A>
    <xmx:n-kZZ6T8MEghqePoihUw_g4NT3aTJH--W7UOKYu8xvU9H4J66i3RVg>
    <xmx:n-kZZzdn1a21eSMjbnM0qVbB2EFVsN-7u6O3fEkWQruj6nBbAOU8yXE8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 02:30:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3450c0b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 06:30:57 +0000 (UTC)
Date: Thu, 24 Oct 2024 08:30:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <ZxnpnLbETN2-DZsq@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>
 <bc829d84-6696-4e16-9687-8ba611af29ff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc829d84-6696-4e16-9687-8ba611af29ff@app.fastmail.com>

On Wed, Oct 23, 2024 at 06:17:15PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 23, 2024, at 17:05, Patrick Steinhardt wrote:
> > While we have the same issue when calling open(3p) with `O_CREAT`,
> 
> s/O_CREAT/O_CREATE/ ?

Yeah, you'd think that, but no, it's really `O_CREAT`.

> > +static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
> > +{
> > +	SECURITY_ATTRIBUTES security_attributes = {
> > +	    .nLength = sizeof(security_attributes),
> > +	    .bInheritHandle = !(oflags & O_NOINHERIT),
> 
> `clang-format` thinks that these two lines should be indented with tabs
> instead (so two tabs in total).
> 
> (Ubuntu clang-format version 14.0.0-1ubuntu1.1)

And they indeed should be.

> > +	};
> > +	HANDLE handle;
> > +	int access;
> > +	int fd;
> > +
> > +	/* We only support basic flags. */
> > +	if (oflags & ~(O_ACCMODE | O_NOINHERIT))
> > +		return errno = ENOSYS, -1;
> 
> This use of the comma operator is maybe an idiom to save space and avoid
> a brace around the `if`?  This pattern is already in use in
> `mingw_open_append`.  I see in `mingw.h` that it uses:
> 
> ```
> static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
> { errno = ENOSYS; return -1; }
> ```

I basically copied this from other code, but don't care strongly about
it either way.

> > +	if (oflags & O_RDWR)
> > +		access = GENERIC_READ | GENERIC_WRITE;
> > +	else if (oflags & O_WRONLY)
> > +		access = GENERIC_WRITE;
> > +	else
> > +		access = GENERIC_READ;
> > +
> > +	handle = CreateFileW(filename, access,
> > +			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> > +			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
> 
> `clang-format` says that these two lines are too long.

Might be. But the `FILE_SHARE_*` line cannot really be any shorter
without hurting readability. And the second line just follows the first
line then.

Patrick
