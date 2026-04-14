Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32237E2E9
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201063; cv=none; b=Z7i2bL4+sdgTklyJ9YlkaF1ngRFpxkkLG8/xXKzZOXJ+9oZUERAtC7cfTNqN1nO6x1aUBSPBdg/GbvbqH+IaQM49JTYe8CwODiO60ho0z/TyW339DYcyvGwGOdSR4HDRcAay5sMOcpOpi7FqAHyzO+RFkUNUW2YguN+sOWxiEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201063; c=relaxed/simple;
	bh=AYMfMRKtkV8oGkjSu6828YGcRKCwBJs8Kc3+dOZagJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ngWVsuNJNkUuw1FZlE/01bGVvtHvZQ+hBySBEBcHGFpccfgy3+j/U1U6/wk6K8WUcOOpF8+M1gXgT92QnRObapPIJItj047YH1eGra2UZuBppiuxK/PjuTajf36hrQYDTmyrBBRs5TViy1uOfJ6vU6x+OkVaRUC+PecsgT1H19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KdshmVRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiWMPFjB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KdshmVRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiWMPFjB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3AEE1400060;
	Tue, 14 Apr 2026 17:11:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 17:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776201061;
	 x=1776287461; bh=tYckdqKNPNlmzmZWFKKTHi+5cUkpO9N1yp5t7W2E6z8=; b=
	KdshmVRuBBd6WZtIrnDxfTsJrBYDJ+PIb1QbycqIUTZw/Cmw/7I9UoKNDC8gG81M
	ikpABSuHQEQIA2vBou84P7Oic5SKX0SIQX9p3gGt7/U+yJbIWhw1HYyOOUll+hSo
	kQpBGYjz9vvDm8JT4nBfyNBvg2Ec1e6GZ6a2wYw2VicQH+B2T5DFwOKJ++kC9N1H
	Zi1V0+oPAeGMpm+PD2uR9DnGwkQH3m32x8uP/wkP7f4BmHRW+8+m8k8ZUZkqH+rP
	iGHLrJsj6aI/9zisk9coCHYkPahdNm5vxmzt5vLRkbjuc0SDsH28Lz3x27FNpPkD
	UlC607Hu5vcMY4+x8sRR+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776201061; x=
	1776287461; bh=tYckdqKNPNlmzmZWFKKTHi+5cUkpO9N1yp5t7W2E6z8=; b=D
	iWMPFjBvTJOkmQ5cMdorJqp04XKHrkH5FnNXzSlT3RdBC1tLyxj0dBPhjT0osiPp
	CwX1vcrqIlNeZR41oHhIf0HYRjoJc1U9zOjn3R4EcXzdQS6IhVq5i1oGDTU76vMK
	/HYIg/CqH1dn98xw8AEwXJG7I2guZBhVJF+KLzFUi7z/u04J7F1wRoods95S9bwl
	Zysw1ao/YH64h9YUiadXxjGZ9yEDxNWeCt8ElEeRIZaCCL073AvaTvZLmwCgzh8V
	niYS2mcAdwb8q5XxSt1J6r1Bl7EhfRS4ZUKXlH7jXahp4z8kYc/OTKkH17wXKccr
	n6CptnczNONuKQnQcoRbQ==
X-ME-Sender: <xms:Za3eaSM2p_i7VkMlMPDqSUTAh-vefzNdtaDo9MuaQ0EQRN9TRmrZBQ>
    <xme:Za3eaX1lRncKoD3ZygeFYqPlRAh4ExA0zcMaonKA4shr85T1rB6B5ig4Aw68CZnrX
    PL5dUQVGd7P6QH2ctM7XgShBixoqnsUDc7W_ak9lHM4iOb72ONG0w>
X-ME-Received: <xmr:Za3eaRkXdqAw6ny98pt3taiqjFHsWTJP68gKzacGmWLYtONPuwFt0TifWaRpqEdmwlPHbWD5TCC41IEeAC1QQFLzXiXqSYrRTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeeihfdvkeehgfdvhefglefhvefhtdejjeeghedvjedufeelledthedvhfej
    hedvnecuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhurdguvghnthhonhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Za3eaeV1tekj9HuyTRPhiGB8LtAtuYwN4m-5pihZqNBg9hxgUR-4kA>
    <xmx:Za3eaXutYAREshkHDl5pMSSHSAtWaI9NgKzmpl78WUzsHJgZU5L-hA>
    <xmx:Za3eaRa5ZlRTTa445P6N1zNJI30n-ReqSQuptr5p9SjVi0uQYNmVrg>
    <xmx:Za3eaWXah0SKvVM5_--4kNWtrsx6jp8kR2deWtvPiPpf2TcEnQ6iwg>
    <xmx:Za3eaYjKp7eILRy-gBDOCZ0C9erN97c0cYgMXGdzBv5ZFZXshfyXLzj6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 17:11:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Denton Liu
 <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
In-Reply-To: <ad6pEbnSKzUOkS2k@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	14 Apr 2026 22:52:33 +0200")
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
	<20210221192512.3096291-2-szeder.dev@gmail.com>
	<YDLXf+OoJabrJTWu@coredump.intra.peff.net>
	<ad6pEbnSKzUOkS2k@szeder.dev>
Date: Tue, 14 Apr 2026 14:11:00 -0700
Message-ID: <xmqqv7dt8cyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Sun, Feb 21, 2021 at 04:58:23PM -0500, Jeff King wrote:
>> On Sun, Feb 21, 2021 at 08:25:12PM +0100, SZEDER Gábor wrote:
>> 
>> > In many test helper functions we verify that they were invoked with
>> > sensible parameters, and call BUG() to abort the test script when the
>> > parameters are buggy.  6a67c75948 (test-lib-functions: restrict
>> > test_must_fail usage, 2020-07-07) added such a parameter verification
>> > to 'test_must_fail', but it didn't report the error with BUG(), like
>> > we usually do.
>> 
>> OK. I do not care all that much between BUG() and not-BUG here, since we
>> are unlikely to have a test where test_must_fail returning 0 yields
>> success. I guess the most interesting outcome is that we would notice a
>> bug in a test_expect_failure block.
>
> If I had managed to send a new version of this patch series in the
> last 5 years :), then this would have caught the issue noted in:
>
>   https://public-inbox.org/git/ad6hovxCkwMTG11U@szeder.dev/

I was wondering if we should remove "test_might_fail".  Its use case
is rather limited to very narrow cases, like

 * we want to kill something but it may have exited on its own

 * we want "git config --unset" but the variable may or may not be set

 * we want "git foo --abort" just in case we are in the middle of
   "git foo"

all of which is clearer with "|| :", and more importantly, the thing
whose "failure" is protected against the test framework declaring a
test failure is *not* what we are testing (these "config --unset"
are not about testing "git config", in other words).

So the extra ability test_must_fail and test_might_fail have that
they can detect uncontrolled death with non-zero exit status (aka
"crash") is not very interesting---it is more like "As we are
running a git command here, it would be better to catch than not
catch a segfault here as well", i.e., a nice to have item.

