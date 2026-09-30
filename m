Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185A4C33E6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793982; cv=none; b=kuDcJT/7mNltf9lo6GjpcHiFDK3p0d3083qrmBk89CKv7WmoKus3Sxv7jFuq+zqfN0tbLFqKw0WSfFFYsZ9Tbcz7200AWdOeGSH+H23335w39ZHgeqob7n2yYKxyY5dHrJeo4r2omXXuO55qjlEKczjAvDB+zF33oftH4ePIN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793982; c=relaxed/simple;
	bh=s9+gxGoSBmlg+o6whXhKZBULtSnSg20TFrhvIXdtRYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PfBKfW25szykT+lEyAYsbo7BOb1LlL6jsturjIem1VoD8lBZhfVXGmgFXcLh8o7enHvIaVp1CGUJZX4aLFjX1dDHpdITfDpg4t/jGRHCd70pzcJ/L0fjRs0GJIUemdo2hNJ8cO55aGhed3m1+gF42L0tnkW37YZme2pNgdRAPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vKGJL5AA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFEVnYbB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vKGJL5AA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFEVnYbB"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C5ECEEC00BB;
	Wed, 30 Sep 2026 14:46:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 30 Sep 2026 14:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790793979; x=1790880379; bh=VxeblZUnsa
	xDYD5+oJFXgwdrl2+8lDZy98xboOm6vTw=; b=vKGJL5AAOR1a/VGNyH2GdSkRNo
	ACYKtkXmdhPsroT79UJ13cOPfk9J6CdWcuF+2aHL5ol6yENRwNvjxGN8aSlg6u9A
	s32PzIRglnwEhY29JEzAsJmfWOSBFG+Ti5IcS4GD2sScO8axATxW/fV0lzJR+vKd
	A+UkvFS+YbFIjeKFoB1qLBAj49VGxm2P6fB1I1TUThkDd79CBDEG+4yz7Dc6lUIJ
	jqAj2p/zJPrnUoSrSoBxllp9U9L4FocYD0Ax9qf0aCb9meknkyYoxY7T+5WuzF2X
	DZR7r6NnsTghpQb0LUpp00/isoyu/C3N6GtsTUiCGQPCQLxwdJiJLPAVkV5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790793979; x=1790880379; bh=VxeblZUnsaxDYD5+oJFXgwdrl2+8lDZy98x
	boOm6vTw=; b=FFEVnYbBJ/S5ad2JzJG5P4NIYBXrRLqkj8uOUGHSDXeB+894h0I
	Xk/ixlqz4dleqx/oe7Ln5gx4FIyraaW6X+tBq/KkK1SQcjtYcBtO0MTJhiAZY2SC
	dhBxpX08LNlfp2hcVkapkbwKMGI0YntVMJlyy4T/35XXNWzGgk1z276+YhOYGY4T
	f8h5QFx6I7dU6DVNLf0C7Fz6wNjXyfTBdLGLK95gN1+f5DVe/RZm0ZyJmB8BEwfh
	bG6uUUhkSu0SIZEZuq/Y7/hzRVD5Puk4TsEGA3MOPRfzXYcXC4/8D/pzu7QqnSVe
	8ZziqPf2fF6odAOExN9/MPG0ucwwUy4xa6g==
X-ME-Sender: <xms:-1i9anPYTsDpVkemVXW5M01KJF_d-9F2iGtLJawDWj-Olv4RhelP9w>
    <xme:-1i9ao87PF_06vsLtTWLqeLiJiFZlnmLbpMOh7ir_kJjQ5QRUdEi7Shrq_TdMSwyI
    mAUK7Mcs0NiVQREFsxXRLsszMc9OgIW8upeA6TgaPJ-50FICZaST_Y>
