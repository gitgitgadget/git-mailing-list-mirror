Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330835E92B
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953462; cv=none; b=MXqwvbnTgFlELWZnf9xsuoq2YhIYW+gGt1glO1rl5wrc0Hbov/PHrq0VF+2a8x3F56xRJICkn36kmOTTAs8zYUbSXZEKqnxnBBFM3h8Ju7reQOrCVHDzeerzXGiOa6oMqvbaPoSb0FKxGSqY37uH0bPix688zypLXtSbN41OTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953462; c=relaxed/simple;
	bh=4QOuIOP4IDc7rLalC6jTmxA4maKSQS4aj+51aSNlRY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnWkhp8iylol9WPmuAO6QXOc+36H1QpiVRcOJLknzI1ZawFlnuLT+cxoI3qIco8/eHv4L7MsWcjiUnFXKXm/8TMDUE4OWs44x1ZSpwjcKFnAk173wXqOzbjUZZWfaxknMMBe2cQCLRrNXHsep93dAID7lDfagGs9kpouF6xdZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cDnp4XdC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZgDLTtDV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cDnp4XdC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZgDLTtDV"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E69647A0081
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:04:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 02 Oct 2026 11:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790953459; x=1791039859; bh=V6hIT24Wwy
	faG1qYEj+ZlJVnLakSOXTaqCSlyLCR+Lc=; b=cDnp4XdCJvjD2eyw2krWEPK9x+
	oAnjKC6r1qSy6MSDbruUBuVWg0fjpMSk+pOl5fohkshRwhfwKVXJOjhjD3SRVxN8
	gqZ3epNLSawiLt1+UAjpo2+noXL9ae43DLF5i1NNadMJSLC+UR9rV0wJjeq/7myV
	hKrRdAfw/1y5S4WikShPK3oQgYfWNaIPDxRRdvUv7uCD9Pq1tpgP8VTIZrWt914G
	KTmK3RspqYlgmH1NGk+ff9o3GIxfxWJ2WKHvp4nfBHoiMP1THoOm5j7itclbTcR5
	xJK3G/SyhZ5cNshF9HHsTwPLz/90ag7pQuBwFx5dRA7zVK/+/UGwPCIpgRgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790953459; x=1791039859; bh=V6hIT24WwyfaG1qYEj+ZlJVnLakSOXTaqCS
	lyLCR+Lc=; b=ZgDLTtDVq17lrpPgsD6Qtfv+TiMWCcm4IWEOH4W4g23ajFBrqNQ
	CPLP2s1fKfymJ8ZwRRF+D0dcS1ygU/ppv9HWHEaX2veFlDBEqDXVH8r1yysEuixi
	LiC5ccSOcduJ7kjc3OW+RpNDN6WIZeHpzsE4iWr+1iXNgd46PtRItTjreaKuq+0g
	45pFftUsUCWZtE2butR9qS5kLXYWyRyFlqZnGX3ZZjfsqbBXRKgmaJxMdi1HBpk5
	PvanbXzXAsGnIhGvMhMKBKWPu0wF3K/C8HRmvZcMNGLMSTbeviCLifODnEJd8zWY
	VYMLZq3ASCC0NoLeYBbDf7b4xXlUfzG9p4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790953459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qUsGtNbQOXJkCu+XAmClRgg0e4xsEXdIbLvA6nRsAEttYf/
	MJ15I30S+5dENul3hwaTQluZ6eo7QalV/cPhNWXEAAnDUP2aT/xnTr4kqV81F4o6
	t0ZTg5yS6rSDELIlPcx96lj5KC424IOL+r/mhtpjI8oZCB17x2gpDWhBU/G9zIGl
	cayBi+XZQOTCSlKYsgOOuwzlK8V0gugwZjEwnRBM1ot+/gBaZfhoFhfo3SLT2rW/
	R/K8NzlMlU8cVT3lTxh4mmoloP2rge/spBLSFzYtnthyqvzJ+ElnvPa2TYD34/oE
	CWX6XZ2SNoYuNoDJ6yLcOn+M8UJHWshgJlkQtYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:L7W5Hf5WWgKtfjM/+g3a/pA1BgmzPAaNPSk+G2x1Rng=:4QOuIOP4IDc7rLalC6jTmxA4maKSQS4aj+51aSNlRY8=;
