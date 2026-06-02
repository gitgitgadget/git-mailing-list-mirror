Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3290357D1D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395991; cv=none; b=fQ5gYBPCWEuWD5McK1mw9B0YY4drgczhdjdJEZl5HbIm1VvJbYwcHBYxCWM8LUpuyZhxajHZQOq+dVhArLMM9sQk3ORwxmEkUBsNUiCy7G7gLcUQVIilFbXpV+DOSdgYFYTkbTd3YAdGBUE78ctdjjlnKTAIRrRjqRLvSak1WA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395991; c=relaxed/simple;
	bh=qwfbk175Pr+XoLVswUHzPnS3Y8542Pnt4MdnqCWXS9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bT2KEF5SUEeqh7yzCL4Qcpm3gIu++iGX4zWC8tBvL/Bpsyxqrw/08oJu/ymFewbyIMqwc1B6ttQlM9R2BKBlYEOjXfrkG3OT716P/fXYnuWKp/LJ6KCl/KLnaT4BJvvil7OTjs37JI82BWYz8k6YHGb+W/jiQUMYuSc2kHU3cSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cE3GLdyk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PhKTvcTO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cE3GLdyk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PhKTvcTO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B82DEC070F;
	Tue,  2 Jun 2026 06:26:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 06:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780395989;
	 x=1780482389; bh=jG9K6aT63q96PL7jysnxnMdADOFgfuWb4Dr4TK8cXV0=; b=
	cE3GLdyk2VdtNJmnW0V8JBMzDVSeLkRQ1xaeaDgWLRfWTJrUnbtw0UKv2dETApK8
	LN5syMBbGmr5VUQjSpngE+cPg1wjhJohuBeGR3Y43/EjxHqwI4K8Wkayvhn6lFFL
	C1XUP0b05A82j9b+Da2J9Kk6N10e9PyjATafw0ZOBraOmngN4/lk0apDZtP6kmTi
	b4sfxSimQJ+iuMGURNHcOCspzDwwfThsvvju78TvGh6HR9D1f3xjjpc4mAkgQugL
	bKoA/mv4henlihBmBQwRAbgWeIWr3iJi26XfPdhRmkQsm2ITQO43gsxaf40fJW7o
	7VxcYNoG66tALfH2hdOFCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780395989; x=
	1780482389; bh=jG9K6aT63q96PL7jysnxnMdADOFgfuWb4Dr4TK8cXV0=; b=P
	hKTvcTOJu+gIahasBK3vq+yUktdGc6emiaLmARbUDixQs2i0qpdsxtykKtNGGqP8
	oGBBKZ5XFz7OzrJ5pAV/xwzP40jLSwbHa5+LcZpAQftBtNvUKmb2wOiH+pX5+v5R
	aZgzPGT6k7hoM/1Nb8YF3tFNTEipGqvYRl5AH0h+9ZVrOffRC9cehnG7OFozJHRd
	gwhCiKuRCW1toWsEiMrE/p1fUowlhkTBgKSyVxyTGffPXADD3K2FPxAtDGpnwhZa
	Hp+nrItpv3t+ptppDx44klS8Vpt9UaWv2LdlTDztGKlhWx5O6i3w3RSJWFWMBOAW
	SVRzYYtihZIg4wG2p0rZQ==
X-ME-Sender: <xms:1K8earubuFxfctTnYk8YOnZRHxD0Ni5-1kidPT0dWjd0_rWrkS2Ayg>
    <xme:1K8eavAwnEMMgqIcvkQg5yvh-ix3AMxmPJAhOadrfFtphjdGua0dhdsbuYj2O7S2G
    Xqdzk3keIhXBbihbUtNfIX91Qa6M2WP-n5F9Hj7haEy87zBvHHj1pA>
