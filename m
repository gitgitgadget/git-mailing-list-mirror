Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85871170853
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770381; cv=none; b=Jh5ORSrezR9j7Gwb6wZs2Z1uQi+sDioIu/7eNCA0dCkemuHH+uqryjcohravugMKx+JPjbjMpKJLwo6ebZbS66KImL0mV1Nf/H170y1s/CdATzdVD1/xnePOvYP5nrWk19BCj07wj3aQPBl+DoUw/iPZbigVKPmnzAnj+sYhDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770381; c=relaxed/simple;
	bh=yk9BfVdMOb0rucGf7v4fZfKT+y4Mp3B9dZC+LyjJLSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8quVezmf51CzNoL1Rnhn1sXJeXdB9iv/UjF7iycRC0dKYZq65rf9UdKLyIILm6a2XYzOqbGSiogccMsBFZ8ly+nmk6M2pm5eF+YodM8A+zE2DR5pkSZ6AhZ6txcroUvp3U8SQViQV1lLVx296mY6KgIFFvJfxJ3XlMFGWNUdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qFlJsF7m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYIua303; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFlJsF7m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYIua303"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DC1313806E8;
	Thu, 24 Oct 2024 07:46:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 24 Oct 2024 07:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729770376; x=1729856776; bh=8Ygj1mdBF4
	UmpGhhDJ/vE0+R+Kl9NMvfUxuIJID4jrc=; b=qFlJsF7mkC6Xktvcc5uwW74gbN
	IDjlDPWmcL3FIzUYmSQLDWCxEgeWeWUV3f7sfVxA7Ow0YUXDiyVfRm2fmEVTSsJv
	uHDLfmuHPpSU5+D7dommy4Pd5FCnVVSV8zyBabtUXfWSNrvCv2KjUu0B0dTBnj/D
	4TRLlxU8tfiPKeacDMnLXqk/5nuxQR+fOUFGeoKtL0fDzNiHbqGcxx1oxZzcmzI3
	Llm4HUa3SBeS2FJl4rrOkL5iH1MxQHrrzpR2PBIVSJH8YBxmjmOFCIqFiA0OwUqn
	4X1lhlU0orozMoAvDmIuBakHnWsEaEUVr7v+0HkJlQvAlhieL6GCutAJNO8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729770376; x=1729856776; bh=8Ygj1mdBF4UmpGhhDJ/vE0+R+Kl9
	NMvfUxuIJID4jrc=; b=NYIua303v1etgbIlz0AD0pNiWEG4N1easf4sK7HuFp4e
	OOd3TmQTgNql65UZNxze0/bQuTlS6qjxer+cjt6Aijvjg5ACtT2zoc2/uMPJpCIx
	QMujhITUSe+HmRf0SJE+6mOJBSFhFIuC639O1FDpPPr4enQFyX3p8s0tMH6JGBCx
	4CyEqYFFG7mS6GxCgH5/pT2j+8Ns4R5UKWLPF3LSOtOwTu6iEfMkSDeACXkVK9FO
	cjl6sKrvsJo59ezL7Bp28/SvZ6ulmvbWKYfRN7eT4o9GpaU6DrRwVUaon22r1IpF
	mNbbq+jE3V16VsM/Mgao4SQDZmmHNYLLabKBycEauQ==
X-ME-Sender: <xms:iDMaZ6o4IEcltTI2ucnfdZZ4xvNHJBI5vwbmTCwhfCv6bt2b1VztJg>
    <xme:iDMaZ4r4TiyPsZgpIT1ZnqYIC9AN_RfzyZWGd2i4pecz0jIjBUPBPGQk8qWqPBuWM
    LZGjnSwAv_iYTDx9g>
