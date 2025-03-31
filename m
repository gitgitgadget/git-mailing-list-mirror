Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E17B673
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404260; cv=none; b=W1UjHdyLGSrn4RvVbqrgW2J7AjqNw2KYaqb5HlOinKXXRNhfQW+y4poya5aFFGatPwCAvupYXRhKeFZXkHq0HYmuyyqjBO4JabkHwpc2rdJjwejJDZoRxioMU1dgppdGpY8LPvfICSk/k0ejlFjGP0CMUoWBKw+I5B9tc7BILhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404260; c=relaxed/simple;
	bh=a/3AyXrxNW11hdauKARtC/pgEZXWU61zEt+TQYH1P24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0n8hpH+f+TipBoaqAvGa8E8+/j2b4dfBz6fo/8JfxP7jsPKO7ZZJC7bM/9YiNmegreYYEz1NiDCdXHKky6T0Zzev8nCvyFOZ57SIwJ8CPi5i3mmn8tXtg2vp7ZEdk4LXOCD/nXgGdWJGNEIF3r/qsLSgxAOZE+yPoqa9KHf6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PFDH6yO3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJxbgzUN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PFDH6yO3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJxbgzUN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F57611401CB;
	Mon, 31 Mar 2025 02:57:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 02:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743404258; x=1743490658; bh=17dHfGK/pR
	o3OxSBLDYnmeh4Ns5wOVUGLPBGgZ2zfgs=; b=PFDH6yO347NS/IRGAILsgbrRm/
	UwMTEy7fruLWpxMw/PgpgsM0HVPctbDgIZlLZZCcetAO5+tureiygxg4cIM1OQOZ
	kd2iAIaKCRES5JSR+ir06BkwlOoa4ovWFxXeJMRetoolIxPkqgi5VuyZjaOi1v/9
	LquBwvavt1Xe9yu/fn0vdmPCgBmPkKvK+YebBUWvyBD28ZDS316TUAPR3NI+f4QW
	aWI+jmbhUTZF55wtmh77WqgdNe66aWt4K8DrFUvR8vBsUG144Xz3vhtRZ9eAQ9sv
	3IsxvFxDPeW737DeNmwC7Zi6CQl3AaydKV0Q0h5HI+CQXZQ/4LIcIS0lB+OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743404258; x=1743490658; bh=17dHfGK/pRo3OxSBLDYnmeh4Ns5wOVUGLPB
	GgZ2zfgs=; b=NJxbgzUNPA2he6q2BBuYbjoiTH1Tk+3RNqhjc6nw4wWlbGXj+iS
	uZUY+lMZ0Y4uLIAB0FRJeU6OI6KDmWS5ckAkahy4m4WyVce6Vl3ijh8j+iY91Mcc
	Pz/aM73iB1A3uigtFYlfaH3F+60LulXmi9gyDOcP/+EkVv4uiXmPfTxO6XzKij9J
	0pzFJkfAYEHRdJPG71UUgNZXWJ1m6za9yLuVUMBUVCs9uBm8ae46YR7/TT4oOa57
	Ilt+g5z0p9PCe5MxABH4BOunRKegKNMdYfJOSikLkFLtxU9AaGqL6oT0TKAvwbOQ
	ZaGRZATLJ4kwaUhed5PEG4YceD1/8RhioJA==
X-ME-Sender: <xms:4TzqZ30nuObaO1pcEatMhGDplT2Ig2R8adB30fFavrlIBZnNZqNjcQ>
    <xme:4TzqZ2E6FcVWezplqCkBvC6w_4qOcYPRNExq4BwcwDemA5lckLKK73mwdYfOZ7l48
    ywxMahz7a4gtiS1oA>
X-ME-Received: <xmr:4TzqZ35ZSeOOnVVFZ6QS6NBsDNvtWXl9fcnYf-6sH6CCHtKn8wN-24NL0OhXbkhSZFgUatHw_N7FluWvEGZLZwKjnxZU-KuuXRCb1jK1FmE11FQW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjheith
    eskhgusghgrdhorhhg
