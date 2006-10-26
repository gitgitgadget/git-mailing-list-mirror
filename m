X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Vincent Ladeuil <v.ladeuil+lp@free.fr>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 18:04:50 +0200
Message-ID: <87k62n5ahp.fsf@alplog.fr>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 16:05:11 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 26 Oct 2006 08:05:36 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 26 Oct 2006 16:04:51.0226 (UTC) FILETIME=[77DECFA0:01C6F918]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30231>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd7j5-0005EJ-If for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423584AbWJZQFA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423597AbWJZQFA
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:05:00 -0400
Received: from mailhost.altair-tech.com ([217.167.26.75]:48093 "HELO
 srv-mail.altest.fr") by vger.kernel.org with SMTP id S1423584AbWJZQE6 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 12:04:58 -0400
Received: from dune.altest.fr ([10.0.0.145]) by srv-mail.altest.fr with
 Microsoft SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 18:04:51 +0200
Received: by dune.altest.fr (Postfix, from userid 1000) id 123562DD11; Thu,
 26 Oct 2006 18:04:51 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

    Linus> On Thu, 26 Oct 2006, Vincent Ladeuil wrote:
    >> 
    >> Ok, so git make a distinction between the commit (code created by
    >> someone) and the tree (code only).
    >> 
    >> Commits are defined by their parents.

    Linus> Commits are defined by a _combination_ of:

    Linus>  - the tree they commit (which is recursive, so the
    Linus>  commit name indirectly includes information EVERY
    Linus>  SINGLE BIT in the whole tree, in every single file)

And here you keep that separate from any SCM related info,
right ?

    Linus>  - the parent(s) if any (which is also recursive, so
    Linus>  the commit name indirectly includes information about
    Linus>  EVERY SINGLE BIT in not just the current tree, but
    Linus>  every tree in the history, and every commit that is
    Linus>  reachable from it)

    Linus>  - the author, committer, and dates of each (and
    Linus>  committer is actually very often different from
    Linus>  author)

    Linus>  - the actual commit message

    Linus> So a commit really names - uniquely and authoratively
    Linus> - not just the commit itself, but everything ever
    Linus> associated with it.

Thanks for the clarification. But no need to shout about EVERY
SINGLE BIT, the pointer to BDDs was already talking a bit about
bits :) 

But I agree, this is the important point that may be missed.

    >> Trees are defined by their content only ?

    Linus> Where "contents" does include names and
    Linus> permissions/types (eg execute bit and symlink etc).

Which can also be expressed as: "Everything the user can
manipulate outside the SCM context", right ?

    >> If that's the case, how do you proceed ? 

    Linus> If you compare the commit name, and they are equal,
    Linus> you automatically know

    Linus>  - the trees are 100% identical
    Linus>  - the histories are 100% identical

And that's the only info you can get, no ordering here. (Just
pointing the obvious, as soon as you try to put more info into
the signature, the equality will vanish).

But for various optimizations this equality property is the only
needed one.

Do we agree ?

    Linus> If you only care about the actual tree, you compare
    Linus> the tree name for equality, ie you can do

    Linus> 	git-rev-parse commit1^{tree} commit2^{tree}

    Linus> and compare the two: if and only if they are equal are
    Linus> the actual contents 100% equal.

Actually, that's backwards:

"their actual contents are equal" implies "their signatures are
equal".

But, two totally different trees can have the same signature.

My god ! What an horror ! Not. I even wonder if I will live so
long as to see it occurs... So we *can* pretend that:

"theirs signatures are equal" is equivalent to "their contents
are equal"

And that's all we care :)

But I digressed, the question was about a detail on your tree
definition, once the signature is defined to be unique (as in
canonical), the property of comparing the signatures as if they
were the objects themselves follows. Thanks for the confirmation.

    >> Calculate a sha1 representing the content (or the content
    >> of the diff from parent) of all the files and dirs in the
    >> tree ?  Or from the sha1s of the files and dirs themselves
    >> recursively based on sha1s of the files and dirs they
    >> contain ?

    Linus> The latter. 

Thanks for providing the clarification. So of course, finding the
differences between the trees is quick, you can prune anywhere
the signatures equality is verified.

    >> I ask because the later seems to provide some nice effects
    >> similar to what makes BDD
    >> (http://en.wikipedia.org/wiki/Binary_decision_diagram) so
    >> efficient: you can compare graphs of any complexity or size in
    >> O(1) by just comparing their signatures.

    Linus> This is exactly what git does. You can compare entire
    Linus> trees (and subdirectories are just other trees) by
    Linus> just comparing 20 bytes of information.

I understand that, years ago even. I have a bit of practice with
BDDs and I am accustomed to that so lovely property. But without
that practice, I think most people will just wonder...

<snip/>

    Linus> And the reason it's fast is that we can compare 20,000
    Linus> files (names, contents, permissions) by just comparing
    Linus> a _single_ 20-byte SHA1.

Yeah, let's go further ! We can compare gazillions of files and
their history since epoch by comparing _two_ signatures ! :-)

    Linus> In git, revision names (and _everything_ has a
    Linus> revision name: commits, trees, blobs, tags) really
    Linus> have meaning. They're not just random noise.

I know that effect, but I understand people complaining that they
*look* like noise. 

I'm still searching a parallel in nature, but the best I could
find is DNA, ever look at a DNA ? 

Looks like noise no ? No ordering either between parents and
children... But there is a way to identify a parent from the DNA
of a children...

