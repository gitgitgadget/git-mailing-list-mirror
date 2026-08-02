Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7A2F5A06
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686479; cv=none; b=ke+NQYVocO6L/yDzxdiB84if3xp+lLS7j5tsb/i967HdqI/6x02AhsW0btF3yC9gHam4hSGYvk8J10gZoNRTTHGtRdptelybrkIbBGnC2BO+T3k+mRqXgkGZdTMGzWuFeJneRCFGp4r5XAwNs2/9yHvUcqciV7AG5YvDM1zuurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686479; c=relaxed/simple;
	bh=dFGqiQF6/n/xEAVRN1U8LKrhlt6z6BMEa/iE8tzIc00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIcuRPiPttmllfaNlMkI6lPf0nHvg1ProzWU7qNv65yfUHlWTiWFZT1bdwOt2ygQRXMSmu7MdBxmcNtfGMsVRTSkpCidYN+Kta+z3CAt4e8lygDbwQ/DFWXG3kvp/PBysXqTxPDfu+4IRU9SfLEEQ0/IjbLD9WjLf3EKgOLRnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dh2mFeVZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNjDI+qo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dh2mFeVZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNjDI+qo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 13A2C1D00184;
	Sun,  2 Aug 2026 12:01:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 02 Aug 2026 12:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785686475; x=1785772875; bh=XZ01aLZz/Q
	qtmCOVtmf37sDpO4l4RQ8S6YAyqWIAY7g=; b=Dh2mFeVZTwYX/cSXeADRzO+8iP
	j+9UaFb5//ZASdRe8xsaEYb8sWp3wIYmweivQVxMKxVrvaHAVUAF6W5jcDkiOpOV
	PgsfujFrW3bfWh5ZRZqi5qvpqQ+aLKAIGydUVJ+0byvMj35VKzDPwbrW8jJrvC06
	MEeKHJ01aEZrVKJCX/h1SrkeiKq2tBhpYfZ3RK6LbkR7nCxSFpMDeEqSc4Xeh+KR
	n68zZW7E6JU/uJN2eZr9a6QGb5wycniu7pm8n4QSvEqR/pPzKqaXAHq0AkvSLSGI
	JiPFLOv+tWPreqeM7kAAmD6M86iL59g99E8RCH66pvIs0DLdvDC9QzazY2Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785686475; x=1785772875; bh=XZ01aLZz/QqtmCOVtmf37sDpO4l4RQ8S6YA
	yqWIAY7g=; b=MNjDI+qonjwevlzhUPC5NSBEowhbDK+gUc2OVD5qizl1cchYBRi
	BH1Nmr45uF2mMNP+xAtC2rS/vSWuIC0KhXLrH9fLUtITcVm+qhkX6C6mdmZ8KhaX
	0AAbr0NEjNmKsGNxub7RG7BIJvgxOjDUDo9SZXt8UBvIb3UwCnsZk5I15A8lYHVT
	g7Yssm52kCAGUbXuE6OaiYZIOgYdK5/L5vh8oVWYM85rr2QAylqzlJkMtum/e28+
	PKlvHnNNwDsHrLggn16YwQCFDONjPikF8YCpfusYk245mZcNBbrPUtaGOufBIqc9
	mMJnlQ3PTLkgPOALBdKinOcfZQw5dl8HW0A==
X-ME-Sender: <xms:y2lvajgGm6dlI5lSGfAzlYJHW-Iwk7y5q2P38VpdIX3Lk4CForu-Sw>
    <xme:y2lvam7cZAuvVwRRUTqkVSMQIvAzW5hjYmk4LVFutSw6l2yz6HB144z-svbtEroXf
    V2o8QBO3o3EBzE6ffzGGS7LZXrtNkG6MQ1K7BlJIH7ue8mgTZHzgw>
