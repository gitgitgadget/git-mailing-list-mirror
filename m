Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838C49DBAA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097984; cv=none; b=FP9/4mUNMIIfRGuBnIVGGG7nZNx8JSljZvWrPM1dGPekTqGhsNWtuprebuEN2KNMkEWS3MYvoIMFkEdBzE5wc2YH4LmztJQlJkWLFE7buRtRBUDrR9p7GfRQoQXtEUhx4FIvudBgZSxlMEOcFqlXG3xUOo1vdoGX4pYqxuf68Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097984; c=relaxed/simple;
	bh=LGM561DbYVdIVpWC6RX5YfK5AmpBrAzpKWYj1eTI5+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYSD+zUDrgo2HXLviSehLwL4+nRhy4zhf3AcWuRyp7ouYi+sg0hZexmQltPREliH5Dfz+JfZLx1nyqQCctXjinHgCj/O033k6inNbOEGDyXaYYLzYT13GmrcR+fZwBwO2nppU8Oj8P794eOd7hbY9hjX/T0zsjVOVHZa8g3aCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YGdc7AuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PM+AzNxy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YGdc7AuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PM+AzNxy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52B967A00D1
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 16:59:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 16:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792097980;
	 x=1792184380; bh=mas9DYlF+ziyB4zBkh123dMV/09ZKNrcIDSgWVAuxwU=; b=
	YGdc7AuXIhvcZ6D6EQC/EdCMlmXfBd/KQvgLSf8GqBfxMMYlVKX35Ds+Ne4KtpGt
	FZ1YJ1TaJs4HSMReHDEP+l83Ns0tTiXIb4E91UPdd9bxpGS2SFqAoSPMb/UzVCR9
	mUf4NQF+wdm29ezs6H+RJiC7bCqtYKHBiWDXa3IIJmbBjlcDC41YCVuya9xAUYQ7
	uU+spJdvgASLlsKa31I0pSLFhOtKfdXA+uY5EflbX9TOb+6N8vzfyZSUgsanjYhP
	z2tyBqt4iES3fvPlMa4hCmTjhdbCvONqiLqvr7SXlCUezI1nO4+Zsc7YcpRBhM4O
	QE1MbyS6gDEzN/5RFgo0vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792097980; x=
	1792184380; bh=mas9DYlF+ziyB4zBkh123dMV/09ZKNrcIDSgWVAuxwU=; b=P
	M+AzNxy+zVUobfO/1TtKVnEC4ZWJIyoPF+lq/nRPcaNGKiD7Jvfp7L7BPJJpbPc5
	iw51gAIrY68V8ghpmp6U3pXCCWI7ZKt34qJ6DUtwzzdciJTXs62iZqaUTIdVj53J
	nJOCnBgjC0w2vHjKsJLrqHhv1P+W0quZz3g5hhUwro7XbZhraibWC//JGFAmcqgh
	vxadJTADjJmwGEIicNVcTjzpCPP/9AVJHfRv7n9cybiOMc68nAMAxpcTdauM0SP5
	2yZ4P3xJg8YgOYP1SfZE/aKQy/Ahlp++t9lQ9rlid6B0yTJoZz2j6qAdbaVgvmYl
	zP8xQ8R2NTVrO+nEh016w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792097980; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aZiIrQrhnpdd8yqgR1vjmPLHiMkpP2o+Nj8KGLx+4fJSYw2
	NiUBoGhKJWyZDe3xGsrCzdUswFlID8CHKq6YgDgg8Dxheq86IXBI5cuvAaSQx1lA
	kL66XnL1Q2kg2MjK6Br8c7N1Y6Azm0Q9jm1iwBphYhPPV69MGP73gl1HsA7dge3a
	10lQux6tVurAvXf/7TRn2tRpKiBvfh5tpxXQxPrnfi76jAPakuGBiFYJKUZ+RFAC
	9UTCwRJ53aKH6SvdioPyA5IsaHdlmftKMyKh0IT4eOzhsckW2ohlJfmr9I17wM1G
	LE2RQUVebbrcVKUmbVwus04zCcIJkLsAIEF3Oag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Soy62rDitUz8HzOgt4XgBcG9nDq8jh6cmbLlW2x1JYg=:LGM561DbYVdIVpWC6RX5YfK5AmpBrAzpKWYj1eTI5+k=;
