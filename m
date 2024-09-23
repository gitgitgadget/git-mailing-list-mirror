Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2AB23AD
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727058353; cv=none; b=eR+6VYbhQnhA2W+gt6wgvcBZTfepouUYvQbxNa3lIc3j8nxeg0exkJU3bAtg8yNpIayj86JdJIImfZZ5PVFTKk04ezkYT4x2LXgH2mriIa1A3Fp/ftHZ8uR47pCGLhZ4FiOTfdGW1G6YLcdGdpU4plY6gM26xn991BiOWIeBYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727058353; c=relaxed/simple;
	bh=O5iegEAIGm7iPuIGdAdLj5MdyT9DuBJ4RGCtcTGyKAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ci9gIpiDA5br77mZeCDMKiula/AP52WaNjzZBbrWthEQhwXCFB6wYXjj2RMAFrK7hcQuxonX7nodcbb/wTemsxrRZneC6mB8zHl8jPSgPYhr8XlRvS5Z5PqFQzFGRjTlIktqPE01L66cxgAwZGs2pLexlHJ+U/ZFbxZjZrPwQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZufnNBc4; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZufnNBc4"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e2886ea751so101421b6e.0
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 19:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727058350; x=1727663150; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GGUe4N/1z1/pdE7mjz2Slpq/P9kuGfzuvbpjQ07T07c=;
        b=ZufnNBc4zjAaP47KPXFJIdMvaVjQul7blXJ2rtZfdPxlOSkDySr5W8xBuAzBxItyCw
         jy5BCInJujYosWD2ozszJjY45m0+5X/nrPPilUuDZMJyn5UWCZBVqIssqXKaJAyKljdB
         qozjTySg/frwBtuH8fFdQxU5LENT4ouNXPX+qIQAGkrd10E5UWC8jkrKu0UYNsSr0vJi
         KXM5KzgVyJq0RWmvEIH8jLQo+hotNAHDS6sRUcGKCe9LRrLtva8kYPG+WdHRrjSxx7QX
         Na7Fj0GHjZ+1K9h9+Y13e0ycmABAI0rrKitmyUqNz9lNaRyM7guvdygNnnhPEkqtJJa3
         WZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727058350; x=1727663150;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGUe4N/1z1/pdE7mjz2Slpq/P9kuGfzuvbpjQ07T07c=;
        b=Rh1w5hhzlH1BRcjWFKBU4zja9SNfv0tcQI0vv7vB2PPCPjOxNZ3oltABhDY13BzqLu
         ipDh4ScY89y/8xSezCArk73o7lYrw1GMOYCm+P3q+6RegLvkN5KG2r0uamnndCdJY0ol
         nBFWo4ViT4C2P6eKYqRQiP1fanO+pZS3ExLXkt1sYoBzmG4ydrvYZnG/A3ZvL2mBgLsf
         8sqvuj+lT0q8HErc+i79cdCy8dZKnViP6arl+rTIFKXY0Bf3Yl5on6IsEriVS79eLy2Y
         FikY6s94wUozYafva2ywYd9+3K+DAyo528gGs6CRRSCz1wJElRUODUB4z0J/w+C+FKmb
         yrtg==
X-Forwarded-Encrypted: i=1; AJvYcCUu680MqNsDRq5duuPItzQ+CaGfkFwKi50C/2LxRLiz5HnDjHn7TXT3FZNcgzj5r8LK4S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMSW2dRZhWFhBSRD23Np1mCXnPCnerWo7Pd+bpnXzVBJPbNIc
	MsMiPaxrJWOt76XVT1yk0yduqNkkW7V66sKy1XpmqySbyhQusOJMjDGikA==
X-Google-Smtp-Source: AGHT+IE9NdBYJpXHppCLp1LEMVsQcumFEgEz5mN82U4ctC7lhCYSS1afJnJYDY050ol8/npRjhg2ig==
X-Received: by 2002:a05:6808:1808:b0:3e0:3b81:6b26 with SMTP id 5614622812f47-3e271ba08c8mr5590384b6e.15.1727058349770;
        Sun, 22 Sep 2024 19:25:49 -0700 (PDT)
