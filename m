Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0657214A98
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467073; cv=none; b=WRQnH161cuLT2KSnXSOZjAoLmneqLvOq84Nk+mOHnEKPQv1A/A6kVDy74ylf0EPULt7Zv8B5enMMB9rf9UOi25tbyMnJu8C1jFCh2elJQo/51B7bGCh/FD+V25ermxn5DdPP0cKyxj+uFJbwaAXtitntlA66AFBRlYIxda7r/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467073; c=relaxed/simple;
	bh=mPqE2VqcF80QODNLFTBHZmRFPN4mylyfOvzjX7EElOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=hs76/B0GPjOaFfQJH6NMjzhCCYpxOfkwEpJ/M7UC8TO2ahgvHzADjeNPZP+rAulJasWpWiaA3+iAl5ohnGmv4TRA6532DhqVTEDqhM+3jw2iRjbvVzi/arkn4sEhfkZdS01pTdmK1E+JLz2/Ov5GrrlSTjCr9wbdzzcllfNNbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LR6LVJzW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgVTf000; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LR6LVJzW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgVTf000"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECF2A25400CC;
	Thu, 20 Mar 2025 06:37:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 06:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742467070;
	 x=1742553470; bh=HL7RqBSz99o6CZoMVhSQFf0R2uOFtHwiUB4pYHCbII0=; b=
	LR6LVJzWU0pE8nmYZQ/2TUFJZw0XPYQJ1LovZu1+6sI+qnX5sFi3fwmfCYM+rA0b
	bavTjzd6/WGsTMmBFuFJw0mkOkE8rVJU0m1vfYF5WrOfdTozJq8b25R++Agvnjp3
	k173inLvdJ115klANshOjylTjsSz4gzt6+9ptcXt+Q3itHtkGRfXrSAjci59I1M7
	ed7HW2yf+bKEUUiSUfeQ/zlchL433kBivrGj4oG/3yGmuJurGGQZJRfstimmdSBo
	H30eDeRk0PFkpYu5vuAojFpz4RKDaWzZaANnKTKSE+eG6jnZHEvlkh16ptW3iPUK
	8A1kCckGbIfW/razV11diQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742467070; x=
	1742553470; bh=HL7RqBSz99o6CZoMVhSQFf0R2uOFtHwiUB4pYHCbII0=; b=R
	gVTf000gB8NQ47g5JJO1rDWbVwfO0FWAUR9KMjCISGa/4tnS7F7xdUCwTc9f55fU
	FdTxxnoiwN+pAKYE1YWN6i47vPyKAE9aTZI0LIVe6+2XQfg43dKG059pCd3lBQsd
	AIgKZzJlkVsvcGa8ETUZLi1JbkqJwLaH8l+WzW1F6NUhY152ZsmpiT2vh4N1PT9b
	5MHjaCemoF/ZxpWSr7AvVwAQKUReKmyewj9UarfBRdyYsEbkrchuJMs05e8a4tq9
	yx4PBx9ajhVXly7+1F+lnsITkjhgOXfRcKNndmkJO0bT7fAiYArLjmZ4UtvNEfYf
	5HlOYmFb8jd4DRRggSXYQ==
X-ME-Sender: <xms:_u_bZzaWE3cGdtWE5fvtg8GImfCgEsFzh6tLt33U1NUTHu2DO8qTzw>
    <xme:_u_bZyaVCeK8h8aukGkG5GVQniu877K76yWPItDx6CSAOzycBxeMrwBw2ir-JOxxy
    5TLFOqZNO0GnwrdRQ>
