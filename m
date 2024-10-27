Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29B2570
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043556; cv=none; b=o/AWhKRBAmFfJt8wE0ReAQSYz+idblN96OFKb3xm5asTZf/kCsHBd8dQolqNRwZI0hdrhlM3ZAdWPtigcuHGSFODAw/7Ru5Otl8na4PhvbO4WamEaQQIbzL/0oTTKabJN5Et4ZViZSH3mFsgs+VsTZRB0izQ6Zh8ga/LIToXbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043556; c=relaxed/simple;
	bh=NdaY4Xh2F226VfH7xcLgqYY2JzBoyydHn0PeGA51R58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uje8OvNkoqk/4l9zynY3dB1y4rw4zHr9xvV2LevPhVzvykenSdb+z3/UMrp4opobXPoO4cdanTn00w8KyDjstbmrUhalbi039cptHw1fTHhxcXWp9thGdM9pZfnJ8/KfgpeU4+U0k7mUVwuifGhCxBDe9Bm1oF1/i1o3MGZx7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rRZUScts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=An/I0Dew; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rRZUScts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="An/I0Dew"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8048325400AB;
	Sun, 27 Oct 2024 11:39:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 27 Oct 2024 11:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730043553; x=1730129953; bh=9iCugBNJJv
	ZGpq/3j2KTbCSRYII18apwKxRpUygIrG8=; b=rRZUSctsICqz8iFcekQLquVihA
	HSIZLjoe/uzXsvJFZA3AE9EwI6xv37LRxXMWllEfnOvSAieGnWLow/Q65mIjU2iG
	kwJ0heg29SE38RIVfjc31oNoxfPurHY6QvrbDtgAkDMxbsxXzVLsCaNvedDDoviA
	VRxnb0TKvvkgqVm+K0JrwaHcVLy+SzEO2j5giFP5PvwowjrwzD5Nhmbc678p/poO
	/IQcIhgTw97wWz5txvc6a4jIhS6dJTfrOZUFyb8OTJcJqmB1MuX0mF0sYuJ2j7k2
	Brrf7QFlNqPd+x/14lRqqHDiLCE/ww5kzr3T9CboLXvWaxJ+UvINCUCcXOwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730043553; x=1730129953; bh=9iCugBNJJvZGpq/3j2KTbCSRYII1
	8apwKxRpUygIrG8=; b=An/I0DewVF2imOnUYAT+DD/N2vdA88Na08T504Nr6B4W
	ZTg9i7ReDFPR554dmE8O/4sC4j1V8yjPC2nQeYShs2N5fjEf3TmNxTtChyc9WZZE
	w7YSgADQlffsDyjD/6jlTYWol19xzhRDWxRrKu1v8vis+bBOuNMRR9byfCtwt/7H
	D+0BHyGHIi+5sMNDLoVhcvhiaGIsVBtmYAGD3z9jum4TsF1mK70+DindywxY7C//
	YBKfHXUyAEjf6qaNtGFazOhiiO4c22IJOpgp9aEtgyIM9q/jKfSpFSDPQD91s8bz
	u8t2xBMS0+wqbaxuIZzdMQUJbVunEr5Px9ZnLuJ1Ow==
X-ME-Sender: <xms:oV4eZ3BMYF_ZTgal_VGjEnVzFzLphuNVjRvgFyxyQcU3Fc40atw6Uw>
    <xme:oV4eZ9hH4_-YiwLnrIdvvtwJR1nY6itNoJc_9RuPuO7qqqpl25tosiPlh3uPDIqzd
    gNol_fbxg_CkXPOEQ>
X-ME-Received: <xmr:oV4eZyn_0agnoe9Et_6KQVTJSLURvzQLB24AJYcS7GK2_z-CYYRUGn6LmQOXyM3aQSOVUUGvhsfwPR0PD1RO6hAImIGL7UaSizk9-rqF93ip4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhei
    theskhgusghgrdhorhhg
X-ME-Proxy: <xmx:oV4eZ5zmV5mRR8qvx3jgVQcU6VDJjWiQ7QZwZyA_X3elg40wCv9xxA>
    <xmx:oV4eZ8QcsV_KXopNzm6A5uC1nWaEVXLqVcsRZYH_wRMYV1QM-FDbfg>
    <xmx:oV4eZ8bz19tS1akTG-ItRKWtVoQSQovhn3_gz22_TDow2iB-Yn42sA>
    <xmx:oV4eZ9RAHIFEOe9R6RyEKDTpR-PLjU4bkx0VpzKocZak1Pzb0XTQ8w>
    <xmx:oV4eZxJV6VCGUJn6lLHw-cgpxvr-KLKpEbT3mFVXofQxlITEsXMkHMen>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 11:39:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7abc9332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 15:39:07 +0000 (UTC)
Date: Sun, 27 Oct 2024 16:39:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 0/3] compat/mingw: implement POSIX-style atomic renames
Message-ID: <cover.1730042775.git.ps@pks.im>
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
X-TUID: v756ZX1pszKz

Hi,

this is third version of my patch series that introduces POSIX-style
atomic renames on Windows to fix concurrent writes with the reftable
backend.

Changes compared to v2:

  - Use `DWORD` instead of `int` to store the `access` flags.

  - Fix handling of `oflags`.

  - Add a comment referring to `mingw_open_append()` for why convert
    `ERROR_INVALID_PARAMETER` to `ERROR_PATH_NOT_FOUND`.

Thanks!

Patrick

Patrick Steinhardt (3):
  compat/mingw: share file handles created via `CreateFileW()`
  compat/mingw: allow deletion of most opened files
  compat/mingw: support POSIX semantics for atomic renames

 compat/mingw.c             | 157 +++++++++++++++++++++++++++++++++++--
 t/t0610-reftable-basics.sh |   8 +-
 2 files changed, 156 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  63c2cfa87a4 = 1:  63c2cfa87a4 compat/mingw: share file handles created via `CreateFileW()`
2:  c308eafbbb5 ! 2:  91d434116f3 compat/mingw: allow deletion of most opened files
    @@ compat/mingw.c: static int mingw_open_append(wchar_t const *wfilename, int oflag
     +		.bInheritHandle = !(oflags & O_NOINHERIT),
     +	};
     +	HANDLE handle;
    -+	int access;
    ++	DWORD access;
     +	int fd;
     +
     +	/* We only support basic flags. */
    @@ compat/mingw.c: static int mingw_open_append(wchar_t const *wfilename, int oflag
     +		return -1;
     +	}
     +
    -+	if (oflags & O_RDWR)
    ++	switch (oflags & O_ACCMODE) {
    ++	case O_RDWR:
     +		access = GENERIC_READ | GENERIC_WRITE;
    -+	else if (oflags & O_WRONLY)
    ++		break;
    ++	case O_WRONLY:
     +		access = GENERIC_WRITE;
    -+	else
    ++		break;
    ++	default:
     +		access = GENERIC_READ;
    ++		break;
    ++	}
     +
     +	handle = CreateFileW(filename, access,
     +			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
     +			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
     +	if (handle == INVALID_HANDLE_VALUE) {
     +		DWORD err = GetLastError();
    ++
    ++		/* See `mingw_open_append()` for why we have this conversion. */
     +		if (err == ERROR_INVALID_PARAMETER)
     +			err = ERROR_PATH_NOT_FOUND;
    ++
     +		errno = err_win_to_posix(err);
     +		return -1;
     +	}
3:  ee1e92e593e = 3:  2447d332a85 compat/mingw: support POSIX semantics for atomic renames
-- 
2.47.0.118.gfd3785337b.dirty