Received: from epic96565.epic.com (syn-075-135-086-025.res.spectrum.com. [75.135.86.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e26b6afd9esm1972844b6e.23.2024.09.22.19.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 19:25:49 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: <rsbecker@nexbridge.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>,  <git@vger.kernel.org>
Subject: Re: [TOPIC 01/11] Rust
In-Reply-To: <053f01db0b79$0d885b30$28991190$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 20 Sep 2024 12:20:42 -0400")
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local>
	<053f01db0b79$0d885b30$28991190$@nexbridge.com>
Date: Sun, 22 Sep 2024 21:25:47 -0500
Message-ID: <m0v7ynm7h0.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Randall,

This ended up being pretty long, so I apologize in advance for 'not
having the time to make it shorter' (if you'll permit a small amount of
plagiarism there). These are just my thoughts on this topic that have
been cooking for a long time. I've been following this conversation
closely, and for the first time, I thought I might have something small
to add. Unfortunately, it's taken a lot of words to say it!

<rsbecker@nexbridge.com> writes:
> On September 20, 2024 10:18 AM, Taylor Blau wrote:
>>* Kyle: Rust code in the Git project; do we want it? Why would we want
>>  it?
>>* Elijah: Anybody other than Randall that objects to it?
>
> To be honest, I do not fundamentally object to Rust.

I don't think anybody (or at least, I hope nobody) thinks so; this is
absolutely a conversation we can and should (and I believe do) have in
good faith :-)

I've not contributed to this conversation much so far -- not out of lack
of interest, but out of respect:

1. While I've been using Git for many, many years, I'm a pretty new face
   on this list. I'm still working on making a good first impression :-)

2. I know absolutely _nothing_ about NonStop, but I do know what it's
   like to feel like you're a member of an invisible set of users. There
   are significant aspects of my $DAYJOB where that is absolutely the
   case, so I want to leave room for what I know that I don't know. I
   know your customers are important, and (I think I know) you
   supporting your customers requires the tools being used to be
   supported.

3. I don't even know _that_ much about Git's implementation compared to
   the experts on this list, so I feel ill-equipped to judge personally
   whether Rust is a good fit for the project to begin with -- thus I
   don't feel I have much to contribute to that conversation over what
   the experts have already said.

Putting my own cards on the table -- I'd be in favor of introducing Rust
into Git's codebase for many of the reasons cited elsewhere. Based on my
naive understanding of the codebase and the types of bug fixes I've seen
come in during my time paying attention to this list, it does seem like
rustc would add the value for which it was designed. I say this not to
'upvote' the idea of including Rust, but to be transparent about the
context from which I'm speaking.

So, in good faith, here goes :-)

> My problem is that the Rust team is not supporting including NonStop
> as a platform. I would love to be able to do the port, but it is not
> up to me - it is up to Rust's permission (or lack of in this case) to
> support NonStop, and I do not see this changing in my life-time.

Is this just regarding the GCC dependency I've seen you reference
elsewhere[1] or is there something else? I just want to make all the
cards are on the table here -- particularly I want to make sure you're
not referencing some licensing incompatibility or project policy that
could be (even) more challenging than porting GCC to NonStop. An
uneducated search of rustc's book[2] for 'gcc' didn't yield anything
immediately interesting, but there are call-outs for not supporting
platforms that introduce license incompatibilities or 'onerous legal
terms'.

If not, is this about (what I assume to be the) 'tier 3' platform
support policy mentioned at [2]? In some respects, it seems like this is
similar to the status of NonStop as a supported platform in the Git
project already, though I suppose that's also a main topic of
conversation for the 'supported platform' thread elsewhere. It does seem
in line with what you already do, though, which is to provide patches to
Git when something merges that breaks tests on NonStop. It seems it
would be similar in a Rust world, though patches would 'just' be sent to
the Rust maintainers instead. (I say that knowing that it would be an
entirely foreign codebase and set of concerns for submitting correct
patches -- so the two are not at all similar in effort, just in
behavior.)

> Depending on a piece of technology where control of where it runs is
> outside of git's control is not responsible, in my view. It restricts
> where git can run, and excludes platforms that currently use a
> critical piece of infrastructure (git).

I think this is going to be true of any platform that the Git project
chooses to continue to build upon, isn't it? Any platform-specific bugs
in the various C compilers used are not in this project's control,
either, nor OpenSSL, cURL, PCRE, gettext, etc., etc. that are already
essential to Git's main functions when it's being used by a human (i.e.,
not as part of a larger automated system).

