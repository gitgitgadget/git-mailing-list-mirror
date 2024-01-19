Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F955E5D
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684663; cv=none; b=ZZBlR0XFGK/sP5Xv/CU0698X7I9KZnzWCz+G2byQNqTroNr6vVABrf1Z8GPTfgO0Hx1iL5J7bfx/kz4by0RKn8G/2Cymxwf/vzlAGzODksVLtqtDD1a5SciMl8zmO1Xf80RxcDG16TP2EatiCSKDObE5ip7SAX16WTcpV8PrPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684663; c=relaxed/simple;
	bh=vftB7WocDgkdn+j0/qfzsQMTBIKP1wI3ycWl89yYaSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=osNLdumKOsBIKAbckjaVkh2WUi0Yi4P7kjm5EscOgIZyomxz7ZZ+y96+eYBRHn+HD06FqtkRuEeYf2QppMqwg7GJwrLi8vllPjX28paqC71PGvz5Q6GJ/r2VX+5LQzzP5Zf5cHZnGqSbhkvGaMR00Gn1gxuIJLAjUEhQZyUBFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cj3iKoCL; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cj3iKoCL"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 345481D46E2;
	Fri, 19 Jan 2024 12:17:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vftB7WocDgkdn+j0/qfzsQMTBIKP1wI3ycWl89
	yYaSA=; b=cj3iKoCLnrXJg47RWl9qV51wIQLhV1c20Cjicr9tDHH7dHk0tzXRLn
	cPxHsJHz3n1obm1SsDT04YBKl3BnxifS5NbX7eEv81q4odSjAJauHftUk7Cl+mVy
	wOD3nW7IjZZMvKp3oGcJTJoyaEGvjkfWjeRMkuBPjvuw6mXzPxbzI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AEA01D46E1;
	Fri, 19 Jan 2024 12:17:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A9CF1D46E0;
	Fri, 19 Jan 2024 12:17:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Sebastian Thiel
 <sebastian.thiel@icloud.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Josh Triplett
 <josh@joshtriplett.org>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
In-Reply-To: <7fc35078-a165-4b3c-96e2-37fbe55e109d@gmail.com> (Phillip Wood's
	message of "Fri, 19 Jan 2024 16:53:50 +0000")
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
	<xmqq8r5gfc3j.fsf@gitster.g>
	<CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
	<xmqqsf3nl2b3.fsf@gitster.g>
	<298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
	<xmqqwms6qwr3.fsf@gitster.g>
	<CABPp-BHaUDdtH6igDmOx_wv8xYh-uA=4L9zDDycrZLaa9c9KLQ@mail.gmail.com>
	<7fc35078-a165-4b3c-96e2-37fbe55e109d@gmail.com>
Date: Fri, 19 Jan 2024 09:17:32 -0800
Message-ID: <xmqq1qadmedv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2B409FA-B6EE-11EE-92A6-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> If you've added a secret then catching it after you've published the
> patch for review is likely to be too late. I agree there are a couple
> of chances to catch it before that though.

Yes, this is one of the two remaining things that still make me a
bit worried about the "$.config" syntax.

> Indeed, though "git clean" requires the user to pass a flag before it
> will delete anything does have a dry-run mode to check what's going to
> happen so there is an opportunity for users to avoid accidental
> deletions.

True, too.

The other one that still make me a bit worried about the "$.config"
syntax is what I called "the devil you already know" that is
applicable only for participants of a project that currently mark
precious files as ignored, to avoid the accidental "git add ." of
secrets.

I think we already are in agreement that all other points (aside
from possible ergonomics preferences and future extensibility, both
feel a lot minor) raised during this discussion are in favor of the
"$.config" syntax.

> While I can see it would be helpful to settle the syntax question I
> think parsing the new syntax is a relatively small part of the work
> that needs to be done to implement precious files.

True.  The parser can be isolated and it should be relatively easy
to revamp.  My current preference is to (at least) tentatively agree
on using the "$.config" syntax, which would allow us to update
dir.c:parse_path_pattern(), and that would make it possible for us
to start adjusting dir.c:is_excluded(), adding is_precious() next to
it, and adjusting all current callers of the former.

Thanks.
