Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6EE1D47AC
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699421; cv=none; b=MlgkUQNz2Te+Efn99VMHaCXuL7CvivGtUdoAHAut5EA6mifl0sSdzLg+SM3+kSr8irRHh1slpUhWojqtx1Buf3js3WgqMVbRxXYzSbXaBXqFdzkaKGPFj6a0Q3SD+jL0u1pxlewyvpjVtWASmWVt60cmAV4GUP/D6XkoBPhbBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699421; c=relaxed/simple;
	bh=AAbfkZ7C9fCb1eRmNQEyH4ieEdIUw8RBg+f0mJE3/pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gd+vb3W2ZhX8lhhrMEKUkaUYKyxXHe7eM1+wZHN64V1A7gDPjO6Zx1NYJvGldemZaiEjHFuC8V4x0ClCTs2uNzAUabjI0bD5SSwZfE8IBa2k7LaM7abWT4KYmZtMMREOsmSm2lFL9cHpU8eD40H+g7CzkA/fWUtzOtq3eezH9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YuUBsvLe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ic05pGZp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YuUBsvLe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ic05pGZp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15D237A0369;
	Tue, 29 Sep 2026 12:30:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Sep 2026 12:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790699418; x=1790785818; bh=AAbfkZ7C9f
	Cb1eRmNQEyH4ieEdIUw8RBg+f0mJE3/pU=; b=YuUBsvLeG5/StTukAYWggkqanw
	WXNhOzpdf/PVlCgya8rAvXhfhgowvixONpl/Ye1uSW2zi8gwWtihVO3/v92jDqEA
	d97piy+IVUwJ3BASRSkc6LzEA/GnTPSEwsiutuXvCf3Io2th8bJwvGvXpMPbxp88
	W9pIfkT8YoIxye0rq6JZN5fXVwK+DJkyn+pTZGHkceehYzowgocBVdnolff4+O1a
	Lok1t1S36+RjtZMjCzqlWntZhQoVVJnRq0sSf6pse51pbrtQaregqnMB4Y/zQkMu
	Jrpa74iq9emQXuf3TBQMDGhv5QqFeOj2gfiDS7CoXJdsBIW17D53/pLP2MBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790699418; x=1790785818; bh=AAbfkZ7C9fCb1eRmNQEyH4ieEdIUw8RBg+f
	0mJE3/pU=; b=Ic05pGZpPQYt2dCvrDWLjfapP3EaPTMqB+uE5ucIItKvUaxVSph
	+ItRkjiZ49t6MpJZo+oGUOP8GlvnPfSB7fhTCebUVuhyabTrUYxDunGn1epDpZ7l
	xay+XkarZ9m/zFSYfAsNbWpRdYPF+ItlrxZfEqpV6TdBCIwMPBbWJKpkP/MZDZJA
	MRsWGd/znTVOS9KsJEl9mSCpk2+Gdin7NWA9KlL95UpxzrQ/4mqGsKF27G9XfYPZ
	Vbbqimmai3UIaxf6Y9/DPhOiNKJnmcoKPRsd+7XJWuFLJM4l+A7Fw9AXk7vGD1Pq
	MSQVmRVvDPyWycGBdtIReEjg4QxMqzfQi8A==
X-ME-Sender: <xms:mue7almZtbmgR4IBU1PisBIRctyUSnwgWdumKbX1Q9MiEwv2ljZwxw>
    <xme:mue7an0BUyla4Z-S-bktNlQCN9xW1KUT_pyJP-7r5sj0yh2LWEx2gOBg5fsJfQ-jK
    zJTJUXNU6o1dXQ1-cp0UBqGG9lJOoKT0uObxlZj_1CB3xOHmjmZNY8>
X-ME-Received: <xmr:mue7agr-0156JIc1rXOfi7fIsENgye6Cl1ryAMJeWh-hXreo2LZtEeV-fLAOclCe8E13yr_0nCsKw_hKJWg1NCGNmVYet1VBoOdV>
X-ME-Proxy-Cause: dmFkZTGk67Pf8WlA1VcfT0sjuUvsuQUNYUpvSqQW/xwep7aknRFmNa9J1t1TLQdi6940Ql
    nxXXO/E3IpqgYxTfgeIjl+smPzeyp5w297LGbA+Ge3OpoWLOi4iq7N4uUluF3gHCekaJgh
    7j5rB9/sownnQgvSVYvM02E+u9Xl+28k9Duy1SeNXNKvr/hfc3VdREGcUAgHzmwbqEdprh
    +fepXpNMeyTPsbF2EhF2VLpVbePGa4YIBLKnKZEJyFwaiSKCG6WdM+f+zsM3n+ZSbULs+3
    VKY6yLlc+Afa/oNwGC0ITbpg7ttgWBu7Jzsxhp7+qesQ/G8C7TYR9zh9fPEzIIwkBoZ5o5
    IA5DKTiMHOEEZgpJYYfTXEkGKYYuLRlwzJzxY+1IWQW95UNW+89XBiP6YCUjdbMuCGs1G4
    v2Sdtts+9oxA+YBn7ptHBGp1wMJCXfPx4MgJq8mpKM0g5l4CNfsY/hCGxQEFj6WxvkBF4Z
    H7Sx77TKuSo96mj5rH1qEnPd40xisoXfYiBYJJHtr6OhWGDj0ulBLIFnYYD3oR2eYWThsT
    chKJxZrjr2YI77moc0D5E7tNNsSI63w8ajZ8ZaBCyy6RYqtkkV+tjAUm6ECsfFyFCpvHF0
    GD2A2e/Y6wKzULAfWOyY2G0kbUXEnfFKpuuj/4djAoThw96ckv8ntoMUj0yw
X-ME-Proxy: <xmx:mue7akc02IyPxzcV1Qlp5WsI_tIolHiG5-99p3yo5gX0CikgjQioHQ>
    <xmx:mue7avpBu6eOMFVR9G3eRsfKx0sShOgechjFZYVApIQppu1Ql_BiQw>
    <xmx:mue7alEBEJWLCO3WQqv26aObgADZczS0EvpAzUofz0yKdc7msa9d0Q>
    <xmx:mue7avtoltXS5buDDV9KYxkwcY-TuTAHUnV_vOG1PUrOqn-b6WitYw>
    <xmx:mue7artMZ8LpsZ-6zvAjmoEDFWLNre6e-E3LqZrmiBIP6LPEi6VGH5DZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 12:30:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/2] git-contacts: allow inputting patch via stdin
In-Reply-To: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
	(Brigham Campbell's message of "Mon, 28 Sep 2026 23:47:11 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	<20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
Date: Tue, 29 Sep 2026 09:30:17 -0700
Message-ID: <xmqqh5j8hvfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

> Make git-contacts accept patches via stdin. Multiple patches may be
> concatenated together before being passed into git-contacts;
> git-contacts recognizes the mbox `From ` header inserted by
> git-format-patch to separate concatenated patches.
>
> Update git-contacts and its corresponding documentation.
>
> ---
> Changes in v5:
> - Add a patch documenting stdin support
> - Link to v4: https://patch.msgid.link/20260925-git-contacts-stdin-v4-1-9b4e4bcbb91c@brighamcampbell.com

The end result may be the same, but I somehow expected that a new
feature plus the documentation update to describe the new feature to
come in a single patch.

Thanks.
