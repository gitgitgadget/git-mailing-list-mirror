Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25213184E
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517578; cv=none; b=sLnOTr5BQqDUCm7lZ2EbVE1uIGHtIyhlEQzEmMGTtSvcqSoL8coLzSYjv6pwJ0EMs0AdVfH83Z2gbcDEz1dJJTxvHHm/r3LsSfruhNKinQ+7Dr+VFybj06XixWZu2ghb9iNjFE6bvsRahs7Fpu6s4lclBw9Syal49uslX5JcBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517578; c=relaxed/simple;
	bh=o10TJE7mTZUjFez1Sl7h3MQkHbivPypUh7IePaCmwHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfYA9UEjayfAeYQd++pfc5kzRBXHKTQLLuFPv5CAF5JorMNwpGTk2YRENcisu5F+R7a9YMIUJlM4PDETmYysdNF4e6Js+emogwhaB9HtOSGvR5GRXfS6MSRNqc4C8xLMQu6AJtrgzQld8t2w/uxemmCxSHkVw+UjVWSKMRc7qWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a+2vgb8k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a+2vgb8k"
Received: (qmail 2500 invoked by uid 109); 26 Jul 2025 08:12:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=o10TJE7mTZUjFez1Sl7h3MQkHbivPypUh7IePaCmwHU=; b=a+2vgb8kea+4AEvcXJGHVr+7asJcLFGwiWxh+tQ4CFMafi1r4ZFOUzMyjj9/1Mg68MGdifR6ggpYd005l+S7K/4FEUD30b95bLQ6nCJbWU6blq2S8eBYTj0iU0gpTKwM4/y3dWqDdMlNvMzO1KSmbAX7L9BbMEQJLmkzC5irgqQGs/BFODYBK9YUAUU3j7pkrcUJgkwjiPUHCNv++KD1hNLo6bKhztLW1//Gbw8QuFKPLwgNmpYCzZrzERwFnmM1WA1+MtuS7X1tN49npQCxi1+G3sPh5kd9PGOB/AKyVBjYZulTef5AQ/vyCPG32+fO/VsXu+gyR/kWO1GA1DFR6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 26 Jul 2025 08:12:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7178 invoked by uid 111); 26 Jul 2025 08:12:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 26 Jul 2025 04:12:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 26 Jul 2025 04:12:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, git@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH] git: show alias info only with lone -h
Message-ID: <20250726081254.GA3042329@coredump.intra.peff.net>
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
 <a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
 <xmqqqzy33k1j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqqzy33k1j.fsf@gitster.g>

On Fri, Jul 25, 2025 at 04:52:40PM -0700, Junio C Hamano wrote:

> When it redirects to our commands, it is less risky as we aim to
> make all our commands honor a single "-h" via t0450.
> 
>    $ git -c alias.c=checkout c -h
>    'c' is aliased to 'checkout'
>    usage: git checkout [<options>] <branch>
>       or: git checkout [<options>] [<branch>] -- <file>...
> 
>        -b <branch>           create and checkout a new branch
>        -B <branch>           create/reset and checkout a branch
>    ...
>        --pathspec-from-file <file>
>                              read pathspec from file
>        --pathspec-file-nul   with --pathspec-from-file, pathspec elements are separated with NUL character
> 
> But then, it may not be such a good idea to pay attention to "do we
> have extra '-h'?" when alias expands to our commands, e.g.

Another interesting case: even for our own commands, the alias itself
may add extra arguments, which confuses things further. So:

  $ git -c alias.gi='grep --cached' gi -h
  'gi' is aliased to 'grep --cached'
  fatal: no pattern given

runs git-grep, but even though the user said only "-h" the alias added
another option which prevents the help-mode from activating.

In this case it is not too harmful, but you can come up with
pathological cases where it actually runs a real command:

  git -c alias.grep-for-foo='grep -e foo' grep-for-foo -h

which runs a real grep.

I guess one way to deal with it would be if the user runs "foo -h", and
alias.foo is "bar --other arguments", then we run just "bar -h",
dropping the extra arguments provided by the alias.

(Another fun corner case: not all git-foo are our commands. But maybe it
is enough to say "if you make a third-party git-foo it should probably
respect bare -h as an option").

>    $ git -c alias.c=checkout c -h main
>    usage: git checkout [<options>] <branch>
>       or: git checkout [<options>] [<branch>] -- <file>...
> 
>        -b <branch>           create and checkout a new branch
>        -B <branch>           create/reset and checkout a branch
>    ...
>        --pathspec-from-file <file>
>                              read pathspec from file
>        --pathspec-file-nul   with --pathspec-from-file, pathspec elements are separated with NUL character
> 
> We get the same short-help, without what alias expansion caused this
> mess, and without any indication that we lost 'main' on the command
> line.

Yeah, that is the flip side of René's patch. Right now we overly guess
that "-h" means help. And after the patch, we'd sometimes under-guess
that it meant help, even for commands which treat it as such. I think
that may be the lesser of two evils, though; if you are asking for help
then "git c -h" is the most-strict way to do it.

So IMHO the patch under discussion is a strict improvement, even though
it leaves many other questionable cases unsolved. I'd also be happy if
on top we did:

  1. When alias.foo="bar --options", turn "git foo -h" into "git bar
     -h", dropping "--options".

  2. When alias.foo="!bar", report only the alias and do not run "bar"
     at all. The collateral damage here would be:

        !git bar $(some_shell_magic_we_need)

     but IMHO that is not all that bad. If we report the alias content,
     the user can probably figure out which "git help" to run next.

-Peff
