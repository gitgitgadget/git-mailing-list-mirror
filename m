Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04E217723
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814625; cv=none; b=hxNewpTPDqkAZKGA4roleW9YHIAI1zIScPnrEtL5gHqg4eJraVTfy/RkCeOXYso5IAZL5EpFjEoLPl4exa61IXkJumrsKSrIPTmXJaj4gxVT8CnwUFJUvGovSwVrqVo1qJ9zbpIBeKHfuy1TEdio++iaP6ppfddvtzzxW70vKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814625; c=relaxed/simple;
	bh=PIeRZYSdqrCwRdcbrRGg5ZDca8iuVvNGqXhQn7DTPKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHAlGuamfsBuJv72596cph6qJEdPdQUxtqdrBlp/JcUKcLxrlKUgyV216UKvfIQfZTBHmusQGRQG5c8W9iXj1KE9yhXJ4j8fJc09cSWZK/lAdavzYjYRZgSgPy0kY6F8XKZrgv0fRosOBzNRcIuKTeiHm8FISN2RRdPUnpWRv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=auCANxHP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5Aq6Xeu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="auCANxHP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5Aq6Xeu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D131EC02AF;
	Thu, 18 Jun 2026 16:30:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 18 Jun 2026 16:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781814622; x=1781901022; bh=pRPBxmxNma
	RvOzr6WKPgNQCQkagR/4KixacKy0qIfXs=; b=auCANxHPyCjNNtydq2Hajg51i9
	VH9Li0UGf9T2rcAVGArlC93p9hHbal6b8tUrblu/1/4Miu8wWfKbftKX31xk8Aef
	5q8wR4n/JZfNHA5qKLPOfNXf0PlpdRVARrSoUvUcXgdQw48hPOnD2X/cN4M3xxAo
	iKB5rk5LznVYlW2EV/PJqL9ZCbv/w1OotBlkgcIHn9oXdPWov5k5dGadeETT4uOR
	vQsEOkZAge6lr4tsKbM20vT3mPdAC9vgtfAVI61dHnQD2SLlUie/+R/vLkkE4oWt
	slC6NUI3bkDcAiDgNzsaZrkVI2DHxXmjH+36q9XC1Zbz5Gqog5vFfRj7Z9lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781814622; x=1781901022; bh=pRPBxmxNmaRvOzr6WKPgNQCQkagR/4Kixac
	Ky0qIfXs=; b=O5Aq6Xeu3Zl2JjkMfMZ+qEjysBm/XcICIKvh2E/zlyVR5GWC6bH
	BYCXMxQLIHUVySbgkVdxvRmzbVVI2yT6A3b6VtE3PBdrAKMMa4Uk50pFJd8D1lgv
	dYA/z+TSli3188bBFojSG+7ZR7EtaFvwBVCNHrFNDm5k2UzP50ZnYCgO63QG71tI
	3L/AYVc07NTalbGLSG0Y2y1gxY4YfJ5FPdPrhJIDvTjCvrnqEmO/oTpRiWqDz/VG
	IJ3B9BgJMjFczuNKYvKrWwNHtNn4+DO52H7aPKTiHDK2E5ktBqN/TEsyAvrQbJrY
	sr1zr+AQIcZP5xI0UBHyw/oRUGC1Mw4pKJA==
X-ME-Sender: <xms:XlU0alY7Baz3m5yPB_E4OmtsWsLVJjzzYQCAd5msvkrpF7Ow65Ugog>
    <xme:XlU0ajZIAJxPyHbp33d8gfy2K-K93yeVPksfXjbWx9iU8E-WPsw5q7yp63clVciO4
    mSiScJ7nqNxcsNeTD3FHSkukd1batsKSsBPwMcyx-QZKqlfCI0miUg>