X-ME-Received: <xmr:y2lvarZBd7QlQVVhjNBcUg6K38gLBk7L5Iml_131pVVJkcgIZ5BbX6dMAUR8po_4nNlw6bonBJfa_DVekXC-rf9lmxgYrWOhuQ>
X-ME-Proxy-Cause: dmFkZTGOg8IxkixSqTKbSdvuCIMudBSG0Gk3HZQC/fdf+LyCLGGIeQWS2QIr/rsShfHNpf
    9mqLweyilDbMf4yQ6vaXt3Cn0yx41UwwMIfRUowMurRbD4qzzPI3VCETnXkykS4Sflzxa2
    Tj2/HZ/Cury9lSO3LBmpc14yqwVfM8x5mBBbEqQJLZkrr24n/Ha2Te5GoX1SRt1P9gToCl
    0XiHlTvfZwORgxut4g1E5+m6VhKVlUPyDJGYGt3RI+WfjRZzkLq7sN/NLfYUu/G9qvYea1
    SCLedLN1OCkpitgN8xL6L4nWqvwxEqFDCfAk1IeiLszb14jyaufVnDro7s+iGP6832hvn4
    XLMXqoC5W5aPjDSFNSW+9Vhc14YeL4s1EaspTPDSc836ruH3e4P1Xf9oJJFu4rqEJZTUeD
    WVeuIyf2kyJmIHw6wctFkWl7Q3xplzpdSVY6thaFa/uw4gcoozfI7dlFgjJjBEp15mj+Hs
    ZSfxXBvcQZAJhyfsIOFWjTYceScpnE2W5chkdi8hbbL4pLY5Vh8pI0Eq4+mm4ua31cOw0U
    Lt3rnZ87wV71LZ+kWVfP2Uy+w5vSsRhnmdVgSEFl7zjpSqm+7+8qUVTpw4uDyAXrodBdKJ
    2SmRWWRS8WrXATCXoJfvnewPNxRSAvZHmp5VAPa2E+UpKHPmpJ2Q5SRCM1QA
X-ME-Proxy: <xmx:y2lvar6oOekZuDqeH9bytG5Ye19gBR3xQHeH3FmCR1EPQ5qxo5Kyfw>
    <xmx:y2lvauBJZaPouo1YPt8XYMAnh7KPP7QW6ZpVtSMxsMaxz81MusENOA>
    <xmx:y2lvahcO_PCpC-eSiFmd7frM0cc6TPurXroUd6w1HUgd2WaqQ5DfMQ>
    <xmx:y2lvatLxZ1XO1UXYbZynG0BbtFuABA9PS-GqEuoJQaA9buNqvOwQ6A>
    <xmx:y2lvauIHvggcjIeoKdeP2BrjMbytBR5Ti6ejzxjdpl4doLvBSvlfp79_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 12:01:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 0/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 02 Aug 2026 09:31:13
	+0000")
References: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
	<pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 09:01:14 -0700
Message-ID: <xmqqh5lc4ilx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add a --reset-when-found option to git bisect that resets the bisect session
> when culprit is found.
>
> Changes in v5:
>
>  * Move automatic reset handling to cmd_bisect() after subcommand resources
>    are closed.
>  * Propagate the first-bad commit OID from bisect_next_all() and remove
>    defer_reset plumbing.
>  * Separate checkout from state cleanup in bisect_reset(), and use bool for
>    its quiet flag.

I know I suggested the second one, but is it really needed?  The
only reason the "first bad commit" is needed is because we may need
to reset to it when --reset-when-done is in effect, but before that
reset happens, we can look at refs/bisect/bad to find it out, and if
that is the case, there is already a mechanism for the next-all to
tell later code what that first bad commit is already.

If it make the patch series a lot smaller to take advantage of that
fact, that would be superb.

I also do not understand exactly why we need both reset_when_found
and reset_when_found_arg_seen.  If we initialize the former to a
"not set" value that command line argument or the state file can
never set to, then wouldn't it make the latter unnecessary?
