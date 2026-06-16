Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3D3793A9
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639606; cv=none; b=VmRzzEdF8tklHlabsve68KC/83OVNBvid2ofwHSda6Muz11MwRCaeve6NG4flngxXfTe73jRrLUPBMBPlYpP9NcQKEUa8m4f4Es3lPvq1uKtnE2Zl5syDeiXd4J8U1jjMd3x17+yOvR5OM0CK9OhIbwBtDWfOWQ90whok407PPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639606; c=relaxed/simple;
	bh=FWdJ2MjyqGsVhzDIQ696J3xqHvSnNqFOMWxIQruBXNs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e7mHTdNAk4PI6JKQ6GkJKUNES4+2B0AnCcUAGOo/21H0Phks5iRH5n/tQODGgVbRWcFgvhlbgyY+HVBTT7qmXCzHPTzFrmfDkHXV3thn+wRf0UztIanISNyFmwZoLl9ehHql60w8TfUXrSOJoG3QjTFOAzPd4V945HGMbefkv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=tYHVrtFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIwzd5zW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="tYHVrtFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIwzd5zW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 537B9EC0171;
	Tue, 16 Jun 2026 15:53:24 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 15:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781639604;
	 x=1781726004; bh=bnwIZfqGb412H8+DISGNEdbbMSY0OuFPm7RCrXDErCU=; b=
	tYHVrtFT0ybLENnNEVd4dofr+dJ9L9bvFb79t/UYsWH+U0QOgSrlvd4phdsaNRhO
	6hnKVGi4lFYSmtZZV35+f46W/98vbxp5YyanrSqvTkVDoBnQKjFlz/I29mBadsNe
	v+B9AqtURErNK0RRzdgGDWfHwXxpr8Oa8PcODx4Uoia12TpkNb7lLJEzR7Ohtfbf
	RiI3hupXGIYWsLD/KqwvHf7l1g2WtpIbi0lLAvHnE+lf4L6YoUqZIETHX24EXi1r
	AfgmWxbW2SMGWMpoXXkMz5GYwcElurytxEpc9cXW1Elcg2jRNFCEMZuXH2dCUQDS
	LaJDpqq4/3ZG/zYptTZd2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781639604; x=1781726004; bh=b
	nwIZfqGb412H8+DISGNEdbbMSY0OuFPm7RCrXDErCU=; b=fIwzd5zWblpmvrrKY
	QOeu8OpC/H5Y7kNrcER1mNafLeK5U6KNSJc17VpiAXPmFT++t6w3/aUAM0hPfiNN
	e+VTgKkwtqAg3Yg2+t7GZnEzrFAAmhRmWcJAm7bZ1Tr+OhmkqwqoviaQtYI84oT4
	lOgW4YoJp+QrKKbm4Zx4yeINzGT4vO0UYupORycaw62vPVuNRAxVZFWs2mPIAVWS
	A5g1s3/Qonj9GC2ySueNuav0i0O3H2nvjKAUCLaBLIx51TUGgyTh8HwHbEJ+wceY
	rM96a5JKvOWkSdfKPQnjpvzVt4DWdK92JRDhisVU9gynuoDxY5cERwtGOYLSEXCt
	qhiqw==
X-ME-Sender: <xms:tKkxaktlkegZM0yalMXhbkXxwYcHgjEHYAiltw6KNH1HEfL_2_RbgZc>
    <xme:tKkxasRWnO1AXiHjv3UPoW56t_UMhggOStGmZKb8XK9Z6t6aPKDegC7-7hWnRQAmU
    eOTI-NFDvGQ3VTVmDyjzqA94L-LkX36SQrmi0L5b7ZyXkH1Pgts>
