From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 15:47:39 -0700
Message-ID: <7vfx9gnwtw.fsf@alter.siamese.dyndns.org>
References: <20091018144158.GA9789@gandalf.dynalias.org>
 <200910181703.20607.johan@herland.net>
 <20091018152054.GA3956@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzeXZ-0007tZ-34
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 00:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbZJRWro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 18:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbZJRWro
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 18:47:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbZJRWrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 18:47:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CD45E9E9;
	Sun, 18 Oct 2009 18:47:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5m6+Jf0vo2QY9229cimImiZtNLk=; b=hBHfm8jMVdFkmbFRzkxGdDR
	yExRXF/B+b1m7UQnVDghNFdNlOVR10NHI2l2XizAYMNHThFVfaKyejubV1syakYF
	MAZeLezKY0yG+yMPK2h8ilO5rKPsbMuolt/d0JwWLxfoh4BJrkNTydmtuasaTGu+
	omQnvZdz+weyAcw+tazY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=F/bfGRfVvyxajJvWIowJjrkdVnoX+rWB29iTMRT4tRL0t6xg+
	LT16fM4POuK/+FrxsCXM/0E/ThcwxOa+qwFdaOgWKpfKYzhsXw5kuf+kiPhrpdml
	brFIBLoMBI9trQ+5NLirQlRJMzykj4XoGSZ7eMmG/Qtea00hd7ZHibxV+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB8B5E9E8;
	Sun, 18 Oct 2009 18:47:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 615C95E9E4; Sun, 18 Oct
 2009 18:47:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FD5A9DA-BC38-11DE-87C0-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130615>

Norbert Preining <preining@logic.at> writes:

> On So, 18 Okt 2009, Johan Herland wrote:
>> A global, increasing version number ala SVN is fundamentally impossible in 
>> any distributed version control system (like Git).
>
> Yes, agreed. 
>
> The point is that I do not actually need the "distributed" part of git.
> I want one central repository and all collaborators commit to that.
> Yes, that is subversion, I know.
>
> We have no branches, no tags, nothing of that. Only trunk.

No, it is not subversion at all.  Don't say "I know" until you really
know.  Anybody who thinks that is not distributed does not understand
distributedness of git.

Distributedness does _not_ come from not having a central shared
repository, nor not using more than one branch.

Distrubutedness comes the moment any and all of your people can make their
commits _locally_.  And the fundamental lack of "increasing global version
number" is one implication of the distributedness.

Suppose you and Alice collaborate that way.  You make the initial commit,
that is pushed to the central shared repository, and alice clones.

    norb$ git commit -m 'first one'
    norb$ git push
    alice$ git clone $central

Now Norb and Alice share that the 'first one' is the current and only
commit at the tip of their history.  The central repository also shares
that notion.  You work and produce a few commits.

    norb$ edit; git commit -a -m 'second norb'
    norb$ edit; git commit -a -m 'third norb'
    norb$ edit; git commit -a -m 'fourth norb'

while Alice does the same.
    
    alice$ edit; git commit -a -m 'second alice'
    alice$ edit; git commit -a -m 'third alice'

You happened to push first:

    norb$ git push

You and the central repository shares the view of the history in which
the mapping between "revision sequence number" and commits looks like:

    1. first one
    2. second norb
    3. third norb
    4. fourth norb

Imagine what view of the history Alice has at this point and think for a
while.  Recall Alice hasn't pulled from the central repository since she
cloned.  There are two possible things you may want to do.

 #1 Some sequential number is given but that is useless as global
    identifier.

    1. first one
    2. second alice
    3. third alice

 #2 Do not give such sequential number locally; the central repository is
    the _only_ place that assigns such a number.  '?' stands for
    'unnumbered'

    1. first one
    ?. second alice
    ?. third alice

Then Alice fetches from the central and integrates her history with it.
She can do one of two things.  "pull" to create a non-linear history by
merging, or "pull --rebase" to keep the history linear.

Since you are imitating subversion, you may choose the latter route to
rebase, and now the linearlized history would become:

    1. first one
    2. second norb
    3. third norb
    4. fourth norb
    ?. second alice
    ?. third alice

Alice's two commits may stay unnumbered (if you chose #2---no local
versions), or changes from 2/3 to 5/6 (if you chose #1).

If you instead use merges, then there won't be 'sequence' number you can
usefully compare anymore.

                    1 first one
                   /|
  second alice    2 2     second norb
                  | |
                  | 3     third norb
                  | |
   third alice    3 4     fourth norb
                  |/
   fourth alice   5

Scheme #1 inherently cannot give you stable and unique numbers in a
distributed environment where you can commit locally without talking to
the central "number naming authority".  By rebasing, you can keep the
long-term numbering unique (by renaming some new ones), but rebase has its
own downsides besides the name of the commit.

Scheme #2 is a way to get some stablility; give the authority of numbering
to the central repository and commits that haven't hit the central
repository are left unnumbered.  But that is generally not very useful
for your purpose of giving incrementing version number for building (the
developers would want to build for testing before finally committing to
publish the result to the central place).

Running describe using one tag on the 'initial' would give you a rough
equivalent of #1 (i.e. you get tentative numbers on the local commits),
both in the case you rebase (i.e. your numbers change) and you merge
(i.e. you can have more than one "second" commits and numbers are not
unique), which would be the best compromise you can get.