Any added dependency will run the risk of not being buildable on every
platform out there -- even if it's included in the standard library,
potentially -- and I don't believe it's a sustainable practice to never
add any dependencies.

> I have tens of thousands of people in my community who depend on git
> on a daily basis, and simply kicking them off because of a decision,
> or lack of decision, that some unrelated dependency controls should be
> (unfortunately does not appear to be for git) a showstopper.

I'd like to understand this a little better.

First, from the original notes:
>> Emily: old versions aren't going away.
which I mention only to supply the obvious counterpoint. I believe
you've said in the past (sorry that I can't find the specific link) that
you'd like to see Git continue to receive improvements and enhancements
that you can forward onto your customers. This is great! I understand
this perfectly. I have the very same desire for my users (which number
in the 3-4k range). I look forward to every performance improvement and
revamped workflow with bated breath -- wondering how/when it can be
incorporated into our system to give our folks the best experience they
can possibly have as direct users of Git in a heavily automated system.

It stands to reason that your users wouldn't see such improvements if
incompatible technologies like Rust are adopted into the codebase and
those features were written using this incompatible technology. This is
understandably a frustrating prospect! Previously, you would have been
able to get even more value out of all the open-source effort (and your
own effort as a maintainer keeping it compatible) -- and now it's not
really feasible. I do understand this sentiment. (Regardless of how much
I understand it, if this is not _your_ sentiment, please let me know!)

Here's where I'm struggling a bit. From what I see, I understand two
contradictory points:

1. To continue building Git on every platform where it builds today, the
   project must either

   a) not add any new incompatible dependencies or
   b) put any such dependencies behind a feature flag (e.g. NO_CURL) so
      that Git may continue to be built without that dependency.

   Great, no harm -- no foul. But...

2. If you continue building without that dependency, you don't get that
   feature, so the original purpose of enhancing Git -- to pass that
   benefit on to users -- is lost.

So it would seem that this leaves us with only option (a) to not add any
new incompatible dependencies -- which is what I understand you've been
proposing. Certainly reasonable. But then how do you build cool new
stuff? Well, build it yourself, I guess.

There's been a _lot_ of cool new stuff lately. This is great! But this
does seem to be spearheaded by the work (and thus funding) of companies
like GitLab, Microsoft, and Google (and these are just the ones I
recognize either by contributor name or by email domain). I'm incredibly
thankful for the work and expertise these folks add to the project on an
ongoing basis.

I worry though that the 'cool new stuff' seems to require such
investment. It is _hard_ to write correct, safe C. I worry that this
difficulty will eventually translate to significant, safe contributions
coming only from those with the resources to create them and not from a
more diverse pool of contributors. As grateful as I am to large
companies who fund Git contributions, I don't think those companies,
given the choice in and of themselves, would think twice about dropping
support for a platform they don't use -- and that is probably a much
smaller set than 'does the platform have GCC'. I don't think this is a
danger today or tomorrow, but it _is_ a danger of not having a diverse
group of contributors -- and that is the danger posed by not allowing
yourself to use any of the 'cool new stuff' _other_ people have written.

--

I don't have a satisfying response to what to do for NonStop in a world
where Rust enters the Git codebase. I really don't, and that frustrates
me for you. I hope that there's a solution out there (maybe from your
vendors, maybe from the storied halls of GCC maintainers, who knows),
but I'll echo (more earnestly this time):
>> Emily: old versions aren't going away.
Nobody has the power to 'kick users off' a project such as Git -- not
even if everyone somehow miraculously agreed to port the entire thing to
something hot off the presses at /r/programminglanguages :-) Ultimately,
your systems will continue to function regardless of what happens
upstream. Of course I can't speak to support contracts, but I assume
neither can anyone on this list.

That said, I also don't know how a project can continue to thrive
without the (occasional, thoughtful, and deliberate) introduction of new
technologies, new contributors excited and emboldened by those
technologies, and new ideas from those contributors.

Change is essential to growth. Like I mentioned at the outset, I'll let
the true experts on this list speak to whether _this_ change is
essential for growth, but I hope I've at least made some points that
were worth reading.

[1]: https://lore.kernel.org/git/007c01da4420$10a7b700$31f72500$@nexbridge.com/
[2]: https://doc.rust-lang.org/rustc/target-tier-policy.html

-- 
Sean Allred