X-ME-Received: <xmr:-1i9arTj5QGYZ-3KRWcgctTgt3WJ3UURWEL6v2ytQ5ONHqEWTFHcv8-snRVlFplFbYivXi3dx7FUCUlDCHoSLf2JptF16mbtnwkL>
X-ME-Proxy-Cause: dmFkZTEatOcaMQm6uq6HVe/FnucRLPCKGNkC7Rptu5uw2CFIXCRdLK0l0DYrVRPhmylTPd
    /UTbReIZIJ+nZio01ILf7H7rlvl4EFUGqGemWqpNPPJq+l8zscoAh/ayErjpHPOwDwA6c9
    fzs+idED48Os0v8R+DaAtQ2+AOxSX/Ugkuhpp2dc7q4HGrdaE31K8ryk7HiOPkkPyAv5NX
    CVYoTSB2UJuP7AsiIyxmOPWBh2n5/IybEhr8dykJa142/yEzL0WIXqDUNebRVbge05rDdC
    Uhlo3qjmlJSuiidRqW2V8sADF4OAm3uziKI/xpm1J0MJEz0RbpGtWxU4g9QiUEx9UhLBV8
    KWNtMeA11kXhBBPKrfXrT8RluaxUjsXuv9DrMBLK5hHiEuT6qgo8iqiuz8po1Ng2x8BrZN
    0kv0jCcntwAlT5//yxR9xE7c7I+qFYzkx6Ut0hMSlbzGTWeqtY9pYmsu1jWMNx3Rg/50QH
    hmoZ9X5AQFlnb3l8EqjMeWFAf+JrP0qcxxtEFEi+LsQdICiwL4ypp2iuuapH/+pQAWZXmw
    vB87E713Tu5iSmr1qs0RqA/IIPGURq5+t2cvctOFgR9VaqvkP4MGjkbGQmQZBmHyG80w5H
    XHMdmCxYJo1dNeseneE0se5RBDb573Uh7GMhSt/Mc0antlNs+ia37YoCqihw
X-ME-Proxy: <xmx:-1i9aqm5hTQhGNlQJ_2L7P2CSEwiA8lcIeW2zippYpBVV95s9qgjCw>
    <xmx:-1i9arQYy-RogDb2BvT26ECt9NcpOSN6BoD2XcNibdeeGoJbW6ay4A>
    <xmx:-1i9aoOKMQ9YqKCNEAPpUKNz280bz3vUMUAZG6L_CYQQzfh7Qsu8mg>
    <xmx:-1i9akW_OM079Sj_gAa4TVTH7F-8PEauuPJFCkTxxEjkHMXKtxxCwA>
    <xmx:-1i9alDn7v6lPkqQsPPRDqME3nisQsai56adCUnQs5y6POPhIdmJ_rNr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:46:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Colin Hinton" <colinlewishinton@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <DLSD3JY380Q4.2VPO95D7M213G@lfurio.us> (Matt Hunter's message of
	"Wed, 30 Sep 2026 00:21:48 -0400")
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
	<20260925192658.1166-1-colinlewishinton@gmail.com>
	<xmqqo6dlt906.fsf@gitster.g>
	<CAHeTm9Pb-fb-ZS_m4UVNZxfp+ENQwBUGDvP1E24dEDTZy5RFFw@mail.gmail.com>
	<DLSD3JY380Q4.2VPO95D7M213G@lfurio.us>
Date: Wed, 30 Sep 2026 11:46:17 -0700
Message-ID: <xmqqpkxua87a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matt Hunter" <m@lfurio.us> writes:

> I agree with this assessment.  However, I wonder if Junio meant
>
>     We should (do something similar) to (what remote.c parses) ...
>
> instead of
>
>     We should do (something similar to what remote.c parses) ...
>
> as the issue in the NEEDSWORK _does_ apply to both sides.

Exactly.

> Perhaps at a minimum, this patch should leave the comment intact (or
> reworded) if not yet addressing remote.c.  v3 otherwise is looking good
> to me, and functionality seems to work.

To end users, the annoyance factor due to an irrelevant incorrect
setting in fetch.followRemoteHEAD and remote.*.followRemoteHEAD
variables killing their "git fetch" are the same.  Correcting one
may be better than correcting none, but until both gets corrected,
we cannot claim we helped users.

Thanks.
