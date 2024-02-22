Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFB14C5AB
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619540; cv=none; b=rQvYjQ/Cd+SBRmqe+Qvwkkqc4sMyVZKFaRphc9KbaAyqC0gMGToHGCu0RQVJ0pCZxapYLYH/aoZZcuD/Dhj1CXVFvtlm3W/i0KP/zeaDC7XoDL7DOUetGXSbqhebh4/sRGyRf+nRtiNwkixZvGQHV4hl7iyppRw6LoIjbs4E+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619540; c=relaxed/simple;
	bh=MOwKf6NxuXYaBz2Wh6dHlMYRrNa6RbSVdmDYMxu1rl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpzaxHYKrZuHKLI/35mLAk2GVuXJVLG+fIoZIKdnPt59pCa39RVX/mmkH+DZFWWzW761389jw7VBmnjgHzf2lNVs84dHqbnGrof9GFh7mvRMxaVkz+jwGidC9KL3GdEm38xXou9jw0PeGnREVGJOpZv6FPI6vONc9YPPTMcJCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKU0siMA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKU0siMA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D5B1D5AC3;
	Thu, 22 Feb 2024 11:32:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MOwKf6NxuXYaBz2Wh6dHlMYRrNa6RbSVdmDYMx
	u1rl0=; b=GKU0siMA4CTwDmorEBVH8N27GTyRLdSJ5qgJMYgMBlbmieBCQeXeNH
	I9ZU3UzYF06VIeKktp2Eda+B178AsaP+YPGSs2aAd7ekY+aOaZ9IgZxCnjm6TeYU
	lmMoF6/AJbCfNHNHVcUlsSyNbTa2NpdasRszrmygmGD3Kh+8E/b6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E02C81D5AC2;
	Thu, 22 Feb 2024 11:32:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD99E1D5ABC;
	Thu, 22 Feb 2024 11:32:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Yasushi SHOJI <yasushi.shoji@gmail.com>,
  Denton Liu <liu.denton@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
In-Reply-To: <ZdcNtxw04MtybTWZ@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Feb 2024 10:02:47 +0100")
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
	<20240221084250.GA25385@coredump.intra.peff.net>
	<xmqqv86hogpi.fsf@gitster.g> <ZdcNtxw04MtybTWZ@tanuki>
Date: Thu, 22 Feb 2024 08:32:06 -0800
Message-ID: <xmqq34tkiho9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC48AAC8-D19F-11EE-AE6E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Even though it may feel wrong to successfully resolve foo@{0} when
>> reflog for foo does not exist at the mechanical level (read: the
>> implementors of reflog mechanism may find the usability hack a bad
>> idea), I suspect at the end-user level it may be closer to what
>> people expect out of foo@{0} (i.e. "give me the latest").
>
> Hum, I dunno. I don't really understand what the benefit of this
> fallback is. If a user wants to know the latest object ID of the ref
> they shouldn't ask for `foo@{0}`, they should ask for `foo`. On the
> other hand, if I want to know "What is the latest entry in the ref's
> log", I want to ask for `foo@{0}`.

The usability hack helps small things like "List up to 4 most recent
states from a branch", e.g.

    for nth in $(seq 0 3)
    do
	git rev-parse --quiet --verify @$nth || break
	git show -s --format="@$nth %h %s" @$nth
    done

vs

    for rev in HEAD @{1} @{2} @{3}
    do
	git rev-parse --quiet --verify "$rev" || break
	git show -s --format="$rev %h %s" "$rev"
    done

by not forcing you to special case the "current".

Ideally, "foo@{0}" should have meant "the state immediately before
the current state of foo" so that "foo" is the unambiguous and only
way to refer to "the current state of foo", but that was not how we
implemented the reflog, allowing a subtle repository corruption
where the latest state of a branch according to the reflog and the
current commit pointed by the branch can diverge.  But that wasn't
what we did, and instead both "foo@{0}" and "foo" mean to refer to
"the latest state of foo".  We can take advantage of that misdesign
and allow "foo@{0}" to refer to the same commit as "foo", at least
at the get_oid_basic() level, whether a reflog actually exists or
not, and that would make the whole thing more consistent.

In any case, I do not know how this "usability" actually helps in
the field, and I wouldn't personally shed tears if it gets removed.
The above is just an explanation why it exists.

Thanks.
