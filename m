Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620815E8B
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399916; cv=none; b=MzM13UzdUNvDAUi3/bpxWLNjRaMTkSCbN+fj2T0zYtl7UkwBm21gCJl4Y/z3UDe7RRqTCyQg4lQkXHU4U4i5mw8RIfhRXvEOSmDFPRaxj18CaGKh/cy974l8SO17kppumEAJydBSifUX2Pt6wmY+hEgntiCwkHgZQ23yBgH7N78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399916; c=relaxed/simple;
	bh=fN60Enfx607R9Rqll/LHiTgQ7tP5IDo6+N3l5/w8pjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d9+/68iDM49sWIGg+ljzqslj3lw0mK0CqdsKS712ygCYaplcCGRT0IVM0UJQhCkzZF6oUiqvd1uCaXf3hsBEKWBmxGFH5WzAMXdbL2P4bhsJjbsJR5Mk/fmqK/ao4DB+/V9htEgEm/XLANCY7rOd6VFvIorstvehNnhDwlBXMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CC1HCR+p; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CC1HCR+p"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DD2E61C4F8;
	Fri, 19 Jul 2024 10:38:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fN60Enfx607R9Rqll/LHiTgQ7tP5IDo6+N3l5/
	w8pjI=; b=CC1HCR+pOcwfhad6ufF50NGg8KD9ylicksRvQibHpT/WfHSACZqlPv
	rQOt6qJ5vfI0gMOwINmbfVNs3Bf2EmOeQap3XMjS9cveEcS5DqNG4p+YS9V0SyRG
	D1TER1OACRfaYD6HunMothPyL0juv1UVzRGcHYAwTDHNzlHjsoMlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C805C1C4F7;
	Fri, 19 Jul 2024 10:38:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B79F91C4F6;
	Fri, 19 Jul 2024 10:38:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Equivalent of difftool.prompt per tool?
In-Reply-To: <wglGbP7resY1dIKhfKqMcs6Xxu7f8iWSZ76k-MFC91eKTEWN2Aw4D6TqNAEndu5b1VZMVnOIS8m9HNoZPFxd6NZjKKmW0OmM8h5bAEuwoVY=@rtzoeller.com>
	(Ryan Zoeller's message of "Fri, 19 Jul 2024 03:31:11 +0000")
References: <wglGbP7resY1dIKhfKqMcs6Xxu7f8iWSZ76k-MFC91eKTEWN2Aw4D6TqNAEndu5b1VZMVnOIS8m9HNoZPFxd6NZjKKmW0OmM8h5bAEuwoVY=@rtzoeller.com>
Date: Fri, 19 Jul 2024 07:38:23 -0700
Message-ID: <xmqqa5idmops.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8DE7D81C-45DC-11EF-B5B9-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Ryan Zoeller <rtzoeller@rtzoeller.com> writes:

> Is there a way to specify difftool.prompt on a per-tool basis,
> without manually passing --prompt or --no-prompt to override the
> global difftool.prompt setting?
>
> I generally want `difftool.prompt = false` set, but one specific
> tool I use has a high startup time and I'd like confirmation
> before launching it.
>
> If this isn't possible today, is difftool.<tool>.prompt something
> others would find useful?

I do not use difftool (nor mergetool) myself, but given how
difftool.<tool>.cmd and difftool.<tool>.path behave, it does not
sound like an unreasonable feature wish.

I'd imagine the feature itself should be trivial to add, but we'd
probably want to add test to t/t7800-difftool.sh, where there are
already existing tests for inteactions between difftool.prompt and
various command line options.

Thanks.

 git-difftool--helper.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/git-difftool--helper.sh w/git-difftool--helper.sh
index dd0c9a5b7f..872d787b09 100755
--- c/git-difftool--helper.sh
+++ w/git-difftool--helper.sh
@@ -12,7 +12,9 @@ TOOL_MODE=diff
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
 	prompt_merge=$(git config --bool mergetool.prompt || echo true)
-	prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
+	prompt=$(git config --bool "difftool.$merge_tool.prompt" ||
+		 git config --bool difftool.prompt ||
+		 echo $prompt_merge)
 	if test "$prompt" = true
 	then
 		test -z "$GIT_DIFFTOOL_NO_PROMPT"

