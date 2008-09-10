From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 01:09:06 +0200
Message-ID: <20080910230906.GD22739@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 01:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYpF-0005JC-EN
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 01:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYIJXJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 19:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYIJXJI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 19:09:08 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:40532 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbYIJXJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 19:09:08 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B16A55465; Thu, 11 Sep 2008 01:09:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95567>

Linus Torvalds wrote:
>On Wed, 10 Sep 2008, Stephen R. van den Berg wrote:
>> But then how would someone who clones the repository get at the information?

>You just said it wouldn't get there with fetches.

True and still valid.

>If clone acts differently from a "full" fetch, something is really really 
>wrong.

It does not act differently.

Let me elaborate:

- The origin field is part of the commit (and only present if
  *consciously* added by the committer), and therefore is transmitted
  along with the rest of a commit upon a fetch.

- The commits being referred to by the origin field are *not*
  transmitted upon a fetch.

- Given a repository with 4 long lived published branches called A, B, C and D
  and a backport from development branch D cherry-picked -o into branch A
  which creates an origin field pointing back to (D^,D^^)

- Now you fetch just branch A from this repository.  This will not cause
  branch D to be pulled in as well.

- However, if you explicitly pull D, the origin information from A to D can
  be used.  People doing a generic clone get all four branches, and
  therefore have all the important commits which normally could contain
  origin links.  Note that even during a clone, commits pointed to by
  origin links are not being transmitted (unless there already are other
  reasons to send them along).

>> The information is essential to understand backports between the various
>> stable branches.

>No it's not. You can mention the backport explicitly in the commit 
>message, and then you get hyperlinks in the graphical viewers. That works 
>when people _want_ it to work, instead of in some hidden automatic manner 
>that does entirely the wrong thing in all the common cases.

Could you spell out one of the common cases where it would do entirely
the wrong thing?
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
