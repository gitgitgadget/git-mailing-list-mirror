Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304E50C2B3
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540502; cv=none; b=HOAYv3I2bYVzneBjCHYAwyr2RlBHoux2I9zlib6j1W7HLLw/Hq84/X4hXKr645j9yLZqd14d0YI1a4EBdD3o7sIzO5NsW8U7BX8yS1IHvnKacx1gUa9CK/Re0QANxGg4+g0K4ECvtWG51F2L+wYCG6JpbSodRp+ClJUfwSEJQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540502; c=relaxed/simple;
	bh=ySE6tx3xR2k7ypvAI4HtX691h9PyiFAbcYD0QKKa7Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jKmiRN524nJUYIo7t4VvsiPhJ3Q0E+VTEJ/pABQk986T33p3zd0W6p+gYyNYpIiAeTNKRcDdsa4x+2tu6aVqaqXhI7OdxuTZ96MZCnuzlcMfvHU5KeRAUOH12xp0eNTLlnO+7y8wHv86G/k4blXDqBc1BQKGB9IroyQSKF+VnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pEfFRCGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MshnKFk2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pEfFRCGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MshnKFk2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 42AD0EC0185;
	Fri,  4 Sep 2026 12:48:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 12:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788540500; x=1788626900; bh=oGlsTbdnaj
	Ry4kPg+lv+R3VNHOL1IFdAoVOyQeHmS/0=; b=pEfFRCGNJ51V1ekF/uIUWYJdVG
	2JO9vYbxnQ4L42LaHXoL7YOfSFGRUsytSJYjHE4nLLfO2rgag7PKLMLzo4KzbxEp
	lohe6JjQAG6f422TDufhpkR11LwiQRqunWrU8CE/5Rw6MMvQcWHooPk/Li/BnT56
	76uxhxhzYmp5Rvx3/xwTkvGr/QyoBheidanNdkBiMv4WGT8VxSfwFlMc48Bsv1tG
	TAV72FGxir6hYdWWrd1gVVchRAPjoIIoKol0F6Q/hE24z/r64o+R8VN5F5yhPhdI
	R0q4qDNXqsFNpIG/MwQ8n+xiHpNBCNb6AICqXfsxry1DbG2L93QTSJt7T2ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788540500; x=1788626900; bh=oGlsTbdnajRy4kPg+lv+R3VNHOL1IFdAoVO
	yQeHmS/0=; b=MshnKFk2Bqq2Y2J66wPmpcIgY9O9uyJeK4tnoCk/exRIWTohplA
	ivriSDShuj8deyoV8BFlkis5MiSTDjt3sBtLk2SYQDxbJCYXKDe67XvJ6uzq9g0o
	Pe85mKsQft1eu9nuFCAeaB6VwFjVaoYV1JBWoDtkMUPcsC6yxCe5Ff/A3O/FxK8L
	zPu02OO9Rctw+MLl38kUVBV+v4nicQI3eXJN4bPozTxsduz/6/G5X/aeOq4AHoY8
	nAzePMVFihRZWMPm8cj1DIFiAQ/xDm5oUJwyCe8kYbz0NmDzl6GW3ZWLwj8VOTp8
	QfXHiAJnnotMGJQcPeXtxrrw+PvWsToqEdg==
X-ME-Sender: <xms:VPaaageFkxsbnwo2Dft-pI4L-pqyvVdvKpC0w0HVTGUy4eWlHd5lIQ>
    <xme:VPaaaprlma3WIoUV8UXQ74jGVE7AzM7voPvWP3r6uyFOwuxAhHxyqdK-ryE_gpMc5
    CpXFsX5IYqk70x7jujFvmsOceqUp86DJhaacstsYNfkgUe3lfoqdIA>
X-ME-Received: <xmr:VPaaau4mRZnrBuYiPNA6_-WXEHNI7yc81w7J7-o-QFIlCf1g404E_dJCfnKiji45tqiMPNMjbe5gc1jQAhMmu36iAkjWTIjDQg>
X-ME-Proxy-Cause: dmFkZTGlWWMYOUoYp/77e6ZrXrjHfrGwbuctd83ZNg7jn6A6AYt3liN0bA6x4NM55tFvhe
    rdGh7p4g3HUE5m+SiES7B3FONn9dg2hFzEMap//wCuBt0BrLhRh4OdDH9RymKyYNf8Yaan
    R8tMb7PZ9U/pMyxW7qu9biKL5/7bnG32wDbiHxVuhU5v92aCGPESPTg3xOfspJWapLoIOo
    tkPcNO+ejzxLnmUF1w+dAZtdZCXkoA1u7XYMlM2CYmgaJwJt2nB0BfUYdhL0/cEHb0in+D
    Ntf375yh1JmLa+qPTCC9DhqS+erIn7RXt/9Xi6w09ejjW3ul3XQK3+mjChOCndD215ieLW
    U/GpMbVgPItClLFHBDf0r9CDvTWWvJLXfWv2pepo/cK0mm5fuuxGHLdfj2w2h01ur8e7/Y
    nB+M8bwT36/8oELB1jOxkQrRGtq2RBnHOHS+scuJlovuPxKMJgCKwsK3uzBVgtiUS++QHo
    S96IrdbMdyOcT1rB/YdSjDyYMSbQoLD2bDxWC1aWunCjCkbd9tnX7ZyCLU2Bd5KzmOCxq7
    odE3kRcYKPk299yr7ZoAySyhxyDT9xXSwH1k8M4KyC+o3PmuRXUULaLtAMilDMvhE8BqKR
    Loz/CxC6Pl7tXcVwbPMwcRVceYfOLyFIXPY0VOkxkOOet/ALeJZOukCe1YBw
X-ME-Proxy: <xmx:VPaaavrqnZPtglNfaX1sIIA61adTfm4EU8LmdQHY7fy8r3MmNntlVg>
    <xmx:VPaaaggkM5CeUUnImOIo5Pigrq41dENx_dE5TsQXs2Ec7wfjkBlqNQ>
    <xmx:VPaaapIIF4pal9xp8jf6FK_Jn44lCuRib-hmND_EorCqLoewrhliFg>
    <xmx:VPaaagDc7G1z-8OxVdK5TLWJ-OFo8tLD08WlT_9z9R3oRdEK2ZnQTw>
    <xmx:VPaaalrUKnOQ0qk_vpHk2HtDKs_a7l06SdBA3pGj6H9P_3mWZezw0bj5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 12:48:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref
 has no reflog
In-Reply-To: <20260903200015.36849-1-f@lex.la> (Aleksei Sviridkin's message of
	"Thu, 3 Sep 2026 23:00:15 +0300")
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
	<20260903200015.36849-1-f@lex.la>
Date: Fri, 04 Sep 2026 09:48:18 -0700
Message-ID: <xmqqpkyt3qul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> your sign-off must be the last line in the trailers.
>
> I took Assisted-by from the kernel, which asks for it. I could not find
> anything either way in git's guidelines, so I followed the kernel. I will
> put the sign-off last in v2, and drop Assisted-by if you would rather not
> have it.

We are not the kernel ;-)

Quite honestly, I would rather not have patches filled with AI slop
that is often walls of text filled with "eh, that may not be wrong
per-se, but is it relevant?" descriptions and we can never tell what
was used as the original material to copy from.  I prefer patches
with human-readable explanations and known origin.

Thanks.
