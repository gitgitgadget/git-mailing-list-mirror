Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BF315D58
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540299; cv=none; b=iCxIKBnqcdgttKqxtIUeu74lXPks6iW5Pfm6cubum/itWmZUas6w9eYZ8T3C1h4N4FQYhILb4yo8mjqYb/zfxeGjqDGi89/gJWkeL+GLkzQVQS9AvqTW1OPSlvqIxOw0lRK2qBsMWxr4qiSolKvIMtgIyrFIw7OIWgu8uCCELMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540299; c=relaxed/simple;
	bh=pUSCcWwdvdIbjL6/KKONrflldKluPmob14Sp58RtmsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=coL/i+Ncdo5nDOxl2Qz4vPKW+xsWrtzy/T6+M/B8Dvg0ILv53yQC7klkiwtRBGNN4mNJESw6aDkTwvnnW59d7BDzWpAWIzjTTLLtzfOkfc1R58FSNVqKoeEmIDctbw+mqszT9W08slOJisM0KpKmbG1rV4pvgy1waozjL4BV334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yFuKK9Ni; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYgCei9N; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yFuKK9Ni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYgCei9N"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AAE17A0113;
	Sat, 18 Apr 2026 15:24:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 18 Apr 2026 15:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776540295; x=1776626695; bh=+LgaX1yx9H
	AgTAocBAbMtjPN0MP9Z9Btpg6IDvF4hpg=; b=yFuKK9NiOG6xN0ZdCtzruyoTp7
	MRPhO/ftXPfIsKLZm4PIKs11Obx5wdJSG9H88OYjGFfUpLCeE5lFxLwazBLI90OQ
	E6t1W5ZIl67rcRaeiPfQcAxZd12rBA1rPaH9OCK7QkKqlGXSQl7dayoyl64lk+TI
	2Bf6GCWNwA7EfXOlAQp6+TUQSN5/TVnosCk/mcaeb9IuELhr3e+T0hOdKJHmSXT4
	GXZDhpC2mzHllwNMn1EKtTOwd5b0OuPb7ks9GvJWWexvJJjCRVevcgwnCMY5FtO6
	cNKzuvVrwpPa6VCvj8C1jPfFAeMWUEaGrA9tkWGeN5yxVEigHf4JPLLGTowA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776540295; x=1776626695; bh=+LgaX1yx9HAgTAocBAbMtjPN0MP9Z9Btpg6
	IDvF4hpg=; b=jYgCei9NO0Sr20u46+5T9qGfFzOmSDdJ42YAW2/ZqTb8Yhn/7zm
	cyhmPi3eEtHmVG1kr3Q4R4g0e4+Su9RWUjEh62tpdcRbHOFaGSQPE1arszgHnzs1
	Y5ezjHjD/sQc5bcZdwH5wN+5RjJaa9ceQyAFRMrrsyw4CpO9LLutNMvzHpD0oSYW
	ggnXzNBVD3/kMWww6ORXrAQDqSaetn79w+A4d3pub9w9dqkViSlE+WDdLOVDbCjW
	wUmjDFnNGXK+qvs4iT48RiauHIrHRt7jHxAKJl5E7Z84+SIV/UTiIoW0zPUFSusd
	zFxmxvPNuCWxjN2EL8i4J1P/JK+ZpKbOX9g==
X-ME-Sender: <xms:h9rjaRsMPzsq1YmyolbJb3iMS0XbFqI8V4DqAuu12pA4ikMiMDWMkg>
    <xme:h9rjaeKqDWlVGmrh6OCWP_v-h_28WBzuWxfsZ54ATUf6k1W0qlCcEtpkWD2QGqOlF
    qSph6eOWMLT3QJmoXij1oRsJv2Vy7KjdzWCUGdDzxVxUNVlgBNdow>
X-ME-Received: <xmr:h9rjaekodM_7Znp43CxGHUdwhC-Y_rdFFdSNhWZKoaZ_gYX_mvYsIvKfzBHRW7wqUu-j5alnDCnIw8t8EKIAzYW8R8-Gzz_V1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h9rjafIw8Fke_mClQU1ly2N4xLgzrATtam4oXYbTf0UwaHdUn_pL4w>
    <xmx:h9rjaT4SzHhppLYoDOxNwKLY7XqSM6J9EIbAESDXjuvxBCfgz3Oz5w>
    <xmx:h9rjaT2Xn-ueoCN-JMYtfkuwft2KwAU2xa1CehYwJe2x-uGG0TO6-g>
    <xmx:h9rjaZepGBXz0PRwmI6rYrz1J6vx3U9q2wMFqW0qCKzotUtdLj2Jcg>
    <xmx:h9rjaeeZbVQNsTLEVzWqzw_4DzGEoGy1RVZRn5Y0Aju6u_xDuWhpg5df>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 15:24:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  =?utf-8?Q?G=C3=A1bor?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
In-Reply-To: <20260418174446.GA1695@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Apr 2026 13:44:46 -0400")
References: <20260418065009.GA2619713@coredump.intra.peff.net>
	<AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
	<20260418174446.GA1695@coredump.intra.peff.net>
Date: Sat, 18 Apr 2026 12:24:53 -0700
Message-ID: <xmqqtst8ul4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sat, Apr 18, 2026 at 08:17:10AM -0400, Ben Knoble wrote:
>
>> > +if test "$GIT_TEST_USE_SET_E" = 1 && test "${BASH_VERSINFO:=0}" -ge 5
>> > then
>> >    set -e
>> > fi
>> 
>> I guess that should be || instead of &&?
>
> Oops, yeah. I wrote it correctly and tested it once, and then started to
> rewrite it to support setting it to 0, like:
>
>   if test -z "$GIT_TEST_USE_SET_E" && test "${BASH_VERSINFO:=0}" -ge 5
>   then
> 	GIT_TEST_USE_SET_E=1
>   fi
>   case "$GIT_TEST_USE_SET_E" in
>   1|on|true)
> 	set -e
> 	;;
>   esac
>
> But I didn't want to get too much into details of the patch, so I went
> back to the original, but obviously screwed that up. ;)

We could forget about "we know this is a good shell by its name and
version" and test the feature we depend on ourselves, perhaps?
