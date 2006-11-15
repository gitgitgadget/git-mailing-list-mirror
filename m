X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 05:08:52 +0100
Message-ID: <20061115040852.GL7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 04:09:15 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31409>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkC53-0006C8-Th for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966506AbWKOEIy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966566AbWKOEIy
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:08:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10916 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S966506AbWKOEIx (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:08:53 -0500
Received: (qmail 23430 invoked by uid 2001); 15 Nov 2006 05:08:52 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 01:31:50AM CET, Junio C Hamano wrote:
> Carl Worth <cworth@cworth.org> writes:
> 
> > On Tue, 14 Nov 2006 20:47:07 +0100, Petr Baudis wrote:
> >> Hmm, did they (not) consider Cogito? They wouldn't have those issues.
> >
> > I didn't ask.
> >
> > Frankly, I don't see a lot of value in the git/cogito split right now.
> > ...
> > It's great that git is written in a script-friendly way so that new
> > interfaces can be built on top of it. And I think the benefits of new
> > user interfaces are clear when they work in fundamentally different
> > ways, (say, being operated through a GUI). But where git and cogito
> > are both command-line utilities and have the same basic functionality,
> > ...
> > There are some things that cogito does that git does not that I would
> > like to have in git.
> > ...
> > I don't see any defining difference that justifies cogito's
> > existence ("hide the index" maybe? let's just hide it a tiny bit more
> > in git). And I would like to help work to get the remaining good
> > stuff that has been proven in cogito---to get it pushed down into git
> > itself.
> 
> I am of two minds here.
> 
> I do not think the Porcelain-ish UI that is shipped with git
> should be taken with the same degree of "authority" as git
> Plumbing.
..snip passage about workflows..

Controversy's fun, so...

<Cogito maintainer hat _off_> (But yeah, it still looks silly that I'm
saying this.)

 From the current perspective, I think it has been a mistake that the
porcelain and plumbing was not kept separate in independent packages,
and perhaps even maintained separately (and perhaps not; at least having
a single tree with plumbing/ and porcelain/ directories and separate
packages in distributions might already help something), so that "git"
would be kept as a kind of library and then there would be a separate
package providing an interface to it. Or you could select one of several
packages. Not only would that make Cogito prevail in the world and bring
me a flood of marriage proposals, but look at how would it help the
general public:

  (i) Clearly divided porcelain/plumbing interface, so that you can
really isolate the two UI-wise; endless confusion reigns there now. Is
git-update-index porcelain or plumbing? _You_ call git-merge a proper
porcelain? From my perspective, git-update-ref is as plumbing as it
gets, but it's classified as porcelain. Etc, etc. This would be by far
the most important advantage.

  (ii) The plumbing and porcelain would not share the same namespace,
leading to clearer UI. (I'm just inflating (i).)

  (iii) The documentation would not be a strange mix of porcelain and
plumbing. (More (i) inflation.)

  (iv) (i) is troublesome because I have a feeling that Junio declared
several times that he doesn't care that much about stable API for
porcelain compared to the plumbing. But with the current mix it's
desirable to use some porcelain even in other porcelains and in scripts.

  (v) Git would be properly libified by now. If you wanted to convert
bits of porcelain to C, it would be at least much higher priority.

  (vi) You wouldn't need to make the gruesome choice on what is the
canonical workflow the _the_ Git porcelain supports (see the snipped
passage). Or you would, but it would have less impact.

  (vii) The world would be a happier place.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
