Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D698257435
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828079; cv=none; b=nQZYEqQdfldrYxeRk++dD4EMXotoVYGItnz9HX8pf6acnpSjNF+JAeuMcR1z3oYa1zlITjA2wFHCxe3K9e4QzVnbIqeQ23rHV0nMZpfusqMy4O1u0mczxFTBsN1NxlS9Olqgof3A5lOvSfA4+o56Wwh1s6L5sC9eWevIg5bcnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828079; c=relaxed/simple;
	bh=eabpD5YNvjJmPo5KKSqtO52OBPNPt34wT4I1FqpUKEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3LES/HG3oxxi5NRMM0ElgunwikWXgePmE6Q4yEdGtrmgAAN3eJNaYRkaKv4+gfyyzBrrIIipmQ8fCINzDSO/Dq+cJVPAgjAwyPz34XUo2Rz5UbWpe0+7oAEdaYtnmP6dNEYW43bMKh8368nnaP/opRwVhHGXDX7w6QFvVphD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f0asb9wz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JP/fRVFW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f0asb9wz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JP/fRVFW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C3E081D001C1;
	Tue,  4 Aug 2026 03:21:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 03:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828076; x=1785914476; bh=CsOh1HSucC
	Vk/WGA3cv6h0CZHtUOc8TizcmL4FW3ZQ0=; b=f0asb9wzkzVGPCSvfmnZipK1yy
	LZ5oItyc+62mHKUk9xDhmzhjzhLadl7uqjJQxKR9icdSUvAKIReDQ2OHfDh986Cn
	yMVM8rnmW4yE8xYFrwY5kKVUjClH67JyLx0TxupInIfmac/40+mjNjz5yLz1g+XZ
	4P6zCqos9oA3rHPx6g0YnbWwyUB+LuvBJNzzpVZ6VAx3iUg62DXu+kQc1j3v0jYK
	pY7bH6nVZAXpruBx8AMJ5I0JUwsaXp8V7M/SHSuy8u/Z3+DBUE14w6740BvTtSph
	Xe/NY0ckMjOHn0werj6Ln2JONlbg2ztTLr9XvSba7OMrMjrpU7s5Xb+ywk9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828076; x=1785914476; bh=CsOh1HSucCVk/WGA3cv6h0CZHtUOc8Tizcm
	L4FW3ZQ0=; b=JP/fRVFWzmhT2ZqOia/1VIllHyGmBQf4yiTa9FiE+xGdIxIdpWG
	wF53tHZUHHo8WK9CxnX03GNYce6DBhdfRPkWaI8WKPQqrkNFSlx8x80M2a3wRFaW
	QzpkDCt9nBBGtGfx+8gcW9+HQ5Y/ENoUoYkZH37ZR0484Ydx3F+Mefcb0TwUTVAw
	6C4NxJSKs5lN8q0W9jz83U/K7FcCu90PUBt6QQQGDqXVJJ4BPU/B5A+cdiA9dzWC
	TaRGnKcfqxA2ORa5CxJg2bCcxP+DLIvB0K+2WLPXHh0cdEoQbfzcboO+zULMvxoD
	whodGND4k3+wZw29Uv5ylN5O/tykNTscyng==
X-ME-Sender: <xms:7JJxakEicnsL_ZBrUxzx4SQptpl6CpSOXPVpaX1-2xXzNoBI2EcrqA>
    <xme:7JJxakzzHL4t3aHdoXzL49Ne2FU1V3tmTPbpT-i7kHg0hIF-DONwdUeA7rMrfNrSd
    vAFzM_R3o2mLfZGiojHf3scBFgQUvc8-gXbeRpdAUZr5woW7PW9Kx4>
