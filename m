Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD3385D92
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126326; cv=none; b=fREBzIcBmz4dHZBsLwgtlU/UIp+65YytuisJhcU2F/Yhj+V/DPbTHDQYMVbZJXl6bjhItU3ja2D+9QDwfDbhT/jXR9OPv91/xAV/53MlZPp5jjleXtXk3zliNPRLhocU/1FlxoP2pcBjE8IkPlaLMVYeU5Sks0uIEaSvaeltEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126326; c=relaxed/simple;
	bh=/fyBwDMnd49vENpQOowHN+JK1beWVoOd6Pt+Joa0V+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzxH3ZxzDi3HHUKmHrV/NZfT1qHDX+tkz1gs4NMz2MtSc4jpJBpDzFqMik15Qb4U+YuhUDUCNbKQegk2Ge/JGQSBE+bWbv1E6SIVwvneJPGWFIYDoaTUcUOoSjffojZw18TJdyXSjsfIerYWBo6qa4cU12JcAVuOBIKtx3f/vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MREoYTmG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zld7Goia; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MREoYTmG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zld7Goia"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C700EC0242;
	Wed, 15 Jul 2026 10:38:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 15 Jul 2026 10:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784126314; x=1784212714; bh=olv3mW72I8
	lBTcEvC70yPB+M4P0P6DAT7Tt/jzTQQXc=; b=MREoYTmGSOpU5/Uc5+EnItIdwT
	rvlVgCqaDo74162HJap+gD3p7NQxkuRWTmfY8UWXUzgCo2aW3EQEb27FoO2y5/CT
	Ly5cU1I4kO8kDTgWlyFeHeFPSuYt0ieI4C0XYdius+LtQV9IxDCh1wpQ3l6B3uuH
	N27LB1e5F/r2nPYhpC7UteSaa2ancl9jsaokx/WgjMeE/j4OpTo97spWyk62nDoY
	3mp72tS9rfJdnOHwUAUpp+aq643S2cQnv3tT/OOpUG4Xf8wTxyH5s40LLkaU7XKT
	X2ddrHjRQEWiR9I69imLvmu5bIFetSSREHDje2QPtwqAqAZkl6OZaPKAoZ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784126314; x=1784212714; bh=olv3mW72I8lBTcEvC70yPB+M4P0P6DAT7Tt
	/jzTQQXc=; b=Zld7GoiakyumBgZtv2XIVbycklZgg0WnvAruUMjbo1vYMv/MmEM
	ldvqWPDRItpyWD4sqQhVUMI/JCa6I3WwGJOE3ylVaZk9XbO6tssvd5ImZDlegrM3
	1BUNrPEJpiOVK84p51K2kRcLsJSJqR7ByEF9SZBfMHwo6IFVMUHEVFo/AOKL5kdl
	Xe/+97InMUXL82EJ/4FjMyKb4hEdKZ5lGzC/BkhCQqueSLXyleKWVvMqjXoJoGab
	cxcsXr2o1ybTYQAaZIyx7RNRYrYY0AsSmbVyHlSg5WBbei0KfM2G4/RB3hsNGrxA
	j38bdzqvvzxjNnTb6PnUFcA4SP5Jq3PJwzA==
X-ME-Sender: <xms:aZtXauMImKJJcuvu0obGH2shyeEjVCfPuzkdpKvUV-1mnhtu7sNYAQ>
    <xme:aZtXaj97KkEVpoRstHUdssH4kzekhfKPyRyfXrTd_a6es1z683Y7IAu2M2i5PtybC
    dt1TbqCIeKQZzGKM58ENN2T1a8Aku6mq7ngXOW5GkdmSBU4q4IZJQ>
X-ME-Received: <xmr:aZtXaqQhz5fOtIrkO3zLcIC7boHKComB11IYBv_lg7pq4kNaMARgQMz-9HOBGWKALdLHvA4ZH7tpMt1JtK4RurTp0pfHwLF6syRcD4I>
X-ME-Proxy-Cause: dmFkZTGpzRrxEdFmCK3xnZsjTPesYZIElXUTLgherDlvlipZ0hfPoxzK0ek0qMDyjtKn3n
    NgwvJepBcOu6jPGZZNZ4t1znH5eHAYB7X09Hrz47WfGq2pumJXngglOVe0Sp/j8aVNTUxH
    2mw2FjVE8fFHAVyyGfDgsTDGx4iaZ3igDZb2788ENEPa6w+Z2QKqAcGorEm7BQd3oL6PSX
    k+AKHDPJ0T/lbN5V4QTKr/uIl/ebpF0hE7ikHRJPu3vy2fq52uogtUN3DlKPyAgijsOeYf
    HeeWH4+Y0oM5XLQyDC4g58TezXEDbHcJNT8QWBp/xkr1HW13osy+DnYFMk5/iI8cN3oiHm
    AO1Z5+JQxlrjbOl6hWg9Rtv4E2G3jFQUOtVzLBvkGAyyII6aCFwbnMb2z2W1Bn2pn02TtF
    YK5zphEG0wjOpF1PIVBGMSpfsmT9rvKjmPace0YCMWjgKbw6ITQv/A8cAmLYKanBnh4bnm
    y7tzd0qPwxvP1aXVwKkHL6WAp+awSjEVG66AE49M9e/2iugrBAxNw1zAfbotnsF64puRsh
    hCKmSX9IwRTMH2eTmThNMAcyq9hE91xHz8yQ4+deDCp19l21HmEOsZe+jCq6Nb/eZfIPo8
    flhwtEnx/LFv2wpHU959+T9lDhK5iAlVFge1wngNVEJeW3O+Oz9byCaJRknw
X-ME-Proxy: <xmx:aZtXatm4us88ICLA0atv3Z0bW2J7r3TUqQjB_C48_XuQmysw6b0LKA>
    <xmx:aZtXaiTg4HebTUBwADWQwjI_HD8hYHRuz8g3vpTrjyOL3RnD_v5FlA>
    <xmx:aZtXajMV5ju3n3p7HfSsLdXBglZJSLqD2DKDspS_pLOeClxoQSs4KA>
    <xmx:aZtXajXs8YR5jb-6LFkabJCcV53mZ6Tls_hw2cAUHmqe4hlV60MPSA>
    <xmx:aptXarPc6lkvlxlYQ5Zj-pK4Yl0solBqbflpDApuGSTjpvYXNULR4z-g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 10:38:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] refs: remove use of `the_repository`
In-Reply-To: <87y0fcfn7v.fsf@emacs.iotcl.com> (Toon Claes's message of "Wed,
	15 Jul 2026 14:31:48 +0200")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	<20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
	<87y0fcfn7v.fsf@emacs.iotcl.com>
Date: Wed, 15 Jul 2026 07:38:31 -0700
Message-ID: <xmqqse5kpbbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this patch series refactors the ref subsystem to drop uses of
>> `the_repository`. These patches were part of a discarded attempt to
>> make the initialization of the refdb eager. I guess they make sense by
>> themselves though, so here we go.
>>
>> Note that these patches contain a slight tangent to also adapt
>> "worktree.c". This is one of the subsystems that caused problems with
>> eager refdb initialization because of `has_worktrees()`, so I refactored
>> this subsystem while at it.
>
> Changes are all very straightforward and, except from the small comment
> on the commit message of [PATCH 2/7], I approve this series.

Sounds very good.  Thanks.
