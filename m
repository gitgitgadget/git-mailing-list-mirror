Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8ED391E74
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254878; cv=none; b=cBRj+Mdz3It3yUhLUU/VqMXqew8hiUsmT2LqNDRxv6wTVLHl/VmQx2i1cXCruccCKzlONgqQh3eWCuJVnwDT19NDPKpOzyQfQz10ZUJDkRHNUXh4tP9t0wphq5zPTpr61dHzfP0vdFswacKng3dlLPIOT72uvnfKMvjBH3PZJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254878; c=relaxed/simple;
	bh=P7P3G7ucdALA2nrqM6Jp2xGU2fOx9lGYvt7/CKuz7Ic=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LQE858u4ecgSiwPUoaqsMXNtSwPdRjJ6FecR58tf4I/L7S9GKfGaEFV3vm8baEY6PfemXIU3m8AbR9b3Zl9myX3H5U4ydlYbyuuyzY0lXnMh1//pZpl+nhKAFnVMZLVv/WPWW1XAqWuCKcjfUhEdAR5Cjs9YdCVXzhALgGOQx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RbK0uj4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW1dx8PL; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RbK0uj4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW1dx8PL"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C8C21D000AE
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:34:35 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 17 Oct 2026 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792254874;
	 x=1792341274; bh=BJhljMWvDDuzG+NNNo/FMF8UbNYKAt1DFrS33xzp3X4=; b=
	RbK0uj4DV/MxS0NEy+4DZXQjnQ+gWtFKIumNu/t8V/3pi/WhxTFYjM4i4fcLEh0W
	/Rodo7ZIsu/c6GxbMg2PEitUyhYWA7xQ526diGMI5+657AX1pbUeUbBEVioQO9o7
	iz9vPrBSeyeA5RZDls4hqTgS+J0Yk/+5Xw0y761y6nRDm0GFhuT7Sa6/EpwXBG6u
	uR1JmuFYp0u7CVf274dcW/tF+LAEJs2GBtO3Zptd3OvxAoGUI62R2tSR1o1CAPKG
	QqGy6dt2QUOwSqKZHWfOVfkLFvwAaTnvOTCp62K7/7NNlwQNyZ5nyFbQ2K45indk
	Kyb7ME0nWX4iJhKJGKAbuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792254874; x=1792341274; bh=B
	JhljMWvDDuzG+NNNo/FMF8UbNYKAt1DFrS33xzp3X4=; b=SW1dx8PLFurvoaXxV
	qaaPXsaB9HaiBhmhzhIjQgDQCq8PibSJ8f5oWH1AA6vYIwwaSoWJOv4/g4VUa0Zm
	3QVttgJPYbeG3ju3hpRyOMRnugYbXKIrAbW59OMVsKfH5ZvTIX+dnS70qHq4Z/ak
	OFYrulGYVPvPbkNuoMWVUr2jSjseSpA/0k2G3EuslJFjcwinteQApfr+vTEzOLc1
	/QiVjL3r42fabNMfBLbB5TTD51OWoyp0Extab8WBL5w8WkKcKHXCpvZoV5/G/JVJ
	iKyRHazmalq0zKSTbyYfp4H67PkHmTskpeFkI1xIfStAzhj/RbF03cfZ6S1yarlQ
	qMjWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792254874; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qVWYYVj4/4URi1Me7wqJdbENlvhK9rNz9aOrwWDnp3klwNH
	qyuin1k0HCceaB7YBx5EYVptC3PXXnQNuTVF+s4G0wzL5dlM4oo25+weEt7sCGzf
	56nwTEM2Ak6ZWGM8hYQghVPjauMwGbwwvx6s8eAQPWWfVTiLgVbOEx2M/2LxePkW
	6axGpMnpst51QZSPcJNOYFIiYXpTbyYhI1rha4Mp+8ypbQ/EAUERkNLsQRo6YvdM
	vcvqm0C1fdof2eMum0wvKzfk6M2YnwSDnK2g1bWf3Ry68hTQbnbZ8xv5mmgKVcfa
	yKikbCFGwVBFejibJ/4bBsnbHhXjhx4Dq24gdxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IYuxZJpg2Vh0YCUOT8zyzDrKeJRgIfTPwDq2W1e0+3Y=:P7P3G7ucdALA2nrqM6Jp2xGU2fOx9lGYvt7/CKuz7Ic=;
X-ME-Sender: <xms:maPTarqiRMOK54gjv1a8RcV4SG0I61frLSz_vS6rwcJdacAfRfEIdSM>
    <xme:maPTagc5c_l-_LVLuZoFz4IOL51qK8K6YnneyHpTeOIDlAHk6XOOaGcdsp4Eptyut
    SyjsC6iQvSHJw4qfp59NGKf-3Zdj1J92SWoyQ7_RlrTgwEOEhZ2vTr7>
