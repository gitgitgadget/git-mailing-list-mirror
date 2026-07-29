Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B9282F35
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333000; cv=none; b=bMYzI3Wkph2QE94bsSKxQknHhEVvFMpH7FdT9N/9UZTOt0pVfXJ+RrjZR5y12OTWagSh+f3j2eQ07NsfhKO6QuzJwZp8+W/p9lFlKkOlBpXIftVLHqzPVbx7c0QUYjRcGM+f7oo1cLSHnwJLz3k/L6Txj2A+o4Zg0dTIc7ZFjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333000; c=relaxed/simple;
	bh=l0JI82iapA2N609kNKVrgv+/WRIvnnGiUmHrcBBdExA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X8fafQxuzlYSZWYG2PbTmRfJwhmxzlOvxm4wQtD1xA0szDz+7ts0R/guPS1yWzKl9GGxOtcI6zaBRk6X2ARffQxzF7wrlNNfNLWcWpiafcRHbszhOYctCv0Qv3alvPFVDs5F4zGnm0PbnI0uYICTF/A6Zb+NZgv91j5ifuPoSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZQ54l71A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsgCRewN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQ54l71A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsgCRewN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A9A231D0017B;
	Wed, 29 Jul 2026 09:49:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jul 2026 09:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785332990;
	 x=1785419390; bh=9HIeRJoWRfgBvNZJs/xCzCPDHxOEKBlGj5h9lkAEjq4=; b=
	ZQ54l71ArEXII1QnccYYIfvXTa5Rltk8pKCaY1u++XU3zetstLidhYNDSBrIhZnv
	tvaxTjUiSIG0Id1a9KU5M5ZLiLcmycdZsKktqhpDsLxTWEOdqtgvKLjg3WNVxldO
	avWxQV5hfXNDKco0ZfeqVaTn9vDYl5DyXwmYTYQje07Y/xhH5PbVAOM+mRS9teeS
	1xgNyEWxVWbKH2PO91n0B3KYuJ8CmWuZynGUKxomWHAuAeR08PpSRTCHbpXkuQg9
	NWGf8GFFPg0E1Kpmaq6SzWPNBxfA/CaZ9Ra2JFnsgd3IGNkVviiqg3B0YsalCCsM
	PAJSpmwfBTdrqFz6NUju0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785332990; x=
	1785419390; bh=9HIeRJoWRfgBvNZJs/xCzCPDHxOEKBlGj5h9lkAEjq4=; b=C
	sgCRewNXvDG4MinvXDPmBq5LJUfZNq5C7ps1KoaVUI3moBjkjeIgaGS5r7rRDqNj
	wzf3UImNYaYdKNRQLcPheoGnUKH75IZH2FgkmGtlyKLVM/OoS6tXs5ktNMiZ7K8a
	G/+/MYxIV+9RTAzzsPV/OsYffJcCIrobNHAKde9QleRWSsk6ldJsDoKHprpb/NBt
	VFUEtww/uKq8Zf1sivCMXesiiZognLVeRSoyodVpIjy7Mkb79BuAMhpoRawjyttC
	qM8dkDIMvYaN1xhopOsDFnJsSasAQ4ptfkpFQcnbdsu/TPChSH/Zs35MJ8Q1938G
	C9nwmpG9y7jrIg2InE3gA==
X-ME-Sender: <xms:_gRqas-OhTgGyHJZMmM5RmGNL6FOI3-TPPdo7nxQuSNrmVH7dwu3HA>
    <xme:_gRqasK_0eloAFZ1TrexC1M0bNQ4NM6xeFtJRo7_TmWpxF07Z-Q_H4bhLKZsJ7_dC
    LSODSgkqyapS5mc4TwOAIlnt5z02jLHqceV2C1-emfZm2tU_32jNQ>
