Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FF4E8E06
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611155; cv=none; b=XXMqfqzecn/arymmcbTixeoOnvVLDPlRfbZR5kxwDmjyQBLnlky2o0M2mtwThkg7XvGn9gkqyd5FeQ4yat2im2Yi+746R2HBAGbTT0j8phckXqkhi8RDUgT96ec2lVDqrVmq6BwcMdfFxODU1k/iEXEAUVIrTL4ameTQh9GVK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611155; c=relaxed/simple;
	bh=eZCAcciExR2uiA2BN0TqmGeDUI9+ZMXuROiCMTFsz/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsTZUZOqYggk99pU+PZ8aqkWobl1oGOPhKzddgju6O/HjXGV2+3/BMZ9561ZWxiI1dhnBDYb1LufCePopCEWXa5SomMWbcxmPBqbG04RCxHXyGScnUNfY0zS7unv04z6f6iFP48QOiZ74+NGG8o5wMzXWKFeUvAyZgkWOwEtlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I7oLHhTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uvajPlo1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7oLHhTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uvajPlo1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C680EC00CC;
	Mon, 28 Sep 2026 11:59:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 11:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790611153; x=1790697553; bh=Ta23jW6iqn
	IqbgHvqFjDr10yVQYhKh61SLS6FsqkMgM=; b=I7oLHhTnY//O1nagC2f4D32Z/V
	0vwky2zXbtPN1OXTZHbCBxZBpu8nizHW7G2bgsUFNAa4/KurwiN0wlXh7ui74YbO
	jtiiWhaxTzk1FDLcqXub/vri5OAN1E23/NOpQAqWDAACllcBV6W0ojfld94NfULn
	xN363TTn2zyhZx/cWTvHrUFVzSHThcZuNVzsLKm8LvjSzFQjMKHVNbGFAJ5MzHhi
	rlA1LvM7nVfx3BLMwSjjQs1EV0l2ptRP5R9TFJnYrUbkHcHTupdXQOOu81dv0M8+
	yWK00HoZsCvWjKF4IFkN1IL2O+UPAhAtQrU5foceAdSobhIWFDyh+oqR0Wcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790611153; x=1790697553; bh=Ta23jW6iqnIqbgHvqFjDr10yVQYhKh61SLS
	6FsqkMgM=; b=uvajPlo1nqiIY4vPLMzTv7zOKecMxc+DnDgbnWhWf9TWZXlAMZf
	MvT1lfaYQ0s0LwP3tgrwypk2dS92qMAYANaMHqMv/FSlKawRUEK4SkA9QFQ8kIob
	NJUnVqiqb3aq8xGHVNFPqYJ2TS/4stYHx3p++WlIyYa6osLunr3c9sy7uxx85CO9
	1HvKu92y5al8yc8yryntnK6jXWgX5cHnkd/sYBWaOMLkZPZGVAPfrnSDAxQyaAZS
	YiQoXZuKrwAnhuxCgauulxxbdZK+1b6BvfpGi7lLK43KRqQvqLbnS9vjp1U7unZl
	6Afyrujv++YzxIlhvdhFMEnLIkcBGJEtTtQ==
X-ME-Sender: <xms:0Y66ajCals7wVkNoZQYXV99m4YhRWsGboRffTtcBCIKsHn9nMTq_lw>
    <xme:0Y66agatEyTil9SN8i1_eHQhxVpGsabYPB4-o32jvXv5AjXsdWWEUsEi-KMsL9RWp
    3Ue1l8mm-3y9oeVt8xmJ3VWj8NO7Fu95H0f8PMD8Yz7TKGZCNgMtw>
X-ME-Received: <xmr:0Y66am6ibmIoyaNy1DK2uuXC4uq1I4C020A7iYAQuFAjjYIXFsQbPq7PZshdGy_wFHXyY1igPCvdYV93-cW3F0i3tGRkbGt0W0le>
X-ME-Proxy-Cause: dmFkZTF6RHZE7XP+rEe9DPwvka957alTKhpoNVaL4Vv9dnIvcYxpO5r7oeOZwn56rLgT+z
    Y55kkShYAh4eEMDkgOmTjSK2lfpZtLk7jccJKVcXeUYrjrzfvwIlWTSlCyY1EHmYMwCNlG
    evZmIOfm8zq6hJYsLjMZIpSH3B1O2qafpXaY440sTPkKJKpyW+QHff5T4MfvIdFaP8H5wo
    qLMUnLFwZ9zegwN/J2H6b2H6kDBaKyGrLXTGTHYVj79ZCUz5USnu5xxtyVT1tuWWflmeNe
    wKOaoPM1erSg5F6bnuAFgeSVtZj65aMLPYEwg2I5y+Bp1rTyCnF4zGdTF/W1v4O8oLCWip
    2fKpa6FhRvhezpEGpw9J+eXV2oYOq63WngjJcfYH8aO/ufXiddvKpR0CUJB3ejRrCdtUWb
    NYY5DhyL7q4U89V4S7EAofddHZ+CHXBdnDN87vZLhgCnbu/vqCB3um+SKUY/Key2jqX6w1
    Hu6TAKUGQj2A5359X4ax+NKaws/hYp1OAL7O/joSrBQZ4lORpX+kkgTmhaspWe29XZPThZ
    c3940lYDXDQgSqcfkBW/LPnnBl0MdwDDaAdWCjfXVW8Un95Pvje/L67IepRWzJoeGJCTwM
    ZEhsYoXky5UMFfV6Y66f/DKRTN8pRucIhuvZmDAOqgdTPB1MYVU/Z7YhmetQ
X-ME-Proxy: <xmx:0Y66ahYnE_aW-wnXT7WYYA5sXRmL4K6odHiKYoZM976zNa_fzXDIWw>
    <xmx:0Y66alglo0x6PAzxT96fVhSD8ZT6lhjm2XeaRTLkYcGW4qCQHT03ew>
    <xmx:0Y66ai9QIPZt3IaBh7-8oUNjYWMUQfx7sa1ZRYEMtOBNQrjITjtrtg>
    <xmx:0Y66agqmWdfRHhkKZkEKNQtcyXczt7n9rRtfYp-rQAE1q6dURxMCDg>
    <xmx:0Y66asoAK9nQ1Gkuccc-nwwWT9kaZ_wWrq-kVC0HMkd4O5cWSw918sR9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:59:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] setup: enforce repo passed to
 `create_repository()` has no state
In-Reply-To: <arpiK4chGRDnHXrW@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 14:48:43 +0200")
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
	<20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
	<b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
	<886d145f-ac38-4079-8a96-f09904fc3b10@gmail.com>
	<arpiK4chGRDnHXrW@pks.im>
Date: Mon, 28 Sep 2026 08:59:11 -0700
Message-ID: <xmqqtsn9mkog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Oops. I meant s/free(3p)/free(3)/
>
> Ah. 3p is correct though and refers to the POSIX man pages.

If used in a context where you really care about posix specified
behaviour and are interferred by differences among generic C
library's free() implementations, free(3p) may be the right way to
spell it out concisely.

Everywhere else, like in this patch where you do not care about the
distinction, the extra 'p' is merely a noise, I would have to say.

If you are writing a wrapper that _depends_ on your platform free()
being strictly posix compliant, then you might write something like

        #ifdef WE_HAVE_POSIX_FREE
        #define safe_free(x) free(x)
        #else
        static void safe_free(void *x)
        {
                ...
        }
        #endif

and your commit log message may say "We use free(3p) where
available, but otherwise emulate it via platform free() with some
safety knob".

