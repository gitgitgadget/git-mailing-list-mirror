From: "Peter Baumann" <peter.baumann@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 11:04:46 +0200
Message-ID: <802d21790610180204h132984d9q70d52e241c68388f@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	 <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	 <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	 <45359B2A.1070102@utoronto.ca> <4535E844.8010604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Carl Worth" <cworth@cworth.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 11:04:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7M3-0003cT-SC
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWJRJEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWJRJEt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:04:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:54594 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750976AbWJRJEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 05:04:48 -0400
Received: by nf-out-0910.google.com with SMTP id c2so600720nfe
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 02:04:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Patc9VvcSAuYEtfgtPgf1k3XxfVSot8AWRKvMA2z9l+dOmQIBzur5DfGZi84IsiIj4J5dx+arfWc718iTBoIdYZ4OvRn6kadm7l0+sbxEFNbaHjoGEXWd34vBraTVPXSsekWC5LEM1k5exnXn8SItNJw9na1PFIQTWurmjlCgak=
Received: by 10.78.128.15 with SMTP id a15mr10405308hud;
        Wed, 18 Oct 2006 02:04:46 -0700 (PDT)
Received: by 10.78.203.14 with HTTP; Wed, 18 Oct 2006 02:04:46 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <4535E844.8010604@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29208>

2006/10/18, Andreas Ericsson <ae@op5.se>:
> Aaron Bentley wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Carl Worth wrote:
> >> Aaron, thanks for carrying this thread along and helping to bridge
> >> some communication gaps. For example, when I saw your original two two
> >> diagrams I was totally mystified how you were claiming that appending
> >> a couple of nodes and edges to a DAG could change the "order" of the
> >> DAG.
> >>
> >> I think I understand what you're describing with the leftmost-parent
> >> ordering now. But it's definitely an ordering that I would describe as
> >> local-only. That is, the ordering has meaning only with respect to a
> >> particular linearization of the DAG and that linearization is
> >> different from one repository to the next.
> >
> > Well, the linarization for any particular head is well-defined, but
> > since different branches have different heads...
> >
> >> If in practice, nobody does the mirroring "pull" operation then how
> >> are the numbers useful? For example, given your examples above, if
> >> I'm understanding the concepts and terminology correctly, then if A
> >> and B both "merge" from each other (and don't "pull") then they will
> >> each end up with identical DAGs for the revision history but totally
> >> distinct numbers. Correct?
> >
> > The DAGs will be different.  If A merges B, we get:
> >
> > a
> > |
> > b
> > |\
> > c d
> > |\|
> > | e
> > |/
> > f
> >
> > If B merges A before this, nothing happens, because B is already a
> > superset of A.
> >
> > If B merges afterward, we get this:
> > a
> > |
> > b
> > |\
> > d c
> > |/|
> > e |
> > |\|
> > | f
> > |/
> > g
> >
>
> Seems like an awful lot of merge commits. In git, I think these trees
> would be identical (actually both to bazaar and to each other), with the
> exception that the 'g' commit wouldn't exist, since git does
> fast-forward and relies on dependency-chain only to present the graph
> instead of mucking around with info in external files (recording of
> fetches).
>

Ok. This I don't get. Let me recaptulize:

Branch A
a
|
b
|
c

Branch B
a
|
b
| \
d c
| /
e

In branch A, do merge branch B (git pull B) you get as result branch B, because
A fastforwards to B and you don't get a merge commit f

In branch B, do merge branch A (git pull A), the result would be
branch B, because
we are already uptodate.

You _never_ have a commit f or g.

-Peter
