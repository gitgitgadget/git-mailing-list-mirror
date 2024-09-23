Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1545003
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093871; cv=none; b=BZCqegDt+9MLjW8jwKvcZgkEAhFHPNGP/jESUEG1go5abr+MZu5jaAGNfM+Py4Wl0yMSB7RA2/SkMgZMQ+YONBYuNaR3yWfM7rRjkCnJLjcwbn9vb2QEKwfsLcZJvk4ZbogCoPTz8eUZM6EaB/Dlamq++oHd2+4IShGQnP8ZyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093871; c=relaxed/simple;
	bh=0xDkdpP9UzPMVWjZcV2UqtzNjK7qmHDm+amgMjO4kSQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pRuI2CyAbbF87b3+fx/OLfPkB+yv7qoS+rdZuPCJNFaTbISEDrlek/6ZBeZkdr9e/V0/K1mgBkQCFNExc3ZvzC3A+XQNkPRxShWP5dRonY/NAXACHbfNJBC6MEHrU5cbayhjQysNjotCF/CS+nAV3t5yIgy6aHS8yjXqLudh7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48NCHcTQ888491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:17:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Sean Allred'" <allred.sean@gmail.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local>	<053f01db0b79$0d885b30$28991190$@nexbridge.com> <m0v7ynm7h0.fsf@epic96565.epic.com>
In-Reply-To: <m0v7ynm7h0.fsf@epic96565.epic.com>
Subject: RE: [TOPIC 01/11] Rust
Date: Mon, 23 Sep 2024 08:17:33 -0400
Organization: Nexbridge Inc.
Message-ID: <00a501db0db2$94d505d0$be7f1170$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQF24rJ2Q0W9JcDOH4N3ZxazDM0CYQHP+YxMAoJn3JIBrepyA7L9lcAg

On September 22, 2024 10:26 PM, Sean Allred wrote:
>This ended up being pretty long, so I apologize in advance for 'not having
the time
>to make it shorter' (if you'll permit a small amount of plagiarism there).
These are
>just my thoughts on this topic that have been cooking for a long time. I've
been
>following this conversation closely, and for the first time, I thought I
might have
>something small to add. Unfortunately, it's taken a lot of words to say it!
>
><rsbecker@nexbridge.com> writes:
>> On September 20, 2024 10:18 AM, Taylor Blau wrote:
>>>* Kyle: Rust code in the Git project; do we want it? Why would we want
>>>  it?
>>>* Elijah: Anybody other than Randall that objects to it?
>>
>> To be honest, I do not fundamentally object to Rust.
>
>I don't think anybody (or at least, I hope nobody) thinks so; this is
absolutely a
>conversation we can and should (and I believe do) have in good faith :-)
>
>I've not contributed to this conversation much so far -- not out of lack of
interest,
>but out of respect:
>
>1. While I've been using Git for many, many years, I'm a pretty new face
>   on this list. I'm still working on making a good first impression :-)
>
>2. I know absolutely _nothing_ about NonStop, but I do know what it's
>   like to feel like you're a member of an invisible set of users. There
>   are significant aspects of my $DAYJOB where that is absolutely the
>   case, so I want to leave room for what I know that I don't know. I
>   know your customers are important, and (I think I know) you
>   supporting your customers requires the tools being used to be
>   supported.
>
>3. I don't even know _that_ much about Git's implementation compared to
>   the experts on this list, so I feel ill-equipped to judge personally
>   whether Rust is a good fit for the project to begin with -- thus I
>   don't feel I have much to contribute to that conversation over what
>   the experts have already said.
>
>Putting my own cards on the table -- I'd be in favor of introducing Rust
into Git's
>codebase for many of the reasons cited elsewhere. Based on my naive
>understanding of the codebase and the types of bug fixes I've seen come in
during
>my time paying attention to this list, it does seem like rustc would add
the value for
>which it was designed. I say this not to 'upvote' the idea of including
Rust, but to be
>transparent about the context from which I'm speaking.
>
>So, in good faith, here goes :-)
>
>> My problem is that the Rust team is not supporting including NonStop
>> as a platform. I would love to be able to do the port, but it is not
>> up to me - it is up to Rust's permission (or lack of in this case) to
>> support NonStop, and I do not see this changing in my life-time.
>
>Is this just regarding the GCC dependency I've seen you reference
elsewhere[1] or is
>there something else? I just want to make all the cards are on the table
here --
>particularly I want to make sure you're not referencing some licensing
>incompatibility or project policy that could be (even) more challenging
than porting
>GCC to NonStop. An uneducated search of rustc's book[2] for 'gcc' didn't
yield
>anything immediately interesting, but there are call-outs for not
supporting
>platforms that introduce license incompatibilities or 'onerous legal
terms'.

