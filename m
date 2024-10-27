Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AE1E517
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730050043; cv=none; b=FQqOEqOiaRi8U7b/YCUIG10CT9yKaoN4TQcSeNqzXfPkB+ftISho5rnK1XeZrjKB2P1Qs5NT1Agy0JO+8nbIpUrlLy/55TeCT3ENUeUthq8Wz9/sDANOMZG5Rxoo3PohGS26iL8bE5iynWs13QxD1ANvFZaLn32ogZj14iRDjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730050043; c=relaxed/simple;
	bh=dWs65tMbHa+aEI87FMPXmPqGdBM0WRuQXYPDJdKweTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqtbpsRtqtnWkPa/nylk4cAWJ5nHKmnRS4KRoErY1q2asr3kU/5rn7B30P1GGwHXzuz8CTpxHfQ/wKnhpaRJoGielVZnq/Ph+voy3ARdj4ES5x5cVdwqFDqXlEnRtGvU8h2MiM69GT7iJ/9ElgqbLU+oGN+DRHF5EB4cAkEF0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4HCXpCdT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aqixyKV6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4HCXpCdT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aqixyKV6"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2259925400BF;
	Sun, 27 Oct 2024 13:27:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 27 Oct 2024 13:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730050038; x=1730136438; bh=30rajleyaE
	s8YqN1D6ijA1QCHv66leZ2PDbMX53YV0k=; b=4HCXpCdTtK8sfOXjvvS5iA5O9l
	QObtBBEDHMPomxIoKUdFvRu3pmlBHDTQdzFxmyJxFAjM9eLCCklWYAJUbRWAIcU6
	IjpjF6l7tG7JcGXtwTDs4sl78L1sWuwwfK3heeTScpRakZ9WVDwH4Si3EGClzFlk
	6xEQjNKY6NQNIUh0IDNxtMLVIkcmUzWSQuq79/zLIcJq8wMacfaYNLnLeE60CIDD
	WJYxVDJj4KvU6h5eMZgYk9JudqGqV7bvYClTTt4iOL04r8H5tUm5fwcIHRPdYuwi
	5DCe6S24qlYiCGfu97LF4W/gKJYU+xJM/yp1j3G6J0x6IhRst8nEyhd5RQrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730050038; x=1730136438; bh=30rajleyaEs8YqN1D6ijA1QCHv66
	leZ2PDbMX53YV0k=; b=aqixyKV69CkQVscE7Wjpso5BMSrjWcr8hG12jS392sA+
	KZoo57Sb5pv6HCkbXy03ETAO3TY2ATGUzxHFgSZWTm5GOhRhm6XwkyqGa2TA3Cmo
	LIXXfuY/Cz+T7f8LO6RIL312kabM3+efR24vVH+5E0YFU03hEItEeZsNxFDdKDJo
	oAWhHWgcENDclQ+B4e6SiDSbg0KQZPa/pYQqW6oP3p8/DJlKSZnz3GxtgxdTIsJ5
	/HYPzuvehn2egiHe/rfutejiM74joM07dGFgjhISXC0WFaHK410NooI1B5MgSmrt
	PVYtkwDJNJoBR1nxRdWHi/6NKC+Ykzw0x0GugjXWcQ==
X-ME-Sender: <xms:9nceZzlfj-Il1WJlUQZ1bsKk_ywFhSHzFntW--qx-hhp-McrPjHlZg>
    <xme:9nceZ23dGsUFlBDcuRR3guB1Om-PpaYDLX3vxsVmJGkHOy629JzdbTU_vHo6cCdKZ
    w9izItoJci-Yn6Aow>
X-ME-Received: <xmr:9nceZ5qNPK07o4WR6hlI65h8HHf_kiOULzH1CH5_EiILC0ubzQVGdLmOLdCdQ8xNDq65PeiNp6G9E74D8nt0YK4KxkDTxT8SO7kwaMp1Pi-Qug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejheffudffueefleduleelieevvdffleduueehuedu
    tddulefgteegffffudekgeenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:9nceZ7kS3IQ5HWA3ix7hmI4qk2NeVCX-8Dd16c__A9tbrarH71Boew>
    <xmx:9nceZx3zVTcTWr-FroIM-sKw5NFIpOELFBfBvJXBh5ujTnWmElul3Q>
    <xmx:9nceZ6stp412HHj3I2tJDsI5vDwSnzd-vhDxp7m0VppjmSAuuxKBdw>
    <xmx:9nceZ1Wld1mCuACM1dAc9Szn4YqpSV7yoYyIoSPxaRZvJcYkREC1lQ>
    <xmx:9nceZ59WZcflkDerL_jkeC10PjUVnQDaW_ou6rhCrKzKtT6hmdwYp4k->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 13:27:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cc6869a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 17:27:10 +0000 (UTC)
