From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 09 Sep 2008 08:44:43 -0700 (PDT)
Message-ID: <m3zlmhnx1z.fsf@localhost.localdomain>
References: <20080909132212.GA25476@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue Sep 09 17:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd5Pg-0005Nv-0i
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 17:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbYIIPos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbYIIPos
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 11:44:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:53593 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbYIIPor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 11:44:47 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2160454wri.5
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=l8J6dOXTnv+Dx+usbYYwbrjJoFxcc8U7+T8EYSRwgrE=;
        b=iyKCjZRYwMOI2pSh9sGhkW2xiohvkqHcajjd8b1/0HgVIx3oejnY8tRTMHF3gglN6w
         ntgqyvbpbiBQT52ZOhlMnotw1zQCYYX+RRBKwiu8+/CSZpTC+uGGZ11FrVtWWnt8fKca
         lnC1zu4Xep677Zk4F1v1LGOo3BeSoOEoTKCYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=sEj4PcXmlBj6GEGM2coOcP3/HEWbPFdDP6NE5Y8TJ1ItQm53Jp5kcpgkCAPEXiQN+y
         +GcMlPGYTCd5SrP7+oBw4syvjUlgMhbcOpPPBCPyaAH+5vF0FBsqXHZa5Y0y7VMIYu6S
         /2ziU7W2BkI6xL+HBxLrMZibBoJp0GQCwBTPc=
Received: by 10.86.4.2 with SMTP id 2mr1747fgd.21.1220975084665;
        Tue, 09 Sep 2008 08:44:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.219])
        by mx.google.com with ESMTPS id 3sm6058413fge.3.2008.09.09.08.44.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 08:44:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m89FifgF026100;
	Tue, 9 Sep 2008 17:44:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m89FieK4026097;
	Tue, 9 Sep 2008 17:44:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080909132212.GA25476@cuci.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95401>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> I've read and digested the old threads about prior and related links.
> Here's a new proposal which should be able to pass muster, if I read all
> the relevant suggestions and objections in the old threads:
> 
> Consider an origin field as such:
> 
> commit bbb896d8e10f736bfda8f587c0009c358c9a8599
> tree b83f28279a68439b9b044bccc313bbeaa3e973f5
> parent ed0f47a8c431f27e0bd131ea1cf9cabbd580745b
> origin d2b9dff8a08cc2037a7ba0463e90791f07cb49dd
> origin a1184d85e8752658f02746982822f43f32316803 2
> author Junio C Hamano <gitster@pobox.com> 1220132115 -0700
> committer Junio C Hamano <gitster@pobox.com> 1220153445 -0700
> 
> The definition of the origin field reads as follows:
> 
> - There can be an arbitrary number of origin fields per commit.
>   Typically there is going to be at most one origin field per commit.

I understand that multiple origin fields occur if you do a squash
merge, or if you cherry-pick multiple commits into single commit.
For example:
 $ git cherry-pick -n <a1>
 $ git cherry-pick    <a2>
 $ git commit --amend        #; to correct commit message

I'm not sure if you plan to automatically add 'origin' field for
rebase, and for interactive rebase...
 
> - At the time of creation, the origin field contains a hash B which refers
>   to a reachable commit pair (B, B~1).  If B has multiple parents and the pair
>   being referred to needs to be e.g. (B, B~2), then the hash is followed by
>   a space and followed by an integer (base10, two in this case),
>   which designates the proper parentnr of B (see: mainline in git
>   cherry-pick/revert).

I think you wanted to use "(B, B^2)", which mean B and second parent
of B.  B~2 means grandparent of B in the straight line:

      ... <--- B~2 <--- B^1 = B^ = B~1 <--- B
                                           /
                          ... <--- B^2 <--/

Besides I very much prefer using 'origin <sha1> <sha2>' (as proposed
in the neighbouring subthread), which would mean together with
'parent <parent>' (assuming that there are no other parents; if they
are it gets even more complicated), that the following is true

  <current> ~= <parent> + (<sha2> - <sha1>),

where '<rev1> ~= <rev2>' means that <rev1> is based on <rev2> (perhaps
with some fixups, corrections or the like).  Perhaps 'origin' should
be then called 'changeset'.

It would also be easier on implementation to check if
'origin'/'changeset' weak links are not broken, and to get to know
which commits are to be protected against pruning than your proposal
of

  origin <"cousin" id> [<mainline = parent number>]

where <mainline> can be omitted if it is 1 (the default).


This can also lead to replacing

  origin <b> <a>
  origin <c> <b>

by

  origin <c> <a>

for squash merge, or squash in rebase interactive.

> - In an existing repository gc/prune shall not delete commits being
>   referred to by origin links.
> 
> - During fetch/push/pull the full commit including the origin fields is
>   transmitted, however, the objects the origin links are referring to
>   are not (unless they are being transmitted because of other reasons).
> 
> - When fetching/pulling it is optionally possible to tell git to
>   actually transmit objects referred to by origin links even if it would
>   otherwise not have done so.
>
> - git fsck will traverse origin links, but will stay silent if the
>   object an origin link points to is unreachable (kind of like a shallow
>   repository).

The above means that it is a 'weak' link, i.e. it is protecting
against pruning (perhaps influenced by some configuration variable),
but it is not considered an error for it to be broken.

> - git cherry-pick/revert allow for the creation of origin links only if
>   the object they are referring to is presently reachable.

Errr... shouldn't objects referenced by 'origin' links be reachable in
order for "cherry-pick" or "revert" to succeed?

On the other hand this leads to the following question: what happens
if you cherry-pick or revert a commit which has its own 'origin'
links?

> - git rev-list --topo-order will take origin links into account to
>   ensure proper ordering.

What do you mean by that?
 
> - gitk allows for (e.g.) dotted lines to show the origin links.
> 
> - git log would show something like:
> 
>   commit bbb896d8e10f736bfda8f587c0009c358c9a8599
>   Origin: d2b9dff..53d1589
>   Origin: a1184d8..e596cdd
>   Author: Junio C Hamano <gitster@pobox.com>
>   Date:   Sat Aug 30 14:35:15 2008 -0700
> 
>   Note that for easy viewing: git diff d2b9dff..53d1589
>   will show the exact diff the origin link is referring to.
> 
> - git log --graph will show a dotted line of somesort just like gitk.

That is I guess the whole and main reason for 'origin' links to exist,
as having this information in free-form part, i.e. in the commit
message might lead to problems (with parsing and extracting, and
finding spurious links).
 
> - git blame will follow and use the origin link if the object exists.

Hmmmm... I'm not sure about that.

> - git merge disregards the whole origin field entirely, just like all
>   the rest of git-core.

Unless of course one uses more complex merge strategy, which doesn't
take into account only endpoints (branches to be merged and merge
bases), but is also affected in some by history...
 
> Anything I missed?

How would git-rebase make use of 'origin' links.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
