Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8737AA64
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300231; cv=none; b=E9zNJfhb2x+GvLzzzojimrMJpOHsffXuf3jWRKlD97sUfL1v7/ifvVJnSH8URj/1xHaWmzUDr+dM3DdTMBuupbBz6CZ2kmzljIiaU6G4CuhxZK3xymLtCRRREXEZrgvTJaEuwL7wDSMIdIXaDYRAe80oz9ig36IT3g7dq06E8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300231; c=relaxed/simple;
	bh=LzG5Fh5cpp380jv0W3wuiKJs3LzSHdx9eKbiCWLOhws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtkwiZ0Hjm72r7Z+issNtBDEDoSCo8XOnZ5H8/nJOCUjVnLB7LX62zkDZpuNZkowTPqaELZy64yvKMB3Mn3M9pdLMoGB12tqgsE53CetZfqvPqrJfx6NB1D9EBANf+lM5/1tMgepGIeHGrq+iyo6BFXgiRhdWDylvlrh7gOD/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d20ZByDL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KEd/fEcj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d20ZByDL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KEd/fEcj"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C301914000F8;
	Fri, 17 Jul 2026 10:57:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 17 Jul 2026 10:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784300223;
	 x=1784386623; bh=qlByg9lxXbUs/AmEGY5iCx/LwJoNN+OCuSR9Qmfk0uY=; b=
	d20ZByDLLk+DysW2AKhJb/D2u+Xj45KDSfq7cZnw92qjzExC2FA1IraA67MpFTVl
	r7UrqRRLCPSFPuFMvUy/9M7AeSTunulhlZroy9qfi9rend+mBd2EnZ6cLNTQeUek
	QwyoG/Q7ecxC67cxeHulsMg6q2Q8EzgZSpCmaerpTBaue88ihKkrz4JnJmjf2j7Z
	kbgkFLeMioNyNL+4mOaopWpF5zpH6KifUVoLfDNtjcybuntec8B9YdL/FBuBdedc
	nSX12O7yalKrOd7afi2hgnCxoyf3cjBdkogfdiKTp27eamZDnF9meMtslF02bo+O
	gtmYpTRHxnh1s/DzEHuI/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784300223; x=
	1784386623; bh=qlByg9lxXbUs/AmEGY5iCx/LwJoNN+OCuSR9Qmfk0uY=; b=K
	Ed/fEcj2dBEv588Qr8pWVhQam8qLQY7gw/c+FsN3adO5i56MYzlJsjiu42rfRNLk
	sHqc4lH1aTIBTxxKqINHvrqhNY2fsRypPOHRQ/ewWzQofffy9taeMIqu/MLziTJJ
	VhwbC755qGL44XKndfv0r44ibI0LCJXMDSgLPPmE0AJvOmDXT7qmZD9DGnyLYrYx
	Q9uwzbfaYL1WtVQwdAMRYnSqFhYLbNWZNuDdvdGE8wvRQfl88V8rx+ExwAS24T2B
	QA1I03MOCmqJR7gb604TZ3G2axpBCCvV+m2nmQ8dFrfdse453e12hejoTLx+KuZG
	l0MEFNbzr26BWyNnl38yA==
X-ME-Sender: <xms:v0Jaapib8WNbM57yARPP8fjMgCd4dIzP5-G0Sr48D8I8qOq27gRz_g>
    <xme:v0Jaak629voZQXCQQ_YaYnMMvhtmcgHx6hJWVKiql6UH02P1D_dSRmkDGG_Rwx68R
    rGdQaiyKOHnDw5KsoVt3dwLuQ5VTP3CkSShBN-DQLXrak5RDEop1g>
