From: David Chanters <david.chanters@googlemail.com>
Subject: A note from the maintainer: Follow-up questions (MaintNotes)
Date: Sun, 30 Aug 2009 23:19:22 +0100
Message-ID: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 00:19:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhskE-0003W0-Rd
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 00:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZH3WTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 18:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbZH3WTW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 18:19:22 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:64209 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbZH3WTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 18:19:21 -0400
Received: by ewy2 with SMTP id 2so3540522ewy.17
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=yWkXDcsnPG1IB5ck3BbcNtvwH1BVlGL8HNcQvYFu+nY=;
        b=jO8k4M+ev3pRusnmDdyMqJHenKkQGIFMFTxWLlf0+KsLGemVZVrdQGFvkY9ixbfNKh
         BDNmZntn37pfOIDy6qCWb2ZQy8Jo/BST9ZYL3rj24DqDifBMLestRwiHSB1dDMgfAPpb
         AFwlh8rhTNAJytOi9URLXiFWqQY3h9ypEZzmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=WZzcwecDQWkjjHzMQV8I0HcGGJTJIEHKvdgoTH7g39kCCWlCLcyjJQ51d7nXce0hER
         jgylENnENtQkhpE/qkiRGnue9xdZk7qr0HLYnyA2D4rEjArNFD1lDo/5qgQo9hWnQyx4
         WODQe6JLUAtu5yNjNo8H3wgMqSPzN2XLj1AOs=
Received: by 10.216.85.82 with SMTP id t60mr802019wee.14.1251670762133; Sun, 
	30 Aug 2009 15:19:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127442>

Hi,

[Please retain a Cc back to me as I am not currently subscribed to the
mailing list.]

I've recently been intrigued with workflows, and have read quite a bit
about them, including various references on git-scm.com,
gitworkflows(7), and the email "A note from the maintainer" which I
have some questions on.  I'll paste random quotes from that and just
ask my question, I think, so apologies up front of it reads a little
disjointed.

I'd often wondered when I have read various posts of the git mailing
list on gmane, just how it is I am supposed to track:

dc/some-topic-feature

... Junio, are these topic branches ones you actively have somewhere
in your own private checkout?  Yes, I appreciate that when I read a
given post to the mailing list, you or other people will sometimes
make reference to these topic branches, but what do I do if I am
interested in finding out about one of them?  Indeed, perhaps even
before getting to that question, how do you go about creating and
maintaining these topic branches -- are you making heavy use of "git
am"?

I ask because of the following snippet from "MaintNotes":

    The two branches "master" and "maint" are never rewound, and
    "next" usually will not be either (this automatically means the
    topics that have been merged into "next" are usually not
    rebased, and you can find the tip of topic branches you are
    interested in from the output of "git log next"). You should be
    able to safely track them.

I am not sure if there's any real use-case for this, but I will ask
anyway:  is the above saying that I am able to *checkout* one of these
topic-branches just from their presence in "next" alone?  I appreciate
that the point is somewhat moot since the topic branch has already
been merged into "next", but I can surely see this as a really useful
way for people to manage topic-branches in a shared environment:
people can simply pick a topic branch out from the integrated one --
in this case "next".  Or is this idea a complete waste of time?

To continue:

    The "pu" (proposed updates) branch bundles all the remainder of
    topic branches.  The "pu" branch, and topic branches that are
    only in "pu", are subject to rebasing in general.  By the above
    definition of how "next" works, you can tell that this branch
    will contain quite experimental and obviously broken stuff.

I'm obviously missing something here -- but why is rebasing these
existing topic branches (I assume on top of "pu") more useful than
just merging them into "pu" -- like you do with "next"?

    When a topic that was in "pu" proves to be in testable shape, it
    graduates to "next".  I do this with:

            git checkout next
            git merge that-topic-branch

    Sometimes, an idea that looked promising turns out to be not so
    good and the topic can be dropped from "pu" in such a case.

Ah -- so if I have this straight in my head -- you continually form
the local topic-branch on its own branch, and then just merge it into
"next" only when you know that topic branch is satisfactory?  That
being the case -- again, I assume the use of "git am" for the topic
branch?  If regular readers of the git mailing list wish to track this
topic branch, can they do so from you only until it's merged into
"next"?

And a related question:  If you decide a given topic in pu is declared
to "be dropped", is this done by rebasing (as you mentioned earlier)
so as to remove any trace of the topic branch ever having been in
"pu", or am I reading too much into "dropping" here?  :)

I hope these aren't too idiotic.

Thanks all in advance.

David
