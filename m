Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC012EF653
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784497382; cv=none; b=o4q8Dl2ulLSFotmUt6lvUQCCZIGDDUuWG59/4kg8lZ+WFxVhbTIn5IdvQGC/3Sr4bwMG0Q0aHmqOiWh2Ca5bP0ucwlM2Gda0JU5Da8ziV3Lkck7LX0EfVt6xhV4a/qYoxA3rmfc/W9m72F/hvSotiT9iaDcNtIz3HYVUQHvQnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784497382; c=relaxed/simple;
	bh=Sg17H+l+k37j4Wkv7cPxkmz4BVxAhXm0HbdX9xxqnCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKatnVQhDPQpRgPRO+zqtP2V+F0caBXZCaT/AgSB8a7aTuPv8jqm0bHd9P7yXu7W3lA9Qsr3YdpsGmRUJ6pbCYvSFwkl0aQHVirCe6r3KkbvUpTl7YCCHTofOpuELuSgOV55H/914WJdQTk9rY3JpdvuV++lCuX3Z0BFM4eGTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AWrLv5rx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4XSvBvN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AWrLv5rx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4XSvBvN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B7E2EC00A3;
	Sun, 19 Jul 2026 17:42:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 17:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784497379; x=1784583779; bh=fbSd/wEjoU
	og7vFWuFZ0XB+WbUYA6OdqVxCHgNiLGfQ=; b=AWrLv5rxdh5losihL9icDM24d4
	Dd1JgP8qnx2cy4TNkN09misyRvgCmU0GS2EHXuTuxsaMuFVK9TWF8ChZXZJPh/8I
	WgKKWdjWkoG0Ii55/kMcyd3c0FaEmSMT5qLhaS4NsFTzeUhAe4rQTQsEZyR1BV2o
	qoXocRmA4uH1YFMkorvkHgO3ytW+SWz3Dqoh1x9tCoSrSDH63MlE8tmrSLIzjWoB
	SiKsvSF2V718RdopstQLe1r4rxog3rH3Rl2jZ7tpvzchz6aYPiPpSLYFB6c8HnC8
	RX1jUI+ita4wNMB1G69jbpNn6WyQnH+gS3nEk+XF6lBqPqROpZrLodrYzDBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784497379; x=1784583779; bh=fbSd/wEjoUog7vFWuFZ0XB+WbUYA6OdqVxC
	HgNiLGfQ=; b=T4XSvBvNusFsXnIQwB9IT81bLJMISqZZJJglfuVv9wwatTPtRBB
	xg4MB231np+cbfnTmMslxMc0lIJOR8J1WCz/BMH3kPNQhisO3DZvWS8zRLAyNIn0
	Mj3KRgPyUzLvvmP7WmTeqEDvdhBG6Q6JF0KUCSMYQL84M8/2cK5LASurVc/WoI71
	d9BfzRKNqtrAR1WJpeo1RQIgdWXzpRiLRL6uMgV+HcQb0ukzOflzIMrRg352awyC
	LlfUMjUYMn4LOikFR2Qmid3fZdvphRFj7fv9fU8tXugYwKY8/z1YUI6vimNWWL+1
	wMGmOf1UWWTgGQOTgMcI44KBM+d1ilHQeDg==
X-ME-Sender: <xms:40RdanriJBVlyQmZdQg33hjzGRbk-0i6aOtGPa_BC76EC0CHG1sFLg>
    <xme:40Rdaj4OdLcdUsBHMtifH588h_-Ug0rn31_xLgVhzJSdspgQsXipbk0IJvey7UDPA
    cpSaETq-v39KsemKj_qdySOAtiBsUDzvyOmM3lcrGOTEJ8Qtnxqxg>
