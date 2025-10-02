Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2A7D098
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373371; cv=none; b=e7lhHGOnc6VkEwLttTIP0JtGhuJxxScLE01hTKTpjsDAANVWgujaw4R+t+S68w/IIiHwN65TKEYLFyCYAEZ0XBN63p3HpZq0Ph2f6HFN+huCUCrqGAB+ZFdnmUl8E16L4kA16K5/DofdT0D7XhlxGEQoKZIMR9GKcnQw3P4rv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373371; c=relaxed/simple;
	bh=RVxfcoGII+Rogl7N4VAL3pOWs5wGpZuiILww3fWVqg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDU9BTBcS/vKMUSRDd/Ovl32oJHgYiDGR4zxz3/v3GSjD209sULFdEln0ygVZ1ucJkVS5ok7U17wPoVodDa4vk6x3zwiojtWb9o8yGEKFNSxmyEDZxiIjKld1Z9q4L44hFAepdhTfrtNTLAvxnrY9IisnoAjR7a/r6p1xnRw/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KK4wd40c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQGOWLTK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KK4wd40c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQGOWLTK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 049247A0101;
	Wed,  1 Oct 2025 22:49:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 01 Oct 2025 22:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759373367; x=1759459767; bh=ABnw892LBx
	R/jS1G2CBgiDSkbENwkB+7ObJO2NmOTlo=; b=KK4wd40cyw56S2viz1sza7zrUj
	gJZcWD1scMKjrrTh3kOiB1zFkm1c2wo0OhEvRkfuE0K5G2YgX8mFGtkZhssUsEG3
	Gvl15knS6XMBPpYwsa0nH5PT5Je7kpHuObwCTOVMzDn0ctvhxH105cuhX6sd0eLr
	0w9gcAi1WeCHFGTyoXk7AbmuaLyfxGgHl1DtwUwaK9V3Tx2bwOQfxWwuEVr/N9W+
	/sfZHZzGFZPpFladj5wHNuN3+z46KDZyHmtEswCw+uWZurSdTG1eYdx0j4syqKyo
	8GOlJJwSpSu6+Tr5K174yrWRugjod1B2fUyb1s4SBFdX9Ta6G9xW0F13iyDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759373367; x=1759459767; bh=ABnw892LBxR/jS1G2CBgiDSkbENwkB+7ObJ
	O2NmOTlo=; b=uQGOWLTKolM3ZpeT8MIcOUNmK1inP2yiwkCWcswmL9R9zA2ZOaq
	WKjzsXESMqLd9j7d7v4TosJykR5A85GU0I6PnXMP5LggRadMGDEUjSak3XXJh9dR
	5nxId74v59DC4ugzm4TkOwpzRXr2XXLPR3jVUeBLTqN1DMhEuv/Gf9KFwM3RbGCb
	MufkDDmWJ/O6lQADu1WQE/u5PCACmp6mIeeFPRhqFQj+Dd05VYzyolH1qNVZpxaZ
	A+rPZ9QC34iD8wyX9EW13aCtDW5knOkHd/DYlEHSPPEZh3NBBLgUociDf4PtssPf
	Jy3aeWAgqSvquiCCIoYw1aU/s+3hvIAAW9g==
X-ME-Sender: <xms:N-jdaGd8tbwJoSIQ3pm9NYNEhhxcWiVtSr31Chcb97aXZ0IjA8vvhg>
    <xme:N-jdaHNCLcsqmVYzz9-oNhuiKF5PT42-brc1FrYEVebQot5sYdkqV4OmvGbpTOxSZ
    4iMGC8UmixHkN6RdsS5wdP8zQyWyRwF5xYJ3RxWFCKp-NaaUEyRvA>
X-ME-Received: <xmr:N-jdaMiq5pX511xD5JnB7b3q5kJ_2CDHTYRY51aEp-ZTsimdjrAjOP7v68nF4yaEpQ5neX29MhKZOnC4ytSNAIgg-hD-5e4TOCsj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgi
    druggvpdhrtghpthhtoheprhgrvhhisehprhgvvhgrshdrughkpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:N-jdaC11Jso-pgOVdWsDmfjK13ojQOajCT2k6xH0xQZ89H0zox7anA>
    <xmx:N-jdaOiHY1j5bZO8CHh8EegIQ1uoqdTh0tUa4Hh05S-vNM8F55673Q>
    <xmx:N-jdaKeb8dYCeX-71h4uULP3ZDP9kvTiqIfDjb1LgRgEIQVEpe96HA>
    <xmx:N-jdaJljlm7It36ZWxqpd3UF_aCd2-jc8t6wKyzRMJRH5Ei8DP1YIA>
    <xmx:N-jdaFoMqJdLjxYdcET0O-hDfPQJdcJ24ZDj3Wm3axCjOHLEp9yzlZNB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 22:49:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>,  git@vger.kernel.org
Subject: Re: customizing "cherry picked from commit abcd" comment
In-Reply-To: <aN0TVmEMXOyDZEwR@ugly.lan> (Oswald Buddenhagen's message of
	"Wed, 1 Oct 2025 13:41:10 +0200")
References: <87v7l18nnt.fsf@prevas.dk> <aNus0ulSTb4rAYdF@ugly.lan>
	<xmqq5xd054r2.fsf@gitster.g> <aN0TVmEMXOyDZEwR@ugly.lan>
Date: Wed, 01 Oct 2025 19:49:25 -0700
Message-ID: <xmqqa52ayq4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>I do not know what "an ideological commitment" refers to in this
>>context,
>>
> it refers to the general notion "don't cherry-pick, but merge", which
> relegates cherry-picks to being a 2nd-class workflow.

Ah, that is not ideological at all, but aversion against
cherry-picking is purely technical.  With only "cherry picked from"
trailer, there is no structural link between the commit that
introduced the original change and the resulting commit.  It would
make it impossible to automatically and reliably take previous
cherry picks into account when merging back a side branch or older
maintenance track that are riddled with cherry picks.  Compared to
that, a more disciplined approach to (1) fork a topic from the
oldest potential target of eventual cherry pick and develop your
solution there, (2) merge the result to the mainline first, per
trunk-first philosophy, (3) then merge the same down to the older
targets, is always preferrable.  That way, the fact that your
solution is applicable even down to the "oldest potential target" is
structually encoded in the history even at step (1) by the choice of
the fork point, and with (2) and (3), it is obvious from the history
structure that the mainline and the older target both have the same
solution applied.

>>The intention was for the original commit to be also be public and
>>in the same project (e.g., you cherry-pick a commit from the main
>>branch developing towards the next great version, down to a
>>maintenance branch for the previous release), [...]
>>
> yes, exactly. this trunk-first development model is quite common, and
> has been strongly pushed by some big players in recent years. this
> makes it really surprising that git still does not provide
> well-integrated support for it out-of-the-box.

So, I am not sure exactly what you refer to "well-integrated
support" in this context.  Not cherry-picking and instead building
on the oldest potential target for your solution does take some
discipline, and there may not be a strong tool support to help
people pick the right fork point and merge up/down the fixes.

Making that easier would be a great addition and that would be very
much welcome, I would think.   

But I do not think I would approciate the vague "well, this is not
parent-child ancestry relation at all, but this commit and the other
commit that is totally unrelated in the history space are somehow
related, so let's add a random commit header to record such a vague
ill defined notion that they are somehow related, and force the tool
to pay attention to it somehow via magic."
