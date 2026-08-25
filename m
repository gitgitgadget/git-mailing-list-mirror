Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED81531C8
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678079; cv=none; b=svm+ci4dSI6K16NriK1/DcpGpIHqqKM+F0SFWrSeutXULLwLdK4Ig4SltN69ggkLoUGnK9o8cVPk5ZWcIDj2LCVg7Tdmu93E01iDCZvf54Qc2u5N8Ckl8DS64Fa/CueeMUQsQC4RE0xNSSTlvVVS0bOZvQ4nCddcJpBHZ8BywGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678079; c=relaxed/simple;
	bh=ZMKH/dOAPcOVUHIKZSaCuxaPuqVbaRl4neoDMBNLGy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivKOdVSl+HdIpYoJH0LRfc3a7R23FeoQCQu2NvGtOLWnRSDHpdST0yXzsOQRgoERTMNGJyY5kJeXlN1AA1JoNuHzUSWAa8TkvRZ4umg/L5CE6ibnCuvivI2piAShrfZgzV2zqAkslYhf+qCXnGyZ2OVS8g+1YM00DeipcqS0j48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jb7uBV0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dX5Lh4/j; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jb7uBV0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dX5Lh4/j"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 291C91D0008D;
	Tue, 25 Aug 2026 13:14:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 25 Aug 2026 13:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787678077; x=1787764477; bh=RyGIx16D8q
	ECnP78oRbeYjT0X0fhW2SW9kZJJ/EEB2c=; b=jb7uBV0IuIjnuw9U6Ox8haP9lD
	k+D/M/h8ouvq4g+mxNGarff9Oud2iC2/cMLsyjNCvUUX/yBCiTHOYU1+N0psu3mh
	bITrvCUW+d/EeIjSnGVU0pGsruLdO3U1NxDNjp/LpNkRWS5VnsfI44cn6s/mWTW8
	Rwhff9CqUMwv7Qk53npv/MFI0B0ZMmYykxKCYybdPO9IqCtROp22ta77+UyRcD28
	bk1oNPiwN1+NfOxrPzw3yopfgQ2OgGWC2UhtTrbMlr3HM/MWNss9yvsPqq3evvzf
	jj3LiS5beUplidYPRzfAoSi9W/fDKplhed8GOTuuj/L+o2eO7nK0l6k+8ynw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787678077; x=1787764477; bh=RyGIx16D8qECnP78oRbeYjT0X0fhW2SW9kZ
	JJ/EEB2c=; b=dX5Lh4/jT1xgDKacD+2DnThKxXA6I8QrtCi61btzqdxatX7Zx9Z
	LO0nLEX6mIaSF8Lu1YE1cEVIhR0xuifAw+u5wYFMYe9NTOQBUXtqeUlZMEvjx9S5
	siKjjjZ7LCK+inTJzn93d7m4i5UF/foeqb1sFYi88OF4JzZ/m62+RwFdNSBIZWil
	vjmFkKsH4r0b5iWyK77vOZN8ujmvnNWKcdb4CNX2aB+TVJcQ8BYjc3Tw43GNUdLt
	jYR0qENy9g5+Jpmswu3L3yJcHRP99er0+Au2pJ+kGFTeBH91EeoTFIDqifEajEv5
	H//dqc7drkwEdXyzUnieLdN2bX+vCC/pi5A==
X-ME-Sender: <xms:fM2NarHx36A4Dd9FsVzknHt7iXNo0wMJelyVPvDeeECFfEFCZ_0l9Q>
    <xme:fM2NasAvHPdsHUVPVV388JLv4kzNVDS0muEjVWDnlWgKwc13xcrjONFGLIoV5rbtt
    NAc4MKfMIn0t0sSL1E7xvq8kksPynrvB6fuUUEWpGAC77j1j16RhQ>
X-ME-Received: <xmr:fM2Nam8vqlfYuNqzvwFaWDEsFb1NtAmUW2SDjWbAOXsqeDBKxCoFP65Nz-xbGZTibJJ4wbDAxwlkxKTgYriafLql_E-ehhTfZw>
X-ME-Proxy-Cause: dmFkZTFxOUkzOAeDXkDmK6ZFZ4b9xQrdDz+QK1Ia7EIayi2RlQC3MjrvZAOhD5RgvbaOKS
    YWBT+Eye1PmiUlZ3h6ly/fOBarthMEMGWHjDVCwlfA6sjKWJ0YmrM0mNulTsHxM+g4IeWM
    dV5WifM584yzh+8qYiNBTMW9t1GwBujfoPGwE7qyQWGgZ2uPn4vMlaLsHRKwQf2Q+s5JE5
    wOeoHLJoNegCGGqri8cSxZF+rYZx0CTRS9IGbGfMJpe78nnvu0MFN86DimblM5oB02uNPa
    8lg70ZW4D3SrFhbINRP5l30DyFcpCC2l8GxogeARZZxyZckhJw/VUjVelei+HvlIa6SdK8
    r+ecVpEkyiDPOmLIlAnXjh1RiIK8fENo++JK5QKCE7gb1ASXnyvKR1QPrjm3VH8F2AWY08
    /RjqWH0bbV5pSeTd923bwbrTDflQfG+Vt0FDrib8v5htkW4aMZaLUSTn4RaPLP9Xy9D67z
    zx4NVQit6QUancrutWq/aLvinOJgROKfKWlzf73EU1HJIK7Iak+shsiaKp04Vh3suPTo8D
    V8Izm9kM3JVPn0RNwwsDoKSEJuIZe8WXzrxek2g0qsvcN4InONbe1c0v/26NwzJWhVhLQS
    ujtYS86/zb9lCiqhk3K/5tYOXPXy5A2dWNYRiie0X1Ilu6kn1Oo5nEJ55Hxg
