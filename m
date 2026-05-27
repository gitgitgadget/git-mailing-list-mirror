Received: from fout-c2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472212D1F1
	for <git@vger.kernel.org>; Wed, 27 May 2026 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924151; cv=none; b=KfMQV53Ks2ig0E5yzI1rm7QxjiZhb5C5MfCNoBbuzDksX6XL8KBF/7sfMiVH9RgemjNYznempKEiP96J5PeuCbMV/DBuL8t8o4oYqKRbLKetQ4/kRx+Z9FZf1hNfqA18YT4lPmsHX+IKKcNWMGr6vAAa72R1DIWyghenwS7HNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924151; c=relaxed/simple;
	bh=oeu0Yt15kpmkq1vk+oo71nQqdk1x6oWoItSD9EcywF0=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=GHSqpzSiE8zcIAKy4AeaiAoa+HhrA/2Gkq+UAdH/DaU4aZiU86BQ5WQVSPL3UGcDjbVRfjNFiibzreALlIF+OnKfTsIvap2Dx4kOFIMigPjS08VJEUp6T8FZUBRWhGUxjx5Ti1I/LU6OuKDwSZIi1VYKWjVYYA0ApFiFe6MN5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aW945deb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIDb/IZC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aW945deb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIDb/IZC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DD40C1D000C0;
	Wed, 27 May 2026 19:22:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 19:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779924148; x=
	1780010548; bh=tKdXdcIzDESBRwcquV5hycZqsofH4fWt6rWpZx2fQaI=; b=a
	W945deb+UDWKh1zf0CBYtbHTNcUV3L9AlAY+8qJqxX7kl6FH60zxEsn3R2mRP6Qg
	ykdnvEzK7q+ej1G49RbJucXkLi884J81mPiL68Dis8jLwmLusEMbLUErPyJWnpdh
	6V2YZBcFdXw1lkR1HsbgcDrtihV90TwzCBIUdsHZOorU7DA4z+E30UqrPvXLz62C
	oRpjhAwesDFkNWHBlB5aTldV2UyC1nDC5a59lNSBV9lodZkgiadBRrDkTuE8ANU4
	WTc/XlavrvviHWf+CXPtxK8IVftRP8h16K8+/iIE1A5fLhkvhUBRHumZU08rgKPI
	IG9PoluymJCN2yiaXutHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779924148; x=1780010548; bh=t
	KdXdcIzDESBRwcquV5hycZqsofH4fWt6rWpZx2fQaI=; b=AIDb/IZC/oimHIn7A
	fp+JBdI28IxW6oybYKoBzEI7Qq0g1Huo4FTUvtXdOR/gkWBvXZT4w/l1k3JH+pTP
	ZfWzqcyFNjYitG6roFMzBCpVnNPhUrXGJntyc/lXPkpsCGzzAkZ8l7fkPJj2lWoy
	VtGmd2rVUkraxiroX68CWiROHqrYDynu6Fj31pCPSHC+k1XG6YShMcMSfNrcuDxe
	5hpaDdCJymz8ITQ861/XGbomXGK5ybDtzEt+Ob6V7vx3b8UNlHikRdOa/N1ItM1u
	tP8PH9FL3Kyn+gjvJRoOFMiYajTEW5imnfuHmSrl/aXkt256aFv8+6SPGWZ8jQvH
	V6JiQ==
X-ME-Sender: <xms:tHwXaj-sT-gzkljXU8yIf8dMH7v7dsuldczci9rWloqbBsAw6aPLhg>
    <xme:tHwXamux700ShVbmudxuPeRKgwTLa6__eSVIvKXeXL7cOd6LFlXukPIF-cxXuiDO4
    wibpyE0FiB4caO-_lCeXOiHeW0W6fLNdEnrbup1XKZpC_NfYx7WgQ>
