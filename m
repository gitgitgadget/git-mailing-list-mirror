Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C4271443
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784489375; cv=none; b=PeY54v1qdoqj5z1he+6ojbEB/iWY2Anf6zzUMonmhXxcdgD0tgWQXkWuyoXd9UHvIrqKZvUs6QJwKECBx2UVPw2ajHuDZe4VlEAuhl2PBtbruMdZ3EX9SDJubLgWfwxuhCvRQk5fq1Vj0jXm7D/gknMQ4xZQfYCJ8TlMomrjIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784489375; c=relaxed/simple;
	bh=mhVXnsXgPqxwZM6K8vmcRhQ2ocdxlXDvKt8v01NKvYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPqpPHJrd+qMuwqC+9JXWvEVrGM1jxkO21wxW52/JVB8+ibBTpGqxNTQy8VxM01NMMsgJmcIYfSIkifTB6QkbDsj/H3JMoLvchFX/1tZnvp58A3YEyHCY2NovbvPn1gvU7mPQoor6V86wbb+XiMkbv+AQo2sSBhS4fXeJ8oWYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w9bkn4e7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fh2sb8dD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w9bkn4e7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fh2sb8dD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3761114000D0;
	Sun, 19 Jul 2026 15:29:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 19 Jul 2026 15:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784489373; x=1784575773; bh=Sk37sMobtb
	mb/uy0XBoAK0kGEJkyiMn2Is57nIhIYBk=; b=w9bkn4e7umz7tTkNpeiv2ZxfKF
	gyUz9yQpimGJfuvBwIcZbrcSHPQg1D0PN21EUWGO8TfJ2ys6Di51XqXs/j68e3Mg
	h8J1JchJSBqbIBqFzuBOEJdZ+qPF5X49y74C/l7CHKhm4Vd0so3dPjs7w/uNoT/V
	WYgAamHb9y0t62nScMGp4W8hXacedsLZq6yzmVHYLWemjY6nj35goMmUcp1ObSpp
	awghOBqLPQCJe4+FxzBcAfcPBcUYvxSSMq2f5FJVlJnvQ0m/5owBnPpvO85QBnzI
	dJbRt27m1JibwTECQlx54JkVg9hsCI6DLksT0RI95u1dTip5pxKWMS/NoE8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784489373; x=1784575773; bh=Sk37sMobtbmb/uy0XBoAK0kGEJkyiMn2Is5
	7nIhIYBk=; b=fh2sb8dDEliT1Dj+iedn0FhgOF7KLH/mg8pGDDTsU/GopIHySxq
	Oz4bi6Hwtl5kOxjUUWhfhkdnGn0gI0woKl2OdHsm0iUvPs3UZIxFbLE4A5QZL7Lo
	euiEDrM3qsswTtxf5GUDcVmQCvgILsRDtBxkrfxbut+8bPZ2byiE+4YnkBLci/ij
	qE5gV3IKr0Z4OuuIsvzUdo7ffavecWC/eDu5/RCxDOESeAaW2KGa2oaS2IBSSmtd
	zsOXCmTRLy9qRIkKUH1jdJ5/gN595k7NF4DTc+Ew6Gg+qQsFH4Lu5CcJ2RvMJAwy
	2F/y6ICewZZbTTjj8UuaBmfsczrYvLNDGdQ==
X-ME-Sender: <xms:nSVdasq6aZQugkyg6ZSnTB06zghSHfCD9IKEzAqv7El9KXkYQFjT1g>
    <xme:nSVdak4I3Itz_sBp-Wd-tS6jnXqHzjkS-jshJKYcNfRU8BRee_zpixu4MYiN4Y6Px
    rz4j5bZ0NkXs_I7YqtvAtz1Mhv1WCWmW8F1H5yNPxJcdzYF6xG1Xg>
