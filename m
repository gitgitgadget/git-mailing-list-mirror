Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AE3C8C77
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194220; cv=none; b=Xf6Jf9BB/uHwJywebXwLtQAFBP6aBDFu1sDjx27vlp2DvhPnDfbhc14DjiaBG8hYROOmHU7ZqkxfRZqNp2qjuae/+fFH4tlG3x7p6zwqzWDGlqA2kuzJmqKPldZesHVu0x6aetKCcBwPACiRrLdfrLAjbr8XoTGyTYKHXHwMWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194220; c=relaxed/simple;
	bh=hkutSYs//ceA8R3vIRH6bDq/lYo4qcQU2tPAr73oY7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLs9CH44hAO7shxRQZJQoUuqXlzVc4Qjoue2pVDEItVmLqna+HYrejlA28CFBqEtWlS+1G3aDSVCkkgHGmL3IV7zvtd3tkKooPMIm4kKEmzXQShof+T2QgxdawyMDRUYhuFwqjp8Da9fcCU2Dtndz+BO5Qqy3Lw3F7ag3Gbc/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QMOSui6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZgS/lVi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QMOSui6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZgS/lVi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F278DEC003B;
	Thu, 11 Jun 2026 12:10:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 11 Jun 2026 12:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781194218; x=1781280618; bh=8j2n0HPfPE
	ZMMSa84/WDwE4ukwGlXMBv8w1A+ywj1u8=; b=QMOSui6kPJCKjyiV2YanD5xCVP
	HiUev0ddgFcDgXR/tVkUNtYyRv69+WLKo3MzOgemUN2B3s7fsrm/uG8vlTuvvGZ+
	6jMEz0hLf0eZG3+6YUa3UWlQKiz5D+T7lppERSSXFoGWcwXNHxwOS9fpYkQntG/D
	S1eMFgdZGt1aZ5XkF4UTn2swf5zBXVz2Cx6N7L/88isJRmnjs7ihzsrHmghUhiT5
	IoFd0NwlxGC1cDfS0q5vzdDilYUzSPjA4v/oapmcWEj9wMz6WgqO3xIQfbiQQARQ
	+grn4PbdDWRXaFf04TPqdeL/ZfyL58z5bVBeH/9h9QZhPEMYD5mevE+5EdnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781194218; x=1781280618; bh=8j2n0HPfPEZMMSa84/WDwE4ukwGlXMBv8w1
	A+ywj1u8=; b=AZgS/lVidUiP8BrLmuQur8/+6viVLA34KMVBTmrGYVwl7AOGm1k
	wjE2Mw2ZOaY+V2N9AuywIalK/9vyJhu3tqZwM99Jt9P1kUURFPwg2Ycd2wZszfO1
	+FMMcSm8rA+TAF02NMoa2ipuX4XcQf0jBBpho7ao/jcNeMxpKJrunZ94lfEV4zLU
	oFJAGCOIzgtcNNnwMDnE89cssOQa/Mk2ZGRdkiTaf2uDtKYEjlQuOamtO4GVR8bX
	VMj0iKiHQkSXlVS4lkbxr4M1oOpeugcySygP25K6rgpARZwAnrAf+BoNuAzynRui
	tvHuqCJ60oa/dm3XByYjIQnbmOu0i2Y4o8A==
X-ME-Sender: <xms:6t0qau-adwRg12YMKN43h17AQbmwCQKuU4NhtjuEoqFruRyFWOvnuA>
    <xme:6t0qamKpRSTw1sCZjgf9X4tSH9ly6aaiwieokCHOZtdU2Cdk48Jq1CNXxGd8OtUZ4
    sNb9dDJ7nikwc1TDJ1-5IQpF0blnKOsYH52PnnOiFz7dmw60GZ8u4s>
