Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C13911CE
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549574; cv=none; b=bptU79cnTMSirOE4RTnjVvrSRVjPVVpr8YwD5yW2bCacgeUiAzoS0RQg09HmcmFmnKaMOCscqsh/h17sDCEUbRPkOAP8rawco55Un/0VOpDo2+IDTdbsY1AiaiaTmjWTJRfd5s1DZJ5BfguAUIadLwS8423tJFLUzrf82cmQyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549574; c=relaxed/simple;
	bh=oV4n+xlD8snUiF8i138ZcvGc547ZpuUFuHvbXgUJtWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnMnhDVh8o2zl+cLbH0/p7oQ3G6GtLsMkL4Tvs1KoHPpF/qMP1RYVOoO4uFhEgqRb/W/oF6rOF9VSFQcbRr//D74S3DNaOGz9e39wH9a081JIJ76zgrS+B+caXQCnD6j5fDiWxFkiC+G7VmqNB5aQK0jYUQ/QaSWVjmd/HAMSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lChcXCQV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OamooDpT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lChcXCQV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OamooDpT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 77F061D00065;
	Mon, 24 Aug 2026 01:32:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 01:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787549559; x=1787635959; bh=vSYqB6yC2s
	VJR+S3G5OyCDX/0bKo7jsaZSNxHhJVchg=; b=lChcXCQVk2otxB2K3gdWldBrhp
	Og0DH10JLPBuqzp8tbOQOSLD2EKyclkBjxyaKMjLR7Yfm3OSiwYqoFHAHJDJsAY9
	quRd/dveMi1mEVbZHA5rV5+MnwjYqY1Ej5wawB3WgjKiYP9V7VzAqeHF3FYs+Rv2
	VQ4Psd50nvRhI4cBj/X0GExhkyq5EeLeunRmTpgYVDHSU+EqRqwZc6f57QVLpCkg
	k8lSV1WW6PvdHqXhGEGZe74kHC1Wrr4HOLDSrQCgS1q1mBTRVL/uzNhkR+itsMnz
	OzeTNir7HlueMOOHKk6nuDiD2vN7bh+LPIB4yPG1UhW0dRWokmJcBPS3Tfsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787549559; x=1787635959; bh=vSYqB6yC2sVJR+S3G5OyCDX/0bKo7jsaZSN
	xHhJVchg=; b=OamooDpTLK8oWGj6QBm2TKznFzXqR0SWKlY6qKSjLlHAOhVggMW
	D9Waad0O9WZkQJLSABaJRYkUNTpSfU2FmKMVq4v59e85+6RFR68gGwqx3nyd+eci
	VlQA+qcDrjFGRyNxbAUkxQ6F3OsweK9RkDGynavWABKOxjqPtyeqdezJ1fLnU8RK
	AptIJD8IMsI/KR6aSpv+8Bk7/mR5VUNHXtAg80n1U0EIvhZ3i30WiDYjknNrsH/m
	AKIqSoTudamEUK44h0nsAenb4+W0487cA1Sn+McYI7z/+WJplu+cFw9twNiR3qCb
	4Xs/+PL4WkUALUbjMmE134FnFuYw8Z7TX3A==
X-ME-Sender: <xms:dteLarRndqhquG5tL03T_2rl-GijyG5jtP24rsva_gLTYjIPBvmCFA>
    <xme:dteLauQJJ1P7X_DuQYY4IWGGf9Q70NOXcOPNjkADIyuhIBYLpC0yGTua-lTiieoBC
    k5Ddi26V1UGI64nIUwBgoLdJL01syXp9kc1qucOgTB-oAuvkag2bQ>
