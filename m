Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818734908C3
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060564; cv=none; b=fv+GxeSm0uGy/OSHXkMskzuSCTEiE61ld+0Hq4FKKic/0DgXRQ7bi5lQnDMEmHhkCjVdKBWLI5nIY9oPUiDjvmGqlHyN2uYV4KA0zr9buDPlcmXTJxKfR3j7g09DA4cSl55vDI3GnKxDhtx3MwSID6reZgvHzR27vmSJZuMCSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060564; c=relaxed/simple;
	bh=p2elTClWqgEB+hl3T+C29v/TQF+p8ITjCzzBT2GLKUo=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=UfITVw3U+muxYsG04dKcZJyUPyqJanGcQhxMGPISvKckEyg182+Zz/CvA41jqlussSvUo60lwZu694HqHMLsaMcvfEd1WWHcUR/SXCheJFUHGwI6V8lvdxn9WZ/NjfEsPvWMuepIIjMm06Ay7tuheecZYqhKd1xWt9l4efWjGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MuloZCPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AiKQgUW+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MuloZCPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiKQgUW+"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 576FD1D000B4
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:36:01 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 15 Oct 2026 06:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1792060560; x=1792146960; bh=UEPPVQ0k3w
	Wo4AZplkTBp0LlKqOfw9WC1vR0gWgS5ww=; b=MuloZCPNuG30O3R4aGy66g5r+0
	B8VujlUXx7C13yyq2NmmZ/fxAvITWCtHE8STHpxXT4XgzI/mCFH0zY7gOG12GShc
	8vKJj8bOGqKMYYHUzzpVzVGDUxmNH25yCGIQ6YVm95ymkFhjTahI0Rc4tadCnGvT
	oIZG+GOM9A6ajwzShwYvNLx7GkgX5HB6k3T0GANdyRp4KbZXokZZHQ9ZTalaXE2S
	0e8dCDXLnEjW0f52NWqMFbbaRONF9TU5Uvsz6VlF3g0kSw7NOxrQH/kL7I3DiE/c
	ZEGuuN0wnw8kgG/zg27jC5dwIPaRVgo8v5KRIr23F/Uy6xM51GTVrT8v5UZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792060560; x=1792146960; bh=UEPPVQ0k3wWo4AZplkTBp0LlKqOfw9WC1vR
	0gWgS5ww=; b=AiKQgUW+2Rce46yKd+Z0JDt5mjbLUxOz41PwQf9dnM3xMxfMb7m
	BYMW2teRHXgT4sHlat5H10GiJJOml8+pHR6ve8o/iCWGrhF6VvcVQSwOK0GhDUKb
	HE0YpyuShIYS0LVxJtQsREi4OCsc7gsVD/zdOxfWoEFWwvu3smHY+xGlpPPOEIHg
	xyO56qh+ZjcrRM0i4SXmWMemnFPkW5ChDzWqXw06d1y+IXak+sYGovNrx92EqN+u
	LmM/2BU+Z7krnEY1BUyTdXCgwWXROZcfhJUsAFIioWcEcYUsOu3LJYLQFpRZbNBt
	sfDayKak9h8Ly48QJVzV5hL5+xnIzSsZY+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792060560; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O9Rk5OaMUdLEBD/c9z1mfxpgiXNOazkvU8eihyX3cVvtXh4
	vWXxfQgZLEzFNEnbxTTLXh8HXszhOJsHlQY/QyuBOWzhn4VCqelqonZKG0ytUFbF
	YlBObZovKOf9UXopsp1+yz5zhGdinWMBY995R4HnGmNexSGKRYMytt8Rxzl3O/lV
	P0gDf+C3iOBVxw65KWDt86HcHxTV9dup9CaNm+kbrJdD39XOnjGVup1YRMximejq
	apRPSTiBnI54Wlo0maGj8Mlw6IeSEGwK4Hi4HhWScaHR2taPXxu74fHhJ7azCSl+
	jyr40kKbzYNM0WW2XdxGEBSvAZrYJMGB2i6jKEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:ZyMEK54WLJEa9RmIeKhIgDn3LJWxIOYOsnhSYz/PHQI=:p2elTClWqgEB+hl3T+C29v/TQF+p8ITjCzzBT2GLKUo=;
X-ME-Sender: <xms:j6zQaiTxwYYBF-05tC-_GaBLx5HIFjK8Wf7qdUVcVO3dtDZ9-aVmN1I>
    <xme:j6zQainY-P_BN7HTqKqVv0xCWL_l4y_opPC1uwOHnL4Zo3h_BcblDLI5YdTuXZVqE
    hCGj0NJCH_9QjWLuQ6vXbdd8OYPGMPBCJZKg_4xqbhcYnSwP0RQmAJu>