X-ME-Received: <xmr:iDMaZ_MmhJM8G63VLyW9nFXkyS4_UH-XjrUoVAd9HLmBiCK18n6iDd8Po50FTBG_xxTK9dfL97C9iJb6cfTQHDLy9u9yI3DqgVYDZysmKUsEf6ST>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iDMaZ55TKnG-x-FM1Le6AbBcklizRs0LEEi3mowg-Gc2doA0yKFg_g>
    <xmx:iDMaZ55SEYyJ3MCyz14p6YmGIiqRt59Mlt0GYl6nfWu_CgAjYAdezQ>
    <xmx:iDMaZ5i9KOLBG89JEG5UTwfs-lNhKyhTZr8OyXZ7yz_luLF7THhwZg>
    <xmx:iDMaZz7bbPBTI_xWGvDlynEIZyg6Njnch-QPSYlWYyaTWXLtttDDFw>
    <xmx:iDMaZ81TGyFfHWWCYL8oqWJjK8_zYOJKoE3WZQOZMM-SNVEeYbfb25Cp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 07:46:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 708f280f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 11:46:14 +0000 (UTC)
Date: Thu, 24 Oct 2024 13:46:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 0/3] compat/mingw: implement POSIX-style atomic renames
Message-ID: <cover.1729770140.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729695349.git.ps@pks.im>

Hi,

this is the second patch series that implements POSIX-style atomic
renames on Windows in order to fix concurrent writes with the reftable
backend.

Changes compared to v1:

  - Added some historic digging to the first commit message.

  - Fix various spelling mistakes.

  - Fix indentation.

  - Don't use the comma operator to assign `errno`.

Thanks!

Patrick

Patrick Steinhardt (3):
  compat/mingw: share file handles created via `CreateFileW()`
  compat/mingw: allow deletion of most opened files
  compat/mingw: support POSIX semantics for atomic renames

 compat/mingw.c             | 149 +++++++++++++++++++++++++++++++++++--
 t/t0610-reftable-basics.sh |   8 +-
 2 files changed, 148 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  907576d23d1 ! 1:  63c2cfa87a4 compat/mingw: share file handles created via `CreateFileW()`
    @@ Commit message
         Unless told otherwise, Windows will keep other processes from reading,
         writing and deleting files when one has an open handle that was created
         via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
    -    flags such that other processes _can_ read and/or modify such a file.
    -    This sharing mechanism is quite important in the context of Git, as we
    -    assume POSIX semantics all over the place.
    +    flags:
    +
    +      - `FILE_SHARE_READ` allows a concurrent process to open the file for
    +        reading.
     
    -    There are two calls where we don't set up those flags though:
    +      - `FILE_SHARE_WRITE` allows a concurrent process to open the file for
    +        writing.
    +
    +      - `FILE_SHARE_DELETE` allows a concurrent process to delete the file
    +        or to replace it via an atomic rename.
    +
    +    This sharing mechanism is quite important in the context of Git, as we
    +    assume POSIX semantics all over the place. But there are two callsites
    +    where we don't pass all three of these flags:
     
           - We don't set `FILE_SHARE_DELETE` when creating a file for appending
             via `mingw_open_append()`. This makes it impossible to delete the
    -        file from another process or to replace it via an atomic rename.
    +        file from another process or to replace it via an atomic rename. The
    +        function was introduced via d641097589 (mingw: enable atomic
    +        O_APPEND, 2018-08-13) and has been using `FILE_SHARE_READ |
    +        FILE_SHARE_WRITE` since the inception. There aren't any indicators
    +        that the omission of `FILE_SHARE_DELETE` was intentional.
    +
    +      - We don't set any sharing flags in `mingw_utime()`, which changes the
    +        access and modification of a file. This makes it impossible to
    +        perform any kind of operation on this file at all from another
    +        process. While we only open the file for a short amount of time to
    +        update its timestamps, this still opens us up for a race condition
    +        with another process.
    +
    +        `mingw_utime()` was originally implemented via `_wopen()`, which
    +        doesn't give you full control over the sharing mode. Instead, it
    +        calls `_wsopen()` with `_SH_DENYNO`, which ultimately translates to
    +        `FILE_SHARE_READ | FILE_SHARE_WRITE`. It was then refactored via
    +        090a3085bc (t/helper/test-chmtime: update mingw to support chmtime
    +        on directories, 2022-03-02) to use `CreateFileW()`, but we stopped
    +        setting any sharing flags at all, which seems like an unintentional
    +        side effect. By restoring `FILE_SHARE_READ | FILE_SHARE_WRITE` we
    +        thus fix this and get back the old behaviour of `_wopen()`.
     
    -      - When opening a file such that we can change its access/modification
    -        times. This makes it impossible to perform any kind of operation
    -        on this file at all from another process. While we only open the
    -        file for a short amount of time to update its timestamps, this still
    -        opens us up for a race condition with another process.
    +        The fact that we didn't set the equivalent of `FILE_SHARE_DELETE`
    +        can be explained, as well: neither `_wopen()` nor `_wsopen()` allow
    +        you to do so. So overall, it doesn't seem intentional that we didn't
    +        allow deletions here, either.
     
         Adapt both of these callsites to pass all three sharing flags.
     
