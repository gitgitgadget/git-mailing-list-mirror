Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DF4F052A
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375005; cv=none; b=JspXxN4LHCAwsgyV8bpNaTBIfLyOZTaex3M8dAhzm1cOh3aqqFiF4LgSkwYBp5+PjmDZh9mm9y/5ijodNFmGW6nB6zU9QBKkkvCRuiPtsU05/97GX9wFF+t+RvaMTRvA9L3Xwfxh3amigB6lqiqRD+Hhyd3ceh5vfNBSIv/Xfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375005; c=relaxed/simple;
	bh=SjmypiE6wGfhe9+ZqoUBUQOC4cQUCg0p0Qux0PpIArg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPHBtCIKGS8zv8N4MPhbPiK5qJ6zsmY7085f1vkSHzWpKDTE2HjJPlaumly06/3ve0XsCvOM6F3XxOmE1ewBoa0HrIpnRnpCWFOfcI/PiWlGWs3NkNfx0VF09pGCvYD24e53rd95mYuJmFsYXEAOGSteoHpI5enHU8RyV+qNxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UKRuSHPa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljttjm/x; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UKRuSHPa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljttjm/x"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5E2F14000B5;
	Fri, 25 Sep 2026 18:23:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 25 Sep 2026 18:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790375002; x=1790461402; bh=nfVO1tofox
	HbYBe/wZglOt9D3YoctMZbOw4Scuganvs=; b=UKRuSHPa6+Jce4LErP2rubojXh
	8fCYm4JwccMIohHYeFVD8Mxx3U20nTyZmEcnwUKpes4OZ+PNIpgwZwDHJ8SsJvdk
	RmwvwRhoqJ0OM+yTQjhj20SJZ/LiuJuwnRMP1c6/q85Yl62TmAaRQqzHAVFekPWf
	NM6DWv48W4kwQYCFdg07LOqJ/R2pRkQIBxyuVWU/qUeGOefZWnasXpp3MAZ2kOQh
	e/FladW4ZtFt92yI54SDTQrqlTvl6rwpPdgn7fNE+C9nDdycX0nMgovQshRSn4wP
	T+ktjvzQI+7/CVIt/woVO0Sdb1LJrIlQRRJ3X1fGZ7bsXpO39Y4qMn5rb8HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790375002; x=1790461402; bh=nfVO1tofoxHbYBe/wZglOt9D3YoctMZbOw4
	Scuganvs=; b=ljttjm/x7e3Rd0Go5dtYJpHARk9IA/gMgO10szx1hvVWfNQMQLh
	M14PtiO/nrL0JRuuDgfg39IRlylComTO6rjU6t42zorwfSe09XkMHjzDbuQeU/cS
	Kd8MapTFrlIBZ94+d3W4qQSmF61OtgpZMSLJO4tbIbHzVm/uw+WtUGR3Pk8O1vrH
	YAL4ZAdrzJ6urVM+JCUZblb4+K4R2sC6gOfu/3fIE7Z2I7Y83hofI7c7oxdqGdG7
	vCFM6RFtThR7SSJL5BTM6ZEmO+b0u1FUui1vNWIUZM6PJbZrIyKTyJoHlyWj5cV/
	y13cI3oPTeC3WhxONMzYxq/yL8C0cEr0Nsw==
X-ME-Sender: <xms:WvS2apPRJ88CDYHU6aOrEcXA4s-aWQObMq_ZWcioxcixUHagOIYqBA>
    <xme:WvS2ai8O8QqCFMb9jHc-4yHaqouqTD7nKYyGC775qS8a2QyGSo7s9Hx9gB7jPOuiG
    Pu9nusopFUnvyaN5-tKpZ5Hs7kE65ERPlt102f7wLwsYrQMC_lQDQ>
