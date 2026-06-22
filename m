Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AE36EA98
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782164137; cv=none; b=MSzAyROu/WnY903yjuvMGGDTho5zmw+7q7czO5K55/1HkuN03DxWQNp+uu2BLGMz7KwCmbX8G1XvccZuoPBAeoNO+dK0v6QejkYekq3dJqPZnsylAV0kFijR1ht5JnT0uqNeYCRAJ4XmMVoX96+a+mAUxh+4oQela9PAbvf6mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782164137; c=relaxed/simple;
	bh=LzZCKXFPjkumQPpS7wnA2ucOI9hIAwhdGy/jZaKA8dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqhrWTRctr4L8OihTJV55ucWmEuHmZQfCN7+19gy4XqefxwZ4VRWopmD78MysUT4gM+W29sUi62AIhjmstXb+OYmI7g4P5fZfeZl0Aa0XqrwaKjLgST9tMuONn8jWmCNy1w7+1yq2/RebbhEe9FajL+yNKvtRCdLEKHH2ijcjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HOZm63kg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNP2X2dZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOZm63kg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNP2X2dZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 102C67A00E6;
	Mon, 22 Jun 2026 17:35:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 22 Jun 2026 17:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782164134; x=1782250534; bh=jW1XqWyW0A
	RrS1fyqCUHK4B7QMtZqUb26ccc257jMUw=; b=HOZm63kgBXlv7Eq2+GTHvURORP
	N/5ag8VS4wKGEfxU/Dq9JxhwZIdTKEBS2Ai/DcyS84+fm1s9Tvbfb9Qjt+0s0PZD
	G222alvJp7/J8Dd5+mvmsdZpFXOSS1BBzWHOJt1Ue11dD3/qXkd0yaRHNsYIua+v
	/0HkwaSFqB7wAG/m76kNmYcH4iG4SISBHetavmRvPsYI6udHdbsGXVizUZ2hhRRS
	0fgyODE2hsx+WwviSFsQ0O8DxUW9rWw2xfsuFtdb/TUPQDo2dLETcdYR6C6ZK61t
	WTRcprlPksJMmIVfbH1XcWgOUcqxImQlZQbOM67memuesiEbEPKkNzF8YPKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782164134; x=1782250534; bh=jW1XqWyW0ARrS1fyqCUHK4B7QMtZqUb26cc
	c257jMUw=; b=ZNP2X2dZxwA1J6WWiR5731muDRTEchLAY6m3qOvCnb78I73GHw1
	seOiZjyv6CIG2VTUCf2kRh6UZRjH4ZrwZDHHownhJdQbIty1wxcnzsVubt+mI5xU
	Px/UKraSGCkQ1TTCx3jc/dGoq7Ck+cglgeGWOoGaeq8xNhODJ9Kh1TwPEeYVcS5v
	RaeidRffposv69Dn6kgoZWmH0FBa9kXq5E/SgE2HDJfk214/TnOgYx7dGQFvMGxl
	1VSpRF+XdGC3sKVdIm/mp5fEwEzLR+f3MQX7M88dH3VUgJgv2239tp5mjO/wjCAX
	xECctZPbBbMgIcXAmulveAPOVru3adGizBA==
X-ME-Sender: <xms:pqo5avfzWHXv_dHgyQK4EWUtCOeW-L5Wo8_Ly-tTG3WpoqWzBOzLRA>
    <xme:pqo5asOK8l7sfH_pDRmF9onnLytTpFeUVuggWHDMjmXi_wC6yXA_f2oxLH1RwEih-
    GxZFApfOvrhOqkIHCVr1OvfkiNqTvzmmBBv_XGLcm2QG-rlG1dyAw>
