Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2B56757
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451247; cv=none; b=VbkvPMHY8L82c2A06MhgSPZHOVJKJmhL9sjoz/f7umuinm2AIjY6ee879RYiDp57UP4Jbq/XR30uGr4UA/Y09kpxsRlknfGSWZ6vr+l+n0PkMTLCO29gzHkWMPzyPsFe5oioVygcOQ/uuFTceeCpYTSZAj38q9luPSA0KEYVrFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451247; c=relaxed/simple;
	bh=eknsWR5HQM7iVl7Acynmc1PThsvaVtZfnQ4LhutGhwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0IU8aOeha6QntA3pTYALyO6+UiHtov5ciX1n3evqs65JM69Gka5B3hbKBQMf9qM1r5f/qAA9Lk4ejlAnX61TMj+hMkxFMtRen9lGLlptCLfjeXMfMy5y6zxAMZH2z+ONDxsjcbkD2fzGrx/o+mxpoXvp62yKSzviwlJI33XJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELZHFyer; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELZHFyer"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47E371E94E5;
	Tue, 20 Feb 2024 12:47:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eknsWR5HQM7iVl7Acynmc1PThsvaVtZfnQ4Lhu
	tGhwo=; b=ELZHFyer3GPxQz8onlanSjdle2qGTzVW6fd1/ZhHwKE/xlnYGpu0zs
	6HCOkJjVVrEr16w+j0y3Jgl11ZL2r57QS+NJoiJ9Meoumbsli5sFsCjeREw+UGe7
	L3DPikLCbCQTa7DgchiH7IU0r9D8UkfoUgaWb/B8P7xk92NhMyQvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FAA41E94E4;
	Tue, 20 Feb 2024 12:47:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F08F1E94E3;
	Tue, 20 Feb 2024 12:47:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ricardo C <rpc01234@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
In-Reply-To: <78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com> (Phillip Wood's
	message of "Tue, 20 Feb 2024 11:01:30 +0000")
References: <20240218033146.372727-2-rpc01234@gmail.com>
	<99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
	<df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
	<78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com>
Date: Tue, 20 Feb 2024 09:47:22 -0800
Message-ID: <xmqqjzmzqb85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A741D12-D018-11EE-8CAC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> That's a good idea but I think it would be better to test that "git
> stash create" is not affected by the config as we don't want to change
> the behavior of its behavior.

Yup.  Making sure "stash create" stays the same is a very good
thing.  Thanks for suggesting it.

Regardling the need to have an escape hatch that is well publicized
long before a potentially harmful switch can safely happen, one way
out might be to

 - Declare "git stash create" is a plumbing, but the rest is
   considered Porcelain.  Publicize it well and wait for the word to
   spread out.  Folks who are in favor of adding these configuration
   variables to the system may need to do some legwork, spreading
   the word around at stackoverflow and various other venues,
   scouring public repositories at GitHub and other hosting sites
   and studying third-party uses of "git stash" that should be
   replaced with "git stash create" followed by "git update-ref",
   and raising issues to notify the owners of such projects, etc.

 - Add breaking configuration variables after a few years.

We cannot do the usual "start warning when we detect problematic use
without changing the current behaviour, wait, and then switch" dance
in this case, unfortunately, because we lack a good way to detect a
"problematic use".  We cannot tell a direct use of "git stash" via
the command prompt (which may want to honor the configuration) from
an IDE running "git stash" reacting to the "[Stash Now]" UI element
(which might want to honor the configuration) and from a third-party
tool that acts like "rebase --autostash" that wants to save away all
local changes to clear the slate to do its thing (which we should
definitely not interfare).  If we could do so reliably, then we
wouldn't be having this discussion---we'd be using the same logic as
we would use to tell when to warn and instead of warning, just silently
refraining to honor the configuration variables.

An eve easier way out of course is not to do these variables, of course.

FWIW, I can see how permanently enabling "include untracked" may be
OK in a workflow, but I cannot see the utility of permanently
enabling "keepindex" at all.  Sometimes I'd want to clear the slate
so that I can try building and testing what I added to the index and
that is why I want to use the option.  But a lot of other times, I
want to clear the slate to go back to the very pristine state that
is equal to the HEAD.  As the need to switch between the two modes
happens quite often, the way to defeat configured stash.keepindex
takes quite many keystrokes, and in general I think the regular
stashing happens far more often than keepindex stashing, I'd find
that using shorthand "-k" on the command line occasionally without
having this configuration variable would be what people would end up
using anyway.

And there is always "[alias] stk = stash -k" available ;-)
