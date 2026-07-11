Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73A30498E
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783811090; cv=none; b=fSpBFHOJZjxpyVRptTco564kWJVpUHoRa7hH72b4bQPV0rbYIbRhZI0wH6tKbSiZuTZtLJAXQJtOgHcKpxt43D2bog32baclipJtSibvQdkLHUa7GAaX4sCfVTviaduU9pjndiZ2O8Z/RT6fKpShGFKTaTh3OebGkT5DmqecLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783811090; c=relaxed/simple;
	bh=ZjqRsXGMjjKwlFQdHUfS6cN8hblMTVNhL0VWCBVYPuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PX2lUwWSh6MtPge+u6rT60GLfDZ7e5Fexf/XYHlFN8CC3DhuSMbtCEXA3Dwdty0s8InwjLd+Uz1OU0EBCLsYIpllY35sOYrS1uos504SsH6xuYWyAdm0dAaD3OAJMs4fzmXnehdgrM1S6T9skb/IhIoJaLqLNWy6xjT0iBwweOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sxZs6YGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkFd7dss; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sxZs6YGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkFd7dss"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02B3E140008A;
	Sat, 11 Jul 2026 19:04:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 11 Jul 2026 19:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783811087; x=1783897487; bh=08y00hBCuS
	DolMrdKf/oJSAj2ha2dnokSsP/FORvG0Y=; b=sxZs6YGwjxtu/6I1lVMrr65Jup
	VBI38CTlbiBF2pVssS1UddU/NQpH73iyxsqXMV8ixFnLqnr1tqS8abAdTSdPPOPA
	AQSk8hHqtHz7NzrOOFFUsBKqe1lSqfxiVnCqEonQQWAa2nr44+jcg8m0zMkFxjeJ
	9+WvZVjcEocOy375ypxA0NJDfREoIqxkkoef/V7JvWTiP6x4Zio2VYf7Qu4Ef1BG
	mHJGVazmDeBTCJiOUtuSM/b3yFX4dJlxyFlL22zuQnuF1pi2EHAM898NZpDx+jmZ
	HVL03KG+LBhuLEXXX0ixDxKDmqe2y8Ol9oPO1RFArPgYNktBFdusDqqIZXVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783811087; x=1783897487; bh=08y00hBCuSDolMrdKf/oJSAj2ha2dnokSsP
	/FORvG0Y=; b=NkFd7dssZ+joDu8Wsm+/V4CBJqCykyw/MFgHvgR36eyeC5xu9U+
	jY5Q6HMfnSsOnJlg+e/Pb4e7WhV4dH7izUIzlQY+sOk9dbp1Sf6x5Hwj6GcmojaE
	koFf+eAPAXH98VS5wcNsbQCvd1NdjSkS9bCR6BZGh1DrAIcQyhh/qvOLYWOdUmQD
	d/oA3IwNhepT9rXOxbZDpiYvfBotaXe27z8iO9uzolrwMOVitt2rdMdN7HpeBCkq
	9VclTluE9by2Sobzp8Ft3uC86LgsyjcUwXMgip17ZcdO7fcnG7t/IBzjM5dgynsh
	nbgOuYZ3RM6yKqSfihpF3ZYmLZjFGdOROWA==
X-ME-Sender: <xms:D8xSagSPaIFTEK8kOdZS14gd-qZqP8bF68WlgwwAOn2PPvb9BjH5DA>
    <xme:D8xSamvWrl2yyfjr0YIuddCAtCaoTtjXBwwiTD-3oK7kgIhuDcMT4nLOOr3ymoSnj
    Tsxmw_28MJfuphW1UG99f7Ee8bqCitG07W1Fwo8Yl20nvH53Vww1A>
