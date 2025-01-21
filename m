Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA661F76B0
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491413; cv=none; b=Iy0bVqcyN4jaI2vidWZZiXWgOA9X9ZF7H/PPig4HIBtdm013zsvfsqp1IDa34XE4itedUaaYr92wGGSBz4XNRFaTOwnu1at7XQ1NxqWLQJRKTSeS7StFGKWDKEZzzDeJa50uzQvPvQCyEGNgq/ToaSlwuKOhXrjF17MiqunP0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491413; c=relaxed/simple;
	bh=6wB08ZGa9Xrm9Lr/gZuZqpSVqqN/O8xftjK4YUQs9oM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDVVgOEtxlXwcixYKySF1Cmf66kyvp8oiaJP8/Hh0saVtCYbjeoHk4JqLn8Wm8/1qFfzAzkBRCN8kn5CmyOXXpr/liTm0IzOFBZaU+dMXcTT+0wIZ9UBhS8t6HxB+6gX4YS6od7EWz/qdGQotLDDfATFLtKRJ6rpt2VbuYrfJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GAKJAq4/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zHHxSSde; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GAKJAq4/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zHHxSSde"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1700E11401DE;
	Tue, 21 Jan 2025 15:30:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 21 Jan 2025 15:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737491409; x=1737577809; bh=34wOWk/NnY
	xgzzfEXvNkvofwRBy5L8o77dj57Xtyw/8=; b=GAKJAq4/oQmxFJlSpArta4wSAf
	MeivBVC+KwPYEOOfAiTqA3gGcMyQJWyVkTDFfm0GAvQq7cRN2yAZsn7kgrXlnYR0
	toF9ztYkugFEF6Bz62R1MrMu7DstSLqwxjAzf9injlt7U6d3WK2SBIgy70+Nn/0R
	/8JlggPIW9kZMZ/Np2pJzlkMEpf2GDLIf3VoFhRuytBdmg+g6BZXtyzngkhmNQKW
	slRzNPG/+UNBboiswKH0R0RSGyb0nfe512ygB6UZZQsJq3VG8ClKaGiJ+adTsL2P
	scF7Mb8GHcEnyKZJjaGQ76vjqE7rLx8bOfwUupu9D7xzi47xHrNtwpx/ux4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737491409; x=1737577809; bh=34wOWk/NnYxgzzfEXvNkvofwRBy5L8o77dj
	57Xtyw/8=; b=zHHxSSdeaXx2KTZIv4Xv/KToPyBEjCF0BsdaJKd+yPisrh0a6wx
	HLlv0Y30miUL5OVkPN7DpLFCj86/3+dJ0LeRcso8v0aXAe0uSj9QPynl2ge3V6RU
	lxprs0X+s1D0U/NYEPZmzrXmAHWrYdDDdRvKH+jdsiE9Bc91Cj2xOg1u/6yGtZzK
	tZi5fPH5VKOgjF7vI5cd01edl+EBbcbzqyH1xzL6N1WIi75nYyU+tguJv7moa7Br
	3OxZ794uYRx9iKvJ00lsSd7++asVdswqhAro5FpkHhhxRHwJSVKYEZuRdV4Q5Fmp
	dEYasJbmRvzFwVyy984+2h01etaDwLExcIA==
X-ME-Sender: <xms:0QOQZ5vBaSJTCxoR3HjtH8_gIEbaMzC0hOETfi0WkPu9V8fQvMT0qA>
    <xme:0QOQZyfN0tfcdlsYxNUMYzCZG4KaaZdjXVqrhRahK8C7coRUpW68nVmqVMDW1AeYW
    osoHgexQn7431LP8A>
X-ME-Received: <xmr:0QOQZ8y7ZjJ6N2orppAQxRKjo2GTyUbMNZoy_bNvKXIC2tlt8-thSo9Dt51JJmYJSyKNfvM0nDbVei7HeRuk29CV2X8wDGV3lnpG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0QOQZwOqag9JBeUW-CvefFQFzTXQ7xxgOeh_kLVRhvBZs6X7mkABQw>
    <xmx:0QOQZ5_ZMPZtJS4xqf_RybCv9EcpI_fSBI4Z4i-oHDC40tLrKOs8NA>
    <xmx:0QOQZwUfzLeQ-If0OVxxJZ3oWL6Jc2R7fBnk6WPxv9XPht90ClS8HA>
    <xmx:0QOQZ6dEAQdJ0lipnUxw9v7v6as1v4t_QP_SMPVY6Qs0a09gyUa-Xg>
    <xmx:0QOQZ0aA9fTqne8hO0QDKN0UmtbiPXHAAY-H-NpvF_IsK0WtUNg9YAxB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 15:30:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <1331d214-890e-4b47-87c6-44f445172bb2@gmail.com> (Derrick
	Stolee's message of "Tue, 21 Jan 2025 15:19:26 -0500")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<1331d214-890e-4b47-87c6-44f445172bb2@gmail.com>
Date: Tue, 21 Jan 2025 12:30:08 -0800
Message-ID: <xmqqv7u7zz8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 1/17/25 7:42 PM, Junio C Hamano wrote:
>
>> * ds/name-hash-tweaks (2024-12-20) 8 commits
>>   - pack-objects: add third name hash version
>>   - pack-objects: prevent name hash version change
>>   - test-tool: add helper for name-hash values
>>   - p5313: add size comparison test
>>   - pack-objects: add GIT_TEST_NAME_HASH_VERSION
>>   - repack: add --name-hash-version option
>>   - pack-objects: add --name-hash-version option
>>   - pack-objects: create new name-hash function version
>>   "git pack-objects" and its wrapper "git repack" learned an option
>>   to use an alternative path-hash function to improve delta-base
>>   selection to produce a packfile with deeper history than window
>>   size.
>>   Comments?
>>   source: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
>
> I'll poke the thread, too, but this seems to be the most promising
> topic in the area of better delta compression. The latest version
> does not have any comments.
>
> The only decision point I think remains is whether or not to
> include the last patch (--name-hash-version=3) which I would be
> happy either way.

I am happy with the updated function that gives us better of both
worlds, without losing too much from the "renamed from other
directory" while making sure we do not lose too many bits in deeper
trees.

Thanks.
