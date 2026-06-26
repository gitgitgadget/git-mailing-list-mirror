Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779C3B8D40
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499440; cv=none; b=j0xqDdT2uDZrhIFFArcv/KmVIrAlP7CzlLkxe+9KQH6tstQ9zBiSkflXwKWblOJkovK42otYBXnT5Sn1O08W7gEdXFKZZKtJyWv+erHEtRdrMmSPArxu5r0acoWtijIE5QKEu6cr0dHuECAnbPE8Ni+Dl5EQg+5hwKPJ5x7b+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499440; c=relaxed/simple;
	bh=eMVbSx3WmBOCt9oyuMvF/yml7I5IswEjMpGvxgbfJRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gB/FdUhzyb8tJUgMikbjbsaE3oSnNxJAK7q3BZ/A05jtMseQr96/onj1LRCK24baI6zfQV6Er0JBTELLQ9wnPCeLWTpSdYNpFOnCW9lakqnCbEUj2NJl5qIdNo0C9bbD48SbvYSc5GRCdJafWF5voCtcm0GHp/xkf2eM33SS8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JF3N5PL/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5Ux5MsF; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JF3N5PL/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5Ux5MsF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A5E77A00F3;
	Fri, 26 Jun 2026 14:43:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 26 Jun 2026 14:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782499438; x=1782585838; bh=+9FMPy1QHb
	FsuU9SIHaTe4VyPMarW+MG75U28k3WocY=; b=JF3N5PL/4uAFcO4AvxRcLfIjd0
	c8YBeGX1ForsXgVmw4EK8O+FdTPMj7ha+JV/wlyd/lb4vbJaCAmZnXn4SzaPiFOk
	ZQMePQNTOG3YtLBseTk+ds5qelg2uhH8BZ03wVDcRH+CpJOidiQcL70a23YOeNi2
	oPp7tvaoh4rywg0R7r17dQQwQTSaYntJUwuS4P1uuu1mEKb8AU9p6ZUtfR4JSZfm
	PH+k3Wotoucq939VEn3PZzJw0sZJ2ssPhsO4typuZVybuGJKjP0Cv4UIHK6GfbDQ
	bwjePFF9VKxw73P4b2LwWjKZXoOyblCIKQ4j4bFI53dFTE857yvNDTTgOyhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782499438; x=1782585838; bh=+9FMPy1QHbFsuU9SIHaTe4VyPMarW+MG75U
	28k3WocY=; b=G5Ux5MsFtW+8DtfXqAayt/mlu3FcJYeT3xu85vTFkrMRUha5/gV
	vXSy7lE4U6kLpSNrSyh2+xDM6TZsksT7Uh67G+kmoLhN2LD4NZb6QKSjP3Pt959+
	hdyxyfmx0XMn99Fs4p1ryTobEJr8t+IT/DAz/ftYdfrHN1Cxghwne0mkOCPYR2Gm
	cnxnp44B/3WGYJcMJNUAYw3y/R3blmAOK6vq+DSUAa2woMHUivTmf1SqVeEXa5xE
	02JS5/S5Qk7iUQwOCSztnzy7L+tpfKttc3/4g7ilH2+tCiEhImBfJF18ApjDyF82
	94Fnv9SOSb4Xu3Kp/45+eU5vcawzNbig7wg==
X-ME-Sender: <xms:bsg-aoAJW6DOHIqclP-oezbVLpBoV4Ad3O-QmzKow9VlkmJcBr1o0Q>
    <xme:bsg-auNMvcrWLCvyx4llxzxdktN08KDp1FZdkf-RYZ4KcC3ego5Rtzh_ggt_SGgU1
    tYVYhpYoYnJhh7OyfAyJXLaomPwE2sP1pizL0hyn_f9-FMzqxc>
