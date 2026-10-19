Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978506441C3
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418783; cv=none; b=Em+izNcU+xEktbutZpihZLZ5hggOx6zeMcDKirVmDuGtqC0dfKcUXLoXBKApK4z3ggN9V2QjgNwADN8ALAv9bfy9Mj1eUgeagpLb3iGSKbRuMIKxYL4YXcX/xkW2HNy8pxvJTZqbEXS18J/6sCVjUHb1nAxZX+5fIDey39ML+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418783; c=relaxed/simple;
	bh=AsxJqUIw5o7WWRh59zcMcnfjOhB9P8601AJmS9Pls3s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qdZ9QFDS/7KqbexZxNg/m4YX6UVjC7pNXKORx6+t+DuscdQQeUZZTM0TAWiyqJt/xgANtQcZ5bxVmWkdYua8JIBAQT7eTcvuby0eT9vpFy/K/jX6kGz1PcyTT+ZZvI0kSSc4x0YduXNbyXmFQMEbQniAhoUHMsh/ejdwu2Yp1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=VHFAgf5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhBj6pb9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="VHFAgf5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhBj6pb9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA5247A0096
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 10:06:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792418779;
	 x=1792505179; bh=x3hgYlcaBSdraGQye6+Hhh/brh1jf+TsRtf2ZOklCgc=; b=
	VHFAgf5yt3dVBFesUtpLR5h1SqW9OMRI/+wK9U4+gAvq+cg/x1a8+hsSMAAT+gX/
	6kP4QSVWCTGe/T4haJ/kl3i7leOqwSY2eLoTQSaMGjOFAU9+uvlK4GBqyWWbc/jx
	O4ZM16EW2Ln1v0RMFlPyBWdxXXZ+3CXjEwqZqPiG1AFfF1a3MLgmAAhqr7KUZiU5
	GJV0wzjhmCfK1Smm6ZCisE9nhTQLrovMDDVLp+d2gKqBsLhOzndMzksit8OJ2eSe
	3n1F5fsKDGVCdt9hlf01bJGrqQnqfgpufa1m/Aih5ckiKepIF/7rfZHiqlqq+iJC
	Vo6lpZbg9UWq6mdRdOaa6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792418779; x=
	1792505179; bh=x3hgYlcaBSdraGQye6+Hhh/brh1jf+TsRtf2ZOklCgc=; b=W
	hBj6pb9bkYsGsx+836tIgfk6v4DSkmKibtQTfK0smSwSv3DAFNZ/2XQnX2ioPke6
	0yuf5ohw9AvQ/ERAJpKpeNDOjsGQb3+GJI3e3u2GA7MWEqkJM4Nse3deOJAJ7Hah
	Knz/VX8uYX0tD3F5qbez91N259w2VO4rvjKOBmKvJrmTot0Wx8t3hDjSb5zQ5PFK
	D+XnENvmHfhCeg6Uf+YmlWIDe2tnDI15f0wNrw5pwimiOPtmb6E92y5tyOa8l6Em
	HoV07vKoQep2QQeMK+t74IGv8/mdT6tWpr6Lrk0QzAD+I+gsOdb/ZbBUdb8wiFUh
	LielFbya/hqNsL8cjktMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792418779; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rKoAeMiJWq2DCGEvPwwJmsgZAPIdcIWi5bv6wKPkD7DmYg6
	VF7qNUR924xR3MyZl840hth9QKiaWb5vD7cHbLRmX4IO9n5W7Cj6vHlL9RDX4+Fy
	l7oEGWOv8g27lTthGcu3maeUbi/v5rNNgsySBo7Ep5si7aB5qez6kOyJJptKRytl
	Kd9GeikJZcOD/VWjZYYoOvnS1HK15D1RQLyG26GHIyQPx48cORe+eck9URrWsMzX
	RfnoJlKxugT9eLmYtliBfftahBLSZ3BRiuFf0TDUlkIuzD7Nyvrm/JMRlu5mSxNL
	+wiDNj+fqvb5nXZ0b1kgT8GPQ+vtMf4UcXSFtoQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VyUydHPUOim61xTmYRcumV5ga5JBeJdsFF1AdXLt3xo=:AsxJqUIw5o7WWRh59zcMcnfjOhB9P8601AJmS9Pls3s=;
X-ME-Sender: <xms:2yPWaunhkfbbd3oGVYUL1LWrSdgRoZIy-moWs5ELsbpbLXzf-260ug>
    <xme:2yPWagpabzm3A4sqXK8feXK799GFO3Xv9BzDcsRIAAWsMu98K4XjaP-Qj0oT2HpAP
    oJq4pzZ837QjUFXM7nw3yf6OJCEIUs7RurVVU1etuMZamqnOSfHNk7e>
