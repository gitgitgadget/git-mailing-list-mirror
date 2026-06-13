Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B396283FE6
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365465; cv=none; b=V8o0YptqXOdYJqOEwn6de44AjqxYza6YhbIxIwvADEupqpvB8yWR3Ikbzo3UnhWqTtooPeZe7trVZ1KQWnmGddoCjIWRW7/X549FsBDnXZPGq0QfK8Qy9D3yhz9VeDHe2gUqpU9/m/4f/mKHuVn/x2huOElXj3HO3WquWnfa9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365465; c=relaxed/simple;
	bh=i4azWqS18lbxRbSRospYUjJ+ZEXxbyhL0c6UeBHV99U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nIo3LT+EDExi2BT6LC5OVgUbgYbB+sRmDLtotrDJeERJRnbdwOXdc0bRzfcihYa5yfq0I4M2MzJRaJY00sfnZgPNT4kWBlv2Z8RUBFjaaRtRJQJvu3Ken1ZRhFMJF+S2GXlFdgU+TdUKE6fZXhGXbyzzU8iV1g1GkLW2yD1GFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SbaZxxKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTqQE7FW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SbaZxxKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTqQE7FW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BFF3BEC0100;
	Sat, 13 Jun 2026 11:44:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 13 Jun 2026 11:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781365462; x=1781451862; bh=sZdOEXGCh/
	N/GgyokjYOOXrJnHbGq8NU8dWtR/tcXhA=; b=SbaZxxKNIrmMCp6GPbjDkoAI/i
	/Bbimw/6AkCg+CyURt4uNtCI6CMBObxYDbhBqFR4UbMNeu/WETx/CdKbxAjXxw7E
	pHMH4/Jgpgtl2365LPqPB+5G7B4hgehyRksZf6g0Qj1RLLQGQDT/IZttaeuM7lhB
	p+oM2rbF/i5YhRmfhinUgBpfBVAl/T4L3k4KANHqxBP4KlUi7nhzQrVMiSx1l9Ve
	5AlrikteHCLdkxs/xxV4/ZheuMkwVdoabhTntWGwoJ0dXNpD+0I5zbcG8xJYts+3
	RcDWgvR/ycyJrOL02QcZx2Aq/TEiBN+hO2NWf30fdpjnNx0cBq6NOG9mqjng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781365462; x=1781451862; bh=sZdOEXGCh/N/GgyokjYOOXrJnHbGq8NU8dW
	tR/tcXhA=; b=DTqQE7FWu0XLM49FMX5/k/4pkIiGDyP/hS6z+oemEkYytcsPx8x
	6ng3vvmgB94yGGx3ATQpbEhk/soiY+tmomDmW3OAEs3yasZ1f8fle03zP/vqqkr8
	iynhDygAZ5jNWgvn1WxYXU818RnVFvGBSp3VsaEQupC/ZTg4meyVTqdShJOc33ex
	mRhLA86XBLLVsEtFCibKYGVvJkXF2KGfF+U2mPnZZK1E9G/cQYPv8ntQvrH/IIdX
	CfWTJRv4J2COpw/QMNteuqz0a2MzzpfsLxXpbHFQPhVRaxVmiKFixPKE2J1JQOLK
	DZzcYLCkqSIFz6LSefeCJeV87EWHWg1uugQ==
X-ME-Sender: <xms:1notag-XacEfi4FzaqqLLcPXAgYtSL9cflwCHg3adAzvkxO3VR1lKw>
    <xme:1notavuLr943H8O_vcJf_rVYu0p7WXED8Fz65D03PgYKWBGjfO7GaNIoQ1HF8LXGd
    Yg-BOlcM8ymXgaFZlIXY2wANTu1MwtMXuU28yklMlXu1asw-R9IQGI>
