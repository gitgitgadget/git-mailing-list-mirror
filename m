From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 03:50:46 -0400
Message-ID: <20130908075046.GL14019@sigill.intra.peff.net>
References: <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908044329.GA15087@sigill.intra.peff.net>
 <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
 <20130908052107.GA15610@sigill.intra.peff.net>
 <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
 <20130908065420.GI14019@sigill.intra.peff.net>
 <CAMP44s3LLHL=oP2PFr4b7VD0dL4yGBOL00O_GWj8eZLrYNM3kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 09:50:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZlm-0005Fg-S6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab3IHHuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:50:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:43452 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab3IHHuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:50:50 -0400
Received: (qmail 9116 invoked by uid 102); 8 Sep 2013 07:50:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 02:50:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 03:50:46 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3LLHL=oP2PFr4b7VD0dL4yGBOL00O_GWj8eZLrYNM3kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234214>

On Sun, Sep 08, 2013 at 02:15:17AM -0500, Felipe Contreras wrote:

> > I think "the guy" may be git itself. For example, here is a possible
> > session with jc/pull-training-wheel:
> >
> >   $ git push
> 
> Who told him to use 'git push'? Certainly not git.

Any of the hundreds of existing tutorials that teach basic git commands
like "push"?

> >   To ...
> >    ! [rejected]        master -> master (non-fast-forward)
> >   error: failed to push some refs to '...'
> >   hint: Updates were rejected because the tip of your current branch is behind
> >   hint: its remote counterpart. Integrate the remote changes (e.g.
> >   hint: 'git pull ...') before pushing again.
> >   hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> [...]
> 
> Why stop there? Post the whole man page already.
> 
> Moreover, it's overly verbose on all the wrong and irrelevant
> information. If you are going to waste precious screen state, explain
> wth a "non fast-forward" is; people can figure out what a merge is,
> and maybe a rebase, but a "non fast-forward" definitely not.

Note that I was not trying to defend any of the messages, but only
showing a plausible mechanism by which a user with basic knowledge that
he wants to push may arrive at the question "what is the difference
between merge and rebase?".

If you want to suggest revisions for the push message, go ahead. The
push advice _is_ an attempt to define non-fast-forwards in plain
language without taking up too much space, but perhaps you can do
better. You could even suggest omitting it entirely, but I'm not sure if
that is a good idea. It was not added in a vacuum; we lacked that advice
for many years, and people complained about it quite a bit until it was
added.

> > The user is pointed at "pull" from "push", and then gets presented with
> > the "merge or rebase" choice. It may be that the advice you can find by
> > googling "merge vs rebase" is enough to then help the person along
> > (and/or we may need to improve the manpages in that respect).
> 
> Yes, but that's not the use-case we are talking about. You mentioned
> specifically a "svn-like" worfklow where the guy was told by somebody
> else to replace the svn commands with git ones.

No, I mentioned an "svn-like" workflow. I didn't say anything about how
they were told. They might have been told by a co-worker, or read a
brief tutorial on git, or read something like "Git-SVN Crash Course".

> If we are talking about a guy that is learning git, that's and
> entirely different case.

That is certainly what I meant to be talking about.

> The purpose of this change in the code is not to change the user
> behavior. The choice of merge vs. rebase is entirely up to the user,
> and we are not changing that.

Right, but by not doing anything by default, you are forcing the user to
make a decision. Right now, we strongly encourage merging by making it
the default, and you have to learn about rebasing separately. But a
message that mentions them both as equals is going to lead to extra work
for the user; they have to figure out which one is most appropriate. My
concern is that this is non-trivial for new users, and that they may end
up arbitrarily picking rebase, which is probably not doing them any
favors if they do not understand it.

For clueful users, choosing between the two is not hard. But some people
seem to have trouble understanding the DAG. I don't know how large a
group that is, and how any pain caused by this change might compare to
the times it will help.

> > If you are interested, I can ask the opinion of some of the GitHub
> > trainers. They see a lot of new users and have a sense of what kinds of
> > confusion come up most frequently, what kinds of workflows they tend to
> > see, etc. Their experience may be biased towards corporate-ish users,
> > though, because those are the people who pay for training.
> 
> Ask. I'm sure they will tell you doing merges by mistake with 'git
> pull' is an issue.

I've sent an email. I'll post the response when I get it.

> >> "Any more babysitting with essay long messages is counter-productive
> >> to the vast majority of Git users."
> >
> > I think that is what we have advice.* for.
> 
> I don't understand what that means.

It means that some time ago, after many people complained that git did
not give enough hints, we added many hints. Some people who did not need
these hints would want to disable them, and we have the "advice.*"
config options to do so. So we can have a longer message for new users,
and a shorter one for people who do not want to be bothered with the
long advice.

-Peff