X-ME-Received: <xmr:7JJxarjnd1uQhPYAduMl22WbBPCeY2ToM8hZTm1kL1kM7jBSxKdCuefAputNkWdy9NTQFJ1o2JkuFhmTUFjwOM6EUCxSJOIHuyMpXr3y>
X-ME-Proxy-Cause: dmFkZTGHB/BtFsTHMxz54XYKr3pb1NdqVGZZgpa70fhzRiWBE6IpdGW2MuKshyDlUzvURR
    6Yi8GJNystEhuLYBJPTY437SURCIOdV7yOubHk2ki1jVAJOQ3RUuSP+tYYwM6Gn133767I
    MI4g9d/ruHt3p9GXxxb0RgeAYfiEniqlf82nYkABlCZl+uJgo2gXo3F7Fesvj+LURvjGIT
    XpjN69eeIZ7JyPH0NTOtOmO1FOSG1LJpHyDLKuNj6D3D6d8eJytVHieSFiuclOJDkfcOvn
    l0OqKCEm20UoMdFukL7Cj5ViFjYMGz7nemkB6ceKMDq7JXU3iQCwsEESdYDyxa9JdLWZhW
    JLfKOTwVYgFiAY58y0/EfujteeLSXZudtKzFHkhMK+5R2DdNfh8vcK4XEfbnsdtLzLrhvL
    et/atvBWWaxUoiRrIfcd5egvShj98VrgRYVuzLUuvGb1+Uvbbcxj+qilaKcI4PaMjp9Yop
    wfmHkY8HrNc9CQPAs1YhlJBshKitulPrk9YKqImf6NEcihAyHUteSXT5gUe+A9RBuUbwj7
    CmFwnKKR7SzchXkVKvA04qoqTWhBH8zV1BQkX62eXps3vCS0YOAswPKBLRSVqhgu8f5KJl
    S5A4RzIJW9XGQthmmc7hW2y/ShMoAaXomv7TvCrrUDSJsH7uU+gbCJP3Vqkw
X-ME-Proxy: <xmx:7JJxavx8p8IoXEPOXP4C5QybBfFSnQxhM_xRaMfh1-vfUtAy9ak_lg>
    <xmx:7JJxauIaTIbZ1zquAnxFyVREXs0S7oaSVdHoy9gDfhFAY4q3NH1G6w>
    <xmx:7JJxamT_d12Jq-GMhiqwUwWaU6dEc7ipoz5JCz1fKYMga8SVp0n4cw>
    <xmx:7JJxamqfjjE16tm8N5X0uTv6SarxXf3WUEoSJJNwkbbQVmXKQdVdBA>
    <xmx:7JJxakIyfk8mRMdBwJlvbyRticCojEkVwzyZLzmbfnOgM8b_h9ybbpKo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0402d251 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:11 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] loose: load loose object map for the correct source
Message-ID: <anGS37r_67pWr7u0@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>
 <amkMipjGA_7cwpOR@denethor>
 <87tspgd4p5.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tspgd4p5.fsf@emacs.iotcl.com>

On Thu, Jul 30, 2026 at 02:47:50PM +0200, Toon Claes wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> >> When loading the loose object map via `load_one_loose_object_map()` we
> >> pass in both a repository and the corresponding source. We ultimately
> >> don't really respect the passed-in source though as we instead always
> >> load the map via the common directory. This doesn't make any sense
> >> though, as the function is called in a loop through all sources, and as
> >> such the expectation is that we'll load the map that belongs to the
> >> given source.
> >> 
> >> Fix this bug by instead loading the map via the loose source's path.
> >
> > IIUC the primary source is always being used, does this mean that
> > repositories using a compat hash and alternates are currently broken?
> 
> Yeah, the commit message seems to undersell this fix.
> 
> I think it wouldn't hurt to add a small test for this:
> 
>     test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
>     	test_when_finished rm -rf alt borrow &&
>     
>     	git init --object-format=sha256 alt &&
>     	git -C alt config extensions.compatObjectFormat sha1 &&
>     	test_commit -C alt A &&
>     
>     	git init --object-format=sha256 borrow &&
>     	git -C borrow config extensions.compatObjectFormat sha1 &&
>     	echo "$PWD/alt/.git/objects" >borrow/.git/objects/info/alternates &&
>     
>     	oid=$(git -C alt rev-parse HEAD) &&
>     	git -C alt    rev-parse --output-object-format=sha1 "$oid" >expect &&
>     	git -C borrow rev-parse --output-object-format=sha1 "$oid" >actual &&
>     	test_cmp expect actual
>     '

Good idea indeed, will do. Thanks!

Patrick
