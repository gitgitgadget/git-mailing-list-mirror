From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Splitting off old history to ancillary repo
Date: Thu, 28 Aug 2008 18:57:57 +0200
Message-ID: <48B6D915.8080706@fastmail.fm>
References: <46a038f90808271940w3aaf5c4ek6329e8066724c778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 18:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYkq3-0007wN-Dy
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 18:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYH1Q6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 12:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbYH1Q6L
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 12:58:11 -0400
Received: from main.gmane.org ([80.91.229.2]:49735 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYH1Q6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 12:58:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYkow-0004ma-Gm
	for git@vger.kernel.org; Thu, 28 Aug 2008 16:58:06 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 16:58:06 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 16:58:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <46a038f90808271940w3aaf5c4ek6329e8066724c778@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94084>

Martin Langhoff venit, vidit, dixit 28.08.2008 04:40:
> A project I've inherited has a codebase ~500KB in size. However, in
> early history some large binary blobs were committed to the repo.
> We've gotten rid of those, and they are not interesting to current
> development. But an initial checkout still has to retrieve 60MiB, when
> I'm sure the recent (and interesting) history fits in less than 1MB.
> 
> What is the state of grafts from a "keeping the repo mostly
> transparently usable for newcomers" POV? Is there a new mechanims I
> should look at?

Do you mean newcomers who have never cloned your repo before?

I see two ways, both involving history rewriting (and therefore problems
for people who cloned already):

- remove those files using filter-branch
This keeps the whole history in one repo but can produce empty commits
(which touched only the removed files).

- split the history using grafts and use filter-branch to make the split
for good
This gives you a split history which you can now put in different repos.
People interested in the full history can pull both and connect the
history using grafts.

I've used both (depending on the use case), both work well.

Michael
