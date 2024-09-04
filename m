Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7B4AEF5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435733; cv=none; b=cJwtK00jFvvNFN+o0vgvv9deg0IY/7lARU5M0XEJuKJFN1+WXQ970XmuzOA7mhAyItMGyVx75VWnG+gD/94p+6jZ5v8PC4xIGJYZ/hSA1FPhs8I3psb6YrixfPjZ+HlBKRlrHIkJRQGJBH3n+JI3ZFRt44Q/n+QuMo5I1z5BgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435733; c=relaxed/simple;
	bh=kId72RByHmSAjiUpdNUUcZ8DI6huCtN0xC9RROKOxPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seZhRnDYqZ4niKcI1jRpBnSVM++daX93/kNwaBV2rSTLGzSD5W+vZMFhd1Xp8mgLKWzYCSbDOlIj9Qfe/PM95AsRoPQMapUheiSLRYcrdUPoL7yq9J58hQLp5tC9GhhkObBaOa8+cTNwWzKytdFZZTqwH6YNUobXyd87YWVPQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C1JE/MbX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hc1M+PlB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C1JE/MbX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hc1M+PlB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E5AA1140236;
	Wed,  4 Sep 2024 03:42:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Sep 2024 03:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725435730; x=1725522130; bh=abzR+oAqU7
	BEmXqorv9VR04WcLCOeTzn4TXcIAQMmHk=; b=C1JE/MbX1k+ubcsS4PR7VxJkoa
	z7YFqNWgYV46yCP7ilvdMDLPN4lKlfpHdDRUHev+Afs7/RfVQ6Gc5JlDqimRXq42
	UH9f6Kc1d7dCRTuDWw403MXNkIGrfXlJ+N2uEJBJCLQLKQze5rA4WH/CHFSi8OqU
	RzXOIB9LdMSjCoikKrF0yijCZWJmnVn3ErVW4Eh/xQ0yD+OVJ37pghWSCGbFosuD
	SWqfcl9DOsanDDxZG6UCIRScdHxLULZG92JecNey2VO2oL/VUwQvzQJq4aP59q8d
	/c6tiWK/7Y2YQ/3ot4auw544Abp1QO4rPRCpl6cbVXCd2tJKf4YbaigVDddQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725435730; x=1725522130; bh=abzR+oAqU7BEmXqorv9VR04WcLCO
	eTzn4TXcIAQMmHk=; b=hc1M+PlBkG3mWwmnAsgSKVMoXq/LWSQK19u8Ew38GTJK
	LurnjKjoutgJPP9s/7IhsbbydvoJXgiafc4CJ5NrCp/SpuXqbFCQCUFrG2hkJWXl
	OOklnFFjIlBruOexfRg6Ez0t+l4RLeVRD3wH5HMsVUZOo3eKu7dItdje02acXGVA
	qTGyoDGUi+pvjcD9jyViNNzioOnc2ZNwhAtgUQHKyqU6MvSGwAGkE3zMpZ67Ssjs
	FfMaXFgtLe8QBs2/q38xPEsCAKFE7S3KZL1rAKbROPPUt608fw30qDU/wDyvvFHd
	NOQSvnLpL2DPg5mbI2OsrEQHxJ+L+lO2frz3Mp8uTA==
X-ME-Sender: <xms:Ug_YZs39R5YA_MyMHWD3WOVxfdRt3HFSF-pn42bwtDW9UnhkvjYSgw>
    <xme:Ug_YZnFan7ENokOa-0GTiLfOfhpjb1rFYw_9FL8bOaiRWzYWRxCW_F25RIVceGyLe
    MlzqglYjUZyN1BxGA>
X-ME-Received: <xmr:Ug_YZk5gpyF1Olj6MM4am2DMRi_BrhpcPbLSO3G9LgI2Q_dg_OlRJVxoZ2bNxdKrOiL3T2pzOi2FjdOSLyrUJAxLGZQ6eSBTQKxpzyMYfqyK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ug_YZl2BlWU146HIocZ0UcV2Q6iz3GyEIWHhdcLl2Ud07gYP-AHgYg>
    <xmx:Ug_YZvFm4bYT2dLYCLM6U8mtKNs6K4-aRvXvHta4QEkHtidng2fQdg>
    <xmx:Ug_YZu_2h8UizLtTIbM6aXdZa813BpZcGSgDnerPY5niJfgxw0aQBA>
    <xmx:Ug_YZklvsJs0hHvpfRfqwppjjmIVRbu9eATxYMFke5mLQeTed8D4OQ>
    <xmx:Ug_YZnCrGPCgyV2SWvAGwTvJOXb-DzqRmlx9h0vEuFZTMyEB3dRaGCVT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 03:42:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e82570d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 07:41:58 +0000 (UTC)
Date: Wed, 4 Sep 2024 09:42:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to
 repack with `--auto`
Message-ID: <ZtgPSGMD0ZV3S0Nn@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
 <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>
 <ZtbVbn5rxrmLFuNa@pks.im>
 <xmqq4j6wlhpr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j6wlhpr.fsf@gitster.g>

On Tue, Sep 03, 2024 at 11:23:12AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I also noticed `log2i()`, but honestly the only reason why I didn't
> > reuse it is that I had no clue where to put it. There isn't any header
> > that would be a good fit for it, and creating a new "math.h" header for
> > a single function felt overblown to me. So I decided to just not bother.
> > I'm happy to adjust though if somebody has a suggestion for where to put
> > it.
> 
> Given the existing contents of wrapper.h (near the end of the file),
> I think wrapper.c would be a good place to do so.

Indeed. Quite a grab bag of functions, thanks for the hint!

> Shouldn't this essentially be a call to ffs() with the argument
> tweaked, by the way?

We are looking for the last set bit, not for the first set bit. We can
massage things a bit, but wouldn't that require us to be aware of the
platforms endianess?

In any case, GCC is clever enough to notice what we're doing:

    fastlog2(unsigned long):
            xor     eax, eax
            test    rdi, rdi
            je      .L5
            bsr     rax, rdi
    .L5:
            ret

The `log2i()` function looks a bit less efficient:

    log2i(unsigned long):
            test    rdi, rdi
            je      .L3
            bsr     rdi, rdi
            lea     eax, [rdi+1]
            cdqe
            ret
    .L3:
            xor     eax, eax
            ret

Clang isn't yet clever enough with v18.1, but is with trunk:

    log2i(unsigned long):
            bsr     rax, rdi
            inc     rax
            test    rdi, rdi
            cmove   rax, rdi
            ret

    fastlog2(unsigned long):
            test    rdi, rdi
            je      .LBB1_1
            shr     rdi
            bsr     rcx, rdi
            mov     eax, 127
            cmovne  rax, rcx
            xor     eax, -64
            add     eax, 65
            ret
    .LBB1_1:
            mov     eax, -1
            ret

So with the following definition we're optimizing both with GCC and
Clang:

    size_t fastlog2(size_t sz)
    {
        size_t l = 0;
        if (!sz)
            return 0;
        for (; sz; sz >>= 1)
            l++;
        return l;
    }

I'd thus say we can just pick that function instead of caring about
platform endianess with `ffs()`.

Patrick
