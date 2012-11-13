From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 11:48:45 -0500
Message-ID: <20121113164845.GD20361@sigill.intra.peff.net>
References: <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
 <20121113074720.GA18746@sigill.intra.peff.net>
 <CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:49:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJfd-0005Lw-8r
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab2KMQsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:48:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab2KMQsv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:48:51 -0500
Received: (qmail 26381 invoked by uid 107); 13 Nov 2012 16:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 11:49:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 11:48:45 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209633>

On Tue, Nov 13, 2012 at 10:06:26AM +0100, Felipe Contreras wrote:

> > Those people would also not be using a new version of git-send-email,
> > and it will always prompt. I thought we were talking about what
> > send-email should do in future versions. Namely, loosening that safety
> > valve (the prompt) because it is inconvenient, but tightening the checks
> > so that losing the safety valve is not a problem.
> 
> Yeah, but all I'm saying is that the issue happens, you seemed to
> suggest that it doesn't.

What is "it"?

If it is bad guesses like "user@host.(none)" on unconfigured systems,
then I did not suggest it doesn't happen. I said that it happened with
older versions of git, but that it has now been fixed. Of course it will
continue to happen for people on older versions of git until they
upgrade. I cannot go back in time and fix released versions.

If it is guessing at all to end up with "user@host.domain" for a host
that does not receive mail, yes, that happens, and I have been very
clear that it does. The safety valve is showing the ident and a warning
to the user during the commit process.

I do not see any point in discussing the former when considering future
changes to git. It is already disallowed by current versions of git, and
we are just waiting for the whole world to upgrade to a fixed version.

I can see the argument for tightening the check to disallow the latter.
But it would also hurt real people who are relying on the feature.
Perhaps it would make sense to adopt the implicit_ident_advice in other
code paths besides "git commit" (e.g., via "git var).

> I think you are the one that is not understanding what I'm saying. But
> I don't think it matters.
> 
> This is what I'm saying; the current situation with 'git commit' is
> not OK, _both_ 'git commit' and 'git send-email' should change.

Perhaps I am being dense, but this is the first time it became apparent
to me that you are arguing for a change in "git commit".

> Indeed I would, but there's other people that would benefit from this
> patch. I'm sure I'm not the only person that doesn't have
> sendmail.from configured, but does have user.name/user.email, and is
> constantly typing enter.
> 
> And the difference is that I'm _real_, the hypothetical user that
> sends patches with GIT_AUTHOR_NAME/EMAIL is not. I would be convinced
> otherwise if some evidence was presented that such a user is real
> though.

Sadly we cannot poll the configuration of every user, nor expect them
all to pay attention to this discussion on the list. So we cannot take
the absence of comment from such users as evidence that they do not
exist. Instead we must use our judgement about what is being changed,
and we tend to err on the side of keeping the status quo, since that is
what the silent majority is busy _not_ complaining about.

We use the same judgement on the other side, too. Right now your
evidence is "1 user wants this, 0 users do not". But we can guess that
there are other people who would like the intent of your patch, but did
not care enough or are not active enough on the list to write the patch
themselves or comment on this thread.

It is also very easy to me accept the status quo when it is not in
fundamental conflict with the proposed improvement, but simply a matter
of implementation (which it is the case for send-email stopping
prompting in some cases, though it is not for changing the behavior of
git-commit).

> And to balance you need to *measure*, and that means taking into
> consideration who actually uses the features, if there's any. And it
> looks to me this is a feature nobody uses.

You said "measure" and then "it looks to me like". What did you measure?
Did you consider systematic bias in your measurement, like the fact that
people who are using the feature have no reason to come on the list and
announce it?

> But listen closely to what you said:
> 
> > I actually think it would make more sense to drop the prompt entirely and just die when the user has not given us a usable ident.
> 
> Suppose somebody has a full name, and a fully qualified domain name,
> and he can receive mails to it directly. Such a user would not need a
> git configuration, and would not need $EMAIL, or anything.
> 
> Currently 'git send-email' will throw 'Felipe Contreras
> <felipec@felipec.org>' which would actually work, but is not explicit.
> 
> You are suggesting to break that use-case. You are introducing a
> regression. And this case is realistic, unlike the
> GIT_AUTHOR_NAME/EMAIL. Isn't it?

Yes, dying would be a regression, in that you would have to configure
your name via the environment and re-run rather than type it at the
prompt. You raise a good point that for people who _could_ take the
implicit default, hitting "enter" is working fine now, and we would lose
that.  I'd be fine with also just continuing to prompt in the implicit
case.

But that is a much smaller issue to me than having send-email fail to
respect environment variables and silently use user.*, which is what
started this whole discussion. And I agree it is worth considering as a
regression we should avoid.

> I prefer to concentrate on real issues, but that's just me.

To be honest, I am confused at this point what you actually want. Do you
think we should take your original patch?  I think its regression is too
great. And I am not sure if you agree or not. You seem to be arguing
that the regression is not important, yet you simultaneously argue that
we should be making all ident more strict, which would mean that we
should indeed take my suggestion and use "git var" instead of preferring
the config.

> > As for whether they exist, what data do you have?
> 
> What data do _you_ have?
> 
> When there's no evidence either way, the rational response is to don't
> believe. That's the default position.

This is not religion. It is a software project. In the absence of data,
the sane thing is not to break existing users. The burden is on you to
argue that there is no such breakage.

> > Are you aware that the
> > test suite, for example, relies on setting GIT_AUTHOR_NAME but not
> > having any user.* config?
> 
> What tests?  My patch doesn't seem to break anything there:
> % make -C t t9001-send-email.sh
> # passed all 96 test(s)

My point was that there is at least one known setup that uses only
environment variables and not a config file, and that the rest of git is
intended to work with that.  It is not a test failure, but t9001.18
reveals the fact that your change does not handle this situation; we
continue to prompt under the test suite's configuration. In the proper
fix, the test needs to be adjusted.

You don't see any test failures with your patch because we do not cover
the case that you regress (GIT_AUTHOR_EMAIL and user.email both set).

> > When somebody comes on the list and asks why
> > every git program in the entire system respects GIT_* environment
> > variables as an override to user.* configuration _except_ for
> > send-email, what should I say?
> 
> The same thing you say when somebody comes reporting a bug: "yeah, we
> should probably fix that".

It is a larger hassle for both the developer and the user to fix the bug
after the fact, ship a new version, and then have the user upgrade their
git. Why not just not introduce the bug in the first place?

> It's all about proportion. Is it possible that we all are going to die
> tomorrow because of an asteroid? Sure... but what's the point of
> worrying about it if it's not likely?

If you want to talk about risk assessment, then the right computation is
to compare the cost of fixing it now versus the cost of fixing it later
times the probability of it happening. The development cost is probably
a little higher later (because we have to refresh ourselves on the
issue), but the deployment cost is much higher (e.g., users whose
distros ship a broken version, or who have IT policy that does not let
them upgrade git as soon as the bug-fix ships).

> >> That's right, AUTHOR_IDENT would fall back to the default email and full name.
> >
> > Yeah, I find that somewhat questionable in the current behavior, and I'd
> > consider it a bug. Typically we prefer the committer ident when given a
> > choice (e.g., for writing reflog entries).
> 
> Yeah, but clearly the intention of the code was to use the committer
> if the author wasn't available, which is the case here.

Yes. It would make sense to me to respect an explicit committer over an
implicit author. Though the fact that author is preferred over committer
is inconsistent with most of the rest of git. I'm undecided whether that
should be changed.

> >> What about after my change?
> >>
> >> 6.1) GIT_AUTHOR without anything else
> >>
> >> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
> >> var GIT_COMMITTER_IDENT: command returned error: 128
> >
> > Doesn't that seem like a regression? It used to work.
> 
> No, this is *before* my change.
> 
> I's the same bug as 5.1):

