Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838427701
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749317506; cv=none; b=RJ7fg/cMycvAkhbjWlfUWyLVL70SsH8IF9LCmNqptG8uSsqhIPz526Olg9A70M/MOTodMGxUk/R2zVQoDbYLI8WQ8bGOMYon7aKsChCz3W8q3P9sopYdMHZrf5CYi9yX6B9MkNthbySuMvNbTxNOrSIgzWmDgZVcmkrEYjisc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749317506; c=relaxed/simple;
	bh=lpO2/XdImwBgpEclchVo067IwYw3GeOC0IO1tXzsBmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dd/wXypPllMm8reqDUfXwujhGSjTsFFcc4OLZpZDntRFxAdPdWkAwcDw+ispRj3YSQ8ZG56/a6PPpguR6jypuCYeP2Phm+5G7aXr6anY70k5h1ELtx6i6FGDSXelTjug9cZzcCVn7obpEeNT/6Bmw81EkztWPuRepwTOTJ/n6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bN22k+F7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONE435XW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bN22k+F7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONE435XW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6ED182540104;
	Sat,  7 Jun 2025 13:31:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 07 Jun 2025 13:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749317502; x=1749403902; bh=6by3DXFaUA
	TEfS9/W4uQnrkzVZ91vYgv8u7T8fN76H4=; b=bN22k+F7tk+zoa7vKqf/hQpS6o
	MLsBUs35Jjo2/Q7X2aKnPwvzwWIA8nPx/r/tocvfU8c6nO8+5lI/NFuwH39pduw/
	6dmSw1Q2lyv8KkodwyzWXFQEmDEDFI30OHIpZPpgCNqiFZZQTh1VOoV4vhaA7Scy
	eggMNmX6u389Q3Y/ygy46fO6BH+e4LFlpoHgg1ZkZ/Qc8UqIvmvwKRV5m6GkG1VI
	yoxaWPQcrZ4DLSkyN8bAykPsURDxSPm7R/9W5MqD3GXjuglfXU/gW5J/pBSwqjmv
	UnQvD7H2Tf/YIizfyPtIRPmuF0CNVK1jGhhy4A2Jl90U5sf9Xr/S1YAFqnBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749317502; x=1749403902; bh=6by3DXFaUATEfS9/W4uQnrkzVZ91vYgv8u7
	T8fN76H4=; b=ONE435XWUzO0jdu5RoKnt1XIpSz5GQ4HJEEx2/FKhcBtU201KAz
	4ZOsBtcZcpy5xI6+8eK2hpOtaJs4zKebq3rH+rq2Ht7U/hU0VA8u9OISfqHEdP20
	ulbE+MKAkPqu9+G50wi3JAVl0m0SLpfC7Rtk/M4vC8Xh2XuXTm84kLt/yTfeymmM
	cEFrdegcVnCdXUAqAzJ2C3DR+IZix/5Sfm4z1gxHrQrhqLf9NXkhf/okjviGs5/g
	l9rxW495yUexmY5DATXCV2CQZWqb67qkxWRJMENJsZPMOIeynbVy2slogKFdGVjS
	Bxhfajge6g9+Av+lv2NzL8w0X3ulT0dMTWg==
X-ME-Sender: <xms:fndEaH9YRaBuv97779BBZWu7e4Mow5-dP4aAA384857vbsaOeBFlxQ>
    <xme:fndEaDvkEooDP3boKVe_ep8dsh1feWVcO6iOd8AgDnmusXNMLEmH3apu7gujtcKef
    csW8egi39KQ9auTCQ>
X-ME-Received: <xmr:fndEaFCH3Epb-bQ3SG45vFBheOqKOhAfqqQn-RXPE5q6ZogTND7FCQduSXgpgmPT1eGOPELScXSbNKtOfv1GoQWkzgqtiCgG4c56>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeikeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepgfeuveeludefkeefkeelkefguddtkeevleef
    feevtdegtdffuedvjeeihedtteetnecuffhomhgrihhnpegtohhmphhuthgvrhhnvgifsg
    drtghomhdpfihikhhiphgvughirgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrhhnihgv
    uggvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgrugestghomhhsthihlhgvrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fndEaDfpGmTZ-4kozrb4S2fdQUTfatqmBLpmoFgHw8DcDxjssaHPfg>
    <xmx:fndEaMN69LnyJWBkhhr2UWxMVspj59uJ9v6z9lIpGLEsKMhOs_V7vQ>
    <xmx:fndEaFkTDpo_WTlCU3qLG7OvP4SHajbib7kla9rvBVhYQwDSemYy2g>
    <xmx:fndEaGvECbR06-pQH_2ml4udCEPfMCf2QWiU5UIzgmkMIZ5nHsWh0A>
    <xmx:fndEaBzrpkAZSy8a4yMIQBOzPmURZxR1GXRHIJAFEwbP1gWzMuTsmS_K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jun 2025 13:31:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Brad Smith <brad@comstyle.com>,  git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for Solaris 11
