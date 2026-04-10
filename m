Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE61DD877
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832774; cv=none; b=c/hQGi8F3GhG07igb0odkQyYvPD2+DvAFbiAvpCr4l4mq0s5u4/eG+BoGD5JcY9oTlLQvd4p2iMbhn1hD6UCwlc9pHe3Zuoar1J8TrKAkSKEMEf616IOTA4++SIT5w0F29PXmjooe/JJiTY11MxC2YRiA/oZGc4pJtMxMteqS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832774; c=relaxed/simple;
	bh=T/OvpulrpmTCBWv7HeoikgsdAhPIvPhhgxrt+mWs/pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N4C15K3JLTuXrbirb2mifNu670KnCIiM9oYs2yJ6oyVcyudbAJF78g3gYeRtnArEYp9vZ/+aW0Ofs3rsNlZxbXieD1WF7r5AxdmCw6ECgy6ZMKU2ZGa6GAW/OZPgEEeE893zaXLeqbaL3k7TcoZ2Sia+jqd2eqwExEoL7SMfCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=utAwhbK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pActRThW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="utAwhbK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pActRThW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF301140013A;
	Fri, 10 Apr 2026 10:52:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 10:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775832771; x=1775919171; bh=TXihBirwZW
	Ey+2FM/cTevlJgm7idLkpzciPBHCds7rU=; b=utAwhbK1QlAx0zpNKQJVvOqXJb
	Tg/J84LtkIj3KOdtj51MykPR77NKP3AzWwJwiXg0arEyUdft1hV8vBfLLgB3LvxJ
	1+IcjKZkrKM5/GIYGHJ/6aJEDmC3r7m5Y7NRq3AQJwmRRqyUwFwAakscf8oeCWlY
	h86B5ToPx6Zy4igEJhiODC29gSxsuotAg9afTp5mx5EwBMpuR0ZrpuK86idko/U3
	R+V+gL60/pevUknLsRLOS3FXFFQg/cwcrKDzR/hNuwaW0gsUMNumi/AAgriZVrnl
	ZDgzCaYXFARVU6qy8r++fg94QIaDTTQ0TQBTOnNh4Az0TIyEvaPLMvbOZudQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775832771; x=1775919171; bh=TXihBirwZWEy+2FM/cTevlJgm7idLkpzciP
	BHCds7rU=; b=pActRThWyZ/Oa0zwjNtzxS6uMYFQcVRnM0jWtBOUskDGvyG1+I3
	NndeYMPYG0F4MRpDS0Se9lNXm80jLgGKE/m1cD5wdidMjBxAArNB7oOSC8fbKgtz
	qhMPzvRTpb1ke9dfdq2Y4MnvFyq7rHN1XyDdOXCgzxNWe3lLkrVcVqkKRQiLEL8q
	AuuSNQp2+/uueKiCPXBlN40zz9zeDHPGvT5YXPGoMDnIuSwhlcePv6PvqxJT4xoo
	MTladtP6B7dGOtO+5H7IqWPDTW0A+XqXAGltsWvVCyM7amMVYEjikhzzltRT7vGV
	aZO6ItgoAvDk5w4LCDaZcWZ3xLtcJ2gwPcw==
X-ME-Sender: <xms:ww7ZaQ08VlMu4McsDQpwsHrVPh2-0LNlAlL-Q2zAOf6hpzIIl6_JTg>
    <xme:ww7ZaeyAGI8Vwhpv_lgYPVxLm7KmnPvFwvLg4y8ieyMtz6PwDWyO7wFVvbSqIu-AP
    pFLPt7TrZ3M-b57XkjCRt_9u2XJX6lil4I_DvSRq86qHRfnwDEYIg>
X-ME-Received: <xmr:ww7ZaStHlrv4sl9KY_9lNsQmTIzpwDdWTOP5J5cr-8iuHIjxSDs7bpjhFJEkdVJvnh0v8uPskManx9fvnon9_0QmGS2ryk0NBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ww7ZaQxffqxsmO6nx43t9i10rOV8PW91LDhxT0jqXv6reb2sBYZiaA>
    <xmx:ww7ZaVAPuWgbMqvJcEh7FXsHCo_lqqV94m4bpLNLvNZbRpdMP_ZcHg>
    <xmx:ww7ZaeeDfefhid9rbve1gwxFUTmUl170ip0_Fx-6LQSVFcyIkZ7ysA>
    <xmx:ww7Zafkp702tPM-wY2JCSWVj1-KwyV6NRp6KbcPifwXjO9Fmso-cYQ>
    <xmx:ww7ZaYg_A8FEn9NjkUkDGNM2As-N7iT9mDP9tzFJo57GAfkinxd586Zg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 10:52:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re*: [PATCH v2 0/4] Enable Rust by default
In-Reply-To: <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com> (Derrick
	Stolee's message of "Fri, 10 Apr 2026 09:02:13 -0400")
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
	<4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
Date: Fri, 10 Apr 2026 07:52:50 -0700
Message-ID: <xmqqa4varhod.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/9/2026 6:44 PM, brian m. carlson wrote:
>> Our breaking changes document said that we would enable Rust support by
>> default in Git 2.53, while still leaving the ability for it to be
>> disabled.  Unfortunately, we forgot to do that and my time machine is
>> broken right now, so this series sets it up for Git 2.54.
>
> I'm glad you're remembering to help us follow through on this promise.
>
> However, I'm worried that we shouldn't do this change during the rc
> window for 2.54.0. Perhaps we could get a small patch that updates the
> docs to say "we really mean 2.55.0" that lands in the 2.54.0 release,
> and then we merge the requirements for the build in the first batch
> after the release.
>
> This would give us a full release cycle to simmer with the requirement
> instead of slipping it in for the last rc.

Yes, let's do that.

I thought that leaving a bit of wiggle room like this:

  2. In Git 2.55 (or later, if the codebase and the world is not yet ready by then),
     both build systems will default-enable support for Rust.

might not be a bad idea, but during the -rc period, simpler the better.

----- >8 -----
Subject: rust: we are way beyond 2.53

Earlier we timelined that we'd tune our build procedures to build
with Rust by default in Git 2.53, but we are already in prerelease
freeze for 2.54 now.  Update the BreakingChanges document to delay
it until Git 2.55 (slated for the end of June 2026).

Noticed-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/BreakingChanges.adoc w/Documentation/BreakingChanges.adoc
index f814450d2f..af59c43f42 100644
--- c/Documentation/BreakingChanges.adoc
+++ w/Documentation/BreakingChanges.adoc
@@ -190,7 +190,7 @@ milestones for the introduction of Rust:
 1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
    disabled in our Makefile so that the project can sort out the initial
    infrastructure.
-2. In Git 2.53, both build systems will default-enable support for Rust.
+2. In Git 2.55, both build systems will default-enable support for Rust.
    Consequently, builds will break by default if Rust is not available on the
    build host. The use of Rust can still be explicitly disabled via build
    flags.
