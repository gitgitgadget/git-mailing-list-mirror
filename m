Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39F39F190
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715064; cv=none; b=E7IZ8AfLihpHR4r7u3yYBlXzWEUAfVq/LY2fz5b7HViJ3Ly/J8QIcO1qcURpih88iB0xDl6iPwW42hDVRylhIU9J5f5uzffWbNIIRGrg0yurJPnwCQplJG2uKg1MiMIPulyfP/M4P2UKxVeMjEqhGPHF7hmD8xckJjs539SyRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715064; c=relaxed/simple;
	bh=hHCTOPAFyAW4rN0Y6AXQTy/qJNfuklWKX5dBtuWaLfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nD8Tsxef0+uwldK6DTkkW1H1UkjME0CUVdy/CcNMk3z6U1fkjCp+mWS2ab5kX6m2Qd5d91BJhkesAp0lsWDDzqLtxfiQ2GwSgeb5VLz//+w3WXSWbqYIZV4iUuvD9K4Kvho62Qv0NvZqSPJjankOXncLRu7QVWl2DdgyPucYDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AifjA2WF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUhAPHRz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AifjA2WF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUhAPHRz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 31EE7EC01F5;
	Fri, 10 Jul 2026 16:24:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jul 2026 16:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783715061; x=1783801461; bh=c5/ytk8889
	8le2zlBkG6BjHAmjVmejN3PAvOoyRwxUg=; b=AifjA2WFX08keGlr18iMD1wfJW
	sWGXF+TihLix96mudQ9hWakuYSopGSxb07Nn8FbvpWiRRJq6IxOJI4a8YaSJpcWh
	UClsb6BmczHWbcDGNva9yLY5Ni4h3d3Jg6b2WjIhSdLqbIWAbm6UjUY9Lrurcx7w
	ImUN1PkLOMthLPzfhNQE3qe+jN7lncNF3VpV52YECkVoLDEiN0+nSdtmLe8dZfcv
	Rt1aBWMnIvw1t8BHnlsOIIGQ1l9fPs4HTUFIMCs+FeryYrMhXY0dW/4dKqn5GQtW
	LX1sZvyxnScXsyWICUVqp+RjdXA5kkhyh0RMWlBv4DSv5l5ZU4H9+EUM3Ruw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783715061; x=1783801461; bh=c5/ytk88898le2zlBkG6BjHAmjVmejN3PAv
	OoyRwxUg=; b=MUhAPHRzj0xceHX7+AtZRUDWSucNmtyuYw1qHBZafN5fnU++WsA
	jzhJPNSx4hYqJ6MHhbyRqeli8oPttByohBnILsRzb5RZrM/HGaD36x0WNLmXFHq0
	wiurwl87WygDHCrtymgDek4IkBmffOKygVbw5s8My71zbLdMftIJxAbqJmA25ed3
	+mGJ7uDGyyPQrSfHvqOrhMVwvZmhBn21kTdSeL2ScWeVo9z1VhXlLjlUEajQWR3E
	NIf87f330JuqwMM29dqVm5NF29wMzSA/a3iYSFCVOWXyZFVd+7l6q7fPBJWC6xz5
	dxpmQXvdIsW0IzVrtPTWix2RqLM2/aJvfHQ==
X-ME-Sender: <xms:9FRRatQUFsIxVCLrswbmuQcqktaF5fo1QM401wkt_MlwnF8JZSPrUQ>
    <xme:9FRRauNNXzebZmG-LemWiad55c2T7wscqi2qQllWVKJ68wf0OKH66BJ9gd8GcPsor
    PJjl91H2XvY6mZCoXaO5MnQqCVJ4WRuQ4UDoa3WpNRN7rbxEFbn>
X-ME-Received: <xmr:9FRRagMkUA_sbKkHgsjTVin9BLlHqKNrKNtR1yv7WZK1xrS4R0tV6dt81m_j1jK9L1r1XE8NFDnR_jRuj7mt3hzB2V7LsnYOljOqM00>
X-ME-Proxy-Cause: dmFkZTEl8nvWUIkRNkrMKnmSiX/KfsYJ30xS6guD6s4ZsdmT4CtL36vl9mJF8OmLhq2ALf
    ZueCAQ9Bg07Py2z6qo3jNPR+T7lQu0PwCyy0ecHikzEAIbIVnjXYe9aTcErDfNzEF7QBU8
    FhnpD9B3txc+JgcqoNgh+ZxDRHrw5Q02FLhymIan9fQGMFB181NwzTXumOp6Hc3Eaus0qh
    YdCl3D1yGncFQPK8U79fw30SJSNXIMk41Gla3F56Or5OOTUQEaqJwmfs2wqY30n9TWbcsS
    9rx5LxyqV+kLxiFwK2xWiPQQAlblNiPMUO5OWpV3d0L6JYkgRcvzH7ADU1DYDfbW+iUsjg
    zgS6lpA1mykUlyu3dSCitKlOvU2UvZjtrwPtFVB5ZyUUNfPsrw76BQAKmXWi+hT/L9qDHO
    +wCBY/QE5G+JKU+ljFTu/UBs5qrXgQ9obrbdD5I61fxiqqQgwPH7yxMfJ+6C0NIWe9spIo
    9hCEvMuAJmLtKwwhmQPCkM+1D4ZO0I1F6029QtCf+HGTqVkcxNzaWKALMJZSDPNCVBiYA+
    k1hv7uwHFcY+kbEBf165VkNK86gukZJGZFe8KztmRCinTIIykxclA//I36/g3M7plDKjkt
    IYAmoGD/UVOdHRqX7SJ3NMLZf4fd1R3zcZpfAkmD7V0tuer2Zcy9OuvHsqGQ
X-ME-Proxy: <xmx:9FRRauuKCDuI0HYzKYD9mnB_nUmyZcuUdTrousL6TnUCgAn9_wtmFw>
    <xmx:9FRRaqXDdxQGGi_SjMeYrl9albsLw8NpduPdcqolTgnHrpMbjN3trA>
    <xmx:9FRRamsMcs1gEKcDQeWWtOaADQaqM3Dpg8buSW_EIil_dlRzS8ncWQ>
    <xmx:9FRRamV1LpuKfmyuJ2VATeRH4En7Dlt4ywAxJQ8XxEx52ejmZ12onw>
    <xmx:9VRRamVpfjbcGVCrnC9OJ5SrsTjhwN5Jp_XEXieireNsXAuj_zCbKo0c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 16:24:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] refs: remove use of `the_repository`
In-Reply-To: <xmqqo6gedbq2.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	10 Jul 2026 09:57:09 -0700")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	<xmqq5x2nlwyg.fsf@gitster.g> <alCJgLcjXKEgNwFF@pks.im>
	<alCN2Afi4gTSSajg@pks.im> <xmqqo6gedbq2.fsf@gitster.g>
Date: Fri, 10 Jul 2026 13:24:18 -0700
Message-ID: <xmqqa4ryd24t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> It is more than probable that it was what happened.  Will retry the
> merge during the integration run I'll make later today.
>
> Thanks.

And indeed, I had a mismerge.

Thanks, the topic is back in.

