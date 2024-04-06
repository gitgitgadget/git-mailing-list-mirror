Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436AA50
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382007; cv=none; b=EhBfaxwHwdW1e0rs0ZLVzq4XVKoYrDxnC0PabvdovIUgMhbvcwWhtUJkvsNIiZ5XZcDZfSoc+P5bZKAMcI78IKbG9W6eGIVo8M8KneZMakSehB+nh5qQc9MmqdBOlwO8GwxgRjGs4PyReQsprHl1+L/WAWxwcIralrPcMLqcoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382007; c=relaxed/simple;
	bh=v7P9S0jCYlkk496N51aiPxKNy7IE4iU9njRkcGLfXl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+6IrvrbbSq0SCV10qzSCE5xQfDE19Y6mFusjFNFWmvRGyJzBSUdSRfsG9QVl6DVY5ZVUEJ3V2AhY5IWfypgIjRrqMgVwFEh/l+A2qYj3s/V2g+SudCUq5MT4q7vkrD2aB6cup7neFxr1sbMXyjoLOeMpXEMphQKrFYk5D6tBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g9Jln636; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g9Jln636"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF1561F4641;
	Sat,  6 Apr 2024 01:40:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v7P9S0jCYlkk496N51aiPxKNy7IE4iU9njRkcG
	LfXl8=; b=g9Jln63648xwcNg/mNykCtJN2GoC3AAOSBHsOxqs6cRAYeuo3bTl3X
	DidS1NhdisI0f/Zd1plWG64ir01g9oyD69OZZLmmINgzFODFd8lH1gMbQ/9yhshv
	5un+U+PJKayF70P/lOaOYd2MCFabENeKzFEPx3IvvfTBfFaN2sP5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E2041F463F;
	Sat,  6 Apr 2024 01:40:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFA151F463E;
	Sat,  6 Apr 2024 01:40:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sat, 6 Apr 2024 03:48:28 +0200")
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
Date: Fri, 05 Apr 2024 22:40:02 -0700
Message-ID: <xmqqwmpbm4lp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E0FA1C4-F3D8-11EE-9406-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Following the approach of making the produced output more readable, also
> emit additional vertical whitespace after the "Send this email [y/n/...]?"
> prompt.

Hmph.  I'd prefer to see you try not to endlessly extend the scope
of a topic.

By including the above change, the patch no longer is small and
focused enough, which was the reason why we said that the "let's
move the final newline out of the translatable string" can be done
as a "while at it" change.

Besides, because of the switch to separator semantics, that hunk
lost the reason to exist as part of the "use a blank line between
output for each message"---the change no longer is needed to support
the feature.

Even though it is a good change to have, and it deserves to be
justified by its merit alone.

The whole thing deserves to be a three-patch series, the first one
being a preliminarly "let's move the final newline out of the
translatable string" step, followed by "let's have a gap between
output for each patch sent out".  Perhaps another "even during
sending a single patch, we may want extra blank lines when use of
editor and other user interation is involved" patch on top.

I haven't formed an opinion on that last step, and I do not think I
can spend any time to think about that new part of the feature for
some time (others can review that part and give their opinion on it,
of course, while I'll be working on other topics).  It would mean
you are adding yet another feature to delay the base improvement to
stabilize.  You really do not want to do that.

In any case, this [v4], as a single ball of wax, is not something I
can confidently say "I reviewed this and looks OK".

Thanks.