X-ME-Received: <xmr:dteLag7Lx4V1UCQr1z0QIHZef9Wii3ic7obNeRXAPa363lB0YCuY40FCgbHiBHyhpruSpBEyvm66wej5Hli9p9Gtc9VN3K9EYvQ-hqoj-g>
X-ME-Proxy-Cause: dmFkZTGTSTpbjgvZUqptkr4/+bylzfrdkaQTX1KLLbxC6g4+qa7MV3fMW9YcuzJsTgkVM4
    NX+2ujh0Ayb9FOdDtz1shukb0Ei4idd8zwVmbhs5L8JWlXUqNnhbYW7TJMI/v6DWjPc0NC
    aG3zLDmA3Tv8xyMMBrYpBm8dTr/B3lTbDGazjWYJ3vNP+AgNyVl9o8YHoV1MsaSrYb0QYK
    GsuVwDfPVQntUdlni/6I6GWn7LvkDV2Ny1FxHtvkG0/L+lKbIEjjCWavr/9wrpFcZnk8rN
    cdx+C6dA7QTZ+Q6esKAmk37hw8eraNxstbpnK9+7BIwY4XNy246eaj/kEal3Dqnl8ph2kP
    SDjQ0kS3VKBUK4fm0dg/o/i5QfKdK4kKbSQyy8DpSzG0tsV74cnpeLItHrwmSZgtV1n2Jo
    jxqYS0XusGvdrTq7qtAPLrErUs5tczmURQ2aKZ/hBh4kBMSQQrKdlugFOVHuXHLAROBVFF
    SdcaCIByH5YTVuyUD/Rbvh91wG2WCbhXXhKCJBB4Klor8BLbcO+KzFeXqwNoYZ70Yy6nQf
    Uz6T4mfiRZHPZTPb+jvbPrOpST029fP7rQ2ZW3ZLqq/idebLsu+64J62qkhKof/js2TsoX
    cSzjcOqEwziu6Xzuv57FGS8vxxAA3Of6MsqFWHqHigJ+Yp32PkERxAh2381Q
X-ME-Proxy: <xmx:dteLaq1iZM9OK-A18CvZ80frkj4vu-ZHjk3OvcD1yBhBUhEbKjVMHQ>
    <xmx:dteLarC5GtImRtI52EnkSIT3Xj74QD9EfVRz0sa7jharskbG8-4R0w>
    <xmx:dteLalNx5j3n6_YFejISDtCm5Wptco2nIKgZAD1wNGq4bElDi3ZNDw>
    <xmx:dteLagYtNiBOTLb40RPmGqEQybcQ1-8AQYQ37uuEb1u5zcuypHWuGA>
    <xmx:d9eLaiEjHDubv9EqvEb4oEXqGKPGZbQvKQudXh_6H5HIZWsAet9jo4eQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 01:32:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2bb5f4e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 05:32:36 +0000 (UTC)
Date: Mon, 24 Aug 2026 07:32:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] hook: introduce the report hook for
 git-receive-pack(1)
Message-ID: <aovXcPHCiBPxlLXo@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com>
 <aohXatWhxCAUQTcq@pks.im>
 <CAOLa=ZTkW14coLA4st-m6B6P-9pUr+Yzh7Ph6nb0ohXJSbTk4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTkW14coLA4st-m6B6P-9pUr+Yzh7Ph6nb0ohXJSbTk4A@mail.gmail.com>

On Fri, Aug 21, 2026 at 09:08:12AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Fri, Aug 21, 2026 at 03:34:58PM +0200, Karthik Nayak wrote:
[snip]
> >> +repository, but before the pkt-line encoded status report is sent back
> >> +to the client.
> >> +
> >> +The hook receives the complete pkt-line encoded status report on
> >> +standard input. The report begins with an `unpack` line indicating
> >> +whether the object transfer succeeded (`unpack ok` or
> >> +`unpack <error>`), followed by one `ok <refname>` or
> >> +`ng <refname> <reason>` line per ref that was pushed, and is
> >> +terminated by a flush packet.
> >> +
> >> +The hook's standard output entirely replaces the report that is sent
> >> +to the client. The hook must write a valid pkt-line encoded report in
> >> +the same format it received. The hook's stdout is fully buffered by
> >> +`receive-pack` before any data is sent to the client, so the hook's
> >> +exit status is known before the client receives anything.
> >> +
> >> +There are two distinct ways the hook can affect the push outcome:
> >> +
> >> +* To reject individual ref updates while keeping `receive-pack` alive,
> >> +  rewrite the corresponding `ok <refname>` lines to
> >> +  `ng <refname> <reason>` lines in the output and exit with status 0.
> >
> > It's `ng <refname>[ <reason>]`, right? I think the reason itself is
> > optional. We might also want to clarify whether there should be a
> > trailing newline or not.
> >
> 
> You're right, since 'send-pack' will default to 'failed' if there is no
> reason.
> 
> We do say 'terminated by a flush packed'.

We only send the flush packet once donce with all refs though, right?
I was wondering about each individual reference line: are they supposed
to end with a newline or not?

Patrick
