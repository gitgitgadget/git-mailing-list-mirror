From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: New way of tracking remote branches -- question
Date: Mon, 8 Jan 2007 23:45:09 -0800 (PST)
Message-ID: <524590.40333.qm@web31802.mail.mud.yahoo.com>
References: <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 08:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4BfY-0004cu-Ih
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 08:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbXAIHpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 02:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbXAIHpM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 02:45:12 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:41824 "HELO
	web31802.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751134AbXAIHpK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 02:45:10 -0500
Received: (qmail 43011 invoked by uid 60001); 9 Jan 2007 07:45:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Lv+FzDdW+Omr0CC777T8XNSHAvg2JQntax2U+tUeMA93bHiUBO0wvgpcZbJ1utl+8mJFA6O5VVTYRDMt2Bf5ZQkOTgXt77VhjCx/YPdTghOzoRTOHXwQWECUAsylLO2ApPW6xaFqOfG/GWEGRMS5XP1WKGn+T1xNMZlrAfl3VVo=;
X-YMail-OSG: .JzdDL8VM1lmlBM9IbPV8OngVMpsuKuKqOWfmDuu7OnCxaMrM.47NZMow8x1F_1TDSLll_ch8zGiMWaBvovLXgsNFJXwjXDLrMPiT7QDuSUDFjVBr_CY8oqU8CvgAl2yUyWFXcTNI8P9jA9CJKjkIP.c9eClIaCv5xzZUpBYR3jIfk2eTnoPTODg
Received: from [71.80.231.208] by web31802.mail.mud.yahoo.com via HTTP; Mon, 08 Jan 2007 23:45:09 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36323>

> Junio C Hamano <junkio@cox.net> writes:
> 
> If you wanted to do _ANY_ development on top of it (even if that
> was just to set '#define DEBUG 1'), however, you would need to
> branch off of it, say "git checkout -b my-next next", so the
> above inconvenience is arguably very minor.  On the other hand,
> the downside are the pollution of your own heads/ namespace
> (having your forked branch and remote tracking branch means
> heads/ would have next and pu from me and my-next and my-pu you
> work on), and some people are not as careful and disciplined as
> you are and have made mistakes of committing their own changes
> while on such remote tracking branches (you can call the latter
> part "newbie protection").  The next 'git fetch', especially
> when it was forced _and_ was done while on 'next', was rather
> unpleasant.  Of course, discipined people like you and me would
> never do that, but we are not the only two people in the
> universe ;-).

LOL, I love your sense of humor here! :-)

> The issue of "checking the tracking branch out to look-and-see"
> is going to be addressed by the upcoming detached HEAD support,
> so personally I do not think it will be a huge problem.  You
> would have to say "git checkout origin/next" for it with the new
> layout.

I guess, what I want is still to be able to "see" remotes/
when I do "git branch".

Sometimes I don't care to check out the remote branch, I just
want to rev-list it.  Sometimes I do check it out so I can
take a look and when I pull, I do the required reset, but
as you said above :-) this requires discipline.

And of course if I want to do my own development, I branch
off, as I've done with "next", and never forget to "git-pull . next"
after I pull from you.  Again this requires discipline.

But what I appreciate in git, is this discipline.  The fact that
I'm in control of it and that I have to do it -- keeps my mind sharp.

I really think that the line separating porcelains from git
should be drawn at some point.

I think that this "automatic merge/newbie protection" policy,
should've been well suited to porcelains as opposed to
git.

> Another thing the separate remote gives us is to make it easier
> to interact with more than one remote, by having a new directory
> next to remotes/origin/ directory.  If you used the traditional
> layout, your heads/ namespace would explode because you would
> have to have something like:
> 
> 	heads/origin		-- from linux-2.6's master
>         heads/origin-libata	-- from jgarzik libata ALL
> 	heads/origin-sii-lbt	-- from jgarzik libata sii-lbt
>         ...
> 
> in a flat namespace intermixed with your own development
> branches, instead of:
> 
> 	remotes/origin/master	-- from linux-2.6's master
>         remotes/libata/ALL
>         remotes/libata/sii-lbt
> 	...
> 
> grouped together by where they come from (and they cannot
> possibly be mucked around directly thanks to being in remotes/
> hierarchy), separated from any of your own development branches
> that are in heads/.

I don't mind this at all, as long as I get to "see" it, when
I do normal git operations, like "git branch".

So maybe we should take it one step at a time and first
implement that, still exposing it to "git branch" and then
if porcelains want to establish a policy on top of this,
that's fine.  But low-level git should not hide this from me.

    Luben

> Also, this is only about the default layout clone makes, and the
> refs are not packed, so you can easily move remotes/origin/*
> (except 'HEAD') to heads/ immediately after making a clone and
> set up remotes.*.fetch configuration to match the traditional
> layout if that is what you find more convenient.  The operation

I do find that more convenient, but wouldn't like to have
to do that, nor to have a script that does it for me to have
to do it after I clone.

It would be most convenient when this per-repo layout is
implemented, yet I get to see this when I do "git-branch".

I guess, most convenent, yet "newbie-protection" would be
to disallow any commits to remotes/* in this way... I'd opt
for that wholeheartedly.

     Luben