X-ME-Proxy: <xmx:fM2NagBcVRoUqUdVjnS6i5pPF9I6SyNYb2h_B_vvYNwOe1TDQacd7w>
    <xmx:fM2NajT7dR0sqtwb9Nm3H2T2ofYeS3KGPyUCL8rqJon2LffprIEVsQ>
    <xmx:fM2NavvLDMYFE0BsffCNygB-ClrSuLbZIObjqZMYfF9_5j-cRlFANQ>
    <xmx:fM2Nan3SIpbbS5D7XLvsnPdFtsyARVIB47zPF0HxmA0ix0766rxHhg>
    <xmx:fc2NahhtiytcSt3C5zK2rffL8srRKirnoHE6pkAvgXdVuaGlRiNErCA->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 13:14:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nikita Leshenko <nikita@island.io>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH] am: record blobs of cleanly applied patches when using
 --3way
In-Reply-To: <20260825085516.66088-1-nikita@island.io> (Nikita Leshenko's
	message of "Tue, 25 Aug 2026 11:55:16 +0300")
References: <20260825085516.66088-1-nikita@island.io>
Importance: high
Date: Tue, 25 Aug 2026 10:14:34 -0700
Message-ID: <xmqqmruam8at.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikita Leshenko <nikita@island.io> writes:

> Make "git am --3way" succeed in an edge case where it currently fails.
>
> First, some background about the case:
>
> Say we have a patch with two commits, A and B, and both of them change the
> same file.  We apply them to a different repo on a different version of the
> file using --3way.
>
> If both patches apply cleanly, we are done.
>
> If A does not apply cleanly, git am falls back to 3-way merge.  To merge,
> Git uses the preimage hash from the patch:
>
>     A: index 83b2a16..cccad2b 100644
>     B: index cccad2b..0ce2f98 100644
>
> git am looks up 83b2a16, applies A to it, and merges that result with the
> current version of the file.  As an important side effect, applying A to
> 83b2a16 also stores A's postimage, cccad2b, in the repository.  This means
> that if B also doesn't apply cleanly, cccad2b (which is now B's preimage)
> exists in the repository so we can merge against it as well.
>
> Let's assume instead that A applies cleanly and B fails.  Because git am
> didn't have to 3-way merge A, nothing created cccad2b this time.  What we
> have after applying A is our file plus A's change, which is a different
> hash.  When B doesn't apply cleanly, git am fails because it doesn't know
> what cccad2b is:
>
>     Applying: A
>     Applying: B
>     error: sha1 information is lacking or useless (file).
>     error: could not build fake ancestor
>
> However, technically we have the information to build the fake ancestor!  We
> have 83b2a16 in the repository, and we have A, so if we apply A we'll get
> that hash.
>
> So do exactly that: if the user requested --3way, apply the patch on the
> fake ancestor even after a patch applies cleanly, in order to produce
> intermediate hashes for later commits.  If the preimage is missing, or the
> patch does not apply, nothing is recorded and git am behaves as it does
> today.
>
> This does not change the behavior of how patches apply, but when the user
> requested --3way it does cost one extra "git apply --build-fake-ancestor"
> process and one extra apply per clean patch.

If you have a 50-patch series that cleanly applies, we would incur
overhead to spawn 49 extra "git apply --build-fake-ancestor"
subprocesses, to write and unlink 49 temporary index files, and to
perform 49 in-core patch applications, generating unneeded loose
objects in the object database, and loading and unloading the index
file one extra time per step.  That is simply unacceptable.

Can't you do the equivalent lazily inside fall_back_threeway()
instead?  A rough outline may go like so:

 * Imagine that, after applying patches 1..(N-1) successfully, you
   are applying patch N.

   - First try direct application of the patch, and it fails.

   - You call fall_back_threeway().

   - build_fake_ancestor() is called for patch N; if the preimage
     blob exists, you are done, but the case you want to address is
     what to do when the preimage is missing.  And in that case (and
     in that case only), can't you reconstruct the image chain
     lazily?

     Instead of returning error("could not build fake ancestor"):

     - You inspect patches in .git/rebase-apply/ for 1..(N-1)
       patches (i.e., those you have applied already) to find the
       relevant blob objects involved in reconstructing the
       preimage blob necessary to apply patch N.  Some of the
       blobs may already exist in the object database (83b2a16
       in your example).

     - Apply these previous patches in-core to arrive at the
       preimage recorded in these earlier patches (applying patch 1
       to 83b2a16 would now give you cccad2b), until you see the
       preimage blob recorded in patch N.  Write out that blob
       object (and not the blobs that the chain may have
       produced as a result of intermediate patches).

   - If the lazy reconstruction yielded the necessary blobs, try the
     build_fake_ancestor() call again, which should succeed.  If
     not, you can return error("could not build fake ancestor").

   - And after patch N succeeds with 3-way fallback this way, you
     would also have the postimage blob recorded in the patch in
     your object database, which may help when you apply patch
     (N+1).

When the patches cleanly apply, or if 3-way finds necessary blobs
already, there is no additional overhead with the above approach.

Hmm?
