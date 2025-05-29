Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11194315C
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534496; cv=none; b=jeDISfK4WkIxepORrtaUwMqodqwglMRBLtSFCXZeS8otkEkfq1d2mSAK09Zq74fd6mrWnGtnHl75wfu6qiAb4g0swQz6dRNMDrUCnqhsj10h8BnjEF8+SMl5WS9QB25xMhATh6iu/xgZhhGN2ieJ1+95HG0IRX46lwUb5Iv8zZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534496; c=relaxed/simple;
	bh=c5u5XkG76dXVr4wLQgg2m5XFO85ZLExMcOoGeaXTBC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnJov+sEiPnx9EviBGqUa9wgGNeEyVroOpMfr8ri4HyBIZ3n6v60IA2AyLQea56Fv2HI8hDpBT2Ql9awn6hIuBENKPVkF7o89uU7Ban2LI5HaO9LmbpNQBfHStDrC1pJ7LgsFTrDsLQnfWFA512rc8MNCqxXJawnefGJGtC4590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o+RGU6ls; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVupYJ5B; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o+RGU6ls";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVupYJ5B"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0833F13800DB;
	Thu, 29 May 2025 12:01:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 29 May 2025 12:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748534494; x=1748620894; bh=TmYURdxQWt
	j2x3zjBvN8SU1iSgQp0WPtHKqY7GeUu4U=; b=o+RGU6lsb5o43MCs9ZL3Utla2t
	t5v6ES5uFh2BQNUaZN1mpbn5sWrWQS/MV3GPlflLgzu8ptt0UsjOC9BJMTUSheUG
	rLvLqnJKkQht2TteD/SFLBUTT5N6Fa0E/tRSLdU3oBN0qVpHEgKmvgtr1Pg3SWx1
	Cb9K31CiqEq1c7EkVIPKhvXJmzSfHxLFDBlU3xFBCRshPIea4T27P4W/Wzm6wkxx
	Z4BzYdVt+kPa242bGPoZsCdYjCLw99BTR1C8wK/ig+6lpxnW2JGU/FvKezF9JYT5
	FnQ/uCHHIDA2bWzbfQKMRixdW9Z1/823SK9NhhUgowcsyC8gLJqLbTGpGw/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748534494; x=1748620894; bh=TmYURdxQWtj2x3zjBvN8SU1iSgQp0WPtHKq
	Y7GeUu4U=; b=XVupYJ5B5fpJCQFidxmIVpUPRucUp21upfZkuAV//ysu6gqM8Iy
	tw9MwhUMcJ7O/sGVR5YmLQngfqooc/tIFg3Ejy5xzIUl3QiFb8Hy+25FLUcreZCq
	ReAZMZ06PSSpEPxQ5PSderhaRCLhxGAKsVMHLN/reSjiPiGNIqMCh0FH/ta1C0v/
	dA0dEhSwgdaH7eJ720A9t8aKGJu6I7q29QjC6BFN0eMYu3QkTmAqy9u9hIFoS+Nq
	pst4y4Gk8pyIFDciV+aHivazr7agXShV6A66VEAZsMwavfI0GsyiCtR0GVPeBF2S
	pdg5TXI9zqYUG4NDvjvfuxXZmUq8feJEr/A==
X-ME-Sender: <xms:3YQ4aDKK8G72TKMJ1pjlHexyaz5b1KY1d_s2LNXpGeln22DH82W24w>
    <xme:3YQ4aHLfoWKaP7ufBuSmdYu16ST9IOpmRX6IrBtF2R32CzySVDPUbUXMzsgis6iad
    p6ydXMUEFDouD8FtQ>
X-ME-Received: <xmr:3YQ4aLvnJD5hJLTB7CrXS9s9b-frmmUSYRRxLwpsRrJIbQkJyeLcGHnLYos9DTKxWY9g3k1kmgdhiyzqWvNfRs9s2JgbbXWG2vjzDRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomhep
    lfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqne
    cuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefg
    gfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3YQ4aMYYMK1kRPwbmRiK-pmxFEk3s5FckExk9VEvlCDvCrFaig90hw>
    <xmx:3YQ4aKY0iLo2S18deOiNGlTE71-QhK48rDmZuWAyKqFVNLZNPWKWOw>
    <xmx:3YQ4aAArOsmZDE7AtVIoFDoOMvYFSNuxfQMMZ2AueS8OWDA4gVTnSA>
    <xmx:3YQ4aIbgAwfiStLsW4UOBPP1q1a0rbqWNiiRvN3qkBnFRI6c4qUlQQ>
    <xmx:3YQ4aAxgumpGygHGUPL4CWBPYmzAkWeLaZYjaNikhjTO4T4Zn3DC9ayL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 12:01:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: MacOS preferences fix, minor fixes
In-Reply-To: <7557e8f2-2b06-4fd9-a32b-cd13b81d6ff3@kdbg.org> (Johannes Sixt's
	message of "Thu, 29 May 2025 11:22:04 +0200")
References: <7c7779c1-32a7-4a6b-a193-be516e620233@kdbg.org>
	<7557e8f2-2b06-4fd9-a32b-cd13b81d6ff3@kdbg.org>
Date: Thu, 29 May 2025 09:01:32 -0700
Message-ID: <xmqq1ps7mmn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Small correction, just for posterity: the preferences fix is this one
> and affects all platforms, not just MacOS.
>
> Am 29.05.25 um 10:07 schrieb Johannes Sixt:
>> YOKOTA Hiroshi (1):
>>       gitk: Legacy widgets doesn't have combobox

Thanks.
