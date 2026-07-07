Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381034A3A5
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448166; cv=none; b=FA+B+N5ar52sjG5HesMprTA/+diie4ozeaGY4MTOC3mS0HJ8xoms+AY4u5f+lVn8QSOLPEnKNmLgiusEzwtETTziT5VJlYxxAQbAGs8egWJbRf6YDpzJ0hWDpLW2VVvwMjeRxKhI1GyaWwHd7ATMKdOI4mB5mx1nagR6JijQO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448166; c=relaxed/simple;
	bh=aTh7UmlUtyL6ZXz54kwsYotqMohAUSQcbtBjNpsMtWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/rtXhdEjCbqPB0C+XwNgWtIK4qDWFHx+APCBTkboqBV8QthXbL5GSZln/YT2C5V/dGAZDm7T5/tyPI9Tf7DPd8YdijjjztQRNPlr5PsrROAZDDRyLawMI9o4t6SPdeN9yVvw8B+21q5ljwZ86Pi+75V+q3aq0pEJ6BvJq3rzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wdy13OTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkxadn8C; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wdy13OTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkxadn8C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C4A2EC00F2;
	Tue,  7 Jul 2026 14:16:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 14:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783448164; x=1783534564; bh=DUMDdRprU2
	lDYuxUl8w271fYrp/PyNMjk5993rwQ6jY=; b=Wdy13OTLCAHT92nqRt/QSVJM4J
	CjL0Scyumldf2vW0Fu/npX77U6KC30UUbGwx+J8q/gBNBp0Kuw9T8IFJhIZGm8vo
	12KgE8852+ZUDYajfd7+GiMr7MYbFTJWPr/0JOPeNoEv9vUdlar/lX11b+2kEp5E
	UaCSOLOUwuuqD8HWlKyTfg0Jv581IZO+pm61P+8DZg54nBVGu6/df9qVPe9PDofo
	/E06Ycd/LMxQiKk6oLX7qsvGZujrNNTj2u+NF1NeQ80aUqbeKKQrSMYYvkdk7PEo
	kuVoW5x507ypRo4fKLmZqEqAZjMsUqb45qK8fd9lQXykDqBuulcwFD4ynjHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783448164; x=1783534564; bh=DUMDdRprU2lDYuxUl8w271fYrp/PyNMjk59
	93rwQ6jY=; b=dkxadn8C5rHjt1zUqsnFRZsz8P4V09hGcfZ1vx/d8E4oxCNIhrF
	9udtQAZTP8lsqcDO+Y2v5J/0HqN9CtukLeU/5Iqmy10It6bffiO5BI1/5QTGVCE/
	HlRwqnS7j3kYuEBuK/ZKYj1Xb5ZvA0sWxt+hfHDZEYUJ6Bj+gh62GGXRnzyyDvww
	6uLAvFNTXBzHL/OdgVnA++a0rxADkg9nALqVrSq3MZl1Dgrghp4xjSW7bLieLh36
	yWhtxdWm3w+zmtrrBCve1xhN50bvQO4e/5ygh9xPtx8H5LqeYtFCiKUJ0sN1CGGa
	2mMMeFnWX1RFPLuVNbsGT+xdFPZEIvOK0qg==
X-ME-Sender: <xms:ZEJNao88o0kELbpyWyCYV4ceXVB6tLPw_Mc5VL0hJCmgqWMcdMaW-Q>
    <xme:ZEJNankp6vPqD5LW_5xldqvUUKtvyq0Mn1zqjK5I0Fsu566dohUbcedqAx9XEbn6x
    vqLToaz1yhs05V89eG3EhYRR2toecc9oPd5QqUUJeK7jVuewi3-_g>
