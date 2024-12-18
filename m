Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38355FEE6
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536106; cv=none; b=GDpN1DLj6RGwWJ4o5t8EWyP+D2uRZOWq3kof0qXPYQ7qKBt58pTGpGDOa6vexysoU6LIlAOVIdVK8UD6oHT32N1JOVTUYXPDUlsx6nqm4xInavyoz3ZsmV9yY6jrFCH+TQ20xJIfAF2W3Q8nidvwrpdM0qKM44Fqg+Ruha9GhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536106; c=relaxed/simple;
	bh=hbkTjMpaJqnyl7Iz8SPh4BwMa9DYheQ2HTwrjmH7AfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICQbJ5GKhxm0SwwLAInqadFXzefViziV7jtRfegYbtxi8gUdRL/S9sFIsbeH9EeVet4MAYWZH7GqPgSymqxjsQABQcV64+KIEJ5ks9cWSVpJiMPrEgcNgKaNQw5tEqwmskfRh+FHHMlzSITEIZdrXWxWs2lp0JJRti1lhZtTRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jBoVmsFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ow4fxC4f; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jBoVmsFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ow4fxC4f"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA6A925401EB;
	Wed, 18 Dec 2024 10:35:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 18 Dec 2024 10:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734536103;
	 x=1734622503; bh=oeyqb69Vwo3Az+UuD26X60OMkhyXb0H6qobkgGbSz1w=; b=
	jBoVmsFVfRvYV7oEjWP7sRnTb2+l3cLP7JSey+nFpZ0x6BK6Ax6DyS5sjWVdVauO
	cCczkcCopkQPY+ju3gotWZL1vIGo9iK9HA60YLSYyMP2NfUOGoUnKVhE3oDqi0vt
	ijxkAneKD4kFXxoj6jC8CjP2laddVUDAPA0xusrmeaO7FurDYmHsaIAYSjQZht3d
	MwIMNB7yX3YajsYJW9cE6/BJyNJN875mtgIkfbweoVKTNrZziRnNrBfz4tt0UYgL
	G/4RwPYxKhYgZHYsoHnS7K/+N/+3p1Mn/JCXRalw04QOL58ncgtk2KXJ+Drpdkwb
	86rfX0A3z8eLmaRjmkYHTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734536103; x=
	1734622503; bh=oeyqb69Vwo3Az+UuD26X60OMkhyXb0H6qobkgGbSz1w=; b=O
	w4fxC4fstcxn7v5KUzhqccdLollboYEOvEOISbrFKFYv0pYGBG/3Y36dobCBmQpx
	sfsJDpEeSrr4WG/j1ZaGt21D93CrY0wzHy7e2VpAUzLRJsG0zI/eiof5v4thlstc
	WomGQQa1VDnLDG6MjxjhuuCTz3ywjiGxga2a7PTfLYi5VsifhMVwlcSQh5NcPT0V
	N4uDnA4PuCLw0iIYKs7/u7nCgKCnl4lETYLxicwsnVfCqCOt5QbuErleP2rkbD+2
	Z6VKrgHWwTfzTwyhT+WaSZxEQkNI2ttgPKo30SaMJJUgQ41tMmKoZ3YFDcBnHbpx
	ltvtmq5IC5CLM82LB5l+Q==
X-ME-Sender: <xms:p-tiZ7DmkWnCtMtzllGXZwzD-nap48KgWEYk8UxUCeYH17hBU2VdPQ>
    <xme:p-tiZxh1l5pVla3zjksEdlZP3fiBYIutTU3EBgd99LY_MINaIipKg20rn55CUn1uV
    58JCtfQwoiRb_te-A>
X-ME-Received: <xmr:p-tiZ2nDMJ9jfy2SOXOuyQ80H3-a8CuHB45nxjoqooIxX7lyhI75AI3BlhQLcHuaDjsMHvSGLDmlc_eiZofVUtxK2zr0JSjeMzvpOOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgshhgrmhdrkh
    grnhhoughirgdutdesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:p-tiZ9z1Ag865fByE2wHfkk33DprceE1DyPnpRuyft5RGlll1IivKQ>
    <xmx:p-tiZwQbOriiK2sHL2JRBzkjwNZ9_2C6u51Mh7AJX0znyi-oYzKGbA>
    <xmx:p-tiZwa1mYV5KBdVm9Bha8GeFVZ72qEZMZEssTjuj8Vv-ry-nA135Q>
    <xmx:p-tiZxQJO4MYtwQqEiWeD_RJ5N6io8Ti7GMma6STkbe98cJYPOtiQw>
    <xmx:p-tiZ1JACykFdXibdLaAPuQveY5y-d-GX5uoiNELWUjNZ0BIdDj6GvAw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 10:35:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