X-ME-Proxy: <xmx:4TzqZ826rbUdu116Yha7qID_bEXaXP7Grb1cDLQWRWq75-Kwqd51GA>
    <xmx:4TzqZ6F7DKgCtcqEXqvJEb2nURNmfLPuNwAddWWvHYZ1IMgsCphCdQ>
    <xmx:4TzqZ9_ltduPGqqgbXQObLwXsTLC63oQD51qLzpBUyoJR1XS_sW9Bw>
    <xmx:4TzqZ3nLKrfl9oPEREtB_noM6bi9-qke6KYsj3Cu05ClWQ7q9Jre2w>
    <xmx:4jzqZ2jwUhX1rTeDF4upRAt179kHec1LZ-UOF9On6m7enRoi-LT0akbG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 02:57:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed7a9675 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 06:57:36 +0000 (UTC)
Date: Mon, 31 Mar 2025 08:57:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Message-ID: <Z-o83wSIrYgLCBDQ@pks.im>
References: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
 <20250320-b4-pks-mingw-lockfile-flake-v2-2-a84c90cfc6c2@pks.im>
 <d149a082-cef7-3fe9-f9ce-6a4588cc3d1c@gmx.de>
 <Z-Zp9Dvi_Iz7CZ-J@pks.im>
 <801fac5d-dd98-d157-6ff3-c3e8aa6a68ae@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801fac5d-dd98-d157-6ff3-c3e8aa6a68ae@gmx.de>

On Fri, Mar 28, 2025 at 04:41:05PM +0100, Johannes Schindelin wrote:
> On Fri, 28 Mar 2025, Patrick Steinhardt wrote:
> > On Wed, Mar 26, 2025 at 01:20:12PM +0100, Johannes Schindelin wrote:
> > > I know that e.g. PostgreSQL used this undocumented function at least at
> > > some stage, but SQLite avoided it by introducing a simple poll strategy.
> > > We could also do that, but if there is already code in the reftable
> > > library that skips doing things if a `.lock` file exists, then doing the
> > > same if the `.lock` file cannot be created, too, should be a safe argument
> > > to make.
> >
> > I did stumble over the PostgreSQL patch at one point indeed, yeah.
> >
> > Thanks for the pointer to SQLite. It indeed has the following snippet:
> >
> >     #define winIoerrCanRetry1(a) (((a)==ERROR_ACCESS_DENIED)        || \
> >                                   ((a)==ERROR_SHARING_VIOLATION)    || \
> >                                   ((a)==ERROR_LOCK_VIOLATION)       || \
> >                                   ((a)==ERROR_DEV_NOT_EXIST)        || \
> >                                   ((a)==ERROR_NETNAME_DELETED)      || \
> >                                   ((a)==ERROR_SEM_TIMEOUT)          || \
> >                                   ((a)==ERROR_NETWORK_UNREACHABLE))
> >
> > The function gets used via `winRetryIoerr()`, which is used in various
> > I/O functions to retry the operation, including `winOpen()` to open or
> > create a file. And it indeed uses a rather simple polling system there
> > where it sleeps for 25ms up to 10 times.
> >
> > This certainly is something we could implement in `mingw_open()`: when
> > we see that `CreateFileW()` has returned any of the above errors we
> > simply retry the operation. It wouldn't fix the race itself, but it
> > would hopefully make it less likely to hit. If you would be okay with
> > such a solution I can implement it.
> >
> > Also, one thing to note: this problem isn't caused by the reftable
> > library, it's caused by the lockfile subsystem. So if we don't want to
> > do this in `mingw_open()`, any self-contained fix should go into the
> > lockfile system, not into the reftable library, because we may hit the
> > same symptoms anywhere else where we race around creation/deletion of a
> > lockfile. We just happen to hit this case in the reftable library
> > because the test is intentionally stress-testing and racing this code
> > path.
> 
> As I mentioned, I had hoped that we could address this at another layer.
> 
> But let's move forward with the `RtlGetLastNtStatus()` solution because,
> as you correctly pointed out, it is the only solution so far that lets Git
> determine precisely whether the underlying problem is a pending delete.
> 
> I had only one remaining concern: If `RtlGetLastNtStatus()` has not yet
> been initialized, would we not potentially overwrite the last NTSTATUS
> while initializing it? And the answer I can give to myself is: unlikely.
> The `ntdll` is already loaded, so there won't be an update to the
> `NTSTATUS` there, likewise the `GetProcAddress()` call won't fail and
> hence also not update it.
> 
> So let's go ahead with v2!

Great, thanks a lot for your expertise and guidance!

Patrick