2:  3552feddb33 ! 2:  c308eafbbb5 compat/mingw: allow deletion of most opened files
    @@ Commit message
         compat/mingw: allow deletion of most opened files
     
         On Windows, we emulate open(3p) via `mingw_open()`. This function
    -    implements handling of some platform- specific quirks that are required
    +    implements handling of some platform-specific quirks that are required
         to make it behave as closely as possible like open(3p) would, but for
         most cases we just call the Windows-specific `_wopen()` function.
     
    @@ compat/mingw.c: static int mingw_open_append(wchar_t const *wfilename, int oflag
     +static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
     +{
     +	SECURITY_ATTRIBUTES security_attributes = {
    -+	    .nLength = sizeof(security_attributes),
    -+	    .bInheritHandle = !(oflags & O_NOINHERIT),
    ++		.nLength = sizeof(security_attributes),
    ++		.bInheritHandle = !(oflags & O_NOINHERIT),
     +	};
     +	HANDLE handle;
     +	int access;
     +	int fd;
     +
     +	/* We only support basic flags. */
    -+	if (oflags & ~(O_ACCMODE | O_NOINHERIT))
    -+		return errno = ENOSYS, -1;
    ++	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
    ++		errno = ENOSYS;
    ++		return -1;
    ++	}
    ++
     +	if (oflags & O_RDWR)
     +		access = GENERIC_READ | GENERIC_WRITE;
     +	else if (oflags & O_WRONLY)
3:  d17ca1c7ce3 ! 3:  ee1e92e593e compat/mingw: support POSIX semantics for atomic renames
    @@ Commit message
         commits.
     
         Careful readers might have noticed that [1] does not mention the above
    -    flag, but instead mentions `FILE_RENAME_POSIX_SEMANICS`. This flag is
    +    flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
         not for use with `SetFileInformationByHandle()` though, which is what we
         use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
         not documented on [2] or anywhere else as far as I can tell.
     
    -    Unfortuntaly, we still support Windows systems older than Windows 10
    +    Unfortunately, we still support Windows systems older than Windows 10
         that do not yet have this new flag. Our `_WIN32_WINNT` SDK version still
         targets 0x0600, which is Windows Vista and later. And even though that
         Windows version is out-of-support, bumping the SDK version all the way
    @@ Commit message
         On another note: `mingw_rename()` has a retry loop that is used in case
         deleting a file failed because it's still open in another process. One
         might be pressed to not use this loop anymore when we can use POSIX
    -    semantics. But unfortuntaley, we have to keep it around due to our
    +    semantics. But unfortunately, we have to keep it around due to our
         dependence on the `FILE_SHARE_DELETE` flag. While we know to set that
         sharing flag now, other applications may not do so and may thus still
         cause sharing violations when we try to rename a file.
-- 
2.47.0.118.gfd3785337b.dirty