X-ME-Received: <xmr:_gRqavb57DcsXRmV0mEINAjI7mIq0G0mIaxIEO3mDtkNl1c1zWuKFBJCZgyfnYr4vwIkcuW8x0ZUmY0Rn_kg626QiTYSYzA9yA>
X-ME-Proxy-Cause: dmFkZTF2vwA3aAOnqlcwybJwUGRRJkwTj//JtcYWOnZsUDN7jvZ86Agzsm44oz80CkNo7Z
    8Hk4gssk+AYEoWwiBANx+fyCy5YT46CtXyoaiLSlAN6Qf9pIFtARJd+T0R8GspNIt1MALk
    TI1cpd1zkPX/fuceQjmx9G3HJLISP+PJfOzV/VCMcQ2e1KAyOICYBqLMtmFYvArEzWBcNT
    L2du5A8dMP/796O2AM/wtcCTz7I/DJDgGt/Z37WX3oaRjoDqFM96unEVOxPGvV8aTyi31A
    DyEXnoZR4tq/xzdr6SIMgf9q3uVUh48gsKuxfxjQg76/+OIyPoerxtSQs/sEhYOK2FuLsH
    L0pS3u60a4MXfWZTAJ21pglW53xkcJLyI1saeIB86X2JNxPJrjSbnyJeGj1AhkvPXSM4fg
    024kaa4yZPi03skhgaSR+MmOlUKWgTOgu1fsCIuqtYdnWzks80SqsJ1oVmAA2GtKJPtbHZ
    h1424EQQEp9A5PqFZUfVU9dRvubRTOiidP/BMG1wItdNm1naUzLrpAuaSqhm8TTA/BTeBF
    yrwkfICHVyev8wMoZ4jDjLMct1zwLp4RVC54ZhpBb/4tp2RbHXxmYhcs+13JlCfuTvKhln
    NwcryoDQTyItZ24xZNpIxy5GPGpn5LbXnIZ2u6j5M9skLVCO5V5LQYmAtfBA
X-ME-Proxy: <xmx:_gRqamL1C2T1L9ng0cQ7MKL-JQALJOJu_EfguPQOXF1rudteenEKRw>
    <xmx:_gRqalACR_Qhj6ItgIcGRKp39wekOxSio9mmOyaQrhqZ9Jpoo8iuKA>
    <xmx:_gRqajpdoVq6DOH7-BlYj2YyX1nRc-v7VOH6O5CNHsbtak747rmFMg>
    <xmx:_gRqaojXwTtW8hhfK9qshFPBYd6fUYqIHI14PhYK2W3mWmMIqCBZbQ>
    <xmx:_gRqaoLwwa6VsCaEoWG3Rb5Hue3X7_JKOSiQxgCHpiZ10AgjZm8Gjzif>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 09:49:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
In-Reply-To: <xmqqcxw5c3na.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 Jul 2026 06:43:37 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260728215219.753678-4-gitster@pobox.com>
	<CAC2Qwm+AmeDubDrkLmu8Rz9rtO3697gokwF2=2c5PgP--hZT2w@mail.gmail.com>
	<xmqqcxw5c3na.fsf@gitster.g>
Date: Wed, 29 Jul 2026 06:49:49 -0700
Message-ID: <xmqq8q6tc3cy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Michael Montalbo <mmontalbo@gmail.com> writes:
>
>> On Tue, Jul 28, 2026 at 2:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> -       if (addremove && take_worktree_changes)
>>> -               die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
>>> +       die_for_incompatible_opt3(take_worktree_changes, "-u/--update",
>>> +                                 0 <= addremove_explicit, "-A/--all",
>>> +                                 add_resolved, "--resolved");
>>>
>>
>> Should this be "0 < addremove_explicit"?
>
> Thanks for noticing.  '0 <=' is absolutely bogus.
>
> I wonder if we should simply write 'addremove', as this part of the
> change is about rewriting the open-coded die_for_incompatible_opt2()
> in the original and using die_for_incompatible_opt3() to add a third
> option.

Not really.  I forgot that addremove is futzed before this part when
add_resolved is present, so using addremove would mean both
addremove and add_resolved are on, mistakenly complaining about -A
that the user never gave us.

So "0 < addremove_explicit" that is.

>
>>> diff --git a/t/t2207-add-resolved.sh b/t/t2207-add-resolved.sh
>>> new file mode 100755
>>> index 0000000000..f88e3f413e
>>> --- /dev/null
>>> +++ b/t/t2207-add-resolved.sh
>>
>> Does this new test file need a t/meson.build entry?
>
> Yeah, it shows that I rarely exercise meson build.
>
> Thanks.
