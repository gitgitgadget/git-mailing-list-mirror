Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B420DD2
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061703; cv=none; b=D0Y+HngMh1EmSYfrdv75inusUwEp2ASIGq9zShR7+y0HLYd3lAADu9ZxKqFquwa7ZcRYt9OsfvBrNJEES6t3DW0lh/e7lQrmeYPpcNOUzcxp+L6Iyw1XwnBmXl+cwCRY+CtxQ2spdnpfzrnCPNytRfuL7tbQanT0muKbcgUg4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061703; c=relaxed/simple;
	bh=nXUMby2sRvpfgH57zZM+tRhd9dqTyoDXOGhL/2J9y+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0vhwx5pFvbH8DaZ2UssFbVOSfPHzKeylHXgRPtKG7UDagwfJSuIC2ApT2rkH0REZOvRsoF0iW1tzXsMvi3wq/v331mlOxN8Qqz51UGxk6Z0gMXJsg+F5JcQxVvL+aHc9ROkRCqdV5w1UuBhG12f8CR41VR3BIfU4beJ2LLsK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ft87KtOX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ft87KtOX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E02E81FEDE;
	Mon, 15 Jul 2024 12:41:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nXUMby2sRvpfgH57zZM+tRhd9dqTyoDXOGhL/2
	J9y+I=; b=ft87KtOXmQTCzBwS3z6e3kuD+vIavPYP66J4zHhAVszybyLNU5g7Mq
	jxhC3xWg1gyCUBqa1/T6QWXK67LsauMAENujfwqOfmUJD1sNvKWyPT08q2sHgPfH
	vGxaV4+87VjPvOJBLpfaxlTf0z1y168owFRdJacU+d6IvNmgWAlAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7EB81FEDD;
	Mon, 15 Jul 2024 12:41:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BD001FEDA;
	Mon, 15 Jul 2024 12:41:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,  <git@vger.kernel.org>
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
In-Reply-To: <00af01dad6cc$41f10d40$c5d327c0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 15 Jul 2024 11:32:46
	-0400")
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
	<xmqq8qy4adl4.fsf@gitster.g>
	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
	<xmqqttgr9aeb.fsf@gitster.g>
	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
	<004501dad61b$b35b7f30$1a127d90$@nexbridge.com>
	<ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>
	<xmqqv8167kd8.fsf@gitster.g>
	<00af01dad6cc$41f10d40$c5d327c0$@nexbridge.com>
Date: Mon, 15 Jul 2024 09:41:39 -0700
Message-ID: <xmqqh6cq4ngc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C59885A-42C9-11EF-B582-965B910A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

> What is strange is that when running on NonStop using ksh, t0000.1 has never
> failed. I think the situation is subtly different from what we are solving.
> My take is that there is a difference in the local vs. non-local variable
> set semantic, rather than just accepting the keyword. I would propose that
> we need a more comprehensive local test to verify the actual expected
> semantics rather than just testing the syntax.

It is possible that I may be misreading that first test, but as far
as I can tell, it is testing not just the syntax but tests how the
variables declared "local" behaves and should notice if they are not
localized.  It checks that "local" assignments in try_local_xy does
take effect, and (more importantly) after try_local_xy returns, the
original values are restored.

As I speculated earlier in an earlier message, the breakage you
reported may have to do with interaction between "local" and use of
a subshell, and perhaps we can also check that pattern in the test.

Thanks.


