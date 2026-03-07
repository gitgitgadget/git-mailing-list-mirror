Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588314E2F2
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846073; cv=none; b=Abho71KgGc1HHp104IQTiJboRbo50f3kSWawTj0zBbBxMUV1ZFvdHNfGMQGol1nHGGfa0C4TXe+9mClVGjPagZ2nukgmFXJig/YU2Hh0yT4SFdmS9CU9NrJYOZxnnM3Bfs/VLE1JghllhPhtGaFjzZuXkY/Qf4THFjL5u0FI0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846073; c=relaxed/simple;
	bh=u7ImXuDrzVEMf3WwV16GWTFTm8NZWap5DyuUHFWC2+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDfmaTR/9Rm5jxH1EFOYkRpctgxq1Qoy1nIrhFLLrOvVwrCtWnHPp0acIW4wXDty8haDrz2CvByyTbo6lW9b1n88zzHHvp4jHRBboEuJysYyZm6LLaIQIVETTM4F63ImVCAeTkqaiO89QGRYdZM+X1ZByAbTbnsri8EtayjkJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ArrfUhKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrpQqhld; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ArrfUhKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrpQqhld"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B6042EC05B3;
	Fri,  6 Mar 2026 20:14:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 20:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772846070; x=1772932470; bh=tO1Pgs0rW5
	6MsbTdQxvpBKzsRdZHGVFam9vgB01s2oA=; b=ArrfUhKb8mUbstakqOpP9/cgDM
	e2k0NtWbLNFm2WOXCDvKijp2VjtYAJOuAlNvqQL24oYG3wRmeTyrr/sNQ4iR21jb
	Q86kJwK+CgVIjivRkDzOBNghshR0CmjtaLvTufJzX3mhEZ53h/Bjc6elkTS2K7rL
	XN/9oUUpTURCZhsIKPD24IZIz4kvI9lliRRHvN76f7xVX1Zi+7lD36cG4g67Pk5J
	iCizlKmN4xdJlqmUYC/zuX56DYkqSY9laS9Ij3xPj1cbHvxXRFUsP8jSpy7mn7u+
	5mwrOndgrFAiuczFrfk77ybdawJnrLn7dIw0+lUNr3Y5G8NPh5YbHQMCdpXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772846070; x=1772932470; bh=tO1Pgs0rW56MsbTdQxvpBKzsRdZHGVFam9v
	gB01s2oA=; b=TrpQqhldUAObFDDkkwSThOxbPp7fufYthDX4Y+af+r/wlajwQFI
	D5LNDFziUo1UfRu2n9D9C1XtYGsSNFfZ786fY/DuqdXXHRbI0IPbuUzREjWiw9h5
	dLqm0umgUPIP8ebq+bn0GH5T1PNDJsU1MJiZ5K1QWv+Su25XOM3OzTJH2X+wXLy/
	Ri+yJDtEP4/wd1aaP6rO5MwRufjL9K8RPXvYty/nfhCSYScUmnIk12bD2Gq3YR+n
	91zwsa84nk6RpFjaAVGJvWI9CGgj1vxzWPybj7h3ffXcZyEWDvtqNXPKuSL3Wlnn
	jx7UnBn/Y4keFKFYhBsuZxs25QlSQ+82Rig==
X-ME-Sender: <xms:9nuraYQt7YnCaILbnBN85mTZJr2vXTON5Blbs0Eohb2O5kZteeU1Xg>
    <xme:9nuracrfvVl5anGkb1srinXiqD4TGNeyST9f-8iy9N-s_eTe1GoI2kkN-19LJDMyi
    mRBhxGqfS7HOzQTGvniNLV8l7FI5WFXqDFdt83S2BxGDCf1qRXY9g>
X-ME-Received: <xmr:9nuraeJXMupB3Pihs69U-mMQ6xaKVbeJlcSPeX9KiZDbXGU6c1g7QNiZHG0n6w8zBLBKSImdZsQFMmZXtHrrm8Zlt2zFaSSLeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepueektdefgfekgedvvdekfeeiudeftdfgtdeukefgjefhjefhieduvdehvefg
    feevnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhmrghprdgtfienucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhgrtghosgdrvgdr
    khgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9nuraXqhXXj23GlLGabijydxpLj7xtVmKBWngbuD2S7OHZImlIMgJA>
    <xmx:9nuraewZfzzOtrXJDvwfeI6l775ySAB0k37rlLGJe83Cg5lH-daiWg>
    <xmx:9nuraTNr9IT73ETCT9N8BIE-crNKwSX_2EbgH1TfvjvFNAcc4poR0A>
    <xmx:9nurab6-npc3ABnrRrUtKNYzuovQYeEwyC8nhWkrNX5tZNGw7iuD5Q>
    <xmx:9nuraVEg2iBr3aueHE0W-LcIFFbBIVIAiXAVLJHOyJP1FGRucpsQCiGL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 20:14:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/4] Makefile: turn on NO_MMAP when building with LSan
