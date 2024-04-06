Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4587817
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362748; cv=none; b=J2WOWdSM13dNZ5lmApcc0PqbWkOfIDa3pa2pljvC2kgpDp1rvqNRrUl3VVXlBDGy/5jPjvEGfoo91PVhYcheEQFOYAe9+BarYQEEng018CjFbrSRh7xT57wIQ+Fb1Ezljw+voED9Dio91eT5DSLpGmK4yA1KqeWtZtCwUquHjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362748; c=relaxed/simple;
	bh=5KlUkj8UCmltDrUGJYO7SFUdxMrieRlsnWnBbut+d7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPv5Ruat4pn0KEx9fqqz52r+KprstUp17+O1fTkIdug0NKctD3r2w64T/MlYV5fP+amRK5XyR+En0T1k4iS2s2mhHKMIU8y+p6mx81UaSruJqe20T3bdiZSqG3UjZanuuFh5tHnnda3zPV3q9E0qw7S321ntWkf2+Eo6rLJ9qzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lUtlXp/A; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lUtlXp/A"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D40B31DB3ED;
	Fri,  5 Apr 2024 20:19:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5KlUkj8UCmltDrUGJYO7SFUdxMrieRlsnWnBbu
	t+d7o=; b=lUtlXp/AmePCuGhB3R1hcss2fAqYwuwBN5n9/AcEMnO7oH2KJXj74j
	DBwpXPSIqSdlngke/Btd9dh4JLF+KT09qNUZNsMygAI+l4o7DHxsp4ENErdoR5lb
	sbE4ddwHDc82WvHEEymD32RyabNj/OV5jinyBrVjVCCpsSq0x0nhg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD1971DB3EC;
	Fri,  5 Apr 2024 20:19:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B7E31DB3EB;
	Fri,  5 Apr 2024 20:19:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aleks Todorov <aleks.todorov.1337@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Add Commit Summary in blame?
In-Reply-To: <CAO0eup=KqHe68OkHqYWtDgsTx0cAwg5Y5HSqK4s_BNbZhr8hVw@mail.gmail.com>
	(Aleks Todorov's message of "Sat, 6 Apr 2024 00:07:58 +0100")
References: <CAO0eup=KqHe68OkHqYWtDgsTx0cAwg5Y5HSqK4s_BNbZhr8hVw@mail.gmail.com>
Date: Fri, 05 Apr 2024 17:19:03 -0700
Message-ID: <xmqqzfu7s5qg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 47156E8C-F3AB-11EE-B122-25B3960A682E-77302942!pb-smtp2.pobox.com

Aleks Todorov <aleks.todorov.1337@gmail.com> writes:

> Would people be interested in seeing a patch that adds an option to
> see the commit message summary line in the git blame output? I imagine
> I'm not the first person to come up with this, is there a reason why
> it wasn't already implemented? The porcelain already has it, so the
> change is trivial.

I personally do not.  The blame output on the left-hand-side is
already wide enough to be even annoying.

A patch that might interest me personally would be one that takes
the --format option (copy from the log family plus add some that are
only useful in "git blame", like "line number") to allow customizing
the left-hand-side of the output, and allows us to reimplement ugly
hacks^W^W ad-hoc options (like -l, -t, --date, -f, -n, -s, -e) in
terms of that.  With such a feature, of course your "commit summary"
will come almost for free in the form of --format=%s I would think.

A change that adds even more ad-hoc options is probably not welcome,
I would have to say.


