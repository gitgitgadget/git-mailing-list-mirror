Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112384E0B9D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919281; cv=none; b=HUv/LQ8Yy6o3cxWNra7krI1SakL/Ur0zu2cNAm2lxbAFk1FpG+1dXDeKAIraC3vf4HSwbIDTQyW/b2x72xNJHzdgnQvDsPbeGed5IBmYoAzV+Ecspkg6x9D7dwAKw96nnYDTSG67EA95rNEhc5Ay85H7eejmbUN93MNgTkbIwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919281; c=relaxed/simple;
	bh=MmAoI/d8oQbxzPBn2/EoIT4Hqj15iHRsTX4azTnOD0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHuKN4HSzliP6CvzBcd5BwfscA44QEuIAkYWSIGNdykt793f67dMEdKQxULEp6CYcgCWglWtvU+QgQvR8kPdKQsJXlBJFBdkZnHwSpraQQBCkx5mPTlJFLuLoFqxVaaLdoBec639xyjkoTaBK/XdVaPZk6VVvUVhc0sCVhx0Vhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OuZ4nrBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbGsE9HS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OuZ4nrBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbGsE9HS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D0851D00137
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:21:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 15:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791919279; x=1792005679; bh=1zRAulpHrY
	XQKyUiIWmTq8D3oeKvpR+1oG0KoLJV9ao=; b=OuZ4nrByOum/DsLS4uwp6sjeMI
	NrR9Psr8BiXHl1VSN/xc7omGLvaIp+HkCYIEzutMuHwFPGlC+vfG9SsIHI4nGpE/
	Qiy3YyoUiiaRhbGv43XR4Wx0xc82rKVjSH+J7ot4dZN7rv1rsTRH6dI4VpQjDGMf
	/lMm8G7rH7ILrMGVO2WAyeq40vppJGuf0nDvsxVUMGwJICsfyq5pFXIDo+Oqk/v7
	tPWS16wDHSZoAgYmHHMEb+V6rjy+vG9etFtq8NicrKLGutL0X9xPro9wZ7maUzoI
	RBGMmQxveuLdCP727v5Zk0FcblyfKz4otVWZOZg3Gg2Dpj/1ZmjQSb9KktUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791919279; x=1792005679; bh=1zRAulpHrYXQKyUiIWmTq8D3oeKvpR+1oG0
	KoLJV9ao=; b=YbGsE9HSubXjuS9YStQ6l5BAuJURbs7VwZtr02GfEzjSqvkiD7h
	7YUFlFV0Uwje9VOsxJdv3RGCnBTC7cPA14BIXrzVf2wKdQKgNXsWoVHuxY/JU7f4
	rrgumayfStZDwDeOd85XZ9mdrLiuDnYPrrhn8G7dagWmDqqNlQQGw1WGp+SNPlhZ
	M2UkTjMQpt6It+pAX171XdeP6NI03k8y26mbWYiTYqETIpeYylyXV7qZj3d8Cj/T
	gJ5ci+kva6WGpfO6WOCknrdHUZpOfHVSTRyZCjKLtRIHCO+8f2J/69J3UBfVCqzN
	YHzz+4W73KpItWQH+S81Yn83kEom1wmoBpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791919279; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bicNsKryN/XaBrpw0gypCmQbWYcWxDb6CFzLnztQGSVW6CK
	UnJvAcy3tRl784MTkn6Ezx+CGmlGXmuq+BAg4Sou3Sr5caaipd8CWkbCvCd1mbA0
	VPQuhzepcJBJSeYYeOkjMMV0FFEvzRECdoHJR1iDU5QdwaYKirBGv3/chWRAKiH5
	pdXvvW4mWUNsGKlQFIVeTRAWNCdogxMM0AQULXRIYCdpBQkqwSOte/vH61PQOz1W
	+vFWbTZ9ea4Aoy+6Eg8q7dRPt0EzwzO15njEhPlgzGKO6hzTReLRNpaH7H+jaIwR
	K1hcJd+RvymNLsFfCOq5o3TT5vY9LsCkvzdJIlQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oc/OmUKzxYIXGErPYcCLesa9JJd6r9mtpuZDJD0LYaM=:MmAoI/d8oQbxzPBn2/EoIT4Hqj15iHRsTX4azTnOD0k=;