X-ME-Proxy-Cause: dmFkZTEAekuYa5nXZP0Y3UclCliHp4IvZCWZZ5+PSwUbIZjeMPd3cw7Qai7ixZFEHsSJJW
    XzfCYyam0GHoOO7mAzxWojs5oO7l1svgVC7zUzq4Mth+uBZldmmqx7IvCYXfGTQfjQ71X7
    FKHNLL0Nd35s33AC9qsKcBMRTPraCXP/Mqt8zGvZGTjOf6CyFqrtnikUSA9q8vaJoArmgz
    FEBGHjq/c9YtjHb1VWa7WIb3DHRXvdQ5m7F+HevLUJHn5m6xTYsRG0O3XBiL56zylOWzBS
    Wzc1PDvnqCzA83rR0PEmneh/qhaBRBMJ1U8HMYYuYBuCk/vX2tntjrXmKZWA7Ya9IYiqQl
    TEtknvBuMkzW47cfi4ava4670H5D1af0Ofp8hMLv0N2hIkxtLC/OoH/VLMVB1fXMvX042S
    6hGAgydghjrGLblQ8gxhlzUUvkJyAp7OWOaTmLde6W2V7j2xRkee4lfGZymrwJX3G3PfFH
    Y0lJN/+DFB+5HkMsr+dyfG8ic7YdCzwSsfljQDCjoKMp/D7DFXojeFn7uupwUxAclF6C9m
    NbJ6H/pR1+p7JDalT8rz/skf+0d3ByOdKZWOP4mpWQsebSe+4TjWAoUxGxSgQZnWZ4J7rM
    4daH7o+VFQq3B3CsZit8s0BX4zLmrUVF6b3Vs2ggVq/k+hwSdmM31cxX4ISQ
X-ME-Proxy: <xmx:tKkxaja1-zDsKdinTeThV4XNc2YAJnWVZlRSnc17fztO-vTj0bnyKQ>
    <xmx:tKkxagX1nAklIS7KsYZNuyd0RUKP4TM-sSkgOseU9iVM1dT3nlO7CQ>
    <xmx:tKkxathOWTxRceehdrdmc-H2nb2qGhCvdoA9y5Qeba77YMb1HGbCHQ>
    <xmx:tKkxamWNlIs7KvNgv-Vci60nN2Zls8CG-0zNZrCgZdPLiiyhUvupkg>
    <xmx:tKkxauDvFfKhJ2aedo1qp9hEVVeoya9qmnjQ3-YTHh6D4W5_BfvAPlVB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D1BE3021A93; Tue, 16 Jun 2026 15:53:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ0DiacZ5_2c
Date: Tue, 16 Jun 2026 21:53:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Marius Spix" <marius.spix@web.de>, git@vger.kernel.org
Message-Id: <9ef3ac51-9f98-45bb-9815-6fbc5636e15a@app.fastmail.com>
In-Reply-To: <20260616212553.31ddea83@rockhopper>
References: <20260616212553.31ddea83@rockhopper>
Subject: Re: Assisted-by tag
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026, at 21:25, Marius Spix wrote:
> as the Linux kernel requires the new Assisted-by tag for AI-assisted
> commits, I was researching how git handles such tags. Thereby I
> observed the following behaviour:
>
> git commit --signoff
> * adds an empty line before the Signed-off-by tag
> * ignores the Signed-off-by tag by checking for an empty commit message

That a bare message which is just `Signed-off-by` is considered an
=E2=80=9Cempty=E2=80=9D commit message seems like a historical quirk. It=
 checks
specifically for that tag/trailer.

>
> git commit --trailer "\nAssisted-by: OpenAI"
> * does not add an empty line (the "\n" is not converted to a newline)
> * does not ignore the tag by checking for empty commit message

This is just a regular trailer. I don=E2=80=99t know why you have a `\n`.

    git commit --trailer "Assisted-by: OpenAI"

Any number of these will populate the trailer block.

> Since there will be more and more AI-assisted commits in projects like
> the Linux kernel in the future, this should be taken in account.
>
> When merging or squashing commits, that tag should also be
> automatically applied to the new commit message to make it clear that
> the commit is tainted by AI.

That `Signed-off-by` has dedicated options and logic is historical
baggage at this point.

A 2013 [patch] to add `git commit --fixes` because the Linux Kernel uses
`Fixes` was rejected because the Git project considers tags/trailers
project-specific. Instead git-interpret-trailers(1) was born which
eventually provided the code base for `git commit --trailer` and similar
options.

  [patch]: https://lore.kernel.org/all/20131027013402.GA7146@leaf/

Handling how trailers are added is also deemed project-specific. There
are only the configurations and options that git-interpret-trailers(1)
provides. And handling that commits are rewritten (combined and so on)
in such a way that trailer-taint sticks is beyond any discussion I=E2=80=
=99ve
seen on the subject.
