From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 23:53:19 -0500
Message-ID: <20130328235319.299cb494@hoelz.ro>
References: <20130327122216.5de0c336@hoelz.ro>
	<20130327182345.GD28148@google.com>
	<20130327211554.GH28148@google.com>
	<7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
	<20130327174845.5e3081d1@hoelz.ro>
	<20130327230943.GA5204@jtriplet-mobl1>
	<7vfvzfwn55.fsf@alter.siamese.dyndns.org>
	<20130328160937.GD16034@leaf>
	<7vr4iztl3z.fsf@alter.siamese.dyndns.org>
	<20130328190344.GA5361@jtriplet-mobl1>
	<20130328192507.GS28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 05:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULRK3-0001rL-9R
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 05:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3C2ExX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 00:53:23 -0400
Received: from hoelz.ro ([66.228.44.67]:46100 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994Ab3C2ExW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 00:53:22 -0400
Received: from localhost.localdomain (108-234-129-20.lightspeed.milwwi.sbcglobal.net [108.234.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id E4F50280EE;
	Fri, 29 Mar 2013 00:53:20 -0400 (EDT)
In-Reply-To: <20130328192507.GS28148@google.com>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219481>

On Thu, 28 Mar 2013 12:25:07 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Josh Triplett wrote:
> 
> > Related to this, as a path forward, I do think it makes sense to
> > have a setting usable as an insteadOf that only applies to pushurl,
> > even though pushInsteadOf won't end up serving that purpose.  That
> > way, pushInsteadOf covers the "map read-only repo url to pushable
> > repo url" case, and insteadOfPushOnly covers the "construct a magic
> > prefix that maps to different urls when used in url or pushurl"
> > case.
> 
> I hope not.  That would be making configuration even more complicated.
> 
> I hope that we can fix the documentation, tests, and change
> description in the commit message enough to make Rob's patch a
> no-brainer.  If that's not possible, I think the current state is
> livable, just confusing.
> 
> I was happy to see Rob's patch because it brings git's behavior closer
> to following the principle of least surprise.  I am not actually that
> excited by the use case, except the "avoiding surprise" part of it.
> 
> Hope that helps,
> Jonathan
> 

Thanks for all of the input, everyone.  I personally agree with
Jonathon's notion of "principle of least surprise", as I was quite
surprised when my configuration with pushInsteadOf + pushurl did not
work.  However, I also understand Junio's arguments about going back on
documented behavior, as well as whether or not it's a good idea to have
this "triangular" remote set up.

Honestly, if my workflow here is stupid and not "Git-like" and someone
has a better suggestion, I would happy to let my patch go.  Using two
remotes is an option, but to me, using this triangular setup is just
easier.

The only way I see this breaking an existing configuration is if a user
has something like url.user@server.com.pushInsteadOf = myserver:, and
pushurl = myserver:repo/.  If this behavior weren't documented, I would
say that such a configuration works because it relies on a bug, and
should use ssh://myserver:repo/ instead. I personally feel that the fact
that insteadOf + url works and pushInsteadOf + pushurl doesn't is
inconsistent and confusing. However, I am one user of many, and this is
my first exposure to Git from a project contributor point of view.
Therefore, I submit to the wisdom of more seasoned Git developers such
as yourselves. =)

-Rob
