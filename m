Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718373546D8
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452233; cv=none; b=jVuXTc2xzhP3kPRmbvArujtiDl3f48m7ElK2kditchJQ7NTuNrPqSAu/FziZMVNEUe/00OMNFvau4duIyAtLvDOYzRFZ/ACxmokPMfRZ2dcZ7NmFzHUZ8vo3oc36gHMRGjP5hiXJyHuIR0j/RWvhCP6EsCpkFS/n9XCWsSEiWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452233; c=relaxed/simple;
	bh=PQC/FtkG/E7NF7RrMeJ4K5Ghivl5LtSU1z1YZzfWJtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0HSdAvh9/xPI0EiBTjIEGXajsYNFZrqW0ZE5fTwpCdGaG1RLXjrIz1woV9vom1D4W+8/KCvcDlXIMHS1IR9JZhJGbEWsWbsU52gOF3Lf9UHh4oCW36K1v7f/xD3ITO9Zjt9vzSI7WsOEJSQjf4iOWhCSyPFhCluVPvCA/DxQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dsDgkOg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkrfsvmc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dsDgkOg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkrfsvmc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9B0C14000E1;
	Tue,  7 Jul 2026 15:23:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 15:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783452231; x=1783538631; bh=oXL0QMq1j7
	1Nf12+aIe58g+Vu+ka6cLPWMvbT8XVYkA=; b=dsDgkOg1M0G8qoMnEItFvQQSPg
	JWywoge/2pIYuozFDnVxKH2nuPNog/qun1y/qksXyobf0S/oD1v+r+JJtqHKVDeI
	HAmspYN0fE5Bj7pf87/kv0AlSlJt6s4yPiNGvNznGOPJP2xBggl7hc/c9c3BQ3cS
	LjVWMHf7+IXqThkr4pKSDSzJtx+d4JlkBQRS923J6/WBGqDaSDUnbvy5NPjQHUyE
	a8XE8rMHwoNhcNJfjTnyPKpSevO39sx1XW1qaok6MH2a10dsV21NQXRSCkk20Bfk
	fHBCtY2Z6+kgQmimiPCo0pBRQxtgCXUf0W1gNILlGOxKcpnq7AFoK81OrOog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783452231; x=1783538631; bh=oXL0QMq1j71Nf12+aIe58g+Vu+ka6cLPWMv
	bT8XVYkA=; b=hkrfsvmcVgRWeDtw+eYWHkorG0ec9vSfjz0+HfP6xkBoBjLU5gG
	BMfPVUVgbmYLweC0bOdu5rcyxgLX7rYWwISamggLXblRDUZoSc6l47MRd499SUoM
	VnRSHto9ndyLTnVHzLgYDHKRbpRoMb/WxkFRzxYNAE8VF0Ncj+C0Esz+RVe3FLPJ
	dJerYhs2DWEFfcipwFq32Nb5fIQEDDDeCLhgnY3AH8goKaJyjkKfFM5GFFRtLdYN
	wMebDZQrW+yMblpkwtsMgaCSyapVfAq/0l72QNhW/vbdbDjgo2yB2O9e3AQx8zqX
	3oI7WD9cCsN33R3xhnDqOn1rxr3zj7Rs1tg==
X-ME-Sender: <xms:R1JNah8STfoLypE-LX3wIHuYRaN_Vg_kXWeGxj9epsd7479WsAT68w>
    <xme:R1JNavAAmkvIl_fBUy2rjr03x-zTAL6rGcmffnrGWM-tlrQqqTSUWhsdbzYo55OV-
    K7C1GBmeQfqK_-BMh8FTErse0twCkweZSYThwnf1BIbSS4LcqFs8A>