X-ME-Received: <xmr:XlU0as9QsYCAslu5mdhNVbAEBaOE16tIEPwafGPCUq6K3F81zUFR8x554IfEsO47yclRXpKlZeOmRR2vmVOaRJrRa5Y_m3-2spYu>
X-ME-Proxy-Cause: dmFkZTGPRm0EVtj9krNs/PcxWbj7vuLlTgavJfeBoFZfmPCG5hOTbh20reWb8eSwIFeJtc
    1BqkWCFfxwr42ou+cHXHq9VCgOUhMdqyGcE6zwsMf9FKNp8W7iJu43Hceio5RnuRAQ+ckL
    K4MP3eJNL/tefu4i1bn0VItOqd8LIst1vUukPXCW3RSid2Kqg0xKF2QpTD2NZ2HhQ2+Ai7
    r472My2D3MbcBpwfc8OYyOQQgv9YILMw9ygWInyMyOr5fODpbnJ1XX3Kb+OWQPM+DX+WWc
    dN5CWSIA/M/b+2Cw3cjHNcWIx9CFFWq//1jmfdx4ZuSNW3MzElRK/HXVc6t+/YptnkoOrD
    1PELZxTMLHmpRS4ZnL1CLSbp5YWh9Klnz/kWTfwVU7ijHIKNxqPI1c16vwe6P9mQSwdehp
    mjq95/jlAhIx0b032T334YXWYSJZbm51EpQhmCyUT1LMnpRg9YesuG/WfMvYYxvbKWdVVC
    p7MoaKo/GJBBuMbiLErRJ8lIoP+oTJQ+qBkR9oNVxlhIThtj/KHoPdzxBxfd4YgB35qZs6
    1RBt2Jf+DOK2uNy/wO//Dcb3ILHXC+1o7JgDI+VpyWenD7Z/yt2b8j++IDOtf9xSuyaai+
    FT7U80aPTrnUa5+r526UDApLlUV8Z1qq/RMoxdM/wCV73/42Mi1uy8C3sKzQ
X-ME-Proxy: <xmx:XlU0aihwDfTBrUDnXDQybawanSsUhkBqincwCdRriDvfKsgm3WLDqg>
    <xmx:XlU0asfmnb64BsRaVGbKiPVK5AUOuDG5TEQuOpv6QhkWQU2k47i6dg>
    <xmx:XlU0appanKY02W_UjHUiJbvXlfyuSyyXFUhNS2mvdMkeIHN6oVBUAw>
    <xmx:XlU0ahAD3AO9_PfPOhZQqlgtaxgE7-KSTYanQTpVJZJ_fZ1fzmUUig>
    <xmx:XlU0avJfUxruO54yr7AlqqpHl2FinSiQOYfuKSuDNZk43wemiymBPQkG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 16:30:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 3/4] history: add squash subcommand to fold a range
In-Reply-To: <66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 18 Jun 2026
	19:17:05 +0000")
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
	<66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 13:30:20 -0700
Message-ID: <xmqq7bnvr3qb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int cmd_history_squash(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	base_tree_oid = &repo_get_commit_tree(repo, base)->object.oid;
> +	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
> +	commit_list_append(base, &parents);
> +
> +	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
> +			      base_tree_oid, tip_tree_oid, &rewritten, flags);

We use the tree object taken from the commit at the top end of the
range, and create a new commit directly on top of the boundary
commit beyond the bottom of the range, using the message from the
commit at the bottom of the range.  No need to go through the
rigmarole of replaying commits in the range stepwise like sequencer
does, since we are not transplanting the history on top of a
different tree at all.  Very nice.

When I do drunken-walk development to build many commits, making
detour to arrive at an ideal state, the key message is often not in
the bottommost commit but somewhere in the middle where I discovered
why my initial attempt were wrong and discovered a much better
solution, so using only the message from the oldest limits the
usefulness of this feature, but I guess for certain people the
bottommost commit would be a good default.

I see you have already an option to grab messages from all the
commits in the range (many of which may have useless "oops, that was
wrong" single-liner) in a way similar to how "git rebase --squash"
or "squash" insn in the "git rebase -i" todo list lets you use them
in the next step, which is workable.  It is plausible that we would
later want to offer an option to name the single commit that may not
be the bottommost one and use the message only from that commit.

But we'd need to start from somewhere, and "use the bottommost
commit and nothing else" and "we will give you messages from all the
commits, just rearrange them in your editor" may be a good place to
start.

As t3454 is taken by another topic already in flight, I've queued a
trivial "rename it to t3455" patch on top before queuing the topic.

Thanks.