X-ME-Received: <xmr:nSVdajd5UXP5yPAAEFTBnI4JqzIu-Xb8CB2kl4ZC5O7HFI6XVi7nrj8xxWHqOJeaV3uSQnEhPn6VoMxfYpiQ2xVF4cS8LL_VrQ>
X-ME-Proxy-Cause: dmFkZTEGc1+mh+GDSx/QXYateozdxwLfwti+8u3Jx1S+EMtpMFvDQPKMGMiKCu3F0+Uw/9
    SL/mbBpy/M2U6R+2buIjeLyS6umS97VrMMNYqcVutj2KNYIF5+jijfIjHS5W6+B7+uV3lf
    2swVjsDtheKVLB5zy4HXZv08cJD8BTR0fgRuXOGl3ikYRSHq5Vtshwm9iimncVkz9jB06Y
    m/XUN3PYpStxchvJGco3FRD2+gNzOaXoEYxZyfAWdO+2/hadqK5oM11mBZ7MSnJNVpC8ty
    qEb7xai2CKw6Hrhw4kSfav3otncHYoN5OZRAVrguIjFkoCFqnvUbIMQswvHqVIeLy8t2LN
    9y293hhY3/QQrO4GXAe+9ar2SOsOatLYoDb53v63SdzeViPdZg9b1iwm2EOjVOtUFXvIzK
    lWDF+4wqmH3QXJ31HnUpyaTZvUVQ4WFdFcXUs899prfzq6HqNc2q0kaAKaes2HiZXsznDg
    R9giaVRDpXQ7HkX6IJ1CTN4/XrCRayEI/4pxnvh4gaN9A83fttgSKLTvNyCZe4kWal2Y6l
    Vfd35SNfzj6a4AoaLsblYuiW6wZnQ155sT3/Lt6g85LRGkczT4pL3hjiS0aifBckM1A65w
    THj5ovYKXPZ4Ikw0bDXjh6ISspSdz2g+n+CQqN3nssJXRP8KIUZnpGHOD8bw
X-ME-Proxy: <xmx:nSVdap50-0tXif-qVK6Y9TxDghtfoo7UJdzD8CmsjknKWLrNzJacDA>
    <xmx:nSVdaqtvMxJFdjUUv2fxvboouEWBV6IpdHzoyKvAnblKchjMzDXmnw>
    <xmx:nSVdapiNK4TjRfBV42OfRGHKXxoe0yPbUY-TgKhs5-k8DtkJtHr6DA>
    <xmx:nSVdalo1vDOqt1ut2ZJgVSK7WDXoPfAV9i6C2vt30rV7Yf5VETTIkA>
    <xmx:nSVdauk9vZS9v1JxnnMHRkckAFOPGc2EJTbQccEriJyvejqQKK918XWh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 15:29:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  Farid Zakaria
 <farid.m.zakaria@gmail.com>,  Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 0/9] sequencer: do not record dropped commits as
 rewritten
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Wed, 15 Jul 2026 16:21:54 +0100")
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
	<cover.1784128921.git.phillip.wood@dunelm.org.uk>
Date: Sun, 19 Jul 2026 12:29:31 -0700
Message-ID: <xmqqecgyn5gk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks to everyone who commented on v2. I've dropped patch 2 which
> Andrei pointed out was pointless and tried to make the remaining
> commit messages clearer as requested by Oswald.
>
> If a commit gets dropped because its changes are already upstream
> then we should not record it as rewritten. As well as confusing any
> post-rewrite hooks this means we end up copying the notes from the
> dropped commit to the commit that was picked immediately before the
> one that was dropped.
>
> This series is structured as follows:
>
> Patch 1 restores some test coverage that was lost when the default
> rebase backend was changed.
>
> Patches 2 & 3 fix the return value of do_pick_commit() when an external
> command fails (this is in preparation for patch 8).
>
> Patches 4-7 try and simplify the control flow in pick_one_commit()
> in preparation for patch 8.
>
> Patch 8 changes the return type of do_pick_commit() to an enum.
>
> Patch 9 adds a new member to the enum from patch 8 for commits that
> are dropped when they become empty and uses that to stop them from
> being recorded as rewritten.

I see Phillip Cc'ed everybody who participated in the review for the
previous iterations, which is very much appreciated.

It looks like this is now ready to go?  Any further comments?

Thanks.