X-ME-Sender: <xms:vD7RanV6kariOGj-zzuppyCLCdtDdaB6tWiDM9o48aSo6b2XDrpI0A>
    <xme:vD7Ramco_8gIO_5SclWBLnA2eLKU0fQ5vfjgVGgR-gW1KqYJKEJ4uluSNZpMjayTJ
    _XHuzwoxtyEjom5coa4bQmmqEJ4ZJq32_iHS8bpShnipfmbpk5uOs8>
X-ME-Received: <xmr:vD7RartQ9wYanaoNaFFUAliYBPZctB2IyKnjuuZvovW3bTqxUn7HYCUWRdt99WvUbLrcz2rmnEbUrUv_MAP4-Y6A8SaXm1OjKQrT>
X-ME-Proxy-Cause: dmFkZTGw0Xfs0BWmJwLJCkYRQWfUQ0oVj5xI2qJfnF/RhIIVdaDwdrDelljdFFlWjIA6SI
    cqNH0//7Uk4zGIUpll3BKVai9K3Ieqx0lsJHGCL6Yj2iJvJEpSRzxNKHbxaaBLlp4XQH07
    1YKvvby2DX6VEAEPDVRhRFzbKrfyXr5FbQ3qQ+zHYTB2YeGRRt91bDLxpiTGBSzue/FGm/
    bfOdi6CZpK98UesXC1/ekXSbbRmRPkWddblzlI/9qRpnVtYANLNdKwQcvmYI5bfRzgaQ5a
    hbS99tqOSqUBYHNJbeFf8dt3ksUfd+Xy6+w+/RqPfJJADDCUa2cp/j6ovSeMaAlKw2jZcs
    80o1yaii7lWKsMK88lyfJYOPmqPde50F5+pv0Y40b20eqfpNmHLfyGf69gpb0Ei8MhLWCw
    6XYEotBuwM5FrCHvwXY/tSLc+1frO4456CTrQMjpiAu7hVD0c7KbTH9i6bUpxbP6InY2bR
    9TdpcaHUhUiwNy9ewNijaDI/tETkT/qZMmeqwPAYb6bMCv5gug1zs12iNvSl21rQG8xhVG
    noAldIv5PAeHCtlJNUJzESKSLdSFU4iCAiR0hyHqsWYxQGl/bMd2SkX/AxiNFc/J5hvNeC
    pdr+Vi8H+vUnCkvOrb3cZLjY9JNumPhgykJ/NiB8qxzQAVqitOuZ8rkwwJ7w
X-ME-Proxy: <xmx:vD7Rat-L2kWzeSlC5Y8yxTk7uOpbhaFmrn9Kmf-HGagN4_kod6z9_g>
    <xmx:vD7Rau2kYaC9cILS2KvhwLLoQ12CPqyqXkCJxYLAOJ7lDSQPzGXB4A>
    <xmx:vD7RaqCAOJjfy6-clc0M9Z8cHeJXCuUPCIBuY_cmdnEm1EA-k9nwTw>
    <xmx:vD7RaifMVz1vZMPArNkcieT5d2NcPrchK6CQFjBE8_i53Ohvu6hRxw>
    <xmx:vD7RanlXOmpl8dtcpMefEAippPtCR3GoXqbk8wA0GQIrNTNsm0EHDCnZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:59:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pretty: fix lost indent after newline in %w()
In-Reply-To: <fc0dabfb-3dda-4b12-a1fb-184d1e553623@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 15 Oct 2026 22:42:28 +0200")
References: <20261014172333.2224123-1-andy.koppe@gmail.com>
	<fc0dabfb-3dda-4b12-a1fb-184d1e553623@web.de>
Date: Thu, 15 Oct 2026 13:59:39 -0700
Message-ID: <xmqqwlrillxg.fsf@gitster.g>
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

> On the other hand this hard newline concept is not explained in the
> docs as far as I can see.  That makes it fair game for change in my
> book (within reason), as long as that doc gap is filled.  My 2ct..

Yeah, to me, it sounds more productive use of our time and a good
direction.

Thanks.
