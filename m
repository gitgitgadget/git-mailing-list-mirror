Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830F49E143
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119923; cv=none; b=uasTXvWpSopBeg/GiEuDBfNnITXje01SdSMYznBQUEmh/lDJbt1bQZdN+Pjog8FVy4vFWaMIQHVkRMtgLClj9eaEK988oEglYIwVU7NGLjuQJwAP8TCL6nWg0IPYC8iiSMfO4r7+iKoQXoQ4wpMSZngcWoTT8+nv2J77vw0//zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119923; c=relaxed/simple;
	bh=HLL9XgdSV1o+9VeXDa8cOI370+vlYI0/0ruIFj4HYHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayg1/yz/QbZIw7hTSrmzzTL1yGVuO09oIfg+M4GwwSnQMANTE5/O0fFvkKl/miclDNq22rm9kKtadvA1mRMyNiee3IuhClJpRMqaVFbA5/jHyogYwLNxAZinf9wjb+1WRX898ZfkA/aw/2U7geVPIvUR6Dw6rQphGsBnR6aNgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mpq5klcH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/HGu0Bj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mpq5klcH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/HGu0Bj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30A3F14000EB;
	Tue, 22 Sep 2026 19:31:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 19:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790119918;
	 x=1790206318; bh=fbMoEcRn5oZzQW/H7cxOTYMrFm3SiBzbKqQ9gU9KK24=; b=
	mpq5klcHPDlDkMXHjG3ErzXp4kGfUOA8Lo9hTicDWS6mdaCzTDt19guNOEM7NHPD
	Ya4td5AVF4hg4+MtZiTkp3oTLtl7d6HbLVKK+p+8VRA99GJM8h4OjX7v+mBfd/BF
	8zkerPV6AfNymKRIzF14lE2cG8G4rmF+YSLv0Vghyv20VVufQQPWq1dN8PI1tOs9
	BVnmcgPj+yWAtUlSzoRXoC7/VKp1QOuYHocf/JlbBuNBoMxbqPElfl5F9Si6W/t1
	G19WYUejkacPb2OvGI11Up4ABiJWA/YVjDMGWRoOYLmniRNU+FsmxroWLFqQRF1F
	ol9UvgXrHcJ0LOQfdy3JoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790119918; x=
	1790206318; bh=fbMoEcRn5oZzQW/H7cxOTYMrFm3SiBzbKqQ9gU9KK24=; b=C
	/HGu0BjBF8B9qUPnwz2eiUfJqg2uWAwbjpKQXamRf8Fn9HJAom7PG5z2FwWOPcS0
	AZJuUFNlKdlUbeLAW0nbCrfGMhE8VBX1J4V0eIvvtELGwhGaKlpcE7229kLe/QLb
	rBjq3JhJjYCRz00HW7/ghP+9YaWLkz8HPD+0YcAp3aEbk8/r2MQt5BfdpFVxjyB2
	1Tp8uj0Wh1tI95EHloJWWml2rcOYf+Wm5ItGBmFMAIMqRu2LMr4oYtyjbFagHttl
	F5aK/A712ke2R0kNxTUUKCOTM4xtRaNl7w9lYKM6rovWz+I2F13bGz+GS651rL7o
	YwUgC5fMGfkIRYyAuPf0w==
X-ME-Sender: <xms:7g-zaoKQ5U406MEsytdUece9A3_CFte6siCD5pNUqeQTbdHwqm3iGg>
    <xme:7g-zalAoiVLbYKFXQN1WMDgadv_hUIXRK_g466uA_eoZ0OyYjEWJO-x0JTWxweiTp
    hQvkY0ZiV8Cje7gDr4wKaWV43jjYyIUt-hwDQh9_3i7buijvUlGhQ>
