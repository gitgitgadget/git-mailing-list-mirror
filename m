Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579D17279E
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043514; cv=none; b=KDJD+8RjlhKyrWwUIbg3jmR/DW17iRDLT5YgdS6a4Y0lRL0xIXcvjS8nxOnq2Z5COPGkhKLAKh6bSPxqTZ/qZvdpNY9LH1bSXQfezi/PhHmqangvnryMKEUxwvMAb0Q82uJfWbdjH2g46WzrNAdYtP+/t/47ujgM4W8HYitb89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043514; c=relaxed/simple;
	bh=To5HTNRvl+nz222Udw4RULmk7mLQ2MUAlz2CEgHkcNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXbaQam10r9d0aLNVAkSKGpeXWaX4alA1B44GussGH0qXimWfc4OW5hvSKzA/qQ2QEIcDtZkMv+YTZC2VNenD4UJDtuBzWUcGFvq9O6r6hR1vXrbJjMkbrRBrlci7O1IM60xrcJDbxGZ7g36RQCcWkFoY7UAJFFk7i/jRgoH2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VMiRH78J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgjFIJms; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VMiRH78J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgjFIJms"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB90D25400AB;
	Sun, 27 Oct 2024 11:38:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 27 Oct 2024 11:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730043510; x=1730129910; bh=AtAseqE8LS
	dtZd9BX/M0qsVO92uJqIwS2akXOsCGLtg=; b=VMiRH78JSsgm+siq5a6ngfhGEi
	S900R/9/D0A0u5VboMYzVWmDQw8rTKaQSCKBU+sgnHELbXRkxBNdnpXykN8WN1Ui
	w1nd3iGlYT7kLdCEa/SD+X3K7laPOpSORhOVMGJwQgF3KSVf7MkxwQIDnbdVzmqE
	1IWhG/YoXNElrlCp6F4J73m/Afyp0hVpHoe4uW9/TaC8re/k/tfpBr0vqanbsPOG
	hgaESQSTmiPI7YXUmO/cWHiREDamagRpeEAs2BO9FMAuXsuA+ZoRqjq60iP3LoaR
	ekpyD9AaA0sZnvsaea0JoA/Bw5kWamwJq+pjV++cHGV3Ai7GrTimpvk86l+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730043510; x=1730129910; bh=AtAseqE8LSdtZd9BX/M0qsVO92uJ
	qIwS2akXOsCGLtg=; b=WgjFIJmsWJg0+gJcWgrLEbpqJw6B3g4xQ6xFe0FdQ3sk
	zANLhYH04gi5kzqsWn4q5trjkVtiT5ZBN95JY+2LbYRJbBJ902mg+C8GCI8ZAWty
	AwFJzeySLwkT//k/39sy4dBYkNRDAAEniiQIgkc56M3UYBnUtwaEe5/xauqRfrWV
	0s2AcgNxIAkfAHC4J9BBQ5QNd4XNsO69BT5m/TTtaYPBKo5cM3VvXSFVI8Ws091A
	hCImbU4Zb7K5STcxlLmvrZXOuziy1G8LH2eojNkSiMjE158CqzSXQTPehEOWLINa
	rxh5sasBWwXX12V/59i1FN/LMfnGms7fLLlWFfSzAQ==
X-ME-Sender: <xms:dl4eZyQoaIoeFNoANhwnpRBz0IWJXiDeEEEavm1ueWehT4yZxAwpdg>
    <xme:dl4eZ3yLjwOHDu2LabasClp8X7qwlkJEXjiAb6H0elQwX9dLWIjHoJYwtfXB3-Snf
    Nr7hzVpcaOYiPXKCQ>
