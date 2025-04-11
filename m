Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17782980CD
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363647; cv=none; b=edNxG1TcO/TLodYQrxWVGp3U2vA5jLIoSIalMlwDZIsHeGDI4NWYPcqRjYQkVoK3G8IbV1+srhCitMUMoFtieCbA/zVSK0FH0tHk+i09em8lQuKrS6vWHIdL6DwfHnakgTgB2QqMRgxq+GnB0tenpDbEmkEAbZbNmbo/JYkm0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363647; c=relaxed/simple;
	bh=/0aG8+YbYlOH60xIEKzuWhTLjmpb5vmOQgwVAMZGV/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO1uYDgkBTdTZL4da+9o0j9b1r2B2S7Ha4XxEaMhcLFDAEBwoXslWvVAeeZ4ONnu0pZV05bWxAi4YfbCDxIzOfKeLYDmINmFj7fDjwxkZfxK/Z6+enmGToWxnWzKx4F3AywdRn3iYY6p0uLaCgIwHcUR3gAhGi+9hvPcn2vU7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HrNcWvdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwEwmTTm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HrNcWvdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwEwmTTm"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A0D72138028E;
	Fri, 11 Apr 2025 05:27:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 11 Apr 2025 05:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363644;
	 x=1744450044; bh=F/7RN1BFX/CFMSYrmtED2tRI/rz30Rv20r6dQmY51JI=; b=
	HrNcWvdEd6vWYJDGQyGhVWdMLH3zweImJrfscFTcxiMPp5onIn693BwhCUnqp6qG
	YzfFwdJLp8IpmXrmdaerYUFC0AnlZrFv7FdYRXAde1UyKnXQqtIDE66f/T+Mk8Zj
	r7YqssaZvhsxXPHjM3C0f9+3LQ5D5uNnu8QOpASWwu1zLEEFGUafe6luxWSqgJpg
	/U+a0sZLgximClEbzuyZBRQoirN6PcJ2S6V9WepZcgsW40h8t7qYrd5l1dSR479M
	LMIkQbe8aYJXRU+lDuvhkyPzI0YMLTfnvJ3OcBREXXNZF7glbzVkGg14kfZwkq2S
	JvKHwU+y4riI4mNmGwg4lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363644; x=
	1744450044; bh=F/7RN1BFX/CFMSYrmtED2tRI/rz30Rv20r6dQmY51JI=; b=E
	wEwmTTmKt/kVrjBslIHrsPlYVyuD2eiXkBdgbSgwXjbQPTlWonBDXIU+glWclc7D
	pRj7OJNguSvky6I3TGGD47f/IPgzANbsJXbmiZ1zbdjgOT2tOED1H61sKVO0Evau
	bmC4IILVvr5t4xejbCJdLmZFoSAV188nELpkOOxx/1tFZPwwVgEjvUN7OKz4p0Lq
	X7K8xm97TU76TO5iZWhQkgYy1FJYTtBcjj5cr2Ww6QVYvY0IoeGMjiH8SIVEyVTr
	6vsJJSC8+FmfKIjaOFXltYrCGD9kdKKsSOg1Hivvjo2dr0OJz/vPs1QmKOYfTINv
	MIvg71wIhqjO+Jfuj/KrQ==
X-ME-Sender: <xms:fOD4ZwZZJtUQ-6mXLYPw8BRwjNSeCQCJJd7Ub96yvBSOZHhE8CuZkw>
    <xme:fOD4Z7ZnzcKoLKrSkRUDt7nWrT70Fi7ztVm24uDwcSSNZMqq8jWGJ0XSLQrxhCOyW
    LIPhCmFg-T39dkAqg>
X-ME-Received: <xmr:fOD4Z68Ey-Pq6u2GZSiubgjwQBLsN2IsGfWiSYLGn-J4qyotapkGbDBH0ucDqcMPBULxyC8LJG6o5HdM7oJ8VTFluyuSphSvIMFiDYrwV8bjWDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fOD4Z6qk3buGOJUatoheXmOdcwOZErfiIUu6i1WHP0HidzEvftTOBQ>
    <xmx:fOD4Z7qcS5RkGOWzAfyeguEXmdlevGajInY20T7KEG7KG4f70TImxg>
    <xmx:fOD4Z4RzX1v3XTtL6OpPMdvOe6FkVfvOr7qXc8w07eaAQF6Wqd9Wag>
    <xmx:fOD4Z7pYuhE9JqKW_o1QDNdaSxySEQBjuhv2CTmGOJH1mx7mb8NQtQ>
    <xmx:fOD4ZzHPd-Cw2gHjctfdiQ-AGdCBLqijq_7glDXlg_3ngXO7_aIFwhiP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:27:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4724ee12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:27:23 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:27:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] Split up "object-file.c"
Message-ID: <Z_jgeWbEAMjYUSBQ@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
 <CABPp-BFv_WGVUexyQBHkCcyO0N+UQCcJ3eM9Oh6bP_ZCUkaxLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFv_WGVUexyQBHkCcyO0N+UQCcJ3eM9Oh6bP_ZCUkaxLw@mail.gmail.com>

On Wed, Apr 09, 2025 at 07:42:38AM -0700, Elijah Newren wrote:
> On Tue, Apr 8, 2025 at 3:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > "object-file.c" is quite a grab-bag of all kinds of different functions.
> > Many of these functions aren't really a good fit though and should be
> > owned by a different subsystem. This patch series tries to split up
> > concerns a bit better by splitting out this functionality into other
> > files:
> >
> >   - `safe_create_leading_directories()` is moved into "dir.c".
> >   - `xmmap()` is moved into "wrapper.c".
> >   - `git_open_cloexec()` is moved into "compat/open.c".
> >   - Several functions attached to `struct index_state` are moved into
> >     "read-cache.c".
> >   - Several functions related to `struct object_store` are moved into a
> >     new file "object-store.c".
> >
> > "object-file.c" now mostly contains logic to read and write loose object
> > files, whereas "object-store.c" contains the higher-level logic to
> > manage different object directories for a repository. Eventually, these
> > will become the loose object backend as well as the `struct ref_store`
> > equivalent for objects, respectively.
> >
> > The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
> > with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
> > branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
> > into it.
> 
> I was able to apply with these instructions, and looking over the
> series locally with --color-moved was very helpful to verify that you
> were moving functions without modifying them (or, to notice where you
> did modify them and why, e.g. removing the static declaration).
> 
> I very much appreciate the grouping of functions by area that is done
> here with read-cache.c, wrapper.c, compat/open.c, dir.c, and the new
> object-store.c, as well as the new enums to make the purpose of the
> HASH_* flags clearer, and the reduction in the number of globals.
> 
> I only had a few comments on a couple of the patch commit messages.

Thanks for your review!

Patrick
