Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8BA25393E
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642077; cv=none; b=nmV8TJYkMbf5KTEihoaY33QCc+1vuHvdq3W21uDuJw+no7eaICIBMSMGHzc46QRqfQCNeeB7dXKDBDIgLRW3nEz2dux7Eq8uBmj9efC1BcYCbcLwjzOrgM2vI8rc8NuEa06+lUEjmrOjGw8SDqmNoUnknz3BfFgkBYzuex6VEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642077; c=relaxed/simple;
	bh=eXAgv941aGKJD9qvcSRSRZh+qO7hMKuKvKYed5LTXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9LLVyEFpM4RjB55AMO1/YGTWuyzrkReTUprgpUZb17C/edJB8odvGkqOB1/NTKiTjqNx5Lt+QaSuPKukLUlRSo0fIzvpcwFfiZLnjwx/GaWXP332/pnIErdwA3WJTknHi6ft+uJG4Gq8HcesHLZ/WyyN4n7TqG6jFaZnIW2jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=QMoI8qL8; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=k4auBPm9; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="QMoI8qL8";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="k4auBPm9"
Date: Wed, 16 Jul 2025 07:01:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752642072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnSDzhN+pvrx9Wm1ulg5tjbZ6YIkICXQpm5LrL1nC7Q=;
	b=QMoI8qL8XXHlVdsB/m0/MZ9YqzwI0GKq7hYojx/ItKtZcVMpvFnFCDnU60CemisD0Zr+kQ
	1yz2YMhC+CagCYBx4Zbh+BWLZoA63KHKf/GLkZmKAZquPhdWZUYzS3+xo2ptpmb3ER3/cC
	AhNcZkMlCtZzYIL4sUtemSVqYe7lDyHArqkItQFALkZRCKNz6pCJyvxYzcas0YMPJWXJF8
	4459/ZgYpgkPA6f8Ecn1IL+bloS3A+W/ak+ufSurw5aCzBVFN0Bbm3APQz/PHVBF5efzyZ
	9qmgwBQRpX7jGVmEDPF1606+rC5SohW06Gq/mF8pvf917FzuwVYOv7FXiehFeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752642072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnSDzhN+pvrx9Wm1ulg5tjbZ6YIkICXQpm5LrL1nC7Q=;
	b=k4auBPm90ySPiMwOZtWlcOSMJbicAL4UA8E4/lQaAQcRjc1EzLOkQRv17WoTdfHPLUI7SW
	ReAJycPDiW8CmuAw==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] bswap.h: Rework ntohl handling
Message-ID: <20250716050111.cw6zt2Vs@breakpoint.cc>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
 <xmqqple1f7ge.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqple1f7ge.fsf@gitster.g>

On 2025-07-15 14:52:01 [-0700], Junio C Hamano wrote:
> Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:
>=20
> > this series continues the rework of the bswap32/64()/ nothl() handling.=
=20
> >
> > I've been looking at recent compiler and they manage to recognize the
> > manual shifting and use an optimize opcode if available. The ntohl
> > version provided by glibc already provides an "optimized" version which
> > makes an optimisation in git almost not needed.
> > One of the motivation behind overwriting/ providing an optimized
> > version was to provide a macro instead of using a function call. One
> > libc that is still providing ntohl as a function call is musl.
> >
> > While ntohl() is provided by the libc, the ntohll() is not. I found it
> > only on Windows provided by winsock.h.
> >
> > I haven't touched the put/get_be*() macros. gcc & clang are both smart
> > enough to swap the content accordingly and perform a single store/ load.
> > Only the msvc seems to strugle here and performs multiple bytes stores/
> > loads and shifts.
> >
> > v2=E2=80=A6v3 https://lore.kernel.org/all/20250611221444.1567638-1-seba=
stian@breakpoint.cc/
> >   - Fixed typos in the patch description
>=20
> Thanks for updating the proposed log messages with typofixes.  I
> understand the patch text has no changes?

The patches iteself remain unchanged, only the patch description of a
few got updated.
There was only one comment regarding using endian(3). At the same time I
got the feeling to first get this through and then we can think how to
continue further. glibc optimizes ntohl already so git might not have
to. I only found musl that has a function call. I didn't look on *BSD.
It just something is needed for ntohll().

> Thanks.

Sebastian
