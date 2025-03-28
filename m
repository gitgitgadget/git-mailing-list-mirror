Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A520E003
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153665; cv=none; b=l0Y0tnfUwXAy4x1OtONxQAWZdlg9ftLyKUzVbpmgdj1tB2i8ntzUL1scxU7WK8E9ZbPAYkK+JxW18ww2XOWrewdjrwEUTz3FygUFLh60v+LwO0+DCmdBdrrvvGh1JztR/f0T29v39Dr+rFQga/ZQNA9W1Kfn+kvN7ZzAtdXNVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153665; c=relaxed/simple;
	bh=zUmQusG541SVzihLeSCM4fFfmRIo1F82sPkNbOu98M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3/ap8Q6dcsBCi48IhDNicOGbEB+x3xVUd5M0mPrWaUdwabmIC6YXtpmdiu7PAIzn81WApZGhOqJlP3nvL6/Y/rL17gPF0vWnR9bK9tr3K0wMBUn4/BUzJuhxrICTDiewO4mTFF8VjpBsk9Yg7WHgoKNz2DtebTw0o7eiKk8sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KyNWTPA5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neejXwjI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KyNWTPA5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neejXwjI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26C6425401F0;
	Fri, 28 Mar 2025 05:21:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 28 Mar 2025 05:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743153659; x=1743240059; bh=8dKVzfGH42
	acSlY2i4Q8pWORhSh9Dybo72dEUQ2atp4=; b=KyNWTPA5K16bpWFcwRv6AtrgIO
	XFPs6Wp1ljGc1LwuyCtOWiTqIIAdhN33YqdwvQRXzMGmRRUokJgYGeDLJ9TOTYKR
	9a1TSu9fgtixySbmYtztKonZwG8q0C/ZA/NzGjwD/jTpephoq8zbeWqY51Z4mpCF
	uJ0DDIrpkPoGmV0izvdn0vto8zw34nIbhvRXYsP7lhecVa7zbu5gJnBuiESYLUKV
	OxdWghadffskSfNBIJoeH7lFGwGdM7IRcRXNoiOjngzZwJhlEvWQm6YW95avRKeR
	IBGwv2MhIalRvKh8dcAChQsvJa1BbTCwkiYblS/6jRCjQCQGr8hjW/fmn3OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743153659; x=1743240059; bh=8dKVzfGH42acSlY2i4Q8pWORhSh9Dybo72d
	EUQ2atp4=; b=neejXwjI1+AxmihIPuQ+8ys5F9AcHhX2vryaBBuK05UCJzKL+d4
	rRwIWiZEHtdvkE2zn3dIMHsQ4cU+fcd4ImCisY7l9OgfHUgMZw41+IjR3AFyAguy
	ACDeW2DkdPrdumLhnwvNjGeIWElwJt5LpwE7uOyRLVxJ4IN1T2rlBq9upLD+lIBy
	fT27MN7mdE53RcXoa0EWx2briVRALqcBrUlZCv266scCXOCZRc7vJ6vAd+kg+Q66
	3m1R6xR+aw8xrzzxXQcmnn+eSzNAA85ETrkEbo0z5bn/TkezSAFVWkjxl/6nqyBE
	ZNFaD7rAU4fYBezsrKDwPIlyvb5kPx0yDPw==
X-ME-Sender: <xms:-2nmZ3LC5NrwffQEojecg5q1649ee8fMlWsdCjgYYBK4FzkfNCRcFg>
    <xme:-2nmZ7JSJx8n8gFCpIHyZm2MFRv1Jgod0IV6335Z_3TakNqKPXtRFu5fSLUdNbRgi
    oS5UEl0Ndti5wWCNg>
X-ME-Received: <xmr:-2nmZ_t5gifuX_9MY0hjRMEcXexTRg5_hmnr1qorQ4-WySGYoaWbD_WXgNaeEzzXtqUl1Q6E8VosKqeO4AqeDkTIkUYbIT36Mo-mSY_9AoPaeeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeehffduffeufeeludelleeivedvffeludeuheeu
    uddtudelgfetgeffffdukeegnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-2nmZwbebG6FZpYYUik7WsK7ZwG3mnjXllqVhRWnArRTRk33QdOxSA>
    <xmx:-2nmZ-awn_Elh85ahVpLfqD4U8SXroIF8XQifbIUe0SPwZq2igYGbQ>
    <xmx:-2nmZ0CS22LxRpGXB12YuaKZaG5jh2Nwf2gA689Xml2Zb6Ie8ZAguA>
    <xmx:-2nmZ8ZWgCKJN3kquctgWMBBLKDin5Mb34ihLEZG6pB5Lilodou_VA>
    <xmx:-2nmZ1W4_wE-SxgKozfcd_wOd4GVjQQ7-nPRq32mwSmG6v0Q3YjcoaKg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 05:20:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 835a5fad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 09:20:57 +0000 (UTC)
Date: Fri, 28 Mar 2025 10:20:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Message-ID: <Z-Zp9Dvi_Iz7CZ-J@pks.im>
References: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
 <20250320-b4-pks-mingw-lockfile-flake-v2-2-a84c90cfc6c2@pks.im>
 <d149a082-cef7-3fe9-f9ce-6a4588cc3d1c@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d149a082-cef7-3fe9-f9ce-6a4588cc3d1c@gmx.de>

