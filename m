Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0823DEB6
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524173; cv=none; b=WA1JiGbWYrmQNZbjLtH2WOGZH/kHZl89Owy5sgQRMOmbe7fOmkPuK/fI1ycjlb0exbU4gnRz4A8TOREAKLvrtyC2dUlpAP72xt77JMLYC2hItWNX9qmqvQEV2U4jmuIDj0ITDZYNRF8hmQl99mmHp6ly1idl+R/JDtSN6H7hp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524173; c=relaxed/simple;
	bh=HoZ/lS1oUaJpkiNWQOdpQPZZq33ybp0Z6hqDZ5ZdRdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXJ5RP4OYLc3N3zD0sTSQK+VauNdCeKT1b86U1mGiE26xJak4omedxALJLRgBM7X8w5O6Zou7AGE9Ql8xC7yvNLqsn+u4xNFlX7WA+Fqd08YrgZVkhdtS4Q4m/sS5gf3XBdbHFUs3vNMZVnAvR93afa2jhHbjjbwwXXHqeIeViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+XWlFiL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtrxyyjA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+XWlFiL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtrxyyjA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C261140011F;
	Fri,  3 Oct 2025 16:42:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 03 Oct 2025 16:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759524171;
	 x=1759610571; bh=HUQxDDomveCmrdJtruIbl2YG7oZUmLC6g8JKrXanspI=; b=
	E+XWlFiLxQkGIF3iP1AEh0IAwHHjtvhgHmJrX2hqMvBf43taY6Kxr9o/fSdgutNG
	O8EVNNTex8GimRo6jX8ho874Ph6G+UxFRteoeUNNOMalntXLYx6+m0ImBJ+7ASZa
	piL0KOdc3baargiwqpoUAQdegJED7uQzxGmS3tXNX3bg/Z374YDcHzjviNgvl9WM
	w4cHQhgjvNvQvwEKYe9cI0mqgsIg5+oHJckChlKR5YWxuVCVPLdodMqhfQoX1JQX
	7pM3BMqvZ1poTE7ZFt+QtVS6TQhrljvZAjKXpIKbb+xqn8uPvgAuOfmYYuUrPW41
	EGgoxLeJMs35AK6/0OjIlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759524171; x=
	1759610571; bh=HUQxDDomveCmrdJtruIbl2YG7oZUmLC6g8JKrXanspI=; b=E
	trxyyjAn41DqZWSYnOHFGGcB097K4QcYFMMrlCfxMcgomTMUuOzf0/arkSEC54tn
	Ma2mbde7CurJX1Cawa+4Mw/4hbKYh2axq8PvMNYPlNOvctjI2lXk2TPLdj9kNLCd
	KU7FW2IgY8l0Hfs5LpmUNjXpYCo48LBxiXBFVrwBa2LDlVTHmej1HRl+mDTmf/tS
	CtvegUhWhF1QgdTKMkdehkDozgTliLDJBwoemPQ3qFL41qgFrWLc7Zi/QwKZxRWA
	GoGMazAbZABqIC/KjrgOiPuDm0kUVLbDKjquLJzLtCJgVBHXZ8Z0NnP07177LHik
	S7xm/uVjWSqy8s4kP6x2A==
X-ME-Sender: <xms:SjXgaDSLQtIiGBVdIADknjrE1YKNsE_usoIGpgU3uPC9TJM1hhk9zw>
    <xme:SjXgaLy9hB6DtkepxvCJovFxjErawJq-Q38a9hDbB1rEb-7GFR75L8bZx5qLrJMXd
    x6KOMlsoEK63Qku-vi3_FMx50qzooIljC6ZyWzDw0hELHVTROytDZY>
X-ME-Received: <xmr:SjXgaN2-NaDH27A_3OBo65rlhGxJIq6uOMFNktpTlxszC7HwHkSECC6pBk5c4NHzMR0QwawZpuzcAASOxADqafpycSgMnNhhsVp6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepuh
    drfihinhgulhesuhhkrhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SjXgaB7gOPMoaAWC17XP82jbdLwXsUexeI8Ruo6VkTatFD6yGgh9Vw>
    <xmx:SjXgaIWWe_VyXIffau4Y3lz76PeGqboUEXRhbXdo4-5oAjliwDKZUg>
    <xmx:SjXgaIDiDPYd9yaMwv649lFhgFUxfSdGBJ-sGOa9eARUj4AWNCM4aQ>
    <xmx:SjXgaP6D5qxAfwOEw8bnqVivjH4KcS18hnvtLXNFaQTiKFJB-iptrA>
    <xmx:SzXgaOwtTb7OR5_0Cj5twVpn6s_-_CbWL_Got056AAyVyqtZjePsWlzb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 16:42:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
In-Reply-To: <737e78f5-6337-4964-8385-9c35897f5dff@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 3 Oct 2025 21:53:00 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
	<xmqqo6qoufqp.fsf@gitster.g>
	<737e78f5-6337-4964-8385-9c35897f5dff@web.de>
Date: Fri, 03 Oct 2025 13:42:49 -0700
Message-ID: <xmqq8qhru37a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 10/3/25 6:11 PM, Junio C Hamano wrote:
>> René Scharfe <l.s.r@web.de> writes:
>> 
>>> git add --patch presents diff hunks one after the other, asking whether
>>> to add them.  If we mark some as undecided, e.g. with J, then it will
>> 
>> Perhaps "mark" -> "leave".
>> 
>> I somehow find it awkward to say "mark as undecided", as I have
>> always viewed J/K as a way to skip a hunk, leaving it undecided.
>> 
>> Besides, "J" lets you revisit a hunk that you earlier have decided
>> to use of hold off, and it leaves your last decision on that hunk.
>> A statement that implies "J marks as undecided" is misleading.
>
> Right, j/J/k/K leave the use/skip/undecided status of the current hunk
> unchanged.

Yes.  If the one you are walking away with 'J' were already
selected, the scenario you describe in the proposed log message
would not work, so "mark" -> "leave" is the right thing to do in
that context.  But ...

> "leave this hunk undecided" in the documentation is
> misleading as well, because these options will not leave a hunk
> undecided if we made a decision on it before:

... as you say, I agree that your updated version

>                j - go to next undecided hunk
>                J - go to next hunk
>                k - go to previous undecided hunk
>                K - go to previous hunk

in the documentation or help would be a good change.

> Weird that one can switch between use and skip, but there's no
> way to revert back to undecided.

Another thing that is missing (and these two are not a regression in
the C version, but the same in my scripted original) is that once
you decided on _all_ hunks of a file, there is no way to come back
and tell the tool that you changed your mind.