X-ME-Received: <xmr:WvS2atRRn35aNjkpdBipGI1lisTnca_C6ZiqwRB6SddQHXGM8Xlsz1TaUKu4QbVwp2kXC5dj6NQhafh6iqzKBVSRcKwYjYldEfL->
X-ME-Proxy-Cause: dmFkZTE822nLuJphKDcPS5RXHDn53Jz1RpeETZWJXZG4O29nAGAbV4J2G55yO4P8DX1bn8
    sAgS8mycCoDW4xnhoM/LMxsuZFkiC+FaFSGapIG33zbIrZLlq3Xbftbnz+x4rmaIVoQzy1
    t9uTpGEUxNWLI/yK/8WPFeFnBSqENQHPrflOs/1JHORrD0mn5O2bnCyz5n1TCbIZD6wZYW
    GnQkz+aqoi3zFNpKLbS7CHo4IAeSYcjpCzQ42CzyKq7bPkW/ojinTlP1L1vyLXieE4dS40
    QcaxlaWEwctn5oXnP9ZoJghhA9dWEDvBG6xZuyZVESULcSulA5qCoxBVySaK97jdLalzFg
    FL7cPxzXFVwYNwyK3yGy67JJUOeMCVfds8Yocd9upz3YGoxU8XTPbp9R4Dy0QIJF/+QG34
    rFt6EzmUEFZy/tiN7NDzTrAHHY4Tz33ScXDJ9sA6q4UscR2u3W3V52cycqC64B1DXTqDoc
    N6zrqMPpZQKi5xl7r4UHCw+RX2nQJmq+4Jj15vJq0tn7defIUAfG/IZBYahPPkIj21Z6yA
    aOPLj2NZzEMn78Bq72Oa7tuIHEUzlZQ/8wixqhRmBUa5tMbxEGn+w2QiSuMZmUzxqCxtyQ
    UHkhEazWMyITYdud6lkBo67YEkDzqjfBG/CHWSlVfDErkXgPLmvPsEXCcjLQ
X-ME-Proxy: <xmx:WvS2akld6i0tlvBGTA0CpiQTg95QoOKiGUxvX4_3uZ48EG4BxqOGnQ>
    <xmx:WvS2atSDJhdm1JkdL0BbFUbn7n7_yqJ4MepTg8oEZkhuOV2kxNCY3g>
    <xmx:WvS2aiPn3CMKqhYOZP0c-krh6R4bwBVzM3l42gGtfuF3S_JfCCnPCA>
    <xmx:WvS2amXv5rKOmis80YTDKVD_N8Nm1BKXO9EtVWeycG0XRxlXjcz6jw>
    <xmx:WvS2aqPUIWmfc5Pw1aJ0hth0cO-TkAJP1t6rvXEVZXaicPhcMg39gsV->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 18:23:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] some parse_revision_opt() bugfixes
In-Reply-To: <20260925203359.GA1506705@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 25 Sep 2026 16:33:59 -0400")
References: <74796901-ffb1-4cf3-bd63-7294328f70bc@app.fastmail.com>
	<20260925082636.GA1493716@coredump.intra.peff.net>
	<20260925203359.GA1506705@coredump.intra.peff.net>
Date: Fri, 25 Sep 2026 15:23:20 -0700
Message-ID: <xmqqbj9lt1gn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Sep 25, 2026 at 04:26:36AM -0400, Jeff King wrote:
>
>> > I have bisected this to cd439487 (revision: manage memory ownership of
>> > argv in setup_revisions(), 2025-09-19).
>> 
>> Yep, definitely my fault. I don't have time to do a full write-up now,
>> but the most direct solution is:
>> [...]
>> But I think instead doing this:
>
> I ended up reversing my decision there, for reasons that are explained
> in the second commit. But the good news is that doing so also revealed a
> related bug that predates even cd439487.
>
> So here are the fixes. I apologize in advance for the length of the
> second commit message. At least I feel good about my decision to go to
> bed before writing it. ;)
>
>   [1/2]: revision: avoid reporting known options as unknown on error
>   [2/2]: revision: handle argv movement in parse_revision_opt()
>
>  revision.c          |  7 +++++--
>  t/t4201-shortlog.sh | 11 +++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)

Both patches make sense.

: git; rungit v2.52.0 shortlog -n --no-such-option 2>&1 | head -n1
error: unknown option `(null)'
: git; rungit v2.51.0 shortlog -n --no-such-option 2>&1 | head -n1
error: unknown option `--no-such-option'
: git; ./git shortlog -n --no-such-option 2>&1 | head -n1
error: unknown option `--no-such-option'

