Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4A3515DA
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688302; cv=none; b=sBsnd4mk6g4X4I9kwXk3debEj2GuZGhlpfsvwKUO0E7TXs1mAPgWP6Xrjgpna3/CYKaj1PDBZ5sBuB4fHdlKxIJ7tIbr2ot/tCo67gxhnUBCoLV4+N8SsyG+Z+u9ouPlJbhPYjis5bXfe7mAqeDRFGtTVwxnC+CNarBsjMlXq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688302; c=relaxed/simple;
	bh=nWUMBorEfUCOvFkkn/rxPjbNxNNfA91Q63+rM0o7NqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hDTPQi9ZLhTl0ROj0qYF/k+coUTQDhqofDLteIsKtl/bEq0ZZ/EHWKrot0sGRYNtLB2tp4k6wr0eg7mhCZwhjE54CtC345DyYXalRW3Gc5fBzGjeQ5d1b1Rzww8twF3kMl4vLkWr8bM7q1J/7U/z0L8cHmBgOM7ycadBqwa8j4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RIRHG+zu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqAlSO6t; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIRHG+zu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqAlSO6t"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 384FA1400089;
	Tue, 25 Aug 2026 16:05:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 16:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787688300;
	 x=1787774700; bh=4FYay0IhftqRoON8+0RRcEn2UTsWUgpb5uvGbZXgbiM=; b=
	RIRHG+zuCYHnLmoRmMxtBBjb11lRAq+5G1Q2pxl2zhGuHTIphXh3q8fgbP7z8cqL
	3c0ZIjcnCtIByMQDWZHZmdD5pY7gtJR9TfxrWTAY52ZUSyxip9DtGK8zpnJLPNgr
	CnWFe+ucfFZ/xPlFyqcj9YJQHYxoOYIvB1ee9v4kHiMslB89Z/5YSZ/63NtMkxZe
	ZFmnkI5XQTn++RIRzqkud3T1ice+1SKW5tye0latq5fPA1NjBqgEM9iovoJQMgSi
	iWCw/aCvq3sKXHZVCuM2h/Z6eLxY9rqxCje7Gh/Di4ZEG1rVpoY3D52wlYM+r/A0
	LD9vxtoVW+fSd7aImeV87w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787688300; x=
	1787774700; bh=4FYay0IhftqRoON8+0RRcEn2UTsWUgpb5uvGbZXgbiM=; b=d
	qAlSO6t+QcwgjL7ECdMIDe9l5vmoefs7HStEmGTDH4H3jJG44ODvduhsGI8uRN9x
	suvExav/Xy9N/kERLwRKQa5gseoPxaXCIWbax3FIwSKZp+tQJtvfGMYVkGrZY1Hj
	w85nJ9pA1WgpSsl4uO8yuuOrh6kmV9BTP8oylnGemzfdsQoeCaAYWLUPZJrJK4+C
	O/LlF3hYtC1fYgEaGvkcvbma51KSAdEHiUgBlSNz6STkYFwE1UndZ2BXhtzPEmLh
	74q0IJB2Oxu3+feHyI8hAwrm/jEKoPxfQkuEkjQCAwqShdMIAbVhEm6GdfkFgHvz
	XTSI/lAuF9cm+mkYEd2aA==
X-ME-Sender: <xms:bPWNaieEgZw0xXnFV1oGT3Ea0UaSHLGV2ns2eN3WdzTK5bb7TLYRGQ>
    <xme:bPWNajpGplczZb8gCQlpxvAOja4pwXAOWAn94sLj2Hv4uSYeXd6_rgP78oRu3t7Lp
    TZCAIo6zNbVKhm1wfVS51XI__LrcMixAJypThQBinGGtet1trFxMc4>
