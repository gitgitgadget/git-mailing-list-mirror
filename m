From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 17:57:37 +0200
Message-ID: <48C7EE71.8080305@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <48C785C3.9010204@gnu.org> <alpine.LFD.1.10.0809100830570.3384@nehalem.linux-foundation.org> <48C7E9A1.5080409@gnu.org> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdS5i-0001Yj-4C
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbYIJP5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbYIJP5n
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:57:43 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:43741 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYIJP5m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:57:42 -0400
Received: by gxk9 with SMTP id 9so14013664gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=VUqXw2xOgnL3nO/LvcNlM0t0clq0Yy7YEdjBW6Y7j8A=;
        b=PUmssjGfcceQgMVsamtE0jMm32fxpTYz/BoKR6h2PuMrLfPSXStP/amADhTYq1B7z6
         POgvi40ax1VtvCS7jS8s7Y3ug411p0+YQNl1644O3/K8v+ZrvBgLvmhmw2hsqYzuvnYS
         2xp0Y3G+hE5++jRzmWJJo+qbEUsLxlKjW9NOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=ax+hByGkgo0r8+VGwBZTQgzN6T0ROTRrGuEZhCyQOWkHnnC3+k7PE1nSQr7XyLQle3
         FjnxMU1M6O8GazH33qGhj4kI14N0pyF77W6FNLRYWdlVQx2+DISmUBUc1R7Fd3ZqUJpd
         fbVj+83hH/qMVAay3/ccsgYZkmbJPozEC2a/k=
Received: by 10.86.60.15 with SMTP id i15mr1108981fga.14.1221062259382;
        Wed, 10 Sep 2008 08:57:39 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id l12sm8777994fgb.6.2008.09.10.08.57.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 08:57:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95537>


> Btw, so far nobody has even _explained_ what the advantage of the origin 
> link is. It apparently has no effect for most things, and for other things 
> it has some (unspecified) effect when it can be resolved.
> 
> Apart from the "dotted line" in graphical history viewers, I haven't 
> actually heard any single concrete example of exactly what it would *do*.

I mentioned git-cherry as an additional use case.  Automatic rename
detection works because it might have the occasional false negative, but
it has practically no false positive, and those are what screws up
merges.  But automatic changeset detection a la git-patch-id has too
many false negatives to make the current implementation of git-cherry
practical, and here's when the origin link comes in.  Also, automatic
changeset detection does not work with reverts, only with cherry-picks.

Blame could also use the origin link to go backwards in the history and
find the origin of the code, without being fooled by reverts.

I'll quote another message I sent in the thread:

>> And why are the notes created by git cherry-pick -x insufficient for that?
> 
> For example, these notes (or the ones created by "git revert") are
> *wrong* because they talk about commits instead of changesets (deltas
> between two commits).
> 
> Why is only one commit present?  Because these messages are meant for
> users, not for programs.  That's easy to see: users think of commits as
> deltas anyway, even though git stores them as snapshots---"git show
> HEAD" shows a delta, not a snapshot.
> 
> And what does this mean for programs?  That they must resort to
> commit-message scraping to distinguish the two cases. (*)
> 
>    (*) A GUI blame program, for example, would need to distinguish
>    whether code added by a commit is taken from commit 4329bd8, or is
>    reverting commit 4329bd8.  (In the first case, the author of that
>    code is whoever was responsible for that code in 4329bd8; in the
>    second case, it is whoever was responsible for that code in
>    4329bd8^).  If recording changesets, you see 4329bd8^..4329bd8 in
>    the first case, and 4329bd8..4329bd8^ in the second, so it is trivial
>    to follow the chain.
> 
> And scraping is bad.  Imagine people that are writing commit messages in
> their native language.  What if they patch git to translate the magic
> notes created by "git cherry-pick -x" or "git revert" (maybe a future
> version of git will do that automatically)?  Should they translate also
> every program that scrapes the messages?
> 
> 
> Whenever there is a piece of data that could be useful to programs (no
> matter if plumbing or porcelain), I consider free form notes to be bad.
> Because data is data, and metadata is metadata.
> 
> If there was a generic way to put porcelain-level metadata in commit
> messages (e.g. Signed-Off-By and Acknowledged-By can be already
> considered metadata), I would not be so much in favor of "origin" links
> being part of the commit object's format.  Now if you think about it,
> commit references within this kind of metadata would have mostly the
> properties that Stephen explained in his first message:
> 
> 1) they would be rewritten by git-filter-branch
> 
> 2) these references, albeit weak by default

(Note to Linus: reinforcement of your disagreement will be implicitly
assumed :-)

> could optionally be
> followed when fetching (either with command-line or configuration options)
> 
> 3) they would not be pruned by git-gc, unlike notes
> 
> 4) possibly, git rev-list --topo-order would sort commits by taking into
> account metadata references too.
> 
> So the implementation effort would be roughly the same.
> 
> But, can you think of any other such metadata?  Personally I can't, so
> while I understand the opposition to a new commit header field that
> would be there from here to eternity (or until the LHC starts), I do
> think it is the simplest thing that can possibly work.

Paolo