The GCC dependency, which does not currently exist in git, is independent of
Rust.
Rust has its own rules and runtime. The issue here is that the Rust team
gets to
decide what platforms can participate, NOT the platform maintainers. No
matter
what my intent, or resources, I cannot get the Rust team to "Allow" a port.
In
many ways, this is egregious and is a policy issue entirely on Rust, not us.
We
want to do a Rust port but are simply not allowed/approved. It is their
policy.

>If not, is this about (what I assume to be the) 'tier 3' platform support
policy
>mentioned at [2]? In some respects, it seems like this is similar to the
status of
>NonStop as a supported platform in the Git project already, though I
suppose that's
>also a main topic of conversation for the 'supported platform' thread
elsewhere. It
>does seem in line with what you already do, though, which is to provide
patches to
>Git when something merges that breaks tests on NonStop. It seems it would
be
>similar in a Rust world, though patches would 'just' be sent to the Rust
maintainers
>instead. (I say that knowing that it would be an entirely foreign codebase
and set of
>concerns for submitting correct patches -- so the two are not at all
similar in effort,
>just in
>behavior.)

This is not a tier 3 policy with regards to Rust. It is exclusionary.
 
>> Depending on a piece of technology where control of where it runs is
>> outside of git's control is not responsible, in my view. It restricts
>> where git can run, and excludes platforms that currently use a
>> critical piece of infrastructure (git).
>
>I think this is going to be true of any platform that the Git project
chooses to
>continue to build upon, isn't it? Any platform-specific bugs in the various
C
>compilers used are not in this project's control, either, nor OpenSSL,
cURL, PCRE,
>gettext, etc., etc. that are already essential to Git's main functions when
it's being
>used by a human (i.e., not as part of a larger automated system).
>
>Any added dependency will run the risk of not being buildable on every
platform
>out there -- even if it's included in the standard library, potentially --
and I don't
>believe it's a sustainable practice to never add any dependencies.

I agree that it is not a good policy to never add new dependencies. However,
Dependencies must be reasonable and give the platforms a chance, at least,
to adapt. We cannot in the case of Rust. The problem is not actually that we
can
do without new features that are in Rust but not C. The problem is when
there
are CVEs. Suppose a severe CVE happens that is fixed in a Rust component but
referenced by a C component or somehow intertwined. The fix to the CVE
becomes unavailable and git gets thrown off the platform. That is the
reality
of how insidious CVEs are when it meets corporate policy. I am primarily
trying
to protect from that.

If git was a toy or an experiment, this would not be an issue. But git is
core
Infrastructure for managing and deploying customer facing functionality now,
more than any other single piece of code on any platform. It my hope that
the
git team will finally and eventually understand this, and act accordingly.

If the component in Rust is a toy or non-core, like Git LFS in GO, it can
sometimes
be worked around. Git LFS was something we wanted to port, but it turns out
to
be irrelevant as restrictions in Cloud GitHub and BitBucket make it pretty
much
worthless looking into the future.

>> I have tens of thousands of people in my community who depend on git
>> on a daily basis, and simply kicking them off because of a decision,
>> or lack of decision, that some unrelated dependency controls should be
>> (unfortunately does not appear to be for git) a showstopper.
>
>I'd like to understand this a little better.

Telling 10-20000 users that their core bit of infrastructure is insecure and
not fixable
is not a tenable position. However, it is hard to defend the community when
the git
team is hell-bent on this particular decision. What do you need to
understand here?
It is a small community with a large number of users in key financial
institutions that
have a very conservative adoption policy and an even more conservative
hardware
vendors.