In-Reply-To: <20260305231305.GD2901305@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Mar 2026 18:13:05 -0500")
References: <20260305230315.GA2354983@coredump.intra.peff.net>
	<20260305231305.GD2901305@coredump.intra.peff.net>
Date: Fri, 06 Mar 2026 17:14:28 -0800
Message-ID: <xmqqqzpwv3t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> @@ -1600,6 +1600,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>  endif
>  ifneq ($(filter leak,$(SANITIZERS)),)
>  BASIC_CFLAGS += -O0
> +NO_MMAP = CatchMapLeaks
>  SANITIZE_LEAK = YesCompiledWithIt
>  endif
>  ifneq ($(filter address,$(SANITIZERS)),)

And of course, this "breaks" the leaks job at CI without being the
true culprit.

    https://github.com/git/git/actions/runs/22786105918/job/66103114142

My bisection between v2.52.0 and v2.53.0 with the following

    $ git bisect start v2.53.0 v2.52.0
    $ git bisect run sh :doit

where :doit has the shell script attached at the end of this message
blames this commit.  I didn't dig further than that.

commit 4c89d31494bff4bde6079a0e0821f1437e37d07b
Author: Patrick Steinhardt <ps@pks.im>
Date:   Sun Nov 23 19:59:37 2025 +0100

    streaming: rely on object sources to create object stream
    
    When creating an object stream we first look up the object info and, if
    it's present, we call into the respective backend that contains the
    object to create a new stream for it.
    
    This has the consequence that, for loose object source, we basically
    iterate through the object sources twice: we first discover that the
    file exists as a loose object in the first place by iterating through
    all sources. And, once we have discovered it, we again walk through all
    sources to try and map the object. The same issue will eventually also
    surface once the packfile store becomes per-object-source.
    
    Furthermore, it feels rather pointless to first look up the object only
    to then try and read it.
    
    Refactor the logic to be centered around sources instead. Instead of
    first reading the object, we immediately ask the source to create the
    object stream for us. If the object exists we get stream, otherwise
    we'll try the next source.
    
    Like this we only have to iterate through sources once. But even more
    importantly, this change also helps us to make the whole logic
    pluggable. The object read stream subsystem does not need to be aware of
    the different source backends anymore, but eventually it'll only have to
    call the source's callback function.
    
    Note that at the current point in time we aren't fully there yet:
    
      - The packfile store still sits on the object database level and is
        thus agnostic of the sources.
    
      - We still have to call into both the packfile store and the loose
        object source.
    
    But both of these issues will soon be addressed.
    
    This refactoring results in a slight change to semantics: previously, it
    was `odb_read_object_info_extended()` that picked the source for us, and
    it would have favored packed (non-deltified) objects over loose objects.
    And while we still favor packed over loose objects for a single source
    with the new logic, we'll now favor a loose object from an earlier
    source over a packed object from a later source.
    
    Ultimately this shouldn't matter though: the stream doesn't indicate to
    the caller which source it is from and whether it was created from a
    packed or loose object, so such details are opaque to the caller. And
    other than that we should be able to assume that two objects with the
    same object ID should refer to the same content, so the streamed data
    would be the same, too.
    
    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 streaming.c | 65 +++++++++++++++++++++++--------------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)


---- >8 ----

#!/bin/sh

git apply -3 <"$0" || {
	git reset --hard
	exit 125
}

(
	export SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true 
	make NO_MMAP=CatchMapLeaks CC=clang &&
	cd t && sh t1060-object-corruption.sh
)

status=$?

make distclean
git reset --hard

exit $status

diff --git i/compat/mmap.c w/compat/mmap.c
index 2fe1c7732e..1a118711f7 100644
--- i/compat/mmap.c
+++ w/compat/mmap.c
@@ -38,7 +38,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	return start;
 }
 
-int git_munmap(void *start, size_t length)
+int git_munmap(void *start, size_t length UNUSED)
 {
 	free(start);
 	return 0;
