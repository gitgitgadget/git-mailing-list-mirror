Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC341D106
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809534; cv=none; b=PwdVFmu9HN2fez+5MEq61XFUTXLKo/qUSafxzkk/63dysdd/AnC7U9e47Mrns49d62inrwcTd9yhM+6YB1sgtAL/AAQ0EGZGrYgKlOAy0KiXKqqAc02UoV9Uj8Xnb3RLCNpSG2D9NTuGGbQshVx5Eq9EIUoapGF8cyWccC6qZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809534; c=relaxed/simple;
	bh=nvU36WRlCZZgpZS9vUW798RGjNcCE7/CVA3BLVt43Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFpcPt4gZzC47F0kkF3aN9wLPc0K5YEGU8z+/+qk6OSdG8rpunTBZlZfQEjBjMAqBUbws+nLysrX9FqIHCKaMdJpGbGpMpPbMqrxJlMpx6McPLYRywWPre6WrFJO8qoUXA3rdmXkxM+4KQjCL7Wjj5+dWyMQGKXv7QOS9dN7xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XVaHeCqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sl+LRxKm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XVaHeCqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sl+LRxKm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF63814000D4;
	Sat, 15 Aug 2026 11:58:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 15 Aug 2026 11:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786809531; x=1786895931; bh=oP7hGSO8pE
	iBt15mfgmqVXnb1YiIkagHDpalBMj4idE=; b=XVaHeCqIsekOFpFMzSiWsZ1Puf
	28VQ6JhZZypCv62Q+PGwF44FeGlhOzqsAIWsjEVSa+aQgyNnh02p3PBUgG7Epg00
	XleiGTkw9Ei+wn+Bv5ayFzN+oQcLrUw5oO3A7gGZbeV54RS8PrmDp7A/qFy8E8jx
	BeIJ+vP5eVSHS27F76CHKNcScajR4kcGGpXR3VHHaJ5QBIgaClc7eyB3Ny32KKm9
	mQQeJz/+ATGSZPrs2DN6bxwH+fTnNeU4gC0DSsmGALg7a8NE7lY7htaQ8NezKfo1
	ZNqhO3QvnVnP+zc37bKgFb7PfRECot3rzVQ2r4jCebDiAZn7hQY9wHdzK+8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786809531; x=1786895931; bh=oP7hGSO8pEiBt15mfgmqVXnb1YiIkagHDpa
	lBMj4idE=; b=Sl+LRxKmv/8ygZRU3y5ZW4qzwRz5eLfgmPFgmbBpd0hqVQw24g9
	eXrlOuQP1aPpH9HkFquou0WMOWLh8BikYF2ljaEIknQGcmHSEUYkz7RsjlNTOg+g
	W0KMlbFhXcD5a3oZNxh+VGmH7fUDqQfgZx8x8TWmr3AcjHaixi8eHJeIRikGQ7pV
	/+dD3l2ytolym6CkkNQFarnK2/h4GcK2OkUzrN8P2//6RHJCwlvrmUCJGox84iyE
	5VuaGygJOnWcLQYT+9tsBNvh72QnDVKbNYtdTerAIKrEd46uViuBR9T0z+dwSXx7
	ap8OJe0KSfwlkW0mtgVYTCLwAADL3lG/L6g==
X-ME-Sender: <xms:u4yAagdonEUWYC5IfBIBHuu8JgXKuA9qQBJlWK10XbPXnqObXsolHQ>
    <xme:u4yAal7W8xjExHRKY48kobZFhRThuujcE89FArQbhVuKcCOVjVCDdXvKpHvpQwtQs
    rQfNylooWfxvWXZ3PO8PmaH_yQRhwdect7KvWuWEqiVGr3WVB66fJ4>