X-ME-Received: <xmr:bsg-alYJtWmD01Nn6Y0AfwHGTt74vS2FuFhs1ibiD4o0qZPz96RIVxst3H0wh2oqtmwrIOn2Odkq1GXX6bl6AabzicCOiUTJ5Y7gGgY>
X-ME-Proxy-Cause: dmFkZTF0T1JyNUwvp348Vkros3GLzvTw34GDMCQnHAEilJNefAm+H6zAhRhxMxXAn89exC
    3xoE3u/f/Uy+QUkBFx/NS4i57H7RAiVmUjuvaD3C8xuhA9GNin9y4So/ZwEHK4RsaBoVvt
    ynQiKGTSJ+m5InY1+wkaxfUVZgSzqabH18Sb+hxevoOP5jax045Q3f3XZhD3LJYovxIU3M
    pyy+scw8D/C6n0HOUFyGsK/igVChV53h3lJGSF2PuyHPzJP/I/R0ctuz08DHcwwNS772Tc
    IWfUXfz68dncj5s7Y1yjUs+7Ww2rcz+LeY9Vwr7tivV/AXPi9rhkBtZm/zLxRVBg8QOlqi
    4Qzq4AFvHASt2ZK0O+CfDAdAAP5h9cjmAfDob/8adIgnfvUKwAS1r38qulvkv7BVFvgKn4
    /zvvneix+5DRMuxBlOpgajTZHQwsz5gnchtecXwLC3mAulg7Se2GijL+NSCpe1Xk4jTRu0
    kh/RAQg57xDnAn15YRSLWc/X0H45SwU0F70rBXrIXz47JpQbBB/hRhwtx1VMfzN2tcWJD7
    Bb0FSG4/+2xslZp/EZtI6XNPYTMYUCDQsGLALhIEZAtTJd/sh8+bujgGZng81L26RiGEM5
    Cjdb8ep2+/pDVF2zdn96SWEuCoY/kb/8HtrtjwG7KeuVdNSEPqj1fqc2k6ow
X-ME-Proxy: <xmx:bsg-alutrbscrzroSeNqqmJhjnWhrDSUR-aDwc6A-UAJMzSaS-HMgQ>
    <xmx:bsg-avNgDBNj59TtjvTyzeOUMmwXYFlytYN9drKgdpmb99CGVTDWWw>
    <xmx:bsg-ak64k-SCJUNGGOMigQwbDo9tL312zNIYu7acxjqYpgCnJ7_HYw>
    <xmx:bsg-atQDbKQmFwNMdIuGOsfuGTDtiYNtZue1SbaCMIxLVU5gAra5eA>
    <xmx:bsg-arzXC-fLe6pT_zuB_X1h4l-0Gh5KqNGZqjJZMOZZmiPvosZr0X7a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 14:43:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
In-Reply-To: <CAL71e4OT0brcmbNXBzKpZuxTh3=R0j+zgxWmV4S-weT3q=vpvQ@mail.gmail.com>
	(Kristofer Karlsson's message of "Fri, 26 Jun 2026 18:43:58 +0200")
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<xmqqjyrl8di0.fsf@gitster.g>
	<CAL71e4OT0brcmbNXBzKpZuxTh3=R0j+zgxWmV4S-weT3q=vpvQ@mail.gmail.com>
Date: Fri, 26 Jun 2026 11:43:56 -0700
Message-ID: <xmqq1pdt87mb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> On Fri, 26 Jun 2026 at 18:36, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I am getting this failure standalone, when applied on the same base
>> as where v2 was applied earlier.  For now I'll eject it from 'seen'.
>>
>
> Yes, I am sorry about that. I submitted it after having missed running t6600
> and accidentally having introduced a bug. I tried to self-report it to avoid
> wasting your time, but I only did so in the relevant v3 patch and
> not this main message.

Ah, I see.  Mistakes happen, and do not need to rush, as
collaboration is asynchronous around here anyway, and we may read
our e-mails in different order ;-)

Thanks.  It would have been a more troubling experience if only my
set-up were seeing the issue, but I am glad that is not the case.

