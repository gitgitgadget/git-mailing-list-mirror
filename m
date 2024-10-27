Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160352570
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043510; cv=none; b=GAGO+ZzhdssOMDBw1+eFE0LY+eh7jDSnTiQpYPDZKdv1zVIfmUOCz/wWu+n3lgWe0pHm44vGN7fQXaIdQJoZ80GQDdR6+OBm8PjV9nawwzi/XSVo4po0UFCmxMAy3JA5fmsSNQ9jBofPybUAnmZISpucMhvl2kPX8hXlu1PQi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043510; c=relaxed/simple;
	bh=qzI+h2cNfIR3SPEgD7MOVxIovb1QxNKkrukhkbmYlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pplddwMWRowwt7R4Yhm29DTRurB9dF6wDrSirrmkDgjZ9QRvYY2suggTz2OikA+eFkEVw7cL9vFBWHq8g9nM3PECGsuUsoKKQ1HTb9KROt/y2D1dL3g1WLRoubGwFnfpPpVDGvmkJ09trrXbEvwzun5B5i/wYi584BG/ys3la2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fTitc8jZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5g6xlM8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fTitc8jZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5g6xlM8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E7D911400D1;
	Sun, 27 Oct 2024 11:38:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 27 Oct 2024 11:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730043505; x=1730129905; bh=eeunJ/szPP
	npYAVs0/PamKPqSPajD/bA54x4jv7FzEs=; b=fTitc8jZOENVf4QbG3vvtByWF7
	X+98a6xHsCOGaEC3ksuYHgJOjDHOwmXq41M6CFKPgma9DdNc1u+Z5+0ou21C0MPw
	3aVhMY1vmDwUI3sJ/waoOiD754ny85RoNwhz2mztXVpHs0H5YxT5CLUBU8tm8dSv
	gNiuXC1qw4D6UslEs0PDsNVInC031YUca0J6n4Kn1Dyt0YlMygSoikvFUzjNieh2
	tDUzmslz09bY6AB9zsGNU4NVi02vW7daiX0Ytpgz+j/2hEs0VdlNkdUXLlnpIDbV
	RYLJL3vxHLDVFm46h3vDTywQfg5GbXGuQpQM5U5XqdByvUpYMBtu/Q8Unq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730043505; x=1730129905; bh=eeunJ/szPPnpYAVs0/PamKPqSPaj
	D/bA54x4jv7FzEs=; b=P5g6xlM8QfTOljONaIKjUha6TtrUS7TNC5cfOsrw9ZAz
	nEaMNQrbSbqnCOTrKyQx1BBwRveyj6nFkfIKUStg4LWmptmrgc6L2jC7K9jtqV3R
	drS8Bh9gwcBuYgUAb7sadkYQSXfFKJcDHAQd3ATP30qOX0mveoJbJHD7+Y+1WpbE
	ZBp8tjBqWQoFvWMskgdqqLzrSAtT/1VBPCuksWS7fz+Y6GvRLntL7okLMyqOuj07
	NUyZ6NNhueHvccHkUIpnsoXUQlFzWGtnRiOSSLJ9FJSLrawOHEKS/XRrX9BSJc+0
	ASOz/EA4LOFVhAHv/KnSbpY5iIvaEppoPz8/ctdJDA==
X-ME-Sender: <xms:cV4eZ0irRG2uGqjTwWxyI100PqJrw9E3uacWNW3RnyPrxKFS6Nkx5A>
    <xme:cV4eZ9C5ddZouOGmeqge5OU8EXGALG_ick_868RICNYBQWXrB2loOHcfZiTBlU_2e
    3iqM7gCpvJu5Gxdhw>
X-ME-Received: <xmr:cV4eZ8FVMbhgqHB87YBrX01rKXddpEv5K4GZrwv3T-OOVs2v-6cJDQnYz7aNaIT42GrQPWU3xykVOhPQ7SKRGCmODRtdBQAgf7zOsvaLdw79eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cV4eZ1RV3HCzTJt_OYTpL-pROvKcKNDKQR_c8xuulAZMOGhtmPNtlA>
    <xmx:cV4eZxyRLcD0WzQce_PA9CDSG49FDHiRuMfvG3ULNBkPuRTsgf5TSw>
    <xmx:cV4eZz6NfFIijtk1qJjQeVcLzIqDQlt8hq5Sxfp1FCbXLBUUT_6EIg>
    <xmx:cV4eZ-xos3FIuQSQvjo5CCwFtXJ1918QmtSaHMnIjr19U9EZy-AQLg>
    <xmx:cV4eZ0oGeKO4wvxrdEAzBPXWOTfwe70qlpWNqLeswHK60Kc4Z3Eh3Wti>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 11:38:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ad77103 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 15:38:18 +0000 (UTC)
