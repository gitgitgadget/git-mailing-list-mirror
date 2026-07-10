Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AD1EEE6
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702953; cv=none; b=RFK3k1mrG09Cyf5FCDvoqB5MssB/EgaJX/rR0iJqzsN0H7yD/1gvepJOnVMFC3h2hOZ8wBYkf+01RidDAXhJ+yRS5OlKlt4V5IxWyipiEFvyagaLuTHesm5Ans87e8bL4r40oGlkk363Hh5n9mw2l3g2fGtd41kM6zEY2OMKjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702953; c=relaxed/simple;
	bh=dVE9uDG0YBS2DdOSUUlvjES622/ErA7ChOduYxAtYAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYp/eBGMUYQalHdv/6MCjX2HbVuPsMO9lUCVkOdSWI7Rmt1x7OzxqbojYyfIe4CHVAu3m7wkcXV6SBl3ajdD30pTgJzj7xZftkB7Ty+gxcqp/H85tns03IWMYMV21NJWB4K6PDifUzTubqDs0RW0B/gz84w4ckIrnAe//9IoFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iyIfTpBH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XRLyzyG1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iyIfTpBH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRLyzyG1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C06B140004E;
	Fri, 10 Jul 2026 13:02:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 13:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783702951; x=1783789351; bh=xwFE/aNzfz
	383l23P1B+V1AZycj3bY6vDsIS/XT0NAw=; b=iyIfTpBHSe9ziKzyqFUy/7cFLW
	fkMsMT7Z75EljbVQCkgweszEbR9KJfwDvVYsx59uxiKiIIQPap0cgZvAU+MPrg48
	65+kTSbpD0RdXfCqpooDpShBC1NzklLiUPk56Y//lQSmCALnNUoOsRNljaHFfSTF
	GG1FUVpoNkdgcbtOExYdLUzekVAexOSXW3e4+TzgR5Kb2v8sfwHQquivhFJwe6/Y
	BPlk+Fkj/cw18r+KHXSyZLuHPLVv/8RqIDcRAhF7DzcOprPlBptfgeLX4hAnzjul
	C0c9qaDpTjm5wh9YTwGxg1HTZLNG2gik/Rd6W0l3hMJpiwAGbV2QaBpY793g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783702951; x=1783789351; bh=xwFE/aNzfz383l23P1B+V1AZycj3bY6vDsI
	S/XT0NAw=; b=XRLyzyG1JFJCxod9mh6c13V0mkge3PazVr/PlEZ13w2W09vXLrH
	WTJGwU9L9PtNt7Kkm56Ja3UlJERIvgYs0HzzLwq0tzVdZBASZHlMFExOyWvterUk
	NzrrYuBIpXULRj+8KoYL7HDu+4U2lxKL+M+Cvlqijp9tdYlLGQF1sgf/C9Al4puc
	CFIurNhPbf9rG/gKQTTjMLysBObnwa53XAq2G+TFOhZl1vnGxr5HHPzoP+Ivcrx+
	++DrdCAOSMBjF03cgXLMDGGmxc+OKSwV1ZOsXomdTobEmDmM/ImS+68f3saf3p9x
	A6coj98c5v55fy2qag4psJ42p4/0Vs6LeHQ==
X-ME-Sender: <xms:piVRakl0or7I43mjRG6uk7TNxg63yyGWNrMaXvu5lurcb0FS81Kacg>
    <xme:piVRaq3ZHwTWprhwsmDKYGueLt4aESmJ4vpDxP5E063MnIDV2k8U-xN4Z7yqxFhxF
    Th9BIL7gl5YeGmFd67E73B_J_n9JuHFPKILUbbnNlB0VH2pA3VX78g>