X-ME-Received: <xmr:dl4eZ_0jIJGvnVuecB-ibMcIeRcHI70PjNeknqkWUtiT6r3U3JpiUB4hpYUGSAIqTxQRJ9_WBjMkK5yWQtYRdHXIWu7inwmo-fv6yQjDaeG07A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:dl4eZ-AMJINPUVgCNjRIGxrnxrlV5CKFbCEc8DJZQbwyt-UBP-3rCg>
    <xmx:dl4eZ7h_rpQ_jJua2EJuQUHafGmY1Sa4HVsqk1vUEVPi0LX2k5CFwA>
    <xmx:dl4eZ6pNkuMESWDrsj4maSoQSjJpV6r0NAb13vu4K0dzaXekdmTIkQ>
    <xmx:dl4eZ-heZ85ZweN6e0YoJ2UPafprlxMkZSQG_cmF3yVSAyBdW8IFFw>
    <xmx:dl4eZxbo8y5rJS9l2_7OiQpt64B7cb5jq1Q7jumqmx_HU-Q22-FkUUW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 11:38:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1726e9b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 15:38:25 +0000 (UTC)
Date: Sun, 27 Oct 2024 16:38:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <Zx5eipv_Un3x1j-4@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
 <c308eafbbb5a7c853b8126750c4c44a8b8635192.1729770140.git.ps@pks.im>
 <a769d5a6-0d0f-4df4-b581-539d00aacbc9@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a769d5a6-0d0f-4df4-b581-539d00aacbc9@kdbg.org>

On Sun, Oct 27, 2024 at 02:17:36PM +0100, Johannes Sixt wrote:
> Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index e326c6fcd2d..6c75fe36b15 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -532,6 +532,62 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
> >  	return fd;
> >  }
> >  
> > +/*
> > + * Ideally, we'd use `_wopen()` to implement this functionality so that we
> > + * don't have to reimplement it, but unfortunately we do not have tight control
> > + * over the share mode there. And while `_wsopen()` and friends exist that give
> > + * us _some_ control over the share mode, this family of functions doesn't give
> > + * us the ability to enable FILE_SHARE_DELETE, either. But this is a strict
> > + * requirement for us though so that we can unlink or rename over files that
> > + * are held open by another process.
> > + *
> > + * We are thus forced to implement our own emulation of `open()`. To make our
> > + * life simpler we only implement basic support for this, namely opening
> > + * existing files for reading and/or writing. This means that newly created
> > + * files won't have their sharing mode set up correctly, but for now I couldn't
> > + * find any case where this matters. We may have to revisit that in the future
> > + * though based on our needs.
> > + */
> > +static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
> > +{
> > +	SECURITY_ATTRIBUTES security_attributes = {
> > +		.nLength = sizeof(security_attributes),
> > +		.bInheritHandle = !(oflags & O_NOINHERIT),
> > +	};
> > +	HANDLE handle;
> > +	int access;
> 
> I would have made this variable DWORD or unsigned instead of plain int,
> because it receives a bit pattern and would match the parameter type of
> CreateFileW() better; but no big deal.

I have to reroll this series anyway, so I'll just fix this while at it.

> > +	int fd;
> > +
> > +	/* We only support basic flags. */
> > +	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
> > +		errno = ENOSYS;
> > +		return -1;
> > +	}
> > +
> > +	if (oflags & O_RDWR)
> > +		access = GENERIC_READ | GENERIC_WRITE;
> > +	else if (oflags & O_WRONLY)
> > +		access = GENERIC_WRITE;
> > +	else
> > +		access = GENERIC_READ;
> 
> O_RDWR, O_WRONLY and O_RDONLY are not flags, but values occupying two
> bits of oflags. This must be:
> 
> 	if ((oflags & O_ACCMODE) == O_RDWR)
> 		access = GENERIC_READ | GENERIC_WRITE;
> 	else if ((oflags & O_ACCMODE) == O_WRONLY)
> 		access = GENERIC_WRITE;
> 	else
> 		access = GENERIC_READ;
> 
> or similar.

Ah, that makes sense indeed. Will fix.

> > +
> > +	handle = CreateFileW(filename, access,
> > +			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> > +			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
> > +	if (handle == INVALID_HANDLE_VALUE) {
> > +		DWORD err = GetLastError();
> > +		if (err == ERROR_INVALID_PARAMETER)
> > +			err = ERROR_PATH_NOT_FOUND;
> 
> First I wondered what this is about, but then noticed that it is just
> copied from the mingw_open_append() implementation catering to some
> bogus network filesystems. Good.

I'll add a comment.

Patrick