In-Reply-To: <CAG=Um+0qGEf+pX0cjCA2Qti4NYwFeCb29zgS7k2Lu_0yfuEz-w@mail.gmail.com>
	(Shubham Kanodia's message of "Wed, 18 Dec 2024 14:00:03 +0530")
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
	<Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g>
	<CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
	<CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
	<xmqq7c7y13tc.fsf@gitster.g>
	<CAG=Um+0qGEf+pX0cjCA2Qti4NYwFeCb29zgS7k2Lu_0yfuEz-w@mail.gmail.com>
Date: Wed, 18 Dec 2024 07:35:01 -0800
Message-ID: <xmqq34iluhqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

>> ...
>> Thanks.

[administrivia: respond inline, trim out parts that do not have to
be read by bystanders to understand your response].

>> In any case, stepping back a bit, for the population of user who
>> benefit from enabing the prune-remote-refs task, wouldn't it be an
>> even better solution for them to set fetch.prune?  You can tell them
>> to run "git remote prune" just once, set that configuration
>> variable, and then the remote-tracking branches will stay clean from
>> then on.  Any future interactions with the remote make sure stale
>> remote-tracking branches will be removed automatically.  Wouldn't
>> that be a much better option?  I am sure I must be missing a use
>> case where fetch.prune (or remote.<name>.prune) is not a good idea
>> but background prune-remote-refs task works better.
>
> Let me expand on the context for suggesting this change:
>
> I work with a large repository that has over 50k refs, with about 4k
> new ones added weekly.
> We have maintenance scripts on our git server that clean up stale refs
> (unused older than N months).

> Using `fetch.prune` with a normal git fetch isn't ideal because it
> would cause git fetch to unnecessarily download many new refs that
> users don't need. So we actively discourage that.

This is what I did not quite understand.  What do your users
normally do to update their repository from the remote to become in
sync, if they are not running "git fetch"?

	Side note: it is very likely that your users are not
	directly be running "git fetch", but using various
	front-ends like "git pull", "git pull --rebase", or even
	"repo", but they all at some point call "git fetch" to get
	the new objects and update refs.

Ah, are they using "git fetch origin +foo:refs/remotes/origin/foo",
i.e., only selectively fetch the thing that they use and nothing
else (again, their wrappers may supply the refspec to do the
limiting)?  Now it slowly starts to make sense to me (sorry, I am
slow, especially without caffeine in the morning).

Am I following / guessing your set-up more or less correctly so far?

In any case, if your users are doing selective fetching, 50k refs or
4k ref turnover per week on the other side does not really matter.
Your users' desktop repositories won't see remote-tracking refs that
they didn't use and ask for.

But you are right that these selectively fetched refs will
accumulate unless pruned, and fetch.prune would not prune anything
when

	git fetch origin +foo:refs/remotes/origin/foo

because it will not prune what is outside the hierarchy the refspec
covers and this is a deliberate design decision.

For "git fetch origin '+refs/heads/*:refs/remotes/origin/*'", which
is pretty much how "git clone" sets up the remotes, anything we have
in refs/remotes/origin/ hierarchy that do not appear in the current
refs/heads/ hiearchy they have are pruned with fetch.prune=true.
But if you fetch selectively, either 'foo' exists (in which case it
won't be pruned), or 'foo' went away (in which case the fetch itself
fails before even pruning what is on our end), so fetch.prune may
not help.

And at least for a shorter term, periodically running "remote prune"
would be an acceptable workaround for such a workflow.

In the longer term, I suspect that we may want a new option that
lets you more aggressively prune your remote-tracking refs, telling
the tool something like

  git fetch --prune-aggressive origin +refs/heads/foo:refs/remotes/origin/foo

to mean "I only am interested in getting the object to complete
their current 'foo' branch, and get my remote-tracking ref for that
branch updated, BUT if you notice some ref in my refs/remotes/origin/*
that they do not have in their refs/heads/*, please prune it, even when
they are not 'foo' (which means normal --prune would not prune them)",
would not be a terrible idea.

It would be more involved than running "remote prune" periodically,
of course.

> In theory, users could just run `git remote prune` once and carefully
> avoid full fetches to keep their local ref count low.
> However, in practice, we've found that full fetches happen through
> various indirect means:
>
> - Shell plugins like zsh/pure
> - Git GUIs like Sourcetree
> - Code editors like VSCode
>
> among others.

And do any of these bypass underlying "git fetch"?  If not, then one
easier solution is to accept that somebody will do the regular

	refs/heads/*:refs/remotes/origin/*

full-fetch *anyway*.  Once we accept that to happen, we can tell
"git fetch" to always prune.  Then when these "various indirect
means" attempt their full fetch, "git fetch" invoked by them would
still honor fetch.prune, so even though they would try to maintain
these 50k refs in-sync with the remote, which means you may see 4k
new refs per week, but plausibly the refs that got retired are seen
as stale and get removed on the users' repositories.

> - If full `git fetch` is completely avoided, this will gradually
> reduce the local ref count from tens of thousands to just a few
> hundred active refs (even if the remote has 50k+ active refs) as old
> branches on the remote expire with time.

Yes.  You'd somehow need to arrange these third-party tools not to
fetch too much unneeded cruft.

> - Even if not —say, if an errant tool or the developer executes `git
> fetch` mistakenly, then the maintenance job ensures this doesn't
> become their permanent state until the next manual remote prune.

For the latter case, fetch.prune=true would be the ideal solution, I
would imagine.  The "errant tool"'s 'git fetch' would prune the
stale ones.

Now, the documentation should explain when this "periodically running
remote prune" is an acceptable workaround and/or a useful solution,
relative to setting fetch.prune, as most parts of the existing
documentation do assume that the users, intended audience of the
document, are using the bog-standard "git clone" result, that copies
all their branches to remote-tracking branches.

Thanks.
