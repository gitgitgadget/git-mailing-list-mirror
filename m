Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A934BA4D
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908445; cv=none; b=aQz3KancwqL0x/5lsUGCryVEHK7+V19BB1cIiYCzS0A1ptggw8sveEvjLRohT8RoKPeADJEkuMDXlNl5dG03uifhDfTeC2K6eG+8E6Lvd8Rd28WLPAjjep0sFXgXDTeOGiE2mpAo5Cn04F8kOdmBYH/v0xrKCmVw98LWaegSYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908445; c=relaxed/simple;
	bh=//C1yx94asv6+4oXJETLNJrlWlwHegiag1e0B4bXL6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJeaHIBt3KYL/QBcNkQen1+L7RAu6xWb1w5JGLQzHmiDZL14BbGpjez/iIOUnmW3lSfECvEWH0L+hEPVKMT1Qzk3fkkL8DlXOGvev6HDNBC99Cvl42fWuXUuEoR/of8uKUSCuOTxMV4Q1QVDE6MxGt4v2h6ILLUgPu8PiNR64Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gmEQz67/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmkzc2Wq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gmEQz67/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmkzc2Wq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 724DE7A0041;
	Fri, 26 Sep 2025 13:40:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 26 Sep 2025 13:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758908442; x=1758994842; bh=QcJihtF++8
	lv1amX0cF4qS3/rNDVgOR7glCtOXjz2vk=; b=gmEQz67/cUmNIzSTo4fXQOUtub
	DL5zvqhN3RywXrtGHfxMuUEMbLXv69htscelGJoZcIclO4rUE5so8d2s5o/Nowxp
	5uVBcXv5qOmDWrVYtZxfyivNLhlZ+B6AMhZ+UXTU0YV1QLL9UvMQjEzCXqTwGsDX
	vCpW7HQRG7qMgeplruhQQRZ1EU+CuptIEIg7UDM/UowGH0GLbcCL9BP5X0Yvl3D1
	YOlzSby+5GAsiNpVhZrqgEwYBJiF4W5OPvAARiWjeAsRvGybaQtot4n6ngp/oJwh
	FS4eKTjZprGnWmBQ/6KQXsGpipBoeAKnDL2m3WhHWMefs53QWV4ErmjyN4nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758908442; x=1758994842; bh=QcJihtF++8lv1amX0cF4qS3/rNDVgOR7glC
	tOXjz2vk=; b=kmkzc2WqRcCUv62fQeJAn83rr4YnvUhD2J8rMyAm2yLuuzloPiD
	LHDiBB7645TCeA8OIMZwpiILVW2u6zxECHH6BMjgPPHBd0Rjhyj32uKnCoQ/y1mQ
	pezIm/E898vbh/71n5KwFZRBVT0Dqb2AT5YAe5l+QpwXer1WSJej34ifiplUMn6N
	h9NqupapgZEOY4eQScjK21skdxcvB5BXF+BuFIZyw3Em9RsLV3MwuUeQNalFgPr9
	Qbis1brX61IdIq5A+dIuR8XicloEWEWhR+lYe8j6qFjvxlnzTbaDCiIo9XZWfdsu
	cG9xoK+FpKS2l3HRRdbpoBjwUiQ1NtpTQNQ==
X-ME-Sender: <xms:GtDWaK3crPEoyeedJcl3JdvUISN55Vuq5gr0YxdlsHKILMZ2gVQ3vA>
    <xme:GtDWaEEkiA2NfXKuiowYCd2BcMbMj7KpC5gEKF4ND02xxHva8zVHmAXbf4QY-7wAb
    0FcrOZwoJu8pdS7KXU4GwTw69nDBbGYXIo8f7nwbguESHMa8I34jw>
X-ME-Received: <xmr:GtDWaH7jX0shcPZmdofhG3qiGuX8dAy8Yu1ytQ2TajvsioWSYUG-2SlUE3fNKYrIjc7EB-_tz5Z2wQNxj0iUaK7rHPXP4IX_7H_->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedukefguefhhfetffeijedthfdvieevgeefteekteffhefhjeeivdevtdeghfdv
    keenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgrhhhhohhkrdhnohifnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GtDWaKsefxP3RCCnQwMaq6dfn7rXK23UYFLaXwlC7wgRHVoiLTR7NA>
    <xmx:GtDWaI7mkr8ziKg2KMFKl656i5V4_SGsKCjg2qV2a2X1AfNx8H9hTA>
    <xmx:GtDWaFUMLoqLfVb1dXFz4_IcRX93xP03X4uNdMowNh787Sb4vqWdpg>
    <xmx:GtDWaK-x9tBl6yg4k-xlfpjU2CPXYoUPcaRNJJ4A4UVhIZR5mxqY9Q>
    <xmx:GtDWaFTn4BDYk9KuWt2ywJ8r7-ZJWyGpjkZmOjZLDPmBUkerbDOMkm51>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 13:40:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Fix curl_easy_setopt() parameter type problem,
 again
In-Reply-To: <pull.1974.v2.git.1758882772.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 26 Sep 2025 10:32:49
	+0000")
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 10:40:40 -0700
Message-ID: <xmqqo6qxaz8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> As of last week, every CI build of Git for Windows' ARM64 flavor of its SDK
> started failing (the first failed build is this here:
> https://github.com/git-for-windows/git-sdk-arm64/actions/runs/17633130672/job/50104373185).
> ..
> For the record, these patches apply cleanly all the way back to v2.22,
> according to git replay. I did not try to test whether it builds, though,
> because all kinds of stunts are required nowadays to build this old versions
> even without any patches on top.
> Range-diff vs v1:
>
>  1:  7caaec9102 ! 1:  114eb9c8ec http: offer to cast `size_t` to `curl_off_t` safely
>      @@ Commit message
>           naming convention of the helper functions that safely cast from one data
>           type to another which has been well established in `git-compat-util.h`.
>       
>      -    With this move, the error message can unfortunately no longer be renamed
>      -    because the `_(...)` function is not available at the time of
>      -    definition.
>      +    With this move, `gettext.h` must be `#include`d in `http.h` to allow the
>      +    error message to remain translatable.

Ahh, OK.  Now I understand that's what you meant.

>  2:  e1d5a85f70 ! 2:  fdd1327e7b imap-send: be more careful when casting to `curl_off_t`
>      @@ Commit message
>           imap-send: be more careful when casting to `curl_off_t`
>       
>           When casting a `size_t` to `curl_off_t`, there is a currently uncommon
>      -    chance that the value can be cut off (`curl_off_t` is supposed to be
>      -    guaranteed to be 64-bit).
>      +    chance that the value can be cut off (`curl_off_t` is expected to be a
>      +    signed 64-bit data type).

Will replace.  Let me mark the topic for 'next'.

Thanks.