X-ME-Received: <xmr:R1JNamTVH_G3_GsPXIhBi2jTSV2Oy_5TITkcEjlOmNDF0-0XJWbGRsUghgNXLAQDQv_xVMBOBU5UsKH1XqMBmenzeSldEMN1Y7HkXRk>
X-ME-Proxy-Cause: dmFkZTEvGjGZuyZDZNLMkdvh5mDzG6DKjDE6yQbfk2WMoXBzFqkZBGzliRexWyjx3BYmfO
    +SKdr3b+Zb56dtXxCbS/xnveLh4wNPy0c+9hlAEr5k3+2jgpjy25pZJfRuZO2oTBi+WwxP
    XQQpR/zlAhKeW7bdp8ZCYq934kgC+icfrcRbk/S52k81jS5pgSHGarQlTKlFzrsRjcuAvv
    M2UZy4Xnh7XohWjIKqYVgyAxqesAxRGE4BZwmzb7446BPJ2dejDYSBY54GKgZ13Gy2OQe1
    bz1Oz65DUVfl1qO8auOuyG+4Y7kTFDubERtCYibZQZN/iHIxDpOG1jC0KrVYvy/jMvAda+
    iJP/1vmvszZNngyAt7MA2QnOKxBijuR7GiJJ5Jzi2Ka1uH1fFf4qFRuBFYzAjVJLTwtBUd
    s/Fx1gV93EGgWRb8eBqJO1gafL5joXzdcHdAv7rZk7k91kFyfa2gceimwCZzBMcDt1hD5q
    +9YIlL3zskBNA0WJCSnuUFQV3uhg0ShVU9CPoGdgMOUl2La2qKJCoLkmnLBcvAm+bnpNTM
    6n8FYNJ0GI6wGH9mCAXMoLnbEzGcHOFiPlyJwepaSROWauwTMugE/nKM12+ci2dGCJ0EJu
    O+fvjWkaJfJT0ETNOOKoDsfK7YUT/VbFXCRbwc1dfeZbHl+BeWzI4ZLXxSnw
X-ME-Proxy: <xmx:R1JNamvSpUPNAx-7Nz1EYF8Wei4Hwv14tZvmckq7nDd85aI3NzbmHQ>
    <xmx:R1JNai0wU5vQfSudx5Q8Kcku2MUIjHKx2sScdxGDKKSbW3L5URimKQ>
    <xmx:R1JNanX1_U0_oBHE6CwPtItL7nrV34P9tSp9Nv287peYrMwFAfOteg>
    <xmx:R1JNatJ8yAgSdDR_wyacyMDx-8NQh5meUX-rN1tPuNrAsMmyJ0ie4Q>
    <xmx:R1JNai7PlOiBcZrut3B51QgfObt8vYQkFoaXtLg3v9xJ0rVZ4Y1sWqkt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 15:23:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chen Linxuan <me@black-desk.cn>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 2/2] config: add "worktree" and "worktree/i"
 includeIf conditions
In-Reply-To: <ak0am-pEdtOvyBp4@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Jul 2026 17:26:19 +0200")
References: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
	<20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn>
	<akeW4yFC8uuu2o8a@pks.im>
	<CAC1kPDNBecLbmZwjfR5-CsNheF3rcbZ5=SQ+cwjzpFMjFr9KGQ@mail.gmail.com>
	<ak0am-pEdtOvyBp4@pks.im>
Date: Tue, 07 Jul 2026 12:23:49 -0700
Message-ID: <xmqqfr1u38oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > The last call to git-config(1) fails, which is inconsistent with how
>> > resolve the path for "gitdir".
>> 
>> I investigated the symlink mismatch.
>> ...
>> My current possible v7 approach is to keep `repo->worktree` canonical,
>> but store an additional absolute, normalized, non-realpath worktree path
>> for `includeIf.worktree`. For the ordinary discovered-repository case,
>> this has to be derived in `setup_discovered_git_dir()` from physical
>> `cwd`, the worktree-root offset, and a validated `$PWD`, because
>> `set_git_work_tree()` is otherwise only called with `"."`.
>> 
>> This makes your suggested test pass, but the plumbing is less trivial
>> than the original patch. Does this approach sound reasonable, or would
>> you prefer different semantics for symlinked worktree paths?
>
> It certainly sounds a bit ugly, but I'd rather have something that's
> ugly than something that's inconsistent for our users *shrug*

OK, so I'd expect v7 to come and then we hopefully can declare
victory ;-).  Thanks, both.