X-ME-Received: <xmr:1notarAp0Ktb7p-EwFhr82Yjcc63HqidAJjtYr14sVBZmb_KJoSW2bUG3r1RO5rF5ILoXIRwQZ-Cs_gSz743QCiqoo8_hrUs07wm>
X-ME-Proxy-Cause: dmFkZTGvBSdwRdzBWXU9lXMte7jv5/pJyEyK7OvdpFR76DjDIWBuhn7MC9sJ9PocE0p6qi
    5Dl7dtEORwmYPbY8c335eKF2M5NKCl97uuU7tiGFzGrrEhTW6me59x2atQ3gsBjwjqMxLu
    sSJbswcncYauB4qMcreh03FpC5IwRJHYVQzk2Gf/fQlRrgnlaRp8hX9iPVAkYXzzztxcnL
    jbNvC3ppLehezQ1HDS2Wevj4HZewMyr/m46YB80kq7PAnjEqY8OrcI/6FRcIfPzqzwlKNy
    ASQ+w2ogEI8fAGQcyoac+fkHYN6Z2auxCV2l7H33Xf4EViDhTY0Fh0eWVtMTWUYfCnxJOP
    pK15o0Vm2042OdnOgFd3fhwh55SasEAdVRNkSrmI/Qv5K0zMdWRUw9M+nGPg1A/VpTUms1
    7hukjxkzhq4nn8B3wv+0hdAJT8EejXJH47budcy8InlHpddbVkpfYVu4vM40eTL5Hj/5t1
    7Yym60Lm4BP2oKjYRthgDWWswCm96KYV2sits1TRk5eAlB1KXtmlmmzmrbhm1xX4/vLCOx
    wcwnhZV6yxULQvEn70Ee+unZMFxwPb8s8f+RFykSbYOAnpw/4w5mPFMoqpkv8vsBbJpY8Q
    LAWEdFdsrxfP81oxUreqf/ZMCxFUKnCv9GFfiTFXIL6ViGh3szRzFCSGmybQ
X-ME-Proxy: <xmx:1notavXtdRRuD-6t4_zm0qqFmYORRrM-keGsioN3L-ixHwMZM0Sfiw>
    <xmx:1notahClHSs5rlwNzBLJVrho0tFEF5IwEUpNY3iUxoESyhZ40MDwZQ>
    <xmx:1notaq_1QVcoKkeljok8fZJuz3_u_znRayzfoqwxZIFUJ4t4L-rpoA>
    <xmx:1notagHpDzGsaEVPws849E1Cj1p1urDEz67r9sU2CeSmTAZxdnOM8Q>
    <xmx:1notauhL9kRKHXpWGHUiIM1ctLDrxg9uFeUu7AvopNfzpW2jctvRJQPL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jun 2026 11:44:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 0/2] commit: preserve commit hash on a no-op amend
In-Reply-To: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 13 Jun 2026 09:16:27
	+0000")
References: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 08:44:21 -0700
Message-ID: <xmqq33yqfnsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> git commit --amend --no-edit rewrote the commit and moved the branch tip
> even when nothing changed, because the committer date was reset to "now".
> Reuse the existing committer date so a no-op amend keeps the commit hash and
> leaves the branch untouched.
>
> A real change (tree, message, author, committer, or signing) still rewrites
> as before.

I think this change brings nothing but regression.

Isn't it obvious that "commit --amend --no-edit" without updating
any tree contents would record exactly the same contents as before,
without a "real change" (as you said above), to any and all users,
expert and casual alike?

The end-user who runs such a command must have a reason to do so.
The *ONLY* valid reason anybody might want to such an amend is to
make sure the result is a new object, even if it records otherwise
the same content.

Why would they want to do so?  Perhaps it is so that future merges
of the topic branch that contains the commit will work more smoothly
into an integration branch that had earlier merged the topic branch,
and then that earlier merge was reverted.  This change will rob an
effective way to ensure a successful final merge in a workflow to
(1) merge a topic, (2) revert the topic, (3) update near the tip of
the topic while keeping earlier topic intact, and then (4) merge the
result again.

So, no.  I do not think this is a good change.

Let's digress and imagine an alternate universe where rebase/commit
--amend/history were "smart" from day one.  These command in such a
hypothetical world may not be capable of refreshing an existing
commit without making any "real change".

Making a change to these commands to _optionally_ allow them to
recreate an otherwise unchanged commit, so that it will get a new
object name, would be a welcome change that would allow users who
would use "commit --amend --no-edit" with today's system for such a
use case.  

And that would have been a logical evolution of the system in such a
hypothetical world.

But the thing is, we do not live in such a world.

If we still think that alternate hypothetical world is a better
place, we'd need to actively move things around, carefully designing
the transition to avoid harming existing users along the way, to get
there.  Changing the behaviour all of a sudden and breaking existing
workflows is not something we do around here.

One way to get to such a world might be:

 * Introduce an "committer timestamp is a trashable information"
   option, and teach commands like "commit --amend", "rebase", and
   "history" to cheat and yield the existing commit without
   refreshing when they are asked to recreate an existing commit
   while the option is in effect.  Give people the opposite
   "committer timestamp is not trashable information" option, so an
   earlier "is trashable" option on the command line can be
   countermanded by giving it later on the command line.

 * Have users discuss if "is trashable" is a better default, and
   gain consensus to make it the default in a future version of Git.
   Advertise the fact that we achieved consensus LOUDLY, while
   telling dissidents that "is not trashable" option will forever be
   available for them.

 * At a big version boundary, switch the default.

And I do not think I in principle would object to the first step of
such a three step process.

Thanks.
