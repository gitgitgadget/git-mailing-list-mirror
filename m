Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C42E3FE
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080212; cv=none; b=Ack92XU8RpTSGn7kREUANRHykgKnQ83VQNjMrDkC6r4uUSUxOnEHB99iXfjezi6OyTXvucYHKnDR5v2qtuy1vAXsfs5fBlqyPV2BcZOywl44sdW7Rbmw7uSUqU9c7+jgmPhIKy151QlYq9Ax/WrvIipCAGG9cV5cHHsu9D5DThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080212; c=relaxed/simple;
	bh=dgthkSYx9WN+rpIgoW/wVIh1n2q4iw4xLm127O+7J/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bj5HLxlG+DksAT9PNr1pT7hZ+rqnOypgmG4kBmjFhqAo/qOCnMAw1l2qznVn09XVLCWrSTGW2NoTAVW7K7Cuy4Jhiw5Aj6DbvtlyAJenDAEWkCchKu3iwmh+KhqvI1nj7b/E0CiDUBcxAYSz9RBNTb6pn/6AUmDJxxg+VZPagV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zgv+geZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Slkh45fw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zgv+geZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Slkh45fw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 718521400387;
	Sun, 26 Jul 2026 11:36:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 26 Jul 2026 11:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785080210;
	 x=1785166610; bh=bmm9d7d7jVJwrO4xQdrWO94x91z4d4oBUZqv5pijNhg=; b=
	Zgv+geZWBr7KkD5FJW6GQu7CtxbrJaOlqZKRbWLw8NI8o/VYC5XJOWvcNsJli/oM
	REXPXI1XKGGkCkDuiMtZBZjv8KY3J5xk3/cHSpCADZ22iAgfTKPGPXW2Q+WWLkYn
	RiOPvW7hQ94Lrpmoq/h7Kctt+xEtPB1qdNM+m8UWlPdkBmFYAhMEW5LuH7AYMX28
	CVeSn6osG3Fe5ekkSuSs/9uNZVpSXDsS7WAq7L/TAGrKMkEZC+Mk4tA4GBI5kjeZ
	dq+CFfSWvO+x7XhovBTab/rlvXram0GRn/Wuixex9Xk2lQ1xrCl6rGukJKJitxUE
	UobvqIjElajeTZJdELLpCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785080210; x=
	1785166610; bh=bmm9d7d7jVJwrO4xQdrWO94x91z4d4oBUZqv5pijNhg=; b=S
	lkh45fwPXEOslx5NmTVoFlEEETcvOExV+BGWdj/1J2/F4Esw5KgC6D/X8Ybwn+a4
	sa10kCW/zKIKLg3T9+zdQtvnRZHmq1NHWggzh7gqKKcmObKa3mhMumkgRTGe70pd
	uHofC7aCtXmiFjdkDUQwo3B3c3EBDUcOwlIavA/GwuXEueFTiNVVLUYBtDo429v0
	2xpjQaiKv1WinfKuGllbVNsS1TvK8/dqkKXqELb7WJahWnHUDg1ym4UwsvTrT5NJ
	nBGVfj9Y3+mhJRIMzbQM0fL5C9N0Xcuwot5ETX3o3dULMd3BnDZA/LfW4Tp567ct
	lqWUf24BbnsD1L6yqzsrQ==
X-ME-Sender: <xms:kSlmagX7Ej3U1xMVv1yfavPmnimwel2NCWQw-P7fRE59y1CJX6x9Zg>
    <xme:kSlmamGJ2FJnZAXbLc7NwshgwqqElDxtSAhlMUY70xGa89uIWLjKlxJRQamZhp8Km
    Wi5M6EVPmz9TL9cIsTDQgSzi7yQ3-SitOPqDZ3orb9zkMp4Nm6O6A>
