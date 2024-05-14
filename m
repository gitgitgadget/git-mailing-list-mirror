Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B217EBA5
	for <git@vger.kernel.org>; Tue, 14 May 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701558; cv=none; b=BjZk+ZN1Fg+vHD4XlaK5U8xnODrbfCwSJj0pyltbzb5lzwq/WZrHCg8mSDjvUCLBswbYdKuHURNx85Ws0O8+QCEww31fDT0oiPM+dzKL00b3n4jE98CMFCoYHKkWW9kZKjqCdoJuW1+5F3HwyvlaGjJfVSMHayFMUbf7N3XixF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701558; c=relaxed/simple;
	bh=NcM/jRX635BD7Ll6k51KuW3YuDcFZYXAdiDisd6XtvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSjwTpQaC/kWIdQMJPL0CB/37WZ5RTmCwVd5U9TGDEeL7uFu7Uk5KT/ZSfwkEuTRi82DkqmkA5F/u1VSN5NFRATZOM0sM3Kc7KweJOXwSgZf1jjy4f4rh5YslbcmkpwyiJZrgtxRj2d8rcsRGWyoZA1kObyiYpDvqOb+opCTn3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dUa7P/vV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dUa7P/vV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 178043D558;
	Tue, 14 May 2024 11:45:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NcM/jRX635BD7Ll6k51KuW3YuDcFZYXAdiDisd
	6XtvY=; b=dUa7P/vVbvSl+tCGSlpM02XEPmjTsN5LOHFO7HzQ9QuENgfLxWdBjt
	PE8kBfRu6EFxC3+NTGuaoWklVnkLoRjREEO5ShzjyenDGdloQvS1TCJowqE91fY2
	fls2PDHeDFvravDze/myo5JreM/EfUY0hJ77GMPfqKpTUZnjgH/wI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F2413D557;
	Tue, 14 May 2024 11:45:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 937093D554;
	Tue, 14 May 2024 11:45:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [RFC PATCH v2] docs: document upcoming breaking changes
In-Reply-To: <ZkNJaaKTTKbns8wo@tanuki> (Patrick Steinhardt's message of "Tue,
	14 May 2024 13:22:17 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<2ef53ff98b12fe9373a15ec3a795235f040d9049.1715667067.git.ps@pks.im>
	<CAOLa=ZRkLpi-DSNsTgVf5OCk6gEP7VTx2SeJRKT_Lv+pVu1Nyw@mail.gmail.com>
	<ZkNJaaKTTKbns8wo@tanuki>
Date: Tue, 14 May 2024 08:45:50 -0700
Message-ID: <xmqqh6f05rdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0AC12BAC-1209-11EF-9010-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> * annotate, blame, pickaxe
>> You've mentioned `annotate` below, but we could also remove `pickaxe`.
>
> I think most oldtimers use git-blame(1), whereas git-annotate(1) has
> been introduced to make the command less judgemental. I'd thus say that
> this falls into the category of commands that we wouldn't want to
> deprecate because they are both used.

Personally I do not think blame is "judgemental" in the first place,
and I do not think being "judgemental" is bad to begin with.

"git annotate" was there first as a Perl script, added by c65e8987
(Add git-annotate, a tool for assigning blame., 2006-02-20).  It is
intersting to note that "annotate" was advertised as a tool for
assigning blame.

"git blame" was written almost around the same time but with "-c"
compatiblity mode to mimick "git annotate", added by cbfb73d7 (Add
git-blame, a tool for assigning blame., 2006-02-21).

A healthy competition between "annotate" and "blame" continued until
f789e347 (Remove git-annotate.perl and create a builtin-alias for
git-blame, 2006-10-09) retired the "git annotate" Perl script, and
replaced it with an invocation of "git blame -c".

"git blame" was rewritten under the codename "git pickaxe" (cf.
https://lore.kernel.org/git/7vr6xddm7h.fsf@assigned-by-dhcp.cox.net/),
and was released at cee7f245 (git-pickaxe: blame rewritten.,
2006-10-19).  acca687f (git-pickaxe: retire pickaxe, 2006-11-08)
made it take over the old implementation of "git blame".

The name "pickaxe" can be easily removed, as the log message of
acca687f already said back then.  As everybody noticed, it is not
even documented.

>> * log, whatchanged, shortlog
>> Here `log` already handles what the other two commands do.
>
> Does git-log(1) really support everything that git-shortlog(1) does?

Of course not.  The filtering behaviour of shortlog is unique to the
command.

> This is of course a much larger topic and something that is very much up
> for discussion. But in any case, it indicates that a deprecation would
> be premature at this point in time.

Yes, please exclude anything that needs new development while
discussing this topic.  Anybody jumping into this discussion should
take the word "upcoming" in the title more seriously.

So I won't talk about unifying "describe" and "name-rev" somehow ;-)

>> * verify-commit, verify-pack, verify-tag
>> These could probably be subcommands under the verify command.
>
> Same here -- as we don't have the command yet, I think it's premature
> the old commands to a list of deprecations.
>
>> * diff, diff-files, diff-index, diff-tree
>> Here, `diff` seems to handle everything that the others do.

No, diff-files, diff-index and diff-tree can do their thing
without getting broken by end-user configuration.  Writing your
script with "git diff" and you can keep both halves.
