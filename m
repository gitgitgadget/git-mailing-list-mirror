Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD236F42B
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621294; cv=none; b=BLnsbCDP1BIQt/Zz8A4jxCw3P694Ltj/j0bgLl1KJk0OTUbGAoCLd9O0bpkhFCMO+fmpQbmp2Y0/6kdScf4aMwJZjtVRmrcR5F47HwsefDfr9kl8dA+jMUAFOQ0VZ8jemMhUk/ME+IXRZz7oZo+GVHSkqtASkrYN/GEIN6cB7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621294; c=relaxed/simple;
	bh=gxrYQokHfI40HXjTbapIvwo0kVww2776+WiQPsT52JI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OfLjKNM/TstsXk877w0AoNOpixdEjvbWzC8zqkRLrFiDBBF8tAIovYqX/Cn/l2tmKwl+Ffx2hrcokpQiEQjjaHfYjxoquDl4bPrLam0hLW+og6vNZsPtQ2J4ayo/rp0hGFUp8p7qbAo1RAaVKJNMckum9ksj/zGG1JA1V+HIedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZLplM+a7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZLplM+a7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781621282; x=1782226082;
	i=johannes.schindelin@gmx.de;
	bh=gxrYQokHfI40HXjTbapIvwo0kVww2776+WiQPsT52JI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZLplM+a7YJY+svyAAJs02V/C/W7HKmkgRRQILOQqTXeo1LejjvKn0slnK0hdKkE8
	 WUm639u3rtWZHyo4a6hQxqqMU9L2D9ctH4DXsJuHmZw6hgp/TZCZtXJQtqL78VWS8
	 1XYDctXBUKY5DEUpLVZhOpBY7a35sspzH60opiDRmDvtJVSrvZK3US07Gw9RTAbuA
	 H8PtjFZK1uTPx5OAkS2eAlm9WB+7SenPYV2gx5HTiOkabb1lFtw6QxmIMW1to+R+h
	 TTTkYtp30EHT20gC3ur1uBSit1BAf0wuR/h9mmZ7tCLTqITLNG5+GdpdO6tmdh2AE
	 B92Y90GE25OB9G5oyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1wPK4V32gX-006YZu; Tue, 16
 Jun 2026 16:48:02 +0200
Date: Tue, 16 Jun 2026 16:48:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 2/6] object-file.c: use size_t for header lengths
In-Reply-To: <ai-5XO9gsc_HdMFX@pks.im>
Message-ID: <29ae7ae4-4ae7-2057-3273-d5024a893d2e@gmx.de>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com> <809d83e46fb46baeb5d0dfcd12eb7fc63580eec4.1780593313.git.gitgitgadget@gmail.com> <ai-5XO9gsc_HdMFX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:a5iy7Z+F+L9+8rj5CwS0bi+iibdYbhaGEc5QqFOW7bK7loqndCm
 066zxNHKotMwsPDzp85io8Z/OeLmN64Y6ZIOZKedjtQyoJFpqZoQFbLwJoXnIYwJGhbVGvu
 5FsK/PVivnmW2HVH3JOBmlmGMisr15zwktzVglpMpDq+vCngddX/BTDQ97qU5swZFypLOyJ
 inDLABcMx8QbooJN3jW5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ofzsw194VTI=;B67WNGXsBHB92Yzg6GQPdhWUaVO
 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
 ES4PvzrtO3WSLCPZvC7R25/RmbU=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 15 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 05:15:08PM +0000, Philip Oakley via GitGitGadget=
 wrote:
> > From: Philip Oakley <philipoakley@iee.email>
> >=20
> > Continue walking the code path for the >4GB `hash-object --literally`
> > test. The `hash_object_file_literally()` function internally uses both
> > `hash_object_file()` and `write_object_file_prepare()`. Both function
> > signatures use `unsigned long` rather than `size_t` for the mem buffer
> > sizes. Use `size_t` instead, for LLP64 compatibility.
> >=20
> > While at it, convert those function's object's header buffer length to
> > `size_t` for consistency. The value is already upcast to `uintmax_t` f=
or
> > print format compatibility.
>=20
> One thing I was wondering is whether we should rather migrate to a size
> that is consistent across different platforms. We could e.g. `typedef
> uint64_t objsize_t` and then use that going forward.

No, the point of `size_t` is to represent what the current platform can
handle in-memory. That cannot (and should not) be consolidated.

> I guess the question though is whether that'd buy us anything. In other
> words, are there any platforms that we care about where `size_t` is only
> 32 bit wide? And would such platforms even be able to handle such large
> objects?

There are ways to handle objects larger than 4GB on 32-bit platforms, via
streaming. In those cases, what you need is `off_t`, not `size_t`.

Obviously, there is a large class of problems with such setups. For
example, you can forget about efficiently reconstructing a large Git
object from a delta chain. If you cannot do that in-memory, trying to work
around that limitation merely opens up the user for a world of pain.

Ciao,
Johannes
