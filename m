From: David Kastrup <dak@gnu.org>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 09:50:44 +0200
Message-ID: <86mywhfk17.fsf@lola.quinscape.zz>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
	<7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
	<85ir75h2zb.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 09:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTwp-0005Z9-6C
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbXHXHvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbXHXHvK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:51:10 -0400
Received: from main.gmane.org ([80.91.229.2]:54777 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714AbXHXHvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:51:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOTwb-00028h-U6
	for git@vger.kernel.org; Fri, 24 Aug 2007 09:51:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 09:51:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 09:51:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 23 Aug 2007 23\:37\:17 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:iwZ7JdJmosFRuusBbETJjqu9D3M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56562>


[copied to gmane after sending personal copy by accident, since mails
 of me don't arrive on the list from my work account.  Sorry for the
 duplication.]

Linus Torvalds <torvalds@linux-foundation.org> writes:


[make install]

> See? Those ownership things are restorable *as*root*, but that
> doesn't mean that everybody should do development as root. In fact,
> I'd argue that any system that is set up so that you have to develop
> and merge things while being root is pretty damn broken.
>
> Which means that any such environment *has* to encode the owndership
> *separately* from the actual filesystem ownership. Because doing it
> in the filesystem simply isn't sane.

But in this case you have a work directory and an installation
directory.  And you have an installation procedure.  No tracking is
involved at all.

> So yes, you could have an insane piece of crap that actually tracks
> file ownership in the filesystem, and requires people to be root.

In your example, neither installed files nor ownership are tracked in
the filesystem.  Both are "tracked" in the Makefile.  Or rather than
being tracked, they are explicitly catered for by the user.

> Or you could use a ".gitattributes" file or similar _external_
> tracking method that allows even people who cannot actually set
> ownership to work with it.

git is a content _tracker_.  It tracks contents, also contents that
move around.  If it can't track the permissions moving around as well,
it's sort of pointless to integrate this into git: if you have to
manage the stuff yourself, anyway, there is no point in creating the
illusion that it is done by git.

> Your choice. But I know which one I'd choose.

That's fine.  But you don't actually need git at all to implement your
choice, so this is orthogonal to whether having an option to do it
inside of git might be worth having.

-- 
David Kastrup