On Wed, Mar 26, 2025 at 01:20:12PM +0100, Johannes Schindelin wrote:
> On Thu, 20 Mar 2025, Patrick Steinhardt wrote:
> > In our CI systems we can observe that t0610 fails rather frequently.
> > This testcase races a bunch of git-update-ref(1) processes with one
> > another which are all trying to update a unique reference, where we
> > expect that all processes succeed and end up updating the reftable
> > stack. The error message in this case looks like the following:
> >
> >     fatal: update_ref failed for ref 'refs/heads/branch-88': reftable: transaction prepare: I/O error
> >
> > Instrumenting the code with a couple of calls to `BUG()` in relevant
> > sites where we return `REFTABLE_IO_ERROR` quickly leads one to discover
> > that this error is caused when calling `flock_acquire()`, which is a
> > thin wrapper around our lockfile API. Curiously, the error code we get
> > in such cases is `EACCESS`, indicating that we are not allowed to access
> > the file.
> >
> > The root cause of this is an oddity of `CreateFileW()`, which is what
> > `_wopen()` uses internally. Quoting its documentation [1]:
> >
> >     If you call CreateFile on a file that is pending deletion as a
> >     result of a previous call to DeleteFile, the function fails. The
> >     operating system delays file deletion until all handles to the file
> >     are closed. GetLastError returns ERROR_ACCESS_DENIED.
> >
> > This behaviour is triggered quite often in the above testcase because
> > all the processes race with one another trying to acquire the lock for
> > the "tables.list" file. This is due to how locking works in the reftable
> > library when compacting a stack:
> >
> >     1. Lock the "tables.list" file and reads its contents.
> >
> >     2. Decide which tables to compact.
> >
> >     3. Lock each of the individual tables that we are about to compact.
> >
> >     4. Unlock the "tables.list" file.
> >
> >     5. Compact the individual tables into one large table.
> >
> >     6. Re-lock the "tables.list" file.
> >
> >     7. Write the new list of tables into it.
> >
> >     8. Commit the "tables.list" file.
> >
> > The important step is (4): we don't commit the file directly by renaming
> > it into place, but instead we delete the lockfile so that concurrent
> > processes can continue to append to the reftable stack while we compact
> > the tables. And because we use `DeleteFileW()` to do so, we may now race
> > with another process that wants to acquire that lockfile. So if we are
> > unlucky, we would now see `ERROR_ACCESS_DENIED` instead of the expected
> > `ERROR_FILE_EXISTS`, which the lockfile subsystem isn't prepared to
> > handle and thus it will bail out without retrying to acquire the lock.
> >
> > In theory, the issue is not limited to the reftable library and can be
> > triggered by every other user of the lockfile subsystem, as well. My gut
> > feeling tells me it's rather unlikely to surface elsewhere though.
> >
> > Fix the issue by translating the error to `EEXIST`. This makes the
> > lockfile subsystem handle the error correctly: in case a timeout is set
> > it will now retry acquiring the lockfile until the timeout has expired.
> >
> > With this, t0610 is now always passing on my machine whereas it was
> > previously failing in around 20-30% of all test runs.
> >
> > [1]: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilew
> 
> Couldn't we simply handle `EACCES` the same way as `EEXIST` in step 4?
> 
> This suggestion is different from v1, which would have affected all
> callers of `mingw_open()`.

Yeah, but it basically has the same problem: we cannot tell whether
EACCESS is caused by the race or by insufficient privileges. So the
behaviour would be more self-contained, but it would still not be
correct in the same way as it would be incorrect in `mingw_open()`. We
do want to retry locking the file in case we raced, but when EACCESS is
raised due to insufficient permissions we don't.

> The reason I ask is that `RtlGetLastNtStatus()` is undocumented, and
> should therefore not be used. I know that I will be tasked with removing
> that call should it be introduced into Git's source code, and naturally
> I'd like to avoid that.

Unfortunate, but fair enough. It's quite surprising that it is not
possible to figure out the exact status code without relying on
undocumented functions.

> I know that e.g. PostgreSQL used this undocumented function at least at
> some stage, but SQLite avoided it by introducing a simple poll strategy.
> We could also do that, but if there is already code in the reftable
> library that skips doing things if a `.lock` file exists, then doing the
> same if the `.lock` file cannot be created, too, should be a safe argument
> to make.

I did stumble over the PostgreSQL patch at one point indeed, yeah.

Thanks for the pointer to SQLite. It indeed has the following snippet:

    #define winIoerrCanRetry1(a) (((a)==ERROR_ACCESS_DENIED)        || \
                                  ((a)==ERROR_SHARING_VIOLATION)    || \
                                  ((a)==ERROR_LOCK_VIOLATION)       || \
                                  ((a)==ERROR_DEV_NOT_EXIST)        || \
                                  ((a)==ERROR_NETNAME_DELETED)      || \
                                  ((a)==ERROR_SEM_TIMEOUT)          || \
                                  ((a)==ERROR_NETWORK_UNREACHABLE))

The function gets used via `winRetryIoerr()`, which is used in various
I/O functions to retry the operation, including `winOpen()` to open or
create a file. And it indeed uses a rather simple polling system there
where it sleeps for 25ms up to 10 times.

This certainly is something we could implement in `mingw_open()`: when
we see that `CreateFileW()` has returned any of the above errors we
simply retry the operation. It wouldn't fix the race itself, but it
would hopefully make it less likely to hit. If you would be okay with
such a solution I can implement it.

Also, one thing to note: this problem isn't caused by the reftable
library, it's caused by the lockfile subsystem. So if we don't want to
do this in `mingw_open()`, any self-contained fix should go into the
lockfile system, not into the reftable library, because we may hit the
same symptoms anywhere else where we race around creation/deletion of a
lockfile. We just happen to hit this case in the reftable library
because the test is intentionally stress-testing and racing this code
path.

Patrick
