Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397A51022
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161440; cv=none; b=sDsbNlBCJ8EdlnCLsIgXldkthnp7nLBpqIGvUXZLAISUfiIpQr5/aq616UvoYizkwqJrTpavTefcDoyPMsdrE0C1zLRZOez1gOWUbCFPQR/sKSdn7I29eY0L0QFgaTA+Qnkz5w/rH3h/SC6/XcJLBxw3cm8PbxCpJXt2wgIof4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161440; c=relaxed/simple;
	bh=ctDx/fL0BrNhmu6aBqHRuEYg43L5vxzrIj1iEhtdAR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7TtN3tc5j4Fzwx+l4XU9s3UD45VqsDI3yUFFhVNP5+X4SXsgkCLbcAhVEMWFwXu68ee6LvJvyAJ4NBTJqDxbVsRg7fDDcuj7tZPExttYC0KkzpPzmO57to5Fau/FHl1u0eizXANnGQavxjiQQvZUYXQUoJU2Rhtj1dlPezmaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XnP9Qn95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dacvrYMA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XnP9Qn95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dacvrYMA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1894E1D00262;
	Thu, 10 Jul 2025 11:30:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 10 Jul 2025 11:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752161433;
	 x=1752247833; bh=Vdfu9s5BbwIlU+i/RhzSAXuEom5vhwS8cNW6e6QSf2w=; b=
	XnP9Qn95HxFCE1rpyoQ+f7xTByJ+KqIv6NxGcM+y9U917qKBo+vQkyS7GHwdIKdi
	jf9mJ4oYnUKJfkivI1EXpIQ0iXJ8/GhBCxCKp6UogzU/NlPZvZVue3pr72hEH8VB
	RuUN265ov0xT03rELfiJVmIXC43xX9ILedjqisaNeHpAEbTtQGLV0uLDPvDqOm26
	1Bfp80/d0rvRY9zLfdh9K7+NI2FbCaLMV2Y3cknttSz/fvUz0O8eYoD5esweo4/l
	/WkGwUgdYe7Vo9F2pstQOdBzvCt5qmQIYHzLPZ0/Wg332vDlB9l6ErRhLedirDpp
	Zh3eY+vgvZrevKM6EmgnVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752161433; x=
	1752247833; bh=Vdfu9s5BbwIlU+i/RhzSAXuEom5vhwS8cNW6e6QSf2w=; b=d
	acvrYMAvr+1fNXjnD1M5U4PM7mAbFL1AweRaylxD1D/u5NhnGhI7M+cw/PEpC62E
	PENIXW0fFQilFnAw6PGlvK1Pu3wuvJVGyc/iZASmp4lUESdEbfSeAepE6XWP/Eie
	EZIBRRSUNIT2bjd/PNo+xHXCwT/qReq69sk89JLOrPe/gHNi5wEnWFip8z6cIA0V
	Ng6S9CjIErsSVjbMg3e+fbA5RWkWF+GjqsqNYevVjH+QNMrr2wZB9HKsxMKzBN9e
	x/oIUq4k5UHoMSlsmfeSbLMTB1IoGsTs1wlhrp63SoJUuJZnD2ldQK9Qi5XqE3LS
	dseEMfV6VLkkQieQQ8yfQ==
X-ME-Sender: <xms:mdxvaEqpB0hp9521kKTdP8GF4QwgKY2dFQbsT0KrW9WC7CyRSMMacQ>
    <xme:mdxvaGIjpmy7BE0IF_BDic3KNMrriK0PD3Y_xa4_rpVrZi7JwVNnfOJCzfKiVyBHa
    gN5bq1vh4kScWONaQ>
X-ME-Received: <xmr:mdxvaPpGgKaw4T0pW0btLIdXKEvfspuUhPmpO6767Sn-lKM9TALweoNgI76-eELOKlG51LYnUalF2sRF6XVpsrlcQcaveLNT6E3KN-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mdxvaGyR8JNe3ycitMX-f039vJSRL0ULoQl46P-uFZbYfiGYIlQiUQ>
    <xmx:mdxvaLNModuWDiF0igeCtAZh_1PAY_GIXBNPlN52I5Uc1vm_Ya_4Ew>
    <xmx:mdxvaD7C07MVGVltmb7oXbD2UWvYGkmqeJHynDw6l8aCtiZFXZ3bxA>
    <xmx:mdxvaMmpRp5T8BmaimaE8_qF6EGmIBZG7euaxUGJCo66AFkcR6nRvA>
    <xmx:mdxvaMJyuk86iJgoNQaMRpe7oJAPyt1-e10iOzG9ET9LEhFvz_6rrcDJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 11:30:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  git@vger.kernel.org,
  phillip.wood123@gmail.com
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
In-Reply-To: <51208670-eccc-493f-8a60-2bc9e3a70801@kdbg.org> (Johannes Sixt's
	message of "Thu, 10 Jul 2025 09:18:04 +0200")
References: <xmqqplebzgm7.fsf@gitster.g>
	<vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
	<668ce4d4-3b60-47e0-a4a5-dbf73efd1e75@kdbg.org>
	<tuglsm3r64mkgzdh2zdrewpzydz7xmyatqxwbbzpqmltwseefc@65cbcs3pq2qg>
	<51208670-eccc-493f-8a60-2bc9e3a70801@kdbg.org>
Date: Thu, 10 Jul 2025 08:30:31 -0700
Message-ID: <xmqqqzyo83mw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:

> Am 10.07.25 um 06:25 schrieb Carlo Marcelo Arenas Belón:
>> In d28250654f (Windows: Fix signal numbers, 2009-01-22), the value for
>> SIGCHLD was changed from 0 to 17 mentioning some sort of POSIX system.
>> 
>> the relevance comes that if I build a program in Windows that calls
>> `signal(SIGCHLD)` using that number I get an error back, but nothing
>> on errno, but if the number would be instead 20, like in Cygwin/macOS
>> suddenly the behaviour changes and we get the expected EINVAL(20) in errno.
>
>> So do you have any objection on changing the value (which should be otherwise
>> unused, and irrelevanted as you pointed out) to 20 then?
>
> I do not object to change the number. Nevertheless, I would like to
> understand why it makes a difference.

Yeah, whoever writes the commit that changes the value needs to
explain why the change matters, and where the differences come from
in the proposed log message.

Thanks, all.


