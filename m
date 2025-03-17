Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852617A2ED
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226985; cv=none; b=Ygh+7WzTnO2TudAiNB/M2xAd5wnboVyP8zTDL3tVEtTrjbqSQ79C19aL4FcjLNoHscGyIpX31dqz2idKQgRl5ShJzswU1bjVDGraaKruw9wO5gzBEM2YSbTz+vFTYbMxvbqgYtTY9nZ4LRUN31pRKgqPN28KNS7frReC9iJGjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226985; c=relaxed/simple;
	bh=MadOHQSOSGK2XfsHf5gYqHhpxF0SbPdRNMRu6qpKeys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFbl6ryBiTJ1DZyKRUBhZOqKsG97Ur1SbWoQ6T+8xXEJ28K2L4au1iLtSlYBJDYLy+Xe2cJwbZK2+/u4Ut/Z+G7YLevpub260b9YXQVp35h3mch/09S31GsC/egvrUov7LuRZsJIPNRc3YW297MAstfrOm2U6iGOvkM8zRTZQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q08Y+fJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUMb26t5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q08Y+fJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUMb26t5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AF4C25401CB;
	Mon, 17 Mar 2025 11:56:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 17 Mar 2025 11:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742226982; x=1742313382; bh=GeSGpzP7jf
	qbrVCyqFcymkhkR2JSB2QEd+CS27U1OK4=; b=Q08Y+fJcpOOIhw42tQ+ppDS5MW
	LLStSyOenAnyR1Zd7GF0SP7gGS7kA4j3OjyG56NQtydz5rL3jFSgkPbk93x4ZrtE
	GAOrMfMWO3foyquIglvHMcRw8g7h0tYxJAvE/am4XR7hDdEhIE212hU8DQhMh7RB
	fA29W1WdgN8ofm/iai2cKgDZx/6484hfBZE8dXk3QNvSFSpewWIFH/2qqp8LvB+J
	KQBkQcDxvOJjA8dHMjBmlFpTNbFyuihwF5k6SDEdvC+T59Fflw2AL5D+rFIKx6xZ
	3/YBliceOWTIpd62bFv1FTkxp57qo5Ap5jhJZYl93B7U4gwF7Aa30ZGvaGYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742226982; x=1742313382; bh=GeSGpzP7jfqbrVCyqFcymkhkR2JSB2QEd+C
	S27U1OK4=; b=DUMb26t55Yao/IWQJZGNmOk9hReyB6lxPa6vts5PkaBKl9hpMnn
	uieJrV2GSz/yS1xaNq/DHckyXxhjRIsHIzAGCV1N5vEurGCt0/Aa8bHSK+14XaEQ
	8AhhisMHo/8wM6CtM1hlA9A9yy9ZCMzvR13jr7w7xYErA7tzSYJIF/YymbHBU8RJ
	4mDvPU+qY7JYIGIGXeSpw8le81W1exOhKBKvZMix0vMWRqxgCV9v3tJ6kNjqJhJt
	i/oro1+c/RgDdCXAxUgRmSab7rZXHcVOXWk5DQt9twIcpRtMDQMt9EZUduRy+8At
	snBbvOX0yRTTwm8UY/JfBHpLTxnm7v12nBA==
X-ME-Sender: <xms:JUbYZ7vCn7T_t__kyarbR8By8SyeHy5CJYBF7ujgfFdKGVjVE2_8XA>
    <xme:JUbYZ8cHVGeVqO2l_ffmsnOqW6GC2m9b0RhjtJAWJxXsyqlpTIYwAZSUGYPzN7gTs
    dUKBTiJShoV9qVeiQ>
X-ME-Received: <xmr:JUbYZ-xxmDJUVrT-5l9JRoHu4xDNXL8tAZVIwXEQ06eHxo8mpDlDOgP_-Tl9dqyN1Mlfzlbl0_cCwD7fLnLhiTTKfHJwYtJOVwEOpv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdetkedtteduveeludekheffudehvdeu
    udffvdethfeileetgfduheffhfegtdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:JUbYZ6P1tXPpWO2v8Ua3TK21QpEoHpKz8L6FmLm0vZkIP2haoOJUYg>
    <xmx:JUbYZ7_MscdZUXPe9pES71I74zJ2zmANEPokuU7L-n-_cI550-iMWg>
    <xmx:JUbYZ6VjoqfA79MwGIHNOolLHGpEqZcGcQTkMqqQkmfTgBBsUCGtKA>
    <xmx:JUbYZ8c8ZKp0gjK7SdFzFPTGevCYGhdGVFkRlDLTK50m0CHgywtxYA>
    <xmx:JkbYZ2nlp1oivBugc_KhNSKmBXMdlacbkjnuzY4WBHwhNX8zapeyydIb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 11:56:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 06/12] config.mak.uname: only set NO_REGEX on cygwin for
 v1.7
In-Reply-To: <33561996-3b7f-4d0e-825f-5b2369d7d010@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sun, 16 Mar 2025 22:24:18 +0000")
References: <a4272c4a-7073-4671-a883-50e9413b0384@ramsayjones.plus.com>
	<33561996-3b7f-4d0e-825f-5b2369d7d010@ramsayjones.plus.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 17 Mar 2025 08:56:20 -0700
Message-ID: <xmqqecyvbqhn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> After some time (may a year or two), the platform library had been
>> updated (with an import from FreeBSD, I believe) and now passed the full
>> test-suite. This would be about the time of the v1.7 -> v2.0 transition
>> in 2015. I had a patch ready to send, but just didn't get around to
>> submitting it to the list.

So is it safe for us to just drop the bit that sets NO_REGEX and
require Cygwin that is less than 10 years old?  As long as people
are willing to actively maintain the compatibility wart for older
systems there is no strong reason to do so, but at some point it
would become diminishing returns even for those who have hardware to
develop, build, and test on, when the reason they keep such an old
system becomes only to maintain it instead of actively using it,
and I am wondering if Cygwin 1.7 has past that point.

> I forgot to mention, that one of the reasons that I didn't get around
> to submitting this patch then, was because of a '# TODO known breakage
> vanished' in test t7815-grep-binary.sh:
> ...
> The platform regex library is happy to match a NUL byte with the '.'
> pattern. (presumably this is also true on FreeBSD?).

In this test, the haystack has "binary\0file\0m..." and the needle
to be sought is ".fi".  The system I have at hand uses glibc 2.40
and it refuses to match NUL with '.', it seems.

> I could not decide on the best way to 'fix' this issue. The options
> seemed to be: do nothing (it's not hurting anyone), disable the test
> on cygwin or simply remove the test.

The part "On Cygwin" somewhat puzzled me; aren't folks on various
BSD variants seeing the same symptom?

Do we want to eventually turn it to test_expect_success?  I think
the "fix" depends on this single question, and I am not sure if we
do.

Is the behaviour that '.' matches NUL on some platform and doesn't
on some others hurting anybody?  I dislike a tool that behaves
differently depending on the platform, but not strongly enough in
this case somehow.

On the same system, GNU grep and sed seem to consider that '.'
matches NUL there, i.e.

    $ grep -a '.fi' a | cat -v -T
    binary^@file^@m[*]c^@*M-CM-&^@M-CM-0
    $ sed -n -e '/.fi/p' a | cat -v -T
    binary^@file^@m[*]c^@*M-CM-&^@M-CM-0

They ought to be using the same library as Git compiled on this
system does, so it is somewhat curious.

> [I think I prefer to simply delete the test, since it doesn't seem to
> be testing anything useful, as far as I can see.]
>
> What do you think?
>
> ATB,
> Ramsay Jones