X-ME-Sender: <xms:roTOahDP3lVT35kyvF27xtjm6viWjuow5eQjbI8Z1K_tld34VLec0w>
    <xme:roTOamhK1eOj68cO7YXr6-U4XyKH4Fu2w2XLiU33O0tEp0YvrXcOx-Zpo4JJMMC46
    GXMFDy1f7_dEUykUEj0gR2Qm310EbzwnucOEW-tpqAsxCj6Zwsljgs>
X-ME-Received: <xmr:roTOahksdNgiPDTOu-Z-vi4HbQWVbjz3Dk10pOdERW-rcnbUOr4EiGpt8uc4a-vf5tnbSjk4Yk-mGGvK-9zQoYZaqJh67Uv6ICWW>
X-ME-Proxy-Cause: dmFkZTGR+sV03GZaOc4R6T3hwVt0sfJfFdQDWmZwNHKYScH9GFSZNyy9Fk1QbrT2u3l7Mi
    +/80hJonsjw7T4Cju2d7h8AIXwb6XKVM31wZsY3WuuSvsHYLvQaJL+/VglmeMLkThniKi2
    kbFNE3lAYIEeCo2nEtzweH8bI5sPr+fOSS/wXvYnVZsuVU9zl7ykotU1tdlLGdJTyTHx+H
    TKUMYyBZraAFcr+NxkFNyvMz3adYwmh6GTrZWmm+Yyk5wkioSYV56CyKq1ux5Qw5TTq879
    VyfWI51eYC6MgAIlGb+BA93lBdv9w9N/81SpZp0HYO/IKTbx1JnoKpLrf3hRhhlIX2WsV+
    Fj8cmssIftckqiZMu4jmcxWQzQjJbv0MwTGNG7ekDrEAL+rn2Nf7ncTFZz6Gd64Z6c24Mi
    H4amiirKcu335V8gkclU69AXKiQ/poWqEIZirc8/JeAovsrKtGwDJtKVEbQEu9Nw7H7Pae
    ghRP6Edh6DsHgx3F5zFbNA0jC4U3LU28MMGMjbZV98He9cv3EoyvDLD7sS/ZEqmk8WBmkl
    xasWJgGkVbCbURC0Q3P1fBiWvhA3I7j3n74hMeG6O+ZM9mA4eYUDAP+biIHfU7Z1aNyzLX
    vRIJWwgp4VleCQsEMKIdnABJH6PLvxB9fQH6Mj540lSy7TE2h+8DBmrWG9bQ
X-ME-Proxy: <xmx:roTOaqpKQbf741rNxHeGLMYtG668qQ_qdO4V9911n4IlHjQiFJrCnw>
    <xmx:roTOaiG82p3DV9CPzWNdBaT7O0YCPphrUsWVkZCOGiBbe-Ruksk_Rg>
    <xmx:roTOauwNKhZ_FZ6dAFlYwZ_V4F99cXIQ6z2jqmG1XaoZ_tXPpgOA-w>
    <xmx:roTOavoI5T3UWdphIDkkEPOlAbgA9cBeYN2VSFkvWddyELo2DMrNnA>
    <xmx:r4TOagOh_lB_8wstoVC2IbdXYGm8_w40CuWjILjjg7y-2hTHJkSvCGdC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:21:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/2] history: sign rewritten commits
In-Reply-To: <20261003134058.23494-1-git@5ouma.me> (Souma's message of "Sat, 3
	Oct 2026 22:40:56 +0900")
References: <20260703145037.69832-1-git@5ouma.me>
	<20261003134058.23494-1-git@5ouma.me>
Date: Tue, 13 Oct 2026 12:21:17 -0700
Message-ID: <xmqqld81wgnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Souma <git@5ouma.me> writes:

> Changes since v4:
>
>  - Add Git completion coverage for `--gpg-sign` and `--no-gpg-sign` to the
>    history subcommand option tests

At v3 the topic we already had a "looks good enough", but sorry, but
I somehow missed this topic.  Thanks for writing and reviewing.
Marked as ready for 'next'.