X-ME-Proxy-Cause: dmFkZTGJIFY/RFihO8r5viIiM4PfIohpjF3qU1rG//gE7AFSYRqICq3PwoF+N+gyLUcV0H
    nokT8jG2kNqc8gO7Evxwas4vAlLVboFmsKgJ2qlo2rJS6xrwxBqOak1bs7WY4nutw7fHHu
    L15pw19mZwB/0IuM96V+UZdpH50d9NSrGKwzzk5y/pWlki3XVdmdA66DoW3ovxoZeCAzh0
    KqKCbWDmSyplg0byRGy8V4RXfb46Eu0JLvO/j+j4cvnYjih8+nYntzHCmLOfeIVFo8wIe9
    rZxW9bezNmhDw0sddl3HYNw5yw6ELIBnELCL9n/RuB99sD+gFofwgU05oH00ETl4mQkOdm
    y0kogFPIhASwrFoTCg6jcunYpOQiNuxqnRPszVHJ3rlz/JIo5W8y7Eg45PGNTHx+a2BOEM
    3IaGYlUVIF5Ct29zpJSTC0vAA8hinZU1C74b3Js1x5gzgWniiCN1iU+kDnTEN3SEBlfD81
    Eg4lSkpu0l6SR06qA7Lb55ZXQAaYy3zmVustPHPGH7Ij+hMMRQkTxA6cLMpGnFNmOUU9IX
    ppsfhLtK0Qv/sEz+TfNSvB9yDJZlVECEJH6Bobkp7amExsXi5kfzk4RFjiAYju4y6fL3if
    kIuyqAqIGc4repizyEGQHq70FmvN1cP95InmTEcxMdJes4LFTC8XUUcQGh1Q
X-ME-Proxy: <xmx:2yPWajgSsQnTaGV1h6Hq0a8plWj758xF3Dd8QgqM-2koOMUu0XKKmQ>
    <xmx:2yPWanyVLXt0OOHscMHYKNy_rbvonIh7fEzcKCaGdB24FJDb6wofYA>
    <xmx:2yPWamKJZyfycuGP15TSlXh5djxLbuIFlILWRGukslC3qRstRtdrOg>
    <xmx:2yPWauQLbXnBlv-2Wv_2uSRDyv3qP3fCjZf5YKpDxP4zeBhzSAHvhw>
    <xmx:2yPWajfoFRQoDAlGUZU_LLXt3rjELQknNw0CWTYOlXvM1nH_UXJbPGMJ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0FF02782738; Mon, 19 Oct 2026 10:06:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Mon, 19 Oct 2026 10:05:58 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <9c15d34e-406d-4702-b606-da102a340e71@app.fastmail.com>
In-Reply-To: <xmqqik3da2bs.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <xmqqik3da2bs.fsf@gitster.g>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026, at 12:43 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/detached-head.adoc b/Documentation/detache=
d-head.adoc
>> new file mode 100644
>> index 0000000000..1e00712124
>> --- /dev/null
>> +++ b/Documentation/detached-head.adoc
>> @@ -0,0 +1,43 @@
>> +`HEAD` is where Git stores your current branch. `HEAD` can either be:
>> +
>> +1. A branch, which is your current branch.
>> +2. A commit ID, when you don't have a current branch.
>> +   This is called "detached HEAD state".
>
> HEAD is branch which can either be a branch or something else?
>
>     HEAD records the state from which your current changes started.
>     This can be a branch (the "current branch"), or it may not be
>     associated with any concrete branch (in which case HEAD is
>     "detached").

You asked for a more detailed explanation for why I don't think
this is clearer, so here's my best attempt.=20

It's important to use the same words that users might themselves use
to describe a concept, for example, "means", "is", "points at", "is a re=
ference
to", etc.

In March 2024 I asked experienced Git users to explain their impressions=
 of what
HEAD means, and I got a lot of really great replies. I've included a bun=
ch of
them at the end of this email. I think it's a really great example of ho=
w there
are a lot of "technically wrong but useful" ideas about how things in Gi=
t work.
When I think about how to explain HEAD, it's in the context of that rese=
arch
I did around March 2024.

