From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Sun, 7 Jan 2007 19:50:27 -0800 (PST)
Message-ID: <257061.93025.qm@web31801.mail.mud.yahoo.com>
References: <1168134747394-git-send-email-jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jan 08 04:50:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3lWu-0008L8-VB
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbXAHDu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbXAHDu2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:50:28 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:43801 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030478AbXAHDu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 22:50:28 -0500
Received: (qmail 94370 invoked by uid 60001); 8 Jan 2007 03:50:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=e6I1DebOOoiF7z28xs06kUwe7dRp0bBqVGracz/i87jaFz4h7xc6KTtxyp3nDnT55vPGDaJpQZ7r7DynU2SOoTtpkgCdtvedgWfdfjLDoLrKfBUqAD0rPGled9OwnQaTSYkvBWuBhupZ17GAh2+GyaIUMb7fGhxVGd3LDX3HUM8=;
X-YMail-OSG: w0.RTz8VM1lG6C98yqkp396S5EG4AxhuRuZ7AL1XdKrKz6VtxVeN_3iV0NjaeiXJGdyuEx8S1P4naFbLXsVF1y1Qrv4KEpBQhxh.Bo.TTm249BE0yhR.N8WmEq99RjA7XRF6UsMVK41tPn4nitQAfCwj6_etT.J0zqflrzo2jw4wZs3LtFJwwKsl
Received: from [71.80.230.185] by web31801.mail.mud.yahoo.com via HTTP; Sun, 07 Jan 2007 19:50:27 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <1168134747394-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36235>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > gitweb has two bugs in git_patchset_body (now you know who
> > you are without data-mining with git-blame).
> > 
> > The first bug is a missing "</div>" on commitdiff.
> > Saw this one a couple of days ago, but was swamped
> > and had no time to post.
> 
> Could you please provide either minimal example from
> scratch, or parameters for git.git repository view, or
> an URL? I could not reproduce this...

I cannot post a URL to the repo for many reasons.
I don't have time to allocate to trying to define a test
case from scratch, nor am I certain that I can attain that,
since that would be a trivial bug to fix and am sure that
it would've been caught.  But as a heavy git user in a complex
(git) environment, the limits and corner cases are sometimes hit.

I cannot suggest anything other than using git professionally
in a complex environment, as opposed to being a pastime.

I also understand that it is a fine line of separating the two,
and it would appear that the former group not always has the time
and the latter not always has the complex environment to hit
the corner cases.

> > The second bug is displaying a renamed file with the
> > same name as the one of the preceding "patch". Saw
> > this one today when I pulled.
> > 
> > To exhibit these, you need to "commitdiff" a commit
> > which has at least one rename and at least one regular
> > diff preceding the rename.
> 
> Haven't found this one, but I hope one of those patches
> would fix this.

I hope so too.

> > "And while at it" can you please actually *do* "refactor"
> > git_patchset_body *into smaller functions each one doing
> > a single particular task*.
> > 
> > It is sad to see git_patchset_body in such despicable state
> > all the while seeing words like "refactor" in the commit logs
> > of that function.
> 
> (Perhaps I overuse word "refactor").

Perhaps.  Or maybe it is used incorrectly.

> > git_patchset_body is grossly overloaded for what it is
> > supposed to do to, and being one single huge blob, it is
> > hard to maintain.
> 
> I'm not sure if splitting git_patchset_body into smaller functions
> would be worth doing, as 1) such functions would be used only
> by git_patchset_body, 2) quite I bit of info has to be passed.

When things get too complex, they should be done out of
principle, not out of "how I feel about it", since principles
can be proved and what they define can be easily tracked.

Yes, it is worth doing.  It doesn't matter that those smaller
functions would be used only by git_patchset_body, when
(by principle) the workings, logic and justification would
be clearly exposed by those smaller units of function.  Thus
it would be possible to prove that the function is correct
or not, and bugs would be able to be isolated easily.

Smaller units of function should do one thing and do it well.
If you cannot isolate them "because quite a bit of info has
to be passed" then the logic of git_patchset_body is faulty,
by _definition_, and needs to be scrapped and re-engineered
(from scratch).

   Luben