Date: Sun, 27 Oct 2024 16:38:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <Zx5eg2SkHMmNhQRh@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
 <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
 <542b306a-523d-424b-bc9f-c63bb7040beb@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542b306a-523d-424b-bc9f-c63bb7040beb@kdbg.org>

On Sun, Oct 27, 2024 at 02:23:28PM +0100, Johannes Sixt wrote:
> Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
> > By default, Windows restricts access to files when those files have been
> > opened by another process. As explained in the preceding commits, these
> > restrictions can be loosened such that reads, writes and/or deletes of
> > files with open handles _are_ allowed.
> > 
> > While we set up those sharing flags in most relevant code paths now, we
> > still don't properly handle POSIX-style atomic renames in case the
> > target path is open. This is failure demonstrated by t0610, where one of
> > our tests spawns concurrent writes in a reftable-enabled repository and
> > expects all of them to succeed. This test fails most of the time because
> > the process that has acquired the "tables.list" lock is unable to rename
> > it into place while other processes are busy reading that file.
> > 
> > Windows 10 has introduced the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag
> > that allows us to fix this usecase [1]. When set, it is possible to
> > rename a file over a preexisting file even when the target file still
> > has handles open. Those handles must have been opened with the
> > `FILE_SHARE_DELETE` flag, which we have ensured in the preceding
> > commits.
> > > Careful readers might have noticed that [1] does not mention the above
> > flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
> > not for use with `SetFileInformationByHandle()` though, which is what we
> > use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
> > not documented on [2] or anywhere else as far as I can tell.
> 
> The Windows 10 SDK defines FILE_RENAME_FLAG_REPLACE_IF_EXISTS and
> FILE_RENAME_FLAG_POSIX_SEMANTICS for SetFileInformationByHandle(). That
> the documentation lacks "_FLAG_" in the names must be an error in the
> documentation.
> 
> I found the mention of FILE_RENAME_POSIX_SEMANTICS quite distracting,
> because it is a flag to be used with CreateFileW() and basically only
> has to do with case-sensitivity, but nothing with POSIX semantics of
> renaming.

I'd still prefer to mention this, because otherwise an astute reader
might notice that I'm using a different flag name than what is
documented in the docs and figure out that I defined the wrong flag
name.

[snip]
> > +		HANDLE old_handle = INVALID_HANDLE_VALUE;
> > +		BOOL success;
> > +
> > +		old_handle = CreateFileW(wpold, DELETE,
> > +					 FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> > +					 NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
> > +		if (old_handle == INVALID_HANDLE_VALUE) {
> > +			errno = err_win_to_posix(GetLastError());
> > +			return -1;
> > +		}
> > +
> > +		rename_info.Flags = FILE_RENAME_FLAG_REPLACE_IF_EXISTS |
> > +				    FILE_RENAME_FLAG_POSIX_SEMANTICS;
> > +		rename_info.FileNameLength = wpnew_len * sizeof(WCHAR);
> 
> Size is in bytes, not in characters, and without the NUL. Good. I read
> one comment on SO, which said that this value is ignored...

Yeah, I noticed at one point that it didn't really make a difference
what I pass here.

> > +		memcpy(rename_info.FileName, wpnew, wpnew_len * sizeof(WCHAR));
> 
> ... which makes it all the more important that this path is
> NUL-terminated. Yet, this does not copy the NUL. We are still good,
> because the buffer is zero-initialized and xutftowcs_path() ensures that
> wpnew_len is at most MAX_PATH-1.

Yup.

[snip]
> The general structure of the patch makes a lot of sense!

Great, thanks for your review! I'll send a revised version of this
series where I adapt the second patch.

Patrick
