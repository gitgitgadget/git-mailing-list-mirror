Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7083630BF
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360383; cv=none; b=cViB4ojA38whfbTvk6+E5VYihdxNWTobOmLxH8afi7P7soEdNrQ0KIFRRL/NZrSNuMFkK+36OXuF6n6glQxnVxaoFm+TxA9b7Ws3xvC4vr/hLdJBundAjU3SxPUypl74rfD06hnHdIyE5AOirGn3aZF1v8KwQqsGYl6IW9Qd6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360383; c=relaxed/simple;
	bh=kxniG1jlosjgny2wxWDc1iXbsRpO7Cf/K9pwYzZY+l4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGAXMDKmxfcCmQ+/NI+C6gXjHeSOgeNBGZCJrEJw6xkxSjZOnS1kogkAE6CbZ1kop0CE9z0Zboy64pk+uyNUwpkGC80XlAy42f2hOsnSWIpo69AGkhnBOjGASHj2L+TQ7PLQkDipy4ZY6K/vVM2ykVcqSoUvDqi4z5/2Xu1v34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vv0kjjWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2R9/bm1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vv0kjjWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2R9/bm1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 185151400157;
	Fri, 25 Sep 2026 14:19:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 14:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790360381; x=1790446781; bh=7f+JYq4N1/
	dRNPuYYFlDMv4OtqcvAUDsHAkzUcJdZh0=; b=Vv0kjjWRylYGlQIkXYsXgxADt+
	RY8aNmit5TJwBeEoV/ZkaeGHkeZc13yvSG8BVSu10D4tSX9GAeX1ymj685xP3ljO
	xJ0FOWzlfDx9536FNzhiZ1YKoKK/e3AFFclK//P3muVqgetsVLIykQbx91S4zEnX
	gfEO63xInV5MtxyvVm2dY+mD5qO4I52Tg5PmBPK4BOCfgG+2YpNV1b2XrEtxSWQ4
	p8cBqzQOfBxhKtIV3OEPx/z6uV2Md/nM1HQcrLkjaj3CnIjSVVLaul4ItfqkiY49
	3vvA01ZtKkVrAKWHL9U8mpWl++V7aEkzvgk2hV+2RwwmUaR0WNgm3jLN8//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790360381; x=1790446781; bh=7f+JYq4N1/dRNPuYYFlDMv4OtqcvAUDsHAk
	zUcJdZh0=; b=i2R9/bm1u9X53AVzRT3Z0bQw72ihM2v/XanRgn1bBmGVJ+73J7L
	8aqkOFJlk1u43gO5oUhOPoNydQ1X+G93aPxWDDBJsuMGVMJBjrm7mhuZjkZa43N9
	H0f60UEVndyte5ueCNjacW+Xb1I88Vb+G1KuHv0gJqXUEY+LsIHPbhk+Gph+RFWA
	Ucrv6JjTR5Hrn6vhZqZ+yBaHtaEYyVU9FpGlEI7m50MAbqpZ3Obgk/CBtbZoAXsx
	MUTpivmMtV5gUsgISXnpXBeYkMHAdPda32kP39R1Pc5ynh5Q6ZKIVQAgYx8na3HD
	2uIeYs6n98YzFpcPkenJIu1093qb+KJOoSw==
X-ME-Sender: <xms:PLu2aock0NxErbXSsU-hag3Xtm-jJoD7bHZWBOUud7QbbhJANCcW4g>
    <xme:PLu2at4YVrsRbh75Q4nwcWN894QRaEFwrgJnASxO9ZWR2l5R59nVGH44opwTBApwd
    pn3A8Agrzrsr7VIDFBG4BO7EO_5M3mKZzf8tk7rcZ6qrDQkqUbJUbE>
X-ME-Received: <xmr:PLu2ajVla9fcD7XAIRKKq9_3qzTu9AEyy9QvFSohnbnsGchC-TAfdfDBH8rwPz3-VTqo9cBSfCj05aD1PHu4Y2AuYZAbq0bGAlft>
X-ME-Proxy-Cause: dmFkZTFqqydtRAnBS5HX2IMYmvVEO3pQFrJgevQCMPAfctfJcetZ9be15UX6XP2U2Vlm/l
    FPNiq/kc8xNWaJEguj4/o2JyFimcqpAA3lsZLPqGxndS9iW+FbWbdPhRKR5Q++o8x2dykH
    pa4fqt524VYcmtRFnrRD7i2AVNhNi5eZ41lcpSuDrJPdjtwYZGTVxvMaPJHdvlgMg90zqj
    ki9ZPnhjsu7VJNLd/B1zsnw8c4k0Qrkb3LZcbcvCmzZC9f8L2v+U2YBR5yURQi3bFvheDf
    w5KRbGPagPdrLVoXEZQ6KgIUcfC9ZWkSCTeHYkedKBmvH7+KwVoh4eDa2vQuFuNUiMGpn2
    IWglDzYqyJCk+qwFFD499d1jTz1VfqKsEc/Rwn8uflvavhcmPy6tmom47+CkorAF74T19d
    luiDeitldyu45Ho/GAwqzgNQipH5nDv/sAXS/97w5v2ApZdhHSetdKD3UD8Xqdu9UvJEQG
    q3t7hYjbL0IIQgJkbuOjqL95UP7WG35j9YGWtCkfU6jM7Egs6S6i1K+80pdyK5E9P3ZPrP
    GTN7oBHS9Jfdpz33HUgkXMV5frREnCiEzJ+Lgkny+sTPd62o56AB6RjPWcLce8ddshQelx
    /pO4Da9EfwGlGx8SUYsQK+FB+hczPaeue2MQvfKM9+7v4a87oy7Qw5i8VlyA
X-ME-Proxy: <xmx:PLu2ak4lcVyEauPvwCSx_1bLTHakr6c3OstU3ecYs4y98gwWCeJLbw>
    <xmx:PLu2amrFDnIhTOE2ii4S--V8CMhRz_lcBUT4t2T3ICnxcgQmUCFUkg>
    <xmx:PLu2avloj06sSGRfdqHpC90xRwUsjc0ZN14d2vQUw6vNXoZNvwDAcQ>
    <xmx:PLu2aqPe8wxCqLnyjqIXsmWhm37Nh8-D4FiNRW-ftjT78Zy49mLJzg>
    <xmx:Pbu2ahCSUwd2yQ_3AOH4PIIV7fna_vkSBGKE05YVA31H_XUER0FUNX8Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 14:19:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick Steinhardt"
 <ps@pks.im>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
In-Reply-To: <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com> (Julia
	Evans's message of "Fri, 25 Sep 2026 12:59:35 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
	<CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
	<2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
Date: Fri, 25 Sep 2026 11:19:39 -0700
Message-ID: <xmqqld8purb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Thanks, I meant to flag this: the reason I deleted it was really
> just that I couldn't understand what `git log --merge -p <path>`  did
> from the documentation and so I removed it until I could figure it out.

It looks at the index to figure out which paths we got conflicts on,
and then does "git log -p <those> <conflicted> <paths>".  You can
give a pathspec from the command line to further limit the output.

>> `git log --merge -p <filename>`  will print out all commits which
>>   caused the merge conflict for `<filename>`, and the diff
>>  of how they changed the file. 

If you _know_ which exact single file you are interested in, there
is not much you gain from the "--merge" option.  "--left-right"
option may be a lot more useful there.  It let's you see which side
of the merge gave you what changes.
