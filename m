Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D82C3265
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748829623; cv=none; b=ayCRMm3v+E9BxMNayvmDiGIs31nUnJXN3LIAFGxneHLYnMI4ZG2bLghuEIYcGTO67CaGHkoW/CNfDZTvZ72+sFGqEOFz0SUFYvC68U+z9NPTBESyYiZYYsD97lPcyX6KHf8eIEWZNrLEtHnREHWB/FjqhC9OMWN6Tvdhrzv6LU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748829623; c=relaxed/simple;
	bh=4wd4dgoO7h4P945PwHBOhbyrMAPsjKV2cd/PA2d4HoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=doBj3/lvnAQpdD3uH85Vk/aBxigxudCnf8HB6vDcB/VkbCpD43ampB6M8iy5LcbuKTJKV6PON70OqXwYNodLhXEDP2fU1Vh25A+tTDVzS1+Ji1VbSydfoe66tHHNLqNrD3BGlapus5hV+GlRTQlgAQcJUMQBeZmwHyyQJ+UlO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pki5qka+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqEn5/v3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pki5qka+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqEn5/v3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C6321380317;
	Sun,  1 Jun 2025 22:00:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 01 Jun 2025 22:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748829619; x=1748916019; bh=4wd4dgoO7h
	4P945PwHBOhbyrMAPsjKV2cd/PA2d4HoE=; b=Pki5qka+setRIu6MHiLEW54mwK
	dWAFszYoOnTW9IH5uhrB3aGAp34CLqvqLRUY2lx7SDrUQGpxW5/z7WrppUmt5RnP
	UN1QRWCZv2zas499onQjwVfNmRpymZYruoR3BRHyv31zYXytaAmQP9Jma5eOFrVB
	cbBnhE6JGx+41RkZ8qmy7x5rIzyEqVpE1Gtrn6ddkWX98Hv35Y2I6Vo4J9s596Mg
	0WMfHYZYSbqK7kXhbrbMyrMlMi7JWl57KAeRA+EPWRTfM/JJjvMDk5eXbza1Z8Pb
	LLk7jU/EgCAf8l008o77alN/eEaPKEf6jyS0MlK2cZapIW+aZ7TnynaydrSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748829619; x=1748916019; bh=4wd4dgoO7h4P945PwHBOhbyrMAPsjKV2cd/
	PA2d4HoE=; b=BqEn5/v3MueFXSCRNbiFheKX2dwZQSORjCaLg4+NEVHu5hcaGD/
	orV2tUU7wEgEib+JxlHNf/WOJNlyn8kBXeN+o0HR7u/F3pwExFAWg6C/10ywFGXV
	tmJnawtdPpZaB+mlFT4tVOtPikj7x/rRZosMBb710JBHhFxoW4r6HxKqzszpchA2
	p/52tFe7075V/G0Na2NTKtjblC4uN2ddDJSY2DhBDFKXZSuW4ntUFFkBnkd4PcVi
	dsIjKnk/8PJ0tSJGJ74IIK3HwXDHi/xnk/bJbf69wEpPzm0DsGjZXSkM3nVDCeor
	oimG+/l8YWjan6TjbN19uSiHrQucHyCrZ/w==
X-ME-Sender: <xms:swU9aNhZ-SE-aRhsqWQQ1EvOnbtdDrDionfOYCnilrvu4Kn1bijAqQ>
    <xme:swU9aCBt-egcQk8XHUHTvKso5cHUGd77U8UNwf0nSlktEAhb8Qs8TG9UaOeCv2m-b
    hgM6xZGuyG_-65htQ>
X-ME-Received: <xmr:swU9aNGOHpuf93W2UVkslv_6Shfc7w9rOiP8iy10gA2gzDjAkHH9g2eFBSdpPDDGzOhPgHbmYIktdf7EdzIiI2kukJ6ODJ2VJoG7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieegudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegs
    rhgrugestghomhhsthihlhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:swU9aCQB4qvP04-8UiBhlmt7AEc8h4m2JyO00itq7xZTYGrEtk8Tfg>
    <xmx:swU9aKyYtL0Py8K316UPlvWfopnsjiXJR0aNWUc5JlHpUbbRWvbEpA>
    <xmx:swU9aI4lhm5aCUyEP4OOJskmQ1BI3uj3GmvHaALdQo27HFSZLRjgUQ>
    <xmx:swU9aPwiYcqocwnVwh-cLKfDioSZSLQFC7ODrACgPLaIUE4Ct5bhaA>
    <xmx:swU9aA1SNPO6fjVPX_10p14AevzLYR_iARUJ-9_1OFk0-wRruzWtBl6t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 22:00:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Brad Smith <brad@comstyle.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin/gc: correct physical memory detection for
 OpenBSD / NetBSD
In-Reply-To: <87h60z6i5o.fsf@gmail.com> (Collin Funk's message of "Sun, 01 Jun
	2025 18:34:11 -0700")
References: <87h60z6i5o.fsf@gmail.com>
Date: Sun, 01 Jun 2025 19:00:17 -0700
Message-ID: <xmqqr002vr66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Hi Brad,
>
> You wrote:
>
>> OpenBSD / NetBSD use HW_PHYSMEM64 to detect the amount of physical
>> memory in a system. HW_PHYSMEM will not provide the correct amount
>> on a system with >=4GB of memory.
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>> builtin/gc.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> I confirm this patch is correct.
>
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Thanks (also thanks for the online_cpus() one).
