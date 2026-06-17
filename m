Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B453B71BC
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727766; cv=none; b=R0vaWqakxLYO5igfte/8E3oIMZjxU9JP26Lul6u5qp5ntKav0a7Q4LMpffsPldY97//TEuXzqLoFmOeTG2ikTdGx7E5co3cDQuBOEK0VtiaL8tmqvO3PSJgTpbl+3G5cs3WmiyKPCXkjXGgWvptKanwdNC9ZTwL96Bvt59X4uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727766; c=relaxed/simple;
	bh=U5JEQ5kG3NmUVow4SisU61FBCMP+wWO1xKVY1+JLgRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnnVTLiqV7ytJQ/xrNV8l/9zcxFN3Ed429Bj1kUuvqZnr9LtQiuJgxPTmS9+CHB3BQLouOBiySbOvKbZo7SpnfnJzd16BkZyc38qocx7ak526HfgKwwmjuqNP/Y2FSC5cvXz/amq+DSl0khxpWmevGJSgArnP7e3ucF+3LpBjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n9dQfkjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5RyfTf6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n9dQfkjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5RyfTf6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FC4F7A008D;
	Wed, 17 Jun 2026 16:22:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 17 Jun 2026 16:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781727764; x=1781814164; bh=qayl9kRsRB
	WA9eOic4m1UYwhPXWF1GVn5IwdlE3nwKY=; b=n9dQfkjz+4H+BCNHNkcwFsdXIj
	byI+dvY/rfekwlIra4GuKb49FyQoDJiV3xOEslfIK16viURXJnDvu9DqHm/ZttuK
	ASV4CQ+/CrwcqPabov414lwIw7ObJqYIsnsaroi3e3a7TZqVi0SyhfQXfHpZXuiJ
	A+v9Cw1dQ7tGIvKG2MZY7QFZHdcJ9VjEVdtAgJxzeEzqM7boVn59+E3UxCVcpsmf
	glgAUFaWDB8Tx/pMpdbJ1xhGv7/CZQwneRDrFjrzY/+tlgCemrMqQrpTKS4bCwYs
	JBPB9AiLN6I6LJFUw+BfE4XLG8q2VVecr34nSk24ClPK75zZy0EgIbGGW4Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781727764; x=1781814164; bh=qayl9kRsRBWA9eOic4m1UYwhPXWF1GVn5Iw
	dlE3nwKY=; b=Y5RyfTf6LxYbIODIZ4uGe3EXQUltK4b5JdVMnYGZEFrjaxEJvXE
	3P0wEn29J5VJSkzOo/jdEjHmiLtLszcILYN7Gryp8st/cdcxfdJJce7ST/nPGKec
	pvWLMe4lWMR0zdtBCuofmE7Nk0trpEdC8q8126G49+SR6B2A0y0UgUj96Y6jqT+n
	CPKo+T8mWyy4GmxkMfSWZQmIWbwL5QM2Q8gHvLUyeF+NgzykiSs1M2QeEQJcvsdg
	wHBA/0nRHJ4AIzf3TRh37vsQbRg9x3NKIGQQxl9a+ImnUUr+NnCtkzdy2gCX0gVm
	q4E1+yGECrgLpSI1JYmk675/WoRA3y3fBkw==
X-ME-Sender: <xms:EwIzasLv6BtwbyyxZj-hrc-Vhrjb7iX-Uq4g-FlH_7wxWiPJ_Mrcpw>
    <xme:EwIzajBIm4dSoEbUdSwDTKEPvQaMzekXaUhFxHB7d2Q3tIRQeadj903f5yvQl2vNM
    QrE5P-LZcP-yVP99ZHcCjIN0EYaO0bVb0oAUOOJVju6G2lyImGL>
X-ME-Received: <xmr:EwIzalBvSw-8xsLShET5Wu0V3i_mIkYb8hmJsa0FMnnpTVPx3JInvlkGq20xHvmj12Of-O6YqKXuFUGHCAXOo2KIl19tvaC8_V2I>
X-ME-Proxy-Cause: dmFkZTF1eBkIFOqK8L+tiuiAFr/17KsHX3mPUlSkj09nR9/aF6mM2U4A9vhsBMw9QZqYrU
    38rwBEFifLmAQXQdQzuV0gSOpgO3sIIO0V+npU6T3emAwy6D0H1QRUFtwls6BAhxXdh9wG
    ckRHIl0CAhL1yogPX6lXtw6vbKpXgdI/QmHzwMIOcgoIFmFLOSIGkfF7l0EnbYa6IGzbqK
    PEwK9Px8IbVRrPGUlPUEKsWVh0QDZx1fF4jEw0FbsiEzeoyGGiZ4ViOW4/6Jhd4BbSkNlg
    0UxVmMqNPOX9Or51ktqHRWvjaAKmCc3uYheLMcSc9ktgUE9IxCJmOyQaWKSqG8I+E4aaj5
    jOc8ZtXrmb2J6p58J6nmjtLYQoQ9nFP1qtrye406ZTem47rjK02Lcn8kAGMrWUmmejamYE
    kg+w64SyHJ9hZePYXY4as/C68O4IsocGft7L2lOGX3vfAR6xIgTKJGorGwFyZo7yDFM4Va
    N7yWzsxWR+X9eIiRXBnRPmSRx+t/q6MvaXNpAvzOJS1Yz+RwYgYsoH+DobHUsq3JzV73im
    Pn9rzwrnQ8wPyRNskQrH0sjjXje+DnWrfYcrp5Ol3OikEc0D5h7XStXp+F7Ob2XhwVRzn8
    6iNaz62UfH+346+VpV1I4FEOYXxago6vwt2pMuxo+0VfsfIDuBtGXbFgCaXw