X-ME-Received: <xmr:tHwXamC6Ak-wZT8l0jKDEuYACaVzD8R3UBeQIyJYfjNSxpR5vnnyMTk2y01jGiPrYl52KFrWrWDM3OafTnnngSd2h4uVpR3-7p1usR7faMSx>
X-ME-Proxy-Cause: dmFkZTEe4E1Y4x8uT6eCLLwrEBDS9XNdFoVWNOTSnv2J/kfHA0kiGW/uaR/gHOKBBOpzjk
    uimHYQIj+HWvKMB6eOXeb0hPfZgrQuz5b0Z68KDZVxqu9a7ZjnypOR+zdnSqYTaFVHfaQ5
    6XnJzBz6P/GeFFHCM0ZAU2TC+pcwrFvfJGWKadcC5TrdKTCVZ/Ss9XC4X+GFyg25LxrC7c
    Lcxq1pPdFyxAZechC7QtcFg8AnlsoEjoAMHlxC2Dkj2TRiws13LQw6gIdwZcrYOpEvzW+Q
    sz5f+m3Tzz08z+4rZLIeU8FsDyjY4y9aUkwmvCYVgIuTA9BT7ve0g+ndhb31L4Y5jYNKYP
    AOwXdTDQMqbHYMXLGYTPpGvglIBwUxZNCaygQPrHj2NV5SZk8tZMLGsHdITFl7/dnQgelv
    GGmPdD7Eqvv5IFnE/FnHdD13CCk2hsX4rms4z8NaWCwCdFGliWDl7lkQVs7of35G62w9iu
    7wQTY2d1H70ILWTDBXXDRrqSlHd81FxEHQM9L2womx7605OVIVGu5MSZBdzWVIsNxlqjYo
    eqi8iMXSDl7sBcg5kEt7XQbhXjJl/SDRU8EOwun1ZtrdPMXYys9Cgvad821RtOfSmLLbc5
    UrF3Sxmp6FolA4mqJlAWekZ0t9p6zAIppuK0X/mjw5re1ZwCBNzjFybaL/kg
X-ME-Proxy: <xmx:tHwXauWoOwH9DJWDCCes91qTnqW8XEzjBRt7um5cWq2PYMqHzo2LsQ>
    <xmx:tHwXakDdgRa76pio6CFsMPb3bMgrQQUE2VWSIj-RdCWFd9YSLnhDNg>
    <xmx:tHwXah8CqQcjB1XMC4geCtNCWf5g5T3ion7tW3tQYJxHl7H03NDcZg>
    <xmx:tHwXarHUXHmgvzDSTc-btvLNduUu6NWwNFkdrV25K-gofYslXKLQqg>
    <xmx:tHwXapz_l3vfw2PtAYJ_A5Vkr0q0P2kzUx_qXYRo9OsNyASDZg1yGtmI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 19:22:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Frieder Hannenheim <mail@fhannenheim.net>,  git@vger.kernel.org
Subject: Re: git mv after the fact
References: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
	<CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
	<xmqqy0h5lfa0.fsf@gitster.g>
	<CAPx1GvetxY1T7cuFN_xe51EURr-ED2BqW3E82jj90ko3PSYSyg@mail.gmail.com>
Date: Thu, 28 May 2026 08:22:22 +0900
Message-ID: <877bootp3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chris Torek <chris.torek@gmail.com> writes:

>> Chris Torek <chris.torek@gmail.com> writes:
>>> A flag for "git mv" would be convenient (and slightly moreefficient ...
>>
>
> On Tue, May 26, 2026 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>> May be convenient, but I do not get the "efficient" part.
>
> A normal `git mv` renames the index entry and the file in the working
> tree without running `git add` on the *contents*, so there's no new hash
> computation.  Presumably a `git mv --after foo bar` would do the same: verify
> that there is no existing `bar` in the index, that there is an existing `foo` in
> the index, and that there is no `foo` but there is a `bar` in the working tree,
> and then it would rename (add-and-remove, really, because of sorting)
> the index entry, without scanning the working tree contents.
>
> In other words, we skip reading the 3 terabyte file, or whatever.

Yup, that matches what I wrote.  We do not rehash and we only write
the index just once.

> Anyway, comparing to `git rm --cached`:
>
>> I think the requested "feature" is not all that outrageous.  It
>> would be a similar value as a morning-after correction measure for
>> "oops, I moved the file in the filesystem without telling Git".
>
> I agree, but I also don't see it as valuable enough to bother
> writing a proper implementation.

Yup, I was merely agreeing with your "convenient" comment.  I do not
think it is such a high-priority item for any active developers
among us to drop something they are doing and writing it instead.
