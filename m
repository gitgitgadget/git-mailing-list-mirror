Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66733AB27F
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790770; cv=none; b=juVKIlGzD3aTBehuq8tAOjskhwCncU3N4a3qYH4wLcyadP8ofNdU4YNi7qmGzkus0OiiRu07C1vveZazwZflqPjV3MgZPOn2TaeERZHB7JTkbNoy+unDprGsV9rCfu29AaJ+MSwG3LQmYhGEwUT0QyrbIEzzgC9eFuRR1OJtKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790770; c=relaxed/simple;
	bh=KvqZP5HO5EawiHIBOx01YdeNn/Nj7f2S/YfOLJ39SUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3znq6hqQta4Sg+bUSdFFrKMBTi8l5g+FYBHhkIFIdLJQ2UBPFc9o4UoL4k1RNywODJgp6eJ27/udbWC01fAz7NThzs9wkC6ngqKOnuOhz07aHPHpC/GN78NK5U6mJ2MZgJOhJBaKPZvut0Gw6cuIfkf2z7lJFdmZ/WIOBzhbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J4cYTTM2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuXmvL4J; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J4cYTTM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuXmvL4J"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6412FEC0120;
	Mon,  3 Aug 2026 16:59:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 03 Aug 2026 16:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785790767; x=1785877167; bh=8FSuIpff5G
	4frJNoLAW+UErDsysuoLYjdPcl2z0GFso=; b=J4cYTTM26SlWL2VzfZTAvUsRui
	B6yOmv6lLcb/J+GtmNdLPvD7g4n4WSAo7jgyAJDyZTFSkT72HAnO5VdPnH8JZ9fq
	MsPRwQEuBWfHblFTDrFC9G+8AD2FtpIhQDGiqDtuR+id5qJjVqW0CmgoP2UdaH/Z
	ySL1IuFG3oL4k5nlHhT4w7zFgeWQQJ0HBfNAbFqlYCUH1vEVnsr7uGZFWfqNQvbj
	xKkU3lOHkWF5GlclxfCaQefOrxoUTLTav6+x1pqgb4uSnux+GdExS9CajgVO0wTN
	46ZGgxivI5yi+tE8OB/aCgLFJAIEDP1zlZNl/bQwXfhxtRN8a6jajLBj5l8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785790767; x=1785877167; bh=8FSuIpff5G4frJNoLAW+UErDsysuoLYjdPc
	l2z0GFso=; b=fuXmvL4JWIaSUiZqNqvVBgljAb7/tM4G32bGtBdV1XqJs3X7wz2
	QN3ZHBADxki9rxw5N0cB142AQJ13dzbCHsOhBO/a6NlTGzbXwOo7WD083aJIdt1Q
	6TLsf2UpkmfOXl60WamM+JPyLrR3jdipf7HH5CnT5iJNwUhEO/IzQoH48uUG95Rf
	a6+1oft5GRUZUmHBXGETvYNRD1eXhaNdDk94AssR9F6phPLEVM2FYldL+QI+OEGv
	D6CVDuoO2z/8S+hlkwDMtkDh++x9v9W8snj81y81Iv+j+hL6FZsSdSDSxlv9exiD
	icQp0fyvhZ1W5p8zqhP2ocWy1sBV/qQKJIA==
X-ME-Sender: <xms:LwFxaqbKob6caHOZKmCiGtRSaOIW8l1yR-xqDA21vY9dPGe0Bdh9iw>
    <xme:LwFxakYtK68dg4VLmq4XuBXPW4IFslFGCmjqFFvFRof2zaeSs1RJVS4nUk6jb09qS
    H1I8lK8Djmj6QWKjrG95o9CGJaQulGGh7SLyLZMeWyfb1R1TlPymQ>