X-ME-Received: <xmr:6t0qahYzrV6UXQzA5uhB_mKPCcXUSqOqQQDbdS4Fzqzv78VLaSq8Fe9CcLoaLj3MtTBFt7G2KTxfgiyb7yEgc3GRB8XlzzS7MHL->
X-ME-Proxy-Cause: dmFkZTF8jbgrE1VDLfuTPbuSMFKN/z8WdPM0dAjas+1AZmyyAk6WpMOjWo6el2FxDi4amA
    Xk8Gd3LcGK83nbQV5jOMK+0WEbYHlqqdnpSr05STPioJA7831O5NKXUZAWhZSO+/IR/lVd
    zHeU+W7BvL79XORFbNZBX9YwNn9pInSjEYbMkUynkO87f8FsfSPCj3IR0E6k/D6lCHiKVq
    Ud9jN3K74dSvIoIbR4PkBMUocKt6TEzJWsbbL7FvRKXOFiP1AazHcOe11G83Mc66GmmH4b
    sKJMHmpmhN/TtwmagPPnfsUWAuV86fcDAwoE9uPnJYAygMpm07IJbfB6og/eLImxCC2eBg
    DXq1qltYRFXQrLZ7Wzt4RuiS6NiJ4yVN6NVaPLX29HoR6MVw0tP82pEk8ML2uLdVdloogY
    83oclLa4WvFBgihKYpr8HnDFCC8bruuDhtXgqS/FfT0+/99AR2JNpNSKqAXnFZjTPWi8yX
    K8pzqA1Y7MDTBg5jY196KsXAMIVDvabbXMhwmc16q07/4QTg65mBe3vtsSnJRrTuXJBW1h
    OwcSk55t5MSOeMqse7UtIc9lU7ywe6l23zewvFv05PYnbU85zHwJFFKvVWGBvpV0peSrad
    JOB9clkcTVPL6il5DoN6cotD+LzqfJ1Jah0rm/gOIPKhNb5IwrpPWY9UxsZA
X-ME-Proxy: <xmx:6t0qagIItwBcwH0UxlQEPcLdFhOJm9A7CeyJjEp9sdyXo047JayoGQ>
    <xmx:6t0qanCwWUdxs2_XKtzPbZ1_IgL5juOilLDVz7Idyy2hG8GjVRoctw>
    <xmx:6t0qatpAhsetyvstGftTkjMIDdnFwJXjXfMDueVDVP33EbhX459F2Q>
    <xmx:6t0qaqiCONVIg0CygOQ6WCE3_4T5n1wxVYRAzNh9iv7M7SgAf_iH7g>
    <xmx:6t0qaiIi_tufGjJ1yohseCQ38os0MO3YX8aW2CXP29DKCA0q6J53jOjc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 12:10:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #03)
In-Reply-To: <3f10ac4d-45d1-4ae1-9079-17d7b52cc7e1@gmail.com> (Phillip Wood's
	message of "Thu, 11 Jun 2026 16:26:22 +0100")
References: <xmqqzf14tttx.fsf@gitster.g>
	<3f10ac4d-45d1-4ae1-9079-17d7b52cc7e1@gmail.com>
Date: Thu, 11 Jun 2026 09:10:17 -0700
Message-ID: <xmqqik7poy6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 09/06/2026 01:56, Junio C Hamano wrote:
>> 
>> * pw/status-rebase-todo (2026-05-01) 2 commits
>>   - status: improve rebase todo list parsing
>>   - sequencer: factor out parsing of todo commands
>> 
>>   The display of the rebase todo list in "git status" has been
>>   improved to correctly abbreviate object IDs for more commands and
>>   avoid misinterpreting refs as object IDs.
>> 
>>   Waiting for response(s) to review comment(s).
>>   cf. <xmqqbjdwcsno.fsf@gitster.g>
>
> I replied to that message with 
> <4fafee2c-4151-45f4-a842-17d6b77d951c@gmail.com> I'm waiting to hear 
> whether you agree that the unambiguous label case is unlikely enough to 
> happen that we can ignore it.

Thanks.  

I forgot to send the response to the message, so I just have done
so.