X-ME-Received: <xmr:u4yAarUU1h1YofgYFdcoVUJ-LSnUbeYXFKCjHauoAwDYrtsGCFqrUZ28SCmOMMaCk45U2tgadYQiNx9XjWRg6EfTcX1pxarK9g>
X-ME-Proxy-Cause: dmFkZTFEGXYfSRqMjYD/gGP5zzGOQyj8spu2Vbt1dnD7Waz0sAENFjvykHncy4D0aOLcOQ
    /jxj4z1U2wjPMZZJrctCQYLzSPEzSt24PAAEMyDhhiUk6ZbSmnAKk50OFxDkQCnnWWFcgF
    9viWv98oG36Lg5Baj4nZO2wvzBzzUmCmhFYPkgk3CPW8Elz6ak9AZQKWS99u+rUkmB1ycv
    e616miOE7yFOnbYi2Q3fLvYdnKE8hmZypIxPwNqqABZCti1bjUqbwCvJMSxUttmMxeXIhJ
    zNBWRatA3PBhtseDtA+9VTnzTTFzCtVLBeJP/Zhz9dWKZoGBQKKtQ2gs1KdNSmEatAsgtO
    um18uQzI6hehLaH8328J6DEjVWTkzGgo9PMjtA0wNAuq0AnqGwzSr2IUfTRzm1f2Mpat+G
    XZSzTgBXnh/DZmwYS77eJshFld4Taw67VGzIHO9AuCklyzT9bzp5/L6upoZUqI6be8rn15
    0oZoG0LMwe1/7WsuaODRnSLllGtjosXFDTThdZhTx10x9+oo1uA2OOYuYQxQ9E0Cs4IKoo
    p4ByuRWB7cU8geTciVReN9WXsv17D5JoOX+l/sBQewrOlpa+0uySs3v4j76U1YMod9G0hi
    OXXMGHETE4e/HJA7DrAirEcthscjvVWyFTqo2zsTNfe71VuxkIuEcWBGwaVg
X-ME-Proxy: <xmx:u4yAas7eivtsCQMqY4hVPb28bPsKl685z4OAssuegHolohf535ytGg>
    <xmx:u4yAaurAq06woS6e8NBJTgr0Rm62NrsIMo9P3X30FqTBavnGmXRewg>
    <xmx:u4yAanl-WyEvqfSozUU5af-TbD1hxdwYVkUnUTMmT8x9B4KLupAcVw>
    <xmx:u4yAaiMGKvsxxZtNkZLg7njWUyZ4Pjlxlm1doWRakgy_gF6AVgnw_w>
    <xmx:u4yAatKUU-8F3mZklx48ZrIRAskW4TmwEeuvEWGujzkqgYPUd12MKTAa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Aug 2026 11:58:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v6] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <20260815064747.2196896-1-cat@malon.dev> (Tian Yuchen's message
	of "Sat, 15 Aug 2026 14:47:46 +0800")
References: <20260814072419.1666358-1-cat@malon.dev>
	<20260815064747.2196896-1-cat@malon.dev>
Date: Sat, 15 Aug 2026 08:58:49 -0700
Message-ID: <xmqqmrun8jeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.
>
> builtin/fetch-pack.c, builtin/fsck.c, and builtin/rev-list.c are
> entered via commands marked RUN_SETUP in git.c:commands[]. Their
> 'repo' parameter is only NULL when '-h' is given outside of a
> repository, in which case either show_usage_if_asked() or
> parse_options()'s own '-h' handling exits the process before
> returning. We can therefore drop their UNUSED markers and assign
> to 'repo' directly.
>
> builtin/index-pack.c is entered via RUN_SETUP_GENTLY, so its
> 'repo' pointer can be NULL any time it is run outside of a
> repository, not only with '-h'. We keep a NULL check there and fall
> back to 'the_repository'.

Hmph, are there legitimate situations where we run "git index-pack"
outside a repository, or is it a user error?  Just being curious
and not a suggestion to change the established behaviour (in other
words, even if it turns out that it should be diagnosed as a user
error, we shouldn't do so in the context of changing where the
fetch_if_missing bit lives).

Other than that, this iteration looks good to me.