X-ME-Received: <xmr:pqo5athUnskgt6Wco2xefkqtlYagn67hOAkVXzNWQVW1KasSyVszQ5eDBYamsjMFAKb8QYMaJpNfAvDaghVXqfLtPCCnc0Flmir6WRQ>
X-ME-Proxy-Cause: dmFkZTFJJUmCJJbPVnExFEoMI31OY9PWCPA7Vywzezb15p2j4PqpJTGnhxPr3JFYkMYzA7
    +8MN6jyU5U1QQ4opMbW/+fM6C6vSSsENpS9y0GyJBBL89AIAYR4DoidWE/1KgOSlXVYZHm
    bEYuLtt9hz/+nenOfJdFGzf7L7Kg/R+oBMe1MgaJISeqtRmnlMQMG3ZUu6VEswV90FFOOf
    wMxYPJLDEmxH52LUtl8lr/+8XOWNf7U8aEIemB4qLDhEcr4g5bB+L5s41ghj3cmhsANFxp
    o7p88nvPtmUGcNtaF7Qy5ZoJKbN7Z7txdp0H3fD4tVvqGlUDnG5o6c+q46yg8O1dydTdX5
    FcidpFwYqHDYW2YtXhiTJ+i0EaYgwGG9x+FXlLgL8Ri0BzdwBghETzgSLjkRBjLMzPnhNM
    rt+0X7cOobL/WPKpjRMaTIfL+9ftvnaDJlRPwJkHIAJORPtVzUy6O4YEXFWyHeKlqqiyXI
    SjkbdMTiqNHochuESHhHBAeaFRe0sTld8gU3qN7Ya5run3sK0zbn756xhGpmRgTBVYWu/b
    HGQhzKFY1j/ulKQ9Mlq19zIAkA7IfMb2TlFlMqtE2IDU4A3plju2bimQUG+Gt+ytfX+G35
    H7nssJQ/WidLn1yCvf5Ed4D8SjSJTCrNi285UagwOLYI7DDvbuHijKs93QWQ
X-ME-Proxy: <xmx:pqo5av095HgzzHQqZddAWzTvcR-W1NnLPNHEVfRTfosaTC37V6sDRQ>
    <xmx:pqo5anjoXMF09-QmoSyPPyjMqkqMVLGHw2Z1a3TYK_v65w145RvBGg>
    <xmx:pqo5avcYoXqP6hMBC_Oyqy6S6XAH29ijb3b7QBqMpo1znTkcd6ADXA>
    <xmx:pqo5aqmepLDGAVZE7arLevQyj9HEk2Q9nK3KHwwwQOhuwrMM6-lTUA>
    <xmx:pqo5ahD50u2RGABlNg51OgoqwL2KgUCrjMnhwHQ4MIFX21pNnCmV68QN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 17:35:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/2] branch: suggest <remote>/<branch> on upstream slip
In-Reply-To: <xmqq1pdytkmj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jun 2026 12:56:04 -0700")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<21684539debaf433b6b63404e1a7622a5cc33283.1781262619.git.gitgitgadget@gmail.com>
	<xmqq1pdytkmj.fsf@gitster.g>
Date: Mon, 22 Jun 2026 14:35:33 -0700
Message-ID: <xmqqh5mus1ga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> "git branch --set-upstream-to origin main" reads the trailing word as
>> the local branch to operate on and dies with "branch 'main' does not
>> exist", pointing at the wrong problem.
>
> When 'main' does not exist locally,
>
>     $ git branch --set-upstream-to "$anything" main
>
> would fail before even looking at the "$anything" (which is supposed
> to specify the new_upstream for the named local branch 'main').  The
> operation is to set the upstream for 'main', and if 'main' does not
> exist, doesn't the user deserve the error that says 'main' does not
> exist, no matter what "$anything" is, whether it is a well-formed or
> ill-formed remote tracking branch name?
>
> So it is unclear, at least to me, why "branch 'main' does not exist"
> is an inappropriate message, mostly because these three lines does
> not clearly tell me what the user _expected_ the command line to do.

After pondering on this a bit, I _think_ (but I am guessing, and
your job as an author of proposed commit log message is to make sure
your readers do not have to guess) what the user expected was to set
the upstream for the currrent branch.

    When trying to set the upstream for the current branch to "main"
    branch of the remote "origin", i.e.,

        $ git branch --set-upstream-to origin/main

    it is easy for some users to mistakenly say

        $ git branch --set-upstream-to origin main

    But it is a request to set the upstream for the local branch
    "main" to "origin", which is not expected to work as the
    upstream most likely would look like <remote>/<branch> (e.g.,
    "origin/main").  The user would get either one of these errors:

        fatal: branch 'main' does not exist
        fatal: the requested upstream branch 'origin' does not exist

    Give a hint that we _suspect_ the user may have meant to set the
    upstream of the current branch to 'origin/main' (but do so only
    when 'origin/main' does exist), and tell them the right way to
    spell that request.

or something perhaps?