X-ME-Proxy-Cause: dmFkZTF84FC35ZaZhEczja2/5rhxrNpjMM0XiAKlmx9i8gUd30XueqiJ2I90zf8Zc6KvcA
    496nQgMRTL+/ycqcLFmZjLUjELNixFuHg3hZAivlFh+NmR297bHsclnCMytiDRk2jPXYu1
    rPGjAJm8p6mRimjfYlDEhxJm9VW651Qnz+nvoqMn0sJbX0/cdBTpWxQZ91OuJ2hRLb4yVk
    vbL5Rlcpv/ccDWqwH4xX3BqG+Kuy9oGa2DMGd3SBOPbJWQZU6POxV25GxYuBfXDeZ9NquA
    iPIXeurQwJWr5iar0hllxLTXu96XIGSXzmF84bkFwFUpX+JSLQ6fvwkMVbw4JMZ1pLr6fc
    QtvsAPBsYmKTeRPMv5uSvM1Ic13R7Vz9DTKis0sQjvSiXYGUFwM09xlisMFJpA8HH7oviD
    O8Dv9MuELJdeU5K9xPdEhPYqynS7JMrpRe2uSGDxlIu7TZKfG7uIh7sK6w7H6YIk9ESBc1
    UidQtjlGPM7Oynkv/uugnqL9SN1pY6g+l9JRVmnNu6iAGEuOIg1K75uxUKKVsV2rY9E5d6
    JP7z06lUsCpTVQRaDx56cxzVIDRYgc+cxjaY+dq9LMTiFaKCgCW+a2oA88CWa7D0UvbXLe
    VNGArpNPATxEt60SNvGmksf3Ab4o8ucUvtk98iZLdGmv6l1X2zY1YxuJYO0A
X-ME-Proxy: <xmx:mqPTal5iZs1MmGaBObiJ9woNOQyc0COY5HAQ9yf-rfTUkRBu5l3YRg>
    <xmx:mqPTai3XFQwR6gsHeluqno3RGsXWsHQpHKjYnWdjGnra9jdru1BwOw>
    <xmx:mqPTapUBQMlhLsiu13HSavhabWCyBd5s2Yo2z86LWT1CAB_apbBzCw>
    <xmx:mqPTal53s57YtrngyBmIJ7mAAhmRIBTlW5Bk1Bqg3-EuQ8d66zb7bA>
    <xmx:mqPTagM46cRVPYw4zSEZAJC0rQc5gCXxLZa5oMZwKuy5uCo6pNk9kiw1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 803BE22C009C; Sat, 17 Oct 2026 12:34:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-pxXllTXubF
Date: Sat, 17 Oct 2026 18:34:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>
In-Reply-To: <2c1656e2-a054-43c2-94cc-31625f8c69e9@app.fastmail.com>
References: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>
 <2c1656e2-a054-43c2-94cc-31625f8c69e9@app.fastmail.com>
Subject: Re: git-diff-tree(1) can already do the important parts of git-format-rev(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026, at 20:42, Kristoffer Haugsbakk wrote:
> On Thu, Oct 15, 2026, at 12:35, Kristoffer Haugsbakk wrote:
>>[snip]
>>
>>     git rev-list HEAD |
>>     git diff-tree --stdin --format=3Dmedium --no-patch -m
>>
>> You have =E2=80=9Con-demand pretty formatting=E2=80=9D
>
> But for multiline pretties you need NUL termination. And this is what
> `-z` says:
>
>     When --raw, --numstat, --name-only or --name-status has been given,
>     do not munge pathnames and use NULs as output field terminators.
>
>     Without this option, pathnames with "unusual" characters are quoted
>     as explained for the configuration variable core.quotePath (see
>     git-config(1)).
>
> So `-z` only applies to some primitive and name-centric diff
> formats. And that=E2=80=99s why my later footnote is wrong:
>
>>[snip]
>>
>> =E2=80=A0 1: git-format-rev(1) also supports NUL-terminated input in =
order to
>>      deal with multiline revision expressions.[3] And `-Z` for
>>      git-cat-file(1) does that too (both input and output), so the pa=
ir
>>      git-cat-file(1)/git-diff-tree(1) is equally expressive.
>>
>>      =F0=9F=94=97 3: https://lore.kernel.org/git/e8bb57a2-8eff-4f72-9=
6ca-72d8880901e0@gmail.com/

But I was wrong again. git-diff-tree(1) supports NUL for pretty printing
(`-v`). I was only looking at one single output. But with =E2=80=9Csepar=
ator=E2=80=9D
delimiters (either newline or NUL) there is no delimiter for one single
record (output). That=E2=80=99s why it didn=E2=80=99t show up for me. (t=
hanks `cat -A`)

But the separator behavior is a problem. Because when consuming input
piecemeal (like reading from a shell coproc) you need a terminator. But
the `log-tree.c` functionality very diligently keeps itself to using
separators:

1. You feed one commit: you get the output with no delimiter
2. You feed another one: now there are two output records so a delimiter
   is needed. *Then* a separator is printed right before the record
3. Repeat
4. Of course the final record will not have a delimiter at the end

I experimented with forcing terminator behavior but it seems that
git-diff-tree(1) is just unwilling.

But it seems that one can just add a `--use-terminator` option
commands that use `tree-log.c` (I think by adding it to `revision.c:
handle_revision_opt`). Then I can use a git-diff-tree(1) that acts like
git-format-rev(1) with `--stdin-mode=3Drevs`... and in fact a bit better
(see previous).

All of this for pretty-printing (`-z`). For `--patch` (cf. raw diff)
there is no NUL delimiter support.

  THE CONTEXT

I am working on a shell script that needs to construct a git-log(1)/
git-format-patch(1)-like output. Each commit message describes a range
of commits. And the optional patch/diff output is the interdiff between
each range if they happen to share the same base. This is like
git-format-patch(1) with `--interdiff`. So what I need for each
record/entry in the log:

1. A commit message
2. An interdiff if wanted and if it can be produced

What I have done, respectively:

1. A coproc for `git format-rev --stdin-mode=3Drevs`
2. Individual calls to git-diff-tree(1) (not `--stdin`)

Somewhat incidental to this, I figured out that git-diff-tree(1) can
almost replace `git format-rev --stdin`.

But when I turned to git-diff-tree(1) and tried to transform (2) into a
coproc. But that seems to not be feasible, since it seems that
NUL-termination is not supported for diffs that a person would want
to look at.