X-ME-Received: <xmr:LwFxap84gT6ShjwKoBfIVE1grKyO_Sg3Y673MS-7cv6LM5VHfTIsr4mU1EA6abtUXpfbYifg_PbHOvPOfpKRUBnJvY148xQoaA>
X-ME-Proxy-Cause: dmFkZTEXPWt4IDmppb0hhBwDmaLbWeAzU35xo8N9MzDscj+PSzRV93H8Tlc+aWmHNVZ7LA
    DyYr857nbqX2oVsvq5jwTnIyd9YoC0lgacBdCArCP5X0uDzfI7dey9Gm38fHU1Nh1xubF9
    Pj7Ie63VMH5uimwbce4brQ2bPJgNvWGdj4LzmOhw3kWYSPpE+/tax1aTZUR5dcVtEPV4Gt
    QZTXi4zQOsA+BToteIcLKwvakCRQLp+Sktfsq7Y4AY18xN03iBvV89aqUNDIhc+z7WuEiv
    98+lfd5rLeEE2TMQggNRsy3hz9cM70jSmomOB1A9cerJeMRTOAeq5QnbgecF/ZquMHJvWo
    3eXGqbDkC6cpgE/7j/ZiQPgE+miN//v4ufitF600OBA+7rx/UIAYc2Gl5jtQYrYXtsZLKz
    NziQPDgd22E/F5J4F7R1E3YuFtAHTnqF5qdmNflw8FzNkx38LOY8nz8oitvhIqRVQsi86z
    EuqpuUSbsXjsvFpNY1UROO73SP6ywumuKk6zI2PwhIQp2ROqsjfbb9lpaE3qXtmNjp24QN
    Arn1fr3OxKJWE37jRsCIOCpatWN3IF+nEBOY5+JIgc18IiSUXrlPQi4+OUpKLLQZ6jDeNX
    GwOFWB9W8vHPmaO06SM/Dn8VOKrxM6hoXVqRnKKxuW2BWlLW4QKSpdY9PA/A
X-ME-Proxy: <xmx:LwFxargDmKOifIP7Kluoo7qySIvAXxBMzHzhwCvohBv_w-lmZm9rfg>
    <xmx:LwFxahcb8uUNjuJlDpXyncNyohPL6v3MRePBcbOfORJfeoZdEhRY6g>
    <xmx:LwFxaqqANqa4O8wY-SROsBMz4inbjKpEkF7h48EtXtrZOSkPooeGDw>
    <xmx:LwFxauCXcE3H9U2rsxK_8NZfAi2V0RWPFCqDkuAxCivVB09qLt6Cdg>
    <xmx:LwFxape7ptcI9y-tLmYIXyo1tPWlbLARATr5QnuhdFvns4qOk26mHEU->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 16:59:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jamie Magee <jamie.magee@gmail.com>
Subject: Re: [PATCH] t0213: skip ancestry tests under user-mode emulation
In-Reply-To: <pull.2168.git.1783359242130.gitgitgadget@gmail.com> (Jamie Magee
	via GitGitGadget's message of "Mon, 06 Jul 2026 17:34:01 +0000")
References: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
Date: Mon, 03 Aug 2026 13:59:25 -0700
Message-ID: <xmqq8q6myl76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jamie Magee <jamie.magee@gmail.com>
>
> The tests added in 3c8c638df6 (t0213: add trace2 cmd_ancestry tests,
> 2026-02-13) expect the cmd_ancestry event to name "test-tool" and
> "git". On Linux those names come from the "comm" field of
> /proc/<pid>/stat. Under user-mode emulation (e.g. qemu-user) /proc
> reports the emulator ("qemu-riscv64") instead, so the event is still
> emitted, the TRACE2_ANCESTRY probe enables the tests, and tests 2-5
> fail even though they pass on native riscv64.
>
> Require the probe to see "test-tool" in the ancestry of a test-tool
> spawned from test-tool, so the tests skip when the names are unreliable.
>
> Cc: Matthew John Cheetham <mjcheetham@outlook.com>
> Signed-off-by: Jamie Magee <jamie.magee@gmail.com>
> ---
>     t0213: skip ancestry tests under user-mode emulation

While nobody with similar environment that would benefit from this
change has stepped up since this patch was posted almost a month
ago (and I do not have such an environment to test it on, either),
this seems low impact enough to cause regressions in environments
where the change does not intend to affect (i.e., native environments
where process names are trustworthy).

So I am tempted to merge this down, only if it is to shrink the
number of in-flight topics I have to carry and watch out for
updates, as nobody seems to be motivated enough to recruit testers
or reviewers to move the topic forward.

Those who are not in the user-mode emulation environment and are
negatively affected because this patch drops TRACE2_ANCESTRY from
your envionment should block me with a real review on the patch,
preferrably with suggested improvements.

Thanks.
