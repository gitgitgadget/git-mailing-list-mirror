Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84865383
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751950997; cv=none; b=MR9A6Fn05s/yxvQ57qFqGWgvMrPbY8FVaNZHSQeXPqVE88rskssaoi1lEcBFICaZGjn5MoSCN3ZI4FELP6rYNmiNWyf7WuL0cyUA4Fi3/6B+QSOA6COCA5R2AUZP4FAYeA4ziPxqJpbqYiYXIb4Fab5Pzl2WenfVCZlLot3+UEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751950997; c=relaxed/simple;
	bh=GK5PfZRnbyyNTWmyKKvZQ6m7pU5thTNSFWlns2kkWDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDyNxLAI2hR8dhMobt8Mv3jxR1Zx8Y2WevUBKmJAj1O4xrFYdb9/hJrLEi/gftUS0xKERovMJo+hedReS35tmdWttbwIFtJo0rTrq3hI+E63jF3gTCCl3XRCrD9ztd030C1RpgO/jyJa30MC2lc0sfvy1ld0cy6XK35oI924wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IfvH5CKw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7VUHbFd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfvH5CKw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7VUHbFd"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B4CAFEC0235;
	Tue,  8 Jul 2025 01:03:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 01:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751950994;
	 x=1752037394; bh=5iaVpVr7pIf8GMaM6vLLWPkvcT/2QmZ9lTDWjsP82RM=; b=
	IfvH5CKwS6etghQT4KrlWOVZtLSceiWA2xGVXiCpTF+2U7QCtybcDZbpcLrRiJXf
	R8Pl0QD4296y/5wNt5bL4ZiGcFlwDmgB10JlckHMDvlFHG/ODET0meSXZGg0lOTo
	bSCBRirjCePxhhbXbMvbzRYu3oyID8DLaWWCoPkw3f7XqGTrmfoUIQ7f9ueIjgWJ
	HjncPZzLDgD9MdtphSUryhO4r/MOKpeVWHj4YlD9pneT8kKvN7irI3qqQf1YqrRh
	OvtV8w/ghWAl5Ye4+XbEKGesXsmM5X+AEbcWWDGAdwghQ1H+tIUElgsIyJ0oaxkf
	VktQYmS2oL88DD71nX2l7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751950994; x=
	1752037394; bh=5iaVpVr7pIf8GMaM6vLLWPkvcT/2QmZ9lTDWjsP82RM=; b=X
	7VUHbFdrLSOJWkskvKfhYUYT8q3ysJluGjAF4XnlYWK/Qy7OtbbJgFfcY0jSOzJS
	FOcSgONbXtZvKW22+HT0GLmFmaBebHlo2wJTlshXLXIZ833OVfaYZg4wfCaBOQtf
	di9y7aZDMWc7c72LbFjH9ep7rN7YWgXNiOfThZmCUJela6k2fEwTfLw9zxJsrAWt
	6BNXZ/isKQ4sEA67GJAQk5LsOhPigw29pdAgtsY1qgSGh7zXKVeC3VQTKOJ/8QA/
	8efrdjAEOjUK0+/elaqwi/CTqu2SyZq59Ir6F+YK7Zzy3HFmLoJ597yR0qGTKFjl
	xFKkfC4sxoHA4yvYwSJqw==
X-ME-Sender: <xms:kqZsaOty6PaxdMcWJDD-HyIULXeDnuuFDzz-jfDQ34mdr5qxm8Wx-w>
    <xme:kqZsaAXl-TnFSaYcSwctWFgFheTOeTlWT-qg-dS-iDZyLKn6-D9Qc-HrM0YbDeRpP
    aUbxwLxyeb6qCfThg>
X-ME-Received: <xmr:kqZsaJi2UbcsMoqprnB0yIqOJaqNczIgK4AzUgWkqUNq_bDgCgnsqvzQmoYUzZUmUewHsfp6qjtveDBzQf32I2N2EqVlXTqigsqJ_b4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:kqZsaIp-dx2j78QGNXgZ0spzgXvUOaoDs-5g2MZu5AEpLArQ0f8Mcw>
    <xmx:kqZsaPGSakzYIsq2ZIAGHpW3J6B8l0JrJ-8TG3NS3Lagp6tzLMczEA>
    <xmx:kqZsaN4SmIZamROt3CpdsL9GY6_k2CjBDgi42Bn_eOtI-0kUG22q9w>
    <xmx:kqZsaHdjJ1Aw0oWz3nqlB0cH6M_IB_6Anx-dZXY9AGFnTh21H5ToAA>
    <xmx:kqZsaBY9aMN-zf34Gh-nwXJnsj73Fx8lvzVeHAYYnYLIwKrt7LxwswFM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 01:03:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
	(Christian Couder's message of "Tue, 8 Jul 2025 05:35:47 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
	<xmqqbjpv1ucb.fsf@gitster.g>
	<CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
Date: Mon, 07 Jul 2025 22:03:12 -0700
Message-ID: <xmqqwm8jxoj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jul 8, 2025 at 12:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > This v4 is just about fixing a few bugs in the tests using the SHA-256
>> > object format compared to the v3. (I had issues with CI tests on v3,
>> > so I sent it without waiting for the results.)
>>
>> We haven't heard much after a few comments were posted on this
>> latest round, since Elijah's
>> <20250619133630.727274-1-christian.couder@gmail.com>; I understand
>> that it would be the author's turn to respond (the response does not
>> necessarily have to be with an updated iteration).  If so, let me
>> mark the topic as Stalled in the draft of the latest issue of the
>> "What's cooking" report.
>
> I will hopefully send a v5 later today.

Thanks.

By the way, I noticed that you often do not respond to reviews until
the last minute, at the same time as when you send your next
iteration, or even soon after doing so.

That is quite different from how other contributors operate, i.e.
respond and engage in discussions triggered by the reviews, and
after people involved in discussion got an (even rough) idea of what
the right next step would be, if not a total consensus, send the
next iteration.

I do not know which style is more efficient form of cooperation, but
it somewhat makes my job harder, if I do not hear much _heartbeats_
after I see review comments on the list.  I do not mind waiting for
seeing the next round for quite a while---after all, any substantial
(re)work takes time.  And responding to reviews may need thinking
things through carefully, which may take some time, so I would not
demand an immediate response, either.  But it would be nearly
impossible to feel the current status of such a topic---a few review
comments are seen, the author goes silent for a while, we cannot
tell if the author is working on a new iteration or where the author
and reviewers agree and disagree.

Also a review response that comes at the same time or immediately
after a new iteration is already sent out makes it look like the
author is refusing to continue discussion and reviewers are not
welcome to make follow-up suggestions during such a discussion.

Instead, the next iteration comes as a fait accompli, and makes it
less useful to continue the review discussion on the previous round
by responding to such a late response.