Date: Sun, 27 Oct 2024 18:27:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <Zx54B6FdGprtH0HV@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
 <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
 <542b306a-523d-424b-bc9f-c63bb7040beb@kdbg.org>
 <Zx5eg2SkHMmNhQRh@pks.im>
 <49619b52-0fea-4179-a829-7ec4a6945055@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49619b52-0fea-4179-a829-7ec4a6945055@kdbg.org>

On Sun, Oct 27, 2024 at 05:31:00PM +0100, Johannes Sixt wrote:
> Am 27.10.24 um 16:38 schrieb Patrick Steinhardt:
> > On Sun, Oct 27, 2024 at 02:23:28PM +0100, Johannes Sixt wrote:
> >> Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
> >>> Windows 10 has introduced the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag
> >>> that allows us to fix this usecase [1]. When set, it is possible to
> >>> rename a file over a preexisting file even when the target file still
> >>> has handles open. Those handles must have been opened with the
> >>> `FILE_SHARE_DELETE` flag, which we have ensured in the preceding
> >>> commits.
> >>>> Careful readers might have noticed that [1] does not mention the above
> >>> flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
> >>> not for use with `SetFileInformationByHandle()` though, which is what we
> >>> use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
> >>> not documented on [2] or anywhere else as far as I can tell.
> >>
> >> The Windows 10 SDK defines FILE_RENAME_FLAG_REPLACE_IF_EXISTS and
> >> FILE_RENAME_FLAG_POSIX_SEMANTICS for SetFileInformationByHandle(). That
> >> the documentation lacks "_FLAG_" in the names must be an error in the
> >> documentation.
> >>
> >> I found the mention of FILE_RENAME_POSIX_SEMANTICS quite distracting,
> >> because it is a flag to be used with CreateFileW() and basically only
> >> has to do with case-sensitivity, but nothing with POSIX semantics of
> >> renaming.
> > 
> > I'd still prefer to mention this, because otherwise an astute reader
> > might notice that I'm using a different flag name than what is
> > documented in the docs and figure out that I defined the wrong flag
> > name.
> 
> Ah, I was confused twice here. First, the documentation that you cite[*]
> mentions FILE_RENAME_POSIX_SEMANTICS, but the name does not exist at
> all. There does exist FILE_RENAME_FLAG_POSIX_SEMANTICS. The
> documentation is just wrong. And in my earlier comment I copied the
> inexistent flag name.
> 
> But I meant to cite this flag: FILE_FLAG_POSIX_SEMANTICS (no "RENAME").
> It exists and is for CreateFileW().
> 
> Perhaps you also meant cite the latter one as the flag that "is not for
> use with `SetFileInformationByHandle()`"?
> 
> At any rate, the paragraph as written isn't correct.

I think I'm missing something. That's what the paragraph says:

    Careful readers might have noticed that [1] does not mention the above
    flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
    not for use with `SetFileInformationByHandle()` though, which is what we
    use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
    not documented on [2] or anywhere else as far as I can tell.

And I'd claim it is correct.

`FILE_RENAME_POSIX_SEMANTICS` exists, this it is not a documentation
error. It is at a lower level than `FILE_RENAME_FLAG_POSIX_SEMANTICS`,
the documentation at [1] refers to "ntifs.h", which is part of the
Windows Driver Kit interfaces. So it is not supposed to be used with
`SetFileInformationByHandle()`, but with `FtlSetInformationFile()` [2],
which _also_ has a separate `FILE_RENAME_INFO` structure that looks the
same as `FILE_RENAME_INFO` defined for `SetFileInformationByHandle()`.
The only difference as far as I can tell is that the flags used for
these structures have slightly different names.

Now I totally get your confusion -- I have been extremely confused by
all of this, as well. It certainly is a documentation error that the
respective `FILE_RENAME_FLAG_POSIX_SEMANTICS` is undocumented, but
having proper docs for this is rather important such that the reader
knows what its behaviour is. So I have no other choice than to link to
the ntifs interfaces, as it documents the actual behaviour, even though
it lives in a different part of the Windows APIs.

Patrick

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_file_rename_information
[2]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/fltkernel/nf-fltkernel-fltsetinformationfile
