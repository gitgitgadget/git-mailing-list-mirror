Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2D8F5B
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682121; cv=none; b=p/J8bsbhIYveVnRHUg1ESsPunrlJvVGbCldoJJD8R3LkN0MammUTMXIs2Zghw9X0vjXfJLmCMY0b2nj85dCud3szfMb5qqmlCGS97cXiy5dYzdM0Moimj+HyWqQyd0+yGgibhQDdVL62vK8pG8D1QzVVs5YckGta1Woym1RC7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682121; c=relaxed/simple;
	bh=pEbbkeeXafizcHBnXiHVpuHhoaWw44NLrBDqM6ATawI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jblc7DUy4TwQgwXBukiRiaKNyfs9y3qlwL/6ESuCVtMpmftjHKfLAkk0OYlxJrNdtC3BmyTKNQUALODFa8gHmjEqYYf/b+aRGyGEZVPhbhLmlMNxa7xKRP0jjgycFGZjsgBrhGKawp3ISEl0ld7OIrEzlLb2OnwF2WsCM61cQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T0gPI2pL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kN6Ynov3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T0gPI2pL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kN6Ynov3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7173F138025A;
	Fri, 11 Oct 2024 17:28:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 11 Oct 2024 17:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728682118;
	 x=1728768518; bh=9Scxt7zozNevNgIj0kbju5/39njwVgHUcMIHW1Kf9hs=; b=
	T0gPI2pL2vb2XZA9taDeGstIC8d+mi7m29aJbv8x8AgkEzEaaxEcq8HtAvlZhC/s
	3Bt+UjMWlxb1YuBH7nPoVZWq8UwYxNyuQeAxiEucbBUkpmgBJE2oCuRhJTJfXNVf
	T+Hhtuo24SomoO76v1UmEZIR0lRHD4CeRxVMw90kWvsCpbPJuqfE2WQoax7gAZvv
	NU3Z9ixxiSN2kTwDFlj63GJHoAlfMsazcHwfxeAh+UU+xgXyH5pDs+SR+VniLzTT
	+SVPzigUSdoApH56Ls/HVqeiYbcrwX7gPLH3Pm7/zyY7WAe1NVhRYDfQsIjIWLGC
	qAq8jPuqVvL6pldmqy8sHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728682118; x=
	1728768518; bh=9Scxt7zozNevNgIj0kbju5/39njwVgHUcMIHW1Kf9hs=; b=k
	N6Ynov3QeEqzH9Ya8MfE3cKKTobdRp6sxb1NmmRkXx1zOkmRoDUL7sAQycVutAwQ
	CUNHDSA/FMJBXaKWEX/pgUX2oMsml2AA+UbmLz7ZcbDqKQoS8tTw2VR3IAZmN/aO
	UyOYE7j1xhQuwG7Eqs3yF6oc72sJwmvLlm0vn1BGl6VXLrJECv/v7jOm0WkQsqBK
	ckQG9Mes0+2ahI4YZTKgXGKXdzq/FRYy7mwSQzUTmA9ZISxLiE8gYE+2k6v9oXHB
	cwfpikFKZmn/6f9w7RPe0jc9cv9hl119KhLkUdOEvtQyMyCdzijdgmYKIOv6l9LF
	2fFdCARdmv1tJtFTCNJQw==
X-ME-Sender: <xms:hpgJZy-ihOfKIKzEoDzqtQxCGVK-g0sqjR_uO13ipattnhGKKWLBMw>
    <xme:hpgJZytkeUqdTlFg5S7i5QVSdC8ogoTBB_QoIaYZJL7exp1XQ4e8KQdpMvTEYpdLB
    P1HtQFntl6f2L7aZw>
X-ME-Received: <xmr:hpgJZ4Cgsl7MDRxmOwrDnpRDL6WFKHXj1j3m9K7OJ53fBKtR7ZqlISmIVBIGIiSOdxKKfLkCg0kxlh3GAUBjucrk0VXurVF78kbBRsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfh
    gvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hpgJZ6fCJAm6nYc8FmbevZOvdOmMYh-t23ajt_bsRHwbbt4a6tSsnw>
    <xmx:hpgJZ3OvwGvJiQJcZ3ixiP8fjblnl2DoJOZOPBc0b_UAAnnbx-9qfQ>
    <xmx:hpgJZ0milvep_30MVSul3glA8A72LkkuWTXWyYYOUbd8y8phwwo_KQ>
    <xmx:hpgJZ5tA2hwK_SI2vyBJcZeIFOLXXG7THC8rnEn3H1_Vcw1LT3VpUA>
    <xmx:hpgJZ8onmzaGf1D7NfU2gfg4kRqCjkrxwq7Rjwr0z1LqFywCWICd7X6c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 17:28:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  <git@vger.kernel.org>
Subject: Re: with git update-ref?
In-Reply-To: <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> (Bence Ferdinandy's
	message of "Fri, 11 Oct 2024 23:04:17 +0200")
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
	<cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
	<D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com>
Date: Fri, 11 Oct 2024 14:28:36 -0700
Message-ID: <xmqqa5facosb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> On Fri Oct 11, 2024 at 22:56, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com> wrote:
>> `ref: refs/remotes/origin/test`? (space after colon)
>
> I tried a couple of variations and no:
>
> ❯ git update-ref --no-deref refs/remotes/origin/HEAD 'ref: refs/remotes/origin/test'
> fatal: ref: refs/remotes/origin/test: not a valid SHA1
> ❯ git update-ref refs/remotes/origin/HEAD 'ref: refs/remotes/origin/test'
> fatal: ref: refs/remotes/origin/test: not a valid SHA1
> ❯ git update-ref --no-deref refs/remotes/origin/HEAD 'ref:refs/remotes/origin/test'
> fatal: ref:refs/remotes/origin/test: not a valid SHA1
> ❯ git update-ref  refs/remotes/origin/HEAD 'ref:refs/remotes/origin/test'
> fatal: ref:refs/remotes/origin/test: not a valid SHA1
>
> I guess the intended way of doing this is via git symbolic-ref anyway, but I'm
> curious if this should work somehow or I'm misinterpreting the meaning of that
> sentence.

I do not think update-ref is a tool to modify a symbolic-ref.
Moreover, the mention of "ref:" is meant to be for those who are
overly curious for their own good and go peek into their .git/
directory; script writers should not have to know such an
implementation detail.

: ask what the current state is.
$ git symbolic-ref refs/remotes/origin/HEAD
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref

: set it
$ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main

: inspect the result
$ git symbolic-ref refs/remotes/origin/HEAD
refs/remotes/origin/master

Thanks.