X-ME-Received: <xmr:1K8eaiZL1uH6AufLN3cblWmczL9gWdmABboqEI98w-vs5PmhzUqzPA5kQBCC9b1K_Fgo17_RJ52DHDB9MEZ-Nlvx6kc6SM5LzVi2>
X-ME-Proxy-Cause: dmFkZTEIJPxFR6iHsUb16GzBEKec4Ef9DOZZWCynK9zGg/CaZSjwePLHjSI+HMgGgGoj8w
    LXyGwIy1Dht0EedJmv4nRRlvgJYtVNM7YJ5/0P8EfsDtyfaF2BQPszCrId4yE2oxZp6i/c
    LQJa99Nw/EkpS1J2B3lDgaVaqIyaEDfcGmSFXR0vwLn6szOr0WgH8axviKgaOnWbCj0HgF
    buwz8ZHQdSOX4E6aVYn3XrMQPSHoFFtDMfm5E75k/XtC4LPzt9pqHj/fcGF/rK+SL9nXfu
    YoG1h3N//+koF9eHuhIPJb8ZJzJdkVpWYdnAV7UqcdwJJtpydJEViOB50XCsRJkKr2pYGt
    KCM7JEwUsDmS28/MfJqIGAc49t9l24lGKpKpQoVUjILihNSP/Q834xxYprGBU4SewZR5QM
    aWruyyJW3qu3Uo7pFd/rt4APs94YePHiShs4QdaMiPVxuuwl6x1I0F/azom7zLqQswHX/h
    nVZgOHySYkvt3+vuA5aNtc3rZCTrcK3asDEnQc9uHfE0TsGrpYCuszvXcSKBBRhTvrG36R
    lP0AZM5IYCiO1oXGQbnNRy6YC5t3ulN4XRL+gOGqn5DBefWNKbG8Dk9LZ2RvGXnV1XIKs+
    lOnzSwMCnioV8yLy47ShYpgShx/aU/TEOEgrbT3CNxIowfSc1P+qtRWNKAwQ
X-ME-Proxy: <xmx:1K8eaqXYVviU6z5Y_2JwBZJahsFeRsPU_0bUX3TZSOz5DkJXPMrfdA>
    <xmx:1K8eahOsOhN0_Xe3EC4mX-3IqoFeYJUQSqRy-1N4KBArxbCMabpZOQ>
    <xmx:1K8eakYMuhOyC6O2F-ZvdqhaJs2QauIt-uIrNWJnSbjbtV5PFrec-A>
    <xmx:1K8eag8azVrR0MmnkBGce7NUVV_NL6NN9nXhF2ncraMarzrL4dWb_Q>
    <xmx:1a8eas-Ic8sgsId3qwygO9a3YAUlb3w6DXIhjokXFi_yeybaFdfvQxCd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 06:26:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Olamide Caleb Bello
 <belkid98@gmail.com>,  git@vger.kernel.org,  phillip.wood123@gmail.com,
  usmanakinyemi202@gmail.com,  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] environment: move `zlib_compression_level` into
 `struct repo_config_values`
In-Reply-To: <CAP8UFD2J_482vT3J3hYpSeqG+of_ZDjO3a-paGocRyRgn0=FDQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 2 Jun 2026 12:08:44 +0200")
References: <20260423160832.114816-1-belkid98@gmail.com>
	<20260601154211.82370-1-belkid98@gmail.com>
	<20260601154211.82370-4-belkid98@gmail.com>
	<xmqqpl29ztx7.fsf@gitster.g> <ah6QgwfK_TykIiBp@pks.im>
	<CAP8UFD2J_482vT3J3hYpSeqG+of_ZDjO3a-paGocRyRgn0=FDQ@mail.gmail.com>
Date: Tue, 02 Jun 2026 19:26:27 +0900
Message-ID: <xmqq33z5xmp8.fsf@gitster.g>
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

> On Tue, Jun 2, 2026 at 10:13 AM Patrick Steinhardt <ps@pks.im> wrote:
>
>> Overall, I think it's sensible to always use `the_repository` at the
>> callsites in a patch series like this so that it's obvious that there is
>> no change in behaviour. So every patch series that gets rid of global
>> state in a subsystem X will basically bubble up the global state into
>> the next-higher level, and it's then the duty of the next patch series
>> to address that next-higher level.
>>
>> The only exception of course is subsystems that already got rid of
>> `the_repository` -- we really shouldn't reintroduce the use there.
>
> I agree that it should be fine to proceed like this. It limits the
> complexity of the patches when we separate getting rid of
> `the_repository` from getting rid of other global state.

I guess we are all in agreement that what was posted stops at a good
point, leaving some for later updates.  Unless there are any other
outstanding issues, it may be a good time to declare victory.  The
"bool" in the log message for [5/8] must be corrected, though, so
perhaps this topic is expecting a (hopefully small and final)
reroll?

Thanks.