X-ME-Received: <xmr:7g-zaoe_6vWapHDOj3lazbCrV5zd9QW6-F29ZO9TL7brqjOLN5nCRwrA_JTNuiJe8i3tVh4IuiWeglbcnEKNJ4uXESIcM56XTggk>
X-ME-Proxy-Cause: dmFkZTEfJV12p0yYV5+hC1jrYETACOvKJKudFOuAzBALBDwce6jkmCdKYppKTKkkqgH43/
    ySn4qqjjJa96crstAX/9aFi6yZs4uP7q2uHx3BP2nSF30ngHC+8xWqQyubXIb0uIKHqVvH
    3tpcU0XO6Lu2F+88S2zetB4RfWHRK0krKPMOEYa+ADdEWpF8HSLFG4SOSOqFNhHTJmJO2X
    NpF3kceJfxo3z8sW/JRkDZmkDDu0aFYhlvhNVjU8an7I1WZMOikDSGKqd2yUF1eVF/YXTH
    NUuQumHbBrVE5VwfUlwlmoNNJrJxi+I9fgbjOltg9/dMrLCqY03ckcBNLLskuXLkMfLhma
    T78Kwk358Nu6YlywRYZg+ZztC24CTv8nC3T2kJ1mDwSiBkh798YfWWtkGrd5QJiGU9Zs45
    MRO3ZmF93wt/dN51d0oyWmOkFA86gGEncICyt1V0Qt6ncoPtXRFjV6r56dWd+6bVxBTo9y
    ztK5TLEN2MnFJ9dAaTp5YgFkqaoee30BHMuMJA1LCpKDXHSu0FUGBKM7o/Nvjr0spmoj4D
    9ja06UbFfcGpoF3bsfPaRMhVhKCPHK9N5ol3DyMmPnXYjD6j0MP3KvLl4rBo4NVBQGNTfo
    NJXbRjfxkAhgCOT88A8eqa/sUUwtgQ2IpJxIswsnTrZY/ugDYSZnZ43cqs+Q
X-ME-Proxy: <xmx:7g-zak0G-8CXzhgIHIae5HkrBqEbv6pFHkFNYNgyzzzI8-oM1ReMyw>
    <xmx:7g-zaviSKFlYGCEH9MvgzAOcT1uhjWSeCb4q-3uqxEU5ZcPFqyn7aw>
    <xmx:7g-zatlf-L_M4cNkUjNpMMUKhQcdx56O8lmoCFrNMhouC8tiQOyXmA>
    <xmx:7g-zalasteQcPzAVCl03jUz-djQKmyIZA9b-u6I6espakf6pKHXRZg>
    <xmx:7g-zamBwpIPEtOFKwiyIPsaZVs8JE1jbRHlO5Sr58m3a86mQFQdx3U52>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 19:31:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phil Hord <phil.hord@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  "D . Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 1/3] refs: allow callers to supply old OIDs for batch
 deletion
In-Reply-To: <CACQ=SRGf=cKQooiSQD+ZsG8tCAdHkCrxoW5vyPSnT=UMjSajmw@mail.gmail.com>
	(Maciej Ciemborowicz's message of "Tue, 22 Sep 2026 21:21:56 +0200")
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
	<cover.1790079917.git.maciej.ciemborowicz@gmail.com>
	<3315d5f47ad7d8bcdbeda90b161606507c7040ea.1790079917.git.maciej.ciemborowicz@gmail.com>
	<xmqqjyoddsjy.fsf@gitster.g>
	<CACQ=SRGf=cKQooiSQD+ZsG8tCAdHkCrxoW5vyPSnT=UMjSajmw@mail.gmail.com>
Date: Tue, 22 Sep 2026 16:31:56 -0700
Message-ID: <xmqqfqz0dfrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> On Tue, Sep 22, 2026 at 8:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> I think there was a comment by another reviewer on the previous
>> round around this area, which was never answered.  In general, it is
>> a polite thing to respond to review messages and see that your
>> response is acknowledged before you send an updated patch.
>
> I'm very sorry, I didn't check my email before submitting the patch.
> I'll take a look at this. By the way, I expected the review process to
> be tough, but I'm starting to wonder if I'll ever get through it :).

I do not think it is the review process, but the fact that the
problem you chose to tackle is not trivial to solve cleanly to begin
with, and you are doing very well.  Often non-trivial topics take
multiple iterations to get right.

> You mentioned earlier that you could prepare a patch. Is that offer
> still on the table?

I do not recall that, or I do not know a patch to do what was being
discussed back then, sorry.