>First, from the original notes:
>>> Emily: old versions aren't going away.
>which I mention only to supply the obvious counterpoint. I believe you've
said in
>the past (sorry that I can't find the specific link) that you'd like to see
Git continue to
>receive improvements and enhancements that you can forward onto your
>customers. This is great! I understand this perfectly. I have the very same
desire for
>my users (which number in the 3-4k range). I look forward to every
performance
>improvement and revamped workflow with bated breath -- wondering how/when
>it can be incorporated into our system to give our folks the best
experience they can
>possibly have as direct users of Git in a heavily automated system.

What I should have said was that I have no problem with git adding new
portable
dependencies. Rust is fundamentally unportable given the policy restrictions
Imposed by that team.

>
>It stands to reason that your users wouldn't see such improvements if
incompatible
>technologies like Rust are adopted into the codebase and those features
were
>written using this incompatible technology. This is understandably a
frustrating
>prospect! Previously, you would have been able to get even more value out
of all
>the open-source effort (and your own effort as a maintainer keeping it
compatible) -
>- and now it's not really feasible. I do understand this sentiment.
(Regardless of how
>much I understand it, if this is not _your_ sentiment, please let me know!)
>
>Here's where I'm struggling a bit. From what I see, I understand two
contradictory
>points:
>
>1. To continue building Git on every platform where it builds today, the
>   project must either
>
>   a) not add any new incompatible dependencies or
>   b) put any such dependencies behind a feature flag (e.g. NO_CURL) so
>      that Git may continue to be built without that dependency.
>
>   Great, no harm -- no foul. But...
>
>2. If you continue building without that dependency, you don't get that
>   feature, so the original purpose of enhancing Git -- to pass that
>   benefit on to users -- is lost.
>
>So it would seem that this leaves us with only option (a) to not add any
new
>incompatible dependencies -- which is what I understand you've been
proposing.
>Certainly reasonable. But then how do you build cool new stuff? Well, build
it
>yourself, I guess.
>
>There's been a _lot_ of cool new stuff lately. This is great! But this does
seem to be
>spearheaded by the work (and thus funding) of companies like GitLab,
Microsoft,
>and Google (and these are just the ones I recognize either by contributor
name or
>by email domain). I'm incredibly thankful for the work and expertise these
folks add
>to the project on an ongoing basis.
>
>I worry though that the 'cool new stuff' seems to require such investment.
It is
>_hard_ to write correct, safe C. I worry that this difficulty will
eventually translate to
>significant, safe contributions coming only from those with the resources
to create
>them and not from a more diverse pool of contributors. As grateful as I am
to large
>companies who fund Git contributions, I don't think those companies, given
the
>choice in and of themselves, would think twice about dropping support for a
>platform they don't use -- and that is probably a much smaller set than
'does the
>platform have GCC'. I don't think this is a danger today or tomorrow, but
it _is_ a
>danger of not having a diverse group of contributors -- and that is the
danger posed
>by not allowing yourself to use any of the 'cool new stuff' _other_ people
have
>written.
>
>--
>
>I don't have a satisfying response to what to do for NonStop in a world
where Rust
>enters the Git codebase. I really don't, and that frustrates me for you. I
hope that
>there's a solution out there (maybe from your vendors, maybe from the
storied
>halls of GCC maintainers, who knows), but I'll echo (more earnestly this
time):
>>> Emily: old versions aren't going away.

Again, it is not the gcc dependency. We have been coping with c99 and will
have c11
shortly. It is Rust itself that is exclusionary. It might be easier to write
new
functionality in Rust - it is easier in Java, Perl, and Python too. Why
Rust? Because
someone wants it, not because you cannot implement the functionality.

I do not see giving up on git is an option, but if that is what ultimately
happens,
I think it will be embarrassing and expensive in the extreme for large
numbers
of users. Considering that 90% of all financial transactions quietly and
without
fanfare touch NonStop hardware at some point, the impact should be obvious
but not initially apparent.

>Nobody has the power to 'kick users off' a project such as Git -- not even
if
>everyone somehow miraculously agreed to port the entire thing to something
hot
>off the presses at /r/programminglanguages :-) Ultimately, your systems
will
>continue to function regardless of what happens upstream. Of course I can't
speak
>to support contracts, but I assume neither can anyone on this list.
>
>That said, I also don't know how a project can continue to thrive without
the
>(occasional, thoughtful, and deliberate) introduction of new technologies,
new
>contributors excited and emboldened by those technologies, and new ideas
from
>those contributors.
>
>Change is essential to growth. Like I mentioned at the outset, I'll let the
true experts
>on this list speak to whether _this_ change is essential for growth, but I
hope I've at
>least made some points that were worth reading.
>
>[1]:
>https://lore.kernel.org/git/007c01da4420$10a7b700$31f72500$@nexbridge.co
>m/
>[2]: https://doc.rust-lang.org/rustc/target-tier-policy.html
>
>--
>Sean Allred

