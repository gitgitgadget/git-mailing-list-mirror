From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Sat, 31 Oct 2009 12:32:40 -0700
Message-ID: <7vmy377413.fsf@alter.siamese.dyndns.org>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
 <200910311011.31189.trast@student.ethz.ch>
 <7vr5sj8m5f.fsf@alter.siamese.dyndns.org>
 <20091031182416.GO10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org, sasa.zivkov@sap.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 20:33:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Jh6-0006iD-KH
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 20:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933181AbZJaTcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 15:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933162AbZJaTcu
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 15:32:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155AbZJaTct (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 15:32:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 402CB6E1DB;
	Sat, 31 Oct 2009 15:32:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zpzTG6SowKwOgTznAchyW9pgvA4=; b=DXK6hE
	mC7rKHa+xvAad2TqBr0v1nsO/N3pFBD+9HoGQxLpO0oUNbyp4cPs6ErNl8WHsOzB
	0ufU892o7E8xUxt3NnrlQ7dz1DjfL5Sk+wAYfj0Mo+uIxsdbou0MzkgGLCwTuVag
	4/Z6NQ0lx06TB5ja5WHHulV4q9vqyNyVVy2dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HBXcaq7goIFlypaG9HJwvrbGILMpmtrE
	1s8QnflnMMx6CBH8iTWY0VRDsbTf4W92mRjNGVJ+rEJ1hOocJZyygjkkqfx6ZSYb
	semhA9LYrru5TEiKbo+Bd0M2EKpMqsIFcYKLst8Y2pATWcs+8XIdX7hmahM5hoZj
	tDGEQGcRJnY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E93A66E1D9;
	Sat, 31 Oct 2009 15:32:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A543C6E1D8; Sat, 31 Oct
 2009 15:32:41 -0400 (EDT)
In-Reply-To: <20091031182416.GO10505@spearce.org> (Shawn O. Pearce's message
 of "Sat\, 31 Oct 2009 11\:24\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BA1CCD4-C654-11DE-9DD4-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131850>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> This patch alone breaks tests in the t55?? series quite a lot,
>
> Drop the patch.

Ok, I missed that the unstated goal was "we will eventually drop support
for reading from branches and remotes".  I think it is a worthy goal, but
also agree that should be done at 1.7.0 or 1.8.0 boundary.

If this were Andrew alone, I personally do not think it is such a big
deal.  My understanding is that an eventual goal over there in the kernel
land is to grow 'linux-next' tree even more so that akpm tree will shrink
in the longer term, anyway.  I consulted Andrew in early days while he was
fighting with git to get his scripts to do what he needs them to do, and I
can do that again to bring them up-to-date if necessary.

In order to better support "massive integrator" workflow
that involves interacting with dozens of remote branches, we need to admit
that some of the things you can do if you are set up like Andrew are less
convenient to do via "git remotes" managing .git/config file.  E.g.

    : add new
    $ echo "$korg:/home/rmk/linux-2.6-arm.git#master" >.git/branches/arm-current
    : remove stale
    $ rm -f .git/branches/powerpc
    : find source
    $ grep -r $something .git/branches
    : make random small changes, e.g. change branch name only
    $ vi .git/branches/sparc

and we _might_ need to improve "git remote" interface before dropping
support for reading branches and remotes files.

Admittedly, managing integration trees like -mm and linux-next needs not
just nickname-to-repo-branch mapping but also involves the correct merge
order anyway, and people like Andrew and Stephan Rothwell (linux-next)
maintain a text file to describe them that git does not know about.

E.g. http://linux.f-seidel.de/linux-next/pmwiki/pmwiki.php?n=Linux-next.IncludedTrees

We do not have any infrastructure support for that kind of thing.

To manage 'pu' and 'next', I use specialized scripts (in my 'todo' branch,
look for Reintegrate script) myself, even though the number of topics I
manage is far smaller than what we are discussing here[*1*].  In that
sense, the difference between the remotes sections in .git/config file and
.git/branches/* files is not such a big issue in the larger picture.

As long as we keep the UI to deal with bare URL and branch names from the
command line properly working, the "massive intergrator" workflow might be
better done without _any_ remote definition, either in the config nor
branches/remotes files.  Two integrator scripts might read like these:

	#!/bin/sh
	# fetch-all script
        # fetch from repositories
        failed=
	while read nickname url branch
        do
        	git fetch -q "$url" "+$branch:refs/remotes/$nickname" ||
		failed="$failed$nickname "
	done <merge-order
        test -z "$failed" ||
        echo "Failed to fetch from $failed"

        #!/bin/sh
	# merge-all script
	# git reset --hard remotes/linus-tip
        while read nickname url branch
        do
        	git merge -m "Merge from $url#$branch" "remotes/$nickname" ||
		accept_rerere ||
                break
	done <merge-order

where accept_rerere is something like what my Reintegrate script (in
'todo' branch) has in it.  Then the workflow for the integrator would
become:

  1. to run "fetch-all" once;
  2. reset to Linus's tip of the day;
  3. run "merge-all";
     3.a fix up conflicts;
	 edit && git commit
     3.b decide to drop the day's tree and use previous day's:
	 git reset --hard &&
         git update-ref refs/remotes/$nick refs/remotes/$nick@{1.day}
     3.c decide to drop the tree:
	 git reset --hard &&
         edit merge-order
     and go back to step 3.


[Footnote]

*1* I do not keep a "merge order" file, but existing merges on 'pu' for
that purpose.  The Reintegrate script figures it out by looking at what
was in 'pu'.  One cycle of my git day looks like this, in this order:

    : record what topics are in 'next' and 'pu'
    : 'jch' is a shadow of 'next' that merges all the topics in 'next'
    : on top of 'master'.
    $ Meta/Reintegrate master..jch >/var/tmp/redo-jch.sh
    $ Meta/Reintegrate jch..pu >/var/tmp/redo-pu.sh

    : queue a new topic
    $ git checkout -b xx/topic master
    $ git am -s $patch

    : update a topic
    $ git checkout xx/topic
    $ git am -s $patch

    : fix a topic (that is not in 'next' yet)
    $ git checkout xx/topic
    $ git rebase -i $(git merge-base master HEAD)

    : decide to graduate a topic to 'master'
    $ git checkout master
    $ git merge xx/topic

    : apply directly to master
    $ git checkout master
    $ git am -s $patch

    : update 'next' with what's new in 'master'
    $ git checkout next && git merge master
    : rebuild 'jch' (shadow of 'next')
    $ git branch -f jch master && git checkout jch
    $ sh /var/tmp/redo-jch.sh
    : at this point, 'jch' and 'next' must exactly match

    : add topics that are next-ready to 'jch' and test
    $ git merge xx/topic

    : merge them to 'next' as well
    $ Meta/Reintegrate master..jch >/var/tmp/redo-jch.sh
    $ git checkout next && sh /var/tmp/redo-jch.sh
    : at this point, 'jch' and 'next' must exactly match

    : rebuild 'pu'
    $ git branch -f pu jch && git checkout pu
    $ sh /var/tmp/redo-pu.sh
    : merge new topics
    $ git merge xx/topic
