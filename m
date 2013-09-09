From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 16:17:51 -0400
Message-ID: <20130909201751.GA14437@sigill.intra.peff.net>
References: <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908044329.GA15087@sigill.intra.peff.net>
 <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
 <20130908052107.GA15610@sigill.intra.peff.net>
 <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
 <20130908065420.GI14019@sigill.intra.peff.net>
 <CAMP44s3LLHL=oP2PFr4b7VD0dL4yGBOL00O_GWj8eZLrYNM3kg@mail.gmail.com>
 <20130908075046.GL14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 22:18:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7uS-0002NW-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 22:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab3IIUR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 16:17:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:57669 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab3IIURy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 16:17:54 -0400
Received: (qmail 23682 invoked by uid 102); 9 Sep 2013 20:17:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 15:17:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 16:17:51 -0400
Content-Disposition: inline
In-Reply-To: <20130908075046.GL14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234369>

On Sun, Sep 08, 2013 at 03:50:46AM -0400, Jeff King wrote:

> > > If you are interested, I can ask the opinion of some of the GitHu=
b
> > > trainers. They see a lot of new users and have a sense of what ki=
nds of
> > > confusion come up most frequently, what kinds of workflows they t=
end to
> > > see, etc. Their experience may be biased towards corporate-ish us=
ers,
> > > though, because those are the people who pay for training.
> >=20
> > Ask. I'm sure they will tell you doing merges by mistake with 'git
> > pull' is an issue.
>=20
> I've sent an email. I'll post the response when I get it.

Here is what I sent them (I am leaving both my mail and theirs unedited
to avoid any "telephone"-like confusion in trying to summarize):

        Right now, running "git pull" will always create a merge, unles=
s
        the user has specifically configured it to perform a rebase.
        Some people find this problematic, because the project may care
        about the order of merges (e.g., so that --first-parent
        traversals do the right thing), and some users may accidentally
        do "backwards" merges from a main branch into a topic (either
        because they are clueless, or because they simply forgot).

        There is a proposal being considered to have "git pull" do
        nothing by default, but instead ask the user to specify whether
        to merge or rebase (with the option of setting a config value i=
f
        you want it to do one by default).

        One concern I have is that new users may run across this
        relatively early. For example, the first time they "git push"
        and get a non-fast-forward because somebody else has already
        pushed, git suggests to run "git pull". At which point they wil=
l
        have to decide whether to merge or rebase. So what I'd like you=
r
        opinions on is:

          1. Do new users have trouble with the concept of rebase vs
             merge?  How would they handle this change of behavior?

          2. Do new users have trouble with rebases in general? There
             are some complications over doing a normal merge, but I
             don't know how often they trip people up in practice.

And the responses I got were:

        1. New users definitely have trouble distinguishing between
        rebase and merge. Even people who have been using Git for a
        while on a basic level are sometimes confused by this.

        2. Most people we teach=E2=80=94even the ones who have been usi=
ng Git
        for a while=E2=80=94don't know what a rebase is at all. They've=
 heard of
        it, but they don't get it. It takes careful explanation to get
        the concept across and explain why it is not the same thing as =
a
        merge.

        Speaking for myself, about half of the time in the Foundations
        class I'll explain `pull --rebase` and `branch.autosetuprebase`=
=2E
        (Whether we get to it depends on class interest and ability.)
        When we do address that topic, we always recommend that
        rebase-on-pull is the right thing to do, since the merges Git
        creates are just noise that makes history hard to work with in
        the ways you have pointed out. (For smart classes, I like to
        make the analogy of Git to a distributed database, and point ou=
t
        how the merge on pull is just Git's mechanism for resolving
        split-brain writes. I explain that those merges aren't a
        deficiency in Git; they're just what has to happen by default.
        The fact that Git handles split-brain writes so well by itself
        is amazing.)

        My input would be to continue to have `pull` merge by default.
        Those merges aren't great, but new users won't have any idea ho=
w
        to make a decision about them at that point. As it is, it just
        works, and it works quite elegantly. Once you start to learn
        some things, you can tune Git up to work even more elegantly by
        rebasing, but having to understand that concept and make a
        decision on your first (or second or third or twentieth) pull i=
s
        probably asking too much.

and:

        Just a few more elements to add:

        * I have been teaching rebase and what it means in _some_ of my
        Git Foundations classes as of late.  But "some" means there are
        a majority that do not get it.

        * These are the people that get "formal" training on Git.  What
        about all the newbies?  They really won't have a foundation for
        what these two "flavors" mean.

        * The merge is very different from what Subversion presents as =
a
        default.  That's a possible point in the "option's favor."

        * In the end though, the "simplest thing that works" should be
        the default without a choice.  To me, a choice implies knowledg=
e
        of the benefits of each option.  I would say that the majority
        of our Git students do not, at the beginning of Git usage,
        understand the difference.

I did not specifically ask in the original about whether backwards
merges were a problem, though I think that is touched on in the
responses.

If you'd like me to ask something specifically, I can relay the
question, or I can ask them to come join the discussion here.

-Peff