X-ME-Received: <xmr:v0JaahZG0NnUUCP4jgdZfmCpDVnGt9bZzih49knNb_kTj66YDVaq_StjZKnMzokdt53WkMVhLiiNhIQ9QrS1FWUt_Jx5kkd92Bs65zk>
X-ME-Proxy-Cause: dmFkZTE38zKTtQ/b/96VLTYLYoB9aIwZ4dDmfjQdk8qXOAcRsav5Car3W19sXVeUvNz8LJ
    6xcG36njvF7f5v7nRZES5t3trrHT3cpZ0anF/5myfo6gaIl4IbJK//tjn+8/2qAXZaF1/a
    4FeP8K6Dn9KquKAgM/NPZBDbR2fWHZpiyyOXaQRv6ENzSNdTT0F7wKeTGjjlgSobzhSbUc
    bIdBU53Xbv1//5UxQzDBYJtnEhIWwskVVlChOpHiIzvJHwCwpKC68tpMgC+uOtTlwKIKAL
    1416B8EqWOZg2Qm8+nLlmW51qnV7Y2uCg8E+NI1EDnjkrMVicamC/kifoMajS1sz6rOmGw
    umwER1ZEQpstCq4+A3cNGvFICaLZ8TyEGz7y5kN9xfNlBP+f+b/0ph+jn32fyeYnzCcW6e
    UJ4a/xKdT7Nqt5aa64LBVXqDdibUOemQm6C/NdBk73PeuxLw60CjWivqTS8MrbQfDgfOL5
    MRyW2WzvndGyhHHYvJGLP4cMdCFpJwHVEiyo7HalARRfLSso0CdIbYig8kzkNtxPQfBsvK
    qDUdGAGwX/aBe05N+MFZjTlFeMi/lHlhawwZoAfC01jN6+Sh6Bznv3mPU/IM8ZruBFnXUX
    PHz9pixDozWUK00Qh988ZLP9VECoXMbmn928PPrgJ3+vRDpfB7BJXRV+Ni6g
X-ME-Proxy: <xmx:v0Jaap7FjhI8Kr2yxeE8pzHEBZ9A60MSeZ5lBb8J7KojI9uW36FojQ>
    <xmx:v0JaakDVE5PDfAfMcskSjGcABXCNOECRkqBTnjgd7Nam3E8YlHMHcA>
    <xmx:v0JaavelBYxJrgeIUMVvehmEYXLo7AGx_RnXfMOndIWpTyfbCSFg0w>
    <xmx:v0JaajLccDl0c8HszMXzdVAWGOAX5LBloREzTI4LIZhGoq4YkLahQA>
    <xmx:v0JaaoivPvMd3P6eEWAgBkZxOFcLXE_AaoO5-_O6EKJuR0rglMmIbZU_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 10:57:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <CABPp-BGdK8v8Qk5XB=QL_yJDPTNjSb2rN08GiPpK50V2gAj1QQ@mail.gmail.com>
	(Elijah Newren's message of "Wed, 15 Jul 2026 20:53:54 -0700")
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
	<20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
	<CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
	<xmqqbjcawnhp.fsf@gitster.g>
	<CABPp-BGxO0bd3UzDYNnhNUgDSKYwcFVCFsJ9rCzmNX7Q0xBrow@mail.gmail.com>
	<xmqqse5km6lc.fsf@gitster.g>
	<CABPp-BGdK8v8Qk5XB=QL_yJDPTNjSb2rN08GiPpK50V2gAj1QQ@mail.gmail.com>
Date: Fri, 17 Jul 2026 07:57:01 -0700
Message-ID: <xmqq1pd17jgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Wed, Jul 15, 2026 at 11:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> But if that is not the outcome they wanted, I fail to see why they
>> would feed all three branches to a single invocation of --linearize
>> in the first place.  After all, the command is only doing what it
>> was asked to do.
>
> Passing several branches isn't the user asking for concatenation; it's
> the user asking for replay's core feature: update many branches at
> once. Adding --linearize  to flatten a merge does have to join the
> lines which that merge combined, but it shouldn't also weld together
> branches that were never merged in the first place.  The user is
> combining two intended features, and the concatenation is an emergent
> third behavior that neither of them implies.

I am not yet convinced by the above.

 * The fact that the user ran 'git replay' indicates that they
   want the command's core feature of updating multiple
   branches.

 * The fact that the user specified '--linearize' indicates that
   they want a linear history, regardless of the number of positive
   branch tips they gave.

So from that point of view, I still think it reasonable to expect
such a history to be linearized.

In any case, I am not the primary audience for this new feature,
and I have no desire to dictate the design one way or the other.  
Let us hear what the topic author has to say.

I will mark the topic as "On hold, waiting for response".

Thanks.