Ah, I see. We are loading both, whether or not they end up being used,
and barfing prematurely on errors. That seems like a bug.

> >> And what about your proposed change?
> >
> > Let me be clear that I sent you a "something like this" patch to try to
> > point you in the right direction. If it has a bug or is incomplete, that
> > does not mean the direction is wrong, but only that I did not spend very
> > much time on the patch.
> 
> It doesn't matter, the idea was to use user_ident_sufficiently_given().

Right. Which it sounds like now agree with me on?

> > I think that respecting the usual ident lookup but disallowing implicit
> > identities (either totally, or causing them to fallback to prompting) is
> > the right direction.  I agree my patch was not a complete solution. I'm
> > sorry if it led you astray in terms of implementation, but I also think
> > I've been very clear in my text about what the behavior should be.
> 
> I think that is orthogonal to what I'm trying accomplish.

What is it you are trying to accomplish? Eliminating the prompt in some
cases, as in your original patch? Dealing with implicit identities may
be orthogonal to your goal, but your original patch is not sufficient,
as it reverses the precedence of config and environment variables.
So you can either:

  1. Reimplement the environment variable lookup that ident.c does,
     leaving implicit ident logic out completely.

  2. Modify ident.c and "git var" to let send-email reuse the logic in
     ident.c, but avoid dropping the prompt when an implicit ident is
     used.

Doing (2) sounds a lot more maintainable to me in the long run.

> > Don't get me wrong. I think the spirit of your patch is correct, and it
> > helps some git users. But it also hurts others. And it is not that hard
> > to do it right.
> 
> And I disagree, I think it hurts nobody, and I think it's hard to do it right.

I am tired of talking about this. The patch series below took me less
time to write than I have spent arguing with you. It was not that hard.

  [1/6]: ident: make user_ident_explicitly_given private
  [2/6]: ident: keep separate "explicit" flags for author and committer
  [3/6]: var: accept multiple variables on the command line
  [4/6]: var: provide explicit/implicit ident information
  [5/6]: Git.pm: teach "ident" to query explicitness
  [6/6]: send-email: do not prompt for explicit repo ident

> Fixing a regression that nobody would notice is not my itch either,

Sorry, but it is part of your itch. The git project is at state A. With
your patch, we are at a regressed state B. If you then fix it, we are at
state C. From your perspective, it may be "I do not want to make the fix
to go from B to C". But from the project's perspective, it is "we do not
want to go from state A to state B; state C would be acceptable". So
from the perspective of people who do not care about your feature but do
care about the regression in state B, it is inextricably linked to your
itch.

> yet the patch I sent above does it, and it even fixes 'git commit'
> (IMO). But it's also not good enough.

I do not necessarily agree on "git commit". Moreover, I feel like it is
a separate issue. My series above _just_ implements the "do not prompt
when explicit" behavior. It does not deal with git-commit at all, nor
does it address the author/committer fallback questions. Those can
easily go on top.

-Peff
