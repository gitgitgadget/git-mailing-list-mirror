Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818937B007
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851968; cv=none; b=mQKDSf9FC2Wc3Jaj5ob60GNfSj2rGhSRkaTUHBGHkRU5eQchuSR/Yko2/GZAf3iWnX+104UqqnawPyCRd71oZULcOnBEdNWTPh6JB5jCGJovD8UQuJ2OA0QQnF71EfwynNRhuEAl6Dq/suNLIMmcq41PeRUqYX/unhEPsK6gfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851968; c=relaxed/simple;
	bh=cmRoPCoYK46XVgdmUVVkyfT3rPP/c9oyCMH2swSH+f0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r1olV1dLwWlcoQDdrLcstHe8P6MoYyIpQKGg/6cZueHoBt03895GNueYl2POfVpmZjdvRVrhZSqnVcoalVek9VNx6/qbLHuYmCL/PBUnNA0qvHgh6+j2NmxZwcbnmpxhTeaXMkSLmYd7YlrSnaXOzwvEkn5JfkHX7QDt9BhXOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VOxWqD7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2Vh3LP7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VOxWqD7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2Vh3LP7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A47FCEC025F;
	Thu, 27 Aug 2026 13:32:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 27 Aug 2026 13:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787851965; x=1787938365; bh=IBZ/4O8aLW
	VAjXe7H5NqVr5xwTmtDWJ7HGJ4h4cyktY=; b=VOxWqD7o1lNayGqrUIHGYb3H+F
	fk8Y90lWStinX8/ehFJ/lP8dfDEq0aQGp6FBNBQt98LQ2YDaS99mDftLGogH2tHK
	dicR1Ajea1+CKWg96hNpu/vVzRJZ7PZM0qaQvFpBlNqlx4YAhBZ6JsQHxAQUVOX1
	gj70iDBcAMpbuK/yE+w959++WgkUFbw60m/bJwBho4U2VoHd+Q5NBY6b5XvP5RCa
	JzZRc+YpD3jNBKoomTkeEHfP4eicyx5HVfMhjAP4LSqwvrvvZqz+4IUbUcSnGM/b
	4Ax9n0xa6GcD+1Sv4bHLY1hsbO9JjKpbTdJqIeGj+YzH4xX1uouKRXq2zpRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787851965; x=1787938365; bh=IBZ/4O8aLWVAjXe7H5NqVr5xwTmtDWJ7HGJ
	4h4cyktY=; b=S2Vh3LP7JY/Zmn29ZJkk5EU609U8rpcg+JWtt1RjF9HynjILQ34
	MVHcVZaF8z7S5YriRg3MHJFHgRLBeIvSgxJOx6LgWoue9vnCGawaoahrvv13KEAh
	pQU402G57pcNq7o6hAt2rMY4Gdq651yDxzchYcQd21N32LR705yuEHuM0NDl2ouB
	aSjKLt+H/UUIpd3yLwjHgT/0E8UGPkw8K7UBhxEOKC+0G59vSB+PWtnoKp5whtgA
	c4iuvWZDB9CnIsdRDoecbWgfgMFWB/BZcNy888AITvv3BJgDwBszJllI0vTXYMxk
	HcK305COcbdYz/BI/XGcIOxpJCs92xiWtSw==
X-ME-Sender: <xms:vXSQakLLwwa3UOm8kBK5NMjlaSH6cfuQSaUgkyJUr2SASSczFFULLw>
    <xme:vXSQan0YRF4J0PXELdRYfD79eqsLFGRm_3MtwzdFgQDXlgrFYTo4j5VMus6baG26o
    n1HVZGAgjaa6jyizXQzMcz7vAphFhxoJuHxHP_oW4zlVoRFhkdP5EI>
X-ME-Received: <xmr:vXSQaugV_pIlOnCO1ubnx2L0n1z-2FP5-EbUe-DHkRvRA4MhN2C8AjHqoceP7GNDOZtO5nRXgC5de0mXG_mypyu3bKLttPa6gQ>
X-ME-Proxy-Cause: dmFkZTETPW0ZAZZVxUJhbRDVnstAqyHqRRYN6W3JzbF2MDX1IZs9jpFyxmsuUFIczKhuCC
    gYi+i42afCKjwtbrHkImbzVZORbctb7LGziH5LoqgxpVRjakY40osJeAbQI3gwnDsJm62i
    a0SQpoqAbnDpSulZHkkFY37EW+CffVQpt471BazkawfeFnu3cJk4trlpDBtshD+LibLjaG
    9duKEHL98+ach2HuR/LEuSJAQct7QJ5nJy9uHL8jcbwXG9RR6daF+LETIidmuZWHq03WLh
    odF0+rsyCkMM0J3EZjFT/KlQEMaKER8+E/pUDA3nGd1v2MZPOcL3iarps/33Y5b5ByIrXe
    wYo0pm+kLOzMsW53Pg/i/ow+RZq7hIVZvBCR/o3tZpB/hrmb/SKffzDSdnVlnOV6cuyNjk
    Qb152CyjEuJkHzEsqdZpA4QpCX3xl8q1mt0aGCTLZqxanF0gAu6l27wv+MaMf0tb5pKGhz
    AZdFV7l0DH2hZ0sjjm1CgrcElHCM/8jWt5UbH/8OVVFPt1riYR1BINauVgmhu5GPVVgc4V
    fXX+9ePXKcwpkkJ/9F0lbRYR4uLHt76AXeLNQ04J8AtvD3AMRkgl0z/K7+htrUSWVGE0y4
    fQO8TFuIodnRje/PrCQykk3jEoWT3TV7cq5oLLRt/Iy4/QS1pU/zL9y5ZAwA
X-ME-Proxy: <xmx:vXSQaoUzqyObhCm1mhBPGu2dgikgqmUQY34s2noVjp23aUmi89PuJQ>
    <xmx:vXSQatU8QDveHLJYtiY0M3hhGqqDbfwbErGET0-Fx2DMKV5lqRwKRA>
    <xmx:vXSQaohjjUpACQLVhtTpdS62lNua_-lhsqYuITZb_GCHaSlgJSwG2w>
    <xmx:vXSQaoYHCIVk3aeYMtV-b5MnNMN0E00FupWHWB9S-kgQQmADiVPbwg>
    <xmx:vXSQajtd8Z-aWizxFFG_LvmWbfOd7W-JEP8gHUJcSbKeFGsHYRMBqTwf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 13:32:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v10 0/4] worktree add: improve message for ambiguous
 remote branch name
In-Reply-To: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Thu, 27 Aug 2026 14:41:53
	+0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 10:32:44 -0700
Message-ID: <xmqq4igfa2pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 'git worktree add ../foo-dir bar-topic' fails to dwim when there are
> multiple remote branches with name `bar-topic'. But it doesn't display
> meaningful message as 'git checkout bar-topic' does under the same
> situation.
>
> We improve this by adding advice and modify the error message for worktree
> add.
>
> By Junio's suggestion, we include matched remote names in the advice. It is
> applied to checkout, too.
>
> We also fix the behavior of --guess-remote when there are multiple matches.
>
> Changes from the previous patch:
>
>  * [1/4] fix the function name and add detailed commit message
>  * [2/4] change type of tracking_name_data.remote_names

This iteration looks good to me.  Let's mark it for 'next' unless
we hear other comments in a few days.

Thanks.