X-ME-Proxy-Cause: dmFkZTGjxvlE8uRm3z9cCKB4jvvHujY92752beIwczaVdr8kSrpiRsjRjGYMyhgIz0tD6M
    4D23Sf0/7Ik9kk6269pTWTL4UKiuJg+Y5E5suuXSO0aGk0siNVUQEgfHFNhfM0ARtp9Ya0
    7q5O0t/uFn7Up5M3qm+uRSWAM0mRjrIJ3s2mu5Ymxg96AjVI2jUGYJI9yqOXYo0T6EHXi2
    vm7XgG8n9bl8ctiWZFC0FzWR0jX44TN/mrYUv2qWbPDp2djSzuFmeJLvo9Bh47y5x1eMeo
    YUzQGkv/yh/LCTswnXcOTCtJaOa2k1CpDm6r65r8q5A5CAzMRNG8yCFVxEvnUwZZNMAwaQ
    L3fCibjY3/t/ROl6UvuzK8zWyVQF8HTPTOYgm/011AXKikUmMVjWq1tdVMB6Qn3XdNnQsx
    SDMgn6j+Eri1v9ZvwjB5XlEZEXn9lpwCSXt5wFOb4eT4j/ak6uGOF8CigVl0293+rV8O9L
    RL8KWzz7+oTZJP7C38NRAw1I8+qz4IC3HxMwWE0/kRXs4xh6wdFpCbKxp1Bzszo2isbGSd
    52DN2R/uWb+LhO/XDZn1RB2nRgV+XGiNxRD9omhk/8FTVxkwVB4xET6+zF+7boBioESDvZ
    sPmaoWVVu1kwzdYvVPsoMNxbHWO+ILi9fJ33v3cp+cQh8maqsrQFbXQT/YBw
X-ME-Proxy: <xmx:j6zQal_chuE9GTRR5yPHXqiSBKW2BfPdXylB0OE2GQ4djNOCiTuRBg>
    <xmx:j6zQat8jIlvmCIZvlMlIHTdo3Ey0ymWUsjiQ3xrLAVx5ltn-EDYWkw>
    <xmx:j6zQauCMAq8AjpEiNQvatcF31oPCQ4H5xhCGAyjZtJsdO44DHuQIzA>
    <xmx:j6zQatxEJvyiyehLdHTL4MfYFeI79hmGrP7U8tbrQG09Ge8YicjWLw>
    <xmx:kKzQapEB9y1I01NM_CNJ9l1R6LDABjG9B3RwLlyADMPjbL_g9KD9xb5z>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1A52F22C009D; Thu, 15 Oct 2026 06:35:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Oct 2026 12:35:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>
Subject: git-diff-tree(1) can already do the important parts of git-format-rev(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

git-format-rev(1) is an experimental command from Git 2.55.0. It was
introduced because no command was found for the use case of pretty
formatting one revision at a time from standard in (stdin). See
[Discussion] on the doc.

=F0=9F=94=97 Discussion: https://git-scm.com/docs/git-format-rev#_discus=
sion

But yesterday someone was reading through all of git-rev-list(1). And
this is one of the examples:

    git rev-list HEAD |
    git diff-tree --stdin --format=3Dmedium -p

And if one turns on merge display and off patch display.

    git rev-list HEAD |
    git diff-tree --stdin --format=3Dmedium --no-patch -m

You have =E2=80=9Con-demand pretty formatting=E2=80=9D

And it=E2=80=99s even *better*. Because it supports `--notes` like git-l=
og(1)
does. And probably everything else that the rev-list machinery
supports. git-format-rev(1) does not. The `--notes` display is not part
of pretty formatting itself.

(There are also some minor extra things you get from the pretty formats
(the built-in ones) used with git-log(1) and co. that you don=E2=80=99t =
get with
git-format-rev(1). Because git-format-rev(1) just uses `pretty.h` while
I think git-log(1) and co. use `log-tree.h`.)

But you do have the issue that you have to pass object names. With
git-format-rev(1) you can pass revision expressions. But you can just
stick a revs-to-OID pipe in front of it:

    ... | git cat-file --batch-command=3D'%(objectname)' | ...

And then that=E2=80=99s taken care of.[2]

That=E2=80=99s for `git format-rev --stdin-mode=3Drevs`. But there is a
concillation price in that `git format-rev --stdin-mode=3Dtext` can form=
at
object names (full hex) in running text (by just tweaking the function
that `git name-rev --annotate-stdin` calls). But that was a nice bonus
and not why the command was made.

=E2=80=A0 1: git-format-rev(1) also supports NUL-terminated input in ord=
er to
     deal with multiline revision expressions.[3] And `-Z` for
     git-cat-file(1) does that too (both input and output), so the pair
     git-cat-file(1)/git-diff-tree(1) is equally expressive.

     =F0=9F=94=97 3: https://lore.kernel.org/git/e8bb57a2-8eff-4f72-96ca=
-72d8880901e0@gmail.com/