X-ME-Received: <xmr:kSlmakdhIcoQtZOJBh6xZ5xn13mRp7_TxH0fFALMi6ebQmuaZ88cqTFbaBKQ40OHL0BIijDo4iGQ7-uBWOsYZbg50w01ok4FzA>
X-ME-Proxy-Cause: dmFkZTELleC1xLxulWsW22GeuAdZ2qayeBSS2QWq3q6qRMiIPGChWZnutj2U1QFYkWXuZ9
    OcYaF24ky9/wfDV672CszFPSg/D0tk9gKtBGiX7tsYwBSdujWuyMGvKTU5GtxRTti+6PT9
    QVmVP5JYdTJ50K5sc/Uztv/1OoptF2AYQJhzVpcrX+MK9IbGBK+rs8cfA2FNPN3IeaGHUI
    diOupcKkL1pjZoYQ+vKCFH0SPfO9VtVSKkrsXjIGza0U/FORVPEWgui/BHao62LshPROsE
    HmEF58EWoePCY6F5rDoXlShtyAnL8+37p4fIuhECCd5K4tRcCGAgVjQKxk1uHVk6gZEWti
    Ypi3Baps8gUXZpEPRQYE0b+H/N8by+lXahHcXY+92QJU6Oe5jajIuBG8LIrLSIG4Kkpx5o
    ATT+XTSsqOeTS+MiB4a1oi4e7cva5jPjLAmRyUcEEignXyQAasZFJJjQejQxy6V2hpQck0
    BIE8dwbQTxeqfarHmm9NqHC07WJvzu3YoWC1JxkQqtMmJdI+Ix8YBqyONLKCnEopgrhwbT
    ydJOUdRqmJW6Wyd8ftIPPuWh3YfQaprk25HFudCanpWj4cINxiY025kEatvPg2jB+7m7Vc
    mwWDgsrePV+GDQNj+RCMKDhbW+umg1QXrK1059i1uCsem94a+pmg4MLFqhrw
X-ME-Proxy: <xmx:kSlmavKODFH9Zqb08i1__jdnMoScTVjFVTmfk0zqVUC2qbbjcJhD0A>
    <xmx:kSlmahGRF8ReANLfyq50TeDmvUzpOXUr59FWMTqpaMn8nCTlGNScqA>
    <xmx:kSlmaqBLexs3OTXb-Mz20alVW7UeDbeXb8WH10KCuj4ZknXfSvP0QQ>
    <xmx:kSlmas9NtDlC3t98yK6N8vBei9iSBZ99T44JbdfSwAeL-Mf3SOFTXQ>
    <xmx:kilmamenyu3TY3ffxNoFJ2o40bLAasL2KtmA3nrlEawogM6hkVSK2EQw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 11:36:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  stsp <stsp2@yandex.ru>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] branch: report active bisect run when rejecting delete
In-Reply-To: <590382fb-731b-4e14-911e-ff68356d1082@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 25 Jul 2026 12:41:07 +0200")
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
	<590382fb-731b-4e14-911e-ff68356d1082@web.de>
Date: Sun, 26 Jul 2026 08:36:47 -0700
Message-ID: <xmqqbjbtyd80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> git branch refuses to delete branches that are currently checked out
> with a message like this: "error: cannot delete branch 'foo' used by
> worktree at '/path/of/worktree'".  This can be confusing if it's an
> internal checkout for git bisect.  Report a more specific error in
> that case to help users that might have forgotten their bisect run.
>
> Suggested-by: stsp <stsp2@yandex.ru>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Changes since v2:
> - Only report bisect runs as specific rejection reason for now.
> - Leave rebasing unaddressed because I don't see how to formulate
>   clear and readable messages for those scenarios, yet.
> - Collect all checkout reasons of all branches in a simple array for
>   easy use, e.g. to eventually address rebases or for git status.
> - Rebased onto the landed test_grep conversion.

The scope of this patch has shrunk a bit.  While the 'in use by a
rebase' state is still recognized internally, unlike in the previous
round, we guard users only against the 'in use by a bisect' state and
the 'in use by being checked out' state.

This is probably a good single step, so unless there are objections,
let's mark the topic for 'next'.

My understanding of what is stopping us from taking the next step is
that we do not know the exact phrasing to express the 'in use by a
rebase' state concisely.

Thanks.
