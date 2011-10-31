From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 16:30:59 -0400
Message-ID: <20111031203059.GJ16825@thunk.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyVi-0001Rp-08
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002Ab1JaUbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:31:05 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50736 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933617Ab1JaUbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 16:31:03 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RKyVY-0000wG-TW; Mon, 31 Oct 2011 20:31:00 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RKyVX-0008ML-QB; Mon, 31 Oct 2011 16:30:59 -0400
Content-Disposition: inline
In-Reply-To: <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184522>

(removing linux-ide and linux-kernel)

On Mon, Oct 31, 2011 at 11:23:55AM -0700, Junio C Hamano wrote:
> On the other hand, the consumers of "Linus kernel" may want to say that
> they trust your tree and your tags because they can verify them with your
> GPG signature, but also they can independently verify the lieutenants'
> trees you pulled from are genuine. Keeping signed tags and publishing them
> is one way to make it possible, but 400 extra tags in 3 months feels like
> an approach with too much downside (i.e. noise) for that benefit.

I wouldn't put it as "we don't trust Linus's tree", because it's not
true.  In general, we do trust Linus's tree.  On the other hand, it's
useful if the proof which was submitted at the time of the push could
be verified by third parties.

Suppose the project wasn't Linus, but some other project, say, a
hypothetical Desktop system called Troll3.  Let's assume that it's run
by a sole dictator, S. Crew Powerusers, who blindly assumes that any
tree on github is secure, and is confident he or she can detect social
engineering attacks caused by a bad guy grabbing a developer's SSH key
used to push to github, and who can fake a pull request to Linus that
looks real but is really originated by the bad guy.  Let's assume
further that the pull request has a signed tag which could be used to
detect such forgeries, but because Mr. Powerusers can't be bothered to
check the tag, because he can't figure out how to update his GPG
keyring and besides, he hates crypto stuff --- and the bad guys know
this, and are good (Kevin Mitnick or better) at social engineering
attacks.

In this sort of scenario, it's useful if *other* people could
independently verify the Troll3 git tree via the crypto signatures,
even though the central maintainer couldn't be bothered to check the
crypto signatures.


Here's an idea.... what if the "signed push" information could be
embedded into the merge commit's description?  That is, the
information could sent via a signed git tag, or some other mechanism,
but then part of the git merge would incorporate the GPG signature
into the merge commit's description field (and we could always create
a merge commit so there's a place to put the digital siganture).  That
way, it's mostly out of the way, but it's in a well-defined place
where it will always easy to have a third party independently verify
the source of a set of commits in the git tree.

The problem with notes and tags is that they have to be pushed
separately, and might get lost; where as if they are stored in the
merge commit's description, they will always be there.

							- Ted