X-ME-Proxy: <xmx:EwIzalBvgcxoNWicjbN_eyG7Bx2gDMlgyMQ8NedAsZW_74Q1eT5fMg>
    <xmx:EwIzagoC9I88aiUs_R65YeYveH0ZAuLkCX6m9pdC951EvI93oxny5Q>
    <xmx:EwIzavkz7hU-kNt7zNVzaO0Wx6hmGYJgFGQjxi6hMvIw3Lw21Fev3A>
    <xmx:EwIzagwf44buJi33ogXC1yGYeB5Ap7pY1edIXqfgjMxRtlg4JCHRzw>
    <xmx:FAIzalgHxXTRWnK-g1YCwut2Cu5XrCNtRUoNUdPf44zH6ectSDqqbOi_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:22:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] config: allow disabling config includes
In-Reply-To: <e88c6e7d-1236-4595-9dea-26c33eab6432@gmail.com> (Derrick
	Stolee's message of "Wed, 17 Jun 2026 16:21:08 -0400")
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
	<20260608225149.GB340696@coredump.intra.peff.net>
	<4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>
	<20260611083943.GJ2191159@coredump.intra.peff.net>
	<539713c4-b291-42e6-8541-a16a454518f5@gmail.com>
	<xmqqzf0tuhfm.fsf@gitster.g>
	<e88c6e7d-1236-4595-9dea-26c33eab6432@gmail.com>
Date: Wed, 17 Jun 2026 13:22:42 -0700
Message-ID: <xmqqik7gvrvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 6/17/2026 2:53 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>>> On 6/11/2026 4:39 AM, Jeff King wrote:
>>>> On Tue, Jun 09, 2026 at 08:59:22AM -0400, Derrick Stolee wrote:
>>>
>>>> I'm not sure I entirely understand the problematic case, though. The
>>>> user points to in-repo config (which we already tell people is a bad
>>>> idea), and then that config breaks for some reason? Because the include
>>>> is relative and git is run from another directory?
>>>
>>>>> Or: are we venturing into territory where we don't even want to create a
>>>>> new foot-gun? If there were another way to solve the situation that I'm
>>>>> facing without these risks, then I'd be open to it. Any ideas?
>>>>
>>>> Yeah, the more I think on it, the more it seems like a foot-gun. Like I
>>>> said, I'm not sure I entirely understand the use-case. If you could
>>>> flesh out an example, that might help.
>>> The case I'm struggling with is that our build system has sandboxing
>>> restrictions to make sure the build is deterministic based on a certain
>>> number of inputs. A tool we don't control is calling Git commands and
>>> these users with included config are getting errors because the build
>>> is looking at files in the repo that are not registered as build inputs.
>>>
>>> Files within $SRCROOT/.git/ are ignored as "internal to Git" but when
>>> the users update their config to include other files, this error occurs.
>>>
>>> I'd much rather that this tool doesn't call Git at all, but I'm unable
>>> to make that change to a third-party tool. But this environment variable
>>> would make it possible to disable this behavior. And I'd also rather
>>> that these users don't use includes in this way, but they are using a
>>> checked-in file to share aliases and other quality-of-life things when
>>> a human uses Git, not "critical" settings.
>>>
>>> This series is my attempt to see if we can find a solution that enables
>>> this behavior, but maybe we've found enough concerns with the idea that
>>> we can push back on the users to say "stop doing that."
>> 
>> It seems that the thread went dark after this message.  Should I
>> take silence as an agreement, and mark the topic as retracted?
>> 
>> Thanks for an interesting discussion.
>
> Yes, consider this retracted. I saw you made that note in the What's
> Cooking email so I thought it was understood.
>
> I believe that the risk is not worth the reward here.

Thanks.  Will drop.