X-ME-Received: <xmr:D8xSapa18sLPkqwzIJui9mrJF8BDvMTRYa4s8IIhyGVkR_7O1vC6ybwGQtFdIH9yFJRaU76pgST0dTfTeU-1hoFy9hqyIANwAN_OYig>
X-ME-Proxy-Cause: dmFkZTEIEN3MWaE1AqTGdNgr0H7bMwSgKrsmvktn5e940/Y5C0T8nD8VP0CZWrXUFFKQ4y
    8+r/BnmcV+X+eXJVDKQAISWNJEeCyVD7HOt0TTzewQbHLUIkyxv2TLbQUweAA0VUIY4C5L
    f5fK5NF0WpZ5exsNd2/lH5iPJ/T3toy85eKFoKG1oFv9vWKT+Dqs8pDYw5G5QhjSoXZzOH
    4uiFcyyDPOfi2xzsHb0LnMG70PnFu2CauydjARMDIx+SV4isgQ4n3oFMqGBWUzpY8EERd+
    D84J13OMn4CPcbBYaEz3kQRoCwD0knUvhquob/rS4GQEdeCkRHiJd9N3L/VovCzN9SgUrZ
    R7X7e3MPs8QNhDVr1dupF3i7Za+6WJeQsyzcIog5Md/Vto1MqJrxjU4lRJUlEEaj7QRJLq
    zfWRJgsEg0pNhD+S3/KeBpuWJVOPk8vfa7vVr6ngQEZm4G9QOyfW1MnwWvs5Z+J0p1ZKVJ
    Jhbs5YtOyU0CI8AeZUE2S8stD+3Byua/Yp/1L3aCSIV5RXPm4KDEqKTk4eYsXvrSVeW9oL
    IYkQwfuSU3JdqSi63hVTOM/qlsViFezoY2ljbl+NnTiHU0TcVfYcMoaYMO1gWaabHQ+gsx
    P4CEzsyMR/U0YM9oE9jmhkzm3yP1KFKkd6969aC+Rm4N4O6q7WxfTSKsZFaA
X-ME-Proxy: <xmx:D8xSakFWNYIZCaw0m76FbpZqyjR3YH3ixugB5yuqBMY29NN4_Ca1BA>
    <xmx:D8xSalx644bWTN_v73K6uRiZDopZ7OAQ79rO3gkImDa5qHknDm8xrQ>
    <xmx:D8xSaukwh0fARYPqT5pN3BzVqvssPa5bCnQOAYR_tv3B_x96d0h7VA>
    <xmx:D8xSamn4wnU9JQdQRadZ2raYbDotKwnGn8cw8yK7Wqbs_0sJTkbOrQ>
    <xmx:D8xSapPWi72HwgadpAasy50ClZawEQ3nURp0nd5hoVo7_SXP_NQ06OkI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 19:04:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <27215.27575.968985.583226@chiark.greenend.org.uk> (Ian Jackson's
	message of "Thu, 9 Jul 2026 10:36:55 +0100")
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
	<27215.27575.968985.583226@chiark.greenend.org.uk>
Date: Sat, 11 Jul 2026 16:04:45 -0700
Message-ID: <xmqqmrvx86wi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> Hi.  Thanks for the review.  I'll go through it point by point:
>
> Colin Stagner writes ("Re: [PATCH 2/2] git-subtree: Bail out if we find output from Rust rewrite (test)"):
>> It may be slightly faster to create only one repo and just make orphan 
>> branches, like `test_create_subtree_add()` does.
> ...
>> `test_commit()` from test-lib-functions.sh may be superior to manually 
>> writing and committing this file.
>
> Thanks for the suggestions.  I'll take a look.

So, is there a conclusion after reviewing this?

I think this is the only thing outstanding item among the review
comments this thread received.  Specifically, regarding the use of
'local' discussed in the thread, our coding guidelines explicitly
state:

 - Even though "local" is not part of POSIX, we make heavy use of it
   in our test suite.  We do not use it in scripted Porcelains, and
   hopefully nobody starts using "local" before all shells that matter
   support it (notably, ksh from AT&T Research does not support it yet).

Thus, we are fine there.

Just responding belatedly as I was scanning topics that are marked
as "Expecting a reroll" in my draft copy of the "What's cooking"
report that I work from.

Thanks.