X-ME-Received: <xmr:40RdamegoTGJiM3yMG32uirSq7OARadMLsl2d36kmpKXYxhxfmmqgxt_cXkCS5uKhPe-SQQIQv9NhmiXU_dhL7lfJu0Qhsk5pw>
X-ME-Proxy-Cause: dmFkZTEQYv2q7+7qQDRaNKQMzCM9aqEQ5A6SqF2YwAGFYVT5HPDchjHyF3Z3DgOHKufp1/
    W2qdgCT49h/roifjKq37yisD4/HhqswkkmPE4TQyr/u+LG1XUeKjUKE9HwIv867wrKRTSr
    y6RvQfMECYjM8fvGtPmB7eo1j6AhtnfqZ1fKiWETzNs+T0ZUtxdyOLGIg84ynes6sXmmUS
    ARP6euf6AEoscdFLRcOKmB9dS1zYB4dFDYtEHnCREpaQKt+OKAvuYnUXLChpOgQPE3b4e6
    vSxQ4L+v4hd5SBq/Ytd2YROkryml9kXB9HOPTuXZgCfQ7oMbmh7Wf2nSh7Z8yTNjvED3rG
    pCyChjJGor6IM0EbriVcWa+4jVT5bBTT7gI8fHSggfSGwZiLUjFDt+rPxa6XxZloUEF1we
    1QyjaIKsk9C9me5sUILTui+GYB5GHC7rSbBtMC5PsKEzoO5N3ybWRYVBLvKcCwXYIEcGto
    g+HHLH7Zu8ybIHe7bsvDAoUoYrKiP1PziPZdhr6Z2S7Av6dCpo0Bg1M8eWmtHzb1xWxf0Q
    c9siHLlws4LGiDcgJh1ES0a3l8nFg37BYedf4eRatZjyojh+nJYuwmXx4gGXH8PxSHkTQ+
    MP963RUMGe76avR/7iKmgm+k1jBOfkEJDTNHmvJsjwObx1T1wT2FnC+aUrLA
X-ME-Proxy: <xmx:40Rdag5EkRd6Jw_JbbpX8F8KhhHwfB-dmu4NPGFV43z_c4zvGgjynA>
    <xmx:40Rdaltim7Shwewnb5h2SmVLPj9EDcF0g0Ml0c_W6JbiiMmhIAja8Q>
    <xmx:40RdaogCuGhFMBWLFy7o-b1vEJNSt25IirzWyMy8_Bz4LcVkfO-rQA>
    <xmx:40Rdaoqf2aEa-RRh_TRx2xM531zmVv2JTROlQt6LMUE2cCVOJs2lbQ>
    <xmx:40Rdagk9FYN79K1aT78HsOvf_Qok5j8cUwfhuW3fok6ptP1yMMGTYi14>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 17:42:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v19 5/7] branch: add --delete-merged <branch>
In-Reply-To: <a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 14 Jul 2026
	18:24:51 +0000")
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 14:42:57 -0700
Message-ID: <xmqqpl0ilkpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> ...
> +struct spare_data {
> +	struct strset *deletable;
> +	struct strset *spared;
> +};

Let me offer a brief comment on the data representation chosen for
this design, which initially left me confused enough to suspect a
bug or two.  It turns out the confusion was entirely mine, and I
have since convinced myself that the approach is sound.

> +/*
> + * A surviving branch stacked on a deletion candidate would lose its
> + * upstream, so drop that candidate from the delete set and remember it
> + * in "spared" so its own upstream can be tidied up afterwards.
> + */
> +static int spare_stacked_base(const struct reference *ref, void *cb_data)
> +{
> +	struct spare_data *data = cb_data;
> +	struct branch *branch;
> +	const char *upstream, *up_short;
> +
> +	if (strset_contains(data->deletable, ref->name))
> +		return 0;
> +	branch = branch_get(ref->name);

Here, spare_stacked_base() is a callback triggered by the
refs_for_each_branch_ref() iterator.  I initially misremembered what
the for-each-ref family of iterators passes to its callbacks.  I
thought 'ref->name' here would be a full refname, such as
'refs/heads/main', which does not match what 'branch_get' expects
(which is a branch name).  The same confusion led me to think the
'deletable' strset was indexed by full refnames, which would then
...

> +	upstream = branch_get_upstream(branch, NULL);
> +	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
> +	    !strset_contains(data->deletable, up_short))
> +		return 0;

... mean that this lookup using 'up_short' (the branch name obtained
after stripping the 'refs/heads/' prefix) is buggy.  But that is not
the case.  The 'deletable' strset stores branch names, so indexing
with 'up_short' is correct, and ...

> +	strset_remove(data->deletable, up_short);
> +	strset_add(data->spared, up_short);

... adding 'up_short' to the 'deletable' strset is correct too.  The
same applies to the 'spared' strset.  It is consistently indexed by
branch names rather than full refnames.

This design choice makes perfect sense for this application.  We
have no business touching the upstream of a branch unless it is a
local branch.  A remote-tracking branch, such as
'refs/remotes/origin/main', lives outside the 'refs/heads/'
hierarchy.  Such a branch has no need to interact with either the
'deletable' or 'spared' tables.

I hope others will not be as easily confused as I was, but just in
case it helps future readers ...

Thanks.