X-ME-Received: <xmr:bPWNag4L2vI8x1iN8nby_UuN9CPFWFpTCXKEST6y1QVHpMMscEHC7rsMVF6_gQ6lLPdhNBX3RgfN3lus6OHhvelzpjKbz8CXlw>
X-ME-Proxy-Cause: dmFkZTGXiu1peq5xwqJIKs9wYa3UK73Xqm3LvOse8UWkLPg7lj8eSvMJAa83e8CT7fgN8z
    LY1fqzXO003w7egFR/IP9I6UwsuiiKYlPnW8QrKdcEcHbNGWPEOUPN5m4Sjs2Y38+9zFQT
    XBI4Q1rSSgeZvyBasAoDpxKzvPzAz+Z/wlr0/mTxSlJiwbsKok1l9aCwuv/x8rxFk3f0+A
    zy/Uh9zIfwVWAjWwSB534Xcdv5PYu022o24Ful1E6W+j0n60pF4JdrD91IfUkUmWonYvKa
    Qqwc76yYykvVVXHRQTPReoO8XUe/dXJyAVBpTDrVK7r+zCgXnhfrfD87P3UdL/MrGKoqZE
    sQtsWpiqhROjuH/mz+yA+1uzKYO33d4AXmKKk+u4t3kHrH6oL6asSDfD9STN9/vTHsr28a
    8GL0PvELFwhtdZ9tOqV7upEdQoG5BuEBqDq/PSv0aEwVqSTzvvq7ECczwMgY1azHNdwSm8
    MjRI0yXaR8c52CbGBHVgSEVlcUt/gq1OGqqF3gmt86UvaS2t+7MhpnCvBbjRbj0W+si7wq
    xqloUsQHQFC6zdJu5c8LUFQPHKyfkQ8XJh61h2kWCJvOUwJVoW8v9MKSEXEN/ybcaYEZs3
    DJzshZHshUqWQ+C0lSsZC3e6V2xldkHpii4XgFrShCRB6eV+Oe/unr+reN5w
X-ME-Proxy: <xmx:bPWNaprMd4rm-P6289BjYjOk_z4YN7lby3jjpV6k5EXSaeL-Nec_uA>
    <xmx:bPWNaij1LSsJuQFrdGJ1MvwYpeOuMZPuy-HDPZQ7CyaKI2sqB2bwxQ>
    <xmx:bPWNajLTRGitslNfh6SXVXPalOVfoCmf7BneNjQRYzZJ7Nl6tB_jig>
    <xmx:bPWNaiDi97Z58oo4y4EbS8UBnqoTJgshK-WwlQHNnd6jXRPdfrn37A>
    <xmx:bPWNavSLUF9Li-NMgoG6g2CfgatIs1zglENp5M7cNrZybSUtdvkNUSsA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:04:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] worktree add: let worktree_basename() return string
 copy
In-Reply-To: <20260825180350.2099-5-l.s.r@web.de> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 25 Aug 2026 20:03:50 +0200")
References: <20260825180350.2099-1-l.s.r@web.de>
	<20260825180350.2099-5-l.s.r@web.de>
Date: Tue, 25 Aug 2026 13:04:58 -0700
Message-ID: <xmqqld9uklud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> worktree_basename() requires callers to do pointer arithmetic to get the
> actual basename.  Simplify them by doing the calculations in the
> function and returning a copy of the basename directly.

OK.

> Remind programmers to free the result by renaming the function to
> worktree_basename_dup().  Two already do; convert the remaining one from

This is a bit surprising, depending on what "do" refers to, as I
read it to mean "Two callers already free what is returned by the
worktree_basename() function", which cannot be the case (or they
would be segfaulting already).  So I must have misunderstood this
sentence.  I count three callers of the function, so two do
something while the other one that needs conversion does something
else.

> resetting a shared strbuf to freeing the allocated string, which
> requires the same number of lines, but no arithmetic.  The added
> allocation is negligible because it's small and there's only one per run
> of "git worktree add".

This talks about the caller in builtin/worktree.c:add_worktree(),
and it is indeed far easier to read with this patch applied, as
there is no need to copy out only the basename part, and we no
longer need to worry about chomping trailing directory separators.

> @@ -766,10 +765,8 @@ static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
>  
>  static char *dwim_branch(const char *path, char **new_branch)
>  {
> -	int n;
>  	int branch_exists;
> -	const char *s = worktree_basename(path, &n);
> -	char *branchname = xmemdupz(s, path + n - s);
> +	char *branchname = worktree_basename_dup(path);
>  	struct strbuf ref = STRBUF_INIT;

Ah, OK, so this is what you mean by "two already do".  Not "two
already free the result", but "two already make a copy before doing
anything else anyway, so why not make worktree_basename_dup() give
them their own copies?".  Makes sense.

> @@ -876,9 +873,7 @@ static int add(int ac, const char **av, const char *prefix,
>  	}
>  
>  	if (opts.orphan && !new_branch) {
> -		int n;
> -		const char *s = worktree_basename(path, &n);
> -		new_branch = new_branch_to_free = xmemdupz(s, path + n - s);
> +		new_branch = new_branch_to_free = worktree_basename_dup(path);

Likewise.


So going back to the confusing part of the log message,

    Remind ... to worktree_basename_dup().  Among the three callers
    of worktree_basename(), two immediately make copies of the
    returned string before using and freeing it, which makes for an
    easy conversion.  Convert the other one from resetting ...

or something like that, perhaps?

Thanks.