X-ME-Sender: <xms:8se_aris3NoX9FoDwgnC1rYD9GZVijIguTEmMFymxReuqiHWAapfWg>
    <xme:8se_aotIcsvoqGcfNzWpLY9biz2A8_WsMvnqI2llI1le_tM3cs1l__tAbWlXkmgaK
    IxZfkWC4GvSrY5KHWcFgwRlcTHGaEVk8uriwtG7yshsbMGXeSOYDeA>
X-ME-Received: <xmr:8se_apSZrv414EchbAAspjWsj3rsAvhZcHkThFN8BGZv0ha7SK8fpT__hWEJZ2ESS9wE5l1-ubIZbpY9GDIboPTZBRUawuHKZXo4>
X-ME-Proxy-Cause: dmFkZTGeyBj/9fXHuGPyOJd/FCg3//8u4Ygd9w52z3PqJQcyB4+/3SLud/MZ082NdGJgAn
    ruTCuiVYfokbuyL1qiHY781wSP1KzvzbGk0P97pF1BvHfStmda28UDHWxux+et6zU3oID/
    nl7zEjSHaKznslbrc6+AMEXhIWjYYB3GGyGy1wjw5QJeZ3sdDoVH2yt+U1jT6nhMEDI3qD
    UzygRfMViX4uch1VRFJErxsbYhfWqoobco00iGEEH1YsGE1nC9fh5hCOHudHSLdV4oqkZ2
    yu0M+UmhmeuFGEf4N+5W9r6mO8pg8BOatK8s2J/6BwXguI33bDWfb2IW3AudLPf6NPCjHF
    Ftwkr42yoMfRh9kJCGV6PmXXQacGknM5FBO8fLpYi8ZXDIx2+t0cdcsi4bk+PjOg4m1zwY
    8V+Wjn3d/ELwVILsZO6GOacsgm7ihEdXtq7ET/CUApfuTFBIbqD7niaM3JmhswupBgOIeO
    KxyQyFQxrrybL8B9E5laZELkZssfTtMjuFDYrykosHaxiTOICyAULqGs4OMJ5xXTlHWuEg
    fn5xv0DhOa4sREoK+l31etHE8wTgN7NkoqDKf5lKV9xi6nZUK+zoBE9YUIjnKyoRlnxScB
    0zidhhLJnYogfpiPVHbdtoGXWgYsWEfDOWU1LWh1Q3e3PTvLXwTKvU++eWbw
X-ME-Proxy: <xmx:8se_as27D43_B6ngITnnv7AxCeeOeoRRF5IsSKjHNd02JOkAvXE8zg>
    <xmx:8se_aut_Q418PBX1KcFfB_byyC3J_eI4bpUQdLEojhRTr6Y18HA0Jw>
    <xmx:8se_aiiUtw_5Mzi9gtFzB4f0tOllBmQP0R--cxuVou5l_3U7tI_vhw>
    <xmx:8se_av_CsngQ4G-rnJpWg74n0Tt8VkSMvXy6zYMQCOI9W54lNW_UEA>
    <xmx:88e_atvgSYw8WCh8sanUzYM5YoJ6CiswJIjONczs5JWq-BpreUtK7jIU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 11:04:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im
Subject: Re: [PATCH v3] t5520: don't expire reflogs where it matters
In-Reply-To: <CAA0xjtpM6t-Ga57UF0yrv7=ggz5GChHSk7hTQnGbVfAykhVmQw@mail.gmail.com>
	(Thomas Bachem's message of "Fri, 2 Oct 2026 11:23:49 +0200")
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
	<pull.2243.v3.git.1790843056949.gitgitgadget@gmail.com>
	<CAA0xjtpM6t-Ga57UF0yrv7=ggz5GChHSk7hTQnGbVfAykhVmQw@mail.gmail.com>
Date: Fri, 02 Oct 2026 08:04:17 -0700
Message-ID: <xmqqfqyo16vi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Bachem <mail@thomasbachem.com> writes:

> Hi Junio,
>
> On 02/10/2026 00:48, Junio C Hamano wrote in What's cooking [1]:
>> The t5520 test script has been updated to disable reflog expiration.
>> This prevents test flakiness caused by auto-maintenance running
>> geometric repack which would otherwise immediately expire the test's
>> reflogs due to them carrying hardcoded timestamps from 2005.
>
> It's the reflog-expire task of auto maintenance that expires the
> reflogs, not the geometric repack.

Indeed.  Thanks.