X-ME-Received: <xmr:_u_bZ1_9fEQlwlAg4scnL-ao47cLjv3CiqGk7pQCZKVG_pTwYPibdBCW3CTWNwPwMYiPVHhmLB303fTAvK9oYyKc5YF2vJnWHavWdSVonlkuDsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:_u_bZ5qnUq-TS8BgRei2InIlNAuB7kKnmQyac8qarwL7mO17Sx1Gag>
    <xmx:_u_bZ-p8ATMuEgjb14A23SN6uzhW5PmRcfQN0x4_a42AlzOmruuxKg>
    <xmx:_u_bZ_QHe6KWJnSBicZ5MczOk6wmvTu4SKy-dRKs4bWYVIgYRtCA8Q>
    <xmx:_u_bZ2osFRedMffPj0nEhYpqRgHrAkPd5Gqnl8klIz9QXzG1I85zhg>
    <xmx:_u_bZ3kelLbaDq-RQUV3zl9WFs2ZmZp2zBjio2ddADGlUIkQw9iXl_iK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 06:37:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 75c3a7fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 10:37:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Date: Thu, 20 Mar 2025 11:37:45 +0100
Message-Id: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnv22cC/42NTQ6CMBBGr0Jm7Zi2gCgr72FYQDuFCb9pTdWQ3
 t3KCVy+ly/v28GTY/JQZzs4Cux5XRKoUwZ6aJeekE1iUEKVIpc5dgVuo8eZl/6F06pHyxOhndq
 RsLgZqzVdqdIKUmFzZPl91B9N4oH9c3Wf4yzIn/2vGyQK7HRpcqqELeXlnqZnnqGJMX4BY3uNR
 8MAAAA=
X-Change-ID: 20250313-b4-pks-mingw-lockfile-flake-49dfcce8e7c2
In-Reply-To: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

I finally found some time to have a look at why t0610 is failing
regularly in MinGW. As it turns out the root cause is our emulation of
open(3p): when trying to open a file with `_wopen(..., O_CREAT|O_EXCL)`
the call fails in case another process has marked the same file for
deletion via `DeleteFileW()`. This gets triggered by t0610 because we
race around locking the reftable stack and thus causes the failure.

The fix is simple: we get `ERROR_ACCESS_DENIED` in this situation, so
instead of translating that error to `EACCESS` we translate it to
`EEXIST`. This fixes the flake on my machine, but as usual when it comes
to Windows I would very much like to ask those in the know to point out
any obvious mistakes I did.

The other patch is a while-at-it patch that I was wondering about while
debugging the issue. It's not needed and I'm happy to drop it if you
don't think we should include it.

Changes in v2:
  - Make the workaround more specific by also paying attention to the
    NtStatus code. Like this, we only translate the error when we see
    that the error code was `STATUS_DELETE_PENDING`, which should rule
    out that the translation triggers in unintended cases.
  - A new patch for Meson that makes us pull in "compat/msvc.c" instead
    of "compat/mingw.c". This is more of a while-at-it fix that I
    spotted while working on this patch series. It doesn't have any
    ramifications for what I'm doing.
  - Drop the patch that makes us handle O_CLOEXEC. It's not needed, and
    I'd rather focus on changes that actually improve the situation.
  - Link to v1: https://lore.kernel.org/r/20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      meson: fix compat sources when compiling with MSVC
      compat/mingw: fix EACCESS when opening files with `O_CREAT | O_EXCL`

 compat/mingw.c | 20 ++++++++++++++++++++
 meson.build    |  4 +++-
 2 files changed, 23 insertions(+), 1 deletion(-)

Range-diff versus v1:

1:  c2c1f988729 < -:  ----------- compat/mingw: handle O_CLOEXEC in `mingw_open_existing()`
2:  fd698866034 < -:  ----------- compat/mingw: fix EACCESS when opening files with `O_CREAT | O_EXCL`
-:  ----------- > 1:  9a2798b1b63 meson: fix compat sources when compiling with MSVC
-:  ----------- > 2:  ff5bf477747 compat/mingw: fix EACCESS when opening files with `O_CREAT | O_EXCL`

---
base-commit: 4b68faf6b93311254efad80e554780e372deb42f
change-id: 20250313-b4-pks-mingw-lockfile-flake-49dfcce8e7c2