X-ME-Received: <xmr:piVRanoqh35Zln-SCb9RxDFCs0BklZ2sw9DLQ_wS3kZvfx4cRRGFXbkcjW7R_rpsqqXvYLXVZFb9W0j916hxm0AU5hroQ0-ycy7f15Q>
X-ME-Proxy-Cause: dmFkZTFl1LfEyWqkUrM/Sos1qadAuWJXkpt4HS+i0qVw/Dx9gjEpEdXWnW2TVJkxFhv6Ml
    Ls7J4cFKVQ+kAlCUkOqIfwaYVUPz2KpYh+t58MoVy9O4b11eQ94N86fu9PuBF2ntQ5Pn3k
    2AMv2FTWbog2OST7YZEmF2QxiVqM2zt6mUX3mr2YPSvJnK/mA1VftTayLYKWeq9aNEnt2G
    dd4bWiiPcJ+/f9IHAAAYhrNGqYNLd9g92nxegVQW/JHWBL6iIywpKHh9i3R+UsmXLTvOQ1
    bjpWBlsF1ajJXvLVtOW5DEaQkgnc8tFatML8dd/IeHfdpAzv6ZXDBUB85mcTgT1qq84zLc
    HJfKiv2MWJ3CFfFEE9u3O21GrQ1CCnMwAR1SB3e22a2bZlQjXkMB+n1+ysITsDoosfB7EY
    0vGHIYCZxnNMB9k2T4jtofvQWxU0/I6XuiJLnmrQngM7ntP5SJMmDopBZXEQ75yNj3qeiJ
    dVEiQ4MRwCxSXO0E8nynl9xUnj6y1XGxVr5JO1v0gAMbC23Er8revg4bebe7pgIrtRPNus
    xxICef05aVPdfkfppM7Scqn640cz9r//v8I4Tacn5BRFcuOnOtqLzYXfrd+BrojdGnbjUA
    ugN1UfPhUE7F/1Xo8Zk4zLqr4UH83vKrTkXDi3mpGi62Y/7uiAbaNnbI7C6A
X-ME-Proxy: <xmx:piVRave_Th2i5mLrUUcREVYXkDtwkP90RnwCsFUvQzx0X4LpAAWjzQ>
    <xmx:piVRaurb9BFT-o9QHcKC6bChpIZXgDt4MPMjIPhFz33hbxRi4UWSZg>
    <xmx:piVRaoEsJJnaiwl6PKIHJ7gVwZcR8x6-eKz8sCJs7iV1o-KB6MYgmA>
    <xmx:piVRamvsOSHN1fi0CRCTyc1MGpDuVVbKkIrPUwg5oJ56Ew7hfQWJKQ>
    <xmx:pyVRat0UX974eMvbw3x8R7LoRQH9nq4MF8eboixJcXpGUgeXEmr8h7a0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 13:02:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: me@black-desk.cn,  git@vger.kernel.org
Subject: Re: [PATCH] b4: include change-id in cover template
In-Reply-To: <alCxgqybWb9eDEG0@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Jul 2026 10:46:58 +0200")
References: <20260710-add-change-id-to-b4-template-v1-1-1bd37a25064e@black-desk.cn>
	<alCxgqybWb9eDEG0@pks.im>
Date: Fri, 10 Jul 2026 10:02:29 -0700
Message-ID: <xmqqik6mdbh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jul 10, 2026 at 03:22:13PM +0800, Chen Linxuan via B4 Relay wrote:
>> From: Chen Linxuan <me@black-desk.cn>
>> 
>> With b4 0.15.2, I hit a local failure after sending a series with the
>> in-tree cover template.  The generated sent/<change-id>-vN tag contained
>> base-commit, but did not contain change-id, and later b4 commands failed
>> when trying to read it:
>> 
>>   CRITICAL: Tag sent/... does not contain change-id info
>> 
>> Looking at b4's source, the sent tag message is derived from the rendered
>> cover letter.  The same code later parses that tag and expects both
>> base-commit and change-id to be present.  The default b4 cover template
>> has both trailers, but our in-tree template only has base-commit.
>> 
>> Add the missing change-id trailer next to base-commit so sent tags
>> produced from the project template remain readable by b4's reroll and
>> comparison logic.
>
> Ah, that's indeed an oversight on my side. So this change looks good to
> me, thanks!
>
> Patrick

I would have slightly preferred to see the observation part fully in
present tense (instead of "I did and it failed"), perhaps like so:

    When sending a series with the in-tree cover template, the
    generated sent/<change-id>-vN tag contains base-commit but lacks
    change-id.  Later b4 commands fail when trying to read it.

but that is a minor point.

Will queue.  Thanks, both.