In-Reply-To: <aEP7kpQIHZx94eg6@google.com> (Jonathan Nieder's message of "Sat,
	7 Jun 2025 10:42:58 +0200")
References: <aEOlc_PV7ZngUdj0@humpty.home.comstyle.com>
	<aEP7kpQIHZx94eg6@google.com>
Date: Sat, 07 Jun 2025 10:31:40 -0700
Message-ID: <xmqqbjqzzceb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brad Smith wrote:
>
>> Solaris 11.0 and newer have mkdtemp(), memmem(), strcasestr()
>> and strtoumax().
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>  config.mak.uname | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> Thanks!  That's from more than 10 years ago, so seems very reasonable
> to rely on.  I assume this is tested :), so lgtm.

One thing I didn't check myself is if the new make directive lines
(ifeq and endif) are indented with SPs, not HTs.  I heard that newer
gnumake is pickier than before?

To truly test this you'd have to have access to 5.5 or older, 5.6,
5.7, 5.8, 5.9, 5.10, and 5.11, unless we declare that it is good
enough to eyeball and to see the set of variables for these existing
releases hasn't changed ;-)  At least it does not break 5.10 and 5.11

This patch is good, and I'll queue it as-is; thanks for writing and
reviewing.

Outside the theme of this patch, should we also attach good-until
date on each of these entries, with scheduled deprecation/removal
for old ones?  If [*] and [**] can be believed, 5.6 for example have
met its EOL in July 2006.

[*] https://computernewb.com/wiki/Oracle_Solaris_End_of_Life_Date
[**] https://en.wikipedia.org/wiki/Oracle_Solaris#Version_history

>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> [...]
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -190,9 +190,6 @@ ifeq ($(uname_S),SunOS)
>>  	SHELL_PATH = /bin/bash
>>  	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
>>  	HAVE_ALLOCA_H = YesPlease
> ...
> Not about this change: do we want to retire some of the cases for old
> versions at some point, or to collapse them so they can share more?
> Seems nice for maintainability.

Heh, I should have read to the end of your message.

Marking for retirement is certainly a good idea.

As there are way too more stale entries than entries for supported
releases (which are only 5.10 and 5.11 if [*] can be believed),
restructuring to share more may not be, depending on how it is done.
The current one already says "These are common to all releases" and
then independently list additional variables for each and every
release, so you need to look at only two lists to see which
variables are applicable to one single release.

We cannot change it to "all releases should use these", followed by
"if you are at or older than 5.10, additionally use these", followed
by "if you are at or older than 5.9, additionally use these", ...,
as we may add or remove these variables as releases progress and
gain features, which may lose NO_FROTZ that used to signal the lack
of frotz feature, or may gain HAVE_NITFOL that signals the gain of
nitfol feature, in a newer release.

The current arrangement allows us to get rid the support for a
single release fairly safely by just removing its release-specific
addition part---if it makes some variables in release-specific
addition part shared across all releases, like NO_UNSETENV and
NO_SETENV already are, the result may be redundant and more verbose
than it necessarily is, but cleaning up to move these ones to common
section can be done independently from such a removal.

And the same argument can be made when you add a new release, like
this patch does, to separate the addition of a support and cleaning
up.  It is clear from the patch text that we are losing three from
the commonly shared part and adding them to all the existing ones,
plus writing release specific additions for 5.10 and 5.11.

After the dust settles from this patch, we may want to see if there
are ones like NO_SETENV/NO_UNSETENV/GIT_TEST_CMP that can be shared
across all releases and move them to the commonly shared part as a
follow-up patch.

Thanks.
