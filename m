Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C042F260C
	for <git@vger.kernel.org>; Thu, 28 May 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994546; cv=none; b=S/qyWnzb4WDcHBU+wO7IZ6+EiwRrKsZ4dFjpz8cTfqb8SQJSbNud7zgMYxK4zteJRKrDPULxH4pdFvgo/nEV0Vav2krBQQg43HxYcRx6QgFKsPc8NuaF4JUkwKAJuV08WBAVHo8gx1UiLx56sQXHA6gpleWRLJX8tDUaG+WyeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994546; c=relaxed/simple;
	bh=yhX4rtZPR7y+0/9yl38vZ5Zc1At3MXmSifbM36lcMaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgRMKqwKFYnfM+16q7/MEKsbBERD3rBB2LNDwvF+wqjio026g2/VAn2FtfGJ5r4Jlql+spu3MWtZPIUgsZQzRK6lU+LT+sGwPqrDahWf5KCwetNO9qOVK++2/HE0X0FUcXGFv0yJlZ3guTraP/d35X+w4R6ZDTRkShk5kVW/Nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C+Axz67j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFEmc6rl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C+Axz67j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFEmc6rl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C159414000FA;
	Thu, 28 May 2026 14:55:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 14:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779994543;
	 x=1780080943; bh=RL9mEeOwVKMO5Ity7hvb+cDIg/FU2Js6EkrpTupfgho=; b=
	C+Axz67jsVU5L7exwVbONx5O/n9y9+Hpe8c8CLdcYB43URJsr5UEIj2lJ9jFlNIK
	OrSner7YVy4kCJezyHG0TPpjZhvTpzxLxt0RAlmLkmY6c4C9rT9lfG2Zad9gPl9Z
	Fvmfd3QpYfSYXCsO42Fj+SnoMAusBiFb9k3vAl/GoQna3PxECVwhifFT8eLM0nFV
	LRLGK1wu9mIaDDqkCYrFhse5gKtWhElkl/tJ3r8n+sOHz6E/Pk1hSvj7WCT65IY5
	KSup/lOJ6bAGozuAnfsHYvl5pZfzbaVr1AN/npgbKJECgOoJ0yx7zyZXWJluhHf5
	4qjkN/KnIbdcs0oKXl9X/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779994543; x=
	1780080943; bh=RL9mEeOwVKMO5Ity7hvb+cDIg/FU2Js6EkrpTupfgho=; b=W
	FEmc6rleEU4T4aZF6FzuQj4H+nbOlC15QS0xPBjqrGdQEgeFECcDYo9E6XWjsYoL
	SuK3g13/U6YxFPk0y3b59CaMjQrpcOPFldBtmrF/s1Cgunurc3Irj5OUqxN6ocms
	fwWePjzuXWBQhetnDp9T8Hji3IlbvB+S+GrIYcAKZBJELy6pFvViWLoCUspq2V3K
	5r2HpzH6BkHgSZNqY52G4OT0NfhV8ZoR3IeEYfpK3wzuaXlAjkzrQKEAXp2I+6bf
	Xgj9Tea2MCeywQckjXSfiZEuqNIav8jt+Rduq5KelLNbww9ZOxN5AuiOMFZZ5S4I
	2Zjj4c7YAUbDDRjViytDw==
X-ME-Sender: <xms:r48YanpHfAPF0RPNcOeoRTsvr2s9Me_R8DgbLuNHKm_AKTUJxlBZGg>
    <xme:r48Yaojxxu9_LCMeK56LdmKzhh4A4yizCsO84LWosHnnTSuCEvQZwdLh9vuwhoprt
    WCuOOglZjF9NBQdF0p7EjSZT58he333hIXkm39rZnsW_JAHTsEr>
X-ME-Received: <xmr:r48YasiZJxH5I6KUGIItj9yBMMDVXSTZWEk6__v8ZL79BHCNDwHGOdjcVfxrG9pk2qPpPRQ1r1QSq6Q5FNiDkereLQqauh94EEwI>
X-ME-Proxy-Cause: dmFkZTGy/utuqfvx9k4CRzsd2/ocQqgzsBHog1X2mSGVybAf33NVjVBo/hgxjvgVMBpFU/
    LmN6P9xXrCDcaYnWHDGv6XXdGs8lUo+BHUlKSifSlL97DJxmQNYv4Wi6TcthKb8crh0rBa
    O/YuB2gJBKLkvR65xjtggIsI//bavYpcOjAhWIWnOAZ8DFQg6jsVE/ng39vtKj9EzHEL7N
    5u+7ocvPLifAvEaCNxsOfVXHurJmkrn1X6Inn0XdoLoBAA02hN3o9lU3YKwKshODDn0sAE
    ldRS2/349x11JgYUHcMc8RZMqr3agKOZ47+TZUYBIoz13qijz/hxkn4ePEAM16/doftNfb
    Igq2VNm44qbinuuTEXQD8DepI6XhGkctRldPMvojRDHRW8h1e8FmPek4mqrNiaCs/AgdAZ
    4MSfU+d5OPOelhCkUHPTR8LmPZ/vv7PqT503UJU2yCTpqRfHi6YXsXVPYoXByFV8av6r8Y
    lc5FJUVrIwGE5TypGV4bwTMubAopkyXTIwKF0/oPVU9BfwimG7Ty/Tj3F/deXJw61qFqGI
    jYxg2Uhe40bsXnRsxOpeM0WUUwOjLSGWsDVNelkVjTxNtBMVTlF4qo86c/Qf1r0j6MMD2O
    cbLq1fAz0WPfEGadpgk+heHab5O65kHEQk6nYGlOvtibXY13rmOs7SrmPO1A
X-ME-Proxy: <xmx:r48YamhUB5wvVmENx9iFFacx2H3rmK8zgY9KrlYc_cupeqHmHxFYnw>
    <xmx:r48YakId6jkez50cLGShdpb4vyaj7rlkI39r37qciUtvsFwN5juoSg>
    <xmx:r48YatEazDfOIcCtxzGjDiDlc2pjXn0wo1SPHOtaJqT2EE_SOZNpFQ>
    <xmx:r48YagR55G5cIiXL_dpQvU7Thz2uTBolK4Nfq2pn_s142bgfRSTOtw>
    <xmx:r48YapxIjARliYacW30KuPFNptXZhFffASi-qHWOjPf-SSkyO30SaPmK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 14:55:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 0/3] line-log: integrate -L with the standard log
 output pipeline
In-Reply-To: <CALnO6CA5GPS2CMv_x_=wOPBgspe31FkW=h832GCBpAUbBoJNLg@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 27 May 2026 16:20:37 -0400")
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
	<pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
	<CALnO6CA5GPS2CMv_x_=wOPBgspe31FkW=h832GCBpAUbBoJNLg@mail.gmail.com>
Date: Fri, 29 May 2026 03:55:41 +0900
Message-ID: <xmqqo6hzjrde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>>      ++ ! test_grep "^diff --git" actual &&
>>      ++ ! test_grep "^@@" actual
>
> I wish we had docs for all the little test helpers… in particular, I
> think this is supposed to be "test_grep !" ?

Good eyes.  I wonder if we teach test-lint to catch these.