Your suggestion ("HEAD records the state from which your current
changes started." uses pretty different language ("records") from
the language users are using in the quotes below. I think it would be gr=
eat if
we could make a correct statement that builds on the ideas that users al=
ready
have about HEAD, using the kind of language that they themselves would u=
se to
describe the ideas.

Let me know if this is a helpful way for you to bring some user perspect=
ives
into the conversation. Like I said earlier I don't really think it's pos=
sible to
discuss how to explain HEAD in a vacuum so maybe these quotes will help!

Also if you could give me any ideas for how to reply in a "shorter" way =
than
"I don't think this is clearer" let me know, I can't bring you quotes fr=
om user
research to justify every single wording choice :)

-  "HEAD is a mysterious thing I never need to know about unless somethi=
ng has
g-one wrong, eg. merge conflicts."

-"the HEAD Commit in my Clone of our Repo is the Commit at the top of: g=
it log"

- "Other than seeing "detached head" sometimes and panicking, I don't re=
ally know
what Head is. And I used git quite a bit over the years =F0=9F=98=85"

- "HEAD points at the latest commit of the branch you're viewing. Except=
 when it
doesn=E2=80=99t. There's attached and detached head situations and that'=
s where it gets
somewhat confusing."

- "It is a=E2=80=A6 thing=E2=80=A6 which =E2=80=9Cpoints at=E2=80=9D=E2=80=
=A6 the newest (?) commit that =E2=80=9C=E2=80=9DI=E2=80=9D=E2=80=9D am =
=C2=BFon?"

- "it's a pointer to the latest commit on the currently checked out bran=
ch"

- "HEAD means (a pointer to) the (commit hash of the) checked-out branch"

- "HEAD is the reference to the current commit that's checked out."

- "The commit which will be the parent of the next commit you create, at=
 least
using "git commit" command."

- "unless I am taking special pains to deliberately edit history, HEAD w=
ill
(1) become the first parent of whichever commit I write next AND (2) nam=
es the
branch where that commit will be appended".

- "it's where you "currently are" on a branch (or maybe in the whole rep=
o? not
sure on head vs HEAD)"

- "the most recent commit on the branch you're working on"

- "Insertion point for new commits."

- "HEAD is a "commit-like"? that refers to the commit? that was used? to=
 populate
the working directory?"

- "a file in .git that points to either a commit or a ref; git uses this=
 as the
"current" commit for things like git status"

- "HEAD is a symbolic reference to another reference ... I don't have a =
mental
model for what happens if HEAD points at a tag ref"

- "my impression is that it's the commit I'm currently looking at. It's =
attached
if that commit is the tip of a branch (means I can make new commits), an=
d it's
detached when that is not the case."

- "it's a file that contains the currently checked-out commit id or bran=
ch name?"

- "Sometimes I think I kinda understand. Then I remember the existence o=
f the
phrase =E2=80=9Cdetached HEAD=E2=80=9D."

- "HEAD is what is going to be the parent of your next commit"

- "HEAD points at the latest commit in the branch you're currently in. S=
o if
you're in main, it's the latest commit there. If you're in dev, it's the=
 latest
commit in that branch.  ... But if you're in a branch and not on the lat=
est
commit, HEAD still points at the latest commit."

- "HEAD is shorthand for "most recent commit on current branch"."

- "it means "the commit I have checked out at this very moment"."

- "I am quite unconfident as I only ever see it mentioned when running '=
git
reset'. From that context, something like "the most recent 'saved' state=
 of the
repo before you made any 'unsaved' modifications""

- "A pointer to the *latest* commit (not necessarily "current" commit) in
whatever I'm working on. ... the latest commit" is whatever is conceptua=
lly "at
the end" of the branch's timeline."

- "HEAD is used as a pointer to the current commit, while it is (usually=
) pointer
to the current branch, which head (lowercase) points to the current comm=
it - one
layer of indirection."

- "I think of it as pointing to the next place where a commit would appe=
ar if I
made one"

- "HEAD is a reference to a commit, either directly or indirectly. A dir=
ect
commit is just in detached state, where HEAD is looking at the commit it=
self.
An indirect reference would be the case you=E2=80=99ve shown above, wher=
e HEAD is a
reference to a reference."

- "Its like... the thing at the end of the branch, right? Like... the cu=
rrent
commit."

- "I think in practice it is the last ref checked out. Sometimes it is t=
he SHA of
the revision (detached head), sometimes it is a ref (branch or tag)."

- "HEAD means the head of a specific branch, which seems to be the defau=
lt branch
in github?"

- "the git command that involves HEAD which I use most often is `git pus=
h origin
HEAD` ... I'd definitely struggle to articulate why this works the way t=
hat
it does"
