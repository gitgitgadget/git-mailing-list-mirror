Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6CA3043DC
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902321; cv=none; b=O8RIbbTt+8bTSKF4+9+ij0rA0sT8sl14AhSFZJY0Ff4Iuf2iWRDMnan4Etaxt3shk0+wk/lstJryWPHeG/EAEnGWc7D0e5e0NvCFYb8DncCWiatBDtSOuIZSkY7+X3Eos+WlbhfMwIQLKdZl+VEUDzNq9dzG8DqBKao/zquHRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902321; c=relaxed/simple;
	bh=mcIReE2IcdM3eoNPJY7ObpU1XpMmVN/6zoe2t9M07PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3KsHPGIAOi/Y9nJ1wNrop8e6/WORnmL5mBdY4+XvOepzORy4Xn+mMaZP1kyBNUURds+/dNzlSn9ZtXqYPoXE3n/Dff1psuo7YRTxHECFc2NTyt69cIOA/4LZYd0w2Etvua/iT+92DRCXK+40l5Fch/F61okxyFfEITlKVunwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=cwmgEM+F; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="cwmgEM+F"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a36887bso4150786b6e.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790902318; x=1791507118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mcIReE2IcdM3eoNPJY7ObpU1XpMmVN/6zoe2t9M07PE=;
        b=cwmgEM+F6spkbjQ39UU3P2eeklq5m1YGS6Pl9uAVqI0VC6Ac4IgfdTHLF6WSdGIRwo
         at34+jdImCvUaIURQud1qXJb4Or2LsQXz3whzhlmEXtGQ2b0s7Ih75V+UPow0HSErxqC
         g9KKNWPPFLhzv+icV292odDzDJ+gb2OzCDC4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790902318; x=1791507118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcIReE2IcdM3eoNPJY7ObpU1XpMmVN/6zoe2t9M07PE=;
        b=XG0WtgpGgRIFdt/I9d0tsogvA19hmAQjyCfq6LAVgWEX5iD+eoM4AC41M7CllQ351H
         ZbAtovUzt2k2PKb7aRJRaWxbMDs6mcULkOBoF4nP0lFxH5Y7ADzf+iji2ffqALFH94Pg
         M+l3tro+dEEC+NJMmDffzwbyloN9UcPxsJxeO1aaDce1PwVUBMQqJSViEbrZuNASejLD
         A7lQnPPtjvLAXND+fT4YV4yBy8Ke7iyF59sFJ13aUZ/kcCpKgLH1qZo25OBABgF6UZMF
         wvyHAV5Ef1X9mv4XrRCy67UkAKhCe077pIOq4XHa74sPeCAl0VKfx5BXSpj83yHCW0Lw
         +lkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXdByjhEK6wbBhABbewurzSTwj2zCICHTekHvFt1OjH1Rzy1a64Zul3ZpZnr2gu6ouFfc=@vger.kernel.org
X-Gm-Message-State: AFuF++l70osPqRxTQRXuzuJklMqbaGM9wllQtcwo8cIFGwf1VE++UaVF
	zRH7kNFtepZALI9NWhhZKsXgCXVSkscH/B1KeBUkb/sn7tSwHpLYUis1AAn/+k13krU=
X-Gm-Gg: AYBFou2KfRyZMHPtNsk3zBN4CsONLb7FhfgG3ZnYDSaVoWyRzZcb4DNVhd2SzBDkR4Y
	uW/ZK+d/DhcJXP4wTX/or0Rifjd0Rp1J5ALyBost3oyJbZAK8l3BWVjqaV+9YhWsNWuERBZ692z
	MdUo0MrXI+et+9ZJ9mBJ6vQqZ/PXNBgUYglhoQ2XMtbHbLhCVVH2Q7DTYXO1MT86DgRodjn0C+O
	lvYFkIEOSGqkGN9FaArKu7HOzMIDZ5Cq0yjNvlQJJcgZ/eiC3gYrzw+6/dpsol6yycVPdaUDHZD
	RtdglHIliNejMUSjzfiXFo9+pvfTfXu6cDpFFvhvIoCChZ9pCalsBdqgqM5u0I2XV26hnFdb3Kp
	DbYFnf8Fn/drR6vUgdljyWJ/I5BMe3OSUxEl3xD9WvslJDtMvWX89jNaabDvvoTik0Vs5/12cVW
	ofphTCtaOjj0LvdcSxEjXhJ8h+3wwjrA2K4U9O6rlkue3i3NwwJ0DLGYee/IdZZZSYad1wO1blm
	fO7z1/6ayGoUSZHL9erkCW9iaDNOvm9VDCiMdTHaDpNvVJbBuy7bCW7LR1KWn5rGKJ/msPfXOBe
	tYQdinJSKqMWIA==
X-Received: by 2002:a05:6808:220e:b0:4f4:9a44:73c0 with SMTP id 5614622812f47-4f526a4c96dmr1026713b6e.6.1790902318642;
        Thu, 01 Oct 2026 17:51:58 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f524cd09b4sm964932b6e.13.2026.10.01.17.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:51:57 -0700 (PDT)
Date: Thu, 1 Oct 2026 19:51:48 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <ar8AJLYZVb6sCIO-@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
 <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>
 <CABPp-BHE662t9aaNcZ4DZ+2AU_C7jR7_VyHZwt2Tm8JSPE3JZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHE662t9aaNcZ4DZ+2AU_C7jR7_VyHZwt2Tm8JSPE3JZw@mail.gmail.com>

On Thu, Oct 01, 2026 at 04:22:11PM -0700, Elijah Newren wrote:
> With the oid_array and parent-first pack order, the blobs are visited
> as sub/a and sub/b, so sub/* -delta applies. With the oidset, the
> subtree is visited first and the blobs are seen as a and b, so one is
> delta-compressed. When the root is processed later, the subtree is
> already marked SEEN and is not revisited with the sub/ prefix.
>
> The oid_array does not manufacture parent-before-child ordering if the
> input pack itself has the subtree first; this path information is
> explicitly best-effort. But it preserves a useful order when one
> exists, whereas an oidset discards it.

Sure, though as Peff and I discussed elsewhere in the thread, there are
also situations where you can produce a sub-optimal pack even with
oid_array. That's because the namehash you get for a given tree object
depends on the path you took to get there.

So you can certainly come up with examples where the ordering of tree
objects in an array of extra roots produces a lesser-quality delta
selection than the same objects permuted into some different order.

The other thing to keep in mind is that, while there are clearly
trade-offs as we have discussed here, the oidset ensures that we don't
allocate memory wastefully when the same object is listed multiple times
as an extra root.

The other other thing to keep in mind is that the size of this set is
almost always going to be puny compared to the size of the overall pack.
These objects are merely meant to pull in the (likely) few objects that
need refreshed out of the cruft pack in order to ensure reachability
closure.

So I think it's clear that this is a trade-off, and neither decision
(oidset vs oid_array) is absolutely perfect for all cases. But on
balance I think that the trade-offs push us towards oidset much more
than they do towards oid_array.

Thanks,
Taylor