X-ME-Received: <xmr:ZEJNamXxlAgW0XanAqfJ5sLl_VRtxlzpyi9icoeoA-ppaPSyStnknTmI0MTMvD-Jbk4cPTq8o3E86BqlLboApUH_gmwZ-RjOiOLlHKI>
X-ME-Proxy-Cause: dmFkZTGlsYPTd7hB20oruEV2WO2EpoGytbEijTl+sjboDW/xsB0WA5UN+1PTSGgUmMyrfE
    4qgoke1jYc+bmUAApIL3Gi86K7SH00rxxmOCzEErEDJ6OBq55n3N83vFl6g380NUCtAOQN
    v2dDh24jv8UVK5lOMuNJk9Y311Djv8Tbhs4uWx4VLDbYlaUbhaHiHx3bfODa3sBUEYRvxa
    G5302j/6wA5yV+T8zlNptdFBNWD8XmtTNO8Hl7EXsyRTtVFu4xUT1CybOnYqJsb3KDSvj/
    A5nGYi/Eq55qoBx1r+VBEDy0BWmUwpNR1VTDt3ZLzRnPTWUe1TN2NriFMgTnzu4fA+ffDQ
    +BkQxCJzccHZ16gfrF/qmS4iQEhRqM9eUfbq9YqjEUJR9Svc7lZhpZbn0cVbKoIx57PkfX
    jo30ACw6kPNDduUk1/WMQOBzUVaq+vvfrhCUKGNzuxGlNAHm54leV3peGZpXKAvoIw2sKz
    oh7NGXJERvWE0veTBZELczvAzFMNU6tLGmuLhridT6/wikga60X/4croMB6lhrtX/zCkuH
    8RVtivx0+iJcOHUmdic1u2tNrGOj7/wHkcNZvIw6vCSJi6BQNEruO0IsPtFsgWwfjKK9ah
    wOtxLyRziC+QJMRplSRgzJwmL87nU1tAalijVoDoc+Ogp7pPAaHeBrfo2utQ
X-ME-Proxy: <xmx:ZEJNakGwCB3YxW49Ne5pZWNLhrwRnj_h9OgeS7N81OG5-2wgIZc31g>
    <xmx:ZEJNaqcuDzrB_zbsdx6UtEzh_9ksOnJqe4qfTdVJoD6cf6raRA8XlQ>
    <xmx:ZEJNatJAUTQxTK-2hwh3tJyeYWNe8ckqxui174ICRjExQuCkplEHTA>
    <xmx:ZEJNanGNpnriQkjchGJQjz558vrGmSjivQGUQR2_9HmI7hFNC5nTRg>
    <xmx:ZEJNaiJBZH2Dz1Y7rDPABORRH0DrHetYg1TyfcYEZ_1z5web8BFYtKU1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 14:16:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Joerg Thalheim <joerg@thalheim.io>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <10bb26f4-38e7-1bb8-d2d9-4d3e2ef52adc@gmx.de> (Johannes
	Schindelin's message of "Tue, 7 Jul 2026 13:39:07 +0200 (CEST)")
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
	<20260517132111.1014901-1-joerg@thalheim.io>
	<f449d0db-0434-f870-c69f-793f2b096816@gmx.de>
	<10bb26f4-38e7-1bb8-d2d9-4d3e2ef52adc@gmx.de>
Date: Tue, 07 Jul 2026 11:16:02 -0700
Message-ID: <xmqq8q7m4qe5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 28 May 2026, Johannes Schindelin wrote:
>
>> On Sun, 17 May 2026, Joerg Thalheim wrote:
>> 
>> > I matched the core.filesRefLockTimeout naming rather than reusing
>> > microsoft/git's core.configWriteLockTimeoutMS, but can switch if the
>> > downstream compat matters more.
>> 
>> I see that there is quite a bit of precedent for naming a config setting
>> `*Timeout` and implying that it specifies milliseconds, e.g.
>> https://git-scm.com/docs/git-config#Documentation/git-config.txt-corefilesRefLockTimeout
>> 
>> In general, I am pretty wary of unit-less numbers [*1*], that's why I
>> chose that "MS" suffix. However, the prior art in Git is clear, and I
>> should not have missed it. Therefore, I have no objections against
>> `core.configLockTimeout` as-is; I'll take care of providing a smooth
>> upgrade path in Microsoft Git.
>
> For the record: I meant this feedback as _supporting_ the patch. Now I see
> it is stalled... I do not really see any reason for this to be blocked
> from promoting to `next` and then `master`, though.
>
> Ciao,
> Johannes

Heh, this paragraph

    microsoft/git carries a similar patch (core.configWriteLockTimeoutMS,
    default off) for Scalar's tests. Defaulting to non-zero here because
    the worktree case fails silently.

in the proposed log message was enough to convince me that you'd be
favor of it.

I think the "Waiting for response(s) to review comment(s)." is for

    So I'd rather lean towards dropping the cache and keeping the
    repository parameter.

that was expressed in a separate review in <agrIrGwSMFlKTx9x@pks.im>
and haven't been responded to.

Thanks for pinging.
