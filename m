Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17F2367C4
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876806; cv=none; b=hrxtlMjE2s6n1DB+5TCgqDXsIelsw/X/8BVwFGEtgTCHTsxZebFlLhNEJpNIJ1u4o2chKmpMXPM3eLduBHsduElBSsC271bcKBboionqIi/horgu7bih3TGBF1UC4RGIFOG3T0mDoegl4JOpaOrKjUYQ3U3NrfdeZc9VcJR6aZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876806; c=relaxed/simple;
	bh=DrHmjCcn2Utw9CRUi5t8Mhdn6AimoG/DSAX8XcZdXiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKSyVVoV04dZ5bc3VOG0UOAX6J3NozW8h5IEF+1qcSVQuM/s1ExYd2aREcD3ryMmUjJIZR4lPF2BEpeKxnGTOSpouTz5qPATud0LCnMaTvjAB7Y0bo3yToHObwMoAoxpm2KASWIo8hCYLPxjn3c88gJpebMetFE/dirZJVckMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DSiJeuPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adGBPWNw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DSiJeuPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adGBPWNw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 319EB11401C3;
	Mon,  2 Jun 2025 11:06:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 11:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748876803; x=1748963203; bh=DrHmjCcn2U
	tw9CRUi5t8Mhdn6AimoG/DSAX8XcZdXiQ=; b=DSiJeuPEgH4ykhjySZBp6FhIYh
	3qmGYMuF0BpN/zaYArOrTJ7xdvH7sUS95imLfcRg2Xeh4b94UHNS4n+LMpBHDb9g
	pbEDuwbPJl2qUm9lbkOdj4BksZo3mVFr+VS+DuVYVLSuL3k/tIu+j0HjMc5NBA3C
	vVVVYRY2Ae1rYNHmfd2TLN4poHCdsVVmNUJcejS9DTZP/x2TESwDZYwbdYP2G+Ty
	dO+jGKtGDOQutYWRlPvP6ktIFynwXs39xXK5QJClBhqeFoxjnIProwKwK8dDoHzk
	b3wx4j/RAvEZiFYujH0cQ91IUKEocsXpZhpeVhlMd78pC64laYKKoc7GfZVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748876803; x=1748963203; bh=DrHmjCcn2Utw9CRUi5t8Mhdn6AimoG/DSAX
	8XcZdXiQ=; b=adGBPWNwYE7PN2CAal8Cha/ViOdx4F1hYqEyGCF1DjOY0YMOo/Z
	dApv8inqkxIs0q+KDyAvsm17rODepI7sQtGFKF5y5b/LJ9dxNDoneY8OGN5Ugztk
	wjWVqvweo3mL/+f51pkQpqW4qO/gsY6MCVkOk234Wztt78ONlZDtGWemB/ZSwix0
	kciwpmLOklnrvoRfol8HZanwwKoeq/smPccM9aRRGZPAELnd2IdaS0A2dX14QK1U
	X5ZSrO+aP9g3g4Z8rWNyqeO3qgeJ0cgBInQmGpK4GK6DBwKbwTlSJtGIYpB//DAo
	K2Wc6YOyYWioCZcnbkZtZ4frTEZJ+T/m8tg==
X-ME-Sender: <xms:Ar49aCYSg_AOdIFlWe1J-vKOZ2sq6UfwErfFVxLQpm0vHEt3HCso1A>
    <xme:Ar49aFb6GiHri8l4kleR6RUC7vpVg6AlObT8SIg4lGSsvAH3Ihzq6KmwyUOfejiq9
    ngWAOpqsyRe1jlZtw>
X-ME-Received: <xmr:Ar49aM8yDqhIDvu8Cd83FZrtT6aZsbgEu3aQPrD4pnFq2RbjI4T7B9HAK7yp_yOV-lvlQwkD5sucFT1IUCsRIeJnp1ol95r_xtoX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ar49aEoIae2K1qGWkKxc4XKpVOLRbm6D3bmMMhv8aQYsc3z5BAAgsw>
    <xmx:Ar49aNrHpn_n74g3Ffa-Nr-AP7uWC_qJin7ifnGUAZWLWQ_roi1Ebw>
    <xmx:Ar49aCSQb_s2lrDeEbyYLS6MTybMSKRUgs9ne2fV8nm80gajT0rhtw>
    <xmx:Ar49aNpIztUfniFxtMaw3aIrGhaCXlNr3ilLM92Xfrdij6QNnenTLQ>
    <xmx:A749aEMVHAIWNPo__VsSTgvJKR8R00CO7DyHtwVl--So8yRCbKyAnQYy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:06:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  jltobler@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] refs/files: skip updates with errors in batched
 updates
In-Reply-To: <CAOLa=ZQQCFA=jdOGDONGcsO_VDUAxfHjn_Wk5r+8weHMFXDQ3w@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 2 Jun 2025 05:46:12 -0700")
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
	<20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-1-903d1db3f10e@gmail.com>
	<aD2SRmlSKZm8g8kn@pks.im>
	<CAOLa=ZQQCFA=jdOGDONGcsO_VDUAxfHjn_Wk5r+8weHMFXDQ3w@mail.gmail.com>
Date: Mon, 02 Jun 2025 08:06:40 -0700
Message-ID: <xmqqcybmuqrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> Curious -- we do have tests, so why don't any of them hit this issue?
>>
>
> We don't hit this edge case in any of our tests I presume. This
> basically requires a deletion request with an expected old OID, however
> the reference should be non-existent.

I read Patrick's remart not as a question but as a rhetoric
suggestion to make sure we have test coverage ;-)
